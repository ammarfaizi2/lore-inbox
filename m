Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262305AbUKVVpB@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262305AbUKVVpB (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 22 Nov 2004 16:45:01 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262379AbUKVVnX
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 22 Nov 2004 16:43:23 -0500
Received: from fw.osdl.org ([65.172.181.6]:33748 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S262305AbUKVVjc (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 22 Nov 2004 16:39:32 -0500
Date: Mon, 22 Nov 2004 13:43:44 -0800
From: Andrew Morton <akpm@osdl.org>
To: OGAWA Hirofumi <hirofumi@mail.parknet.co.jp>
Cc: torvalds@osdl.org, linux-kernel@vger.kernel.org
Subject: Re: [RFC][PATCH] problem of cont_prepare_write()
Message-Id: <20041122134344.3b2cb489.akpm@osdl.org>
In-Reply-To: <87ekimw1uj.fsf@devron.myhome.or.jp>
References: <877joexjk5.fsf@devron.myhome.or.jp>
	<20041122024654.37eb5f3d.akpm@osdl.org>
	<87ekimw1uj.fsf@devron.myhome.or.jp>
X-Mailer: Sylpheed version 0.9.7 (GTK+ 1.2.10; i586-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

OGAWA Hirofumi <hirofumi@mail.parknet.co.jp> wrote:
>
> Andrew Morton <akpm@osdl.org> writes:
> 
> > Perhaps cont_prepare_write() should look to see if the zerofilled page is
> > outside the current i_size and if so, advance i_size to the end of the
> > zerofilled page prior to releasing the page lock.
> 
> Yes, my first patch was it.

I don't understand what you mean.  Do you mean you tried that approach and
rejected it for some reason?

> Umm... however, if ->i_size is updated before ->commit_write(),
> doesn't it allow access to those pages, before all write() work is
> successful?

That's OK.  A thread which is read()ing that page will either

a) decide that the page is outside i_size, and won't read it anyway or

b) decide that the page is inside i_size and will read the page's contents.

Still, I'd be inclined to update i_size after running ->commit_write.  It
looks like we can simply replace the call to __block_commit_write() with a
call to generic_commit_write().


But none of this has anything to do with truncate, and the patch which you
sent is playing around with the truncate code and appears to be quite
unrelated.  Did you send the correct patch?  If so, what is it designed to
do?

