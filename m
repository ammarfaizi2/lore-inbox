Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265173AbTFMGhn (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 13 Jun 2003 02:37:43 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265176AbTFMGhn
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 13 Jun 2003 02:37:43 -0400
Received: from e4.ny.us.ibm.com ([32.97.182.104]:15236 "EHLO e4.ny.us.ibm.com")
	by vger.kernel.org with ESMTP id S265173AbTFMGhl (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 13 Jun 2003 02:37:41 -0400
Date: Fri, 13 Jun 2003 12:24:19 +0530
From: Dipankar Sarma <dipankar@in.ibm.com>
To: Trond Myklebust <trond.myklebust@fys.uio.no>
Cc: John M Flinchbaugh <glynis@butterfly.hjsoft.com>,
       linux-kernel@vger.kernel.org, Linus Torvalds <torvalds@transmeta.com>,
       Maneesh Soni <maneesh@in.ibm.com>
Subject: Re: 2.5.70-bk16: nfs crash
Message-ID: <20030613065418.GC1331@in.ibm.com>
Reply-To: dipankar@in.ibm.com
References: <20030612125630.GA19842@butterfly.hjsoft.com> <20030612135254.GA2482@in.ibm.com> <16104.40370.828325.379995@charged.uio.no> <20030612155345.GB1438@in.ibm.com> <16104.43445.918001.683257@charged.uio.no> <20030612195302.GH1438@in.ibm.com> <16105.24576.901270.856844@charged.uio.no> <20030613055001.GA1331@in.ibm.com> <16105.27531.983439.972077@charged.uio.no>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <16105.27531.983439.972077@charged.uio.no>
User-Agent: Mutt/1.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jun 12, 2003 at 11:13:31PM -0700, Trond Myklebust wrote:
> >>>>> " " == Dipankar Sarma <dipankar@in.ibm.com> writes:
> d_lookup() is the only place where someone can pick up an existing
> dentry for which they do not already hold a reference.

AFAICS, the way to do a perfectly safe "sole ownership" check is
to grab the per-dentry lock (instead of dcache_lock) and
do the check.

>     >> d_invalidate(), d_prune_aliases(), prune_dcache(),
>     >> shrink_dcache_sb() are but a few functions that rely on the
>     >> above code snippet working to keep d_lookup() from intruding.
> 
>      > Those routines hold the per-dentry lock as required and that
>      > protects them from intruding lockfree d_lookup().
> 
> d_invalidate() does not. d_prune_aliases() does not. d_unhash() does
> not.
> 
> Down in the per-filesystem code, I know of several locations in the
> NFS code that do not. There's one in procfs. I'm sure you can find
> more examples in the other filesystems too...

Yes and we need an audit. Besides I see places where d_count check
is being done without holding *any* lock. That is ok only if the
dentry is guranteed to be unhashed and we are doing a "sole ownership"
check. Otherwise it may not work.

> 
> Your argument only holds water if you demand that all callers of
> d_drop() should also take the per-dentry lock. AFAICS this is not
> being enforced.

There are some rules that we need to work out irrespective of
RCU and document clearly -

1. d_unhashed() checks that are being done with and without dcache_lock -

	if (!d_unhashed(new_dentry)) {
		d_drop(new_dentry);
		rehash = new_dentry;
	}
This seems to require that either we hold the dcache_lock or the operations
that we do on the dentry allow unhashed dentries.

2. Checking for "sole ownership" of dentries. Depending on whether the
   dentry is hashed and what operation we are going to do, we will
   need to hold the per-dentry lock.

I am glad that you are reviewing this. Is there any other dcache
operations in filesystems that you would like to add to the list
above ?

Thanks
Dipankar
