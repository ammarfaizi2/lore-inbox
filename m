Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265145AbTFMFdc (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 13 Jun 2003 01:33:32 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265151AbTFMFdc
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 13 Jun 2003 01:33:32 -0400
Received: from e5.ny.us.ibm.com ([32.97.182.105]:59564 "EHLO e5.ny.us.ibm.com")
	by vger.kernel.org with ESMTP id S265145AbTFMFda (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 13 Jun 2003 01:33:30 -0400
Date: Fri, 13 Jun 2003 11:20:01 +0530
From: Dipankar Sarma <dipankar@in.ibm.com>
To: Trond Myklebust <trond.myklebust@fys.uio.no>
Cc: John M Flinchbaugh <glynis@butterfly.hjsoft.com>,
       linux-kernel@vger.kernel.org, Linus Torvalds <torvalds@transmeta.com>,
       Maneesh Soni <maneesh@in.ibm.com>
Subject: Re: 2.5.70-bk16: nfs crash
Message-ID: <20030613055001.GA1331@in.ibm.com>
Reply-To: dipankar@in.ibm.com
References: <20030612125630.GA19842@butterfly.hjsoft.com> <20030612135254.GA2482@in.ibm.com> <16104.40370.828325.379995@charged.uio.no> <20030612155345.GB1438@in.ibm.com> <16104.43445.918001.683257@charged.uio.no> <20030612195302.GH1438@in.ibm.com> <16105.24576.901270.856844@charged.uio.no>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <16105.24576.901270.856844@charged.uio.no>
User-Agent: Mutt/1.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jun 12, 2003 at 10:24:16PM -0700, Trond Myklebust wrote:
> Wrong. Look at the VFS code. In all cases the test is of the form.
> 
>     spin_lock(&dcache_lock);
>     /* Are we the sole users of this dentry */
>     if (atomic_read(&dentry->d_count) == 1) {
>        /* Yes - do some operation */
>     }
> 
> 
> Knowing that d_lookup() can *increase* d_count is not a plus here. The
> whole idea is to have a test for sole use.

Well, d_lookup() isn't the only place that does a dget() without
holding dcache_lock. There are *many* places where dget() is
done without holding dcache_lock. That didn't seem to be a
requirement in the pre-RCU dcache model.

> 
> In most cases, the "do some operation" above is
> 
> 	d_drop(dentry);
> 

I don't think that would work in pre or post-RCU dcache.

> in order (for instance) to ensure that nobody else can look up this
> dentry while we're working on it (e.g. rename or unlink,...).

rename, unlink etc. hold the per-dentry lock, so they are protected
against lockfree d_lookup().

> 
> Your d_lookup() screws the above example of code which you can find in
> any number of VFS functions. dput(), d_delete(), d_invalidate(),
> d_prune_aliases(), prune_dcache(), shrink_dcache_sb() are but a few
> functions that rely on the above code snippet working to keep
> d_lookup() from intruding.

Those routines hold the per-dentry lock as required and that protects
them from intruding lockfree d_lookup().

Thanks
Dipankar
