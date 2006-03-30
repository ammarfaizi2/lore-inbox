Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751091AbWC3ILn@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751091AbWC3ILn (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 30 Mar 2006 03:11:43 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751086AbWC3ILn
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 30 Mar 2006 03:11:43 -0500
Received: from smtp.osdl.org ([65.172.181.4]:33185 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S1751091AbWC3ILm (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 30 Mar 2006 03:11:42 -0500
Date: Thu, 30 Mar 2006 00:11:09 -0800
From: Andrew Morton <akpm@osdl.org>
To: Neil Brown <neilb@suse.de>
Cc: linux-kernel@vger.kernel.org, drepper@redhat.com, mtk-manpages@gmx.net,
       nickpiggin@yahoo.com.au
Subject: Re: [patch 1/1] sys_sync_file_range()
Message-Id: <20060330001109.6cd10565.akpm@osdl.org>
In-Reply-To: <17451.36790.450410.79788@cse.unsw.edu.au>
References: <200603300741.k2U7fQLe002202@shell0.pdx.osdl.net>
	<17451.36790.450410.79788@cse.unsw.edu.au>
X-Mailer: Sylpheed version 1.0.4 (GTK+ 1.2.10; i386-redhat-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Neil Brown <neilb@suse.de> wrote:
>
> On Wednesday March 29, akpm@osdl.org wrote:
> > 
> > From: Andrew Morton <akpm@osdl.org>
> > 
> > Remove the recently-added LINUX_FADV_ASYNC_WRITE and LINUX_FADV_WRITE_WAIT
> > fadvise() additions, do it in a new sys_sync_file_range() syscall
> > instead. 
> 
> Hmmm... any chance this could be split into a sys_sync_file_range and
> a vfs_sync_file_range which takes a 'struct file*' and does less (or
> no) sanity checking, so I can call it from nfsd?

Coming right up.  (Will switch it to fget_light() too)

> Currently I implement COMMIT (which has a range) with a by messing
> around with filemap_fdatawrite and filemap_fdatawait (ignoring the
> range) and I'd rather than a vfs helper.
> 
> And in nfsd I call filp->f_op->fsync between the two.  Doesn't
> sys_sync_file_range need to call into the filesystem at all?

Interesting question.  sync_file_range() is purely a pagecache (ie: file
contents) operation.  It doesn't touch metadata at all.

So if it's being used for data-integrity purposes then it really only makes
sense when it's doing file overwrites.

It does call into the filesystem of course - a_ops.writepages() and perhaps
a_ops.writepage().

