Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263624AbUDPT16 (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 16 Apr 2004 15:27:58 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263613AbUDPT15
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 16 Apr 2004 15:27:57 -0400
Received: from fw.osdl.org ([65.172.181.6]:13738 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S263624AbUDPT1p (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 16 Apr 2004 15:27:45 -0400
Date: Fri, 16 Apr 2004 12:27:33 -0700
From: Chris Wright <chrisw@osdl.org>
To: Ken Ashcraft <ken@coverity.com>
Cc: linux-kernel@vger.kernel.org, mc@cs.stanford.edu, rusty@rustcorp.com.au
Subject: Re: [CHECKER] Probable security holes in 2.6.5
Message-ID: <20040416122733.Z22989@build.pdx.osdl.net>
References: <1082134916.19301.7.camel@dns.coverity.int>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <1082134916.19301.7.camel@dns.coverity.int>; from ken@coverity.com on Fri, Apr 16, 2004 at 10:01:57AM -0700
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> [BUG]
> /home/kash/linux/linux-2.6.5/kernel/module.c:1303:load_module:
> ERROR:TAINT: 1283:1303:Using user value "((*hdr).e_shstrndx * 0)"
> without first performing bounds checks
> [SOURCE_MODEL=(lib,copy_from_user,user,taintscalar)] [PATH=]    
> 
> 	/* Suck in entire file: we'll want most of it. */
> 	/* vmalloc barfs on "unusual" numbers.  Check here */
> 	if (len > 64 * 1024 * 1024 || (hdr = vmalloc(len)) == NULL)
> 		return ERR_PTR(-ENOMEM);
> Start --->
> 	if (copy_from_user(hdr, umod, len) != 0) {
> 
> 	... DELETED 14 lines ...
> 
> 	if (len < hdr->e_shoff + hdr->e_shnum * sizeof(Elf_Shdr))
> 		goto truncated;
> 
> 	/* Convenience variables */
> 	sechdrs = (void *)hdr + hdr->e_shoff;
> Error --->
> 	secstrings = (void *)hdr + sechdrs[hdr->e_shstrndx].sh_offset;
> 	sechdrs[0].sh_addr = 0;
> 
> 	/* And these should exist, but gcc whinges if we don't init them */

Loading modules is inherently risky.  I'm not sure how much we want to
worry about malicious elf headers when loading a module...you've already
given away the family jewels ;-)

thanks,
-chris
-- 
Linux Security Modules     http://lsm.immunix.org     http://lsm.bkbits.net
