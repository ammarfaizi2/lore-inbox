Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S272572AbRHaA5W>; Thu, 30 Aug 2001 20:57:22 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S272573AbRHaA5N>; Thu, 30 Aug 2001 20:57:13 -0400
Received: from oboe.it.uc3m.es ([163.117.139.101]:56074 "EHLO oboe.it.uc3m.es")
	by vger.kernel.org with ESMTP id <S272572AbRHaA45>;
	Thu, 30 Aug 2001 20:56:57 -0400
From: "Peter T. Breuer" <ptb@it.uc3m.es>
Message-Id: <200108310057.f7V0vDB14902@oboe.it.uc3m.es>
Subject: Re: [IDEA+RFC] Possible solution for min()/max() war
In-Reply-To: <791753058.999219857@[169.254.198.40]> from "Alex Bligh - linux-kernel"
 at "Aug 31, 2001 01:04:17 am"
To: "Alex Bligh - linux-kernel" <linux-kernel@alex.org.uk>
Date: Fri, 31 Aug 2001 02:57:13 +0200 (MET DST)
CC: "linux kernel" <linux-kernel@vger.kernel.org>
X-Anonymously-To: 
Reply-To: ptb@it.uc3m.es
X-Mailer: ELM [version 2.4ME+ PL66 (25)]
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

"A month of sundays ago Alex Bligh - linux-kernel wrote:"
> I believe your patch is correct & better than the
> 3 arg perversion, (because the diff to 3 args
> can only be worse than the diff to strict
> casting); carry on plugging it.

Can't say that I have an agenda to carry. It just is a fact that
a 3-arg min/max sticks in the craw! And after seeing this discussion
fly past for a week I begin to understand what Linus' aim might be
(and what the technical problem might be, but I don't think that's
as important). And anyone wth access to gcc's info page can see
that gcc extensions are powerful enough to do the extra checking
that Linus wants ... even without working out the details.

Out of the same mild interest, I've counted the following defn's of min
in the kernel headers (2.4.8):

  include/linux/amigaffs.h:#define MIN(a, b) ({           \
  include/linux/cyclomx.h:#define min(a,b) (((a)<(b))?(a):(b))
  include/linux/cycx_drv.h:#define MIN(a,b)       ((a) < (b) ? (a) : (b))
  include/linux/efs_fs.h:#define MIN(a, b) (((a) < (b)) ? (a) : (b))
  include/linux/if_tun.h:#define MIN(a,b) ( (a)<(b) ? (a):(b) ) 
  include/linux/isdn.h:#define MIN(a,b) ((a<b)?a:b)
  include/linux/isicom.h:#define MIN(a, b) ( (a) < (b) ? (a) : (b) )
  include/linux/lvm.h:#define min(a,b) (((a)<(b))?(a):(b))
  include/linux/wanpipe.h:#define min(a,b) (((a)<(b))?(a):(b))

so apparently there wasn't a central definition before? Incidentally,
most of these are vulnerable to double evaluation.

I've modified these (used the macro with asm(."err");) and recompiled ...

 ..no messages from bzImage.

Groove.  Make modules hits paydirt:

  gcc -D__KERNEL__ -I/usr/local/src/linux-2.4.8/include  -Wall
  -Wstrict-prototypes -Wno-trigraphs -O2 -fno-strict-aliasing
  -fno-common -pipe -mpreferred-stack-boundary=2 -march=i686 -DMODULE
  -c -o tun.o tun.c
  {standard input}: Assembler messages:
  {standard input}:633: Error: Unknown pseudo-op:
  `.error_with_min_or_max'
  make[2]: *** [tun.o] Error 1

That's line 270:

          int len = count ...
          ...
          len = MIN(skb->len, len);
          copy_to_user(ptr, skb->data, len);

Well, I assume skb->len is unsigned. But len can be negative at times
..  it causes an error return. But this assignment is in the non-error
path where len >= 0, so it is safe to do unsigned comparisons
and replace this with

          if (len > skb->len)  // len >= 0 guaranteed
              len = skb->len;


There are other errors. I'll leave them to you ...

Peter
