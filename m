Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262328AbUCCBMN (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 2 Mar 2004 20:12:13 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262310AbUCCBMN
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 2 Mar 2004 20:12:13 -0500
Received: from pxy1allmi.all.mi.charter.com ([24.247.15.38]:16574 "EHLO
	proxy1.gha.chartermi.net") by vger.kernel.org with ESMTP
	id S262330AbUCCBL7 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 2 Mar 2004 20:11:59 -0500
Message-ID: <40453094.6070604@quark.didntduck.org>
Date: Tue, 02 Mar 2004 20:10:44 -0500
From: Brian Gerst <bgerst@didntduck.org>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.6) Gecko/20040116
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Art Haas <ahaas@airmail.net>
CC: linux-kernel@vger.kernel.org
Subject: Re: [PATCH] Compile kernel with GCC-3.5 and without regparm
References: <20040303002339.GA20651@artsapartment.org>
In-Reply-To: <20040303002339.GA20651@artsapartment.org>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
X-Charter-MailScanner-Information: 
X-Charter-MailScanner: 
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Art Haas wrote:
> Hi.
> 
> I tried to build the kernel with my CVS GCC-3.5 compiler today, and had
> all sorts of failures about prototypes not matching. My configuration
> had not selected the 'CONFIG_REGPARM' option, so the new '-mregparm=3'
> flag wasn't passed to the compiler. That's fine, but the problem is the
> FASTCALL macro is unconditionally defined to add an regparm(3)
> attribute, making the compiler quite confused. The following small patch
> conditionally defines FASTCALL, and allowed my compilation to succeed
> either with or without the CONFIG_REGPARM conditional being defined.
> 
> I tested this patch by configuring a kernel without the CONFIG_REGPARM
> flag, then started the build. Once the build got through building a
> couple of files in 'arch/i386/kernel' that had failed previously, I
> stopped the build. A cleanup and reconfiguration with the CONFIG_REGPARM
> conditional followed, and a new build began. Again, the files in the
> same directory compiled fine, so things looked good. I then tried to
> build with CONFIG_REGPARM defined and setting CC and HOSTCC to use
> my gcc-2.95 compiler, and the files in that directory compiled again
> successfully once more.
> 
> If this patch is deemed correct, a similar patch for 'asm-um' is
> likely necessary as well.
> 
> Art Haas
> 
> ===== include/asm-i386/linkage.h 1.2 vs edited =====
> --- 1.2/include/asm-i386/linkage.h	Sun Aug  4 00:44:49 2002
> +++ edited/include/asm-i386/linkage.h	Tue Mar  2 17:59:59 2004
> @@ -2,7 +2,9 @@
>  #define __ASM_LINKAGE_H
>  
>  #define asmlinkage CPP_ASMLINKAGE __attribute__((regparm(0)))
> +#ifdef CONFIG_REGPARM
>  #define FASTCALL(x)	x __attribute__((regparm(3)))
> +#endif
>  
>  #ifdef CONFIG_X86_ALIGNMENT_16
>  #define __ALIGN .align 16,0x90

You can't do this.  Some of these functions are called from asm code 
which assumes that parameters are passed in registers.  The right fix is 
to make the prototypes and function match.

--
				Brian Gerst
