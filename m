Return-Path: <linux-kernel-owner+willy=40w.ods.org-S263616AbUECJeU@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263616AbUECJeU (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 3 May 2004 05:34:20 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263623AbUECJeT
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 3 May 2004 05:34:19 -0400
Received: from mail.fh-wedel.de ([213.39.232.194]:39580 "EHLO mail.fh-wedel.de")
	by vger.kernel.org with ESMTP id S263616AbUECJeS (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 3 May 2004 05:34:18 -0400
Date: Mon, 3 May 2004 11:33:54 +0200
From: =?iso-8859-1?Q?J=F6rn?= Engel <joern@wohnheim.fh-wedel.de>
To: =?iso-8859-1?Q?Jo=E3o?= Paulo Just Peixoto <jp@justsoft.com.br>
Cc: linux-kernel@vger.kernel.org, Linus Torvalds <torvalds@osdl.org>
Subject: Re: Warning messages
Message-ID: <20040503093354.GA21411@wohnheim.fh-wedel.de>
References: <20040501182035.8D4DD354843@mail3.dsgx.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20040501182035.8D4DD354843@mail3.dsgx.org>
User-Agent: Mutt/1.3.28i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 1 May 2004 22:55:59 +0100, linux-kernel-owner+joern=40wohnheim.fh-wedel.de-S262920AbUEBBnc@vger.kernel.org wrote:
> 
>     Everytime I compile the 2.6.5 Linux kernel I get these warning messages:
> 
>   AS	arch/i386/boot/setup.o
> /usr/src/linux-2.6.5/arch/i386/boot/setup.S: Assembler messages:
> /usr/src/linux-2.6.5/arch/i386/boot/setup.S:159: Warning: value 0x37ffffff truncated to 0x37ffffff
> 
>     What does it mean?

That the kernel depends on a funny side effect of the assembler.  It's
harmless, but if you don't like it, apply the patch below.  Linus,
would you consider it as well?

Jörn

-- 
When in doubt, use brute force.
-- Ken Thompson


The warning is correct, the calculated value for ramdisk_max would be
0xb7ffffff instead of 0x37ffffff.  Truncating 0xb7ffffff to 0x37ffffff
is desired behaviour, so we should do it explicitly.

 setup.S |    3 ++-
 1 files changed, 2 insertions(+), 1 deletion(-)

--- linux-2.6.1/arch/i386/boot/setup.S~initrd_warning	2004-03-09 11:37:29.000000000 +0100
+++ linux-2.6.1/arch/i386/boot/setup.S	2004-03-09 11:38:59.000000000 +0100
@@ -162,7 +162,8 @@
 					# can be located anywhere in
 					# low memory 0x10000 or higher.
 
-ramdisk_max:	.long MAXMEM-1		# (Header version 0x0203 or later)
+ramdisk_max:	.long (MAXMEM-1) & 0x7fffffff
+					# (Header version 0x0203 or later)
 					# The highest safe address for
 					# the contents of an initrd
 
