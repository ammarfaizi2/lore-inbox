Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030277AbVIIR3k@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030277AbVIIR3k (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 9 Sep 2005 13:29:40 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030279AbVIIR3k
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 9 Sep 2005 13:29:40 -0400
Received: from zeniv.linux.org.uk ([195.92.253.2]:9959 "EHLO
	ZenIV.linux.org.uk") by vger.kernel.org with ESMTP id S1030277AbVIIR3j
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 9 Sep 2005 13:29:39 -0400
Date: Fri, 9 Sep 2005 18:29:38 +0100
From: viro@ZenIV.linux.org.uk
To: Linus Torvalds <torvalds@osdl.org>
Cc: Andreas Schwab <schwab@suse.de>, linux-kernel@vger.kernel.org
Subject: [sparse fix] (was Re: [PATCH] bogus cast in bio.c)
Message-ID: <20050909172938.GQ9623@ZenIV.linux.org.uk>
References: <20050909155356.GF9623@ZenIV.linux.org.uk> <je4q8u1agp.fsf@sykes.suse.de> <20050909163643.GO9623@ZenIV.linux.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20050909163643.GO9623@ZenIV.linux.org.uk>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> fs/bio.c:686:15: warning: incorrect type in assignment (different address spaces)
> fs/bio.c:686:15:    expected void [noderef] *iov_base<asn:1>
> fs/bio.c:686:15:    got void [noderef] *<noident>
> from the first form (cast to __user void *).  Lovely...
> 
> OK, I think I know what's going on there, will fix.

What happens is actually pretty simple - we get address_space(1) handled
in declaration_specifiers(), which sets ctype->as to 1.  Then we see
"void" and eventually get to
                        ctype->base_type = type;
                }

                check_modifiers(&token->pos, s, ctype->modifiers);
                apply_ctype(token->pos, &thistype, ctype);
with thistype coming from lookup for "void".  And that, of course, has
zero ->as.  Now apply_ctype merrily buggers ctype->as and we have 0...

So AFAICS proper fix for sparse should be to check thistype->as to see
if it really has any intention to change ->as.  ACK?

--- parse.c	2005-09-07 17:03:13.000000000 -0400
+++ parse.c.new	2005-09-09 13:25:01.000000000 -0400
@@ -636,7 +636,8 @@
 		ctype->alignment = thistype->alignment;
 
 	/* Address space */
-	ctype->as = thistype->as;
+	if (thistype->as)
+		ctype->as = thistype->as;
 }
 
 static void check_modifiers(struct position *pos, struct symbol *s, unsigned long mod)
