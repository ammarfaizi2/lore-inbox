Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262377AbVAUOeF@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262377AbVAUOeF (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 21 Jan 2005 09:34:05 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262378AbVAUOeE
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 21 Jan 2005 09:34:04 -0500
Received: from [220.248.27.114] ([220.248.27.114]:6316 "HELO soulinfo.com")
	by vger.kernel.org with SMTP id S262377AbVAUOdx (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 21 Jan 2005 09:33:53 -0500
Date: Fri, 21 Jan 2005 22:31:37 +0800
From: hugang@soulinfo.com
To: "Rafael J. Wysocki" <rjw@sisk.pl>
Cc: Pavel Machek <pavel@suse.cz>, Andi Kleen <ak@suse.de>,
       Andrew Morton <akpm@osdl.org>, LKML <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH][RFC] swsusp: speed up image restoring on x86-64
Message-ID: <20050121143136.GA19036@hugang.soulinfo.com>
References: <200501202032.31481.rjw@sisk.pl> <20050121022348.GA18166@hugang.soulinfo.com> <20050121103028.GF18373@elf.ucw.cz> <200501211442.55274.rjw@sisk.pl>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200501211442.55274.rjw@sisk.pl>
User-Agent: Mutt/1.3.28i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jan 21, 2005 at 02:42:54PM +0100, Rafael J. Wysocki wrote:
> Hi,
> 
> 
> No, it's "repeat until %ecx is zero or ZF is cleared", but the latter never happens
> with movsl.  It's intended for cmpsl, scasl and friends (the assembler should
> complain about using it here).
> 
> > I think this should be "rep movsl".
> 
> Yes, it should.
> 
I'll change my code.

> 
> I have a suggestion.
> 
> hugang, you are currently replacing an array of pbes with a list of arrays
> of pbes contained within individual pages.
> 
> I would go further and replace it with a single one-directional list
> of pbes.  Namely, I would modify "struct pbe" in the following way:
> 
> struct pbe {
> 	unsigned long address;
> 	unsigned long orig_address;
> 	swp_entry_t swap_address;	
> 	struct pbe *next;
> };
> 
> (AFAICT, the "dummy" field is only used by hugang - as a pointer)
> and I would define "for_each_pbe()" as:
> 
> #define for_each_pbe(pbe, pblist) \
> 	for (pbe = pblist;  pbe;  pbe = pbe->next)
> 
> Then, the only non-trivial changes would be in alloc_pagedir() and
> in swsusp_pagedir_relocate(), where I would need to link pbes to
> each other.
> 
> This also would make the assembly parts independent of the
> sizeof(struct pbe), which is currently hardcoded there.
> 
> What do you think?
Thanks for point that, That's better solution than current, I'll change
current code to this.

I'm think about, how can I make chang smaller.

-- 
Hu Gang       .-.
              /v\
             // \\ 
Linux User  /(   )\  [204016]
GPG Key ID   ^^-^^   http://soulinfo.com/~hugang/hugang.asc
