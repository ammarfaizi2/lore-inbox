Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262765AbUAOPib (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 15 Jan 2004 10:38:31 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263742AbUAOPia
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 15 Jan 2004 10:38:30 -0500
Received: from fed1mtao05.cox.net ([68.6.19.126]:63398 "EHLO
	fed1mtao05.cox.net") by vger.kernel.org with ESMTP id S262765AbUAOPi2
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 15 Jan 2004 10:38:28 -0500
Date: Thu, 15 Jan 2004 08:38:24 -0700
From: Tom Rini <trini@kernel.crashing.org>
To: Rusty Russell <rusty@rustcorp.com.au>
Cc: Paul Mackerras <paulus@samba.org>,
       Benjamin Herrenschmidt <benh@kernel.crashing.org>,
       Christoph Hellwig <hch@infradead.org>, Andrew Morton <akpm@osdl.org>,
       Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH][RFC] 2.6 && module + -g && kernel w/o -g
Message-ID: <20040115153824.GE983@stop.crashing.org>
References: <20040114210937.GA983@stop.crashing.org> <20040115013723.29B912C0DC@lists.samba.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20040115013723.29B912C0DC@lists.samba.org>
User-Agent: Mutt/1.5.5.1+cvs20040105i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jan 15, 2004 at 10:00:11AM +1100, Rusty Russell wrote:

> In message <20040114210937.GA983@stop.crashing.org> you write:
> > Okay.  I've been looking at stock 2.6.1 noticed  that the fix for this
> > issue that Rusty proposed, and that ultimately made it into 2.6.1-rc3
> > (or so) is not correct.  The problem is that we do:
> > 
> > err = module_frob_arch_sections(hdr, sechdrs, secstrings, mod);
> > /* Which goes over every .debug section and can take _ages_ on something
> >  * like ipv6 */
> 
> Right.  So the arch-specific module_frob_arch_sections() can be slow.
> Logically, the fix should be in those module_frob_arch_sections(), not
> in the generic code.

So it was right the first time, OK. :)

> > +		/* If we find any debug RELAs, frob these away now. */
> > +		if (sechdrs[i].sh_type == SHT_RELA &&
> > +				(strstr(secstrings+sechdrs[i].sh_name, ".debug")
> > +				 != 0))
> > +			sechdrs[i].sh_type = SHT_NULL;
> > +
> 
> Doesn't cover SHT_REL, and I really dislike name matches: they've bitten
> us before.
> 
> Really, I prefer the arch-specific optimization.

FWIW, this isn't an optimization, taking 12 minutes to load the ipv6
module is a bug. :)

Andrew, can you please apply the following patch?  Thanks.
--- 1.10/arch/ppc/kernel/module.c	Fri Sep 12 09:26:52 2003
+++ edited/arch/ppc/kernel/module.c	Thu Jan 15 08:35:40 2004
@@ -88,6 +88,10 @@
 		    != is_init)
 			continue;
 
+		/* We don't want to look at debug sections. */
+		if (strstr(secstrings + sechdrs[i].sh_name, ".debug") != 0)
+			continue;
+
 		if (sechdrs[i].sh_type == SHT_RELA) {
 			DEBUGP("Found relocations in section %u\n", i);
 			DEBUGP("Ptr: %p.  Number: %u\n",

-- 
Tom Rini
http://gate.crashing.org/~trini/
