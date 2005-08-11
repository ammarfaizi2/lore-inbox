Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932298AbVHKQW7@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932298AbVHKQW7 (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 11 Aug 2005 12:22:59 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932297AbVHKQW7
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 11 Aug 2005 12:22:59 -0400
Received: from nproxy.gmail.com ([64.233.182.197]:18782 "EHLO nproxy.gmail.com")
	by vger.kernel.org with ESMTP id S932298AbVHKQW6 convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 11 Aug 2005 12:22:58 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=CjDy02Nz1+PS4bfO6A0yocJI+odcj7rVjR2SdLEZXSnsM+SgleMjoRXdf4lAP3ypzQU6GBDJmDpH8af8Sb0CHTCcI3y016+0CEDLyib/m+50y4CXkBOxnGzwa/KhtB1nH5QTZ6ZzYzsn6qQcbMlxmxuYCpyFrNIJ1EnTKQCrysg=
Message-ID: <2cd57c9005081109222c6a5973@mail.gmail.com>
Date: Fri, 12 Aug 2005 00:22:53 +0800
From: Coywolf Qi Hunt <coywolf@gmail.com>
To: Andrew Morton <akpm@osdl.org>
Subject: Re: [PATCH] remove name length check in a workqueue
Cc: James Bottomley <James.Bottomley@steeleye.com>, mingo@redhat.com,
       linux-kernel@vger.kernel.org, linux-scsi@vger.kernel.org
In-Reply-To: <20050810112710.47388a55.akpm@osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Content-Disposition: inline
References: <1123683544.5093.4.camel@mulgrave>
	 <Pine.LNX.4.58.0508101044110.31617@devserv.devel.redhat.com>
	 <20050810100523.0075d4e8.akpm@osdl.org>
	 <1123694672.5134.11.camel@mulgrave>
	 <20050810103733.42170f27.akpm@osdl.org>
	 <1123696466.5134.23.camel@mulgrave>
	 <20050810112710.47388a55.akpm@osdl.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 8/11/05, Andrew Morton <akpm@osdl.org> wrote:
> James Bottomley <James.Bottomley@SteelEye.com> wrote:
> >
> > On Wed, 2005-08-10 at 10:37 -0700, Andrew Morton wrote:
> > > > and anyway, it doesn't have to be unique;
> > > > set_task_comm just does a strlcpy from the name, so it will be truncated
> > > > (same as for a binary with > 15 character name).
> > >
> > > Yup.  But it'd be fairly silly to go adding the /%d, only to have it
> > > truncated off again.
> >
> > Well, but the other alternative is that we hit arbitrary BUG_ON() limits
> > in systems that create numbered workqueues which is rather contrary to
> > our scaleability objectives, isn't it?
> 
> Another alternative is to stop passing in such long strings ;)
> 
> > > What's the actual problem?
> >
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
>         if (singlethread)
>                 BUG_ON(strlen(name) > sizeof(task_struct.comm) - 1);
>         else
>                 BUG_ON(strlen(name) > sizeof(task_struct.comm) - 1 - 4);
> 
> which gets you 10,000,000 HBAs.   Enough?
> 
> Ho hum, OK, let's just kill the BUG_ON.

s/BUG_ON/WARN_ON/ ?

-- 
Coywolf Qi Hunt
http://ahbl.org/~coywolf/
