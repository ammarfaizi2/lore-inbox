Return-Path: <SRS0=y5+2=4O=vger.kernel.org=io-uring-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2186EC4BA13
	for <io-uring@archiver.kernel.org>; Wed, 26 Feb 2020 16:53:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E7AA221556
	for <io-uring@archiver.kernel.org>; Wed, 26 Feb 2020 16:53:10 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="Ke3zHlRT"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726810AbgBZQxK (ORCPT <rfc822;io-uring@archiver.kernel.org>);
        Wed, 26 Feb 2020 11:53:10 -0500
Received: from bombadil.infradead.org ([198.137.202.133]:45226 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726151AbgBZQxK (ORCPT
        <rfc822;io-uring@vger.kernel.org>); Wed, 26 Feb 2020 11:53:10 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=lw5ZJrF2vLLzt6YlgdJXV18NDddK/UjL52iREY7XGmI=; b=Ke3zHlRT0xx9Z7vYEyotlimGp2
        BFD9Y++ZwQbhing5NTQQmRQD/CXn/J7mT4nzLxpK+5adnu7fVZ2B9XTUpSkfPSFsW9XwVxnkAFgmR
        eBjVNQbP4uNKGXORLkIOb71jxR+ZgTNWiF4rKd3xZwfUxDekydVOsOIDLsG/hWuhjcz+JaD6SBnEa
        1E2ZkJNDeApgacLPm7+XUqCiGpvVfkaRwvM0wnR1mdorDc3mwTTioNUGTsn1fgURSOSvj0U6DMqHv
        tIvycu3gR+pYR3/haLCxNGU0Aks2pxTghWEVkp8lfAbVMUKXHng7sFVCTSxBQcvcvGCM4RkEkVbeo
        nfPTW35g==;
Received: from hch by bombadil.infradead.org with local (Exim 4.92.3 #3 (Red Hat Linux))
        id 1j6zvp-0001O9-8M; Wed, 26 Feb 2020 16:53:09 +0000
Date:   Wed, 26 Feb 2020 08:53:09 -0800
From:   Christoph Hellwig <hch@infradead.org>
To:     Jens Axboe <axboe@kernel.dk>
Cc:     Christoph Hellwig <hch@infradead.org>,
        Bob Liu <bob.liu@oracle.com>, linux-block@vger.kernel.org,
        martin.petersen@oracle.com, linux-fsdevel@vger.kernel.org,
        darrick.wong@oracle.com, io-uring@vger.kernel.org
Subject: Re: [PATCH 1/4] io_uring: add IORING_OP_READ{WRITE}V_PI cmd
Message-ID: <20200226165309.GA3995@infradead.org>
References: <20200226083719.4389-1-bob.liu@oracle.com>
 <20200226083719.4389-2-bob.liu@oracle.com>
 <6e466774-4dc5-861c-58b5-f0cc728bacff@kernel.dk>
 <20200226155728.GA32543@infradead.org>
 <af282e53-7dff-2df3-0d03-62e1bcdb0005@kernel.dk>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <af282e53-7dff-2df3-0d03-62e1bcdb0005@kernel.dk>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html
Sender: io-uring-owner@vger.kernel.org
Precedence: bulk
List-ID: <io-uring.vger.kernel.org>
X-Mailing-List: io-uring@vger.kernel.org

On Wed, Feb 26, 2020 at 08:58:46AM -0700, Jens Axboe wrote:
> Yeah, should probably be a RWF_ flag instead, and a 64-bit SQE field
> for the PI data. The 'last iovec is PI' is kind of icky.

Abusing an iovec (although I though of the first once when looking
into it) looks really horrible, but has two huge advantages:

 - it doesn't require passing another argument all the way down
   the I/O stack
 - it works with all the vectored interfaces that take a flag
   argument, so not just io_uring, but also preadv2/pwritev2 and aio.
   And while I don't care too much about the last I think preadv2
   and pwritev2 are valuable to support.
