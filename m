Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263622AbTHZK4b (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 26 Aug 2003 06:56:31 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263637AbTHZK4b
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 26 Aug 2003 06:56:31 -0400
Received: from e1.ny.us.ibm.com ([32.97.182.101]:49105 "EHLO e1.ny.us.ibm.com")
	by vger.kernel.org with ESMTP id S263622AbTHZK4Q (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 26 Aug 2003 06:56:16 -0400
Date: Tue, 26 Aug 2003 16:31:11 +0530
From: Suparna Bhattacharya <suparna@in.ibm.com>
To: Andrew Morton <akpm@osdl.org>
Cc: Steve Lord <lord@sgi.com>, barryn@pobox.com, linux-kernel@vger.kernel.org,
       linux-mm@kvack.org, linux-xfs@oss.sgi.com
Subject: Re: [BUG] 2.6.0-test4-mm1: NFS+XFS=data corruption
Message-ID: <20030826110111.GA4750@in.ibm.com>
Reply-To: suparna@in.ibm.com
References: <20030824171318.4acf1182.akpm@osdl.org> <20030825193717.GC3562@ip68-4-255-84.oc.oc.cox.net> <20030825124543.413187a5.akpm@osdl.org> <1061852050.25892.195.camel@jen.americas.sgi.com> <20030826031412.72785b15.akpm@osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20030826031412.72785b15.akpm@osdl.org>
User-Agent: Mutt/1.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Aug 26, 2003 at 03:14:12AM -0700, Andrew Morton wrote:
> Steve Lord <lord@sgi.com> wrote:
> >
> > > > Is this enough information to help find the cause of the bug? If not,
> >  > > it might be several days (if I'm unlucky, maybe even a week or two)
> >  > > before I have time to do anything more...
> >  > > 
> >  > 
> >  > -mm kernels have O_DIRECT-for-NFS patches in them.  And some versions of
> >  > RPM use O_DIRECT.  Whether O_DIRECT makes any difference at the server end
> >  > I do not know, but it would be useful if you could repeat the test on stock
> >  > 2.6.0-test4.
> >  > 
> >  > Alternatively, run
> >  > 
> >  > 	export LD_ASSUME_KERNEL=2.2.5
> >  > 
> >  > before running RPM.  I think that should tell RPM to not try O_DIRECT.
> > 
> >  I doubt the NFS client is O_DIRECT capable here, I have run some rpm
> >  builds over nfs to 2.6.0-test4 and an xfs filesystem, everything is
> >  behaving so far. I will try mm1 tomorrow.
> > 
> >  Do we know if this NFS V3 or V2 by the way?
> 
> OK, sorry for the noise.  It appears that this is due to the AIO patches in
> -mm.  fsx-linux fails instantly on nfsv3 to localhost on XFS.  It's OK on
> ext2 for some reason.
> 
> Binary searching reveals that the offending patch is
> O_SYNC-speedup-nolock-fix.patch
> 

I'm not sure if this would help here, but there is
one bug which I just spotted which would affect writev from
XFS. I wasn't passing the nr_segs down properly.

Regards
Suparna

-- 
Suparna Bhattacharya (suparna@in.ibm.com)
Linux Technology Center
IBM Software Labs, India


--- linux-2.6.0-test4-mm1/mm/filemap.c	2003-08-26 10:09:50.000000000 +0530
+++ fix-mm/mm/filemap.c	2003-08-26 16:23:55.000000000 +0530
@@ -1942,7 +1942,7 @@ generic_file_aio_write_nolock(struct kio
 		goto osync;
 	}
 
-	ret = __generic_file_aio_write_nolock(iocb, iov, 1, ppos);
+	ret = __generic_file_aio_write_nolock(iocb, iov, nr_segs, ppos);
 
 	/*
 	 * Avoid doing a sync in parts for aio - its more efficient to
