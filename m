Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751113AbWABW4f@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751113AbWABW4f (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 2 Jan 2006 17:56:35 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751120AbWABW4f
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 2 Jan 2006 17:56:35 -0500
Received: from pentafluge.infradead.org ([213.146.154.40]:9864 "EHLO
	pentafluge.infradead.org") by vger.kernel.org with ESMTP
	id S1751113AbWABW4f (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 2 Jan 2006 17:56:35 -0500
Subject: Re: [patch 00/2] improve .text size on gcc 4.0 and newer compilers
From: Arjan van de Ven <arjan@infradead.org>
To: Antonio Vargas <windenntw@gmail.com>
Cc: gcoady@gmail.com, Andrew Morton <akpm@osdl.org>,
       Adrian Bunk <bunk@stusta.de>, mingo@elte.hu, tim@physik3.uni-rostock.de,
       torvalds@osdl.org, davej@redhat.com, linux-kernel@vger.kernel.org,
       mpm@selenic.com
In-Reply-To: <69304d110601021403o59a10c77i3d9ef8dc046e27bd@mail.gmail.com>
References: <20051229224839.GA12247@elte.hu>
	 <20051230074916.GC25637@elte.hu> <20051231143800.GJ3811@stusta.de>
	 <20051231144534.GA5826@elte.hu> <20051231150831.GL3811@stusta.de>
	 <20060102103721.GA8701@elte.hu> <20060102134228.GC17398@stusta.de>
	 <20060102102824.4c7ff9ad.akpm@osdl.org>
	 <1136227746.2936.46.camel@laptopd505.fenrus.org>
	 <sq7jr1l1ffgdc5ra26ra6n2ota7osj9c2q@4ax.com>
	 <69304d110601021403o59a10c77i3d9ef8dc046e27bd@mail.gmail.com>
Content-Type: text/plain
Date: Mon, 02 Jan 2006 23:56:23 +0100
Message-Id: <1136242584.2839.1.camel@laptopd505.fenrus.org>
Mime-Version: 1.0
X-Mailer: Evolution 2.2.3 (2.2.3-2.fc4) 
Content-Transfer-Encoding: 7bit
X-Spam-Score: -2.8 (--)
X-Spam-Report: SpamAssassin version 3.0.4 on pentafluge.infradead.org summary:
	Content analysis details:   (-2.8 points, 5.0 required)
	pts rule name              description
	---- ---------------------- --------------------------------------------------
	-2.8 ALL_TRUSTED            Did not pass through any untrusted hosts
X-SRS-Rewrite: SMTP reverse-path rewritten from <arjan@infradead.org> by pentafluge.infradead.org
	See http://www.infradead.org/rpr.html
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


> > Are these typical targets for non-inline?

these are very simple 1 line things, and are the cases where inline is
just fine. The problem cases are the ones with a whole lot more than
that though, say 3 or more real code lines with things like loops or
udelays or ... There's 50+ line functions marked "inline". Those are the
"bad guys" not so much the simple 1 liners

> 
> according to the latest flamewars, maybe it would be better
> to just turn the #defines into static functions instead on static inlines...
> guess even better would be to just get CodingStyle fixed ASAP ;)

I proposed the following chunks:

Adds a bit of text to Documentation/Codingstyle to state that
inlining everything "just because" is a bad idea

Signed-off-by: Arjan van de Ven <arjan@infradead.org>

diff -purN linux-2.6.15-rc6/Documentation/CodingStyle linux-2.6.15-rc6-deinline/Documentation/CodingStyle
--- linux-2.6.15-rc6/Documentation/CodingStyle	2005-10-28 02:02:08.000000000 +0200
+++ linux-2.6.15-rc6-deinline/Documentation/CodingStyle	2005-12-30 13:31:13.000000000 +0100
@@ -344,7 +344,7 @@ Remember: if another thread can find you
 have a reference count on it, you almost certainly have a bug.
 
 
-		Chapter 11: Macros, Enums, Inline functions and RTL
+		Chapter 11: Macros, Enums and RTL
 
 Names of macros defining constants and labels in enums are capitalized.
 
@@ -429,7 +429,35 @@ from void pointer to any other pointer t
 language.
 
 
-		Chapter 14: References
+		Chapter 14: The inline disease
+
+There appears to be a common misperception that gcc has a magic "make me
+faster" ricing option called "inline". While the use of inlines can be
+appropriate (for example as a means of replacing macros, see Chapter 11), it
+very often is not. Abundant use of the inline keyword leads to a much bigger
+kernel, which in turn slows the system as a whole down, due to a bigger
+icache footprint for the CPU and simply because there is less memory
+available for the pagecache. Just think about it; a pagecache miss causes a
+disk seek, which easily takes 5 miliseconds. There are a LOT of cpu cycles
+that can go into these 5 miliseconds.
+
+A reasonable rule of thumb is to not put inline at functions that have more
+than 3 lines of code in them. An exception to this rule are the cases where
+a parameter is known to be a compiletime constant, and as a result of this
+constantness you *know* the compiler will be able to optimize most of your
+function away at compile time. For a good example of this later case, see
+the kmalloc() inline function.
+
+Often people argue that adding inline to functions that are static and used
+only once is always a win since there is no space tradeoff. While this is
+technically correct, gcc is capable of inlining these automatically without
+help, and the maintenance issue of removing the inline when a second user
+appears outweighs the potential value of the hint that tells gcc to do
+something it would have done anyway.
+
+
+
+		Chapter 15: References
 
 The C Programming Language, Second Edition
 by Brian W. Kernighan and Dennis M. Ritchie.
@@ -450,4 +478,4 @@ WG14 is the international standardizatio
 language C, URL: http://std.dkuug.dk/JTC1/SC22/WG14/
 
 --
-Last updated on 16 February 2004 by a community effort on LKML.
+Last updated on 30 December 2005 by a community effort on LKML.


