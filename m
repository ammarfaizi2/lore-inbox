Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S284890AbSAULtw>; Mon, 21 Jan 2002 06:49:52 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S284902AbSAULtm>; Mon, 21 Jan 2002 06:49:42 -0500
Received: from gold.MUSKOKA.COM ([216.123.107.5]:26376 "EHLO gold.muskoka.com")
	by vger.kernel.org with ESMTP id <S284890AbSAULtg>;
	Mon, 21 Jan 2002 06:49:36 -0500
Message-ID: <3C4C0056.4F50C3D6@yahoo.com>
Date: Mon, 21 Jan 2002 06:49:42 -0500
From: Paul Gortmaker <p_gortmaker@yahoo.com>
X-Mailer: Mozilla 3.04 (X11; I; Linux 2.2.20 i586)
MIME-Version: 1.0
To: esr@thyrsus.com
CC: Dave Jones <davej@suse.de>, Jeff Garzik <jgarzik@mandrakesoft.com>,
        Linux Kernel List <linux-kernel@vger.kernel.org>
Subject: Re: Calling EISA experts
In-Reply-To: <20020117015456.A628@thyrsus.com> <20020117121723.B22171@suse.de> <3C46B718.26F52BD5@mandrakesoft.com> <20020117124849.F22171@suse.de> <20020117085056.B7299@thyrsus.com>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Eric S. Raymond wrote:

> Bingo.  I've got reliable /proc tests for ISAPNP, PCI, and MCA.  Previous
> discussion indicates I can't get one for ISA classic.  An EISA test would,
> as ever, allow me to cut the number of questions about ancient dead
> hardware that users have to see.

Minimal approach: Register motherboard EISA ID (i.e. slot zero) ports in
/proc/ioports.  Works on all kernel versions.  See $0.02 patch below.

This is probably the least intrusive way to get what you want.  It doesn't
add Yet Another Proc File, and costs zero bloat to the 99.9% of us who 
have a better chance of meeting Aunt Tillie than an EISA box. 

Possible alternative: Create something like /proc/bus/eisa/devices which
lists the EISA ID (e.g. abc0123) found in each EISA slot.   This might
have been worthwhile some 8 years ago, but now? ....

Paul.


--- arch/i386/kernel/setup.c~	Tue Nov  6 19:14:03 2001
+++ arch/i386/kernel/setup.c	Mon Jan 21 06:22:15 2002
@@ -122,6 +122,7 @@
  */
 #ifdef CONFIG_EISA
 int EISA_bus;
+struct resource eisa_id = { "EISA ID", 0xc80, 0xc83, IORESOURCE_BUSY };
 #endif
 int MCA_bus;
 
@@ -1020,6 +1021,11 @@
 	/* request I/O space for devices used on all i[345]86 PCs */
 	for (i = 0; i < STANDARD_IO_RESOURCES; i++)
 		request_resource(&ioport_resource, standard_io_resources+i);
+
+#ifdef CONFIG_EISA
+	if (EISA_bus)
+		request_resource(&ioport_resource, &eisa_id);
+#endif
 
 	/* Tell the PCI layer not to allocate too close to the RAM area.. */
 	low_mem_size = ((max_low_pfn << PAGE_SHIFT) + 0xfffff) & ~0xfffff;

