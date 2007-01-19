Return-Path: <linux-kernel-owner+w=401wt.eu-S932231AbXASPkW@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932231AbXASPkW (ORCPT <rfc822;w@1wt.eu>);
	Fri, 19 Jan 2007 10:40:22 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932333AbXASPkW
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 19 Jan 2007 10:40:22 -0500
Received: from wr-out-0506.google.com ([64.233.184.226]:6566 "EHLO
	wr-out-0506.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932231AbXASPkV (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 19 Jan 2007 10:40:21 -0500
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=beta;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=XMXkCt5ra4HeyzFJecXfP8K7LETPCbw5e8AdxSptmWiApXeIVpw0tNTCZnGkWer+cNFyMQxDgZ37MWCENaLvdtQiffTXvcz1DzlFslx5RNqykc9BpluUCc74Zbv9Xm4GIcodZmTjQFTCFdHH5vFGP4GBEzkfzIpvH0U42x+CFs8=
Message-ID: <6d6a94c50701190740v6da25151kb9ddcf358ab2957@mail.gmail.com>
Date: Fri, 19 Jan 2007 23:40:20 +0800
From: "Aubrey Li" <aubreylee@gmail.com>
To: "Vaidyanathan Srinivasan" <svaidy@linux.vnet.ibm.com>
Subject: Re: [RPC][PATCH 2.6.20-rc5] limit total vfs page cache
Cc: linux-kernel@vger.kernel.org, linux-mm@kvack.org,
       "Linus Torvalds" <torvalds@osdl.org>, "Andrew Morton" <akpm@osdl.org>,
       "Nick Piggin" <nickpiggin@yahoo.com.au>,
       "linux-os (Dick Johnson)" <linux-os@analogic.com>,
       "Robin Getz" <rgetz@blackfin.uclinux.org>
In-Reply-To: <45B0D967.8090607@linux.vnet.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
References: <6d6a94c50701171923g48c8652ayd281a10d1cb5dd95@mail.gmail.com>
	 <45B0D967.8090607@linux.vnet.ibm.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 1/19/07, Vaidyanathan Srinivasan <svaidy@linux.vnet.ibm.com> wrote:
>
> Hi Aubrey,
>
> I used your patch on my PPC64 box and I do not get expected
> behavior.  As you had requested, I am attaching zoneinfo and meminfo
> dumps:
>
> Please let me know if you need any further data to help me out with
> the test/experiment.
>

Although I have no PPC64 box in hand, I think the logic should be the same.
get_page_from_freelist() is called 5 times in __alloc_pages().

1) alloc_flags = ALLOC_WMARK_LOW | ALLOC_PAGECACHE;
2) alloc_flags = ALLOC_WMARK_MIN | ALLOC_PAGECACHE;
We should have the same result on the first two times get_page_from_freelist().

3) if (((p->flags & PF_MEMALLOC) || unlikely(test_thread_flag(TIF_MEMDIE)))
			&& !in_interrupt())
   alloc_flags = ALLOC_NO_WATERMARKS
The case on my platform will never enter this branch. If the branch
occurs on your side,
The limit will be omitted. Because NO watermark, zone_watermark_ok()
will not be checked. memory will be allocated directly.

4)if (likely(did_some_progress)) {
   alloc_flags should include ALLOC_PAGECACHE.
So we should have the same result on this call.

5)	} else if ((gfp_mask & __GFP_FS) && !(gfp_mask & __GFP_NORETRY)) {
   alloc_flags = ALLOC_WMARK_HIGH, without ALLOC_PAGECACHE

This branch will not hit on my case. You may need to check it.

If 3) or 5) occurs on your platform, I think you can easily fix it.
Please confirm it and let me know the result.

Thanks,
-Aubrey
