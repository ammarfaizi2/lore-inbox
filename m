Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S287145AbSAHJPC>; Tue, 8 Jan 2002 04:15:02 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S287177AbSAHJOw>; Tue, 8 Jan 2002 04:14:52 -0500
Received: from e1.ny.us.ibm.com ([32.97.182.101]:16634 "EHLO e1.ny.us.ibm.com")
	by vger.kernel.org with ESMTP id <S287145AbSAHJOf>;
	Tue, 8 Jan 2002 04:14:35 -0500
Message-Id: <200201080914.g089EHq21694@butler1.beaverton.ibm.com>
Content-Type: text/plain; charset=US-ASCII
From: James Cleverdon <jamesclv@us.ibm.com>
Reply-To: jamesclv@us.ibm.com
Organization: IBM xSeries Linux (NUMA)
To: Marcelo Tosatti <marcelo@conectiva.com.br>
Subject: Re: [PATCH] MAX_MP_BUSSES increase
Date: Tue, 8 Jan 2002 01:14:16 -0800
X-Mailer: KMail [version 1.3.1]
In-Reply-To: <Pine.LNX.4.21.0112261341470.9842-100000@freak.distro.conectiva>
In-Reply-To: <Pine.LNX.4.21.0112261341470.9842-100000@freak.distro.conectiva>
Cc: linux-kernel@vger.kernel.org, Linus Torvalds <torvalds@transmeta.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Back from holiday.

On Wednesday 26 December 2001 07:43 am, Marcelo Tosatti wrote:
> James,
>
> Don't remove the "#ifdef CONFIG_MULTIQUAD" on your patch: Let the old max
> (32) for non-multiquad machines.

There's a problem with that -- despite its name, CONFIG_MULTIQUAD is used for 
the old NUMA-Q hardware.  It turns on some memory mapped port I/O code that 
doesn't have any purpose for other machines.  The PCI bus overflow happens on 
our new Foster-based boxes that may or may not contain multiple quad CPU 
boards.

Still, CONFIG_MULTIQUAD is better than nothing.  It just may take a little 
bit of redefinition, so long as we can coax the various distros to build 
their installation and working kernels with CONFIG_MULTIQUAD turned on....

> Please resend me the patch this way.

OK, what do you think about this:

diff -ru 2.4.17/include/asm-i386/mpspec.h 
jamesc-2.4.17/include/asm-i386/mpspec.h
--- 2.4.17/include/asm-i386/mpspec.h	Thu Nov 22 11:46:18 2001
+++ jamesc-2.4.17/include/asm-i386/mpspec.h	Tue Jan  8 01:00:12 2002
@@ -185,12 +186,13 @@
  */
 
 #ifdef CONFIG_MULTIQUAD
-#define MAX_IRQ_SOURCES 512
+#define MAX_MP_BUSSES	257	/* Need max PCI busses for hotplug + 1 for ISA. */
+#define MAX_IRQ_SOURCES (MAX_MP_BUSSES * 4)	/* Four intrs per PCI slot. */
 #else /* !CONFIG_MULTIQUAD */
+#define MAX_MP_BUSSES	32
 #define MAX_IRQ_SOURCES 256
 #endif /* CONFIG_MULTIQUAD */
 
-#define MAX_MP_BUSSES 32
 enum mp_bustype {
 	MP_BUS_ISA = 1,
 	MP_BUS_EISA,



> On Wed, 19 Dec 2001, James Cleverdon wrote:
> > We've run into a bit of a problem with a forthcoming system.  The BIOS
> > reserves so many PCI bus numbers for hotplug when maxed out PCI expansion
> > box(es) are present that some arrays (mp_bus_id_to_node[],
> > mp_bus_id_to_pci_bus[], etc) overflow, splattering important variables.

-- 
James Cleverdon, IBM xSeries Platform (NUMA), Beaverton
jamesclv@us.ibm.com   |   cleverdj@us.ibm.com

