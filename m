Return-Path: <linux-kernel-owner+willy=40w.ods.org-S263687AbUFRVHe@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263687AbUFRVHe (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 18 Jun 2004 17:07:34 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263126AbUFRVGU
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 18 Jun 2004 17:06:20 -0400
Received: from fw.osdl.org ([65.172.181.6]:26560 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S262085AbUFRU6n (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 18 Jun 2004 16:58:43 -0400
Date: Fri, 18 Jun 2004 13:58:02 -0700 (PDT)
From: Linus Torvalds <torvalds@osdl.org>
To: Geert Uytterhoeven <geert@linux-m68k.org>
cc: Linux/m68k <linux-m68k@lists.linux-m68k.org>,
       Linux Kernel Development <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] cross-sparse
In-Reply-To: <Pine.GSO.4.58.0406182245540.23356@waterleaf.sonytel.be>
Message-ID: <Pine.LNX.4.58.0406181351350.6178@ppc970.osdl.org>
References: <Pine.GSO.4.58.0406172304170.1495@waterleaf.sonytel.be>
 <Pine.LNX.4.58.0406180925210.4669@ppc970.osdl.org>
 <Pine.GSO.4.58.0406182245540.23356@waterleaf.sonytel.be>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Fri, 18 Jun 2004, Geert Uytterhoeven wrote:
> 
> IIRC, actually the first error I got when using the native sparse was that it
> couldn't find stdarg.h.

Ok.

> And even the non-native sparse doesn't know about architecture-specific defines
> like __mc68000__, causing some code paths being wrong. Guess I have to replace
> them by e.g. CONFIG_M68K.

No, this is handled by fixing up the expected defines in the

	arch/xxx/Makefile

thing, ie x86 has this:

	CHECK := $(CHECK) -D__i386__=1

exactly because sparse is architecture-agnostic. Same goes for 64-bit 
issues (sparse defaults to 32-bit types regardless of what the native 
format is), so a 64-bit platform like ppc64 would do:

	CHECK := $(CHECK) -m64 -D__powerpc__=1

where that "-m64" is the magic flag to sparse for a 64-bit compile 
environment.

But your stdarg.h issue is certainly valid. I'd really like for sparse to 
be _totally_ independent of the native compiler install, and I guess we 
could do something like

	CHECK := $(CHECK) -I$(shell $(CC) -print-file-name=include)

or similar to get this part right too, but then sparse would be hard to 
use stand-alone without the Makefile magic. Hmm.

		Linus
