Return-Path: <linux-kernel-owner+willy=40w.ods.org-S965147AbVI0VEZ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965147AbVI0VEZ (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 27 Sep 2005 17:04:25 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965148AbVI0VEY
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 27 Sep 2005 17:04:24 -0400
Received: from mother.openwall.net ([195.42.179.200]:29402 "HELO
	mother.openwall.net") by vger.kernel.org with SMTP id S965147AbVI0VEX
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 27 Sep 2005 17:04:23 -0400
Date: Wed, 28 Sep 2005 01:03:31 +0400
From: Solar Designer <solar@openwall.com>
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
Cc: Sergey Vlasov <vsu@altlinux.ru>, Linus Torvalds <torvalds@osdl.org>,
       vendor-sec@lst.de, linux-kernel@vger.kernel.org,
       security@linux.kernel.org
Subject: Re: PID reuse safety for userspace apps (Re: [linux-usb-devel] Re: [Security] [vendor-sec] [BUG/PATCH/RFC] Oops while completing async USB via usbdevio)
Message-ID: <20050927210331.GA4879@openwall.com>
References: <20050925151330.GL731@sunbeam.de.gnumonks.org> <Pine.LNX.4.58.0509270746200.3308@g5.osdl.org> <20050927160029.GA20466@master.mivlgu.local> <Pine.LNX.4.58.0509270904140.3308@g5.osdl.org> <20050927165206.GB20466@master.mivlgu.local> <20050927172048.GA3423@openwall.com> <1127853252.10674.9.camel@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1127853252.10674.9.camel@localhost.localdomain>
User-Agent: Mutt/1.4.2.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Perhaps I should have dropped the old Subject completely, despite the
topic I brought up being related to what was discussed.  I am talking
about PID reuse related issues in userspace apps that appear to require
an additional kernel interface to be resolved.

On Tue, Sep 27, 2005 at 09:34:11PM +0100, Alan Cox wrote:
> On Maw, 2005-09-27 at 21:20 +0400, Solar Designer wrote:
> > The idea is to introduce a kernel call (it can be a prctl(2) setting,
> > although my pseudo-code "defines" an entire syscall for simplicity)
> > which would "lock" the invoking process' view of a given PID (while
> > letting the PID get reused - so there's no added risk of DoS).
> 
> You can solve it just as well in kernel space without application
> changes.

Not really.  For example, the kernel currently has no idea, and no
reliable way to find out, that killall(1) has taken note of a PID and is
about to kill it.

> Given a refcounted structure something like
> 
> 	struct pidref {
> 		atomic_t ref;
> 		struct pidref *next, *prev;
> 		pid_t pid;
> 	};
> 
> and a hash you can take a pid reference whenever you hang onto a pid in
> kernel space and check what should be a tiny if not empty hash in the
> normal cases whenever you allocate a pid.

That would work for certain in-kernel issues.

If we would let userspace apps lock PIDs like that, there would be added
DoS risk that would need to be dealt with (e.g., by letting a process
lock only one other PID - provided that the PID space is sufficiently
large that having a half of it locked is not a problem).  But I do not
see a reason to go for that complexity.  My proposal avoids it.

(A hash table could be used along with my proposal as well to speed
things up, but it would not affect _allocation_ of PIDs.  Rather, only
the "locking" process's view would be affected by the "lock".)

-- 
Alexander
