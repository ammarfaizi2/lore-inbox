Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1753196AbVHHBVq@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753196AbVHHBVq (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 7 Aug 2005 21:21:46 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753198AbVHHBVq
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 7 Aug 2005 21:21:46 -0400
Received: from dvhart.com ([64.146.134.43]:2945 "EHLO localhost.localdomain")
	by vger.kernel.org with ESMTP id S1753196AbVHHBVp (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 7 Aug 2005 21:21:45 -0400
Date: Sun, 07 Aug 2005 18:21:49 -0700
From: "Martin J. Bligh" <mbligh@mbligh.org>
Reply-To: "Martin J. Bligh" <mbligh@mbligh.org>
To: Zachary Amsden <zach@vmware.com>, Chris Wright <chrisw@osdl.org>
Cc: Andrew Morton <akpm@osdl.org>, linux-kernel@vger.kernel.org,
       Pratap Subrahmanyam <pratap@vmware.com>
Subject: Re: [PATCH] abstract out bits of ldt.c
Message-ID: <383160000.1123464108@[10.10.2.4]>
In-Reply-To: <42F6AF8E.60107@vmware.com>
References: <372830000.1123456808@[10.10.2.4]> <20050807234411.GE7991@shell0.pdx.osdl.net> <374910000.1123459025@[10.10.2.4]> <20050807174129.20c7202f.akpm@osdl.org> <20050808004645.GT7762@shell0.pdx.osdl.net> <42F6AF8E.60107@vmware.com>
X-Mailer: Mulberry/2.2.1 (Linux/x86)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> I like these patches.  They greatly simplify a lot of the work I 
> had anticipated was necessary for Xen.  I.e. - LDT / GDT accessors 
> are not needed for most updates, only updates to live descriptor 
> table entries (for GDT this is TLS, LDT, TSS?, entries and there 
> is 1 LDT update case).

I'm just trying to get rid of as much code duplication as possible.

> BTW, Martin, did you see my ldt-accessors patch?  It also 
> encapsulates that 1 LDT update case you show here, just named 
> differently.

I was focussing on creating a whole Xen stack before looking at
your stuff much, then seeing what was common between them, as I
think it's a bit hard to read the current Xen code because of the
copied files. Unfortunately, is going to be harder then I thought
to maintain that stack out of tree, so I wanted to shovel out
the basic refactoring stuff. Then the line got a bit blurred.
Humpf. And this is the easy part. Damn it.

Doing the whole thing and comparing is going to be a total PITA.
Perhaps the right thing to do is go one file at a time, and sync
up on that basis.

> Yours:
> 
> +static inline int install_ldt_entry (__u32 *lp, __u32 entry_1, __u32 entry_2)
> +{
> +	*lp     = entry_1;
> +	*(lp+1) = entry_2;
> +	return 0;
> +}
> 
> Mine:
> 
> +static inline void write_ldt_entry(void *ldt, int entry, __u32 entry_a, __u32 entry_b)
> +{
> +	__u32 *lp = (__u32 *)((char *)ldt + entry*8);
> +	*lp = entry_a;
> +	*(lp+1) = entry_b;
> +}
> 
> 
> They both work, but mine does not assume page aligned LDTs (necessary 
> to extract entry number).  This is moot right now because LDTs are 
> page aligned anyway in Linux.  I actually don't care which one we 
> use, but it might be even nicer if we got one with C type checking 
> (struct desc_struct for ldt).

Heh, is similar, considering we're working from completely different
angles. I'm just refactoring the current code without changing it
too much at first, we can make it more robust later. otherwise it's
going to be a pig to review if we mix those up.

> I think introducing mach-xen headers is a bit premature though - lets 
> get the interface nailed down first so that the hypervisor developers 
> have time to settle the include/asm-i386/mach-xxx files without 
> dealing unneeded churn onto the maintainers.

I can easily leave those bits out. There's going to be lots of bits common
with std i386, and bits that are common amongst the hypervisor layers,
then bits that are specific. Hopefully more bits that are common, but
still.

Humpf. I shall go back into my corner and have a rethink. Will read through
your patches some more, then send you some email.

M.
