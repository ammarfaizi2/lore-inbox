Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261428AbVCHR1b@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261428AbVCHR1b (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 8 Mar 2005 12:27:31 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261438AbVCHR1b
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 8 Mar 2005 12:27:31 -0500
Received: from e1.ny.us.ibm.com ([32.97.182.141]:31120 "EHLO e1.ny.us.ibm.com")
	by vger.kernel.org with ESMTP id S261431AbVCHR1E (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 8 Mar 2005 12:27:04 -0500
Subject: Re: [PATCH] 2.6.10 -  direct-io async short read bug
From: Badari Pulavarty <pbadari@us.ibm.com>
To: suparna@in.ibm.com
Cc: Andrew Morton <akpm@osdl.org>,
       =?ISO-8859-1?Q?S=E9bastien_Dugu=E9?= <sebastien.dugue@bull.net>,
       "linux-aio@kvack.org" <linux-aio@kvack.org>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
In-Reply-To: <20050308090946.GA4100@in.ibm.com>
References: <1110189607.11938.14.camel@frecb000686>
	 <20050307223917.1e800784.akpm@osdl.org>  <20050308090946.GA4100@in.ibm.com>
Content-Type: text/plain
Organization: 
Message-Id: <1110302614.24286.61.camel@dyn318077bld.beaverton.ibm.com>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.2.2 (1.2.2-5) 
Date: 08 Mar 2005 09:23:35 -0800
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 2005-03-08 at 01:09, Suparna Bhattacharya wrote:

> 
> Hmm, shouldn't dio->result ideally have been adjusted to be within
> i_size at the time of io submission, so we don't have to deal with
> this during completion ? We are creating bios with the right size
> after all. 
> 
> We have this: 
> 		if (!buffer_mapped(map_bh)) {
> 				....
> 				if (dio->block_in_file >=
>                                         i_size_read(dio->inode)>>blkbits) {
>                                         /* We hit eof */
>                                         page_cache_release(page);
>                                         goto out;
>                                 }
> 

This check will catch only if there is no block on the disk. In the
current test case, the filesize = 3K and filesystem blocksize=4K.
So, we have a block (beyond filesize). The test tries to read 4K.
None of the checks catch this case and it submits 4K IO. 

> and
> 		dio->result += iov[seg].iov_len -
>                         ((dio->final_block_in_request - dio->block_in_file) <<
>                                         blkbits);
> 
> 
> can you spot what is going wrong here that we have to try and
> workaround this later ?


Andrew, please don't apply the original patch. We shouldn't even attempt
to submit IO beyond the filesize. We should truncate the IO request to
filesize. I will send a patch today to fix this.

Thanks,
Badari

