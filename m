Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267284AbTBXQcB>; Mon, 24 Feb 2003 11:32:01 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267285AbTBXQcB>; Mon, 24 Feb 2003 11:32:01 -0500
Received: from poup.poupinou.org ([195.101.94.96]:38679 "EHLO
	poup.poupinou.org") by vger.kernel.org with ESMTP
	id <S267284AbTBXQb7>; Mon, 24 Feb 2003 11:31:59 -0500
Date: Mon, 24 Feb 2003 17:42:09 +0100
To: Pavel Machek <pavel@ucw.cz>
Cc: kernel list <linux-kernel@vger.kernel.org>,
       ACPI mailing list <acpi-devel@lists.sourceforge.net>,
       Robert Woerle <robert@paceblade.com>, ducrot@poupinou.org
Subject: Re: [ACPI] PaceBlade broken acpi/memory map
Message-ID: <20030224164209.GD13404@poup.poupinou.org>
References: <20030220172144.GA15016@elf.ucw.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20030220172144.GA15016@elf.ucw.cz>
User-Agent: Mutt/1.4i
From: Ducrot Bruno <ducrot@poupinou.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Feb 20, 2003 at 06:21:45PM +0100, Pavel Machek wrote:
> Hi!
> 
> I have PaceBlade here, and its memory map is wrong, which leads to
> ACPI refusing to load. [It does not mention "ACPI data" in the memory
> map at all!]

I have made those patches to workaround that.  I have no time
to rediff it though (sorry), but it is easy to get it.  I also CC
to Robert Woerle because he has already send a PR to the
bios mainteners.

> 
> And when I work around that, it crashes in processing _STA/_INI
> methods. [Anyone from PaceBlade listening?]

Don't know what happens: I have no paceblade and it sound like it
is OK for Robert ?


this one is bad.  Only here in order to get the second diff apply cleanly.


--- linux-2.4.21-pre3-acpi-20030109-s4bios/arch/i386/kernel/setup.c	2003/01/22 12:37:35	1.1
+++ linux-2.4.21-pre3-acpi-20030109-s4bios/arch/i386/kernel/setup.c	2003/01/22 13:44:06
@@ -546,6 +546,12 @@
 	if (*pnr_map < 2)
 		return -1;
 
+	biosmap[(int) *pnr_map].addr = 0x0eef0000;
+	biosmap[(int) *pnr_map].size = 53248;
+	biosmap[(int) *pnr_map].type = E820_ACPI;
+	(*pnr_map)++;
+
+	
 	old_nr = *pnr_map;
 
 	/* bail out if we find any unreasonable addresses in bios map */





This one is the good one.  Need to be rediffed correctly, or to be changed for 2.5.


--- linux-2.4.21-pre3-acpi-20030109-s4bios/arch/i386/kernel/setup.c	2003/01/27 13:46:37	1.2
+++ linux-2.4.21-pre3-acpi-20030109-s4bios/arch/i386/kernel/setup.c	2003/01/27 14:13:28
@@ -546,10 +546,47 @@
 	if (*pnr_map < 2)
 		return -1;
 
+	/*
+	 * For broken BIOS which do not declare an ACPI DATA properly,
+	 * even though ACPI NVS are here, we try to declare the 64ko as
+	 * ACPI DATA (and hope it will work).
+	 */
+	do {
+		int i;
+		int seen = 0;
+		struct e820entry new_entry;
+
+		old_nr = *pnr_map;
+		memset(&new_entry, 0, sizeof (new_entry));
+
+		for (i = 0; i < old_nr; i++) {
+			switch (biosmap[i].type) {
+			case E820_ACPI:
+				seen = 1;
+				break;
+			case E820_NVS:
+				new_entry.addr = biosmap[i].addr - 0x10000;
+				new_entry.size = 0x10000;
+				new_entry.type = E820_ACPI;
+				break;
+			default:
+				break;
+			}
+		}
+		if (!seen && new_entry.type == E820_ACPI) {
+			printk(KERN_WARNING "setup: found a ACPI NV region, but no ACPI DATA.  Trying to mark\n");
+			printk(KERN_WARNING "setup: %016Lx of size %016Lx as ACPI DATA.\n", new_entry.addr, new_entry.size);
+			memcpy(&biosmap[(int) *pnr_map], &new_entry, sizeof(new_entry));
+			(*pnr_map)++;
+		}
+	} while (0);
+
+#if 0
 	biosmap[(int) *pnr_map].addr = 0x0eef0000;
 	biosmap[(int) *pnr_map].size = 53248;
 	biosmap[(int) *pnr_map].type = E820_ACPI;
 	(*pnr_map)++;
+#endif
 
 	
 	old_nr = *pnr_map;



It is much better to kill the lines in #if 0 ... #endif of course.

Cheers,

-- 
Ducrot Bruno

--  Which is worse:  ignorance or apathy?
--  Don't know.  Don't care.
