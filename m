Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932124AbWGKTpJ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932124AbWGKTpJ (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 11 Jul 2006 15:45:09 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932127AbWGKTpJ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 11 Jul 2006 15:45:09 -0400
Received: from caramon.arm.linux.org.uk ([212.18.232.186]:52748 "EHLO
	caramon.arm.linux.org.uk") by vger.kernel.org with ESMTP
	id S932124AbWGKTpI (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 11 Jul 2006 15:45:08 -0400
Date: Tue, 11 Jul 2006 20:44:57 +0100
From: Russell King <rmk+lkml@arm.linux.org.uk>
To: Theodore Tso <tytso@mit.edu>, Jon Smirl <jonsmirl@gmail.com>,
       Alan Cox <alan@lxorguk.ukuu.org.uk>,
       lkml <linux-kernel@vger.kernel.org>
Subject: Re: tty's use of file_list_lock and file_move
Message-ID: <20060711194456.GA3677@flint.arm.linux.org.uk>
Mail-Followup-To: Theodore Tso <tytso@mit.edu>,
	Jon Smirl <jonsmirl@gmail.com>, Alan Cox <alan@lxorguk.ukuu.org.uk>,
	lkml <linux-kernel@vger.kernel.org>
References: <9e4733910607100810r6e02f69g9a3f6d3d1400b397@mail.gmail.com> <1152552806.27368.187.camel@localhost.localdomain> <9e4733910607101027g5f3386feq5fc54f7593214139@mail.gmail.com> <1152554708.27368.202.camel@localhost.localdomain> <9e4733910607101535i7f395686p7450dc524d9b82ae@mail.gmail.com> <1152573312.27368.212.camel@localhost.localdomain> <9e4733910607101604j16c54ef0r966f72f3501cfd2b@mail.gmail.com> <9e4733910607101649m21579ae2p9372cced67283615@mail.gmail.com> <20060711012904.GD30332@thunk.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20060711012904.GD30332@thunk.org>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jul 10, 2006 at 09:29:04PM -0400, Theodore Tso wrote:
> On Mon, Jul 10, 2006 at 07:49:31PM -0400, Jon Smirl wrote:
> > How about the use of lock/unlock_kernel(). Is there some hidden global
> > synchronization going on? Every time lock/unlock_kernel() is used
> > there is a tty_struct available. My first thought would be to turn
> > this into a per tty spinlock. Looking at where it is used it looks
> > like it was added to protect all of the VFS calls. I see no obvious
> > coordination with other ttys that isn't handled by other locks.
> 
> No, it was just a case of not being worth it to get rid of the BKL for
> the tty subsystem, since opening and closing tty's isn't exactly a
> common event.  Switching it to use a per-tty spinlock makes sense if
> we're going to rototill the code, but to be honest it's probably not
> going to make a noticeable difference on any benchmark and most
> workloads.

It's not that simple - remember that you must be able to open a tty
in non-blocking mode while someone else is opening the same tty in
blocking mode, _and_ succeed.  (iow, the getty waiting for call-in
and you want to dial out case.)

If we go for merely replacing BKL with some other lock, each tty
driver has to be able to drop that lock when it decides to sleep due
to no carrier in its open method... which is kind'a yuck.

-- 
Russell King
 Linux kernel    2.6 ARM Linux   - http://www.arm.linux.org.uk/
 maintainer of:  2.6 Serial core
