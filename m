Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S313153AbSC1NgJ>; Thu, 28 Mar 2002 08:36:09 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S313156AbSC1NgA>; Thu, 28 Mar 2002 08:36:00 -0500
Received: from rwcrmhc52.attbi.com ([216.148.227.88]:58287 "EHLO
	rwcrmhc52.attbi.com") by vger.kernel.org with ESMTP
	id <S313153AbSC1Nfn>; Thu, 28 Mar 2002 08:35:43 -0500
Message-ID: <3CA31BF6.7030609@didntduck.org>
Date: Thu, 28 Mar 2002 08:34:46 -0500
From: Brian Gerst <bgerst@didntduck.org>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:0.9.9) Gecko/20020311
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Andrew Morton <akpm@zip.com.au>
CC: linux-kernel@vger.kernel.org, Linus Torvalds <torvalds@transmeta.com>
Subject: Re: [patch] ext2_fill_super breakage
In-Reply-To: <3CA2C68E.5B8C4176@zip.com.au>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Andrew Morton wrote:
> In 2.5.7 there is a thinko in the allocation and initialisation
> of the fs-private superblock for ext2.  It's passing the wrong type
> to the sizeof operator (which of course gives the wrong size)
> when allocating and clearing the memory. 
> 
> Lesson for the day: this is one of the reasons why this idiom:
> 
> 	some_type *p;
> 
> 	p = malloc(sizeof(*p));
> 	...
> 	memset(p, 0, sizeof(*p));
> 
> is preferable to
> 
> 	some_type *p;
> 
> 	p = malloc(sizeof(some_type));
> 	...
> 	memset(p, 0, sizeof(some_type));
> 
> I checked the other filesystems.  They're OK (but idiomatically
> impure).  I've added a couple of defensive memsets where
> they were missing.

I'm not sure I follow you here.  Compiling this code (gcc 2.96):

int foo1(void) { return sizeof(struct ext2_sb_info); }
int foo2(struct ext2_sb_info *sbi) { return sizeof(*sbi); }

yields:

00000b70 <foo1>:
      b70:       b8 dc 00 00 00          mov    $0xdc,%eax
      b75:       c3                      ret

00000b80 <foo2>:
      b80:       b8 dc 00 00 00          mov    $0xdc,%eax
      b85:       c3                      ret

The sizes are the same, so unless it makes a difference with another 
version of gcc then this is just a cosmetic change.

-- 

						Brian Gerst

