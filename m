Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932266AbWELWIK@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932266AbWELWIK (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 12 May 2006 18:08:10 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932267AbWELWIK
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 12 May 2006 18:08:10 -0400
Received: from zeniv.linux.org.uk ([195.92.253.2]:45267 "EHLO
	ZenIV.linux.org.uk") by vger.kernel.org with ESMTP id S932266AbWELWIJ
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 12 May 2006 18:08:09 -0400
Date: Fri, 12 May 2006 23:08:08 +0100
From: Al Viro <viro@ftp.linux.org.uk>
To: Linus Torvalds <torvalds@osdl.org>, Erik Mouw <erik@harddisk-recovery.com>,
       Or Gerlitz <or.gerlitz@gmail.com>, linux-scsi@vger.kernel.org,
       axboe@suse.de, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [BUG 2.6.17-git] kmem_cache_create: duplicate cache scsi_cmd_cache
Message-ID: <20060512220807.GR27946@ftp.linux.org.uk>
References: <20060511151456.GD3755@harddisk-recovery.com> <15ddcffd0605112153q57f139a1k7068e204a3eeaf1f@mail.gmail.com> <20060512171632.GA29077@harddisk-recovery.com> <Pine.LNX.4.64.0605121024310.3866@g5.osdl.org> <20060512203416.GA17120@flint.arm.linux.org.uk> <20060512214354.GP27946@ftp.linux.org.uk> <20060512215520.GH17120@flint.arm.linux.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20060512215520.GH17120@flint.arm.linux.org.uk>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, May 12, 2006 at 10:55:20PM +0100, Russell King wrote:
> On Fri, May 12, 2006 at 10:43:54PM +0100, Al Viro wrote:
> > On Fri, May 12, 2006 at 09:34:16PM +0100, Russell King wrote:
> > > On Fri, May 12, 2006 at 10:36:57AM -0700, Linus Torvalds wrote:
> > > > Yes. We could just revert that commit, but it seems correct, and I'd 
> > > > really like for somebody to understand _why_ that commit matters at all. I 
> > > > certainly don't see the overlap here..
> > > 
> > > Reverting the commit breaks MMC/SD in a very real way, and the fix
> > > is plainly correct and is actually the only possible fix that can be
> > > applied.
> > 
> > Bullshit.  Could you explain what generic code dereferences ->driverfs_dev
> > after del_gendisk()?  If you see such beast, please tell; _that_ is the
> > real bug.
> 
> Al, I think you're going to eat your own bull on this one.
> 
> You'll find that in the reply I've just sent to Linus - two oopen
> reported by two different people since the mount/umount hotplug
> events got re-merged.
> 
> The problem case is:
> 
> - insert card
> - mount filesystem
> - remove card
> - umount filesystem <bang, oops>
> 
> The generic code is block_uevent(), which is called at umount time
> _after_ the gendisk has been deleted (which happens when the card has
> been removed.)
> 
> Basically, you can't umount a destroyed block device without oopsing.

So block_uevent() is bogus; great, we've located the real bug.  The
real question: what uses these events and what can userland _do_ when
it gets something about a device that had been gone for a month?

Secondary question: who had resurrected that crap?  I distinctly remember
killing it off...
