Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267595AbSKQUxE>; Sun, 17 Nov 2002 15:53:04 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267597AbSKQUxE>; Sun, 17 Nov 2002 15:53:04 -0500
Received: from are.twiddle.net ([64.81.246.98]:40071 "EHLO are.twiddle.net")
	by vger.kernel.org with ESMTP id <S267595AbSKQUxD>;
	Sun, 17 Nov 2002 15:53:03 -0500
Date: Sun, 17 Nov 2002 12:59:59 -0800
From: Richard Henderson <rth@twiddle.net>
To: Rusty Russell <rusty@rustcorp.com.au>
Cc: Richard Henderson <rth@twiddle.net>, linux-kernel@vger.kernel.org
Subject: Re: in-kernel linking issues
Message-ID: <20021117125959.A31315@twiddle.net>
Mail-Followup-To: Rusty Russell <rusty@rustcorp.com.au>,
	linux-kernel@vger.kernel.org
References: <20021116145102.A24671@twiddle.net> <20021117130132.AA5352C058@lists.samba.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
In-Reply-To: <20021117130132.AA5352C058@lists.samba.org>; from rusty@rustcorp.com.au on Sun, Nov 17, 2002 at 11:46:32PM +1100
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Another Idea:

Why build our own __ksymtab section, which contains names and
addresses in some random order that requires a linear search,
when instead we can re-use the dynamic symbol table for the 
shared library.  If we do that, we no longer have a linear search,
but can use the hash table provided by the linker.  Plus we don't
have to work so hard to get rid of it.  ;-)

Consider

#define EXPORT_SYMBOL(sym)			\
	asm (".section .exports\n"		\
	     "	.asciz \"" #sym "\"\n"		\
	     ".previous")

then link with '--version-exports-section ""'.  This will result
in a .dynsym section that contains exactly those symbols we asked
to exported from the module (plus the undefineds, but that's obvious).

This has other benefits in that the linker will now know that
the symbols not exported may be able to have their relocations
satisfied completely at link time, which results in fewer dynamic
relocations.

Along that same vein, we should be using the link option -Bsymbolic,
since we do not allow modules to override one another's symbols,
and this describes that fact to the linker.  Which will result in
even fewer dynamic relocations.

The problem remaining here is to get the same dynamic symbol table
generated for the kernel itself.  This is where we'd really win with
the hashing, since the kernel has by far the largest symbol table.
I'll have to give this some more thought.


r~
