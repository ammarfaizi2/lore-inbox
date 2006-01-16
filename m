Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932187AbWAPHGY@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932187AbWAPHGY (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 16 Jan 2006 02:06:24 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932188AbWAPHGY
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 16 Jan 2006 02:06:24 -0500
Received: from smtp.osdl.org ([65.172.181.4]:60394 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S932187AbWAPHGX (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 16 Jan 2006 02:06:23 -0500
Date: Sun, 15 Jan 2006 23:05:57 -0800
From: Andrew Morton <akpm@osdl.org>
To: "Serge E. Hallyn" <serue@us.ibm.com>
Cc: linux-kernel@vger.kernel.org, paulus@au1.ibm.com, anton@au1.ibm.com,
       linuxppc64-dev@ozlabs.org
Subject: Re: 2.6.15-mm4 failure on power5
Message-Id: <20060115230557.0f07a55c.akpm@osdl.org>
In-Reply-To: <20060116063530.GB23399@sergelap.austin.ibm.com>
References: <20060116063530.GB23399@sergelap.austin.ibm.com>
X-Mailer: Sylpheed version 1.0.4 (GTK+ 1.2.10; i386-redhat-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

"Serge E. Hallyn" <serue@us.ibm.com> wrote:
>
> On my power5 partition, 2.6.15-mm4 hangs on boot with the following
>  console output.  2.6.15-mm3 booted fine.  .config attached.
> 
>  boot: quicktest
>  Please wait, loading kernel...
>     Elf64 kernel loaded...
>  OF stdout device is: /vdevice/vty@30000000
>  Hypertas detected, assuming LPAR !
>  command line: ro console=hvc0 root=/dev/sda6 smt-enabled=1 
>  memory layout at init:
>    memory_limit : 0000000000000000 (16 MB aligned)
>    alloc_bottom : 0000000002223000
>    alloc_top    : 0000000008000000
>    alloc_top_hi : 0000000088000000
>    rmo_top      : 0000000008000000
>    ram_top      : 0000000088000000
>  Looking for displays
>  instantiating rtas at 0x00000000077d7000 ... done
>  0000000000000000 : boot cpu     0000000000000000
>  0000000000000002 : starting cpu hw idx 0000000000000002... done
>  0000000000000004 : starting cpu hw idx 0000000000000004... done
>  0000000000000006 : starting cpu hw idx 0000000000000006... done
>  copying OF device tree ...
>  Building dt strings...
>  Building dt structure...
>  Device tree strings 0x0000000002424000 -> 0x0000000002424f36
>  Device tree struct  0x0000000002425000 -> 0x000000000242c000
>  Calling quiesce ...
>  returning from prom_init
>  Page orders: linear mapping = 24, others = 12

It might be worth reverting the changes to arch/powerpc/mm/hash_utils_64.c,
see if that unbreaks it.

-		base = lmb.memory.region[i].base + KERNELBASE;
+		base = (unsigned long)__va(lmb.memory.region[i].base);

The nice comment in page.h:

 * KERNELBASE is the virtual address of the start of the kernel, it's often
 * the same as PAGE_OFFSET, but _might not be_.
 *
 * The kdump dump kernel is one example where KERNELBASE != PAGE_OFFSET.
 *
 * To get a physical address from a virtual one you subtract PAGE_OFFSET,
 * _not_ KERNELBASE.

Tells us that was not an equivalent transformation.
