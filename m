Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265555AbUANBBI (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 13 Jan 2004 20:01:08 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265592AbUANBBI
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 13 Jan 2004 20:01:08 -0500
Received: from modemcable178.89-70-69.mc.videotron.ca ([69.70.89.178]:45187
	"EHLO montezuma.fsmlabs.com") by vger.kernel.org with ESMTP
	id S265555AbUANBBC (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 13 Jan 2004 20:01:02 -0500
Date: Tue, 13 Jan 2004 20:00:10 -0500 (EST)
From: Zwane Mwaikambo <zwane@arm.linux.org.uk>
To: James Cleverdon <jamesclv@us.ibm.com>
cc: Andrew Morton <akpm@osdl.org>, linux-kernel@vger.kernel.org,
       Linus Torvalds <torvalds@osdl.org>, Chris McDermott <lcm@us.ibm.com>,
       "Martin J. Bligh" <mbligh@aracnet.com>
Subject: Re: [PATCH] 2.6.1-mm2: Get irq_vector size right for generic subarch
 UP installer kernels
In-Reply-To: <200401131627.02138.jamesclv@us.ibm.com>
Message-ID: <Pine.LNX.4.58.0401131957420.18388@montezuma.fsmlabs.com>
References: <200401131627.02138.jamesclv@us.ibm.com>
MIME-Version: 1.0
Content-Type: MULTIPART/Mixed; BOUNDARY="Boundary-00=_WzIBAILudZL8oQ+"
Content-ID: <Pine.LNX.4.58.0401131957421.18388@montezuma.fsmlabs.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.
  Send mail to mime@docserver.cac.washington.edu for more info.

--Boundary-00=_WzIBAILudZL8oQ+
Content-Type: TEXT/PLAIN; CHARSET=US-ASCII
Content-ID: <Pine.LNX.4.58.0401131957422.18388@montezuma.fsmlabs.com>
Content-Disposition: INLINE

On Tue, 13 Jan 2004, James Cleverdon wrote:

> Problem:  Earlier I didn't consider the case of the generic sub-arch and
> uni-proc installer kernels used by a number of distros.  It currently is
> scaled by NR_CPUS.  The correct values should be big for summit and generic,
> and can stay the same for all others.

This all looks strange, especially in assign_irq_vector() does this
mean that you'll try and allocate up to 1024 vectors?

> diff -pru 2.6.1-mm2/include/asm-i386/mach-default/irq_vectors.h
> t1mm2/include/asm-i386/mach-default/irq_vectors.h
> --- 2.6.1-mm2/include/asm-i386/mach-default/irq_vectors.h	2004-01-08
> 22:59:19.000000000 -0800
> +++ t1mm2/include/asm-i386/mach-default/irq_vectors.h	2004-01-13
> 13:43:56.000000000 -0800
> @@ -90,8 +90,12 @@
>  #else
>  #ifdef CONFIG_X86_IO_APIC
>  #define NR_IRQS 224
> -# if (224 >= 32 * NR_CPUS)
> -# define NR_IRQ_VECTORS NR_IRQS
> +/*
> + * For Summit or generic (i.e. installer) kernels, we have lots of I/O APICs,
> + * even with uni-proc kernels, so use a big array.
> + */
> +# if defined(CONFIG_X86_SUMMIT) || defined(CONFIG_X86_GENERICARCH)
> +# define NR_IRQ_VECTORS 1024
>  # else
>  # define NR_IRQ_VECTORS (32 * NR_CPUS)
>  # endif

--Boundary-00=_WzIBAILudZL8oQ+
Content-Type: TEXT/X-DIFF; CHARSET=us-ascii; NAME="irq_vector_2004-01-13_2.6.1-mm2"
Content-ID: <Pine.LNX.4.58.0401131957423.18388@montezuma.fsmlabs.com>
Content-Description: 
Content-Disposition: ATTACHMENT; FILENAME="irq_vector_2004-01-13_2.6.1-mm2"

diff -pru 2.6.1-mm2/include/asm-i386/mach-default/irq_vectors.h t1mm2/include/asm-i386/mach-default/irq_vectors.h
--- 2.6.1-mm2/include/asm-i386/mach-default/irq_vectors.h	2004-01-08 22:59:19.000000000 -0800
+++ t1mm2/include/asm-i386/mach-default/irq_vectors.h	2004-01-13 13:43:56.000000000 -0800
@@ -90,8 +90,12 @@
 #else
 #ifdef CONFIG_X86_IO_APIC
 #define NR_IRQS 224
-# if (224 >= 32 * NR_CPUS)
-# define NR_IRQ_VECTORS NR_IRQS
+/*
+ * For Summit or generic (i.e. installer) kernels, we have lots of I/O APICs,
+ * even with uni-proc kernels, so use a big array.
+ */
+# if defined(CONFIG_X86_SUMMIT) || defined(CONFIG_X86_GENERICARCH)
+# define NR_IRQ_VECTORS 1024
 # else
 # define NR_IRQ_VECTORS (32 * NR_CPUS)
 # endif

--Boundary-00=_WzIBAILudZL8oQ+--
