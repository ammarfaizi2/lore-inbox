Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262806AbTBKQCv>; Tue, 11 Feb 2003 11:02:51 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S265532AbTBKQCv>; Tue, 11 Feb 2003 11:02:51 -0500
Received: from chaos.physics.uiowa.edu ([128.255.34.189]:7847 "EHLO
	chaos.physics.uiowa.edu") by vger.kernel.org with ESMTP
	id <S262806AbTBKQCt>; Tue, 11 Feb 2003 11:02:49 -0500
Date: Tue, 11 Feb 2003 10:12:27 -0600 (CST)
From: Kai Germaschewski <kai@tp1.ruhr-uni-bochum.de>
X-X-Sender: kai@chaos.physics.uiowa.edu
To: "Martin J. Bligh" <mbligh@aracnet.com>
cc: linux-kernel <linux-kernel@vger.kernel.org>
Subject: Re: [Bug 337] New: build breakage for module versioning support 
In-Reply-To: <83000000.1044979297@[10.10.2.4]>
Message-ID: <Pine.LNX.4.44.0302111010370.26687-100000@chaos.physics.uiowa.edu>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 11 Feb 2003, Martin J. Bligh wrote:

> http://bugme.osdl.org/show_bug.cgi?id=337
> 
>            Summary: build breakage for module versioning support
>     Kernel Version: 2.5.60, 2.5.60-bk1
>             Status: NEW
>           Severity: normal
>              Owner: bugme-janitors@lists.osdl.org
>          Submitter: john@larvalstage.com
> 
> 
> Problem Description:
> 
> Enabling module versioning support causes build breakage.
> 
>   gcc -Wp,-MD,arch/i386/kernel/.time.o.d -D__KERNEL__ -Iinclude -Wall
> -Wstrict-prototypes -Wno-trigraphs -O2 -fno-strict-aliasing -fno-common
> -pipe -mpreferred-stack-boundary=2 -march=athlon
> -Iinclude/asm-i386/mach-default -nostdinc -iwithprefix include
> -DKBUILD_BASENAME=time -DKBUILD_MODNAME=time -c -o
> arch/i386/kernel/.tmp_time.o arch/i386/kernel/time.c
> ld:arch/i386/kernel/.tmp_time.ver:1: parse error
> make[1]: *** [arch/i386/kernel/time.o] Error 1
> make: *** [arch/i386/kernel] Error 2

That's caused by a sed incompatibility.
Fix already posted on l-k: (I'll submit it to Linus)

===== scripts/Makefile.build 1.27 vs edited =====
--- 1.27/scripts/Makefile.build	Sat Feb  8 14:30:33 2003
+++ edited/scripts/Makefile.build	Mon Feb 10 15:25:44 2003
@@ -94,7 +94,7 @@
 	else								      \
 		$(CPP) -D__GENKSYMS__ $(c_flags) $<			      \
 		| $(GENKSYMS) -k $(VERSION).$(PATCHLEVEL).$(SUBLEVEL)	      \
-		| sed -n 's/\#define __ver_\(\w*\)\W*\(\w*\)/__crc_\1 = 0x\2 ;/gp' \
+		| sed -n 's/\#define __ver_\([^ 	]*\)[ 	]*\([^ 	]*\)/__crc_\1 = 0x\2 ;/gp' \
 		> $(@D)/.tmp_$(@F:.o=.ver);				      \
 									      \
 		$(LD) $(LDFLAGS) -r -o $@ $(@D)/.tmp_$(@F) 		      \

