Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129197AbRB1TQ2>; Wed, 28 Feb 2001 14:16:28 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129213AbRB1TQT>; Wed, 28 Feb 2001 14:16:19 -0500
Received: from pneumatic-tube.sgi.com ([204.94.214.22]:25192 "EHLO
	pneumatic-tube.sgi.com") by vger.kernel.org with ESMTP
	id <S129197AbRB1TQG>; Wed, 28 Feb 2001 14:16:06 -0500
Message-ID: <3A9D4E00.CD8C3682@sgi.com>
Date: Wed, 28 Feb 2001 11:14:08 -0800
From: Rajagopal Ananthanarayanan <ananth@sgi.com>
X-Mailer: Mozilla 4.72 [en] (X11; U; Linux 2.2.16-4SGI_20smp i686)
X-Accept-Language: en
MIME-Version: 1.0
To: Rik van Riel <riel@conectiva.com.br>, linux-kernel@vger.kernel.org
Subject: Clustered IO (was: Re: [patch][rfc][rft] vm throughput 2.4.2-ac4)
In-Reply-To: <97j66o$7fej5$1@fido.engr.sgi.com>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Rik van Riel wrote:

> 
> Another solution would be to do some more explicit IO clustering and
> only flush _large_ clusters ... no need to invoke extra disk seeks
> just to free a single page, unless you only have single pages left.

Hi Rik,

Yes, clustering IO at the higher level can improve performance.
This improvement is on top of the excellent elevator changes that
Jens Axboe has done in 2.4.2. In XFS we are doing clustering
at writepage(). There are two paths:

	1. page_launder() -> writepage() -> cluster
		# this path under memory pressure.
	2. try_to_free_buffers() -> writepage() -> cluster
		# this path under background writing as in bdflush
		# but can also be used by sync() type operations that
		# work with buffers than pages.

Clustering by itself (in XFS) improves write performance by about 15-20%,
and we're seeing close to raw I/O performance. With clustering
the IO requests are pegged at 1024 sectors (512K bytes)
when performing large sequential writes ...


ananth.


--------------------------------------------------------------------------
Rajagopal Ananthanarayanan ("ananth")
Member Technical Staff, SGI.
--------------------------------------------------------------------------
