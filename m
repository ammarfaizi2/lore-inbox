Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263303AbUANVJk (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 14 Jan 2004 16:09:40 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263370AbUANVJk
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 14 Jan 2004 16:09:40 -0500
Received: from fed1mtao06.cox.net ([68.6.19.125]:55948 "EHLO
	fed1mtao06.cox.net") by vger.kernel.org with ESMTP id S263303AbUANVJi
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 14 Jan 2004 16:09:38 -0500
Date: Wed, 14 Jan 2004 14:09:37 -0700
From: Tom Rini <trini@kernel.crashing.org>
To: Paul Mackerras <paulus@samba.org>,
       Benjamin Herrenschmidt <benh@kernel.crashing.org>,
       Christoph Hellwig <hch@infradead.org>, Andrew Morton <akpm@osdl.org>,
       Rusty Russell <rusty@rustcorp.com.au>
Cc: Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH][RFC] 2.6 && module + -g && kernel w/o -g
Message-ID: <20040114210937.GA983@stop.crashing.org>
References: <20040108003040.GA18481@stop.crashing.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20040108003040.GA18481@stop.crashing.org>
User-Agent: Mutt/1.5.5.1+cvs20040105i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jan 07, 2004 at 05:30:40PM -0700, Tom Rini wrote:

> Okay, this is what seems to fix the bug that hch found for me.  Does
> this seem right to everyone else?  I'm going to poke at it a bit more
> tomorrow, pending time.
> 
> ===== arch/ppc/kernel/module.c 1.10 vs edited =====
> --- 1.10/arch/ppc/kernel/module.c	Fri Sep 12 09:26:52 2003
> +++ edited//home/trini/work/kernel/testing/linux-2.6/arch/ppc/kernel/module.c	Wed Jan  7 17:07:30 2004
> @@ -87,6 +87,9 @@
>  		if ((strstr(secstrings + sechdrs[i].sh_name, ".init") != 0)
>  		    != is_init)
>  			continue;
> +		/* Skip over debug bits. */
> +		if (strstr(secstrings + sechdrs[i].sh_name, ".debug") != 0)
> +			continue;
>  
>  		if (sechdrs[i].sh_type == SHT_RELA) {
>  			DEBUGP("Found relocations in section %u\n", i);

Okay.  I've been looking at stock 2.6.1 noticed  that the fix for this
issue that Rusty proposed, and that ultimately made it into 2.6.1-rc3
(or so) is not correct.  The problem is that we do:

err = module_frob_arch_sections(hdr, sechdrs, secstrings, mod);
/* Which goes over every .debug section and can take _ages_ on something
 * like ipv6 */
... skip 100 lines ...
.... Checks Rusty / Linus added ...

The following patch fixes the problem for me on PPC32:

--- 1.96/kernel/module.c	Wed Jan  7 22:46:59 2004
+++ edited/kernel/module.c	Wed Jan 14 14:05:12 2004
@@ -1439,6 +1439,13 @@
 			strindex = sechdrs[i].sh_link;
 			strtab = (char *)hdr + sechdrs[strindex].sh_offset;
 		}
+
+		/* If we find any debug RELAs, frob these away now. */
+		if (sechdrs[i].sh_type == SHT_RELA &&
+				(strstr(secstrings+sechdrs[i].sh_name, ".debug")
+				 != 0))
+			sechdrs[i].sh_type = SHT_NULL;
+
 #ifndef CONFIG_MODULE_UNLOAD
 		/* Don't load .exit sections */
 		if (strncmp(secstrings+sechdrs[i].sh_name, ".exit", 5) == 0)

IMHO, this shouldn't be covered under a PPC32 test since at least PPC32,
PPC64 and Alpha have this issue, and I suspect that ia64, parisc, s390
and v850 have the problem as well (based on what their module_arch_frob
bits look to be doing).

-- 
Tom Rini
http://gate.crashing.org/~trini/
