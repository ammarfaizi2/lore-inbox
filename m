Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262572AbTCISyO>; Sun, 9 Mar 2003 13:54:14 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262575AbTCISyO>; Sun, 9 Mar 2003 13:54:14 -0500
Received: from [195.39.17.254] ([195.39.17.254]:2052 "EHLO Elf.ucw.cz")
	by vger.kernel.org with ESMTP id <S262572AbTCISyJ>;
	Sun, 9 Mar 2003 13:54:09 -0500
Date: Sat, 8 Mar 2003 00:19:54 +0100
From: Pavel Machek <pavel@ucw.cz>
To: "H. Peter Anvin" <hpa@zytor.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: Reserving physical memory at boot time
Message-ID: <20030307231954.GB164@elf.ucw.cz>
References: <Pine.LNX.3.95.1021204115837.29419B-100000@chaos.analogic.com> <Pine.LNX.4.33L2.0212040905230.8842-100000@dragon.pdx.osdl.net> <b442s0$pau$1@cesium.transmeta.com> <32981.4.64.238.61.1046844111.squirrel@www.osdl.org> <b453mj$qpi$1@cesium.transmeta.com> <20030306212607.GA173@elf.ucw.cz> <3E67D89B.1010308@zytor.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <3E67D89B.1010308@zytor.com>
X-Warning: Reading this can be dangerous to your mental health.
User-Agent: Mutt/1.5.3i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!

> > Really? So user has to know where ACPI tables are and specify less
> > than that on mem= command line? That seems very
> > counter-intuitive. [Ahha, its probaly okay because e820 saves you.]
> > 
> > What do you pass on 4GB machine as mem= parameter? AFAIK those beasts
> > have hole at 3.75G. [Hopefully bigmem machines have working e820
> > tables?]
> > 
> 
> If you pass mem= you have to pass mem=3840M.  Yes, it sucks, but if you
> genuinely have a machine which is so fucked up that you can't rely on
> the memory map the BIOS presents to you, you have problems to begin with.
> 
> Oh yes, this is why GRUB passing the mem= parameter gratuitously was
> beyond total and complete brainfuckage.

Okay; which mem= options you want killed?

What about this?
								Pavel

--- clean/arch/i386/kernel/setup.c	2003-03-06 23:25:14.000000000 +0100
+++ linux/arch/i386/kernel/setup.c	2003-03-08 00:18:21.000000000 +0100
@@ -527,6 +527,9 @@
 		 * to <mem>, overriding the bios size.
 		 * "mem=XXX[KkmM]@XXX[KkmM]" defines a memory region from
 		 * <start> to <start>+<mem>, overriding the bios size.
+		 *
+		 * HPA tells me bootloaders need to parse mem=, so no new
+		 * option should be mem=
 		 */
 		if (c == ' ' && !memcmp(from, "mem=", 4)) {
 			if (to != command_line)
@@ -535,8 +538,24 @@
 				from += 9+4;
 				clear_bit(X86_FEATURE_PSE, boot_cpu_data.x86_capability);
 				disable_pse = 1;
-			} else if (!memcmp(from+4, "exactmap", 8)) {
-				from += 8+4;
+			} else {
+				/* If the user specifies memory size, we
+				 * limit the BIOS-provided memory map to
+				 * that size. exactmap can be used to specify
+				 * the exact map. mem=number can be used to
+				 * trim the existing memory map.
+				 */
+				unsigned long long start_at, mem_size;
+ 
+				mem_size = memparse(from+4, &from);
+			}
+		}
+
+		if (c == ' ' && !memcmp(from, "memmap=", 7)) {
+			if (to != command_line)
+				to--;
+			if (!memcmp(from+7, "exactmap", 8)) {
+				from += 8+7;
 				e820.nr_map = 0;
 				userdef = 1;
 			} else {
@@ -548,7 +567,7 @@
 				 */
 				unsigned long long start_at, mem_size;
  
-				mem_size = memparse(from+4, &from);
+				mem_size = memparse(from+7, &from);
 				if (*from == '@') {
 					start_at = memparse(from+1, &from);
 					add_memory_region(start_at, mem_size, E820_RAM);
@@ -565,6 +584,7 @@
 			}
 		}
 
+
 		/* "acpi=off" disables both ACPI table parsing and interpreter init */
 		if (c == ' ' && !memcmp(from, "acpi=off", 8))
 			acpi_disabled = 1;


-- 
When do you have a heart between your knees?
[Johanka's followup: and *two* hearts?]
