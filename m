Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262413AbUKVVw7@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262413AbUKVVw7 (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 22 Nov 2004 16:52:59 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262415AbUKVVv2
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 22 Nov 2004 16:51:28 -0500
Received: from fw.osdl.org ([65.172.181.6]:40668 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S262347AbUKVVtw (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 22 Nov 2004 16:49:52 -0500
Date: Mon, 22 Nov 2004 13:53:54 -0800
From: Andrew Morton <akpm@osdl.org>
To: Anton Altaparmakov <aia21@cam.ac.uk>
Cc: hirofumi@mail.parknet.co.jp, torvalds@osdl.org,
       linux-kernel@vger.kernel.org
Subject: Re: [RFC][PATCH] problem of cont_prepare_write()
Message-Id: <20041122135354.38feab51.akpm@osdl.org>
In-Reply-To: <1101121403.18623.10.camel@imp.csi.cam.ac.uk>
References: <877joexjk5.fsf@devron.myhome.or.jp>
	<20041122024654.37eb5f3d.akpm@osdl.org>
	<1101121403.18623.10.camel@imp.csi.cam.ac.uk>
X-Mailer: Sylpheed version 0.9.7 (GTK+ 1.2.10; i586-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Anton Altaparmakov <aia21@cam.ac.uk> wrote:
>
> Would it be ok to modify i_size from prepare_write?

I think so - I seem to recall seeing that done somewhere else...

One thing to watch out for is when to bring the page uptodate.  If the page
is uptodate then the read() code just won't try to lock it at all.  If you
increase i_size AND set PG_uptodate too early you could open a window which
allows read() to peek at uninitialised data.

But if you set the page uptodate only when its contents really are sane
then things should work OK.

If you end up doing

	memset(page, 0, N);
	SetPageUptodate(page);

then I think you'll need an smb_wmb() in between so the read() code sees the
above two writes in the correct order.
