Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S317361AbSGZIQG>; Fri, 26 Jul 2002 04:16:06 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S317367AbSGZIQG>; Fri, 26 Jul 2002 04:16:06 -0400
Received: from dell-paw-3.cambridge.redhat.com ([195.224.55.237]:35832 "EHLO
	passion.cambridge.redhat.com") by vger.kernel.org with ESMTP
	id <S317361AbSGZIQF>; Fri, 26 Jul 2002 04:16:05 -0400
X-Mailer: exmh version 2.4 06/23/2000 with nmh-1.0.4
From: David Woodhouse <dwmw2@infradead.org>
X-Accept-Language: en_GB
In-Reply-To: <3D40A3E4.9050703@snapgear.com> 
References: <3D40A3E4.9050703@snapgear.com>  <3D3FA130.6020701@snapgear.com> <9309.1027608767@redhat.com> 
To: Greg Ungerer <gerg@snapgear.com>
Cc: linux-kernel@vger.kernel.org, David McCullough <davidm@snapgear.com>
Subject: Re: [PATCH]: uClinux (MMU-less) patches against 2.5.28 
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Date: Fri, 26 Jul 2002 09:19:19 +0100
Message-ID: <9143.1027671559@redhat.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


gerg@snapgear.com said:
>  You may have noticed some MAGIC_ROM_PTR patches in the mtd driver
> code in this patch. This is to allow XIP for applications. We have
> been support XIP for quite some time on uClinux, it works really well.

> A problem we have experienced with MTD is that the nature of
> asynchronous writing to FLASH does not play nice with apps runing XIP.
>  Any thoughts on how to deal with this?

Other than burying my head in the sand and hoping that someone starts 
making dual-port flash? Sort of...

XIP of the kernel makes it harder, of course -- writing to the chip you're
running the _kernel_ from turns your entire text segment into status words,
so really I can't see any alternative but to copy the flash manipulation
routines into RAM, disable all interrupts, and get on with it. 

If we're talking about XIP of just userspace pages, I have a vague plan for 
that which may be slightly more feasible. If it holds up to the cold light 
of day, perhaps you can help adjust it to work with uClinux.

The plan is to hand out pages to be mapped into userspace (or indeed kernel 
space -- JFFS2 can speed up mounts this way too), but which get marked 
absent when the flash driver talks to the chip. If your applications then 
take a page fault, you can either suspend the operation or just make them 
wait till it's complete.

The actual implementation of this should be relatively simple. We can 
provide a generic_mtd_vm_ops and the chip drivers just need to know about 
an extra state for 'mapped' and have a method to enter that state, and a 
callback for when they want to _leave_ that state. Oh, and a way to get the 
raw physical address for a given range of flash.

It occurs to me that this doesn't work too well without an MMU though. Got 
any better ideas? Could we disable entire processes when one of their pages 
is inaccessible?

--
dwmw2


