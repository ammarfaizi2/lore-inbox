Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S266527AbTBGVGW>; Fri, 7 Feb 2003 16:06:22 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S266564AbTBGVGW>; Fri, 7 Feb 2003 16:06:22 -0500
Received: from fmr02.intel.com ([192.55.52.25]:5625 "EHLO
	caduceus.fm.intel.com") by vger.kernel.org with ESMTP
	id <S266527AbTBGVGV> convert rfc822-to-8bit; Fri, 7 Feb 2003 16:06:21 -0500
content-class: urn:content-classes:message
Subject: RE: [PATCH] Restore module support.
Date: Fri, 7 Feb 2003 13:15:54 -0800
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Message-ID: <DD755978BA8283409FB0087C39132BD1A07CA5@fmsmsx404.fm.intel.com>
Content-Transfer-Encoding: 7BIT
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
X-MimeOLE: Produced By Microsoft Exchange V6.0.6334.0
Thread-Topic: [PATCH] Restore module support.
Thread-Index: AcLO4j6jfE1P5DrVEdeo8wBQi2jWzAACwfiA
From: "Luck, Tony" <tony.luck@intel.com>
To: "Russell King" <rmk@arm.linux.org.uk>
Cc: <linux-kernel@vger.kernel.org>
X-OriginalArrivalTime: 07 Feb 2003 21:15:54.0253 (UTC) FILETIME=[1957FBD0:01C2CEEE]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Russell King wrote:
> On Fri, Feb 07, 2003 at 10:43:19AM -0800, Luck, Tony wrote:
> > > (2) has the disadvantage that its touching 
> non-architecture specific
> > > code, but this is the option I'd prefer due to the 
> obvious performance
> > > advantage.  However, I'm afraid that it isn't worth the 
> effort to fix
> > > up vmalloc and /proc/kcore.  vmalloc fix appears simple, 
> but /proc/kcore
> > > has issues (anyone know what KCORE_BASE is all about?)
> > 
> > KCORE_BASE is my fault ... it was an attempt to fix the "modules
> > below PAGE_OFFSET" problem for the ia64 port.  For a few nanoseconds
> > the code just here looked like this:
> > 
> > #if VMALLOC_START < PAGE_OFFSET
> > #define	KCORE_BASE	VMALLOC_START
> > #else
> > #define	KCORE_BASE	PAGE_OFFSET
> > #endif
> 
> Ah, ok.  What I'm thinking of is something like the following 
> (untested
> and probably improperly thought out patch...):
> 
> --- orig/fs/proc/kcore.c	Sat Nov  2 18:58:18 2002
> +++ linux/fs/proc/kcore.c	Fri Feb  7 19:48:35 2003
> @@ -99,7 +99,10 @@
>  }
>  #else /* CONFIG_KCORE_AOUT */
>  
> +#ifndef KCORE_BASE
>  #define	KCORE_BASE	PAGE_OFFSET
> +) < #define in_vmlist_region(x) ((x) >= VMALLOC_START && (x
> VMALLOC_END)
> +#endif
>  
>  #define roundup(x, y)  ((((x)+((y)-1))/(y))*(y))
>  
> @@ -394,7 +397,7 @@
>  		tsz = buflen;
>  		
>  	while (buflen) {
> -		if ((start >= VMALLOC_START) && (start < VMALLOC_END)) {
> +		if (in_vmlist_region(start)) {
>  			char * elf_buf;
>  			struct vm_struct *m;
>  			unsigned long curstart = start;
> 
> An architecture could then define KCORE_BASE and in_vmlist_region()
> alongside their VMALLOC_START definition if they needed to change
> them.

Looks pretty good.  What's the motivation for the in_vmlist_region()?
I don't think that I need that for ia64 ... so it might be better to
have separate #ifdefs:

#ifndef KCORE_BASE
#define	KCORE_BASE	PAGE_OFFSET
endif
#ifndef in_vmlist_region
#define in_vmlist_region(x) ((x) >= VMALLOC_START && (x < VMALLOC_END))
#endif

-Tony
