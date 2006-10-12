Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1422780AbWJLHQn@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1422780AbWJLHQn (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 12 Oct 2006 03:16:43 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1422784AbWJLHQn
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 12 Oct 2006 03:16:43 -0400
Received: from mail8.sea5.speakeasy.net ([69.17.117.10]:60631 "EHLO
	mail8.sea5.speakeasy.net") by vger.kernel.org with ESMTP
	id S1422780AbWJLHQm convert rfc822-to-8bit (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 12 Oct 2006 03:16:42 -0400
From: Vadim Lobanov <vlobanov@speakeasy.net>
To: Eric Dumazet <dada1@cosmosbay.com>
Subject: Re: [PATCH] fdtable: Eradicate fdarray overflow.
Date: Thu, 12 Oct 2006 00:16:40 -0700
User-Agent: KMail/1.9.1
Cc: akpm@osdl.org, linux-kernel@vger.kernel.org
References: <200610111958.03238.vlobanov@speakeasy.net> <200610112307.38485.vlobanov@speakeasy.net> <452DE18B.9030701@cosmosbay.com>
In-Reply-To: <452DE18B.9030701@cosmosbay.com>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 8BIT
Content-Disposition: inline
Message-Id: <200610120016.40622.vlobanov@speakeasy.net>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wednesday 11 October 2006 23:32, Eric Dumazet wrote:
> Vadim Lobanov a écrit :
> > On Wednesday 11 October 2006 22:19, Eric Dumazet wrote:
> >> Hi Vadim
> >>
> >> I find your PAGE_SIZE/4 minimum allocation quite unjustified.
> >>
> >> For architectures with 64K PAGE_SIZE, we endup allocating 16K, for poor
> >> tasks that happen to touch a not so high (>= 64) file descriptor...
> >>
> >> I would vote for a fixed size, like 1024
> >
> > In my opinion, always picking 1024 would be highly suboptimal for some
> > architectures (x86-64 in particular -- that's a whole page, just for the
> > fdarray!). If anything, I'd prefer something similar to this pseudo-code:
>
> I was speaking of 1024 bytes.

Oh, well, that does make a difference! :) I misread your email: I thought you 
were suggesting 1024 fdarray entries, not 1024 bytes. I'd agree with you 
completely then.

> That is replace your (PAGE_SIZE/4)  by 1024, wich was you probably meant
> No archi has a smaller page, so no need to play with min_t() macro...

Good point. Code can then simply become:
nr /= (1024 / sizeof(struct file *));
nr = roundup_pow_of_two(nr + 1);
nr *= (1024 / sizeof(struct file *));

> > Let me know what you think. Please don't just go radio-silent on me. ;)
>
> radio-silent ? well, it seems I already sent you many mails about your
> patches :)

Your feedback is very much appreciated, believe me! :) Both you (for the 
ideas) and akpm (for his assistance and seemingly-infinite patience, even 
when I accidentally broke his tree (I owe him a few beers/other-goodies for 
that)) have helped out tremendously with this.

So far, I have two comments from you that I need to take care of:
1) allocate at least L1_CACHE_BYTES for fdsets
2) change PAGE_SIZE/4 to 1024
Both are performance tweaks, not crash fixes, and are easy to do. Could you 
please look through the rest of the code in fs/file.c and point out any other 
issues or code tweaks you can see? My plan is to prepare patches for these 
things and buffer them up, and when we're done tweaking, I'll forward the 
whole batch on to akpm.

Then, once everything has settled down for a long while, I'll send out the 
final fs/file.c cleanups patch -- mostly it introduces extensive comments 
into that file about why the code does what it does.

> Eric

-- Vadim Lobanov
