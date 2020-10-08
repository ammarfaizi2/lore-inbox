Return-Path: <SRS0=T8Kb=DP=vger.kernel.org=io-uring-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 30067C4363A
	for <io-uring@archiver.kernel.org>; Thu,  8 Oct 2020 15:05:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id BE5A820782
	for <io-uring@archiver.kernel.org>; Thu,  8 Oct 2020 15:05:22 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="iBYGMRJI"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730685AbgJHPFW (ORCPT <rfc822;io-uring@archiver.kernel.org>);
        Thu, 8 Oct 2020 11:05:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33966 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729833AbgJHPFW (ORCPT
        <rfc822;io-uring@vger.kernel.org>); Thu, 8 Oct 2020 11:05:22 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 23D83C061755;
        Thu,  8 Oct 2020 08:05:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=EhbowcTrL1buMO0T3pEwyAVDuwOGAjjdNpotKY8+ZUA=; b=iBYGMRJIa2jBx5pxH+rbv6r7iX
        N78Er1ccrRahID+u+RL0aFoBhpxxe1XqbT3XGkZxS7TwTz2l4MYZXJ7WhpuHWAey29juNNvi+E25u
        oqM3V+5dhcHDEjIVP94X+anxx6bk3iYLiYXK2LdFlZrnKgdCck8eS2ZPAW1nQPetkTXkfZE511rWx
        I6LjJW1vljgmJ1kfyKhBMOfXUMcB96ZUfWkUJL27E4uCvrhcHeMtYNl72iFcgtgt3dXUC/OCTn/sF
        o/UO7QlqP9isHhqfuH4KYkrVGh6zjxt7wx481vIUQOmbqIG7/DkVHt3xzf50/CUBbfExdoM640pTA
        yfA421LQ==;
Received: from willy by casper.infradead.org with local (Exim 4.92.3 #3 (Red Hat Linux))
        id 1kQXTq-0006pi-Ap; Thu, 08 Oct 2020 15:05:18 +0000
Date:   Thu, 8 Oct 2020 16:05:18 +0100
From:   Matthew Wilcox <willy@infradead.org>
To:     Jens Axboe <axboe@kernel.dk>
Cc:     syzbot <syzbot+cdcbdc0bd42e559b52b9@syzkaller.appspotmail.com>,
        io-uring@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        linux-kernel@vger.kernel.org, syzkaller-bugs@googlegroups.com,
        viro@zeniv.linux.org.uk
Subject: Re: inconsistent lock state in xa_destroy
Message-ID: <20201008150518.GG20115@casper.infradead.org>
References: <00000000000045ac4605b12a1720@google.com>
 <de842e7f-fa50-193b-b1d7-c573e515ef8b@kernel.dk>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <de842e7f-fa50-193b-b1d7-c573e515ef8b@kernel.dk>
Precedence: bulk
List-ID: <io-uring.vger.kernel.org>
X-Mailing-List: io-uring@vger.kernel.org

On Thu, Oct 08, 2020 at 09:01:57AM -0600, Jens Axboe wrote:
> On 10/8/20 9:00 AM, syzbot wrote:
> > Hello,
> > 
> > syzbot found the following issue on:
> > 
> > HEAD commit:    e4fb79c7 Add linux-next specific files for 20201008
> > git tree:       linux-next
> > console output: https://syzkaller.appspot.com/x/log.txt?x=12555227900000
> > kernel config:  https://syzkaller.appspot.com/x/.config?x=568d41fe4341ed0f
> > dashboard link: https://syzkaller.appspot.com/bug?extid=cdcbdc0bd42e559b52b9
> > compiler:       gcc (GCC) 10.1.0-syz 20200507
> > 
> > Unfortunately, I don't have any reproducer for this issue yet.
> > 
> > IMPORTANT: if you fix the issue, please add the following tag to the commit:
> > Reported-by: syzbot+cdcbdc0bd42e559b52b9@syzkaller.appspotmail.com
> 
> Already pushed out a fix for this, it's really an xarray issue where it just
> assumes that destroy can irq grab the lock.

... nice of you to report the issue to the XArray maintainer.
