Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261624AbTIXTiS (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 24 Sep 2003 15:38:18 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261628AbTIXTiS
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 24 Sep 2003 15:38:18 -0400
Received: from relay1.eltel.net ([195.209.236.38]:5544 "EHLO relay1.eltel.net")
	by vger.kernel.org with ESMTP id S261624AbTIXTiR (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 24 Sep 2003 15:38:17 -0400
Date: Wed, 24 Sep 2003 23:37:08 +0400
From: Andrew Zabolotny <zap@homelink.ru>
To: Jens Axboe <axboe@suse.de>
Cc: linux-kernel@vger.kernel.org
Subject: Re: __make_request() bug and a fix variant
Message-Id: <20030924233708.39ffc921.zap@homelink.ru>
In-Reply-To: <20030920113737.GQ21870@suse.de>
References: <20030919231732.7f7874e6.zap@homelink.ru>
	<20030920113737.GQ21870@suse.de>
Organization: home
X-Mailer: Sylpheed version 0.9.6 (GTK+ 1.2.10; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 20 Sep 2003 13:37:37 +0200
Jens Axboe <axboe@suse.de> wrote:

> You can see the initialisor for buffer_heads is
> init_buffer_head, which memsets the entire buffer_head. When a
> buffer_head is detached from the request list, b_reqnext is cleared
> too.
I did some more research on this subject. Indeed, I was wrong. The
problem is that when you acquire a buffer_head by calling
kmem_cache_alloc and you return it with kmem_cache_free the returned
buffer can be filled with any garbage *except* the b_reqnext field
which *should* be set to NULL, otherwise the next driver who'll get this
buffer_head will most probably crash.

Not that relying on this field being NULL is a bad practice (because
in kernel performance is top priority), but it's not clean (and
nowhere mentioned - even in the source code). So I think it would be a
Good Thing{tm} to mention somewhere(say at least in buffers.c before
put_unused_buffer_head) that before returning a buffer to the common
pool you should ensure that b_reqnext is NULL (although it is not
related only to put_unused_buffer_head but to kmem_cache_free as well -
but the later is not related to buffer_head's:).

Sorry for borrowed time and thank very much for assistance.

--
Greetings,
   Andrew
