Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129842AbRAKLR7>; Thu, 11 Jan 2001 06:17:59 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S130370AbRAKLRu>; Thu, 11 Jan 2001 06:17:50 -0500
Received: from passion.cambridge.redhat.com ([172.16.18.67]:60288 "EHLO
	passion.cambridge.redhat.com") by vger.kernel.org with ESMTP
	id <S129842AbRAKLRl>; Thu, 11 Jan 2001 06:17:41 -0500
X-Mailer: exmh version 2.2 06/23/2000 with nmh-1.0.4
From: David Woodhouse <dwmw2@infradead.org>
X-Accept-Language: en_GB
In-Reply-To: <Pine.LNX.4.30.0101101737240.30973-100000@devserv.devel.redhat.com> 
In-Reply-To: <Pine.LNX.4.30.0101101737240.30973-100000@devserv.devel.redhat.com> 
To: Ingo Molnar <mingo@redhat.com>
Cc: Alan Cox <alan@lxorguk.ukuu.org.uk>, Keith Owens <kaos@ocs.com.au>,
        Nathan Walp <faceprint@faceprint.com>, Hans Grobler <grobh@sun.ac.za>,
        linux-kernel@vger.kernel.org
Subject: Re: Oops in 2.4.0-ac5 
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Date: Thu, 11 Jan 2001 11:15:55 +0000
Message-ID: <1605.979211755@redhat.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


mingo@redhat.com said:
>  i prefer clear oopses and bug reports instead of ignoring them. A
> failed MSR write is not something to be taken easily. MSR writes if
> fail mean that there is a serious kernel bug - we want to stop the
> kernel and complain ASAP. And correct code will be much more readable
> that way.

The bug here seems to be that we're using the same bit (X86_FEATURE_APIC) to
report two _different_ features. 

We don't represent X86_FEATURE_CXMMX and X86_FEATURE_MMX with the same bit, 
even though they are supposed to provide the same functionality - because 
they are in fact different. Likewise we shouldn't use the same bit for the 
two different types of APIC, IMO.

Index: include/asm-i386/cpufeature.h
===================================================================
RCS file: /inst/cvs/linux/include/asm-i386/Attic/cpufeature.h,v
retrieving revision 1.1.2.1
diff -u -r1.1.2.1 cpufeature.h
--- include/asm-i386/cpufeature.h	2000/12/05 13:30:46	1.1.2.1
+++ include/asm-i386/cpufeature.h	2001/01/11 11:12:41
@@ -62,6 +62,7 @@
 #define X86_FEATURE_K6_MTRR	(3*32+ 1) /* AMD K6 nonstandard MTRRs */
 #define X86_FEATURE_CYRIX_ARR	(3*32+ 2) /* Cyrix ARRs (= MTRRs) */
 #define X86_FEATURE_CENTAUR_MCR	(3*32+ 3) /* Centaur MCRs (= MTRRs) */
+#define X86_FEATURE_AMD_APIC	(3*32+ 4) /* AMD Athlon CPU-local APIC */
 
 #endif /* __ASM_I386_CPUFEATURE_H */
 
Index: arch/i386/kernel/setup.c
===================================================================
RCS file: /inst/cvs/linux/arch/i386/kernel/setup.c,v
retrieving revision 1.4.2.47
diff -u -r1.4.2.47 setup.c
--- arch/i386/kernel/setup.c	2001/01/01 12:56:13	1.4.2.47
+++ arch/i386/kernel/setup.c	2001/01/11 11:12:41
@@ -1058,6 +1058,11 @@
 			break;
 
 		case 6:	/* An Athlon/Duron. We can trust the BIOS probably */
+			if (test_bit(X86_FEATURE_APIC, &c->x86_capability)) {
+				/* Not a compatible APIC */
+				clear_bit(X86_FEATURE_APIC, &c->x86_capability);
+				set_bit(X86_FEATURE_AMD_APIC, &c->x86_capability);
+			}
 			break;		
 	}
 

--
dwmw2


-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
