Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S276103AbRJBSVk>; Tue, 2 Oct 2001 14:21:40 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S276108AbRJBSVb>; Tue, 2 Oct 2001 14:21:31 -0400
Received: from zok.SGI.COM ([204.94.215.101]:20389 "EHLO zok.sgi.com")
	by vger.kernel.org with ESMTP id <S276103AbRJBSVS>;
	Tue, 2 Oct 2001 14:21:18 -0400
Message-ID: <3BBA0500.9135C05E@nowhere.com>
Date: Tue, 02 Oct 2001 11:18:40 -0700
From: L A Walsh <no-one@nowhere.com>
Organization: Trust Technology, Core Linux, SGI
X-Mailer: Mozilla 4.77 [en] (X11; U; Linux 2.4.10 i686)
X-Accept-Language: en, en-US, en-GB, fr
MIME-Version: 1.0
To: Pete Zaitcev <zaitcev@redhat.com>
CC: linux-kernel@vger.kernel.org
Subject: Re: 'dd' local works, but not over net, help as to why?
In-Reply-To: <mailman.1002009301.30795.linux-kernel2news@redhat.com> <200110021722.f92HMmt29193@devserv.devel.redhat.com>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hmmm....well both are linux machines with kernels 2.4.10 and 2.4.9.
So I'm not specifying the count -- if the dd on the receiving machine gets
a short read for an 8M block, does that imply that it would write the
short data and pad with 0's?  If that's the case, I can see why it would
run out of space. I know Solaris had the known bug of non-integrity
of binary data transfer over rsh, but I know IRIX doesn't have that and
I've never run into it with linux using 'tar' (w/o the B option).  It
may be the first time I've tried this with 'dd' over the net and with 
such a large dataset.  Is the below output from linux2linux?  I thought
of compress/zcat, but it's a 100Mps local LAN w/little to no traffic, so
I know that almost any compression was going to slow down the xfer...

Y'd think that 'dd' would do what it is told and read the correct block
size rather than returning a 'short'.  Would one consider this a
possible "undesired feature" [bug] in 'dd', if that proves to be the
problem?  Seems like there should at least be a way to say for it to wait
for short blocks.  Hmph.

oh well.
thanks for all the pointers.
Linda



Pete Zaitcev wrote:
> 
> > dd if=/dev/hda2 bs=1M|rsh other-system of=/dev/sda2 bs=1M
> 
> That does not work on all unixes. Perhaps it does on IRIX,
> but certainly not on Solaris. The remote dd is going to
> get short reads from the socket. The telltale sign is the
> number to short records:
> 
> itcev@niphredil /boot]$ dd if=vmlinux-2.4.7-niph bs=8k | ssh pentabug dd of=xxx bs=8k
> 333+1 records in
> 333+1 records out
> 7+653 records in                <------- almost all are shorts
> 7+653 records out
> [zaitcev@niphredil /boot]$
> 
> There is no good way to deal with it, unless you use some external
> filter (perhaps netcat?). tar has a flag -B to deal with this.
> An oldtimer's trick is to use compress, which works because
> zcat uses stdio for output and its blocksize is fixed.
> 
> [zaitcev@niphredil /boot]$ dd if=vmlinux-2.4.7-niph bs=8k | compress | ssh pentabug "zcat |dd of=xxx bs=8k"
> 333+1 records in
> 333+1 records out
> 333+1 records in
> 333+1 records out
> [zaitcev@niphredil /boot]$
> 
> This behaviour of sockets on Linux is entirely normal, so deal with it.
> My pet peeve is how DaveM insists that WRITES to a socket may return
> short. That stupidity just makes me furious each time. A socket has
> a posix-schmozix "right" to return short, I agree.  But it is extremely
> rude and in the right implementation, it should not. It breaks just
> about _every_ application that uses printk.
> 
> -- Pete

--  -    _    -    _    -    _    -    _    -    _    -    _    -    _    -
L A Walsh, law at sgi dot com     | Senior Engineer
01-650-933-5338                   | Trust Technology, Core Linux, SGI
