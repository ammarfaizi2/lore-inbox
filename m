Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129383AbRAEXXA>; Fri, 5 Jan 2001 18:23:00 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129777AbRAEXWv>; Fri, 5 Jan 2001 18:22:51 -0500
Received: from harpo.it.uu.se ([130.238.12.34]:33961 "EHLO harpo.it.uu.se")
	by vger.kernel.org with ESMTP id <S129383AbRAEXWh>;
	Fri, 5 Jan 2001 18:22:37 -0500
Date: Sat, 6 Jan 2001 00:22:32 +0100 (MET)
From: Mikael Pettersson <mikpe@csd.uu.se>
Message-Id: <200101052322.AAA01515@harpo.it.uu.se>
To: linux-kernel@vger.kernel.org
Subject: 2.4.0 memory sizing broken on old x86 machines
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Memory sizing for old machines whose BIOSen don't speak E820
got broken in 2.4.0-test13-pre4:

--- v2.4.0-test12/linux/arch/i386/kernel/setup.c	Mon Dec 11 17:59:43 2000
+++ linux/arch/i386/kernel/setup.c	Thu Dec 21 14:01:19 2000
@@ -518,7 +518,7 @@
 
 		e820.nr_map = 0;
 		add_memory_region(0, LOWMEMSIZE(), E820_RAM);
-		add_memory_region(HIGH_MEMORY, mem_size << 10, E820_RAM);
+		add_memory_region(HIGH_MEMORY, (mem_size << 10) - HIGH_MEMORY, E820_RAM);
   	}
 	printk("BIOS-provided physical RAM map:\n");
 	print_memory_map(who);

(This snipped is in setup_memory_region() where legacy (e801 or 88)
memory size info is converted to e820-style.)

BIOS call 0x88 returns extended (above 1M) memory size not total, so
the subtraction "- HIGH_MEMORY" is wrong. The effect is that the
kernel believes the machine to have 1MB less RAM than it actually has
-- not fun on an old 486 with limited RAM to start with :-(

I think this patch should be backed out pronto.

/Mikael
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
