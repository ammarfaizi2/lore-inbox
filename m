Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261689AbVANAst@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261689AbVANAst (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 13 Jan 2005 19:48:49 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261720AbVANAr3
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 13 Jan 2005 19:47:29 -0500
Received: from wproxy.gmail.com ([64.233.184.203]:57112 "EHLO wproxy.gmail.com")
	by vger.kernel.org with ESMTP id S261738AbVANA3B (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 13 Jan 2005 19:29:01 -0500
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:reply-to:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:references;
        b=i2sFWGLirDutoRsFkQQMxezfBJTLC4RdVsfPlxUynXeuE5cry2cy3qDKbmHbAjMJ3C0YrAVv0TZP/zWFmVhGldYQpdVSfab105ygCtfgHT3Os03/Ks/pdAd/2Z+vpiValeLQS2kWunTq83lrWE4DDXSrq+AO3Lr6wO72wZd8Zm0=
Message-ID: <8746466a0501131628368e11e1@mail.gmail.com>
Date: Thu, 13 Jan 2005 17:28:56 -0700
From: Dave <dave.jiang@gmail.com>
Reply-To: Dave <dave.jiang@gmail.com>
To: Andrew Morton <akpm@osdl.org>
Subject: Re: [PATCH 1/5] Convert resource to u64 from unsigned long
Cc: torvalds@osdl.org, linux-kernel@vger.kernel.org, smaurer@teja.com,
       linux@arm.linux.org.uk, dsaxena@plexity.net, drew.moseley@intel.com,
       mporter@kernel.crashing.org
In-Reply-To: <20050113162309.2a125eb1.akpm@osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
References: <8746466a050113152636f49d18@mail.gmail.com>
	 <20050113162309.2a125eb1.akpm@osdl.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 13 Jan 2005 16:23:09 -0800, Andrew Morton <akpm@osdl.org> wrote:
> Dave <dave.jiang@gmail.com> wrote:
> >
> > ere's my first attempt of trying to convert the struct resource
> > start/end to u64 per blessed by Linus =) This is to support >32bit
> > physical address on 32bit archs such as some of the newer ARMv6 and
> > XSC3 based platforms and perhaps IA32 PAE.  I left the PCI stuff alone
> > functionally. Supporting 64bit PCI BAR on 32bit archs is for another
> > day. I fixed most of the core stuff I can think of, fixed ARM and i386
> > hopefully and a few of the device drivers as examples. I have tested
> > on an IQ31244 XScale IOP (ARM) platform and a dual-xeon platform for
> > i386. Matt Porter has graciously sent me PPC fixes that he tested on.
> 
> OK, well Greg KH will be the main target of this work..
> 
> Can you do something a bit more friendly than application/octet-stream
> encoding, btw?
> 
> +#if BITS_PER_LONG == 64
> +#define U64FMT "016lx"
> +#else
> +#define U64FMT "016Lx"
> +#endif
> 
> We've avoided doing this.  We prefer to do
> 
>         printk("%llx", (unsigned long long)foo);
> 
> which is tidier, although a little more runtime-costly.
> 
> Your approach assumes that all 64-bit architectures implement u64 as
> unsigned long (as opposed to unsigned long long, which I guess is legal?) I
> don't know if that's a problem or not.
> 
> Also, the patches introduce tons of ifdefs such as:
> 
> +#if BITS_PER_LONG == 64
>         return (void __iomem *)pci_resource_start(pdev, PCI_ROM_RESOURCE);
> +#else
> +       return (void __iomem *)(u32)pci_resource_start(pdev, PCI_ROM_RESOURCE);
> +#endif
> 
> We really should find a way of avoiding this.  Even if it is
> 
> #if BITS_PER_LONG == 64
> #define resource_to_ptr(r) ((void *)(r))
> #else
> #define resource_to_ptr(r) ((void *)((u32)r))
> #endif
> 
> in a header file somewhere.  Open-coding the decision all over the place is
> unsightly.
> 
 
Ok, I shall rework the patches w/ ull. I wasn't sure that ull would
cause problems on 64bit archs or not for u64....thus the ugly
workarounds....

BTW, anyone know how to inline patches via gmail? 

-- 
-= Dave =-

Software Engineer - Advanced Development Engineering Team 
Storage Component Division - Intel Corp. 
mailto://dave.jiang @ intel
http://sourceforge.net/projects/xscaleiop/
----
The views expressed in this email are
mine alone and do not necessarily 
reflect the views of my employer
(Intel Corp.).
