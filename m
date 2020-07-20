Return-Path: <SRS0=q1Im=A7=vger.kernel.org=io-uring-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.5 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0BBB2C433E1
	for <io-uring@archiver.kernel.org>; Mon, 20 Jul 2020 06:10:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id EA0B221775
	for <io-uring@archiver.kernel.org>; Mon, 20 Jul 2020 06:10:49 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726486AbgGTGKt (ORCPT <rfc822;io-uring@archiver.kernel.org>);
        Mon, 20 Jul 2020 02:10:49 -0400
Received: from verein.lst.de ([213.95.11.211]:45446 "EHLO verein.lst.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725805AbgGTGKt (ORCPT <rfc822;io-uring@vger.kernel.org>);
        Mon, 20 Jul 2020 02:10:49 -0400
Received: by verein.lst.de (Postfix, from userid 2407)
        id EBB6868BFE; Mon, 20 Jul 2020 08:10:46 +0200 (CEST)
Date:   Mon, 20 Jul 2020 08:10:46 +0200
From:   Christoph Hellwig <hch@lst.de>
To:     Jens Axboe <axboe@kernel.dk>
Cc:     linux-arch@vger.kernel.org, linux-api@vger.kernel.org,
        linux-kernel@vger.kernel.org, io-uring@vger.kernel.org
Subject: io_uring vs in_compat_syscall()
Message-ID: <20200720061046.GA10678@lst.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.17 (2007-11-01)
Sender: io-uring-owner@vger.kernel.org
Precedence: bulk
List-ID: <io-uring.vger.kernel.org>
X-Mailing-List: io-uring@vger.kernel.org

Hi Jens,

I just found a (so far theoretical) issue with the io_uring submission
offloading to workqueues or threads.  We have lots of places using
in_compat_syscall() to check if a syscall needs compat treatmenet.
While the biggest users is iocttl(), we also have a fair amount of
places using in_compat_task() in read and write methods, and these
will not do the wrong thing when used with io_uring under certain
conditions.  I'm not sure how to best fix this, except for making sure
in_compat_syscall() returns true one way or another for these cases.
