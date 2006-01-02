Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751122AbWABXKn@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751122AbWABXKn (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 2 Jan 2006 18:10:43 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751124AbWABXKn
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 2 Jan 2006 18:10:43 -0500
Received: from relay01.mail-hub.dodo.com.au ([203.220.32.149]:53965 "EHLO
	relay01.mail-hub.dodo.com.au") by vger.kernel.org with ESMTP
	id S1751122AbWABXKn (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 2 Jan 2006 18:10:43 -0500
From: Grant Coady <grant_lkml@dodo.com.au>
To: Arjan van de Ven <arjan@infradead.org>
Cc: Antonio Vargas <windenntw@gmail.com>, gcoady@gmail.com,
       Andrew Morton <akpm@osdl.org>, Adrian Bunk <bunk@stusta.de>,
       mingo@elte.hu, tim@physik3.uni-rostock.de, torvalds@osdl.org,
       davej@redhat.com, linux-kernel@vger.kernel.org, mpm@selenic.com
Subject: Re: [patch 00/2] improve .text size on gcc 4.0 and newer compilers
Date: Tue, 03 Jan 2006 10:10:37 +1100
Organization: http://bugsplatter.mine.nu/
Reply-To: gcoady@gmail.com
Message-ID: <micjr1lipg2puqbtsocicc37vtfcjbu1jk@4ax.com>
References: <20051229224839.GA12247@elte.hu> <20051230074916.GC25637@elte.hu> <20051231143800.GJ3811@stusta.de> <20051231144534.GA5826@elte.hu> <20051231150831.GL3811@stusta.de> <20060102103721.GA8701@elte.hu> <20060102134228.GC17398@stusta.de> <20060102102824.4c7ff9ad.akpm@osdl.org> <1136227746.2936.46.camel@laptopd505.fenrus.org> <sq7jr1l1ffgdc5ra26ra6n2ota7osj9c2q@4ax.com> <69304d110601021403o59a10c77i3d9ef8dc046e27bd@mail.gmail.com> <1136242584.2839.1.camel@laptopd505.fenrus.org>
In-Reply-To: <1136242584.2839.1.camel@laptopd505.fenrus.org>
X-Mailer: Forte Agent 2.0/32.652
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 02 Jan 2006 23:56:23 +0100, Arjan van de Ven <arjan@infradead.org> wrote:

>I proposed the following chunks:
>
>Adds a bit of text to Documentation/Codingstyle to state that
>inlining everything "just because" is a bad idea
>
>Signed-off-by: Arjan van de Ven <arjan@infradead.org>
>
>diff -purN linux-2.6.15-rc6/Documentation/CodingStyle linux-2.6.15-rc6-deinline/Documentation/CodingStyle
>--- linux-2.6.15-rc6/Documentation/CodingStyle	2005-10-28 02:02:08.000000000 +0200
>+++ linux-2.6.15-rc6-deinline/Documentation/CodingStyle	2005-12-30 13:31:13.000000000 +0100
>@@ -344,7 +344,7 @@ Remember: if another thread can find you
> have a reference count on it, you almost certainly have a bug.
> 
> 
>-		Chapter 11: Macros, Enums, Inline functions and RTL
>+		Chapter 11: Macros, Enums and RTL
> 
> Names of macros defining constants and labels in enums are capitalized.
> 
>@@ -429,7 +429,35 @@ from void pointer to any other pointer t
> language.
> 
> 
>-		Chapter 14: References
>+		Chapter 14: The inline disease
>+
>+There appears to be a common misperception that gcc has a magic "make me
>+faster" ricing option called "inline". While the use of inlines can be
          ^^^^^^--?? not sure what this is
>+appropriate (for example as a means of replacing macros, see Chapter 11), it
>+very often is not. Abundant use of the inline keyword leads to a much bigger
>+kernel, which in turn slows the system as a whole down, due to a bigger
>+icache footprint for the CPU and simply because there is less memory
>+available for the pagecache. Just think about it; a pagecache miss causes a
>+disk seek, which easily takes 5 miliseconds. There are a LOT of cpu cycles
>+that can go into these 5 miliseconds.
>+
>+A reasonable rule of thumb is to not put inline at functions that have more
>+than 3 lines of code in them. An exception to this rule are the cases where
>+a parameter is known to be a compiletime constant, and as a result of this
>+constantness you *know* the compiler will be able to optimize most of your
>+function away at compile time. For a good example of this later case, see
>+the kmalloc() inline function.
>+
>+Often people argue that adding inline to functions that are static and used
>+only once is always a win since there is no space tradeoff. While this is
>+technically correct, gcc is capable of inlining these automatically without
>+help, and the maintenance issue of removing the inline when a second user
>+appears outweighs the potential value of the hint that tells gcc to do
>+something it would have done anyway.

Seems sane, reasonable and mostly readable to me, thank you.

Grant.
