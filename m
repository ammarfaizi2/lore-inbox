Return-Path: <io-uring-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E9A1CC433DB
	for <io-uring@archiver.kernel.org>; Sun, 24 Jan 2021 02:57:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id B6159229CA
	for <io-uring@archiver.kernel.org>; Sun, 24 Jan 2021 02:57:20 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726412AbhAXC5D (ORCPT <rfc822;io-uring@archiver.kernel.org>);
        Sat, 23 Jan 2021 21:57:03 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40906 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725943AbhAXC5D (ORCPT
        <rfc822;io-uring@vger.kernel.org>); Sat, 23 Jan 2021 21:57:03 -0500
X-Greylist: delayed 3421 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Sat, 23 Jan 2021 18:56:23 PST
Received: from zeniv-ca.linux.org.uk (zeniv-ca.linux.org.uk [IPv6:2607:5300:60:148a::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 159C4C0613D6;
        Sat, 23 Jan 2021 18:56:23 -0800 (PST)
Received: from viro by zeniv-ca.linux.org.uk with local (Exim 4.94 #2 (Red Hat Linux))
        id 1l3UgD-005Cgl-3r; Sun, 24 Jan 2021 01:59:05 +0000
Date:   Sun, 24 Jan 2021 01:59:05 +0000
From:   Al Viro <viro@zeniv.linux.org.uk>
To:     Andres Freund <andres@anarazel.de>
Cc:     Lennert Buytenhek <buytenh@wantstofly.org>,
        Jens Axboe <axboe@kernel.dk>, linux-kernel@vger.kernel.org,
        io-uring@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        linux-btrfs@vger.kernel.org
Subject: Re: [RFC PATCH] io_uring: add support for IORING_OP_GETDENTS64
Message-ID: <20210124015905.GH740243@zeniv-ca>
References: <20210123114152.GA120281@wantstofly.org>
 <20210123235055.azmz5jm2lwyujygc@alap3.anarazel.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210123235055.azmz5jm2lwyujygc@alap3.anarazel.de>
Sender: Al Viro <viro@ftp.linux.org.uk>
Precedence: bulk
List-ID: <io-uring.vger.kernel.org>
X-Mailing-List: io-uring@vger.kernel.org

On Sat, Jan 23, 2021 at 03:50:55PM -0800, Andres Freund wrote:

> As there's only a shared lock, seems like both would end up with the
> same ctx->pos and end up updating f_pos to the same offset (assuming the
> same count).
> 
> Am I missing something?

This:
        f = fdget_pos(fd);
        if (!f.file)
                return -EBADF;
in the callers.  Protection of struct file contents belongs to struct file,
*not* struct inode.  Specifically, file->f_pos_lock.  *IF* struct file
in question happens to be shared and the file is a regular or directory
(sockets don't need any exclusion on read(2), etc.)
