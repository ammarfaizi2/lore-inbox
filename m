Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261901AbTITPh5 (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 20 Sep 2003 11:37:57 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261905AbTITPh5
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 20 Sep 2003 11:37:57 -0400
Received: from relay1.eltel.net ([195.209.236.38]:52443 "EHLO relay1.eltel.net")
	by vger.kernel.org with ESMTP id S261901AbTITPhz (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 20 Sep 2003 11:37:55 -0400
Date: Sat, 20 Sep 2003 19:36:26 +0400
From: Andrew Zabolotny <zap@homelink.ru>
To: Jens Axboe <axboe@suse.de>
Cc: linux-kernel@vger.kernel.org
Subject: __make_request() bug and a fix variant
Message-Id: <20030920193626.31d2b8f5.zap@homelink.ru>
In-Reply-To: <20030920113737.GQ21870@suse.de>
References: <20030919231732.7f7874e6.zap@homelink.ru>
	<20030920113737.GQ21870@suse.de>
Organization: =?ISO-8859-1?Q?=20=E4=CF=CD?=
X-Mailer: Sylpheed version 0.8.2 (GTK+ 1.2.10; i386-redhat-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 20 Sep 2003 13:37:37 +0200
Jens Axboe <axboe@suse.de> wrote:

> I dunno if you were the one posting this issue here some months ago?
No, it wasn't me :-)

> Show me a regular kernel path that passes invalid b_reqnext to
> __make_request? That would be a bug, indeed, but I've never heard of
> such a bug. Most likely it's a bug in your driver, not initialising
> b_reqnext.
I have been calling bread() which was causing me troubles. bread does
not accept a buffer_head from outside, it gets a new one and returns it.
So I don't have any control over b_reqnext field - the bug happens
inside bread() between these lines:

bh = getblk(dev, block, size);
/* here bh_reqnext is already junk. In fact, I partially solved this
   problem by making my own clone of bread() and setting b_reqnext
   to NULL right here. But unfortunately, there is no guarantee we'll
   fix all invalid buffer_heads - maybe some remain in the pool and
   will be returned to other innocent drivers requesting them. */
if (buffer_uptodate(bh))
	return bh;
/* and now ll_rw_block will try to merge the bh with those already in
   the queue, and if it will take the ELEVATOR_NO_MERGE path, bh_reqnext
   will still remain junk. */
ll_rw_block(READ, 1, &bh);

> You can see the initialisor for buffer_heads is
> init_buffer_head, which memsets the entire buffer_head. When a
> buffer_head is detached from the request list, b_reqnext is cleared
> too.
Ah, so I was correct that __make_request expects b_reqnext to be already
set to NULL. In this case the bug should be somewhere else - in some
code that returns buffer_head's back to the pool of buffers.

Interesting that right before the driver crashes in bread() I call
grok_partitions. I think the bug is somewhere there. I will do a new
debug session at Monday (the code that breaks is at work), so I will
post new details if I find any.

--
Greetings,
   Andrew
