Return-Path: <linux-kernel-owner+willy=40w.ods.org-S265154AbUG3AYQ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265154AbUG3AYQ (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 29 Jul 2004 20:24:16 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267547AbUG3AYQ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 29 Jul 2004 20:24:16 -0400
Received: from mail.dif.dk ([193.138.115.101]:932 "EHLO mail.dif.dk")
	by vger.kernel.org with ESMTP id S265154AbUG3AYK (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 29 Jul 2004 20:24:10 -0400
Date: Fri, 30 Jul 2004 02:22:28 +0200 (CEST)
From: Jesper Juhl <juhl-lkml@dif.dk>
To: Jesper Juhl <juhl-lkml@dif.dk>
Cc: Roger Luethi <rl@hellgate.ch>, Rob Landley <rob@landley.net>,
       linux-kernel@vger.kernel.org
Subject: Re: Interesting race condition...
In-Reply-To: <Pine.LNX.4.60.0407300213370.3606@jjulnx.backbone.dif.dk>
Message-ID: <Pine.LNX.4.60.0407300220240.3606@jjulnx.backbone.dif.dk>
References: <200407222204.46799.rob@landley.net> <20040729235654.GA19664@k3.hellgate.ch>
 <Pine.LNX.4.60.0407300213370.3606@jjulnx.backbone.dif.dk>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII; format=flowed
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 30 Jul 2004, Jesper Juhl wrote:

> On Fri, 30 Jul 2004, Roger Luethi wrote:
>
>> On Thu, 22 Jul 2004 22:04:46 -0500, Rob Landley wrote:
>>> I just saw a funky thing.  Here's the cut and past from the xterm...
>>> 
>>> [root@(none) root]# ps ax | grep hack
>>>  9964 pts/1    R      0:00 grep hack HOSTNAME= SHELL=/bin/bash 
>>> TERM=xterm HISTSIZE=1000 USER=root 
>>> LS_COLORS=no=00:fi=00:di=00;34:ln=00;36:pi=40;33:so=00;35:bd=40;33;01:cd=40;33;01:or=01;05;37;41:mi=01;05;37;41:ex=00;32:*.cmd=00;32:*.exe=00;32:*.com=00;32:*.btm=00;32:*.bat=00;32:*.sh=00;32:*.csh=00;32:*.tar=00;31:*.tgz=
>>> [root@(none) root]# ps ax | grep hack
>>>  9966 pts/1    S      0:00 grep hack
>>> 
>>> Seems like some kind of race condition, dunno if it's in Fedore Core 1's 
>>> ps
>>> or the 2.6.7 kernel or what...
>> 
>> If somebody posted a solution for this, I didn't see it. There's a race in
>> the kernel, and considering the permissions on /proc/PID/{cmdline,environ}
>> a security bug as well: If you win the race with a starting process, you
>> can read its environment.
>> 
>> This should plug the hole. Can you give it a spin?
>> 
>> Roger
>> 
>> --- linux-2.6.8-rc2-bk1/fs/proc/base.c.orig	2004-07-30 01:43:23.535967505 
>> +0200
>> +++ linux-2.6.8-rc2-bk1/fs/proc/base.c	2004-07-30 01:43:27.428303752 
>> +0200
>> @@ -329,6 +329,8 @@ static int proc_pid_cmdline(struct task_
>> 	struct mm_struct *mm = get_task_mm(task);
>> 	if (!mm)
>> 		goto out;
>> +	if (!mm->arg_end)
>> +		goto out;	/* Shh! No looking before we're done */
>> 
>>  	len = mm->arg_end - mm->arg_start;
>> 
>
> I might be reading the code wrong or not be fully aware of the circumstances 
> here, so please bear with me, but I took a look at get_task_mm() and it can 
> return NULL. If it does you'd end up dereferencing a NULL pointer with "if 
> (!mm->arg_end)" - or is that garanteed not to happen here?
>
> Wouldn't something like
>
> if (!mm || !mm->arg_end)
> 	goto out;
>
> be safer?
>
Arrgh, that's what happens when you try to read patches at 02:25
For some reason my eyes read the patch as

-    if (!mm)
-            goto out;
+    if (!mm->arg_end)
+            goto out;       /* Shh! No looking before we're done */

but that's not what it looks like :(  Sorry about that. There's no problem 
except for me being too sleepy.

/Jesper Juhl

