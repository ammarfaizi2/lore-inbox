Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S315468AbSE2Ujs>; Wed, 29 May 2002 16:39:48 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S315480AbSE2Ujq>; Wed, 29 May 2002 16:39:46 -0400
Received: from parcelfarce.linux.theplanet.co.uk ([195.92.249.252]:47887 "EHLO
	www.linux.org.uk") by vger.kernel.org with ESMTP id <S315476AbSE2UjS>;
	Wed, 29 May 2002 16:39:18 -0400
Message-ID: <3CF53C03.5040301@mandrakesoft.com>
Date: Wed, 29 May 2002 16:37:23 -0400
From: Jeff Garzik <jgarzik@mandrakesoft.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.0rc2) Gecko/00200205
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: "J.A. Magallon" <jamagallon@able.es>
CC: Lista Linux-Kernel <linux-kernel@vger.kernel.org>,
        Alan Cox <alan@lxorguk.ukuu.org.uk>, davej@suse.de,
        Linus Torvalds <torvalds@transmeta.com>
Subject: Re: [PATCH] intel-x86 model config cleanup
In-Reply-To: <20020529143544.GA2224@werewolf.able.es>
Content-Type: text/plain; charset=ISO-8859-15; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

J.A. Magallon wrote:

>Hi all..
>
>One other try.
>
>This is an attempt to clean up the CPU model flags. Changes:
>
>- change names for CONFIG_Mxxxx, trying to make them more intuitive
>- split PII from PPro
>- introduce X86_F00F config flag and fixmap fix.
>- kill CONFIG_M586 as independent flag, and make it just an
>  extra flag for 586 (I couldnt get a better name for
>  MGEN586, suggestions wellcome...)
>- kill CONFIG_M686 as independent flag, and make it just an
>  extra flag for anything >= PPro.
>- change option order definition to avoid duplicates, like:
>
>if [ "$CONFIG_MPENTIUM" = "y" ]; then
>   define_bool CONFIG_M586 y         <==============
>   define_bool CONFIG_X86_TSC y
>fi
>if [ "$CONFIG_MPENTIUMMMX" = "y" ]; then
>   define_bool CONFIG_M586 y         <==============
>   define_bool CONFIG_X86_TSC y
>   define_bool CONFIG_X86_GOOD_APIC y
>fi
>if [ "$CONFIG_M586" = "y" ]; then <======== common things here
>   define_int  CONFIG_X86_L1_CACHE_SHIFT 5
>   define_bool CONFIG_X86_USE_STRING_486 y
>   define_bool CONFIG_X86_ALIGNMENT_16 y
>   define_bool CONFIG_X86_PPRO_FENCE y
>   define_bool CONFIG_X86_F00F_BUG y
>fi 
>
>Patch follows:
>
>diff -ruN linux-2.4.19-pre9-jam1/Documentation/Configure.help linux-2.4.19-pre9-jam1-arch/Documentation/Configure.help
>--- linux-2.4.19-pre9-jam1/Documentation/Configure.help	Wed May 29 11:50:43 2002
>+++ linux-2.4.19-pre9-jam1-arch/Documentation/Configure.help	Wed May 29 11:52:18 2002
>@@ -3943,16 +3943,17 @@
>   a PPro, but not necessarily on a i486.
> 
>   Here are the settings recommended for greatest speed:
>-   - "386" for the AMD/Cyrix/Intel 386DX/DXL/SL/SLC/SX, Cyrix/TI
>+   - "Generic-386" for the AMD/Cyrix/Intel 386DX/DXL/SL/SLC/SX, Cyrix/TI
>      486DLC/DLC2, UMC 486SX-S and NexGen Nx586.  Only "386" kernels
>      will run on a 386 class machine.
>-   - "486" for the AMD/Cyrix/IBM/Intel 486DX/DX2/DX4 or
>+   - "Generic-486" for the AMD/Cyrix/IBM/Intel 486DX/DX2/DX4 or
>      SL/SLC/SLC2/SLC3/SX/SX2 and UMC U5D or U5S.
>-   - "586" for generic Pentium CPUs, possibly lacking the TSC
>+   - "Generic-586" for generic Pentium CPUs, possibly lacking the TSC
>      (time stamp counter) register.
>-   - "Pentium-Classic" for the Intel Pentium.
>+   - "Pentium" for the Intel Pentium.
>    - "Pentium-MMX" for the Intel Pentium MMX.
>-   - "Pentium-Pro" for the Intel Pentium Pro/Celeron/Pentium II.
>+   - "Pentium-Pro" for the Intel Pentium Pro.
>+   - "Pentium-II" for the Intel Pentium II / Celeron.
>    - "Pentium-III" for the Intel Pentium III
>      and Celerons based on the Coppermine core.
>    - "Pentium-4" for the Intel Pentium 4.
>  
>

Since you are playing in this area, I wonder if you would consider doing 
something that has been needed for a while:
Individual CPU selection.

This implies separating the concept of a "generic x86 kernel that 
supports N CPU types" from "kernel supports one CPU type and one only." 
 The i386/config.in is currently a mishmash of both.  Dave Jones did 
some work along these lines in his "cpuchoice" diff, which I have attached.

Basically, the general direction IMO should be:  a user can select the 
CPU they own (Pentium-II), and none of the options for Pentium 
3/4/Athlon will be enabled.  Generic kernels would ask for a minimal CPU 
level to support, I imagine.  Support >=486, >=586, etc.  Pretty much 
what we have now.

    Jeff





