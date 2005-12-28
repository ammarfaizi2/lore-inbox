Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964777AbVL1JZN@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964777AbVL1JZN (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 28 Dec 2005 04:25:13 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932519AbVL1JZN
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 28 Dec 2005 04:25:13 -0500
Received: from ns.virtualhost.dk ([195.184.98.160]:30476 "EHLO virtualhost.dk")
	by vger.kernel.org with ESMTP id S932509AbVL1JZL (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 28 Dec 2005 04:25:11 -0500
Date: Wed, 28 Dec 2005 10:26:27 +0100
From: Jens Axboe <axboe@suse.de>
To: Pete Zaitcev <zaitcev@redhat.com>
Cc: Dave Jones <davej@redhat.com>, linux-kernel@vger.kernel.org,
       jgarzik@pobox.com
Subject: Re: 2.6.15rc5git1 cfq related spinlock bad magic
Message-ID: <20051228092626.GA2772@suse.de>
References: <20051208045048.GC24356@redhat.com> <20051209104150.GF26185@suse.de> <20051209185521.GC7473@redhat.com> <20051226145228.6eba3980.zaitcev@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20051226145228.6eba3980.zaitcev@redhat.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Dec 26 2005, Pete Zaitcev wrote:
> On Fri, 9 Dec 2005 13:55:21 -0500, Dave Jones <davej@redhat.com> wrote:
> 
> >  > > [311578.273186] BUG: spinlock bad magic on CPU#1, pdflush/30788 (Not tainted)
> >[...]
> >  > > [311578.499972] RIP: 0010:[<ffffffff8021f8bd>] <ffffffff8021f8bd>{spin_bug+138}
> >  > > [311578.798449] Call Trace:<ffffffff8021fbdb>{_raw_spin_lock+25} <ffffffff802174a4>{cfq_exit_single_io_context+85}
> >  > > [311578.828782]        <ffffffff80217527>{cfq_exit_io_context+33} <ffffffff8020d07d>{exit_io_context+137}
> >  > > [311578.856762]        <ffffffff8013f937>{do_exit+183} <ffffffff80152c90>{keventd_create_kthread+0}
> >  > > [311578.883192]        <ffffffff80110c25>{child_rip+15} <ffffffff80152c90>{keventd_create_kthread+0}
> >  > > [311578.909852]        <ffffffff80152d86>{kthread+0} <ffffffff80110c16>{child_rip+0}
> 
> > Hmm, I may have also been experimenting at the time with Pete Zaitcev's
> > ub driver. Pete, could ub have been doing something bad here?
> 
> Yes, this is ub's fault. I thought that blk_cleanup_queue frees the
> queue, but this is not the case. In recent kernels, it only decrements
> its refcount.  If CFQ is around, it keeps the queue pinned and uses
> the queue's spinlock.  But when ub calls blk_init_queue(), it passes a
> spinlock located in its data structure (ub_dev), which corresponds to
> a device. The ub_dev is refcounted and freed when the device is
> disconnected or closed. As you can see, this leaves the queue's
> spinlock pointer dangling.

That indeed looks like to be it. We've had the reference counted queue
for a long time. CFQ is the only io scheduler that is affected by such a
bug, although the core block layer coultd trigger it as well but the
window is much smaller (with CFQ the window is very large).

> The code was taken from Carmel, and it used to work fine for a long time.
> I suspect now that Carmel is vulnerable, if it's hot-removed while open.
> Maybe Jeff wants to look into it.

Indeed.

> The usb-storage is immune to this problem, because SCSI passes NULL to
> blk_init_queue.

SCSI did have the same problem recently, it just does the assignment
differently.

> Schedulers other than CFQ use their own spinlocks, so they do not hit
> this problem.
> 
> The attached patch works around this issue by using spinlocks which are
> static to the ub module. Thus, it places ub into the same group as floppy.
> This is not ideal, in case someone manages to remove the module yet have
> queues remaining... But I am reluctant to copy what scsi_request_fn is
> doing. After all, ub is supposed to be simpler.
> 
> Any comments before I send this to Greg?

It's probably the easiest way to fix it in a straight forward manner.
I'll see if I can add some debug code to detect this issue...

-- 
Jens Axboe

