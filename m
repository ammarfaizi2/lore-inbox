Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S265637AbTBCBay>; Sun, 2 Feb 2003 20:30:54 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S265608AbTBCBay>; Sun, 2 Feb 2003 20:30:54 -0500
Received: from dhcp024-209-039-102.neo.rr.com ([24.209.39.102]:13961 "EHLO
	neo.rr.com") by vger.kernel.org with ESMTP id <S265637AbTBCB1b>;
	Sun, 2 Feb 2003 20:27:31 -0500
Date: Sun, 2 Feb 2003 20:37:02 +0000
From: Adam Belay <ambx1@neo.rr.com>
To: linux-kernel@vger.kernel.org
Cc: greg@kroah.com, Alan Cox <alan@lxorguk.ukuu.org.uk>,
       Jaroslav Kysela <perex@perex.cz>, Dominik Brodowski <linux@brodo.de>,
       Tamagucci <Tamagucci@libero.it>, CaT <cat@zip.com.au>,
       "Ruslan U. Zakirov" <cubic@miee.ru>
Subject: [PATCH][RFC] Possible PnP BIOS GPF Solution for Sony VAIO and other laptops
Message-ID: <20030202203702.GA23248@neo.rr.com>
Mail-Followup-To: Adam Belay <ambx1@neo.rr.com>,
	linux-kernel@vger.kernel.org, greg@kroah.com,
	Alan Cox <alan@lxorguk.ukuu.org.uk>,
	Jaroslav Kysela <perex@perex.cz>,
	Dominik Brodowski <linux@brodo.de>, Tamagucci <Tamagucci@libero.it>,
	CaT <cat@zip.com.au>, "Ruslan U. Zakirov" <cubic@miee.ru>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

The PnP BIOS may be wandering into segement 0x40.  If that is the case, this 
patch should fix the problem.  I do not have a buggy system so I cannot test 
this patch but I'd be intersted to hear the results.  If you have a system that 
has caused pnpbios problems in the past, I recommend you try this patch.  If it 
works, the system will not panic on startup.  This patch is against 2.5.59 and
separate from my other recent patches.


--- a/drivers/pnp/pnpbios/core.c	Fri Jan 31 16:59:57 2003
+++ b/drivers/pnp/pnpbios/core.c	Fri Jan 31 17:01:07 2003
@@ -142,11 +142,13 @@
 set_limit(cpu_gdt_table[cpu][(selname) >> 3], size); \
 } while(0)
 
+static struct desc_struct bad_bios_desc = { 0, 0x00409200 };
+
 /*
  * At some point we want to use this stack frame pointer to unwind
- * after PnP BIOS oopses. 
+ * after PnP BIOS oopses.
  */
- 
+
 u32 pnp_bios_fault_esp;
 u32 pnp_bios_fault_eip;
 u32 pnp_bios_is_utter_crap = 0;
@@ -160,6 +162,8 @@
 {
 	unsigned long flags;
 	u16 status;
+	struct desc_struct save_desc_40;
+	int cpu;
 
 	/*
 	 * PnP BIOSes are generally not terribly re-entrant.
@@ -168,6 +172,10 @@
 	if(pnp_bios_is_utter_crap)
 		return PNP_FUNCTION_NOT_SUPPORTED;
 
+	cpu = get_cpu();
+	save_desc_40 = cpu_gdt_table[cpu][0x40 / 8];
+	cpu_gdt_table[cpu][0x40 / 8] = bad_bios_desc;
+
 	/* On some boxes IRQ's during PnP BIOS calls are deadly.  */
 	spin_lock_irqsave(&pnp_bios_lock, flags);
 
@@ -207,6 +215,9 @@
 		: "memory"
 	);
 	spin_unlock_irqrestore(&pnp_bios_lock, flags);
+
+	cpu_gdt_table[cpu][0x40 / 8] = save_desc_40;
+	put_cpu();
 	
 	/* If we get here and this is set then the PnP BIOS faulted on us. */
 	if(pnp_bios_is_utter_crap)
@@ -1431,7 +1442,7 @@
 		 * from devices that are can only be static such as
 		 * those controlled by the "system" driver.
 		 */
-		if (pnp_bios_get_dev_node(&nodenum, (char )1, node))
+		if (pnp_bios_get_dev_node(&nodenum, (char )0, node))
 			break;
 		nodes_got++;
 		dev =  pnpbios_kmalloc(sizeof (struct pnp_dev), GFP_KERNEL);
@@ -1563,6 +1574,8 @@
 		pnp_bios_callpoint.segment = PNP_CS16;
 		pnp_bios_hdr = check;
 
+		set_base(bad_bios_desc, __va((unsigned long)0x40 << 4));
+		_set_limit((char *)&bad_bios_desc, 4095 - (0x40 << 4));
 		for(i=0; i < NR_CPUS; i++)
 		{
 			Q2_SET_SEL(i, PNP_CS32, &pnp_bios_callfunc, 64 * 1024);
