Return-Path: <SRS0=Bxfd=A2=vger.kernel.org=io-uring-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D50EDC433DF
	for <io-uring@archiver.kernel.org>; Wed, 15 Jul 2020 21:04:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id B5A512067D
	for <io-uring@archiver.kernel.org>; Wed, 15 Jul 2020 21:04:08 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726356AbgGOVEI (ORCPT <rfc822;io-uring@archiver.kernel.org>);
        Wed, 15 Jul 2020 17:04:08 -0400
Received: from relay4-d.mail.gandi.net ([217.70.183.196]:36311 "EHLO
        relay4-d.mail.gandi.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725917AbgGOVEI (ORCPT
        <rfc822;io-uring@vger.kernel.org>); Wed, 15 Jul 2020 17:04:08 -0400
X-Originating-IP: 50.39.163.217
Received: from localhost (50-39-163-217.bvtn.or.frontiernet.net [50.39.163.217])
        (Authenticated sender: josh@joshtriplett.org)
        by relay4-d.mail.gandi.net (Postfix) with ESMTPSA id 83233E0003;
        Wed, 15 Jul 2020 21:04:03 +0000 (UTC)
Date:   Wed, 15 Jul 2020 14:04:01 -0700
From:   josh@joshtriplett.org
To:     bugs@claycon.org
Cc:     axboe@kernel.dk, io-uring@vger.kernel.org, josh@joshtriplett.org
Subject: Re: [WIP PATCH] io_uring: Support opening a file into the fixed-file
 table
Message-ID: <20200715210401.GA351229@localhost>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200715023240.r6wyekihzc2jadpm@ps29521.dreamhostps.com>
Sender: io-uring-owner@vger.kernel.org
Precedence: bulk
List-ID: <io-uring.vger.kernel.org>
X-Mailing-List: io-uring@vger.kernel.org

Clay Harris wrote:
> On Tue, Jul 14 2020 at 14:08:26 -0700, Josh Triplett quoth thus:
> > The other next step would be to add an IORING_OP_CLOSE_FIXED_FILE
> > (separate from the existing CLOSE op) that removes an entry currently in
> > the fixed file table and calls fput on it. (With some care, that
> > *should* be possible even for an entry that was originally registered
> > from a file descriptor.)
>
> I'm curious why you wouldn't use IOSQE_FIXED_FILE here.  I understand
> your reasoning for OPEN_FIXED_FILE, but using the flag with the existing
> CLOSE OP seems like a perfect fit.  To me, this looks like a suboptimal
> precedent that would result in defining a new opcode for every request
> which could accept either a fixed file or process descriptor.

We absolutely could use IORING_OP_CLOSE with IOSQE_FIXED_FILE as the
userspace interface. It would take a bit of refactoring to make that
work, since unlike other cases of IOSQE_FIXED_FILE we don't just want a
struct file in both cases and instead we need the file descriptor (to
close it) in the non-fixed-file case, but I agree that that would make
sense as the userspace interface.
