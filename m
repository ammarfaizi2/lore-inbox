Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267938AbTBMAVK>; Wed, 12 Feb 2003 19:21:10 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267939AbTBMAVK>; Wed, 12 Feb 2003 19:21:10 -0500
Received: from atlrel9.hp.com ([156.153.255.214]:64488 "EHLO atlrel9.hp.com")
	by vger.kernel.org with ESMTP id <S267938AbTBMAVJ>;
	Wed, 12 Feb 2003 19:21:09 -0500
Content-Type: text/plain;
  charset="us-ascii"
From: Bjorn Helgaas <bjorn_helgaas@hp.com>
To: davem@redhat.com
Subject: tg3: back-to-back register write bug workaround causes MCA
Date: Wed, 12 Feb 2003 17:30:53 -0700
User-Agent: KMail/1.4.3
Cc: linux-kernel@vger.kernel.org
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Message-Id: <200302121730.53701.bjorn_helgaas@hp.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

The attached change to tg3 causes an MCA on an HP zx6000
(a 2-CPU IA64 box).  This is with Marcelo's current 2.4.x BK tree
plus the ia64 patch.  Backing out the change below makes the
MCA go away.

Driver attach:
tg3.c:v1.4 (Feb 1, 2003)
PCI: Found IRQ 56 for device 20:02.0
eth1: Tigon3 [partno(BCM95700A6) rev 0105 PHY(5701)] (PCI:66MHz:64-bit) 10/100/1000BaseT Ethernet 00:30:6e:38:d9:67

lspci -vv:
20:02.0 Ethernet controller: Broadcom Corporation NetXtreme BCM5701 Gigabit Ethernet (rev 15)
        Subsystem: Hewlett-Packard Company: Unknown device 12a4
        Control: I/O- Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr+ Stepping- SERR+ FastB2B-
        Status: Cap+ 66Mhz+ UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort- >SERR- <PERR-
        Latency: 192 (16000ns min), cache line size 20
        Interrupt: pin A routed to IRQ 56
        Region 0: Memory at 0000000090800000 (64-bit, non-prefetchable) [size=64K]
        Capabilities: [40] PCI-X non-bridge device.
                Command: DPERE- ERO- RBC=0 OST=0
                Status: Bus=0 Dev=0 Func=0 64bit- 133MHz- SCD- USC-, DC=simple, DMMRBC=0, DMOST=0, DMCRS=0, RSCEM-      
        Capabilities: [48] Power Management version 2
                Flags: PMEClk- DSI- D1- D2- AuxCurrent=0mA PME(D0-,D1-,D2-,D3hot+,D3cold+)
                Status: D0 PME-Enable- DSel=0 DScale=1 PME-
        Capabilities: [50] Vital Product Data
        Capabilities: [58] Message Signalled Interrupts: 64bit+ Queue=0/3 Enable-
                Address: 968ec1a842f280a8  Data: ca46

The MCA occurs when dhclient configures the interface.  The PCI bus
address is 0x0000000090806804, and the root bridge says the error is
"received no DEVSEL# when mastering I/O bus".

Is there any information I can collect to help diagnose the problem?

Bjorn


# --------------------------------------------
# 03/01/30	davem@nuts.ninka.net	1.953.2.5
# [TG3]: Workaround 5701 back-to-back register write bug.
# --------------------------------------------
#
diff -Nru a/drivers/net/tg3.c b/drivers/net/tg3.c
--- a/drivers/net/tg3.c	Wed Feb 12 15:42:52 2003
+++ b/drivers/net/tg3.c	Wed Feb 12 15:42:53 2003
@@ -165,6 +165,8 @@
 		spin_unlock_irqrestore(&tp->indirect_lock, flags);
 	} else {
 		writel(val, tp->regs + off);
+		if ((tp->tg3_flags & TG3_FLAG_5701_REG_WRITE_BUG) != 0)
+			readl(tp->regs + off);
 	}
 }
 
@@ -5961,6 +5963,14 @@
 			pci_write_config_word(tp->pdev, PCI_COMMAND, pci_cmd);
 		}
 	}
+
+	/* Back to back register writes can cause problems on this chip,
+	 * the workaround is to read back all reg writes except those to
+	 * mailbox regs.  See tg3_write_indirect_reg32().
+	 */
+	if (GET_ASIC_REV(tp->pci_chip_rev_id) == ASIC_REV_5701)
+		tp->tg3_flags |= TG3_FLAG_5701_REG_WRITE_BUG;
+
 	if ((pci_state_reg & PCISTATE_BUS_SPEED_HIGH) != 0)
 		tp->tg3_flags |= TG3_FLAG_PCI_HIGH_SPEED;
 	if ((pci_state_reg & PCISTATE_BUS_32BIT) != 0)
diff -Nru a/drivers/net/tg3.h b/drivers/net/tg3.h
--- a/drivers/net/tg3.h	Wed Feb 12 15:42:53 2003
+++ b/drivers/net/tg3.h	Wed Feb 12 15:42:53 2003
@@ -1795,6 +1795,7 @@
 #define TG3_FLAG_USE_LINKCHG_REG	0x00000008
 #define TG3_FLAG_USE_MI_INTERRUPT	0x00000010
 #define TG3_FLAG_ENABLE_ASF		0x00000020
+#define TG3_FLAG_5701_REG_WRITE_BUG	0x00000040
 #define TG3_FLAG_POLL_SERDES		0x00000080
 #define TG3_FLAG_MBOX_WRITE_REORDER	0x00000100
 #define TG3_FLAG_PCIX_TARGET_HWBUG	0x00000200

