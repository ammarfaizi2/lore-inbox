Return-Path: <linux-kernel-owner+w=401wt.eu-S1750778AbXAKPxf@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750778AbXAKPxf (ORCPT <rfc822;w@1wt.eu>);
	Thu, 11 Jan 2007 10:53:35 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750741AbXAKPxf
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 11 Jan 2007 10:53:35 -0500
Received: from iriserv.iradimed.com ([69.44.168.233]:43725 "EHLO iradimed.com"
	rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
	id S1750736AbXAKPxe (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 11 Jan 2007 10:53:34 -0500
Message-ID: <45A65D7C.2040206@cfl.rr.com>
Date: Thu, 11 Jan 2007 10:53:32 -0500
From: Phillip Susi <psusi@cfl.rr.com>
User-Agent: Thunderbird 1.5.0.9 (Windows/20061207)
MIME-Version: 1.0
To: Viktor <vvp01@inbox.ru>
CC: Linus Torvalds <torvalds@osdl.org>, Aubrey <aubreylee@gmail.com>,
       Hua Zhong <hzhong@gmail.com>, Hugh Dickins <hugh@veritas.com>,
       linux-kernel@vger.kernel.org, hch@infradead.org,
       kenneth.w.chen@intel.com, akpm@osdl.org, mjt@tls.msk.ru
Subject: Re: O_DIRECT question
References: <6d6a94c50701101857v2af1e097xde69e592135e54ae@mail.gmail.com> <Pine.LNX.4.64.0701101902270.3594@woody.osdl.org> <45A629E9.70502@inbox.ru>
In-Reply-To: <45A629E9.70502@inbox.ru>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
X-OriginalArrivalTime: 11 Jan 2007 15:53:54.0717 (UTC) FILETIME=[B25E3CD0:01C73598]
X-TM-AS-Product-Ver: SMEX-7.2.0.1122-3.6.1039-14928.003
X-TM-AS-Result: No--7.995700-5.000000-31
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Viktor wrote:
> OK, madvise() used with mmap'ed file allows to have reads from a file
> with zero-copy between kernel/user buffers and don't pollute cache
> memory unnecessarily. But how about writes? How is to do zero-copy
> writes to a file and don't pollute cache memory without using O_DIRECT?
> Do I miss the appropriate interface?

Not only that but mmap/madvise do not allow you to perform async io. 
You still have to just try and touch the memory and take the page fault 
to cause a read.  This is unacceptable to an application that is trying 
to manage multiple IO streams and keep the pipelines full; it needs to 
block only when there is no more work it can do.

Even with only a single io stream the application needs to keep one side 
reading and one side writing.  To make this work without O_DIRECT would 
require a method to asynchronously fault pages in, and the kernel would 
have to utilize that method when processing aio writes so as not to 
block the calling process if the buffer it asked to write is not in 
memory.

I was rather disappointed years ago by NT's lack of an async page fault 
path, which prevented me from developing an ftp server that could do 
zero copy IO, but still use the filesystem cache and avoid NT's version 
of O_DIRECT.


