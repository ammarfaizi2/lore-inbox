Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S315529AbSGXAjl>; Tue, 23 Jul 2002 20:39:41 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S315540AbSGXAjl>; Tue, 23 Jul 2002 20:39:41 -0400
Received: from jalon.able.es ([212.97.163.2]:32948 "EHLO jalon.able.es")
	by vger.kernel.org with ESMTP id <S315529AbSGXAjk>;
	Tue, 23 Jul 2002 20:39:40 -0400
Date: Wed, 24 Jul 2002 02:42:45 +0200
From: "J.A. Magallon" <jamagallon@able.es>
To: Lista Linux-Kernel <linux-kernel@vger.kernel.org>
Subject: [RFC] x86 cpu selection cleanup
Message-ID: <20020724004245.GE3622@werewolf.able.es>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Disposition: inline
Content-Transfer-Encoding: 7BIT
X-Mailer: Balsa 1.3.6
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

HI all...

I have introduced in the -jam kernels a cleanup for the x86 cpu selection that
can make things easier for future work.
The patches apply on top of -rc3-aa1, but if there is general interest I can
make them for plain rc3 (or better for final, I know, an rc is not place for
this).

Steps:
- Introduce CONFIG_X86_F00F_BUG (credits to Brian Gerst)
- Make CONFIG_M586 a generic option, not set directly but dependent on
  processor specific configs, like GEN586 (generic 586), PENTIUM (a real
  intel pentium), PENTIUMMMX
- Make CONFIG_M686 a generic option, not set directly but dependent on
  MPENTIUMPRO, MPENTIUM2, MPENTIUM3, MPENTIUM4 (so I splitted PII from
  PPro, both were 686).

(now that I think, I could even name it CONFIG_X86_586 and CONFIG_X86_686,
they are an abstract of what _X86_ features are available)

Things end like this for 586:

if [ "$CONFIG_MGEN586" = "y" ]; then
   define_bool CONFIG_M586 y 
fi 
if [ "$CONFIG_MPENTIUM" = "y" ]; then
   define_bool CONFIG_M586 y
   define_bool CONFIG_X86_TSC_CPU y
fi 
if [ "$CONFIG_MPENTIUMMMX" = "y" ]; then
   define_bool CONFIG_M586 y 
   define_bool CONFIG_X86_TSC_CPU y
   define_bool CONFIG_X86_GOOD_APIC y
fi
if [ "$CONFIG_M586" = "y" ]; then
   define_int  CONFIG_X86_L1_CACHE_SHIFT 5
   define_bool CONFIG_X86_USE_STRING_486 y
   define_bool CONFIG_X86_ALIGNMENT_16 y
   define_bool CONFIG_X86_PPRO_FENCE y
   define_bool CONFIG_X86_F00F_BUG y
fi

And like this for 686:

if [ "$CONFIG_MPENTIUMPRO" = "y" ]; then
   define_bool CONFIG_M686 y
   define_int  CONFIG_X86_L1_CACHE_SHIFT 5
   define_bool CONFIG_X86_PPRO_FENCE y
fi
if [ "$CONFIG_MPENTIUM2" = "y" ]; then
   define_bool CONFIG_M686 y
   define_int  CONFIG_X86_L1_CACHE_SHIFT 5
fi
if [ "$CONFIG_MPENTIUM3" = "y" ]; then
   define_bool CONFIG_M686 y
   define_int  CONFIG_X86_L1_CACHE_SHIFT 5
   define_bool CONFIG_X86_SFENCE y
fi
if [ "$CONFIG_MPENTIUM4" = "y" ]; then
   define_bool CONFIG_M686 y
   define_int  CONFIG_X86_L1_CACHE_SHIFT 7
   define_bool CONFIG_X86_SFENCE y
   define_bool CONFIG_X86_LFENCE y
   define_bool CONFIG_X86_MFENCE y
fi
if [ "$CONFIG_M686" = "y" ]; then
   define_bool CONFIG_X86_TSC_CPU y
   define_bool CONFIG_X86_GOOD_APIC y
   define_bool CONFIG_X86_PGE y
   define_bool CONFIG_X86_USE_PPRO_CHECKSUM y
fi

Comments ?
Direct to trash ?

-- 
J.A. Magallon             \   Software is like sex: It's better when it's free
mailto:jamagallon@able.es  \                    -- Linus Torvalds, FSF T-shirt
Linux werewolf 2.4.19-rc3-jam1, Mandrake Linux 9.0 (Cooker) for i586
gcc (GCC) 3.1.1 (Mandrake Linux 8.3 3.1.1-0.10mdk)
