Return-Path: <linux-kernel-owner+w=401wt.eu-S965281AbWLPBJJ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965281AbWLPBJJ (ORCPT <rfc822;w@1wt.eu>);
	Fri, 15 Dec 2006 20:09:09 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965304AbWLPBJJ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 15 Dec 2006 20:09:09 -0500
Received: from zeniv.linux.org.uk ([195.92.253.2]:33456 "EHLO
	ZenIV.linux.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S965281AbWLPBJI (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 15 Dec 2006 20:09:08 -0500
Date: Sat, 16 Dec 2006 01:09:06 +0000
From: Al Viro <viro@ftp.linux.org.uk>
To: Pavel Machek <pavel@ucw.cz>
Cc: rpurdie@rpsys.net, lenz@cs.wisc.edu,
       kernel list <linux-kernel@vger.kernel.org>,
       Russell King <rmk@arm.linux.org.uk>, Dirk@Opfer-Online.de,
       arminlitzel@web.de, pavel.urban@ct.cz, metan@seznam.cz
Subject: Re: Nasty warnings on arm (+ one compile problem -- INIT_WORK related)
Message-ID: <20061216010906.GC17561@ftp.linux.org.uk>
References: <20061215235818.GD2853@elf.ucw.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20061215235818.GD2853@elf.ucw.cz>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

 
> Plus compile error. It should be some search&replace I should do, but
> which one?
> 
> drivers/video/sa1100fb.c:1447:49: macro "INIT_WORK" passed 3
> arguments, but takes just 2
> drivers/video/sa1100fb.c: In function `sa1100fb_init_fbinfo':
> drivers/video/sa1100fb.c:1447: error: `INIT_WORK' undeclared (first
> use in this function)
> drivers/video/sa1100fb.c:1447: error: (Each undeclared identifier is
> reported only once
> drivers/video/sa1100fb.c:1447: error: for each function it appears
> in.)
> drivers/video/sa1100fb.c: At top level:
> drivers/video/sa1100fb.c:1204: warning: `sa1100fb_task' defined but
> not used
> make[2]: *** [drivers/video/sa1100fb.o] Error 1
> make[1]: *** [drivers/video] Error 2
> make: *** [drivers] Error 2
> 
>         INIT_WORK(&fbi->task, sa1100fb_task, fbi);
> 
> ...
> 
> /*
>  * Our LCD controller task (which is called when we blank or unblank)
>  * via keventd.
>  */
> static void sa1100fb_task(void *dummy)
> {
>         struct sa1100fb_info *fbi = dummy;
>         u_int state = xchg(&fbi->task_state, -1);
> 
>         set_ctrlr_state(fbi, state);
> }
> 
> (Or will I need to play with container_of or something? I guess I did
> not pay attetion to workqueue stuff).

... and that's

static void sa1100fb_task(struct work_struct *ucking_fugly)
{
	struct sa1100fb_info *fbi = container_of(ucking_fugly,
						 struct sa1100fb_info,
						 task);
