Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964805AbWDCB0A@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964805AbWDCB0A (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 2 Apr 2006 21:26:00 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964806AbWDCB0A
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 2 Apr 2006 21:26:00 -0400
Received: from cantor.suse.de ([195.135.220.2]:15774 "EHLO mx1.suse.de")
	by vger.kernel.org with ESMTP id S964805AbWDCB0A (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 2 Apr 2006 21:26:00 -0400
From: Neil Brown <neilb@suse.de>
To: Nathan Scott <nathans@sgi.com>
Date: Mon, 3 Apr 2006 11:24:04 +1000
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-ID: <17456.31028.173800.615259@cse.unsw.edu.au>
Cc: akpm@osdl.org, linux-kernel@vger.kernel.org, drepper@redhat.com,
       mtk-manpages@gmx.net, nickpiggin@yahoo.com.au
Subject: Re: [patch 1/1] sys_sync_file_range()
In-Reply-To: message from Nathan Scott on Friday March 31
References: <200603300741.k2U7fQLe002202@shell0.pdx.osdl.net>
	<17451.36790.450410.79788@cse.unsw.edu.au>
	<20060331071736.K921158@wobbly.melbourne.sgi.com>
X-Mailer: VM 7.19 under Emacs 21.4.1
X-face: v[Gw_3E*Gng}4rRrKRYotwlE?.2|**#s9D<ml'fY1Vw+@XfR[fRCsUoP?K6bt3YD\ui5Fh?f
	LONpR';(ql)VM_TQ/<l_^D3~B:z$\YC7gUCuC=sYm/80G=$tt"98mr8(l))QzVKCk$6~gldn~*FK9x
	8`;pM{3S8679sP+MbP,72<3_PIH-$I&iaiIb|hV1d%cYg))BmI)AZ
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Friday March 31, nathans@sgi.com wrote:
> On Thu, Mar 30, 2006 at 06:58:46PM +1100, Neil Brown wrote:
> > On Wednesday March 29, akpm@osdl.org wrote:
> > > Remove the recently-added LINUX_FADV_ASYNC_WRITE and LINUX_FADV_WRITE_WAIT
> > > fadvise() additions, do it in a new sys_sync_file_range() syscall
> > > instead. 
> > 
> > Hmmm... any chance this could be split into a sys_sync_file_range and
> > a vfs_sync_file_range which takes a 'struct file*' and does less (or
> > no) sanity checking, so I can call it from nfsd?
> > 
> > Currently I implement COMMIT (which has a range) with a by messing
> > around with filemap_fdatawrite and filemap_fdatawait (ignoring the
> > range) and I'd rather than a vfs helper.
> 
> I'm not 100% sure, but it looks like the PF_SYNCWRITE process flag
> should be set on the nfsd's while they're doing that, which doesn't
> seem to be happening atm.  Looks like a couple of the IO schedulers
> will make use of that knowledge now.  All the more reason for a VFS
> helper here I guess. ;)

PF_SYNCWRITE? What's that???

(find | xargs grep ...)
Oh.  The block device schedulers like to know if a request is sync or
async (and all reads are assumed to be sync) - which is reasonable -
and so have a per-task flag to tell them - which isn't (IMO).

md/raid (particularly raid5) often does the write from a different
process than generated the original request, so that will break
completely. 

What is wrong with a bio flag I wonder....

Hopefully this will get wrapped up in a do_X helper so nfsd won't need
to know about it.

Thanks for the heads-up.

NeilBrown

