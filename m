Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S314291AbSEFI5l>; Mon, 6 May 2002 04:57:41 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S314295AbSEFI5j>; Mon, 6 May 2002 04:57:39 -0400
Received: from caramon.arm.linux.org.uk ([212.18.232.186]:38920 "EHLO
	caramon.arm.linux.org.uk") by vger.kernel.org with ESMTP
	id <S314291AbSEFI5X>; Mon, 6 May 2002 04:57:23 -0400
Date: Mon, 6 May 2002 09:57:15 +0100
From: Russell King <rmk@arm.linux.org.uk>
To: Daniel Phillips <phillips@bonn-fries.net>
Cc: Andrea Arcangeli <andrea@suse.de>,
        "Martin J. Bligh" <Martin.Bligh@us.ibm.com>,
        linux-kernel@vger.kernel.org
Subject: Re: Bug: Discontigmem virt_to_page() [Alpha,ARM,Mips64?]
Message-ID: <20020506095715.B17754@flint.arm.linux.org.uk>
In-Reply-To: <20020502180632.I11414@dualathlon.random> <E174Vq8-0004BK-00@starship> <20020506015505.B14956@flint.arm.linux.org.uk> <E174XqN-0004D2-00@starship>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, May 06, 2002 at 04:03:15AM +0200, Daniel Phillips wrote:
> On Monday 06 May 2002 02:55, Russell King wrote:
> > I see no problem with the above with the existing discontigmem stuff.
> > discontigmem does *not* require a linear relationship between kernel
> > virtual and physical memory.  I've been running kernels for a while
> > on such systems.
> 
> I just went through every variant of arm in the kernel tree, and I found that
> *all* of them implement a simple linear relationship between kernel virtual
> and physical memory, of the form:

Whoops.  I didn't say _current_ kernels, did I? 8)  (Don't write mails at
2am...)

We got rid of it later as we cleaned up the kernel mappings to use ioremap
instead of static device mappings.  Hence 2.4/2.5 don't contain them any
more.  However, from 2.3.35:

diff -urN linux-orig/include/asm-arm/arch-sa1100/memory.h linux/include/asm-arm/arch-sa1100/memory.h
...
 /*
  * The following gives a maximum memory size of 128MB (32MB in each bank).
- *
- * Does this still need to be optimised for one bank machines?
  */
-#define __virt_to_phys(x)      (((x) & 0xe0ffffff) | ((x) & 0x06000000) << 2)
-#define __phys_to_virt(x)      (((x) & 0xe7ffffff) | ((x) & 0x30000000) >> 2)
+#define __virt_to_phys(x)      (((x) & 0xf9ffffff) | ((x) & 0x06000000) << 2)
+#define __phys_to_virt(x)      (((x) & 0xe7ffffff) | ((x) & 0x18000000) >> 2)

This type of mapping went away in 2.4.0-test9, which is after this
particular platform got discontig mem support in 2.3.99-pre2-rmk1.

An example is right up to date, and was the subject of the first mail
is:

+#define __virt_to_phys(vpage)   (((vpage) + ((vpage) & 0x18000000)) & \
+                                 ~0x40000000)
+
+#define __phys_to_virt(ppage)   (((ppage) & ~0x30000000) | \
+                                 (((ppage) & 0x30000000) >> 1) | \
+                                 0x40000000)

You won't find this one in my patches nor Linus' kernel tree though.

-- 
Russell King (rmk@arm.linux.org.uk)                The developer of ARM Linux
             http://www.arm.linux.org.uk/personal/aboutme.html

