Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751075AbWGGCOi@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751075AbWGGCOi (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 6 Jul 2006 22:14:38 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751146AbWGGCOi
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 6 Jul 2006 22:14:38 -0400
Received: from mx1.redhat.com ([66.187.233.31]:63875 "EHLO mx1.redhat.com")
	by vger.kernel.org with ESMTP id S1751075AbWGGCOh (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 6 Jul 2006 22:14:37 -0400
Date: Thu, 6 Jul 2006 22:05:08 -0400 (EDT)
From: Jason Baron <jbaron@redhat.com>
X-X-Sender: jbaron@dhcp83-5.boston.redhat.com
To: akpm@osdl.org
cc: Alan Cox <alan@lxorguk.ukuu.org.uk>, Ulrich Drepper <drepper@gmail.com>,
       Arjan van de Ven <arjan@infradead.org>, linux-kernel@vger.kernel.org,
       alex@shark-linux.de, paulus@samba.org, tony.luck@intel.com,
       paulus@samba.org, ak@muc.de, geert@linux-m68k.org,
       zippel@linux-m68k.org
Subject: Re: make PROT_WRITE imply PROT_READ
In-Reply-To: <Pine.LNX.4.64.0606291655030.10034@dhcp83-5.boston.redhat.com>
Message-ID: <Pine.LNX.4.64.0607062154260.23330@dhcp83-5.boston.redhat.com>
References: <1151071581.3204.14.camel@laptopd505.fenrus.org>
 <Pine.LNX.4.64.0606231002150.24102@dhcp83-5.boston.redhat.com>
 <1151072280.3204.17.camel@laptopd505.fenrus.org>
 <a36005b50606241145q4d1dd17dg85f80e07fb582cdb@mail.gmail.com>
 <20060627095632.GA22666@elf.ucw.cz> <a36005b50606280943l54138e80tbda08e1607136792@mail.gmail.com>
 <20060628194913.GA18039@elf.ucw.cz> <a36005b50606281647i58f2899eo7ae7e95757969d42@mail.gmail.com>
 <20060629073033.GF27526@elf.ucw.cz> <1151582323.23785.16.camel@localhost.localdomain>
 <20060629172036.GB2947@elf.ucw.cz> <Pine.LNX.4.64.0606291655030.10034@dhcp83-5.boston.redhat.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


On Thu, 29 Jun 2006, Jason Baron wrote:

> 
> On Thu, 29 Jun 2006, Pavel Machek wrote:
> 
> > Hi!
> > 
> > > > > PROT_READ to be used or implicitly adding it.  Don't confuse people
> > > > > with wrong statement like yours.
> > > > 
> > > > Can you quote part of POSIX where it says that PROT_WRITE must imply
> > > > PROT_READ?
> > > 
> > > I don't believe POSIX cares either way
> > > 
> > > "An implementation may permit accesses other than those specified by
> > > prot; however, if the Memory Protection option is supported, the
> > > implementation shall not permit a write to succeed where PROT_WRITE has
> > > not been set or shall not permit any access where PROT_NONE alone has
> > > been set."
> > > 
> > > However the current behaviour of "write to map read might work some days
> > > depending on the execution order of instructions" (and in some cases the
> > > order that the specific CPU does its tests for access rights) is not
> > > sane, not conducive to application stability and not good practice.
> > 
> > Well, some architectures may have working PROT_WRITE without
> > PROT_READ. If you are careful and code your userland application in
> > assembly, it should work okay.
> > 
> > On processors where that combination depends randomly depending on
> > phase of moon (i386, apparently), I guess change is okay. But the
> > patch disabled PROT_WRITE w/o PROT_READ on _all_ processors.
> > 
> > 								Pavel
> > 
> 
> 
> ok, the following patch should make x86 self-consistent, making PROT_WRITE 
> imply PROT_READ.
> 
> i can produce patches for other architectures, if people agree with this 
> approach.
> 
> thanks,
> 
> -Jason
> 
> 
> --- linux-2.6/arch/i386/mm/fault.c.bak	2006-06-29 16:48:25.000000000 -0400
> +++ linux-2.6/arch/i386/mm/fault.c	2006-06-29 16:49:51.000000000 -0400
> @@ -449,7 +449,7 @@
>  		case 1:		/* read, present */
>  			goto bad_area;
>  		case 0:		/* read, not present */
> -			if (!(vma->vm_flags & (VM_READ | VM_EXEC)))
> +			if (!(vma->vm_flags & (VM_READ | VM_EXEC | VM_WRITE)))
>  				goto bad_area;
>  	}
>  
> -
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/
> 


hearing no objections.....below is a patch to make PROT_WRITE imply 
PROT_READ for a number of architectures which don't support write only 
in hardware.

While looking at this, I noticed that some architectures which do not 
support write only mappings already take the exact same approach. For 
example, in arch/alpha/mm/fault.c:

"
        if (cause < 0) {
                if (!(vma->vm_flags & VM_EXEC))
                        goto bad_area;
        } else if (!cause) {
                /* Allow reads even for write-only mappings */
                if (!(vma->vm_flags & (VM_READ | VM_WRITE)))
                        goto bad_area;
        } else {
                if (!(vma->vm_flags & VM_WRITE))
                        goto bad_area;
        }
"

Thus, this patch brings other architectures which do not support write 
only mappings in-line and consistent with the rest. I've verified the 
patch on ia64, x86_64 and x86.

I've 'cc relevant architecture maintainers for comments.

thanks,

-Jason

Signed-off-by: Jason Baron <jbaron@redhat.com>

--- linux-2.6/arch/sh/mm/fault.c.bak	2006-07-06 13:24:16.000000000 -0400
+++ linux-2.6/arch/sh/mm/fault.c	2006-07-06 13:24:37.000000000 -0400
@@ -80,7 +80,7 @@ good_area:
 		if (!(vma->vm_flags & VM_WRITE))
 			goto bad_area;
 	} else {
-		if (!(vma->vm_flags & (VM_READ | VM_EXEC)))
+		if (!(vma->vm_flags & (VM_READ | VM_EXEC | VM_WRITE)))
 			goto bad_area;
 	}
 
--- linux-2.6/arch/arm26/mm/fault.c.bak	2006-07-06 13:22:20.000000000 -0400
+++ linux-2.6/arch/arm26/mm/fault.c	2006-07-06 13:21:56.000000000 -0400
@@ -155,7 +155,7 @@ __do_page_fault(struct mm_struct *mm, un
 	 */
 good_area:
 	if (READ_FAULT(fsr)) /* read? */
-		mask = VM_READ|VM_EXEC;
+		mask = VM_READ|VM_EXEC|VM_WRITE;
 	else
 		mask = VM_WRITE;
 
--- linux-2.6/arch/powerpc/mm/fault.c.bak	2006-07-06 13:15:04.000000000 -0400
+++ linux-2.6/arch/powerpc/mm/fault.c	2006-07-06 13:15:17.000000000 -0400
@@ -333,7 +333,7 @@ good_area:
 		/* protection fault */
 		if (error_code & 0x08000000)
 			goto bad_area;
-		if (!(vma->vm_flags & (VM_READ | VM_EXEC)))
+		if (!(vma->vm_flags & (VM_READ | VM_EXEC | VM_WRITE)))
 			goto bad_area;
 	}
 
--- linux-2.6/arch/ia64/mm/fault.c.bak	2006-07-06 12:56:24.000000000 -0400
+++ linux-2.6/arch/ia64/mm/fault.c	2006-07-06 13:04:08.000000000 -0400
@@ -146,9 +146,11 @@ ia64_do_page_fault (unsigned long addres
 #		error File is out of sync with <linux/mm.h>.  Please update.
 #	endif
 
+	if (((isr >> IA64_ISR_R_BIT) & 1UL) && (!(vma->vm_flags & (VM_READ | VM_WRITE))))
+		goto bad_area;
+
 	mask = (  (((isr >> IA64_ISR_X_BIT) & 1UL) << VM_EXEC_BIT)
-		| (((isr >> IA64_ISR_W_BIT) & 1UL) << VM_WRITE_BIT)
-		| (((isr >> IA64_ISR_R_BIT) & 1UL) << VM_READ_BIT));
+		| (((isr >> IA64_ISR_W_BIT) & 1UL) << VM_WRITE_BIT));
 
 	if ((vma->vm_flags & mask) != mask)
 		goto bad_area;
--- linux-2.6/arch/ppc/mm/fault.c.bak	2006-07-06 13:23:09.000000000 -0400
+++ linux-2.6/arch/ppc/mm/fault.c	2006-07-06 13:23:57.000000000 -0400
@@ -239,7 +239,7 @@ good_area:
 		/* protection fault */
 		if (error_code & 0x08000000)
 			goto bad_area;
-		if (!(vma->vm_flags & (VM_READ | VM_EXEC)))
+		if (!(vma->vm_flags & (VM_READ | VM_EXEC | VM_WRITE)))
 			goto bad_area;
 	}
 
--- linux-2.6/arch/x86_64/mm/fault.c.bak	2006-07-06 13:25:12.000000000 -0400
+++ linux-2.6/arch/x86_64/mm/fault.c	2006-07-06 13:25:32.000000000 -0400
@@ -470,7 +470,7 @@ good_area:
 		case PF_PROT:		/* read, present */
 			goto bad_area;
 		case 0:			/* read, not present */
-			if (!(vma->vm_flags & (VM_READ | VM_EXEC)))
+			if (!(vma->vm_flags & (VM_READ | VM_EXEC | VM_WRITE)))
 				goto bad_area;
 	}
 
--- linux-2.6/arch/arm/mm/fault.c.bak	2006-07-06 13:26:07.000000000 -0400
+++ linux-2.6/arch/arm/mm/fault.c	2006-07-06 13:26:14.000000000 -0400
@@ -170,7 +170,7 @@ good_area:
 	if (fsr & (1 << 11)) /* write? */
 		mask = VM_WRITE;
 	else
-		mask = VM_READ|VM_EXEC;
+		mask = VM_READ|VM_EXEC|VM_WRITE;
 
 	fault = VM_FAULT_BADACCESS;
 	if (!(vma->vm_flags & mask))
--- linux-2.6/arch/m68k/mm/fault.c.bak	2006-07-06 13:06:42.000000000 -0400
+++ linux-2.6/arch/m68k/mm/fault.c	2006-07-06 13:07:17.000000000 -0400
@@ -144,7 +144,7 @@ good_area:
 		case 1:		/* read, present */
 			goto acc_err;
 		case 0:		/* read, not present */
-			if (!(vma->vm_flags & (VM_READ | VM_EXEC)))
+			if (!(vma->vm_flags & (VM_READ | VM_EXEC | VM_WRITE)))
 				goto acc_err;
 	}
 
--- linux-2.6/arch/i386/mm/fault.c.bak	2006-06-29 16:48:25.000000000 -0400
+++ linux-2.6/arch/i386/mm/fault.c	2006-07-06 11:13:09.000000000 -0400
@@ -449,7 +449,7 @@ good_area:
 		case 1:		/* read, present */
 			goto bad_area;
 		case 0:		/* read, not present */
-			if (!(vma->vm_flags & (VM_READ | VM_EXEC)))
+			if (!(vma->vm_flags & (VM_READ | VM_EXEC | VM_WRITE)))
 				goto bad_area;
 	}
 
 
