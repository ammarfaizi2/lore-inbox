Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S313156AbSC1Nqc>; Thu, 28 Mar 2002 08:46:32 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S313157AbSC1NqW>; Thu, 28 Mar 2002 08:46:22 -0500
Received: from pc132.utati.net ([216.143.22.132]:31889 "HELO
	merlin.webofficenow.com") by vger.kernel.org with SMTP
	id <S313156AbSC1NqR>; Thu, 28 Mar 2002 08:46:17 -0500
Content-Type: text/plain; charset=US-ASCII
From: Rob Landley <landley@trommello.org>
To: Brian Gerst <bgerst@didntduck.org>
Subject: Re: [patch] ext2_fill_super breakage
Date: Thu, 28 Mar 2002 08:46:21 -0500
X-Mailer: KMail [version 1.3.1]
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <3CA2C68E.5B8C4176@zip.com.au> <3CA31BF6.7030609@didntduck.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Message-Id: <20020328140113.B96BE4FF@merlin.webofficenow.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thursday 28 March 2002 08:34 am, Brian Gerst wrote:
> Andrew Morton wrote:
> > In 2.5.7 there is a thinko in the allocation and initialisation
> > of the fs-private superblock for ext2.  It's passing the wrong type
> > to the sizeof operator (which of course gives the wrong size)
> > when allocating and clearing the memory.
> >
> > Lesson for the day: this is one of the reasons why this idiom:
> >
> > 	some_type *p;
> >
> > 	p = malloc(sizeof(*p));
> > 	...
> > 	memset(p, 0, sizeof(*p));
> >
> > is preferable to
> >
> > 	some_type *p;
> >
> > 	p = malloc(sizeof(some_type));
> > 	...
> > 	memset(p, 0, sizeof(some_type));
> >
> > I checked the other filesystems.  They're OK (but idiomatically
> > impure).  I've added a couple of defensive memsets where
> > they were missing.
>
> I'm not sure I follow you here.  Compiling this code (gcc 2.96):
>
> int foo1(void) { return sizeof(struct ext2_sb_info); }
> int foo2(struct ext2_sb_info *sbi) { return sizeof(*sbi); }
>
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

If you take the sizeof based on the type of the actual variable is using, 
you're guaranteed to get the right result.  (The type information is only in 
one place, so what the compiler's using and what you're reserving space for 
have to be the same thing.)

If you sizeof( ) the type and declare the type of the variable seperately, 
you have the possibility of version skew between them.  The sizeof( ) and the 
variable declaration itself may not match.  Hence bugs.

Rob
