Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S276329AbRI1V6c>; Fri, 28 Sep 2001 17:58:32 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S276335AbRI1V6W>; Fri, 28 Sep 2001 17:58:22 -0400
Received: from neon-gw-l3.transmeta.com ([63.209.4.196]:58898 "EHLO
	neon-gw.transmeta.com") by vger.kernel.org with ESMTP
	id <S276333AbRI1V6D>; Fri, 28 Sep 2001 17:58:03 -0400
Date: Fri, 28 Sep 2001 14:58:07 -0700 (PDT)
From: Linus Torvalds <torvalds@transmeta.com>
To: Marcelo Tosatti <marcelo@conectiva.com.br>
cc: Andrea Arcangeli <andrea@suse.de>, lkml <linux-kernel@vger.kernel.org>
Subject: Re: 2.4.10 does not set accessed bit for readahead pages
In-Reply-To: <Pine.LNX.4.21.0109281506430.3230-100000@freak.distro.conectiva>
Message-ID: <Pine.LNX.4.33.0109281455050.4008-100000@penguin.transmeta.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


On Fri, 28 Sep 2001, Marcelo Tosatti wrote:
>
> I've done some experiments in the past trying to use a new GFP_ flag for
> allocation of readahead pages. This new GFP flag was the indicator to
> __alloc_pages() that it should fail very easily (so, in theory, we would
> not spend time on page reclaiming for readahead, which is simply a guess).

I don't think the above has anything to do with the accessed bit.

The fact is, failing very easily will mean that we never do much
read-ahead at all, or will mean that _other_ allocations will have to bear
more of the grunt of the work, and that the LRU lists just become
unbalanced. I doubt that the fact that your GFP experiments back up
touching the accessed bit.

However, if somebody has benchmarks comparing apples to apples (ie
comparing _just_ setting/notsetting the accessed bit), that would be very
interesting.

Not setting the accessed bit means that the read-ahead has to be useful
within "one loop" of the inactive list. I think that's the right thing: if
we don't actually touch the pages soon, the read-ahead was probably a
loss. And it's better to cut your losses early rather than late.

		Linus

