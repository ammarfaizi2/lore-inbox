Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S276037AbRJBRWd>; Tue, 2 Oct 2001 13:22:33 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S276040AbRJBRWX>; Tue, 2 Oct 2001 13:22:23 -0400
Received: from nat-pool-meridian.redhat.com ([199.183.24.200]:45614 "EHLO
	devserv.devel.redhat.com") by vger.kernel.org with ESMTP
	id <S276037AbRJBRWS>; Tue, 2 Oct 2001 13:22:18 -0400
Date: Tue, 2 Oct 2001 13:22:48 -0400
From: Pete Zaitcev <zaitcev@redhat.com>
Message-Id: <200110021722.f92HMmt29193@devserv.devel.redhat.com>
To: law@sgi.com, <linux-kernel@vger.kernel.org>
Subject: Re: 'dd' local works, but not over net, help as to why?
In-Reply-To: <mailman.1002009301.30795.linux-kernel2news@redhat.com>
In-Reply-To: <mailman.1002009301.30795.linux-kernel2news@redhat.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> dd if=/dev/hda2 bs=1M|rsh other-system of=/dev/sda2 bs=1M

That does not work on all unixes. Perhaps it does on IRIX,
but certainly not on Solaris. The remote dd is going to
get short reads from the socket. The telltale sign is the
number to short records:

itcev@niphredil /boot]$ dd if=vmlinux-2.4.7-niph bs=8k | ssh pentabug dd of=xxx bs=8k
333+1 records in
333+1 records out
7+653 records in		<------- almost all are shorts
7+653 records out
[zaitcev@niphredil /boot]$ 

There is no good way to deal with it, unless you use some external
filter (perhaps netcat?). tar has a flag -B to deal with this.
An oldtimer's trick is to use compress, which works because
zcat uses stdio for output and its blocksize is fixed.

[zaitcev@niphredil /boot]$ dd if=vmlinux-2.4.7-niph bs=8k | compress | ssh pentabug "zcat |dd of=xxx bs=8k"
333+1 records in
333+1 records out
333+1 records in
333+1 records out
[zaitcev@niphredil /boot]$ 

This behaviour of sockets on Linux is entirely normal, so deal with it.
My pet peeve is how DaveM insists that WRITES to a socket may return
short. That stupidity just makes me furious each time. A socket has
a posix-schmozix "right" to return short, I agree.  But it is extremely
rude and in the right implementation, it should not. It breaks just
about _every_ application that uses printk.

-- Pete
