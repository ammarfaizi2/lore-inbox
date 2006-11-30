Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1031239AbWK3Tbl@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1031239AbWK3Tbl (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 30 Nov 2006 14:31:41 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1031238AbWK3Tbl
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 30 Nov 2006 14:31:41 -0500
Received: from wx-out-0506.google.com ([66.249.82.239]:32688 "EHLO
	wx-out-0506.google.com") by vger.kernel.org with ESMTP
	id S967909AbWK3Tbk (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 30 Nov 2006 14:31:40 -0500
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=F9x4Bjb1NNjnBLYqrGVVYKcH65V2QJxipWpbOgh2LsVmBxbxdUgW6/WsoTmtll0vVZaLA72+il5yQ4rPR2HtHj4cnNnw2HKNIZpszKVCFSxluyzXKtGy+htSXZ5o4RUYlgAinKYzwFtms8Oe1vl3St/7qmsBuoSa6Van6P5jqUM=
Message-ID: <5c49b0ed0611301131q3ee6ae08l8caeb4a226960203@mail.gmail.com>
Date: Thu, 30 Nov 2006 11:31:39 -0800
From: "Nate Diller" <nate.diller@gmail.com>
To: "Wendy Cheng" <wcheng@redhat.com>
Subject: Re: [PATCH] prune_icache_sb
Cc: "Andrew Morton" <akpm@osdl.org>, linux-kernel@vger.kernel.org,
       linux-fsdevel@vger.kernel.org
In-Reply-To: <456F014C.5040200@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
References: <4564C28B.30604@redhat.com> <20061122153603.33c2c24d.akpm@osdl.org>
	 <456B7A5A.1070202@redhat.com> <20061127165239.9616cbc9.akpm@osdl.org>
	 <456CACF3.7030200@redhat.com> <20061128162144.8051998a.akpm@osdl.org>
	 <456D2259.1050306@redhat.com> <456F014C.5040200@redhat.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 11/30/06, Wendy Cheng <wcheng@redhat.com> wrote:
> How about a simple and plain change with this uploaded patch ....
>
> The idea is, instead of unconditionally dropping every buffer associated
> with the particular mount point (that defeats the purpose of page
> caching), base kernel exports the "drop_pagecache_sb()" call that allows
> page cache to be trimmed. More importantly, it is changed to offer the
> choice of not randomly purging any buffer but the ones that seem to be
> unused (i_state is NULL and i_count is zero). This will encourage
> filesystem(s) to pro actively response to vm memory shortage if they
> choose so.
>
>  From our end (cluster locks are expensive - that's why we cache them),
> one of our kernel daemons will invoke this newly exported call based on
> a set of pre-defined tunables. It is then followed by a lock reclaim
> logic to trim the locks by checking the page cache associated with the
> inode (that this cluster lock is created for). If nothing is attached to
> the inode (based on i_mapping->nrpages count), we know it is a good
> candidate for trimming and will subsequently drop this lock (instead of
> waiting until the end of vfs inode life cycle).

I have a patch that is a more comprehensive version of this idea, but
it is not fully debugged, and has suffered some bitrot in the past
couple months.  This turns out to be a good performance improvement in
the general case too, but is more complex than your idea because there
are real locking changes needed to avoid deadlocks.  I can send you a
copy of the patch if you are interested.

> Note that I could do invalidate_inode_pages() within our kernel modules
> to accomplish what drop_pagecache_sb() does (without coming here to bug
> people) but I don't have access to inode_lock as an external kernel
> module. So either EXPORT_SYMBOL(inode_lock) or this patch ?

like i said above, you have to be careful when touching inode_lock,
dcache_lock, and the mapping's tree_lock, because of potential
deadlocks.  the mapping's lock can be taken from softirq context, but
the inode and dcache locks cannot.

NATE
