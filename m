Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129267AbQLODTu>; Thu, 14 Dec 2000 22:19:50 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129257AbQLODTa>; Thu, 14 Dec 2000 22:19:30 -0500
Received: from neon-gw.transmeta.com ([209.10.217.66]:37902 "EHLO
	neon-gw.transmeta.com") by vger.kernel.org with ESMTP
	id <S129314AbQLODTV>; Thu, 14 Dec 2000 22:19:21 -0500
To: linux-kernel@vger.kernel.org
From: torvalds@transmeta.com (Linus Torvalds)
Subject: Re: Test12 ll_rw_block error.
Date: 14 Dec 2000 18:48:45 -0800
Organization: Transmeta Corporation
Message-ID: <91c0qd$10l$1@penguin.transmeta.com>
In-Reply-To: <3A397BA9.CB0EC8E5@thebarn.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

In article <3A397BA9.CB0EC8E5@thebarn.com>,
Russell Cattelan  <cattelan@thebarn.com> wrote:
>This would seem to be an error on the part of ll_rw_block.
>Setting b_end_io to a default handler without checking to see
>a callback has already been defined defeats the purpose of having
>a function op.

No.

It just means that if you have your own function op, you had better not
call "ll_rw_block()".

The problem is that as it was done before, people would set the function
op without actually holding the buffer lock.

Which meant that you could have two unrelated users setting the function
op to two different things, and it would be only a matter of the purest
luck which one happened to "win".

If you want to set your own end-operation, you now need to lock the
buffer _first_, then set "b_end_io" to your operation, and then do a
"submit_bh()". You cannot use ll_rw_block().

Yes, this is different than before. Sorry about that.

But yes, this way actually happens to work reliably.

		Linus
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
