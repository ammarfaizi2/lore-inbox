Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751495AbWDCI27@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751495AbWDCI27 (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 3 Apr 2006 04:28:59 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751515AbWDCI27
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 3 Apr 2006 04:28:59 -0400
Received: from smtp.osdl.org ([65.172.181.4]:43991 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S1751495AbWDCI26 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 3 Apr 2006 04:28:58 -0400
Date: Mon, 3 Apr 2006 01:27:53 -0700
From: Andrew Morton <akpm@osdl.org>
To: Jens Axboe <axboe@suse.de>
Cc: neilb@suse.de, nathans@sgi.com, linux-kernel@vger.kernel.org,
       drepper@redhat.com, mtk-manpages@gmx.net, nickpiggin@yahoo.com.au
Subject: Re: [patch 1/1] sys_sync_file_range()
Message-Id: <20060403012753.218db397.akpm@osdl.org>
In-Reply-To: <20060403074959.GG3770@suse.de>
References: <200603300741.k2U7fQLe002202@shell0.pdx.osdl.net>
	<17451.36790.450410.79788@cse.unsw.edu.au>
	<20060331071736.K921158@wobbly.melbourne.sgi.com>
	<17456.31028.173800.615259@cse.unsw.edu.au>
	<20060403074959.GG3770@suse.de>
X-Mailer: Sylpheed version 1.0.4 (GTK+ 1.2.10; i386-redhat-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Jens Axboe <axboe@suse.de> wrote:
>
> On Mon, Apr 03 2006, Neil Brown wrote:
> > On Friday March 31, nathans@sgi.com wrote:
> > > On Thu, Mar 30, 2006 at 06:58:46PM +1100, Neil Brown wrote:
> > > > On Wednesday March 29, akpm@osdl.org wrote:
> > > > > Remove the recently-added LINUX_FADV_ASYNC_WRITE and LINUX_FADV_WRITE_WAIT
> > > > > fadvise() additions, do it in a new sys_sync_file_range() syscall
> > > > > instead. 
> > > > 
> > > > Hmmm... any chance this could be split into a sys_sync_file_range and
> > > > a vfs_sync_file_range which takes a 'struct file*' and does less (or
> > > > no) sanity checking, so I can call it from nfsd?
> > > > 
> > > > Currently I implement COMMIT (which has a range) with a by messing
> > > > around with filemap_fdatawrite and filemap_fdatawait (ignoring the
> > > > range) and I'd rather than a vfs helper.
> > > 
> > > I'm not 100% sure, but it looks like the PF_SYNCWRITE process flag
> > > should be set on the nfsd's while they're doing that, which doesn't
> > > seem to be happening atm.  Looks like a couple of the IO schedulers
> > > will make use of that knowledge now.  All the more reason for a VFS
> > > helper here I guess. ;)
> > 
> > PF_SYNCWRITE? What's that???
> > 
> > (find | xargs grep ...)
> > Oh.  The block device schedulers like to know if a request is sync or
> > async (and all reads are assumed to be sync) - which is reasonable -
> > and so have a per-task flag to tell them - which isn't (IMO).
> > 
> > md/raid (particularly raid5) often does the write from a different
> > process than generated the original request, so that will break
> > completely. 
> 
> I don't think any disagrees with you, the sync-write process flag is
> indeed an atrocious beast...

Yeah.  PF_SYNCWRITE was a performance tweak for the anticipatory scheduler.
As cfq is using it as well now (hopefully to good effect) I guess it could
be formalised more.

> > What is wrong with a bio flag I wonder....
> 
> Nothing, in fact I would love for it to be changed. I'm sure such a
> patch would be accepted with open arms! :-)

I think once someone starts coding it, they'll become a big fan of
PF_SYNCWRITE...

For the page writeback functions it's probably possible to use
writeback_control.sync_mode=WB_SYNC_ALL as a trigger, propagate that into
the IO layer.  Maybe that'll always be sufficient - it's hard to tell.  The
writeback paths are twisty and deep...

Then again, using WB_SYNC_ALL as a hint that this process will be waiting
for this writeout to complete is a bit hacky too - it doesn't _really_ mean
that - it just means that I/O should be _started_ against all relevant
dirty data.

Good luck ;)
