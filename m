Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S313189AbSC1RaC>; Thu, 28 Mar 2002 12:30:02 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S313191AbSC1R3z>; Thu, 28 Mar 2002 12:29:55 -0500
Received: from parcelfarce.linux.theplanet.co.uk ([195.92.249.252]:56333 "EHLO
	www.linux.org.uk") by vger.kernel.org with ESMTP id <S313189AbSC1R3j>;
	Thu, 28 Mar 2002 12:29:39 -0500
Message-ID: <3CA3529E.80E70428@zip.com.au>
Date: Thu, 28 Mar 2002 09:27:58 -0800
From: Andrew Morton <akpm@zip.com.au>
X-Mailer: Mozilla 4.79 [en] (X11; U; Linux 2.4.19-pre4 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: Brian Gerst <bgerst@didntduck.org>
CC: linux-kernel@vger.kernel.org, Linus Torvalds <torvalds@transmeta.com>
Subject: Re: [patch] ext2_fill_super breakage
In-Reply-To: <3CA2C68E.5B8C4176@zip.com.au> <3CA31BF6.7030609@didntduck.org>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Brian Gerst wrote:
> 
> Andrew Morton wrote:
> > In 2.5.7 there is a thinko in the allocation and initialisation
> > of the fs-private superblock for ext2.  It's passing the wrong type
> > to the sizeof operator (which of course gives the wrong size)
> > when allocating and clearing the memory.
> >
> > Lesson for the day: this is one of the reasons why this idiom:
> >
> >       some_type *p;
> >
> >       p = malloc(sizeof(*p));
> >       ...
> >       memset(p, 0, sizeof(*p));
> >
> > is preferable to
> >
> >       some_type *p;
> >
> >       p = malloc(sizeof(some_type));
> >       ...
> >       memset(p, 0, sizeof(some_type));
> >
> > I checked the other filesystems.  They're OK (but idiomatically
> > impure).  I've added a couple of defensive memsets where
> > they were missing.
> 
> I'm not sure I follow you here.  Compiling this code (gcc 2.96):
> 
> int foo1(void) { return sizeof(struct ext2_sb_info); }
> int foo2(struct ext2_sb_info *sbi) { return sizeof(*sbi); }

The current code is using sizeof(ext2_super_block) for
something which is of type ext2_sb_info.

> yields:
> 
> 00000b70 <foo1>:
>       b70:       b8 dc 00 00 00          mov    $0xdc,%eax
>       b75:       c3                      ret
> 
> 00000b80 <foo2>:
>       b80:       b8 dc 00 00 00          mov    $0xdc,%eax
>       b85:       c3                      ret
> 
> The sizes are the same, so unless it makes a difference with another
> version of gcc then this is just a cosmetic change.

The stylistic change tends to provide insulation from the
above bug.

-
