Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261653AbVDBBns@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261653AbVDBBns (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 1 Apr 2005 20:43:48 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262959AbVDBBns
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 1 Apr 2005 20:43:48 -0500
Received: from fire.osdl.org ([65.172.181.4]:5576 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S261653AbVDBBnn (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 1 Apr 2005 20:43:43 -0500
Subject: Re: [PATCH] Direct IO async short read bug followup
From: Daniel McNeil <daniel@osdl.org>
To: Andrew Morton <akpm@osdl.org>
Cc: Badari Pulavarty <pbadari@us.ibm.com>, sebastien.dugue@bull.net,
       jean-pierre.dion@bull.net, gh@us.ibm.com, janetmor@us.ibm.com,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       "linux-aio@kvack.org" <linux-aio@kvack.org>
In-Reply-To: <20050401172022.45d0cdd5.akpm@osdl.org>
References: <1111743607.1299.85.camel@frecb000686>
	 <20050325014307.4395012e.akpm@osdl.org>
	 <1111745400.1299.89.camel@frecb000686>
	 <20050325022416.01c2535b.akpm@osdl.org> <42442743.40600@us.ibm.com>
	 <1112404259.29841.19.camel@ibm-c.pdx.osdl.net>
	 <20050401172022.45d0cdd5.akpm@osdl.org>
Content-Type: text/plain
Message-Id: <1112406206.29841.31.camel@ibm-c.pdx.osdl.net>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.6 
Date: Fri, 01 Apr 2005 17:43:27 -0800
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 2005-04-01 at 17:20, Andrew Morton wrote:
> Daniel McNeil <daniel@osdl.org> wrote:
> >
> > I updated the patch to add an i_size element to the dio structure and
> >  sample i_size during i/o submission.  When i/o completes the result can
> >  be truncated to match the file size without using i_size_read(), thus
> >  the aio result now matches the number of bytes read to the end of file.
> > 
> 
> Can you provide the analysis of the bug, please?

The direct i/o code is mapping the read request to the file system
block.  If the file size was not on a block boundary, the result
would show the the read reading past EOF.  This was only happening
for the AIO case.  The non-AIO case truncates the result to match
file size (in direct_io_worker).  This patch does the same thing
for the AIO case, it truncates the result to match the file size
if the read reads past EOF.
> 
> > 
> >  Daniel
> > 
> >  --- linux-2.6.11.orig/fs/direct-io.c	2005-04-01 15:33:11.000000000 -0800
> >  +++ linux-2.6.11/fs/direct-io.c	2005-03-31 16:59:15.000000000 -0800
> >  @@ -66,6 +66,7 @@ struct dio {
> >   	struct bio *bio;		/* bio under assembly */
> >   	struct inode *inode;
> >   	int rw;
> >  +	ssize_t i_size;			/* i_size when submitted */
> 
> I'll change this to loff_t, OK?
> -

Yes.

Daniel

