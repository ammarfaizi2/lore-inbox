Return-Path: <io-uring-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4E851C433ED
	for <io-uring@archiver.kernel.org>; Mon,  5 Apr 2021 18:23:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 1B889613A3
	for <io-uring@archiver.kernel.org>; Mon,  5 Apr 2021 18:23:57 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234589AbhDESYC (ORCPT <rfc822;io-uring@archiver.kernel.org>);
        Mon, 5 Apr 2021 14:24:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35460 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232740AbhDESYB (ORCPT
        <rfc822;io-uring@vger.kernel.org>); Mon, 5 Apr 2021 14:24:01 -0400
Received: from zeniv-ca.linux.org.uk (zeniv-ca.linux.org.uk [IPv6:2607:5300:60:148a::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EED7CC061788;
        Mon,  5 Apr 2021 11:23:54 -0700 (PDT)
Received: from viro by zeniv-ca.linux.org.uk with local (Exim 4.94 #2 (Red Hat Linux))
        id 1lTTt7-002nw9-Sh; Mon, 05 Apr 2021 18:23:49 +0000
Date:   Mon, 5 Apr 2021 18:23:49 +0000
From:   Al Viro <viro@zeniv.linux.org.uk>
To:     Christian Brauner <christian.brauner@ubuntu.com>
Cc:     Jens Axboe <axboe@kernel.dk>,
        syzbot <syzbot+c88a7030da47945a3cc3@syzkaller.appspotmail.com>,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
        syzkaller-bugs@googlegroups.com, io-uring@vger.kernel.org
Subject: Re: [syzbot] WARNING in mntput_no_expire (2)
Message-ID: <YGtVtfbYXck3qPRl@zeniv-ca.linux.org.uk>
References: <20210404113445.xo6ntgfpxigcb3x6@wittgenstein>
 <YGnhkoTfVfMSMPpK@zeniv-ca.linux.org.uk>
 <20210404164040.vtxdcfzgliuzghwk@wittgenstein>
 <YGns1iPBHeeMAtn8@zeniv-ca.linux.org.uk>
 <20210404170513.mfl5liccdaxjnpls@wittgenstein>
 <YGoKYktYPA86Qwju@zeniv-ca.linux.org.uk>
 <YGoe0VPs/Qmz/RxC@zeniv-ca.linux.org.uk>
 <20210405114437.hjcojekyp5zt6huu@wittgenstein>
 <YGs4clcRhyoXX8D0@zeniv-ca.linux.org.uk>
 <20210405170801.zrdhnon6g4ggb6c7@wittgenstein>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210405170801.zrdhnon6g4ggb6c7@wittgenstein>
Sender: Al Viro <viro@ftp.linux.org.uk>
Precedence: bulk
List-ID: <io-uring.vger.kernel.org>
X-Mailing-List: io-uring@vger.kernel.org

On Mon, Apr 05, 2021 at 07:08:01PM +0200, Christian Brauner wrote:

> Ah dentry count of -127 looks... odd.

dead + 1...

void lockref_mark_dead(struct lockref *lockref)
{
        assert_spin_locked(&lockref->lock);
	lockref->count = -128;
}

IOW, a leaked (uncounted) reference to dentry, that got dget() called on
it after dentry had been freed.

	IOW, current->fs->pwd.dentry happens to point to an already freed
struct dentry here.  Joy...

	Could you slap

spin_lock(&current->fs->lock);
WARN_ON(d_count(current->fs->pwd.dentry) < 0);
spin_unlock(&current->fs->lock);

before and after calls of io_issue_sqe() and see if it triggers?  We definitely
are seeing buggered dentry refcounting here.
