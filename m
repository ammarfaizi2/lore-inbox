Return-Path: <linux-kernel-owner+willy=40w.ods.org-S266149AbUITIyt@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266149AbUITIyt (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 20 Sep 2004 04:54:49 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266163AbUITIyt
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 20 Sep 2004 04:54:49 -0400
Received: from imap.gmx.net ([213.165.64.20]:39320 "HELO mail.gmx.net")
	by vger.kernel.org with SMTP id S266149AbUITIyk (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 20 Sep 2004 04:54:40 -0400
X-Authenticated: #1725425
Date: Mon, 20 Sep 2004 10:54:48 +0200
From: Marc Ballarin <Ballarin.Marc@gmx.de>
To: "Ihar 'Philips' Filipau" <filia@softhome.net>
Cc: benh@kernel.crashing.org, greg@kroah.com, linux-kernel@vger.kernel.org
Subject: Re: udev is too slow creating devices
Message-Id: <20040920105448.5d569eeb.Ballarin.Marc@gmx.de>
In-Reply-To: <414DE099.8040202@softhome.net>
References: <414C9003.9070707@softhome.net>
	<1095568704.6545.17.camel@gaston>
	<414D42F6.5010609@softhome.net>
	<20040919140034.2257b342.Ballarin.Marc@gmx.de>
	<414D96EF.6030302@softhome.net>
	<20040919171456.0c749cf8.Ballarin.Marc@gmx.de>
	<414DE099.8040202@softhome.net>
X-Mailer: Sylpheed version 0.9.12 (GTK+ 1.2.10; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 19 Sep 2004 21:40:09 +0200
Ihar 'Philips' Filipau <filia@softhome.net> wrote:

> 
>    Well, go to /etc/rc.d and try to integrate that with rest of system.
>    The only right way of handling of such stuff I know - is FSM.

Yes. But this is just the nature of this problem. For reliable operation
and proper error reporting some state tracking is required even today.

>    Implementing FSMs in shell scripts - last thing I ever wanted. 

In most cases it should boil down to something like

while exists(lockfile)
	sleep

> And I 
> still cannot get how you are going to safely serialize /etc/dev.d/ 
> callbacks against /etc/rc.d/ without polling.

Spinlocking with lock-files could work.

>    You are wrong. Hardware driver must fail, when hardware is not 
> present/not detected. Simple as that.

Why?

>    User knows what driver is meant for, especially when it loads it 
> manually.
>    If user will be told when driver is ready - user can verify that 
> hardware in question is present.

This isn't even necessary. If the driver triggers a hotplug event an an
apropriate  script is in dev.d everything will work automatically.
If it doesn't the user can check why.

>    What about scripts outside of /etc/dev.d/?
> 

They will have to spin on a lock file. See below.

>    
> Splitting system boot-up procedure will have some funny consequences. 
> Debugging will be left as an execise for end-users. Running once fsck 
> simultaneously on several partitions will cool your temper down.

This is quite easy to solve in dev.d (Python-like pseudo-code):

if not(ACTION==add)
	exit
parse(fstab)
if not(DEVNAME in fstab)
	exit
if has_parents(mountpoint)
	while not(parents in mtab)
		if has_failed?(parents)
			has_failed!(DEVNAME)
			exit
		sleep
while is_locked(parent(DEVNAME))
	sleep
lock(parent(DEVNAME))
fsck DEVNAME
mount DEVNAME || has_failed!(DEVNAME)
unlock(parent(DEVNAME))

Most likely I missed some fine points, but this way fsck and mounts are
serialized when necessary and parallelized when possible (even across
different fsck binaries). Dependencies in the filesystem hierarchy are
satisfied and errors can be detected.

lock/unlock/has_failed! are simply "touch" and "rm -f"
is_locked and has_failed? are simply "test -e".
has_parents and parents are derived from fstab.

Of course, the init system needs some "cleverness". If /usr or /var are on
separate devices later scripts need to poll mtab and do "has_failed?"
checks. This is even needed today with a static /dev (but is not done). As a
result current scripts break in undeterministic ways if mounting fails.

> 
>    Again. FSM is no way to go for shell scripts. And shell scripts is 
> what is used to manage system. Even /etc/dev.d/ scripts - are shell 
> scripts, after all.

Well, if bash proves too cumbersome there is still spython...

Regards
