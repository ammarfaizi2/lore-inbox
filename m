Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262227AbVCHX74@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262227AbVCHX74 (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 8 Mar 2005 18:59:56 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262411AbVCHX7s
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 8 Mar 2005 18:59:48 -0500
Received: from e1.ny.us.ibm.com ([32.97.182.141]:31942 "EHLO e1.ny.us.ibm.com")
	by vger.kernel.org with ESMTP id S262227AbVCHX5f (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 8 Mar 2005 18:57:35 -0500
Subject: Re: [PATCH] 2.6.10 -  direct-io async short read bug
From: Badari Pulavarty <pbadari@us.ibm.com>
To: Daniel McNeil <daniel@osdl.org>
Cc: Suparna Bhattacharya <suparna@in.ibm.com>, Andrew Morton <akpm@osdl.org>,
       =?ISO-8859-1?Q?S=E9bastien_Dugu=E9?= <sebastien.dugue@bull.net>,
       "linux-aio@kvack.org" <linux-aio@kvack.org>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
In-Reply-To: <1110324434.6521.23.camel@ibm-c.pdx.osdl.net>
References: <1110189607.11938.14.camel@frecb000686>
	 <20050307223917.1e800784.akpm@osdl.org>  <20050308090946.GA4100@in.ibm.com>
	 <1110302614.24286.61.camel@dyn318077bld.beaverton.ibm.com>
	 <1110309508.24286.74.camel@dyn318077bld.beaverton.ibm.com>
	 <1110324434.6521.23.camel@ibm-c.pdx.osdl.net>
Content-Type: text/plain
Organization: 
Message-Id: <1110326043.24286.134.camel@dyn318077bld.beaverton.ibm.com>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.2.2 (1.2.2-5) 
Date: 08 Mar 2005 15:54:04 -0800
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 2005-03-08 at 15:27, Daniel McNeil wrote:
> On Tue, 2005-03-08 at 11:18, Badari Pulavarty wrote:
> > > Andrew, please don't apply the original patch. We shouldn't even attempt
> > > to submit IO beyond the filesize. We should truncate the IO request to
> > > filesize. I will send a patch today to fix this.
> > > 
> > 
> > Well, spoke too soon. This is an ugly corner case :( But I have
> > a ugly hack to fix it :)
> > 
> > Let me ask you a basic question: Do we support DIO reads on a file
> > which is not blocksize multiple in size ? (say 12K - 10 bytes) ?
> 
> > What about the ones which are not 4K but 512 byte multiple ? (say 7K) ?
> > 
> > I need answer to those, to figure out how hard I should try to fix this.
> > 
> > Anyway, here is ugly version of the patch - which will limit the IO
> > size to filesize and uses lower blocksizes to read the file (since
> > the filesize is only 3K, it would go down to 512 byte blocksize).
> 
> Badari,
> 
> Just to be clear, are you just asking about what we should support on a
> DIO read that spans EOF?
> 
> For DIO reads past EOF the options are:
> 
> 1. return EINVAL if the DIO goes past EOF.
> 
> 2. truncate the request to file size (which is what your patch does)
>     and if it works, it works.
> 
> 3. truncate the request to a size that actually works - like a multiple
>     of 512.
> 
> 4. Do the full i/o since the user buffer is big enough, truncate the
>     result returned to file size (and clear out the user buffer where it
>     read past EOF).
> 
> Number 4 would make it easy on the user-level code, but AIO DIO might be
> a bit tricky and might be a security hole since the data would be dma'ed
> there and then cleared.  I need to look at the code some more.
> 
> 1 and 2 both seem valid and are better than returning the wrong result.
> 
> 3 seems like it would confuse applications.
> 
> Thoughts?

Well, my basic questions were

1)  Should we support DIO on files with sizes that are not multiple of
filesystem blocksize (but multiple of 512 bytes) == say 6K.
I think so, and we should kick it to use 512byte blocksize in the
DIO code.

2) Should we support DIO on files with sizes that are not multiple of
filesystem blocksize and also multiple of 512 bytes == say 8190 bytes.
I think NOT. 

The problem is, we check alignment restrictions for buffer, offset
and IO sizes. We don't care about the filesize - only issue comes
is if the user tries to go beyond EOF.

So on a 8190 byte file, with DIO if the user does
	lseek(fd, 4096, 0);
	read(fd, buf, 4096);

what should read() return ? read() is expected to return 4094 bytes or
EINVAL ?


Thanks,
Badari

