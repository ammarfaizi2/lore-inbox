Return-Path: <io-uring-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 075E8C4361B
	for <io-uring@archiver.kernel.org>; Wed,  9 Dec 2020 12:06:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id C5F8223B7B
	for <io-uring@archiver.kernel.org>; Wed,  9 Dec 2020 12:06:47 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731303AbgLIMGP (ORCPT <rfc822;io-uring@archiver.kernel.org>);
        Wed, 9 Dec 2020 07:06:15 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42546 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730288AbgLIMGP (ORCPT
        <rfc822;io-uring@vger.kernel.org>); Wed, 9 Dec 2020 07:06:15 -0500
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3F586C0613CF;
        Wed,  9 Dec 2020 04:05:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=5t3oRIaMaC7qwxPcnQux4DtmClUR9K6n75chtZH1BU8=; b=r230O62V7u7Rvgpd0cKLkyUe/K
        ovgQEIRHQd25C33Hkol6I1brBUpaAkemNlaW4op2WydoJnRBR084yBBLWvZkhvyayt4Vq22XMaEFl
        RnU/IeR9cfCar5LMYh4EmWJeA4n5IOEaJNFJQuMwuEtBUxINsJ65qwaAT9TddHoEG7qN0JGkX2PUn
        wATz+ejr+lUQkk1NvRbK9PDMW2Z7RWhz2V3i6W0SL8kN4Oh6tdRiSosswUlRIzLRZBvILKMyq4bLM
        nrqXAyianz2SxmwVfN9PVqznp2wlEIDgya+2l1nGrxYTswq32+IY3LJGS2ZBthrYpM++bIsC4qJIj
        4GQNTdIA==;
Received: from hch by casper.infradead.org with local (Exim 4.92.3 #3 (Red Hat Linux))
        id 1kmyDr-0002nL-Gw; Wed, 09 Dec 2020 12:05:31 +0000
Date:   Wed, 9 Dec 2020 12:05:31 +0000
From:   Christoph Hellwig <hch@infradead.org>
To:     Pavel Begunkov <asml.silence@gmail.com>
Cc:     Christoph Hellwig <hch@infradead.org>,
        Jens Axboe <axboe@kernel.dk>,
        Alexander Viro <viro@zeniv.linux.org.uk>,
        linux-fsdevel@vger.kernel.org, io-uring@vger.kernel.org,
        linux-block@vger.kernel.org, linux-kernel@vger.kernel.org,
        Matthew Wilcox <willy@infradead.org>,
        Johannes Weiner <hannes@cmpxchg.org>,
        Ming Lei <ming.lei@redhat.com>
Subject: Re: [PATCH 2/2] block: no-copy bvec for direct IO
Message-ID: <20201209120531.GA9598@infradead.org>
References: <cover.1607477897.git.asml.silence@gmail.com>
 <51905c4fcb222e14a1d5cb676364c1b4f177f582.1607477897.git.asml.silence@gmail.com>
 <20201209084005.GC21968@infradead.org>
 <63057f61-85e5-4720-3532-1a1ba05ab41a@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <63057f61-85e5-4720-3532-1a1ba05ab41a@gmail.com>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by casper.infradead.org. See http://www.infradead.org/rpr.html
Precedence: bulk
List-ID: <io-uring.vger.kernel.org>
X-Mailing-List: io-uring@vger.kernel.org

On Wed, Dec 09, 2020 at 12:01:27PM +0000, Pavel Begunkov wrote:
> On 09/12/2020 08:40, Christoph Hellwig wrote:
> >> +	/*
> >> +	 * In practice groups of pages tend to be accessed/reclaimed/refaulted
> >> +	 * together. To not go over bvec for those who didn't set BIO_WORKINGSET
> >> +	 * approximate it by looking at the first page and inducing it to the
> >> +	 * whole bio
> >> +	 */
> >> +	if (unlikely(PageWorkingset(iter->bvec->bv_page)))
> >> +		bio_set_flag(bio, BIO_WORKINGSET);
> > 
> > IIRC the feedback was that we do not need to deal with BIO_WORKINGSET
> > at all for direct I/O.
> 
> I was waiting for the conversation to unfold, i.e. for Johannes to
> answer. BTW, would the same (skipping BIO_WORKINGSET) stand true for
> iomap?

iomap direct I/O: yes.
