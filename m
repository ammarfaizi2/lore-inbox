Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S268776AbTBZXxa>; Wed, 26 Feb 2003 18:53:30 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S268798AbTBZXxa>; Wed, 26 Feb 2003 18:53:30 -0500
Received: from neon-gw-l3.transmeta.com ([63.209.4.196]:64263 "EHLO
	neon-gw.transmeta.com") by vger.kernel.org with ESMTP
	id <S268776AbTBZXx3>; Wed, 26 Feb 2003 18:53:29 -0500
Date: Wed, 26 Feb 2003 16:00:49 -0800 (PST)
From: Linus Torvalds <torvalds@transmeta.com>
To: Mikael Pettersson <mikpe@user.it.uu.se>
cc: Ion Badulescu <ionut@badula.org>, "Martin J. Bligh" <mbligh@aracnet.com>,
       Rusty Russell <rusty@rustcorp.com.au>, <linux-kernel@vger.kernel.org>,
       <mingo@redhat.com>
Subject: Re: [BUG] 2.5.63: ESR killed my box!
In-Reply-To: <15965.18601.973394.137184@gargle.gargle.HOWL>
Message-ID: <Pine.LNX.4.44.0302261559170.3527-100000@home.transmeta.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Ok, can people agree on this simplified version of Mikaels patch, which 
doesn't BUG_ON(), and doesn't reset 'boot_cpu_physical_apicid' 
unnecessarily..

Does this work for people?

			Linus

---
# This is a BitKeeper generated patch for the following project:
# Project Name: Linux kernel tree
# This patch format is intended for GNU patch command version 2.5 or higher.
# This patch includes the following deltas:
#	           ChangeSet	1.1087  -> 1.1088 
#	arch/i386/kernel/apic.c	1.33    -> 1.34   
#
# The following is the BitKeeper ChangeSet Log
# --------------------------------------------
# 03/02/26	mikpe@user.it.uu.se	1.1088
# [PATCH] APIC ID fixes
# 
# 1) apic_write_around(APIC_ID, boot_cpu_physical_apicid) places the APIC
# value in the lower 8 bits of APIC_ID, when it should be in the upper 8. As
# as result, it effectively forces the APIC id to always be 0 for the boot
# CPU, which is fatal on SMP AMD boxes.
# 
#  Fix: don't do the write at all. The APIC_ID value should be right already.
# 
# 2) phys_cpu_present_map = 1 means we always set bit 0, but later on
#    in setup_local_APIC() we do
#         if (!clustered_apic_mode &&
#             !test_bit(GET_APIC_ID(apic_read(APIC_ID)), &phys_cpu_present_map))
#                 BUG();
# and the bug is triggered if the APIC_ID is not zero.
# 
#  Fix: initialize 'phys_cpu_present_map' correctly.
# --------------------------------------------
#
diff -Nru a/arch/i386/kernel/apic.c b/arch/i386/kernel/apic.c
--- a/arch/i386/kernel/apic.c	Wed Feb 26 16:00:18 2003
+++ b/arch/i386/kernel/apic.c	Wed Feb 26 16:00:18 2003
@@ -665,7 +665,6 @@
 	}
 	set_bit(X86_FEATURE_APIC, boot_cpu_data.x86_capability);
 	mp_lapic_addr = APIC_DEFAULT_PHYS_BASE;
-	boot_cpu_physical_apicid = 0;
 	if (nmi_watchdog != NMI_NONE)
 		nmi_watchdog = NMI_LOCAL_APIC;
 
@@ -1154,8 +1153,7 @@
 
 	connect_bsp_APIC();
 
-	phys_cpu_present_map = 1;
-	apic_write_around(APIC_ID, boot_cpu_physical_apicid);
+	phys_cpu_present_map = 1 << boot_cpu_physical_apicid;
 
 	apic_pm_init2();
 

