Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263923AbUDFRlX (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 6 Apr 2004 13:41:23 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263925AbUDFRlX
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 6 Apr 2004 13:41:23 -0400
Received: from fmr04.intel.com ([143.183.121.6]:64406 "EHLO
	caduceus.sc.intel.com") by vger.kernel.org with ESMTP
	id S263923AbUDFRlR (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 6 Apr 2004 13:41:17 -0400
Message-Id: <200404061740.i36HeLF05474@unix-os.sc.intel.com>
From: "Chen, Kenneth W" <kenneth.w.chen@intel.com>
To: "'Andy Whitcroft'" <apw@shadowen.org>, "'Ray Bryant'" <raybry@sgi.com>
Cc: "Martin J. Bligh" <mbligh@aracnet.com>, "Andrew Morton" <akpm@osdl.org>,
       <linux-kernel@vger.kernel.org>, <anton@samba.org>, <sds@epoch.ncsc.mil>,
       <ak@suse.de>, <lse-tech@lists.sourceforge.net>,
       <linux-ia64@vger.kernel.org>
Subject: RE: [Lse-tech] RE: [PATCH] HUGETLB memory commitment
Date: Tue, 6 Apr 2004 10:40:22 -0700
X-Mailer: Microsoft Office Outlook, Build 11.0.5510
Thread-Index: AcQb8eP6Ht9dppyzQ/mvZ4Kd/7fxTAABsFyg
In-Reply-To: <25241785.1081271641@42.150.104.212.access.eclipse.net.uk>
X-MimeOLE: Produced By Microsoft MimeOLE V6.00.2800.1106
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>>>> Andy Whitcroft wrote on Tue, April 06, 2004 9:14 AM
> >>>>> Ray Bryant wrote on Monday, April 05, 2004 11:22 AM
> >> > Chen, Kenneth W wrote:
> >> > I actually started coding yesterday.  It doesn't look too bad (I think).
> >> > I will post it once I finished it up later today or tomorrow.
> >>
> >> Hmmm...so did I.  Oh well.  We can pull the good ideas from both. :-)
>
> Bugger, so am I.  Someone will have to merge :)
>
> > +	/* we have enough hugetlb page, go ahead reserve them */
> > +	switch(action) {
> > +		case BACK_MERGE:
> > +			curr->end = block_end;
> > +			break;
> > +		case FRONT_MERGE:
> > +			curr->start = block_start;
> > +			break;
> > +		case THREE_WAY_MERGE:
> > +			curr->end = next->end;
> > +			list_del(p->next);
> > +			kfree(next);
> > +			break;
>
> I don't know if I have read this right, but if I have then you only support
> overlapping with two existing extents?  What if there are extents from 0-4,
> 6-8 and 10-12 when you map 0-16?  Will that not corrupt the list?


Doh, you are absolutely right that this code is broken in that scenario.



> Anyhow, below is a work in progress, ie it compiles and boots and passes
> the tests I've applied (not tested error handling well yet).  The regions
> accumulation code has been extensively tested in a user level test harness,
> so I am fairly sure it works.  I have split the request and commit phases
> for the region handling to allow simpler backout on other failure such as
> quota (which remains to be fixed).
>
>
> @@ -736,11 +996,18 @@ struct file *hugetlb_zero_setup(size_t s
>  	d_instantiate(dentry, inode);
>  	inode->i_size = size;
>  	inode->i_nlink = 0;
> +	inode->i_blocks = HUGETLBFS_NOACCT;
>  	file->f_vfsmnt = mntget(hugetlbfs_vfsmount);
>  	file->f_dentry = dentry;
>  	file->f_mapping = inode->i_mapping;
>  	file->f_op = &hugetlbfs_file_operations;
>  	file->f_mode = FMODE_WRITE | FMODE_READ;
> +
> +	error = hugetlb_acct_prepare(inode, 0, size / PAGE_SIZE);
> +	if (error < 0)
> +		goto out_file;
> +	hugetlb_acct_commit(inode, 0, size / PAGE_SIZE);
> +
>  	return file;

Is this absolutely necessary?  There is no vma associated at shmget().
shmat() eventually calls mmap, and that is already covered.

- Ken


