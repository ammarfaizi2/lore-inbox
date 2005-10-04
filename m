Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964797AbVJDPWh@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964797AbVJDPWh (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 4 Oct 2005 11:22:37 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964800AbVJDPWh
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 4 Oct 2005 11:22:37 -0400
Received: from smtp.osdl.org ([65.172.181.4]:50641 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S964797AbVJDPWg (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 4 Oct 2005 11:22:36 -0400
Date: Tue, 4 Oct 2005 08:22:26 -0700 (PDT)
From: Linus Torvalds <torvalds@osdl.org>
To: Magnus Damm <magnus.damm@gmail.com>
cc: Paul Jackson <pj@sgi.com>, Andrew Morton <akpm@osdl.org>,
       Jeff Garzik <jgarzik@pobox.com>, "Randy.Dunlap" <rdunlap@xenotime.net>,
       linux-kernel@vger.kernel.org, Coywolf Qi Hunt <coywolf@gmail.com>,
       Greg KH <greg@kroah.com>
Subject: Re: [PATCHv2] Document from line in patch format
In-Reply-To: <aec7e5c30510032024t6d48643fma875c917acb69d92@mail.gmail.com>
Message-ID: <Pine.LNX.4.64.0510040811280.31407@g5.osdl.org>
References: <20051002163244.17502.15351.sendpatchset@jackhammer.engr.sgi.com>
  <Pine.LNX.4.64.0510021158260.31407@g5.osdl.org>
 <aec7e5c30510032024t6d48643fma875c917acb69d92@mail.gmail.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Tue, 4 Oct 2005, Magnus Damm wrote:
> 
> Huh, I thought that the first line in a unified patch started with
> "---", and that the lines above were treated as garbage.

Indeed, that's true of traditional unified diffs. That's why my tools 
started using "---" in the first place. Cutting off at the "---" means 
that it's _guaranteed_ that we never include any valid patch in the 
description by mistake rather than applying it.

And I _used_ to just hand-edit emails so that things like "Please apply" 
and "Thanks", and "diff -urN" didn't show up.

However, note that "git diffs" can actually contain renames, so a git diff 
may have relevant stuff before the "---". For example:

	diff --git a/arch/v850/kernel/asm-consts.c b/arch/v850/kernel/asm-offsets.c
	similarity index 100%
	rename from arch/v850/kernel/asm-consts.c
	rename to arch/v850/kernel/asm-offsets.c
	diff --git a/arch/v850/kernel/entry.S b/arch/v850/kernel/entry.S
	--- a/arch/v850/kernel/entry.S
	+++ b/arch/v850/kernel/entry.S
	@@ -22,7 +22,7 @@
	 #include <asm/irq.h>
	 #include <asm/errno.h>
	 
	-#include <asm/asm-consts.h>
	+#include <asm/asm-offsets.h>
	 
	 
	 /* Make a slightly more convenient alias for C_SYMBOL_NAME.  */

is a real diff as far as git is concerned, and is obviously much more 
readable (and much more compact) than the traditional broken "delete file 
and re-create it under another name" kind of diff.

So "^diff --git " is actually the real marker for where a git diff starts.

> Relying on "diff -" or "Index: " seems wrong. Try diffing two files by 
> "diff -u file1 file2" and look at the output - the first line is 
> "---"... This extra "---" you are proposing seems like a workaround to 
> me.

With traditional unified patches nothing _relies_ of "diff -" or "Index:", 
exactly because "---" is _always_ seen as the beginning of the patch. But 
even then the patch applicator often wants to see the "diff -" or "Index:" 
line, because it can use them to disambiguate file names.

So there are real _technical_ reasons so make sure that we know where the 
diff starts, and "---" is a good marker, because it's a marker that is 
guaranteed to be there, regardless.

But even apart from those technical reasons, I don't want the first "diff 
-urN ..." or "Index:" line to show up as a commit message. So the tools 
will _also_ break the commit messages at those markers, but that's a hack.

So the _real_ rule is that we break at "---". No ifs, buts, or maybes. And 
no, it's not "extra" or "optional" or "unnecessary".

And it also allows people to put extra commentary, like a diffstat, or a 
private message to me about why I should apply the patch.

		Linus
