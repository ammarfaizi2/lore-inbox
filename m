Return-Path: <SRS0=HfD6=C6=vger.kernel.org=io-uring-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 91BFEC43465
	for <io-uring@archiver.kernel.org>; Mon, 21 Sep 2020 14:22:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 3418B21D95
	for <io-uring@archiver.kernel.org>; Mon, 21 Sep 2020 14:22:07 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="OXs1CYXb"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727030AbgIUOWG (ORCPT <rfc822;io-uring@archiver.kernel.org>);
        Mon, 21 Sep 2020 10:22:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40224 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726395AbgIUOWG (ORCPT
        <rfc822;io-uring@vger.kernel.org>); Mon, 21 Sep 2020 10:22:06 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1B73EC061755;
        Mon, 21 Sep 2020 07:22:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=Y/Us9X4qT/aW/havC7FyDXhsW5+RVtFshXBuZdiAWy8=; b=OXs1CYXbtPQ98T+kWzGgTwM+xC
        BgWGl8kxj/PnXdn9kypJfnsmo2QLPHbYJ9jaXoF5Ac2nh1xRS4HN4Uw76ivsOIPsD7B4f+ZZuvWo4
        CvgDOl/IbFjZlxjsCE6VNLxMsasOH7r9k1ozB2mhDb3mlXLAuEmN+JgZf6WiEK897VXiSPf1qQUt1
        S5sy93ahhcfqJjA6rS1adaxlppJgo2K3goncTPmwbEINkduUvJQsd2EnsgSB8G4NaZAnUgkiiXbu8
        SUhDjjYS0xeNFEUAbPGKo+ZWPc9AYb4Y6kQQEh3lcDhkIFkWQZrw7nNAnYKiBsTlpALVlhAS5IdwD
        b0Z73IHA==;
Received: from hch by casper.infradead.org with local (Exim 4.92.3 #3 (Red Hat Linux))
        id 1kKMhg-00079y-4V; Mon, 21 Sep 2020 14:22:04 +0000
Date:   Mon, 21 Sep 2020 15:22:04 +0100
From:   Christoph Hellwig <hch@infradead.org>
To:     David Laight <David.Laight@aculab.com>
Cc:     "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "netdev@vger.kernel.org" <netdev@vger.kernel.org>,
        "io-uring@vger.kernel.org" <io-uring@vger.kernel.org>,
        Jens Axboe <axboe@kernel.dk>,
        "David S. Miller" <davem@davemloft.net>,
        Al Viro <viro@zeniv.linux.org.uk>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>
Subject: Re: [PATCH 5/9 next] scsi: Use iovec_import() instead of
 import_iovec().
Message-ID: <20200921142204.GE24515@infradead.org>
References: <27be46ece36c42d6a7dabf62c6ac7a98@AcuMS.aculab.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <27be46ece36c42d6a7dabf62c6ac7a98@AcuMS.aculab.com>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by casper.infradead.org. See http://www.infradead.org/rpr.html
Precedence: bulk
List-ID: <io-uring.vger.kernel.org>
X-Mailing-List: io-uring@vger.kernel.org

So looking at the various callers I'm not sure this API is the
best.  If we want to do something fancy I'd hide the struct iovec
instances entirely with something like:

struct iov_storage {
	struct iovec stack[UIO_FASTIOV], *vec;
}

int iov_iter_import_iovec(struct iov_iter *iter, struct iov_storage *s,
		const struct iovec __user *vec, unsigned long nr_segs,
		int type);

and then add a new helper to free the thing if needed:

void iov_iter_release_iovec(struct iov_storage *s)
{
	if (s->vec != s->stack)
		kfree(s->vec);
}
