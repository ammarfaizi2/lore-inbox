Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S289046AbSBIRpi>; Sat, 9 Feb 2002 12:45:38 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S289051AbSBIRp2>; Sat, 9 Feb 2002 12:45:28 -0500
Received: from neon-gw-l3.transmeta.com ([63.209.4.196]:47878 "EHLO
	neon-gw.transmeta.com") by vger.kernel.org with ESMTP
	id <S289046AbSBIRpN>; Sat, 9 Feb 2002 12:45:13 -0500
Date: Sat, 9 Feb 2002 11:30:27 -0800 (PST)
From: Linus Torvalds <torvalds@transmeta.com>
To: Hugh Dickins <hugh@veritas.com>
cc: Andrew Morton <akpm@zip.com.au>,
        Marcelo Tosatti <marcelo@conectiva.com.br>,
        "H. Peter Anvin" <hpa@zytor.com>, <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] BUG preserve registers
In-Reply-To: <Pine.LNX.4.21.0202090808390.872-100000@localhost.localdomain>
Message-ID: <Pine.LNX.4.33.0202091124290.8508-100000@home.transmeta.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Sat, 9 Feb 2002, Hugh Dickins wrote:
>
> It's frustrating that when Verbose BUG() reporting is configured,
> info gets lost: fix for i386 below.  This is your area, Andrew:
> please confirm to Marcelo if you'd like him to apply this.
>
> Example: in hpa's recent prune_dcache crash, %eax showed the length of
> the kernel BUG printk, when we'd have liked to see the invalid d_count:
> off-by-one or obviously corrupted?

Don't do it this way.

Instead, put the string printout in the _trap_ handler, and make the
format of BUG() be something like this:

	#ifdef CONFIG_DEBUG_BUGVERBOSE
	#define BUGSTR "\"" __FILE__ "\""
	#else
	#define BUGSTR ""
	#endif

	#define BUG() \
		asm("ud2\n\t.word __LINE__\n\t.asciiz " BUGSTR)

and then have the trap handler print out the pretty-printed version.

The advantage of this is:
 - much smaller footprint even when messages are enabled.
 - no register corruption
 - easily extendible (ie we can put a "bug code" etc, and have the trap
   handler do different things depending on the code)

Ok?

		Linus

