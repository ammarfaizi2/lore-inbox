Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751053AbVHKOiF@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751053AbVHKOiF (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 11 Aug 2005 10:38:05 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751055AbVHKOiF
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 11 Aug 2005 10:38:05 -0400
Received: from ecfrec.frec.bull.fr ([129.183.4.8]:50563 "EHLO
	ecfrec.frec.bull.fr") by vger.kernel.org with ESMTP
	id S1751050AbVHKOiD (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 11 Aug 2005 10:38:03 -0400
Date: Thu, 11 Aug 2005 16:37:53 +0200 (CEST)
From: Simon Derr <Simon.Derr@bull.net>
X-X-Sender: derrs@openx3.frec.bull.fr
To: Andrew Morton <akpm@osdl.org>
Cc: James Bottomley <James.Bottomley@SteelEye.com>, mingo@redhat.com,
       linux-kernel@vger.kernel.org, linux-scsi@vger.kernel.org
Subject: Re: [PATCH] remove name length check in a workqueue
In-Reply-To: <20050810112710.47388a55.akpm@osdl.org>
Message-ID: <Pine.LNX.4.61.0508111630360.25305@openx3.frec.bull.fr>
References: <1123683544.5093.4.camel@mulgrave>
 <Pine.LNX.4.58.0508101044110.31617@devserv.devel.redhat.com>
 <20050810100523.0075d4e8.akpm@osdl.org> <1123694672.5134.11.camel@mulgrave>
 <20050810103733.42170f27.akpm@osdl.org> <1123696466.5134.23.camel@mulgrave>
 <20050810112710.47388a55.akpm@osdl.org>
MIME-Version: 1.0
X-MIMETrack: Itemize by SMTP Server on ECN002/FR/BULL(Release 5.0.12  |February 13, 2003) at
 11/08/2005 16:50:23,
	Serialize by Router on ECN002/FR/BULL(Release 5.0.12  |February 13, 2003) at
 11/08/2005 16:50:25,
	Serialize complete at 11/08/2005 16:50:25
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 10 Aug 2005, Andrew Morton wrote:

> > What I posted originally; the current SCSI format for a workqueue:
> > scsi_wq_%d hits the bug after the host number rises to 100, which has
> > been seen by some enterprise person with > 100 HBAs.
> > 
> > The reason for this name is that the error handler thread is called
> > scsi_eh_%d; so we could rename all our threads to avoid this, but one
> > day someone will come along with a huge enough machine to hit whatever
> > limit we squeeze it down to.
> 
> OK, well scsi is using single-threaded workqueues anyway.  So we could do:
> 
> 	if (singlethread)
> 		BUG_ON(strlen(name) > sizeof(task_struct.comm) - 1);
> 	else
> 		BUG_ON(strlen(name) > sizeof(task_struct.comm) - 1 - 4);
> 
> which gets you 10,000,000 HBAs.   Enough?

I suppose so, but the problem is slightly worse:

One does not need 100 HBAs to trigger the BUG_ON: 

It is sufficient to have a few HBAs and to insmod/rmmod the driver a few 
times.

Since the host_no is choosen with a mere counter increment 
in scsi_host_alloc():

      shost->host_no = scsi_host_next_hn++; /* XXX(hch): still racy */

Unused `host_no's are not reused and the 100 limit is reached even on 
smaller systems.

I have no idea of why someone would do repeated insmod/rmmods, though.
(But someone did).

	Simon.

