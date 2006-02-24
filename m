Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932586AbWBXVwE@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932586AbWBXVwE (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 24 Feb 2006 16:52:04 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932588AbWBXVwE
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 24 Feb 2006 16:52:04 -0500
Received: from jade.aracnet.com ([216.99.193.136]:52656 "EHLO
	jade.spiritone.com") by vger.kernel.org with ESMTP id S932586AbWBXVwD
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 24 Feb 2006 16:52:03 -0500
Message-ID: <43FF8005.5070700@BitWagon.com>
Date: Fri, 24 Feb 2006 13:52:05 -0800
From: John Reiser <jreiser@BitWagon.com>
Organization: -
User-Agent: Mozilla Thunderbird 1.0.7-1.1.fc4 (X11/20050929)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Matt Mackall <mpm@selenic.com>
CC: linux-kernel@vger.kernel.org
Subject: Re: [PATCH 5/7] inflate pt1: cleanup Huffman table code
References: <6.399206195@selenic.com>
In-Reply-To: <6.399206195@selenic.com>
X-Enigmail-Version: 0.92.0.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> Index: 2.6.16-rc4-inflate/lib/inflate.c
> ===================================================================
> --- 2.6.16-rc4-inflate.orig/lib/inflate.c	2006-02-22 17:16:07.000000000 -0600
> +++ 2.6.16-rc4-inflate/lib/inflate.c	2006-02-22 17:16:08.000000000 -0600
> @@ -117,12 +117,12 @@
>     an unused code.  If a code with e == 99 is looked up, this implies an
>     error in the data. */
>  struct huft {
> -	u8 e;			/* number of extra bits or operation */
> -	u8 b;			/* number of bits in this code or subcode */
>  	union {
> -		u16 n;		/* literal, length base, or distance base */
> -		struct huft *t;	/* pointer to next level of table */
> -	} v;
> +		u16 val; /* literal, length base, or distance base */
> +		struct huft *next; /* pointer to next level of table */
> +	};
> +	u8 extra; /* number of extra bits or operation */
> +	u8 bits; /* number of bits in this code or subcode */
>  };

How aggressive do you want to be?  About 3.7 years ago in
http://freshmeat.net/projects/gzip_x86/  I published:
-----
typedef unsigned short huft_ndx;  /* index>>1 */
struct huft {
  uch e;                /* number of extra bits or operation */
  uch b;                /* number of bits in this code or subcode */
  union {
    ush n;              /* literal, length base, or distance base */
    huft_ndx t;         /* index>>1 of next level of table */
  } v;
};
-----
which makes 4==sizeof(struct huft) and enables manipulation by 32-bit
fetch, exposing 'e' [extra] and 'b' [bits] in x86 byte registers
for fewer shift-and-mask operations.  The struct huft can be managed
as a stack of maximum length 1014.

-- 
