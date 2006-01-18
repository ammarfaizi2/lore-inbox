Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030238AbWARLtR@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030238AbWARLtR (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 18 Jan 2006 06:49:17 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030241AbWARLtR
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 18 Jan 2006 06:49:17 -0500
Received: from ozlabs.org ([203.10.76.45]:61319 "EHLO ozlabs.org")
	by vger.kernel.org with ESMTP id S1030238AbWARLtQ (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 18 Jan 2006 06:49:16 -0500
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-ID: <17358.11049.367188.552649@cargo.ozlabs.ibm.com>
Date: Wed, 18 Jan 2006 22:48:57 +1100
From: Paul Mackerras <paulus@samba.org>
To: Andrew Morton <akpm@osdl.org>
Cc: "Jan Beulich" <JBeulich@novell.com>, linux-kernel@vger.kernel.org,
       Andi Kleen <ak@muc.de>,
       Benjamin Herrenschmidt <benh@kernel.crashing.org>
Subject: Re: [PATCH] CONFIG_UNWIND_INFO
In-Reply-To: <20060114045635.1462fb9e.akpm@osdl.org>
References: <4370AF4A.76F0.0078.0@novell.com>
	<20060114045635.1462fb9e.akpm@osdl.org>
X-Mailer: VM 7.19 under Emacs 21.4.1
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Andrew Morton writes:

> If you do a `make oldconfig' with CONFIG_DEBUG_KERNEL you get
> -fasynchronous-unwind-tables and (on my yellowdog-4 toolchain at least) the
> ppc64 kernel doesn't like that one bit. 
> 
> 
> EXT3-fs: mounted filesystem with ordered data mode.
> ADDRCONF(NETDEV_UP): eth0: link is not ready
> tg3: eth0: Link is up at 100 Mbps, full duplex.
> tg3: eth0: Flow control is off for TX and off for RX.
> ADDRCONF(NETDEV_CHANGE): eth0: link becomes ready
> autofs: Unknown ADD relocation: 44
> sunrpc: Unknown ADD relocation: 44

We aren't handling R_PPC64_REL64 relocations in our module code.  This
patch (completely untested :) might help.

Paul.

diff --git a/arch/powerpc/kernel/module_64.c b/arch/powerpc/kernel/module_64.c
index 928b858..4885f39 100644
--- a/arch/powerpc/kernel/module_64.c
+++ b/arch/powerpc/kernel/module_64.c
@@ -337,6 +337,10 @@ int apply_relocate_add(Elf64_Shdr *sechd
 			*(unsigned long *)location = value;
 			break;
 
+		case R_PPC64_REL64:
+			*location = value - (unsigned long) location;
+			break;
+
 		case R_PPC64_TOC:
 			*(unsigned long *)location = my_r2(sechdrs, me);
 			break;
