Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261279AbUJYV7m@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261279AbUJYV7m (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 25 Oct 2004 17:59:42 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261261AbUJYV5P
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 25 Oct 2004 17:57:15 -0400
Received: from 168.imtp.Ilyichevsk.Odessa.UA ([195.66.192.168]:39435 "HELO
	port.imtp.ilyichevsk.odessa.ua") by vger.kernel.org with SMTP
	id S261945AbUJYPM6 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 25 Oct 2004 11:12:58 -0400
From: Denis Vlasenko <vda@port.imtp.ilyichevsk.odessa.ua>
To: Jan Engelhardt <jengelh@linux01.gwdg.de>
Subject: Re: Temporary NFS problem when rpciod is SIGKILLed
Date: Mon, 25 Oct 2004 18:12:28 +0300
User-Agent: KMail/1.5.4
Cc: Trond Myklebust <trond.myklebust@fys.uio.no>, linux-kernel@vger.kernel.org
References: <200410251702.58622.vda@port.imtp.ilyichevsk.odessa.ua> <Pine.LNX.4.53.0410251622080.1778@yvahk01.tjqt.qr>
In-Reply-To: <Pine.LNX.4.53.0410251622080.1778@yvahk01.tjqt.qr>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="koi8-r"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200410251812.28663.vda@port.imtp.ilyichevsk.odessa.ua>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Monday 25 October 2004 17:24, Jan Engelhardt wrote:
> >Hi Trond.
> >
> >I observed a problem with NFS root in 2.6 kernel
> >(actually it was a 2.5 back then).
> 
> Does it also happen on 2.4?

That's the point. It works in 2.4
 
> >I am using NFS root. At shutdown, when I kill
> >all processes with killall5 -9, NFS temporarily
> >misbehaves. I narrowed it down to rpciod feeling
> >bad when signalled with SIGKILL:
> 
> I think this has to do that you kill some userspace application that is
> necessary for NFS. I am not exactly sure which one it is (if at all), but I
> have had problems mounting an NFS volume when started with -b option (mounting
> the root however was done ok by the kernel)

Well, let's see. 2.4 works. rpciod in 2.6 shows this erratic behaviour
even if I do "kill -9 <pid_of_rpciod>", thus no other process, kernel
or userspace, know about this KILL.

These commands and their output were actually shown in my mail.
Consider rereading it:

> PID TTY STAT TIME COMMAND
> 1 ? S 0:05 /bin/sh /init.vda
> 2 ? SWN 0:00 [ksoftirqd/0]
> 3 ? SW< 0:00 [events/0]
> 4 ? SW< 0:00 [kblockd/0]
> 5 ? SW 0:00 [pdflush]
> 6 ? SW 0:00 [pdflush]
> 8 ? SW< 0:00 [aio/0]
> 7 ? SW 0:00 [kswapd0]
> 49 ? SW 0:00 [rpciod]
> 50 ? SW 0:00 [lockd]
> 812 vc/2 S 0:00 -bash HOME=/home/vda PATH=/sbin:/bin:/usr/sbin:/usr
> 1369 tty2 R 0:00 ps -AH e PWD=/app/shutdown-0.0.5/script GROFF_NO_
> 1368 ? S 0:00 sleep 32000

Aha! rpciod has PID=49, lets -KILL it...

> # kill -9 49;ps -AH e;read junk;ps -AH e
> bash: /bin/ps: Input/output error

Yay. ps binary couldn't be read from NFS.

> <--- I press [Enter] here

Second ps runs fine because rpciod recovered by this time:

> PID TTY STAT TIME COMMAND
> 1 ? S 0:05 /bin/sh /init.vda
> 2 ? SWN 0:00 [ksoftirqd/0]
> 3 ? SW< 0:00 [events/0]
> 4 ? SW< 0:00 [kblockd/0]
> 5 ? SW 0:00 [pdflush]
> 6 ? SW 0:00 [pdflush]
> 8 ? SW< 0:00 [aio/0]
> 7 ? SW 0:00 [kswapd0]
> 49 ? SW 0:00 [rpciod]
> 50 ? SW 0:00 [lockd]
> 812 vc/2 S 0:00 -bash HOME=/home/vda PATH=/sbin:/bin:/usr/sbin:/usr
> 1369 tty2 R 0:00 ps -AH e PWD=/app/shutdown-0.0.5/script GROFF_NO_
> 1368 ? S 0:00 sleep 32000
--
vda

