Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S284933AbSBITgL>; Sat, 9 Feb 2002 14:36:11 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S285023AbSBITfv>; Sat, 9 Feb 2002 14:35:51 -0500
Received: from parcelfarce.linux.theplanet.co.uk ([195.92.249.252]:24843 "EHLO
	www.linux.org.uk") by vger.kernel.org with ESMTP id <S284933AbSBITfn>;
	Sat, 9 Feb 2002 14:35:43 -0500
Message-ID: <3C6579DB.E93DAD92@zip.com.au>
Date: Sat, 09 Feb 2002 11:34:51 -0800
From: Andrew Morton <akpm@zip.com.au>
X-Mailer: Mozilla 4.77 [en] (X11; U; Linux 2.4.18-pre9 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: Linus Torvalds <torvalds@transmeta.com>
CC: Hugh Dickins <hugh@veritas.com>,
        Marcelo Tosatti <marcelo@conectiva.com.br>,
        "H. Peter Anvin" <hpa@zytor.com>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] BUG preserve registers
In-Reply-To: <Pine.LNX.4.21.0202090808390.872-100000@localhost.localdomain> <Pine.LNX.4.33.0202091124290.8508-100000@home.transmeta.com>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Linus Torvalds wrote:
> 
> On Sat, 9 Feb 2002, Hugh Dickins wrote:
> >
> > It's frustrating that when Verbose BUG() reporting is configured,
> > info gets lost: fix for i386 below.  This is your area, Andrew:
> > please confirm to Marcelo if you'd like him to apply this.
> >
> > Example: in hpa's recent prune_dcache crash, %eax showed the length of
> > the kernel BUG printk, when we'd have liked to see the invalid d_count:
> > off-by-one or obviously corrupted?
> 
> Don't do it this way.
> 
> Instead, put the string printout in the _trap_ handler, and make the
> format of BUG() be something like this:
> 
>         #ifdef CONFIG_DEBUG_BUGVERBOSE
>         #define BUGSTR "\"" __FILE__ "\""
>         #else
>         #define BUGSTR ""
>         #endif
> 
>         #define BUG() \
>                 asm("ud2\n\t.word __LINE__\n\t.asciiz " BUGSTR)
> 

Is better, except the filename gets expanded multipe times into
the object file.  How about:

#define BUG()                   \
        asm(    "ud2\n"         \
                "\t.word %0\n"  \
                "\t.long %1\n"  \
                 : : "i" (__LINE__), "i" (__FILE__))

void erp(void)
{
        if (c())
                BUG();
        if (d())
                BUG();
}

-
