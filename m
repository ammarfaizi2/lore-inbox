Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261899AbTDUTrZ (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 21 Apr 2003 15:47:25 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261907AbTDUTrZ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 21 Apr 2003 15:47:25 -0400
Received: from neon-gw-l3.transmeta.com ([63.209.4.196]:12807 "EHLO
	neon-gw.transmeta.com") by vger.kernel.org with ESMTP
	id S261899AbTDUTrV (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 21 Apr 2003 15:47:21 -0400
Date: Mon, 21 Apr 2003 12:59:00 -0700 (PDT)
From: Linus Torvalds <torvalds@transmeta.com>
To: Andi Kleen <ak@muc.de>
cc: linux-kernel@vger.kernel.org
Subject: Re: [PATCH] Runtime memory barrier patching
In-Reply-To: <20030421192734.GA1542@averell>
Message-ID: <Pine.LNX.4.44.0304211254190.17221-100000@home.transmeta.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


On Mon, 21 Apr 2003, Andi Kleen wrote:
> 
> This patch implements automatic code patching of memory barriers based
> on the CPU capabilities. Normally lock ; addl $0,(%esp) barriers
> are used, but these are a bit slow on the Pentium 4. 

Could you fix this part:

+                       /* fill the overlap with single byte nops */ 
+                       memset(a->instr + a->replacementlen, 0x90, 
+                       a->instrlen - a->replacementlen); 

to use an array of replacements, something like

	#define MAXSIZE 6

	char *nop_sizes[MAXSIZE] = {
		NULL,		// "zero sized nop"? I don't think so
		{ 0x90 },	// simple one-byte no-op.
		{ .. whatever the two-byte NOP is .. }
		...
	};

and then have something like

	replace = a->instrlen - a->replacementlen;
	nop = a->instr + a->replacementlen;
	while (replace) {
		int size = replace;
		if (size > MAXSIZE)
			size = MAXSIZE;
		memcpy(nop, nop_sizes + size, size);
		nop += size;
		replace -= size;
	}

instead? I think it's silly to have multiple single-byte nops, when there
are well-defined multi-byte nops available.

Other than that this looks pretty good.

		Linus

