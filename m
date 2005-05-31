Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261627AbVEaK6t@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261627AbVEaK6t (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 31 May 2005 06:58:49 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261801AbVEaK6t
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 31 May 2005 06:58:49 -0400
Received: from mailhub.fokus.fraunhofer.de ([193.174.154.14]:64190 "EHLO
	mailhub.fokus.fraunhofer.de") by vger.kernel.org with ESMTP
	id S261627AbVEaK6l (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 31 May 2005 06:58:41 -0400
From: Joerg Schilling <schilling@fokus.fraunhofer.de>
Date: Tue, 31 May 2005 12:57:24 +0200
To: schilling@fokus.fraunhofer.de, 7eggert@gmx.de
Cc: linux-kernel@vger.kernel.org, 7eggert@gmx.de
Subject: Re: OT] Joerg Schilling flames Linux on his Blog
Message-ID: <429C4314.nail5X01I2XDW@burner>
References: <4847F-8q-23@gated-at.bofh.it>
 <E1Db3zm-0004vF-9j@be1.7eggert.dyndns.org>
 <4295005F.nail2KW319F89@burner>
 <Pine.LNX.4.58.0505260205390.19389@be1.lrz>
 <4296F088.nail3L121R2F5@burner>
 <Pine.LNX.4.58.0505271633200.3055@be1.lrz>
 <429ADE92.nail4ZG3GSIPT@burner>
 <Pine.LNX.4.58.0505301326450.2363@be1.lrz>
In-Reply-To: <Pine.LNX.4.58.0505301326450.2363@be1.lrz>
User-Agent: nail 11.2 8/15/04
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Bodo Eggert <7eggert@gmx.de> wrote:

> > No, the command list was an ungly hack from the beginning and it just is not
> > suitable for what it is used.
> > 
> > 	If you like decent and reliable security, you need privillege separation.
> > 
> > -	Disallow sending SCSI commands via ioctl() on /dev/hd*
>
> > -	Tell people that they have to use /dev/sg* in order to send SCSI 
> > 	commands to devices.
>
> - Each CD player would have to run suid. I'm talking about programs 
>   running a GUI, peeking in CDDB databases and doing other ugly stuff.

If you don't already have fine grained process permissions ready, you are right.
In the other cases, pfksh or somethign similar would know about the special
rights of a program from checking the databases in /etc/security/ and call
/usr/bin/pfexec to set up only the needed rights and then call the program
in question.

Note that in case you call the ability to send SCSI commands a security
risk, then you need to implement all the consequences.....


> - Each CD player will have permission to erase the firmware on all 
>   installed devices.

As you may not know which SCSI commands are used for a specific device, this
is correct.


> - You've seen how ugly scanning for the correct sg device is, and udev 
>   will make it site-dependant. You are no longer "guaranteed" to find any 
>   /dev/sg* devices.

As it seems that this program called "udev" (if I am right) does some strange
lookup and setup which is basically the same from editing /etc/default/cdrecord
why is this program not implemented to give full support for Linux users and
_does_ edit /etc/default/cdrecord?

I don't know that program but in contrary to the concepts of Solaris where
a similar program (devlinks) that exists since 1992 creates links based only
on information found in the names from /devices, and crerates links to /dev
like this one:

lrwxrwxrwx   1 root     other         45 Jul 14  2003 /dev/scg0 -> ../devices/pci@0,0/pci-ide@7,1/ide@1/scg@0,0:
lrwxrwxrwx   1 root     other         39 Jul 14  2003 /dev/scg1 -> ../devices/pci@0,0/pci1000,f@9/scg@0,0:

it seems that the program udev either has access to private kernel data 
structures (from the definition of the people who like to deny access to 
this information to cdrecord::libscg) or does other strange things.

On Solaris, handling of driver instances is done inside the kernel and used
to set up device names.

You should rethink whether you still believe that udev is a clean program while
cdrecord is not.....

Please note that /etc/default/cdrecord must likely predates udev by many years
and polite authors of such a program would have added support for not only
creating links to /dev but also for adding device aliased into 
/etc/default/cdrecord.



> > In contrary to many other programs, cdrecord is cleanly written and does not
> > make such assumptions!
>
> It does asume not to get permission denied errors after seteuid(0) was 
> successfull.

Wrong: please check the source..... 

It does not make _any_ asumption based on uid values except for the fact that
it still tells you to become root in case something did not work.

So if there was a useful framework for the current attempt to implement 
fine grained process privilleges into Linux, cdrecord would be a candidate 
for testing....


> > It seems that you did not understand this, so let me explain it in a different
> > way: If you start to implement a new security mechanism, either do it in a way 
> > that does not affect software that assumes historical UNIX interfaces at all,
> > or keep it private for developers untill it is suitable for the mass.
>
> It's not new. My manpage is from 1997, and the function was ported from 
> solaris (IIRC).

What are you talking about?


> > An OS is the kernel _and_ the user space support software.
>
> The linux kernel is just the linux kernel. Unlike other systems, no
> special userland is enforced (with minimal exceptions like /sbin/init).
> You can run supervise, busybox, sysvinit, use pam or classic login etc.
> If you like, you can get rid of /dev and put it somewhere else.

If you really make this assumtion, you would not be allowed to implement 
fine grained process privielleges into Linux because you could not support
it at shell level. It just makes no sense to add special (currently) nonstandard
features to a kernel without providing the supporting user land programs.



> > Even a "kernel only" subsystem like Linux cannot ignore these facts when
> > trying to introduce interfaces that need special useland programs in order
> > to mahe use out of it.
>
> If you're developing a monolithic OS, you can hide the interface untill
> you've written the applications, but you can't do that for a standalone 
> kernel. The interface is mostly(?) there, and as soon as somebody starts 
> to care enough, it will be used.

You can do the same for something like Linux. You just need to implement the
interface in a way that does not contradict or influence historical UNIX
practice that made it into POSIX. 

> > If it did, soneone would have ignored his NDA. The current interface is not
> > yet 100% stable, it will be officially published when it is closer to something
> > that could be used by anyone. If someone from LKML is really interested in 
> > implementing the interface soon, I would be willing to give away basic
> > details that allow to implement 99% if the code. The error handling is 
> > still in dispute.
>
> I'm too lazy to implement that, but I'd like an abstract.
> (I suspect it's something like 
> http://www.olafdietsche.de/linux/capability/)

Did you forget what question from you I was replying to?

I see no relation to a holey file interface here.

Jörg

-- 
 EMail:joerg@schily.isdn.cs.tu-berlin.de (home) Jörg Schilling D-13353 Berlin
       js@cs.tu-berlin.de		(uni)  
       schilling@fokus.fraunhofer.de	(work) Blog: http://schily.blogspot.com/
 URL:  http://cdrecord.berlios.de/old/private/ ftp://ftp.berlios.de/pub/schily
