Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932262AbWCTMqV@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932262AbWCTMqV (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 20 Mar 2006 07:46:21 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932269AbWCTMqV
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 20 Mar 2006 07:46:21 -0500
Received: from outpipe-village-512-1.bc.nu ([81.2.110.250]:15058 "EHLO
	lxorguk.ukuu.org.uk") by vger.kernel.org with ESMTP id S932262AbWCTMqU
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 20 Mar 2006 07:46:20 -0500
Subject: PATCH: Yet more rio cleaning (2 of 2)
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
To: akpm@osdl.org, linux-kernel@vger.kernel.org
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Date: Mon, 20 Mar 2006 12:52:46 +0000
Message-Id: <1142859166.20050.19.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Evolution 2.2.3 (2.2.3-2.fc4) 
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

- Remove more unused headers
- Remove various typedefs
- Correct type of PaddrP (physical addresses should be ulong)
- Kill use of bcopy
- More printk cleanups
- Kill true/false
- Clean up direct access to pci BARs

Signed-off-by: Alan Cox <alan@redhat.com>

diff -u --new-file --recursive --exclude-from /usr/src/exclude linux.vanilla-2.6.16-rc6-mm2/drivers/char/rio/rioboot.c linux-2.6.16-rc6-mm2/drivers/char/rio/rioboot.c
--- linux.vanilla-2.6.16-rc6-mm2/drivers/char/rio/rioboot.c	2006-03-19 18:20:51.327020568 +0000
+++ linux-2.6.16-rc6-mm2/drivers/char/rio/rioboot.c	2006-03-16 13:15:24.000000000 +0000
@@ -47,15 +47,12 @@
 
 #include "linux_compat.h"
 #include "rio_linux.h"
-#include "typdef.h"
 #include "pkt.h"
 #include "daemon.h"
 #include "rio.h"
 #include "riospace.h"
-#include "top.h"
 #include "cmdpkt.h"
 #include "map.h"
-#include "riotypes.h"
 #include "rup.h"
 #include "port.h"
 #include "riodrvr.h"
@@ -68,7 +65,6 @@
 #include "unixrup.h"
 #include "board.h"
 #include "host.h"
-#include "error.h"
 #include "phb.h"
 #include "link.h"
 #include "cmdblk.h"
@@ -386,7 +382,7 @@
 		 */
 		offset = (p->RIOConf.HostLoadBase - 2) - 0x7FFC;
 
-		writeb(NFIX(((ushort) (~offset) >> (ushort) 12) & 0xF), DestP);
+		writeb(NFIX(((unsigned short) (~offset) >> (unsigned short) 12) & 0xF), DestP);
 		writeb(PFIX((offset >> 8) & 0xF), DestP + 1);
 		writeb(PFIX((offset >> 4) & 0xF), DestP + 2);
 		writeb(JUMP(offset & 0xF), DestP + 3);
@@ -515,10 +511,10 @@
 		 ** 32 bit pointers for the driver in ioremap space.
 		 */
 		HostP->ParmMapP = ParmMapP;
-		HostP->PhbP = (PHB *) RIO_PTR(Cad, readw(&ParmMapP->phb_ptr));
-		HostP->RupP = (RUP *) RIO_PTR(Cad, readw(&ParmMapP->rups));
-		HostP->PhbNumP = (ushort *) RIO_PTR(Cad, readw(&ParmMapP->phb_num_ptr));
-		HostP->LinkStrP = (LPB *) RIO_PTR(Cad, readw(&ParmMapP->link_str_ptr));
+		HostP->PhbP = (struct PHB *) RIO_PTR(Cad, readw(&ParmMapP->phb_ptr));
+		HostP->RupP = (struct RUP *) RIO_PTR(Cad, readw(&ParmMapP->rups));
+		HostP->PhbNumP = (unsigned short *) RIO_PTR(Cad, readw(&ParmMapP->phb_num_ptr));
+		HostP->LinkStrP = (struct LPB *) RIO_PTR(Cad, readw(&ParmMapP->link_str_ptr));
 
 		/*
 		 ** point the UnixRups at the real Rups
@@ -639,7 +635,7 @@
 	/*
 	 ** Fill in the default info on the command block
 	 */
-	CmdBlkP->Packet.dest_unit = Rup < (ushort) MAX_RUP ? Rup : 0;
+	CmdBlkP->Packet.dest_unit = Rup < (unsigned short) MAX_RUP ? Rup : 0;
 	CmdBlkP->Packet.dest_port = BOOT_RUP;
 	CmdBlkP->Packet.src_unit = 0;
 	CmdBlkP->Packet.src_port = BOOT_RUP;
@@ -748,7 +744,7 @@
 	 */
 
 	RtaType = GetUnitType(RtaUniq);
-	if (Rup >= (ushort) MAX_RUP)
+	if (Rup >= (unsigned short) MAX_RUP)
 		rio_dprintk(RIO_DEBUG_BOOT, "RIO: Host %s has booted an RTA(%d) on link %c\n", HostP->Name, 8 * RtaType, readb(&PktCmdP->LinkNum) + 'A');
 	else
 		rio_dprintk(RIO_DEBUG_BOOT, "RIO: RTA %s has booted an RTA(%d) on link %c\n", HostP->Mapping[Rup].Name, 8 * RtaType, readb(&PktCmdP->LinkNum) + 'A');
@@ -757,7 +753,7 @@
 
 	if (RtaUniq == 0x00000000 || RtaUniq == 0xffffffff) {
 		rio_dprintk(RIO_DEBUG_BOOT, "Illegal RTA Uniq Number\n");
-		return TRUE;
+		return 1;
 	}
 
 	/*
@@ -785,7 +781,7 @@
 			 */
 			writew(30, &HostP->LinkStrP[MyLink].WaitNoBoot);
 		rio_dprintk(RIO_DEBUG_BOOT, "RTA %x not owned - suspend booting down link %c on unit %x\n", RtaUniq, 'A' + MyLink, HostP->Mapping[Rup].RtaUniqueNum);
-		return TRUE;
+		return 1;
 	}
 
 	/*
@@ -826,7 +822,7 @@
 				rio_dprintk(RIO_DEBUG_BOOT, "RTA will be given IDs %d+%d\n", entry + 1, entry2 + 1);
 			else
 				rio_dprintk(RIO_DEBUG_BOOT, "RTA will be given ID %d\n", entry + 1);
-			return TRUE;
+			return 1;
 		}
 	}
 
@@ -868,7 +864,7 @@
 				rio_dprintk(RIO_DEBUG_BOOT, "Found previous tentative slot (%d)\n", entry);
 			if (!p->RIONoMessage)
 				printk("RTA connected to %s '%s' (%c) not configured.\n", MyType, MyName, MyLink + 'A');
-			return TRUE;
+			return 1;
 		}
 	}
 
@@ -961,13 +957,13 @@
 	if (RtaType == TYPE_RTA16) {
 		if (RIOFindFreeID(p, HostP, &entry, &entry2) == 0) {
 			RIODefaultName(p, HostP, entry);
-			FillSlot(entry, entry2, RtaUniq, HostP);
+			rio_fill_host_slot(entry, entry2, RtaUniq, HostP);
 			EmptySlot = 0;
 		}
 	} else {
 		if (RIOFindFreeID(p, HostP, &entry, NULL) == 0) {
 			RIODefaultName(p, HostP, entry);
-			FillSlot(entry, 0, RtaUniq, HostP);
+			rio_fill_host_slot(entry, 0, RtaUniq, HostP);
 			EmptySlot = 0;
 		}
 	}
@@ -1023,7 +1019,7 @@
 		} else if (!p->RIONoMessage)
 			printk("RTA connected to %s '%s' (%c) not configured.\n", MyType, MyName, MyLink + 'A');
 		RIOSetChange(p);
-		return TRUE;
+		return 1;
 	}
 
 	/*
@@ -1038,7 +1034,7 @@
 			/*
 			 ** already got it!
 			 */
-			return TRUE;
+			return 1;
 		}
 	}
 	/*
@@ -1046,13 +1042,13 @@
 	 */
 	if (HostP->NumExtraBooted < MAX_EXTRA_UNITS)
 		HostP->ExtraUnits[HostP->NumExtraBooted++] = RtaUniq;
-	return TRUE;
+	return 1;
 }
 
 
 /*
 ** If the RTA or its host appears in the RIOBindTab[] structure then
-** we mustn't boot the RTA and should return FALSE.
+** we mustn't boot the RTA and should return 0.
 ** This operation is slightly different from the other drivers for RIO
 ** in that this is designed to work with the new utilities
 ** not config.rio and is FAR SIMPLER.
@@ -1080,38 +1076,38 @@
 ** slots tentative, and the second one RTA_SECOND_SLOT as well.
 */
 
-void FillSlot(int entry, int entry2, unsigned int RtaUniq, struct Host *HostP)
+void rio_fill_host_slot(int entry, int entry2, unsigned int rta_uniq, struct Host *host)
 {
 	int link;
 
-	rio_dprintk(RIO_DEBUG_BOOT, "FillSlot(%d, %d, 0x%x...)\n", entry, entry2, RtaUniq);
+	rio_dprintk(RIO_DEBUG_BOOT, "rio_fill_host_slot(%d, %d, 0x%x...)\n", entry, entry2, rta_uniq);
 
-	HostP->Mapping[entry].Flags = (RTA_BOOTED | RTA_NEWBOOT | SLOT_TENTATIVE);
-	HostP->Mapping[entry].SysPort = NO_PORT;
-	HostP->Mapping[entry].RtaUniqueNum = RtaUniq;
-	HostP->Mapping[entry].HostUniqueNum = HostP->UniqueNum;
-	HostP->Mapping[entry].ID = entry + 1;
-	HostP->Mapping[entry].ID2 = 0;
+	host->Mapping[entry].Flags = (RTA_BOOTED | RTA_NEWBOOT | SLOT_TENTATIVE);
+	host->Mapping[entry].SysPort = NO_PORT;
+	host->Mapping[entry].RtaUniqueNum = rta_uniq;
+	host->Mapping[entry].HostUniqueNum = host->UniqueNum;
+	host->Mapping[entry].ID = entry + 1;
+	host->Mapping[entry].ID2 = 0;
 	if (entry2) {
-		HostP->Mapping[entry2].Flags = (RTA_BOOTED | RTA_NEWBOOT | SLOT_TENTATIVE | RTA16_SECOND_SLOT);
-		HostP->Mapping[entry2].SysPort = NO_PORT;
-		HostP->Mapping[entry2].RtaUniqueNum = RtaUniq;
-		HostP->Mapping[entry2].HostUniqueNum = HostP->UniqueNum;
-		HostP->Mapping[entry2].Name[0] = '\0';
-		HostP->Mapping[entry2].ID = entry2 + 1;
-		HostP->Mapping[entry2].ID2 = entry + 1;
-		HostP->Mapping[entry].ID2 = entry2 + 1;
+		host->Mapping[entry2].Flags = (RTA_BOOTED | RTA_NEWBOOT | SLOT_TENTATIVE | RTA16_SECOND_SLOT);
+		host->Mapping[entry2].SysPort = NO_PORT;
+		host->Mapping[entry2].RtaUniqueNum = rta_uniq;
+		host->Mapping[entry2].HostUniqueNum = host->UniqueNum;
+		host->Mapping[entry2].Name[0] = '\0';
+		host->Mapping[entry2].ID = entry2 + 1;
+		host->Mapping[entry2].ID2 = entry + 1;
+		host->Mapping[entry].ID2 = entry2 + 1;
 	}
 	/*
 	 ** Must set these up, so that utilities show
 	 ** topology of 16 port RTAs correctly
 	 */
 	for (link = 0; link < LINKS_PER_UNIT; link++) {
-		HostP->Mapping[entry].Topology[link].Unit = ROUTE_DISCONNECT;
-		HostP->Mapping[entry].Topology[link].Link = NO_LINK;
+		host->Mapping[entry].Topology[link].Unit = ROUTE_DISCONNECT;
+		host->Mapping[entry].Topology[link].Link = NO_LINK;
 		if (entry2) {
-			HostP->Mapping[entry2].Topology[link].Unit = ROUTE_DISCONNECT;
-			HostP->Mapping[entry2].Topology[link].Link = NO_LINK;
+			host->Mapping[entry2].Topology[link].Unit = ROUTE_DISCONNECT;
+			host->Mapping[entry2].Topology[link].Link = NO_LINK;
 		}
 	}
 }
diff -u --new-file --recursive --exclude-from /usr/src/exclude linux.vanilla-2.6.16-rc6-mm2/drivers/char/rio/riocmd.c linux-2.6.16-rc6-mm2/drivers/char/rio/riocmd.c
--- linux.vanilla-2.6.16-rc6-mm2/drivers/char/rio/riocmd.c	2006-03-19 18:20:51.329020264 +0000
+++ linux-2.6.16-rc6-mm2/drivers/char/rio/riocmd.c	2006-03-15 19:11:59.000000000 +0000
@@ -51,15 +51,12 @@
 
 #include "linux_compat.h"
 #include "rio_linux.h"
-#include "typdef.h"
 #include "pkt.h"
 #include "daemon.h"
 #include "rio.h"
 #include "riospace.h"
-#include "top.h"
 #include "cmdpkt.h"
 #include "map.h"
-#include "riotypes.h"
 #include "rup.h"
 #include "port.h"
 #include "riodrvr.h"
@@ -72,12 +69,10 @@
 #include "unixrup.h"
 #include "board.h"
 #include "host.h"
-#include "error.h"
 #include "phb.h"
 #include "link.h"
 #include "cmdblk.h"
 #include "route.h"
-#include "control.h"
 #include "cirrus.h"
 
 
@@ -148,7 +143,7 @@
 {
 	unsigned int Host;
 
-	rio_dprintk(RIO_DEBUG_CMD, "Command RTA 0x%lx func 0x%p\n", RtaUnique, func);
+	rio_dprintk(RIO_DEBUG_CMD, "Command RTA 0x%lx func %p\n", RtaUnique, func);
 
 	if (!RtaUnique)
 		return (0);
@@ -375,7 +370,7 @@
 /*
 ** Incoming command on the COMMAND_RUP to be processed.
 */
-static int RIOCommandRup(struct rio_info *p, uint Rup, struct Host *HostP, PKT * PacketP)
+static int RIOCommandRup(struct rio_info *p, uint Rup, struct Host *HostP, struct PKT * PacketP)
 {
 	struct PktCmd *PktCmdP = (struct PktCmd *) PacketP->data;
 	struct Port *PortP;
@@ -418,7 +413,7 @@
 		rio_dprintk(RIO_DEBUG_CMD, "PACKET information: Control	 0x%x (%d)\n", PacketP->control, PacketP->control);
 		rio_dprintk(RIO_DEBUG_CMD, "PACKET information: Check	   0x%x (%d)\n", PacketP->csum, PacketP->csum);
 		rio_dprintk(RIO_DEBUG_CMD, "COMMAND information: Host Port Number 0x%x, " "Command Code 0x%x\n", PktCmdP->PhbNum, PktCmdP->Command);
-		return TRUE;
+		return 1;
 	}
 	PortP = p->RIOPortp[SysPort];
 	rio_spin_lock_irqsave(&PortP->portSem, flags);
@@ -427,7 +422,7 @@
 		rio_dprintk(RIO_DEBUG_CMD, "Received a break!\n");
 		/* If the current line disc. is not multi-threading and
 		   the current processor is not the default, reset rup_intr
-		   and return FALSE to ensure that the command packet is
+		   and return 0 to ensure that the command packet is
 		   not freed. */
 		/* Call tmgr HANGUP HERE */
 		/* Fix this later when every thing works !!!! RAMRAJ */
@@ -541,7 +536,7 @@
 
 	func_exit();
 
-	return TRUE;
+	return 1;
 }
 
 /*
@@ -600,13 +595,13 @@
 	 ** straight on the RUP....
 	 */
 	if ((UnixRupP->CmdsWaitingP == NULL) && (UnixRupP->CmdPendingP == NULL) && (readw(&UnixRupP->RupP->txcontrol) == TX_RUP_INACTIVE) && (CmdBlkP->PreFuncP ? (*CmdBlkP->PreFuncP) (CmdBlkP->PreArg, CmdBlkP)
-																	     : TRUE)) {
+																	     : 1)) {
 		rio_dprintk(RIO_DEBUG_CMD, "RUP inactive-placing command straight on. Cmd byte is 0x%x\n", CmdBlkP->Packet.data[0]);
 
 		/*
 		 ** Whammy! blat that pack!
 		 */
-		HostP->Copy((caddr_t) & CmdBlkP->Packet, RIO_PTR(HostP->Caddr, UnixRupP->RupP->txpkt), sizeof(PKT));
+		HostP->Copy((caddr_t) & CmdBlkP->Packet, RIO_PTR(HostP->Caddr, UnixRupP->RupP->txpkt), sizeof(struct PKT));
 
 		/*
 		 ** place command packet on the pending position.
@@ -620,7 +615,7 @@
 
 		rio_spin_unlock_irqrestore(&UnixRupP->RupLock, flags);
 
-		return RIO_SUCCESS;
+		return 0;
 	}
 	rio_dprintk(RIO_DEBUG_CMD, "RUP active - en-queing\n");
 
@@ -633,15 +628,15 @@
 
 	Base = &UnixRupP->CmdsWaitingP;
 
-	rio_dprintk(RIO_DEBUG_CMD, "First try to queue cmdblk 0x%p at 0x%p\n", CmdBlkP, Base);
+	rio_dprintk(RIO_DEBUG_CMD, "First try to queue cmdblk %p at %p\n", CmdBlkP, Base);
 
 	while (*Base) {
-		rio_dprintk(RIO_DEBUG_CMD, "Command cmdblk 0x%p here\n", *Base);
+		rio_dprintk(RIO_DEBUG_CMD, "Command cmdblk %p here\n", *Base);
 		Base = &((*Base)->NextP);
-		rio_dprintk(RIO_DEBUG_CMD, "Now try to queue cmd cmdblk 0x%p at 0x%p\n", CmdBlkP, Base);
+		rio_dprintk(RIO_DEBUG_CMD, "Now try to queue cmd cmdblk %p at %p\n", CmdBlkP, Base);
 	}
 
-	rio_dprintk(RIO_DEBUG_CMD, "Will queue cmdblk 0x%p at 0x%p\n", CmdBlkP, Base);
+	rio_dprintk(RIO_DEBUG_CMD, "Will queue cmdblk %p at %p\n", CmdBlkP, Base);
 
 	*Base = CmdBlkP;
 
@@ -649,7 +644,7 @@
 
 	rio_spin_unlock_irqrestore(&UnixRupP->RupLock, flags);
 
-	return RIO_SUCCESS;
+	return 0;
 }
 
 /*
@@ -681,9 +676,7 @@
 		if (readw(&UnixRupP->RupP->rxcontrol) != RX_RUP_INACTIVE) {
 			int FreeMe;
 
-			PacketP = (PKT *) RIO_PTR(HostP->Caddr, readw(&UnixRupP->RupP->rxpkt));
-
-			ShowPacket(DBG_CMD, PacketP);
+			PacketP = (struct PKT *) RIO_PTR(HostP->Caddr, readw(&UnixRupP->RupP->rxpkt));
 
 			switch (readb(&PacketP->dest_port)) {
 			case BOOT_RUP:
@@ -749,7 +742,7 @@
 			if (CmdBlkP->Packet.dest_port == BOOT_RUP)
 				rio_dprintk(RIO_DEBUG_CMD, "Free Boot %s Command Block '%x'\n", CmdBlkP->Packet.len & 0x80 ? "Command" : "Data", CmdBlkP->Packet.data[0]);
 
-			rio_dprintk(RIO_DEBUG_CMD, "Command 0x%p completed\n", CmdBlkP);
+			rio_dprintk(RIO_DEBUG_CMD, "Command %p completed\n", CmdBlkP);
 
 			/*
 			 ** Clear the Rup lock to prevent mutual exclusion.
@@ -782,14 +775,14 @@
 			 ** If it returns RIO_FAIL then don't
 			 ** send this command yet!
 			 */
-			if (!(CmdBlkP->PreFuncP ? (*CmdBlkP->PreFuncP) (CmdBlkP->PreArg, CmdBlkP) : TRUE)) {
-				rio_dprintk(RIO_DEBUG_CMD, "Not ready to start command 0x%p\n", CmdBlkP);
+			if (!(CmdBlkP->PreFuncP ? (*CmdBlkP->PreFuncP) (CmdBlkP->PreArg, CmdBlkP) : 1)) {
+				rio_dprintk(RIO_DEBUG_CMD, "Not ready to start command %p\n", CmdBlkP);
 			} else {
-				rio_dprintk(RIO_DEBUG_CMD, "Start new command 0x%p Cmd byte is 0x%x\n", CmdBlkP, CmdBlkP->Packet.data[0]);
+				rio_dprintk(RIO_DEBUG_CMD, "Start new command %p Cmd byte is 0x%x\n", CmdBlkP, CmdBlkP->Packet.data[0]);
 				/*
 				 ** Whammy! blat that pack!
 				 */
-				HostP->Copy((caddr_t) & CmdBlkP->Packet, RIO_PTR(HostP->Caddr, UnixRupP->RupP->txpkt), sizeof(PKT));
+				HostP->Copy((caddr_t) & CmdBlkP->Packet, RIO_PTR(HostP->Caddr, UnixRupP->RupP->txpkt), sizeof(struct PKT));
 
 				/*
 				 ** remove the command from the rup command queue...
@@ -831,14 +824,13 @@
 int RIORFlushEnable(unsigned long iPortP, struct CmdBlk *CmdBlkP)
 {
 	struct Port *PortP = (struct Port *) iPortP;
-	PKT *PacketP;
+	struct PKT *PacketP;
 	unsigned long flags;
 
 	rio_spin_lock_irqsave(&PortP->portSem, flags);
 
 	while (can_remove_receive(&PacketP, PortP)) {
 		remove_receive(PortP);
-		ShowPacket(DBG_PROC, PacketP);
 		put_free_end(PortP->HostP, PacketP);
 	}
 
@@ -892,10 +884,6 @@
 	return 0;
 }
 
-void ShowPacket(uint Flags, struct PKT *PacketP)
-{
-}
-
 /*
 ** 
 ** How to use this file:
diff -u --new-file --recursive --exclude-from /usr/src/exclude linux.vanilla-2.6.16-rc6-mm2/drivers/char/rio/rioctrl.c linux-2.6.16-rc6-mm2/drivers/char/rio/rioctrl.c
--- linux.vanilla-2.6.16-rc6-mm2/drivers/char/rio/rioctrl.c	2006-03-19 18:20:51.331019960 +0000
+++ linux-2.6.16-rc6-mm2/drivers/char/rio/rioctrl.c	2006-03-16 00:04:48.000000000 +0000
@@ -51,15 +51,12 @@
 
 #include "linux_compat.h"
 #include "rio_linux.h"
-#include "typdef.h"
 #include "pkt.h"
 #include "daemon.h"
 #include "rio.h"
 #include "riospace.h"
-#include "top.h"
 #include "cmdpkt.h"
 #include "map.h"
-#include "riotypes.h"
 #include "rup.h"
 #include "port.h"
 #include "riodrvr.h"
@@ -72,12 +69,10 @@
 #include "unixrup.h"
 #include "board.h"
 #include "host.h"
-#include "error.h"
 #include "phb.h"
 #include "link.h"
 #include "cmdblk.h"
 #include "route.h"
-#include "control.h"
 #include "cirrus.h"
 #include "rioioctl.h"
 
@@ -144,7 +139,7 @@
 	ushort loop;
 	int Entry;
 	struct Port *PortP;
-	PKT *PacketP;
+	struct PKT *PacketP;
 	int retval = 0;
 	unsigned long flags;
 
@@ -154,7 +149,7 @@
 	Host = 0;
 	PortP = NULL;
 
-	rio_dprintk(RIO_DEBUG_CTRL, "control ioctl cmd: 0x%x arg: 0x%p\n", cmd, arg);
+	rio_dprintk(RIO_DEBUG_CTRL, "control ioctl cmd: 0x%x arg: %p\n", cmd, arg);
 
 	switch (cmd) {
 		/*
@@ -572,8 +567,8 @@
 		PortSetup.Store = p->RIOPortp[port]->Store;
 		PortSetup.Lock = p->RIOPortp[port]->Lock;
 		PortSetup.XpCps = p->RIOPortp[port]->Xprint.XpCps;
-		bcopy(p->RIOPortp[port]->Xprint.XpOn, PortSetup.XpOn, MAX_XP_CTRL_LEN);
-		bcopy(p->RIOPortp[port]->Xprint.XpOff, PortSetup.XpOff, MAX_XP_CTRL_LEN);
+		memcpy(PortSetup.XpOn, p->RIOPortp[port]->Xprint.XpOn, MAX_XP_CTRL_LEN);
+		memcpy(PortSetup.XpOff, p->RIOPortp[port]->Xprint.XpOff, MAX_XP_CTRL_LEN);
 		PortSetup.XpOn[MAX_XP_CTRL_LEN - 1] = '\0';
 		PortSetup.XpOff[MAX_XP_CTRL_LEN - 1] = '\0';
 
@@ -1404,7 +1399,7 @@
 		return RIO_FAIL;
 	}
 
-	rio_dprintk(RIO_DEBUG_CTRL, "Command blk 0x%p - InUse now %d\n", CmdBlkP, PortP->InUse);
+	rio_dprintk(RIO_DEBUG_CTRL, "Command blk %p - InUse now %d\n", CmdBlkP, PortP->InUse);
 
 	PktCmdP = (struct PktCmd_M *) &CmdBlkP->Packet.data[0];
 
@@ -1430,38 +1425,38 @@
 
 	switch (Cmd) {
 	case MEMDUMP:
-		rio_dprintk(RIO_DEBUG_CTRL, "Queue MEMDUMP command blk 0x%p (addr 0x%x)\n", CmdBlkP, (int) SubCmd.Addr);
+		rio_dprintk(RIO_DEBUG_CTRL, "Queue MEMDUMP command blk %p (addr 0x%x)\n", CmdBlkP, (int) SubCmd.Addr);
 		PktCmdP->SubCommand = MEMDUMP;
 		PktCmdP->SubAddr = SubCmd.Addr;
 		break;
 	case FCLOSE:
-		rio_dprintk(RIO_DEBUG_CTRL, "Queue FCLOSE command blk 0x%p\n", CmdBlkP);
+		rio_dprintk(RIO_DEBUG_CTRL, "Queue FCLOSE command blk %p\n", CmdBlkP);
 		break;
 	case READ_REGISTER:
-		rio_dprintk(RIO_DEBUG_CTRL, "Queue READ_REGISTER (0x%x) command blk 0x%p\n", (int) SubCmd.Addr, CmdBlkP);
+		rio_dprintk(RIO_DEBUG_CTRL, "Queue READ_REGISTER (0x%x) command blk %p\n", (int) SubCmd.Addr, CmdBlkP);
 		PktCmdP->SubCommand = READ_REGISTER;
 		PktCmdP->SubAddr = SubCmd.Addr;
 		break;
 	case RESUME:
-		rio_dprintk(RIO_DEBUG_CTRL, "Queue RESUME command blk 0x%p\n", CmdBlkP);
+		rio_dprintk(RIO_DEBUG_CTRL, "Queue RESUME command blk %p\n", CmdBlkP);
 		break;
 	case RFLUSH:
-		rio_dprintk(RIO_DEBUG_CTRL, "Queue RFLUSH command blk 0x%p\n", CmdBlkP);
+		rio_dprintk(RIO_DEBUG_CTRL, "Queue RFLUSH command blk %p\n", CmdBlkP);
 		CmdBlkP->PostFuncP = RIORFlushEnable;
 		break;
 	case SUSPEND:
-		rio_dprintk(RIO_DEBUG_CTRL, "Queue SUSPEND command blk 0x%p\n", CmdBlkP);
+		rio_dprintk(RIO_DEBUG_CTRL, "Queue SUSPEND command blk %p\n", CmdBlkP);
 		break;
 
 	case MGET:
-		rio_dprintk(RIO_DEBUG_CTRL, "Queue MGET command blk 0x%p\n", CmdBlkP);
+		rio_dprintk(RIO_DEBUG_CTRL, "Queue MGET command blk %p\n", CmdBlkP);
 		break;
 
 	case MSET:
 	case MBIC:
 	case MBIS:
 		CmdBlkP->Packet.data[4] = (char) PortP->ModemLines;
-		rio_dprintk(RIO_DEBUG_CTRL, "Queue MSET/MBIC/MBIS command blk 0x%p\n", CmdBlkP);
+		rio_dprintk(RIO_DEBUG_CTRL, "Queue MSET/MBIC/MBIS command blk %p\n", CmdBlkP);
 		break;
 
 	case WFLUSH:
@@ -1475,7 +1470,7 @@
 			RIOFreeCmdBlk(CmdBlkP);
 			return (RIO_FAIL);
 		} else {
-			rio_dprintk(RIO_DEBUG_CTRL, "Queue WFLUSH command blk 0x%p\n", CmdBlkP);
+			rio_dprintk(RIO_DEBUG_CTRL, "Queue WFLUSH command blk %p\n", CmdBlkP);
 			CmdBlkP->PostFuncP = RIOWFlushMark;
 		}
 		break;
diff -u --new-file --recursive --exclude-from /usr/src/exclude linux.vanilla-2.6.16-rc6-mm2/drivers/char/rio/rio.h linux-2.6.16-rc6-mm2/drivers/char/rio/rio.h
--- linux.vanilla-2.6.16-rc6-mm2/drivers/char/rio/rio.h	2006-03-19 18:20:51.332019808 +0000
+++ linux-2.6.16-rc6-mm2/drivers/char/rio/rio.h	2006-03-15 19:09:25.000000000 +0000
@@ -33,38 +33,6 @@
 #ifndef	__rio_rio_h__
 #define	__rio_rio_h__
 
-#ifdef SCCS_LABELS
-static char *_rio_h_sccs_ = "@(#)rio.h	1.3";
-#endif
-
-/*
-** 30.09.1998 ARG -
-** Introduced driver version and host card type strings
-*/
-#define RIO_DRV_STR "Specialix RIO Driver"
-#define RIO_AT_HOST_STR "ISA"
-#define RIO_PCI_HOST_STR "PCI"
-
-
-/*
-** rio_info_store() commands (arbitary values) :
-*/
-#define RIO_INFO_PUT	0xA4B3C2D1
-#define RIO_INFO_GET	0xF1E2D3C4
-
-
-/*
-** anything that I couldn't cram in somewhere else
-*/
-/*
-#ifndef RIODEBUG
-#define debug
-#else
-#define debug rioprint
-#endif
-*/
-
-
 /*
 **	Maximum numbers of things
 */
@@ -101,9 +69,8 @@
 /*
 **	Flag values returned by functions
 */
+
 #define	RIO_FAIL	-1
-#define	RIO_SUCCESS	0
-#define	COPYFAIL	-1	/* copy[in|out] failed */
 
 /*
 ** SysPort value for something that hasn't any ports
@@ -142,30 +109,8 @@
 /*
 **	Generally useful constants
 */
-#define	HALF_A_SECOND		((HZ)>>1)
-#define	A_SECOND		(HZ)
-#define	HUNDRED_HZ		((HZ/100)?(HZ/100):1)
-#define	FIFTY_HZ		((HZ/50)?(HZ/50):1)
-#define	TWENTY_HZ		((HZ/20)?(HZ/20):1)
-#define	TEN_HZ			((HZ/10)?(HZ/10):1)
-#define	FIVE_HZ			((HZ/5)?(HZ/5):1)
-#define	HUNDRED_MS		TEN_HZ
-#define	FIFTY_MS		TWENTY_HZ
-#define	TWENTY_MS		FIFTY_HZ
-#define	TEN_MS			HUNDRED_HZ
-#define	TWO_SECONDS		((A_SECOND)*2)
-#define	FIVE_SECONDS		((A_SECOND)*5)
-#define	TEN_SECONDS		((A_SECOND)*10)
-#define	FIFTEEN_SECONDS		((A_SECOND)*15)
-#define	TWENTY_SECONDS		((A_SECOND)*20)
-#define	HALF_A_MINUTE		(A_MINUTE>>1)
-#define	A_MINUTE		(A_SECOND*60)
-#define	FIVE_MINUTES		(A_MINUTE*5)
-#define	QUARTER_HOUR		(A_MINUTE*15)
-#define	HALF_HOUR		(A_MINUTE*30)
-#define	HOUR			(A_MINUTE*60)
 
-#define	SIXTEEN_MEG		0x1000000
+#define	HUNDRED_MS		((HZ/10)?(HZ/10):1)
 #define	ONE_MEG			0x100000
 #define	SIXTY_FOUR_K		0x10000
 
@@ -173,8 +118,6 @@
 #define	RIO_EISA_MEM_SIZE	SIXTY_FOUR_K
 #define	RIO_MCA_MEM_SIZE	SIXTY_FOUR_K
 
-#define	POLL_VECTOR		0x100
-
 #define	COOK_WELL		0
 #define	COOK_MEDIUM		1
 #define	COOK_RAW		2
@@ -193,62 +136,19 @@
 **	How to convert from various different device number formats:
 **	DEV is a dev number, as passed to open, close etc - NOT a minor
 **	number!
-**
-**	Note:	LynxOS only gives us 8 bits for the device minor number,
-**		so all this crap here to deal with 'modem' bits etc. is
-**		just a load of irrelevant old bunkum!
-**		This however does not stop us needing to define a value
-**		for RIO_MODEMOFFSET which is required by the 'riomkdev'
-**		utility in the New Config Utilities suite.
-*/
-/* 0-511: direct 512-1023: modem */
-#define	RIO_MODEMOFFSET		0x200	/* doesn't mean anything */
+**/
+
 #define	RIO_MODEM_MASK		0x1FF
 #define	RIO_MODEM_BIT		0x200
 #define	RIO_UNMODEM(DEV)	(MINOR(DEV) & RIO_MODEM_MASK)
 #define	RIO_ISMODEM(DEV)	(MINOR(DEV) & RIO_MODEM_BIT)
 #define RIO_PORT(DEV,FIRST_MAJ)	( (MAJOR(DEV) - FIRST_MAJ) * PORTS_PER_HOST) \
 					+ MINOR(DEV)
-
-#define	splrio	spltty
-
-#define	RIO_IPL	5
-#define	RIO_PRI	(PZERO+10)
-#define RIO_CLOSE_PRI	PZERO-1	/* uninterruptible sleeps for close */
-
-typedef struct DbInf {
-	uint Flag;
-	char Name[8];
-} DbInf;
-
-#ifndef TRUE
-#define	TRUE (1==1)
-#endif
-#ifndef FALSE
-#define	FALSE	(!TRUE)
-#endif
-
-#define CSUM(pkt_ptr)  (((ushort *)(pkt_ptr))[0] + ((ushort *)(pkt_ptr))[1] + \
-			((ushort *)(pkt_ptr))[2] + ((ushort *)(pkt_ptr))[3] + \
-			((ushort *)(pkt_ptr))[4] + ((ushort *)(pkt_ptr))[5] + \
-			((ushort *)(pkt_ptr))[6] + ((ushort *)(pkt_ptr))[7] + \
-			((ushort *)(pkt_ptr))[8] + ((ushort *)(pkt_ptr))[9] )
-
-/*
-** This happy little macro copies SIZE bytes of data from FROM to TO
-** quite well. SIZE must be a constant.
-*/
-#define CCOPY( FROM, TO, SIZE ) { *(struct s { char data[SIZE]; } *)(TO) = *(struct s *)(FROM); }
-
-/*
-** increment a buffer pointer modulo the size of the buffer...
-*/
-#define	BUMP( P, I )	((P) = (((P)+(I)) & RIOBufferMask))
-
-#define INIT_PACKET( PK, PP ) \
-{ \
-	*((uint *)PK)    = PP->PacketInfo; \
-}
+#define CSUM(pkt_ptr)  (((u16 *)(pkt_ptr))[0] + ((u16 *)(pkt_ptr))[1] + \
+			((u16 *)(pkt_ptr))[2] + ((u16 *)(pkt_ptr))[3] + \
+			((u16 *)(pkt_ptr))[4] + ((u16 *)(pkt_ptr))[5] + \
+			((u16 *)(pkt_ptr))[6] + ((u16 *)(pkt_ptr))[7] + \
+			((u16 *)(pkt_ptr))[8] + ((u16 *)(pkt_ptr))[9] )
 
 #define	RIO_LINK_ENABLE	0x80FF	/* FF is a hack, mainly for Mips, to        */
 			       /* prevent a really stupid race condition.  */
@@ -267,27 +167,42 @@
 #define	DISCONNECT	0
 #define	CONNECT		1
 
+/* ------ Control Codes ------ */
 
-/*
-** Machine types - these must NOT overlap with product codes 0-15
-*/
-#define	RIO_MIPS_R3230	31
-#define	RIO_MIPS_R4030	32
-
-#define	RIO_IO_UNKNOWN	-2
-
-#undef	MODERN
-#define	ERROR( E )	do { u.u_error = E; return OPENFAIL } while ( 0 )
-
-/* Defines for MPX line discipline routines */
-
-#define DIST_LINESW_OPEN	0x01
-#define DIST_LINESW_CLOSE	0x02
-#define DIST_LINESW_READ	0x04
-#define DIST_LINESW_WRITE	0x08
-#define DIST_LINESW_IOCTL	0x10
-#define DIST_LINESW_INPUT	0x20
-#define DIST_LINESW_OUTPUT	0x40
-#define DIST_LINESW_MDMINT	0x80
+#define	CONTROL		'^'
+#define IFOAD		( CONTROL + 1 )
+#define	IDENTIFY	( CONTROL + 2 )
+#define	ZOMBIE		( CONTROL + 3 )
+#define	UFOAD		( CONTROL + 4 )
+#define IWAIT		( CONTROL + 5 )
+
+#define	IFOAD_MAGIC	0xF0AD	/* of course */
+#define	ZOMBIE_MAGIC	(~0xDEAD)	/* not dead -> zombie */
+#define	UFOAD_MAGIC	0xD1E	/* kill-your-neighbour */
+#define	IWAIT_MAGIC	0xB1DE	/* Bide your time */
+
+/* ------ Error Codes ------ */
+
+#define E_NO_ERROR                       ((ushort) 0)
+
+/* ------ Free Lists ------ */
+
+struct rio_free_list {
+	u16 next;
+	u16 prev;
+};
+
+/* NULL for card side linked lists */
+#define	TPNULL	((ushort)(0x8000))
+/* We can add another packet to a transmit queue if the packet pointer pointed
+ * to by the TxAdd pointer has PKT_IN_USE clear in its address. */
+#define PKT_IN_USE    0x1
+
+/* ------ Topology ------ */
+
+struct Top {
+	u8 Unit;
+	u8 Link;
+};
 
 #endif				/* __rio_h__ */
diff -u --new-file --recursive --exclude-from /usr/src/exclude linux.vanilla-2.6.16-rc6-mm2/drivers/char/rio/rioinit.c linux-2.6.16-rc6-mm2/drivers/char/rio/rioinit.c
--- linux.vanilla-2.6.16-rc6-mm2/drivers/char/rio/rioinit.c	2006-03-19 18:20:51.333019656 +0000
+++ linux-2.6.16-rc6-mm2/drivers/char/rio/rioinit.c	2006-03-15 19:10:28.000000000 +0000
@@ -51,15 +51,12 @@
 
 
 #include "linux_compat.h"
-#include "typdef.h"
 #include "pkt.h"
 #include "daemon.h"
 #include "rio.h"
 #include "riospace.h"
-#include "top.h"
 #include "cmdpkt.h"
 #include "map.h"
-#include "riotypes.h"
 #include "rup.h"
 #include "port.h"
 #include "riodrvr.h"
@@ -72,19 +69,17 @@
 #include "unixrup.h"
 #include "board.h"
 #include "host.h"
-#include "error.h"
 #include "phb.h"
 #include "link.h"
 #include "cmdblk.h"
 #include "route.h"
-#include "control.h"
 #include "cirrus.h"
 #include "rioioctl.h"
 #include "rio_linux.h"
 
 int RIOPCIinit(struct rio_info *p, int Mode);
 
-static int RIOScrub(int, BYTE *, int);
+static int RIOScrub(int, u8 *, int);
 
 
 /**
@@ -125,7 +120,7 @@
 											/* set this later */
 	p->RIOHosts[p->RIONumHosts].Slot = -1;
 	p->RIOHosts[p->RIONumHosts].Mode = SLOW_LINKS | SLOW_AT_BUS | bits;
-	writeb(BOOT_FROM_RAM | EXTERNAL_BUS_OFF | p->RIOHosts[p->RIONumHosts].Mode | INTERRUPT_DISABLE ,
+	writeb(BOOT_FROM_RAM | EXTERNAL_BUS_OFF | p->RIOHosts[p->RIONumHosts].Mode | INTERRUPT_DISABLE , 
 		&p->RIOHosts[p->RIONumHosts].Control);
 	writeb(0xFF, &p->RIOHosts[p->RIONumHosts].ResetInt);
 	writeb(BOOT_FROM_RAM | EXTERNAL_BUS_OFF | p->RIOHosts[p->RIONumHosts].Mode | INTERRUPT_DISABLE,
@@ -156,7 +151,7 @@
 ** RAM test a board. 
 ** Nothing too complicated, just enough to check it out.
 */
-int RIOBoardTest(paddr_t paddr, caddr_t	caddr, unsigned char type, int slot)
+int RIOBoardTest(unsigned long paddr, caddr_t	caddr, unsigned char type, int slot)
 {
 	struct DpRam *DpRam = (struct DpRam *)caddr;
 	char *ram[4];
@@ -164,7 +159,7 @@
 	int  op, bank;
 	int  nbanks;
 
-	rio_dprintk (RIO_DEBUG_INIT, "RIO-init: Reset host type=%d, DpRam=0x%p, slot=%d\n",
+	rio_dprintk (RIO_DEBUG_INIT, "RIO-init: Reset host type=%d, DpRam=%p, slot=%d\n",
 			type, DpRam, slot);
 
 	RIOHostReset(type, DpRam, slot);
@@ -193,10 +188,10 @@
 
 
 	if (nbanks == 3) {
-		rio_dprintk (RIO_DEBUG_INIT, "RIO-init: Memory: 0x%p(0x%x), 0x%p(0x%x), 0x%p(0x%x)\n",
+		rio_dprintk (RIO_DEBUG_INIT, "RIO-init: Memory: %p(0x%x), %p(0x%x), %p(0x%x)\n",
 				ram[0], size[0], ram[1], size[1], ram[2], size[2]);
 	} else {
-		rio_dprintk (RIO_DEBUG_INIT, "RIO-init: 0x%p(0x%x), 0x%p(0x%x), 0x%p(0x%x), 0x%p(0x%x)\n",
+		rio_dprintk (RIO_DEBUG_INIT, "RIO-init: %p(0x%x), %p(0x%x), %p(0x%x), %p(0x%x)\n",
 				ram[0], size[0], ram[1], size[1], ram[2], size[2], ram[3], size[3]);
 	}
 
@@ -207,7 +202,7 @@
 	*/
 	for (op=0; op<TEST_END; op++) {
 		for (bank=0; bank<nbanks; bank++) {
-			if (RIOScrub(op, (BYTE *)ram[bank], size[bank]) == RIO_FAIL) {
+			if (RIOScrub(op, (u8 *)ram[bank], size[bank]) == RIO_FAIL) {
 				rio_dprintk (RIO_DEBUG_INIT, "RIO-init: RIOScrub band %d, op %d failed\n", 
 							bank, op);
 				return RIO_FAIL;
@@ -216,7 +211,7 @@
 	}
 
 	rio_dprintk (RIO_DEBUG_INIT, "Test completed\n");
-	return RIO_SUCCESS;
+	return 0;
 }
 
 
@@ -232,7 +227,7 @@
 ** to check that the data from the previous phase was retained.
 */
 
-static int RIOScrub(int op, BYTE *ram, int size)
+static int RIOScrub(int op, u8 *ram, int size)
 {
 	int off;
 	unsigned char	oldbyte;
@@ -364,7 +359,7 @@
 		}
 		writew(newword, ram + off);
 	}
-	return RIO_SUCCESS;
+	return 0;
 }
 
 
@@ -412,7 +407,7 @@
 		writeb(0xFF, &DpRamP->DpResetTpu);
 		udelay(3);
 			rio_dprintk (RIO_DEBUG_INIT,  "RIOHostReset: Don't know if it worked. Try reset again\n");
-		writeb(BOOT_FROM_RAM | EXTERNAL_BUS_OFF | INTERRUPT_DISABLE |
+		writeb(BOOT_FROM_RAM | EXTERNAL_BUS_OFF | INTERRUPT_DISABLE | 
 			BYTE_OPERATION | SLOW_LINKS | SLOW_AT_BUS, &DpRamP->DpControl);
 		writeb(0xFF, &DpRamP->DpResetTpu);
 		udelay(3);
diff -u --new-file --recursive --exclude-from /usr/src/exclude linux.vanilla-2.6.16-rc6-mm2/drivers/char/rio/riointr.c linux-2.6.16-rc6-mm2/drivers/char/rio/riointr.c
--- linux.vanilla-2.6.16-rc6-mm2/drivers/char/rio/riointr.c	2006-03-19 18:20:51.334019504 +0000
+++ linux-2.6.16-rc6-mm2/drivers/char/rio/riointr.c	2006-03-15 19:10:38.000000000 +0000
@@ -54,15 +54,12 @@
 
 #include "linux_compat.h"
 #include "rio_linux.h"
-#include "typdef.h"
 #include "pkt.h"
 #include "daemon.h"
 #include "rio.h"
 #include "riospace.h"
-#include "top.h"
 #include "cmdpkt.h"
 #include "map.h"
-#include "riotypes.h"
 #include "rup.h"
 #include "port.h"
 #include "riodrvr.h"
@@ -75,12 +72,10 @@
 #include "unixrup.h"
 #include "board.h"
 #include "host.h"
-#include "error.h"
 #include "phb.h"
 #include "link.h"
 #include "cmdblk.h"
 #include "route.h"
-#include "control.h"
 #include "cirrus.h"
 #include "rioioctl.h"
 
@@ -396,7 +391,6 @@
 			/* For now don't handle RTA reboots. -- REW.
 			   Reenabled. Otherwise RTA reboots didn't work. Duh. -- REW */
 			if (PortP->MagicFlags) {
-#if 1
 				if (PortP->MagicFlags & MAGIC_REBOOT) {
 					/*
 					 ** well, the RTA has been rebooted, and there is room
@@ -413,13 +407,12 @@
 					PortP->InUse = NOT_INUSE;
 
 					rio_spin_unlock(&PortP->portSem);
-					if (RIOParam(PortP, OPEN, ((PortP->Cor2Copy & (COR2_RTSFLOW | COR2_CTSFLOW)) == (COR2_RTSFLOW | COR2_CTSFLOW)) ? TRUE : FALSE, DONT_SLEEP) == RIO_FAIL) {
+					if (RIOParam(PortP, OPEN, ((PortP->Cor2Copy & (COR2_RTSFLOW | COR2_CTSFLOW)) == (COR2_RTSFLOW | COR2_CTSFLOW)) ? 1 : 0, DONT_SLEEP) == RIO_FAIL) {
 						continue;	/* with next port */
 					}
 					rio_spin_lock(&PortP->portSem);
 					PortP->MagicFlags &= ~MAGIC_REBOOT;
 				}
-#endif
 
 				/*
 				 ** As mentioned above, this is a tacky hack to cope
diff -u --new-file --recursive --exclude-from /usr/src/exclude linux.vanilla-2.6.16-rc6-mm2/drivers/char/rio/rio_linux.c linux-2.6.16-rc6-mm2/drivers/char/rio/rio_linux.c
--- linux.vanilla-2.6.16-rc6-mm2/drivers/char/rio/rio_linux.c	2006-03-19 18:20:51.336019200 +0000
+++ linux-2.6.16-rc6-mm2/drivers/char/rio/rio_linux.c	2006-03-17 14:02:07.000000000 +0000
@@ -57,15 +57,12 @@
 #include <asm/uaccess.h>
 
 #include "linux_compat.h"
-#include "typdef.h"
 #include "pkt.h"
 #include "daemon.h"
 #include "rio.h"
 #include "riospace.h"
-#include "top.h"
 #include "cmdpkt.h"
 #include "map.h"
-#include "riotypes.h"
 #include "rup.h"
 #include "port.h"
 #include "riodrvr.h"
@@ -78,17 +75,13 @@
 #include "unixrup.h"
 #include "board.h"
 #include "host.h"
-#include "error.h"
 #include "phb.h"
 #include "link.h"
 #include "cmdblk.h"
 #include "route.h"
-#include "control.h"
 #include "cirrus.h"
 #include "rioioctl.h"
 #include "param.h"
-#include "list.h"
-#include "sam.h"
 #include "protsts.h"
 #include "rioboard.h"
 
@@ -350,27 +343,9 @@
 	return tty->index + (tty->driver == rio_driver) ? 0 : 256;
 }
 
-int rio_ismodem(struct tty_struct *tty)
-{
-	return 1;
-}
-
-
 static int rio_set_real_termios(void *ptr)
 {
-	int rv, modem;
-	struct tty_struct *tty;
-	func_enter();
-
-	tty = ((struct Port *) ptr)->gs.tty;
-
-	modem = rio_ismodem(tty);
-
-	rv = RIOParam((struct Port *) ptr, CONFIG, modem, 1);
-
-	func_exit();
-
-	return rv;
+	return RIOParam((struct Port *) ptr, CONFIG, 1, 1);
 }
 
 
@@ -973,7 +948,6 @@
 
 #ifdef CONFIG_PCI
 	struct pci_dev *pdev = NULL;
-	unsigned int tint;
 	unsigned short tshort;
 #endif
 
@@ -998,6 +972,8 @@
 #ifdef CONFIG_PCI
 	/* First look for the JET devices: */
 	while ((pdev = pci_get_device(PCI_VENDOR_ID_SPECIALIX, PCI_DEVICE_ID_SPECIALIX_SX_XIO_IO8, pdev))) {
+		u32 tint;
+		
 		if (pci_enable_device(pdev))
 			continue;
 
@@ -1008,7 +984,6 @@
 		   Also, reading a non-aligned dword doesn't work. So we read the
 		   whole dword at 0x2c and extract the word at 0x2e (SUBSYSTEM_ID)
 		   ourselves */
-		/* I don't know why the define doesn't work, constant 0x2c does --REW */
 		pci_read_config_dword(pdev, 0x2c, &tint);
 		tshort = (tint >> 16) & 0xffff;
 		rio_dprintk(RIO_DEBUG_PROBE, "Got a specialix card: %x.\n", tint);
@@ -1018,10 +993,8 @@
 		}
 		rio_dprintk(RIO_DEBUG_PROBE, "cp1\n");
 
-		pci_read_config_dword(pdev, PCI_BASE_ADDRESS_2, &tint);
-
 		hp = &p->RIOHosts[p->RIONumHosts];
-		hp->PaddrP = tint & PCI_BASE_ADDRESS_MEM_MASK;
+		hp->PaddrP = pci_resource_start(pdev, 2);
 		hp->Ivec = pdev->irq;
 		if (((1 << hp->Ivec) & rio_irqmask) == 0)
 			hp->Ivec = 0;
@@ -1035,7 +1008,7 @@
 		rio_start_card_running(hp);
 
 		rio_dprintk(RIO_DEBUG_PROBE, "Going to test it (%p/%p).\n", (void *) p->RIOHosts[p->RIONumHosts].PaddrP, p->RIOHosts[p->RIONumHosts].Caddr);
-		if (RIOBoardTest(p->RIOHosts[p->RIONumHosts].PaddrP, p->RIOHosts[p->RIONumHosts].Caddr, RIO_PCI, 0) == RIO_SUCCESS) {
+		if (RIOBoardTest(p->RIOHosts[p->RIONumHosts].PaddrP, p->RIOHosts[p->RIONumHosts].Caddr, RIO_PCI, 0) == 0) {
 			rio_dprintk(RIO_DEBUG_INIT, "Done RIOBoardTest\n");
 			writeb(0xFF, &p->RIOHosts[p->RIONumHosts].ResetInt);
 			p->RIOHosts[p->RIONumHosts].UniqueNum =
@@ -1044,7 +1017,7 @@
 			rio_dprintk(RIO_DEBUG_PROBE, "Hmm Tested ok, uniqid = %x.\n", p->RIOHosts[p->RIONumHosts].UniqueNum);
 
 			fix_rio_pci(pdev);
-			p->RIOLastPCISearch = RIO_SUCCESS;
+			p->RIOLastPCISearch = 0;
 			p->RIONumHosts++;
 			found++;
 		} else {
@@ -1067,10 +1040,8 @@
 			continue;
 
 #ifdef CONFIG_RIO_OLDPCI
-		pci_read_config_dword(pdev, PCI_BASE_ADDRESS_0, &tint);
-
 		hp = &p->RIOHosts[p->RIONumHosts];
-		hp->PaddrP = tint & PCI_BASE_ADDRESS_MEM_MASK;
+		hp->PaddrP = pci_resource_start(pdev, 0);
 		hp->Ivec = pdev->irq;
 		if (((1 << hp->Ivec) & rio_irqmask) == 0)
 			hp->Ivec = 0;
@@ -1088,14 +1059,14 @@
 		rio_reset_interrupt(hp);
 		rio_start_card_running(hp);
 		rio_dprintk(RIO_DEBUG_PROBE, "Going to test it (%p/%p).\n", (void *) p->RIOHosts[p->RIONumHosts].PaddrP, p->RIOHosts[p->RIONumHosts].Caddr);
-		if (RIOBoardTest(p->RIOHosts[p->RIONumHosts].PaddrP, p->RIOHosts[p->RIONumHosts].Caddr, RIO_PCI, 0) == RIO_SUCCESS) {
+		if (RIOBoardTest(p->RIOHosts[p->RIONumHosts].PaddrP, p->RIOHosts[p->RIONumHosts].Caddr, RIO_PCI, 0) == 0) {
 			writeb(0xFF, &p->RIOHosts[p->RIONumHosts].ResetInt);
 			p->RIOHosts[p->RIONumHosts].UniqueNum =
 			    ((readb(&p->RIOHosts[p->RIONumHosts].Unique[0]) & 0xFF) << 0) |
 			    ((readb(&p->RIOHosts[p->RIONumHosts].Unique[1]) & 0xFF) << 8) | ((readb(&p->RIOHosts[p->RIONumHosts].Unique[2]) & 0xFF) << 16) | ((readb(&p->RIOHosts[p->RIONumHosts].Unique[3]) & 0xFF) << 24);
 			rio_dprintk(RIO_DEBUG_PROBE, "Hmm Tested ok, uniqid = %x.\n", p->RIOHosts[p->RIONumHosts].UniqueNum);
 
-			p->RIOLastPCISearch = RIO_SUCCESS;
+			p->RIOLastPCISearch = 0;
 			p->RIONumHosts++;
 			found++;
 		} else {
@@ -1129,7 +1100,7 @@
 		okboard = 0;
 		if ((strncmp(vpdp->identifier, RIO_ISA_IDENT, 16) == 0) || (strncmp(vpdp->identifier, RIO_ISA2_IDENT, 16) == 0) || (strncmp(vpdp->identifier, RIO_ISA3_IDENT, 16) == 0)) {
 			/* Board is present... */
-			if (RIOBoardTest(hp->PaddrP, hp->Caddr, RIO_AT, 0) == RIO_SUCCESS) {
+			if (RIOBoardTest(hp->PaddrP, hp->Caddr, RIO_AT, 0) == 0) {
 				/* ... and feeling fine!!!! */
 				rio_dprintk(RIO_DEBUG_PROBE, "Hmm Tested ok, uniqid = %x.\n", p->RIOHosts[p->RIONumHosts].UniqueNum);
 				if (RIOAssignAT(p, hp->PaddrP, hp->Caddr, 0)) {
@@ -1231,24 +1202,3 @@
 
 module_init(rio_init);
 module_exit(rio_exit);
-
-/*
- * Anybody who knows why this doesn't work for me, please tell me -- REW.
- * Snatched from scsi.c (fixed one spelling error):
- * Overrides for Emacs so that we follow Linus' tabbing style.
- * Emacs will notice this stuff at the end of the file and automatically
- * adjust the settings for this buffer only.  This must remain at the end
- * of the file.
- * ---------------------------------------------------------------------------
- * Local Variables:
- * c-indent-level: 4
- * c-brace-imaginary-offset: 0
- * c-brace-offset: -4
- * c-argdecl-indent: 4
- * c-label-offset: -4
- * c-continued-statement-offset: 4
- * c-continued-brace-offset: 0
- * indent-tabs-mode: nil
- * tab-width: 8
- * End:
- */
diff -u --new-file --recursive --exclude-from /usr/src/exclude linux.vanilla-2.6.16-rc6-mm2/drivers/char/rio/rioparam.c linux-2.6.16-rc6-mm2/drivers/char/rio/rioparam.c
--- linux.vanilla-2.6.16-rc6-mm2/drivers/char/rio/rioparam.c	2006-03-19 18:20:51.336019200 +0000
+++ linux-2.6.16-rc6-mm2/drivers/char/rio/rioparam.c	2006-03-15 19:11:12.000000000 +0000
@@ -52,15 +52,12 @@
 
 #include "linux_compat.h"
 #include "rio_linux.h"
-#include "typdef.h"
 #include "pkt.h"
 #include "daemon.h"
 #include "rio.h"
 #include "riospace.h"
-#include "top.h"
 #include "cmdpkt.h"
 #include "map.h"
-#include "riotypes.h"
 #include "rup.h"
 #include "port.h"
 #include "riodrvr.h"
@@ -73,17 +70,13 @@
 #include "unixrup.h"
 #include "board.h"
 #include "host.h"
-#include "error.h"
 #include "phb.h"
 #include "link.h"
 #include "cmdblk.h"
 #include "route.h"
-#include "control.h"
 #include "cirrus.h"
 #include "rioioctl.h"
 #include "param.h"
-#include "list.h"
-#include "sam.h"
 
 
 
@@ -162,7 +155,7 @@
 	struct tty_struct *TtyP;
 	int retval;
 	struct phb_param *phb_param_ptr;
-	PKT *PacketP;
+	struct PKT *PacketP;
 	int res;
 	u8 Cor1 = 0, Cor2 = 0, Cor4 = 0, Cor5 = 0;
 	u8 TxXon = 0, TxXoff = 0, RxXon = 0, RxXoff = 0;
@@ -228,7 +221,7 @@
 		if (PortP->State & RIO_DELETED) {
 			rio_spin_unlock_irqrestore(&PortP->portSem, flags);
 			func_exit();
-			return RIO_SUCCESS;
+			return 0;
 		}
 	}
 
@@ -240,7 +233,7 @@
 	}
 
 	rio_dprintk(RIO_DEBUG_PARAM, "can_add_transmit() returns %x\n", res);
-	rio_dprintk(RIO_DEBUG_PARAM, "Packet is 0x%p\n", PacketP);
+	rio_dprintk(RIO_DEBUG_PARAM, "Packet is %p\n", PacketP);
 
 	phb_param_ptr = (struct phb_param *) PacketP->data;
 
@@ -579,7 +572,7 @@
 	 */
 	func_exit();
 
-	return RIO_SUCCESS;
+	return 0;
 }
 
 
@@ -587,11 +580,11 @@
 ** We can add another packet to a transmit queue if the packet pointer pointed
 ** to by the TxAdd pointer has PKT_IN_USE clear in its address.
 */
-int can_add_transmit(PKT **PktP, struct Port *PortP)
+int can_add_transmit(struct PKT **PktP, struct Port *PortP)
 {
-	PKT *tp;
+	struct PKT *tp;
 
-	*PktP = tp = (PKT *) RIO_PTR(PortP->Caddr, readw(PortP->TxAdd));
+	*PktP = tp = (struct PKT *) RIO_PTR(PortP->Caddr, readw(PortP->TxAdd));
 
 	return !((unsigned long) tp & PKT_IN_USE);
 }
@@ -615,10 +608,10 @@
  * Put a packet onto the end of the
  * free list
  ****************************************/
-void put_free_end(struct Host *HostP, PKT *PktP)
+void put_free_end(struct Host *HostP, struct PKT *PktP)
 {
-	FREE_LIST *tmp_pointer;
-	ushort old_end, new_end;
+	struct rio_free_list *tmp_pointer;
+	unsigned short old_end, new_end;
 	unsigned long flags;
 
 	rio_spin_lock_irqsave(&HostP->HostLock, flags);
@@ -632,15 +625,15 @@
 
 	if ((old_end = readw(&HostP->ParmMapP->free_list_end)) != TPNULL) {
 		new_end = RIO_OFF(HostP->Caddr, PktP);
-		tmp_pointer = (FREE_LIST *) RIO_PTR(HostP->Caddr, old_end);
+		tmp_pointer = (struct rio_free_list *) RIO_PTR(HostP->Caddr, old_end);
 		writew(new_end, &tmp_pointer->next);
-		writew(old_end, &((FREE_LIST *) PktP)->prev);
-		writew(TPNULL, &((FREE_LIST *) PktP)->next);
+		writew(old_end, &((struct rio_free_list *) PktP)->prev);
+		writew(TPNULL, &((struct rio_free_list *) PktP)->next);
 		writew(new_end, &HostP->ParmMapP->free_list_end);
 	} else {		/* First packet on the free list this should never happen! */
 		rio_dprintk(RIO_DEBUG_PFE, "put_free_end(): This should never happen\n");
 		writew(RIO_OFF(HostP->Caddr, PktP), &HostP->ParmMapP->free_list_end);
-		tmp_pointer = (FREE_LIST *) PktP;
+		tmp_pointer = (struct rio_free_list *) PktP;
 		writew(TPNULL, &tmp_pointer->prev);
 		writew(TPNULL, &tmp_pointer->next);
 	}
@@ -654,10 +647,10 @@
 ** relevant packet, [having cleared the PKT_IN_USE bit]. If PKT_IN_USE is clear,
 ** then can_remove_receive() returns 0.
 */
-int can_remove_receive(PKT **PktP, struct Port *PortP)
+int can_remove_receive(struct PKT **PktP, struct Port *PortP)
 {
 	if (readw(PortP->RxRemove) & PKT_IN_USE) {
-		*PktP = (PKT *) RIO_PTR(PortP->Caddr, readw(PortP->RxRemove) & ~PKT_IN_USE);
+		*PktP = (struct PKT *) RIO_PTR(PortP->Caddr, readw(PortP->RxRemove) & ~PKT_IN_USE);
 		return 1;
 	}
 	return 0;
diff -u --new-file --recursive --exclude-from /usr/src/exclude linux.vanilla-2.6.16-rc6-mm2/drivers/char/rio/rioroute.c linux-2.6.16-rc6-mm2/drivers/char/rio/rioroute.c
--- linux.vanilla-2.6.16-rc6-mm2/drivers/char/rio/rioroute.c	2006-03-19 18:20:51.338018896 +0000
+++ linux-2.6.16-rc6-mm2/drivers/char/rio/rioroute.c	2006-03-16 13:15:55.000000000 +0000
@@ -50,15 +50,12 @@
 
 #include "linux_compat.h"
 #include "rio_linux.h"
-#include "typdef.h"
 #include "pkt.h"
 #include "daemon.h"
 #include "rio.h"
 #include "riospace.h"
-#include "top.h"
 #include "cmdpkt.h"
 #include "map.h"
-#include "riotypes.h"
 #include "rup.h"
 #include "port.h"
 #include "riodrvr.h"
@@ -71,29 +68,25 @@
 #include "unixrup.h"
 #include "board.h"
 #include "host.h"
-#include "error.h"
 #include "phb.h"
 #include "link.h"
 #include "cmdblk.h"
 #include "route.h"
-#include "control.h"
 #include "cirrus.h"
 #include "rioioctl.h"
 #include "param.h"
-#include "list.h"
-#include "sam.h"
 
-static int RIOCheckIsolated(struct rio_info *, struct Host *, uint);
-static int RIOIsolate(struct rio_info *, struct Host *, uint);
-static int RIOCheck(struct Host *, uint);
-static void RIOConCon(struct rio_info *, struct Host *, uint, uint, uint, uint, int);
+static int RIOCheckIsolated(struct rio_info *, struct Host *, unsigned int);
+static int RIOIsolate(struct rio_info *, struct Host *, unsigned int);
+static int RIOCheck(struct Host *, unsigned int);
+static void RIOConCon(struct rio_info *, struct Host *, unsigned int, unsigned int, unsigned int, unsigned int, int);
 
 
 /*
 ** Incoming on the ROUTE_RUP
 ** I wrote this while I was tired. Forgive me.
 */
-int RIORouteRup(struct rio_info *p, uint Rup, struct Host *HostP, PKT * PacketP)
+int RIORouteRup(struct rio_info *p, unsigned int Rup, struct Host *HostP, struct PKT * PacketP)
 {
 	struct PktCmd *PktCmdP = (struct PktCmd *) PacketP->data;
 	struct PktCmd_M *PktReplyP;
@@ -104,10 +97,10 @@
 	int ThisLink, ThisLinkMin, ThisLinkMax;
 	int port;
 	int Mod, Mod1, Mod2;
-	ushort RtaType;
-	uint RtaUniq;
-	uint ThisUnit, ThisUnit2;	/* 2 ids to accommodate 16 port RTA */
-	uint OldUnit, NewUnit, OldLink, NewLink;
+	unsigned short RtaType;
+	unsigned int RtaUniq;
+	unsigned int ThisUnit, ThisUnit2;	/* 2 ids to accommodate 16 port RTA */
+	unsigned int OldUnit, NewUnit, OldLink, NewLink;
 	char *MyType, *MyName;
 	int Lies;
 	unsigned long flags;
@@ -125,7 +118,7 @@
 		 ** from an RTA then we need to fill in the Mapping structure's
 		 ** Topology array for the unit.
 		 */
-		if (Rup >= (ushort) MAX_RUP) {
+		if (Rup >= (unsigned short) MAX_RUP) {
 			ThisUnit = HOST_ID;
 			TopP = HostP->Topology;
 			MyType = "Host";
@@ -151,7 +144,7 @@
 			 ** it won't lie about network interconnect, total disconnects
 			 ** and no-IDs. (or at least, it doesn't *matter* if it does)
 			 */
-			if (readb(&PktCmdP->RouteTopology[ThisLink].Unit) > (ushort) MAX_RUP)
+			if (readb(&PktCmdP->RouteTopology[ThisLink].Unit) > (unsigned short) MAX_RUP)
 				continue;
 
 			for (NewLink = ThisLinkMin; NewLink < ThisLink; NewLink++) {
@@ -168,7 +161,7 @@
 				    'A' + readb(&PktCmdP->RouteTopology[0].Link),
 				    readb(&PktCmdP->RouteTopology[1].Unit),
 				    'A' + readb(&PktCmdP->RouteTopology[1].Link), readb(&PktCmdP->RouteTopology[2].Unit), 'A' + readb(&PktCmdP->RouteTopology[2].Link), readb(&PktCmdP->RouteTopology[3].Unit), 'A' + readb(&PktCmdP->RouteTopology[3].Link));
-			return TRUE;
+			return 1;
 		}
 
 		/*
@@ -258,7 +251,7 @@
 				RIOCheckIsolated(p, HostP, OldUnit);
 			}
 		}
-		return TRUE;
+		return 1;
 	}
 
 	/*
@@ -266,7 +259,7 @@
 	 */
 	if (readb(&PktCmdP->Command) != ROUTE_REQUEST) {
 		rio_dprintk(RIO_DEBUG_ROUTE, "Unknown command %d received on rup %d host %p ROUTE_RUP\n", readb(&PktCmdP->Command), Rup, HostP);
-		return TRUE;
+		return 1;
 	}
 
 	RtaUniq = (readb(&PktCmdP->UniqNum[0])) + (readb(&PktCmdP->UniqNum[1]) << 8) + (readb(&PktCmdP->UniqNum[2]) << 16) + (readb(&PktCmdP->UniqNum[3]) << 24);
@@ -292,10 +285,6 @@
 		rio_dprintk(RIO_DEBUG_ROUTE, "Module types are %s (ports 0-3) and %s (ports 4-7)\n", p->RIOModuleTypes[Mod1].Name, p->RIOModuleTypes[Mod2].Name);
 	}
 
-	if (RtaUniq == 0xffffffff) {
-		ShowPacket(DBG_SPECIAL, PacketP);
-	}
-
 	/*
 	 ** try to unhook a command block from the command free list.
 	 */
@@ -320,7 +309,7 @@
 		PktReplyP->Command = ROUTE_FOAD;
 		HostP->Copy("RT_FOAD", PktReplyP->CommandText, 7);
 		RIOQueueCmdBlk(HostP, Rup, CmdBlkP);
-		return TRUE;
+		return 1;
 	}
 
 	/*
@@ -354,7 +343,7 @@
 				PktReplyP->Command = ROUTE_FOAD;
 				HostP->Copy("RT_FOAD", PktReplyP->CommandText, 7);
 				RIOQueueCmdBlk(HostP, Rup, CmdBlkP);
-				return TRUE;
+				return 1;
 			}
 
 			/*
@@ -447,7 +436,7 @@
 			/*
 			 ** Job done, get on with the interrupts!
 			 */
-			return TRUE;
+			return 1;
 		}
 	}
 	/*
@@ -491,28 +480,25 @@
 		if (RtaType == TYPE_RTA16) {
 			if (RIOFindFreeID(p, HostP, &ThisUnit, &ThisUnit2) == 0) {
 				RIODefaultName(p, HostP, ThisUnit);
-				FillSlot(ThisUnit, ThisUnit2, RtaUniq, HostP);
+				rio_fill_host_slot(ThisUnit, ThisUnit2, RtaUniq, HostP);
 			}
 		} else {
 			if (RIOFindFreeID(p, HostP, &ThisUnit, NULL) == 0) {
 				RIODefaultName(p, HostP, ThisUnit);
-				FillSlot(ThisUnit, 0, RtaUniq, HostP);
+				rio_fill_host_slot(ThisUnit, 0, RtaUniq, HostP);
 			}
 		}
 		PktReplyP->Command = ROUTE_USED;
 		HostP->Copy("RT_USED", PktReplyP->CommandText, 7);
 	}
 	RIOQueueCmdBlk(HostP, Rup, CmdBlkP);
-	return TRUE;
+	return 1;
 }
 
 
-void RIOFixPhbs(p, HostP, unit)
-struct rio_info *p;
-struct Host *HostP;
-uint unit;
+void RIOFixPhbs(struct rio_info *p, struct Host *HostP, unsigned int unit)
 {
-	ushort link, port;
+	unsigned short link, port;
 	struct Port *PortP;
 	unsigned long flags;
 	int PortN = HostP->Mapping[unit].SysPort;
@@ -520,7 +506,7 @@
 	rio_dprintk(RIO_DEBUG_ROUTE, "RIOFixPhbs unit %d sysport %d\n", unit, PortN);
 
 	if (PortN != -1) {
-		ushort dest_unit = HostP->Mapping[unit].ID2;
+		unsigned short dest_unit = HostP->Mapping[unit].ID2;
 
 		/*
 		 ** Get the link number used for the 1st 8 phbs on this unit.
@@ -530,9 +516,9 @@
 		link = readw(&PortP->PhbP->link);
 
 		for (port = 0; port < PORTS_PER_RTA; port++, PortN++) {
-			ushort dest_port = port + 8;
-			WORD *TxPktP;
-			PKT *Pkt;
+			unsigned short dest_port = port + 8;
+			u16 *TxPktP;
+			struct PKT *Pkt;
 
 			PortP = p->RIOPortp[PortN];
 
@@ -569,12 +555,12 @@
 				 ** card. This needs to be translated into a 32 bit pointer
 				 ** so it can be accessed from the driver.
 				 */
-				Pkt = (PKT *) RIO_PTR(HostP->Caddr, readw(TxPktP));
+				Pkt = (struct PKT *) RIO_PTR(HostP->Caddr, readw(TxPktP));
 
 				/*
 				 ** If the packet is used, reset it.
 				 */
-				Pkt = (PKT *) ((unsigned long) Pkt & ~PKT_IN_USE);
+				Pkt = (struct PKT *) ((unsigned long) Pkt & ~PKT_IN_USE);
 				writeb(dest_unit, &Pkt->dest_unit);
 				writeb(dest_port, &Pkt->dest_port);
 			}
@@ -603,10 +589,7 @@
 ** the world about it. This is done to ensure that the configurator
 ** only gets up-to-date information about what is going on.
 */
-static int RIOCheckIsolated(p, HostP, UnitId)
-struct rio_info *p;
-struct Host *HostP;
-uint UnitId;
+static int RIOCheckIsolated(struct rio_info *p, struct Host *HostP, unsigned int UnitId)
 {
 	unsigned long flags;
 	rio_spin_lock_irqsave(&HostP->HostLock, flags);
@@ -628,12 +611,9 @@
 ** all the units attached to it. This will mean that the entire
 ** subnet will re-introduce itself.
 */
-static int RIOIsolate(p, HostP, UnitId)
-struct rio_info *p;
-struct Host *HostP;
-uint UnitId;
+static int RIOIsolate(struct rio_info *p, struct Host *HostP, unsigned int UnitId)
 {
-	uint link, unit;
+	unsigned int link, unit;
 
 	UnitId--;		/* this trick relies on the Unit Id being UNSIGNED! */
 
@@ -658,9 +638,7 @@
 	return 1;
 }
 
-static int RIOCheck(HostP, UnitId)
-struct Host *HostP;
-uint UnitId;
+static int RIOCheck(struct Host *HostP, unsigned int UnitId)
 {
 	unsigned char link;
 
@@ -714,8 +692,7 @@
 ** Returns the type of unit (host, 16/8 port RTA)
 */
 
-uint GetUnitType(Uniq)
-uint Uniq;
+unsigned int GetUnitType(unsigned int Uniq)
 {
 	switch ((Uniq >> 28) & 0xf) {
 	case RIO_AT:
@@ -736,8 +713,7 @@
 	}
 }
 
-int RIOSetChange(p)
-struct rio_info *p;
+int RIOSetChange(struct rio_info *p)
 {
 	if (p->RIOQuickCheck != NOT_CHANGED)
 		return (0);
@@ -751,14 +727,13 @@
 	return (0);
 }
 
-static void RIOConCon(p, HostP, FromId, FromLink, ToId, ToLink, Change)
-struct rio_info *p;
-struct Host *HostP;
-uint FromId;
-uint FromLink;
-uint ToId;
-uint ToLink;
-int Change;
+static void RIOConCon(struct rio_info *p,
+		      struct Host *HostP, 
+		      unsigned int FromId,
+		      unsigned int FromLink,
+		      unsigned int ToId,
+		      unsigned int ToLink,
+		      int Change)
 {
 	char *FromName;
 	char *FromType;
@@ -912,7 +887,8 @@
 ** This function scans the given host table for either one
 ** or two free unit ID's.
 */
-int RIOFindFreeID(struct rio_info *p, struct Host *HostP, uint * pID1, uint * pID2)
+
+int RIOFindFreeID(struct rio_info *p, struct Host *HostP, unsigned int * pID1, unsigned int * pID2)
 {
 	int unit, tempID;
 
diff -u --new-file --recursive --exclude-from /usr/src/exclude linux.vanilla-2.6.16-rc6-mm2/drivers/char/rio/riotable.c linux-2.6.16-rc6-mm2/drivers/char/rio/riotable.c
--- linux.vanilla-2.6.16-rc6-mm2/drivers/char/rio/riotable.c	2006-03-19 18:20:51.339018744 +0000
+++ linux-2.6.16-rc6-mm2/drivers/char/rio/riotable.c	2006-03-16 00:05:36.000000000 +0000
@@ -53,15 +53,12 @@
 
 #include "linux_compat.h"
 #include "rio_linux.h"
-#include "typdef.h"
 #include "pkt.h"
 #include "daemon.h"
 #include "rio.h"
 #include "riospace.h"
-#include "top.h"
 #include "cmdpkt.h"
 #include "map.h"
-#include "riotypes.h"
 #include "rup.h"
 #include "port.h"
 #include "riodrvr.h"
@@ -74,17 +71,13 @@
 #include "unixrup.h"
 #include "board.h"
 #include "host.h"
-#include "error.h"
 #include "phb.h"
 #include "link.h"
 #include "cmdblk.h"
 #include "route.h"
-#include "control.h"
 #include "cirrus.h"
 #include "rioioctl.h"
 #include "param.h"
-#include "list.h"
-#include "sam.h"
 #include "protsts.h"
 
 /*
@@ -136,7 +129,7 @@
 			cptr = MapP->Name;	/* (2) */
 			cptr[MAX_NAME_LEN - 1] = '\0';
 			if (cptr[0] == '\0') {
-				bcopy(MapP->RtaUniqueNum ? "RTA	NN" : "HOST NN", MapP->Name, 8);
+				memcpy(MapP->Name, MapP->RtaUniqueNum ? "RTA	NN" : "HOST NN", 8);
 				MapP->Name[5] = '0' + Entry / 10;
 				MapP->Name[6] = '0' + Entry % 10;
 			}
@@ -325,7 +318,7 @@
 		 */
 		if (MapP->ID == 0) {
 			rio_dprintk(RIO_DEBUG_TABLE, "Host entry found. Name %s\n", MapP->Name);
-			bcopy(MapP->Name, HostP->Name, MAX_NAME_LEN);
+			memcpy(HostP->Name, MapP->Name, MAX_NAME_LEN);
 			continue;
 		}
 
@@ -369,7 +362,7 @@
 			}
 		}
 		if (!p->RIOHosts[Host].Name[0]) {
-			bcopy("HOST 1", p->RIOHosts[Host].Name, 7);
+			memcpy(p->RIOHosts[Host].Name, "HOST 1", 7);
 			p->RIOHosts[Host].Name[5] += Host;
 		}
 		/*
@@ -397,7 +390,7 @@
 		 */
 		if (Host1 != Host) {
 			rio_dprintk(RIO_DEBUG_TABLE, "Default name %s already used\n", p->RIOHosts[Host].Name);
-			bcopy("HOST 1", p->RIOHosts[Host].Name, 7);
+			memcpy(p->RIOHosts[Host].Name, "HOST 1", 7);
 			p->RIOHosts[Host].Name[5] += Host1;
 		}
 		rio_dprintk(RIO_DEBUG_TABLE, "Assigning default name %s\n", p->RIOHosts[Host].Name);
@@ -429,7 +422,7 @@
 		rio_dprintk(RIO_DEBUG_TABLE, "Processing host %d\n", Host);
 		HostP = &p->RIOHosts[Host];
 		rio_spin_lock_irqsave(&HostP->HostLock, flags);
-
+		
 		MapP = &p->RIOConnectTable[Next++];
 		MapP->HostUniqueNum = HostP->UniqueNum;
 		if ((HostP->Flags & RUN_STATE) != RC_RUNNING)
@@ -440,7 +433,7 @@
 		MapP->SysPort = NO_PORT;
 		for (link = 0; link < LINKS_PER_UNIT; link++)
 			MapP->Topology[link] = HostP->Topology[link];
-		bcopy(HostP->Name, MapP->Name, MAX_NAME_LEN);
+		memcpy(MapP->Name, HostP->Name, MAX_NAME_LEN);
 		for (Rup = 0; Rup < MAX_RUP; Rup++) {
 			if (HostP->Mapping[Rup].Flags & (SLOT_IN_USE | SLOT_TENTATIVE)) {
 				p->RIOConnectTable[Next] = HostP->Mapping[Rup];
@@ -539,10 +532,10 @@
 						 ** the phb to port mappings in RIORouteRup.
 						 */
 						if (PortP->SecondBlock) {
-							ushort dest_unit = HostMapP->ID;
-							ushort dest_port = port - SysPort;
+							u16 dest_unit = HostMapP->ID;
+							u16 dest_port = port - SysPort;
 							u16 *TxPktP;
-							PKT *Pkt;
+							struct PKT *Pkt;
 
 							for (TxPktP = PortP->TxStart; TxPktP <= PortP->TxEnd; TxPktP++) {
 								/*
@@ -552,7 +545,7 @@
 								 ** a 32 bit pointer so it can be
 								 ** accessed from the driver.
 								 */
-								Pkt = (PKT *) RIO_PTR(HostP->Caddr, readw(&*TxPktP));
+								Pkt = (struct PKT *) RIO_PTR(HostP->Caddr, readw(&*TxPktP));
 								rio_dprintk(RIO_DEBUG_TABLE, "Tx packet (%x) destination: Old %x:%x New %x:%x\n", *TxPktP, Pkt->dest_unit, Pkt->dest_port, dest_unit, dest_port);
 								writew(dest_unit, &Pkt->dest_unit);
 								writew(dest_port, &Pkt->dest_port);
@@ -600,7 +593,7 @@
 
 	rio_dprintk(RIO_DEBUG_TABLE, "Assign entry on host %x, rta %x, ID %d, Sysport %d\n", MapP->HostUniqueNum, MapP->RtaUniqueNum, MapP->ID, (int) MapP->SysPort);
 
-	if ((MapP->ID != (ushort) - 1) && ((int) MapP->ID < (int) 1 || (int) MapP->ID > MAX_RUP)) {
+	if ((MapP->ID != (u16) - 1) && ((int) MapP->ID < (int) 1 || (int) MapP->ID > MAX_RUP)) {
 		rio_dprintk(RIO_DEBUG_TABLE, "Bad ID in map entry!\n");
 		p->RIOError.Error = ID_NUMBER_OUT_OF_RANGE;
 		return -EINVAL;
@@ -646,7 +639,7 @@
 			 ** Now we have a host we need to allocate an ID
 			 ** if the entry does not already have one.
 			 */
-			if (MapP->ID == (ushort) - 1) {
+			if (MapP->ID == (u16) - 1) {
 				int nNewID;
 
 				rio_dprintk(RIO_DEBUG_TABLE, "Attempting to get a new ID for rta \"%s\"\n", MapP->Name);
@@ -665,7 +658,7 @@
 					p->RIOError.Error = COULDNT_FIND_ENTRY;
 					return -EBUSY;
 				}
-				MapP->ID = (ushort) nNewID + 1;
+				MapP->ID = (u16) nNewID + 1;
 				rio_dprintk(RIO_DEBUG_TABLE, "Allocated ID %d for this new RTA.\n", MapP->ID);
 				HostMapP = &p->RIOHosts[host].Mapping[nNewID];
 				HostMapP->RtaUniqueNum = MapP->RtaUniqueNum;
@@ -706,7 +699,7 @@
 			 */
 			HostMapP->SysPort = MapP->SysPort;
 			if ((MapP->Flags & RTA16_SECOND_SLOT) == 0)
-				CCOPY(MapP->Name, HostMapP->Name, MAX_NAME_LEN);
+				memcpy(HostMapP->Name, MapP->Name, MAX_NAME_LEN);
 			HostMapP->Flags = SLOT_IN_USE | RTA_BOOTED;
 #ifdef NEED_TO_FIX
 			RIO_SV_BROADCAST(p->RIOHosts[host].svFlags[MapP->ID - 1]);
@@ -743,10 +736,10 @@
 int RIOReMapPorts(struct rio_info *p, struct Host *HostP, struct Map *HostMapP)
 {
 	struct Port *PortP;
-	uint SubEnt;
-	uint HostPort;
-	uint SysPort;
-	ushort RtaType;
+	unsigned int SubEnt;
+	unsigned int HostPort;
+	unsigned int SysPort;
+	u16 RtaType;
 	unsigned long flags;
 
 	rio_dprintk(RIO_DEBUG_TABLE, "Mapping sysport %d to id %d\n", (int) HostMapP->SysPort, HostMapP->ID);
@@ -808,10 +801,10 @@
 		PortP->RupNum = HostMapP->ID - 1;
 		if (HostMapP->Flags & RTA16_SECOND_SLOT) {
 			PortP->ID2 = HostMapP->ID2 - 1;
-			PortP->SecondBlock = TRUE;
+			PortP->SecondBlock = 1;
 		} else {
 			PortP->ID2 = 0;
-			PortP->SecondBlock = FALSE;
+			PortP->SecondBlock = 0;
 		}
 		PortP->RtaUniqueNum = HostMapP->RtaUniqueNum;
 
@@ -931,7 +924,7 @@
 				return -ENXIO;
 			}
 			if (MapP->ID == 0) {
-				CCOPY(MapP->Name, p->RIOHosts[host].Name, MAX_NAME_LEN);
+				memcpy(p->RIOHosts[host].Name, MapP->Name, MAX_NAME_LEN);
 				return 0;
 			}
 
@@ -941,7 +934,7 @@
 				p->RIOError.Error = RTA_NUMBER_WRONG;
 				return -ENXIO;
 			}
-			CCOPY(MapP->Name, HostMapP->Name, MAX_NAME_LEN);
+			memcpy(HostMapP->Name, MapP->Name, MAX_NAME_LEN);
 			return 0;
 		}
 	}
diff -u --new-file --recursive --exclude-from /usr/src/exclude linux.vanilla-2.6.16-rc6-mm2/drivers/char/rio/riotty.c linux-2.6.16-rc6-mm2/drivers/char/rio/riotty.c
--- linux.vanilla-2.6.16-rc6-mm2/drivers/char/rio/riotty.c	2006-03-19 18:20:51.340018592 +0000
+++ linux-2.6.16-rc6-mm2/drivers/char/rio/riotty.c	2006-03-16 13:09:26.000000000 +0000
@@ -56,15 +56,12 @@
 
 #include "linux_compat.h"
 #include "rio_linux.h"
-#include "typdef.h"
 #include "pkt.h"
 #include "daemon.h"
 #include "rio.h"
 #include "riospace.h"
-#include "top.h"
 #include "cmdpkt.h"
 #include "map.h"
-#include "riotypes.h"
 #include "rup.h"
 #include "port.h"
 #include "riodrvr.h"
@@ -77,58 +74,18 @@
 #include "unixrup.h"
 #include "board.h"
 #include "host.h"
-#include "error.h"
 #include "phb.h"
 #include "link.h"
 #include "cmdblk.h"
 #include "route.h"
-#include "control.h"
 #include "cirrus.h"
 #include "rioioctl.h"
 #include "param.h"
-#include "list.h"
-#include "sam.h"
 
 static void RIOClearUp(struct Port *PortP);
-int RIOShortCommand(struct rio_info *p, struct Port *PortP, int command, int len, int arg);
-
 
-extern int conv_vb[];		/* now defined in ttymgr.c */
-extern int conv_bv[];		/* now defined in ttymgr.c */
-
-/*
-** 16.09.1998 ARG - Fix to build riotty.k.o for Modular Kernel Support
-**
-** ep.def.h is necessary for Modular Kernel Support
-** DO NOT place any kernel 'extern's after this line
-** or this source file will not build riotty.k.o
-*/
-#ifdef uLYNX
-#include <ep.def.h>
-#endif
-
-#ifdef NEED_THIS2
-static struct old_sgttyb default_sg = {
-	B19200, B19200,		/* input and output speed */
-	'H' - '@',		/* erase char */
-	-1,			/* 2nd erase char */
-	'U' - '@',		/* kill char */
-	ECHO | CRMOD,		/* mode */
-	'C' - '@',		/* interrupt character */
-	'\\' - '@',		/* quit char */
-	'Q' - '@',		/* start char */
-	'S' - '@',		/* stop char */
-	'D' - '@',		/* EOF */
-	-1,			/* brk */
-	(LCRTBS | LCRTERA | LCRTKIL | LCTLECH),	/* local mode word */
-	'Z' - '@',		/* process stop */
-	'Y' - '@',		/* delayed stop */
-	'R' - '@',		/* reprint line */
-	'O' - '@',		/* flush output */
-	'W' - '@',		/* word erase */
-	'V' - '@'		/* literal next char */
-};
-#endif
+/* Below belongs in func.h */
+int RIOShortCommand(struct rio_info *p, struct Port *PortP, int command, int len, int arg);
 
 
 extern struct rio_info *p;
@@ -137,7 +94,6 @@
 int riotopen(struct tty_struct *tty, struct file *filp)
 {
 	unsigned int SysPort;
-	int Modem;
 	int repeat_this = 250;
 	struct Port *PortP;	/* pointer to the port structure */
 	unsigned long flags;
@@ -151,7 +107,6 @@
 	tty->driver_data = NULL;
 
 	SysPort = rio_minor(tty);
-	Modem = rio_ismodem(tty);
 
 	if (p->RIOFailed) {
 		rio_dprintk(RIO_DEBUG_TTY, "System initialisation failed\n");
@@ -159,7 +114,7 @@
 		return -ENXIO;
 	}
 
-	rio_dprintk(RIO_DEBUG_TTY, "port open SysPort %d (%s) (mapped:%d)\n", SysPort, Modem ? "Modem" : "tty", p->RIOPortp[SysPort]->Mapped);
+	rio_dprintk(RIO_DEBUG_TTY, "port open SysPort %d (mapped:%d)\n", SysPort, p->RIOPortp[SysPort]->Mapped);
 
 	/*
 	 ** Validate that we have received a legitimate request.
@@ -305,15 +260,12 @@
 		/* PortP->gs.xmit_cnt = 0; */
 
 		rio_spin_unlock_irqrestore(&PortP->portSem, flags);
-#ifdef NEED_THIS
-		ttyseth(PortP, tp, (struct old_sgttyb *) &default_sg);
-#endif
 
 		/* Someone explain to me why this delay/config is
 		   here. If I read the docs correctly the "open"
 		   command piggybacks the parameters immediately.
 		   -- REW */
-		RIOParam(PortP, OPEN, Modem, OK_TO_SLEEP);	/* Open the port */
+		RIOParam(PortP, OPEN, 1, OK_TO_SLEEP);	/* Open the port */
 		rio_spin_lock_irqsave(&PortP->portSem, flags);
 
 		/*
@@ -321,20 +273,6 @@
 		 */
 		while (!(PortP->PortState & PORT_ISOPEN) && !p->RIOHalted) {
 			rio_dprintk(RIO_DEBUG_TTY, "Waiting for PORT_ISOPEN-currently %x\n", PortP->PortState);
-/*
-** 15.10.1998 ARG - ESIL 0759
-** (Part) fix for port being trashed when opened whilst RTA "disconnected"
-** Take out the limited wait - now wait for ever or until user
-** bangs us out.
-**
-			if (repeat_this -- <= 0) {
-				rio_dprint(RIO_DEBUG_TTY, ("Waiting for open to finish timed out.\n"));
-				RIOPreemptiveCmd(p, PortP, FCLOSE ); 
-				rio_spin_unlock_irqrestore(&PortP->portSem, flags);
-				return -EINTR;
-			}
-**
-*/
 			rio_spin_unlock_irqrestore(&PortP->portSem, flags);
 			if (RIODelay(PortP, HUNDRED_MS) == RIO_FAIL) {
 				rio_dprintk(RIO_DEBUG_TTY, "Waiting for open to finish broken by signal\n");
@@ -354,74 +292,58 @@
 		}
 		rio_dprintk(RIO_DEBUG_TTY, "PORT_ISOPEN found\n");
 	}
-#ifdef MODEM_SUPPORT
-	if (Modem) {
-		rio_dprintk(RIO_DEBUG_TTY, "Modem - test for carrier\n");
+	rio_dprintk(RIO_DEBUG_TTY, "Modem - test for carrier\n");
+	/*
+	 ** ACTION
+	 ** insert test for carrier here. -- ???
+	 ** I already see that test here. What's the deal? -- REW
+	 */
+	if ((PortP->gs.tty->termios->c_cflag & CLOCAL) || (PortP->ModemState & MSVR1_CD)) {
+		rio_dprintk(RIO_DEBUG_TTY, "open(%d) Modem carr on\n", SysPort);
 		/*
-		 ** ACTION
-		 ** insert test for carrier here. -- ???
-		 ** I already see that test here. What's the deal? -- REW
+		   tp->tm.c_state |= CARR_ON;
+		   wakeup((caddr_t) &tp->tm.c_canq);
 		 */
-		if ((PortP->gs.tty->termios->c_cflag & CLOCAL) || (PortP->ModemState & MSVR1_CD)) {
-			rio_dprintk(RIO_DEBUG_TTY, "open(%d) Modem carr on\n", SysPort);
+		PortP->State |= RIO_CARR_ON;
+		wake_up_interruptible(&PortP->gs.open_wait);
+	} else {	/* no carrier - wait for DCD */
 			/*
-			   tp->tm.c_state |= CARR_ON;
-			   wakeup((caddr_t) &tp->tm.c_canq);
-			 */
-			PortP->State |= RIO_CARR_ON;
-			wake_up_interruptible(&PortP->gs.open_wait);
-		} else {	/* no carrier - wait for DCD */
-
+		   while (!(PortP->gs.tty->termios->c_state & CARR_ON) &&
+		   !(filp->f_flags & O_NONBLOCK) && !p->RIOHalted )
+		 */
+		while (!(PortP->State & RIO_CARR_ON) && !(filp->f_flags & O_NONBLOCK) && !p->RIOHalted) {
+				rio_dprintk(RIO_DEBUG_TTY, "open(%d) sleeping for carr on\n", SysPort);
 			/*
-			   while (!(PortP->gs.tty->termios->c_state & CARR_ON) &&
-			   !(filp->f_flags & O_NONBLOCK) && !p->RIOHalted )
+			   PortP->gs.tty->termios->c_state |= WOPEN;
 			 */
-			while (!(PortP->State & RIO_CARR_ON) && !(filp->f_flags & O_NONBLOCK) && !p->RIOHalted) {
-
-				rio_dprintk(RIO_DEBUG_TTY, "open(%d) sleeping for carr on\n", SysPort);
+			PortP->State |= RIO_WOPEN;
+			rio_spin_unlock_irqrestore(&PortP->portSem, flags);
+			if (RIODelay(PortP, HUNDRED_MS) == RIO_FAIL) {
+				/*
+				 ** ACTION: verify that this is a good thing
+				 ** to do here. -- ???
+				 ** I think it's OK. -- REW
+				 */
+				rio_dprintk(RIO_DEBUG_TTY, "open(%d) sleeping for carr broken by signal\n", SysPort);
+				RIOPreemptiveCmd(p, PortP, FCLOSE);
 				/*
-				   PortP->gs.tty->termios->c_state |= WOPEN;
+				   tp->tm.c_state &= ~WOPEN;
 				 */
-				PortP->State |= RIO_WOPEN;
+				PortP->State &= ~RIO_WOPEN;
 				rio_spin_unlock_irqrestore(&PortP->portSem, flags);
-				if (RIODelay(PortP, HUNDRED_MS) == RIO_FAIL)
-					{
-						/*
-						 ** ACTION: verify that this is a good thing
-						 ** to do here. -- ???
-						 ** I think it's OK. -- REW
-						 */
-						rio_dprintk(RIO_DEBUG_TTY, "open(%d) sleeping for carr broken by signal\n", SysPort);
-						RIOPreemptiveCmd(p, PortP, FCLOSE);
-						/*
-						   tp->tm.c_state &= ~WOPEN;
-						 */
-						PortP->State &= ~RIO_WOPEN;
-						rio_spin_unlock_irqrestore(&PortP->portSem, flags);
-						func_exit();
-						return -EINTR;
-					}
+				func_exit();
+				return -EINTR;
 			}
-			PortP->State &= ~RIO_WOPEN;
 		}
-		if (p->RIOHalted)
-			goto bombout;
-		rio_dprintk(RIO_DEBUG_TTY, "Setting RIO_MOPEN\n");
-		PortP->State |= RIO_MOPEN;
-	} else
-#endif
-	{
-		/*
-		 ** ACTION
-		 ** Direct line open - force carrier (will probably mean
-		 ** that sleeping Modem line fubar)
-		 */
-		PortP->State |= RIO_LOPEN;
+		PortP->State &= ~RIO_WOPEN;
 	}
+	if (p->RIOHalted)
+		goto bombout;
+	rio_dprintk(RIO_DEBUG_TTY, "Setting RIO_MOPEN\n");
+	PortP->State |= RIO_MOPEN;
 
-	if (p->RIOHalted) {
+	if (p->RIOHalted)
 		goto bombout;
-	}
 
 	rio_dprintk(RIO_DEBUG_TTY, "high level open done\n");
 
@@ -453,23 +375,21 @@
 	unsigned long end_time;
 	struct tty_struct *tty;
 	unsigned long flags;
-	int Modem;
 	int rv = 0;
 
 	rio_dprintk(RIO_DEBUG_TTY, "port close SysPort %d\n", PortP->PortNum);
 
 	/* PortP = p->RIOPortp[SysPort]; */
-	rio_dprintk(RIO_DEBUG_TTY, "Port is at address 0x%p\n", PortP);
+	rio_dprintk(RIO_DEBUG_TTY, "Port is at address %p\n", PortP);
 	/* tp = PortP->TtyP; *//* Get tty */
 	tty = PortP->gs.tty;
-	rio_dprintk(RIO_DEBUG_TTY, "TTY is at address 0x%p\n", tty);
+	rio_dprintk(RIO_DEBUG_TTY, "TTY is at address %p\n", tty);
 
 	if (PortP->gs.closing_wait)
 		end_time = jiffies + PortP->gs.closing_wait;
 	else
 		end_time = jiffies + MAX_SCHEDULE_TIMEOUT;
 
-	Modem = rio_ismodem(tty);
 	rio_spin_lock_irqsave(&PortP->portSem, flags);
 
 	/*
@@ -493,7 +413,7 @@
 	/*
 	 ** clear the open bits for this device
 	 */
-	PortP->State &= (Modem ? ~RIO_MOPEN : ~RIO_LOPEN);
+	PortP->State &= ~RIO_MOPEN;
 	PortP->State &= ~RIO_CARR_ON;
 	PortP->ModemState &= ~MSVR1_CD;
 	/*
@@ -613,7 +533,7 @@
 	if (PortP->statsGather)
 		PortP->closes++;
 
-      close_end:
+close_end:
 	/* XXX: Why would a "DELETED" flag be reset here? I'd have
 	   thought that a "deleted" flag means that the port was
 	   permanently gone, but here we can make it reappear by it
@@ -629,8 +549,7 @@
 
 
 
-static void RIOClearUp(PortP)
-struct Port *PortP;
+static void RIOClearUp(struct Port *PortP)
 {
 	rio_dprintk(RIO_DEBUG_TTY, "RIOHalted set\n");
 	PortP->Config = 0;	/* Direct semaphore */
@@ -657,7 +576,7 @@
 */
 int RIOShortCommand(struct rio_info *p, struct Port *PortP, int command, int len, int arg)
 {
-	PKT *PacketP;
+	struct PKT *PacketP;
 	int retries = 20;	/* at 10 per second -> 2 seconds */
 	unsigned long flags;
 
diff -u --new-file --recursive --exclude-from /usr/src/exclude linux.vanilla-2.6.16-rc6-mm2/drivers/char/rio/riotypes.h linux-2.6.16-rc6-mm2/drivers/char/rio/riotypes.h
--- linux.vanilla-2.6.16-rc6-mm2/drivers/char/rio/riotypes.h	2006-03-19 18:20:51.341018440 +0000
+++ linux-2.6.16-rc6-mm2/drivers/char/rio/riotypes.h	1970-01-01 01:00:00.000000000 +0100
@@ -1,64 +0,0 @@
-/****************************************************************************
- *******                                                              *******
- *******                      R I O T Y P E S
- *******                                                              *******
- ****************************************************************************
-
- Author  : Jon Brawn
- Date    :
-
- *
- *  (C) 1990 - 2000 Specialix International Ltd., Byfleet, Surrey, UK.
- *
- *      This program is free software; you can redistribute it and/or modify
- *      it under the terms of the GNU General Public License as published by
- *      the Free Software Foundation; either version 2 of the License, or
- *      (at your option) any later version.
- *
- *      This program is distributed in the hope that it will be useful,
- *      but WITHOUT ANY WARRANTY; without even the implied warranty of
- *      MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
- *      GNU General Public License for more details.
- *
- *      You should have received a copy of the GNU General Public License
- *      along with this program; if not, write to the Free Software
- *      Foundation, Inc., 675 Mass Ave, Cambridge, MA 02139, USA.
-
- Version : 0.01
-
-
-                            Mods
- ----------------------------------------------------------------------------
-  Date     By                Description
- ----------------------------------------------------------------------------
-
- ***************************************************************************/
-
-#ifndef _riotypes_h
-#define _riotypes_h 1
-
-#ifdef SCCS_LABELS
-#ifndef lint
-/* static char *_rio_riotypes_h_sccs = "@(#)riotypes.h	1.10"; */
-#endif
-#endif
-
-typedef u16 char_ptr;
-typedef u16 Channel_ptr;
-typedef u16 FREE_LIST_ptr_ptr;
-typedef u16 FREE_LIST_ptr;
-typedef u16 LPB_ptr;
-typedef u16 Process_ptr;
-typedef u16 PHB_ptr;
-typedef u16 PKT_ptr;
-typedef u16 Q_BUF_ptr;
-typedef u16 Q_BUF_ptr_ptr;
-typedef u16 ROUTE_STR_ptr;
-typedef u16 RUP_ptr;
-typedef u16 short_ptr;
-typedef u16 u_short_ptr;
-typedef u16 ushort_ptr;
-
-#endif				/* __riotypes__ */
-
-/*********** end of file ***********/
diff -u --new-file --recursive --exclude-from /usr/src/exclude linux.vanilla-2.6.16-rc6-mm2/drivers/char/rio/rom.h linux-2.6.16-rc6-mm2/drivers/char/rio/rom.h
--- linux.vanilla-2.6.16-rc6-mm2/drivers/char/rio/rom.h	2006-03-19 18:19:27.383781880 +0000
+++ linux-2.6.16-rc6-mm2/drivers/char/rio/rom.h	1970-01-01 01:00:00.000000000 +0100
@@ -1,62 +0,0 @@
-/****************************************************************************
- *******                                                              *******
- *******                      R O M
- *******                                                              *******
- ****************************************************************************
-
- Author  : Ian Nandhra
- Date    :
-
- *
- *  (C) 1990 - 2000 Specialix International Ltd., Byfleet, Surrey, UK.
- *
- *      This program is free software; you can redistribute it and/or modify
- *      it under the terms of the GNU General Public License as published by
- *      the Free Software Foundation; either version 2 of the License, or
- *      (at your option) any later version.
- *
- *      This program is distributed in the hope that it will be useful,
- *      but WITHOUT ANY WARRANTY; without even the implied warranty of
- *      MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
- *      GNU General Public License for more details.
- *
- *      You should have received a copy of the GNU General Public License
- *      along with this program; if not, write to the Free Software
- *      Foundation, Inc., 675 Mass Ave, Cambridge, MA 02139, USA.
-
- Version : 0.01
-
-
-                            Mods
- ----------------------------------------------------------------------------
-  Date     By                Description
- ----------------------------------------------------------------------------
-
- ***************************************************************************/
-
-#ifndef _rom_h
-#define _rom_h 1
-
-#ifndef lint
-#ifdef SCCS
-static char *_rio_rom_h_sccs = "@(#)rom.h	1.1";
-#endif
-#endif
-
-typedef struct ROM ROM;
-struct ROM {
-	u_short slx;
-	char pcb_letter_rev;
-	char pcb_number_rev;
-	char serial[4];
-	char year;
-	char week;
-};
-
-#endif
-
-#define HOST_ROM    (ROM *) 0x7c00
-#define RTA_ROM	    (ROM *) 0x7801
-#define ROM_LENGTH  0x20
-
-/*********** end of file ***********/
diff -u --new-file --recursive --exclude-from /usr/src/exclude linux.vanilla-2.6.16-rc6-mm2/drivers/char/rio/sam.h linux-2.6.16-rc6-mm2/drivers/char/rio/sam.h
--- linux.vanilla-2.6.16-rc6-mm2/drivers/char/rio/sam.h	2006-03-19 18:19:27.384781728 +0000
+++ linux-2.6.16-rc6-mm2/drivers/char/rio/sam.h	1970-01-01 01:00:00.000000000 +0100
@@ -1,67 +0,0 @@
-/****************************************************************************
- *******                                                              *******
- *******                    S A M . H
- *******                                                              *******
- ****************************************************************************
-
- Author  : Ian Nandhra
- Date    :
-
- *
- *  (C) 1990 - 2000 Specialix International Ltd., Byfleet, Surrey, UK.
- *
- *      This program is free software; you can redistribute it and/or modify
- *      it under the terms of the GNU General Public License as published by
- *      the Free Software Foundation; either version 2 of the License, or
- *      (at your option) any later version.
- *
- *      This program is distributed in the hope that it will be useful,
- *      but WITHOUT ANY WARRANTY; without even the implied warranty of
- *      MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
- *      GNU General Public License for more details.
- *
- *      You should have received a copy of the GNU General Public License
- *      along with this program; if not, write to the Free Software
- *      Foundation, Inc., 675 Mass Ave, Cambridge, MA 02139, USA.
-
- Version : 0.01
-
-
-                            Mods
- ----------------------------------------------------------------------------
-  Date     By                Description
- ----------------------------------------------------------------------------
-
- ***************************************************************************/
-#ifndef _sam_h
-#define _sam_h 1
-
-#ifdef SCCS_LABELS
-#ifndef lint
-/* static char *_rio_sam_h_sccs = "@(#)sam.h	1.3"; */
-#endif
-#endif
-
-
-#define NUM_FREE_LIST_UNITS     500
-
-#ifndef FALSE
-#define FALSE (short)  0x00
-#endif
-#ifndef TRUE
-#define TRUE  (short)  !FALSE
-#endif
-
-#define TX    TRUE
-#define RX    FALSE
-
-
-typedef struct FREE_LIST FREE_LIST;
-struct FREE_LIST {
-	FREE_LIST_ptr next;
-	FREE_LIST_ptr prev;
-};
-
-
-#endif
-/*********** end of file ***********/
diff -u --new-file --recursive --exclude-from /usr/src/exclude linux.vanilla-2.6.16-rc6-mm2/drivers/char/rio/space.h linux-2.6.16-rc6-mm2/drivers/char/rio/space.h
--- linux.vanilla-2.6.16-rc6-mm2/drivers/char/rio/space.h	2006-03-19 18:19:27.385781576 +0000
+++ linux-2.6.16-rc6-mm2/drivers/char/rio/space.h	1970-01-01 01:00:00.000000000 +0100
@@ -1,45 +0,0 @@
-/*
-** -----------------------------------------------------------------------------
-**
-**  Perle Specialix driver for Linux
-**  Ported from existing RIO Driver for SCO sources.
- *
- *  (C) 1990 - 2000 Specialix International Ltd., Byfleet, Surrey, UK.
- *
- *      This program is free software; you can redistribute it and/or modify
- *      it under the terms of the GNU General Public License as published by
- *      the Free Software Foundation; either version 2 of the License, or
- *      (at your option) any later version.
- *
- *      This program is distributed in the hope that it will be useful,
- *      but WITHOUT ANY WARRANTY; without even the implied warranty of
- *      MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
- *      GNU General Public License for more details.
- *
- *      You should have received a copy of the GNU General Public License
- *      along with this program; if not, write to the Free Software
- *      Foundation, Inc., 675 Mass Ave, Cambridge, MA 02139, USA.
-**
-**	Module		: space.h
-**	SID		: 1.2
-**	Last Modified	: 11/6/98 11:34:19
-**	Retrieved	: 11/6/98 11:34:22
-**
-**  ident @(#)space.h	1.2
-**
-** -----------------------------------------------------------------------------
-*/
-
-#ifndef __rio_space_h__
-#define __rio_space_h__
-
-#ifdef SCCS_LABELS
-static char *_space_h_sccs_ = "@(#)space.h	1.2";
-#endif
-
-extern int rio_cntls;
-extern int rio_bases[];
-extern int rio_limits[];
-extern int rio_vects[];
-
-#endif				/* __rio_space_h__ */
diff -u --new-file --recursive --exclude-from /usr/src/exclude linux.vanilla-2.6.16-rc6-mm2/drivers/char/rio/top.h linux-2.6.16-rc6-mm2/drivers/char/rio/top.h
--- linux.vanilla-2.6.16-rc6-mm2/drivers/char/rio/top.h	2006-03-19 18:20:51.341018440 +0000
+++ linux-2.6.16-rc6-mm2/drivers/char/rio/top.h	1970-01-01 01:00:00.000000000 +0100
@@ -1,48 +0,0 @@
-/*
-** -----------------------------------------------------------------------------
-**
-**  Perle Specialix driver for Linux
-**  Ported from existing RIO Driver for SCO sources.
- *
- *  (C) 1990 - 2000 Specialix International Ltd., Byfleet, Surrey, UK.
- *
- *      This program is free software; you can redistribute it and/or modify
- *      it under the terms of the GNU General Public License as published by
- *      the Free Software Foundation; either version 2 of the License, or
- *      (at your option) any later version.
- *
- *      This program is distributed in the hope that it will be useful,
- *      but WITHOUT ANY WARRANTY; without even the implied warranty of
- *      MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
- *      GNU General Public License for more details.
- *
- *      You should have received a copy of the GNU General Public License
- *      along with this program; if not, write to the Free Software
- *      Foundation, Inc., 675 Mass Ave, Cambridge, MA 02139, USA.
-**
-**	Module		: top.h
-**	SID		: 1.2
-**	Last Modified	: 11/6/98 11:34:19
-**	Retrieved	: 11/6/98 11:34:22
-**
-**  ident @(#)top.h	1.2
-**
-** -----------------------------------------------------------------------------
-*/
-
-#ifndef __rio_top_h__
-#define __rio_top_h__
-
-#ifdef SCCS_LABELS
-static char *_top_h_sccs_ = "@(#)top.h	1.2";
-#endif
-
-/*
-** Topology information
-*/
-struct Top {
-	u8 Unit;
-	u8 Link;
-};
-
-#endif				/* __rio_top_h__ */
diff -u --new-file --recursive --exclude-from /usr/src/exclude linux.vanilla-2.6.16-rc6-mm2/drivers/char/rio/typdef.h linux-2.6.16-rc6-mm2/drivers/char/rio/typdef.h
--- linux.vanilla-2.6.16-rc6-mm2/drivers/char/rio/typdef.h	2006-03-19 18:20:51.342018288 +0000
+++ linux-2.6.16-rc6-mm2/drivers/char/rio/typdef.h	1970-01-01 01:00:00.000000000 +0100
@@ -1,74 +0,0 @@
-/*
-** -----------------------------------------------------------------------------
-**
-**  Perle Specialix driver for Linux
-**  Ported from existing RIO Driver for SCO sources.
- *
- *  (C) 1990 - 2000 Specialix International Ltd., Byfleet, Surrey, UK.
- *
- *      This program is free software; you can redistribute it and/or modify
- *      it under the terms of the GNU General Public License as published by
- *      the Free Software Foundation; either version 2 of the License, or
- *      (at your option) any later version.
- *
- *      This program is distributed in the hope that it will be useful,
- *      but WITHOUT ANY WARRANTY; without even the implied warranty of
- *      MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
- *      GNU General Public License for more details.
- *
- *      You should have received a copy of the GNU General Public License
- *      along with this program; if not, write to the Free Software
- *      Foundation, Inc., 675 Mass Ave, Cambridge, MA 02139, USA.
-**
-**	Module		: typdef.h
-**	SID		: 1.2
-**	Last Modified	: 11/6/98 11:34:20
-**	Retrieved	: 11/6/98 11:34:22
-**
-**  ident @(#)typdef.h	1.2
-**
-** -----------------------------------------------------------------------------
-*/
-
-#ifndef __rio_typdef_h__
-#define __rio_typdef_h__
-
-/*
-** IT IS REALLY, REALLY, IMPORTANT THAT BYTES ARE UNSIGNED!
-**
-** These types are ONLY to be used for refering to data structures
-** on the RIO Host card!
-*/
-typedef u8 BYTE;
-typedef u16 WORD;
-typedef u32 DWORD;
-typedef u16 RIOP;
-
-
-/*
-** 27.01.199 ARG - mods to compile 'newutils' on LyxnOS -
-** These #defines are for the benefit of the 'libfuncs' library
-** only. They are not necessarily correct type mappings and
-** are here only to make the source compile.
-*/
-/* typedef unsigned int	uint; */
-typedef unsigned long ulong_t;
-typedef unsigned short ushort_t;
-typedef unsigned char uchar_t;
-typedef unsigned char queue_t;
-typedef unsigned char mblk_t;
-typedef unsigned long paddr_t;
-
-#define	TPNULL	((ushort)(0x8000))
-
-
-/*
-** RIO structures defined in other include files.
-*/
-typedef struct PKT PKT;
-typedef struct LPB LPB;
-typedef struct RUP RUP;
-typedef struct Port Port;
-typedef struct DpRam DpRam;
-
-#endif				/* __rio_typdef_h__ */
diff -u --new-file --recursive --exclude-from /usr/src/exclude linux.vanilla-2.6.16-rc6-mm2/drivers/char/rio/unixrup.h linux-2.6.16-rc6-mm2/drivers/char/rio/unixrup.h
--- linux.vanilla-2.6.16-rc6-mm2/drivers/char/rio/unixrup.h	2006-03-19 18:19:27.386781424 +0000
+++ linux-2.6.16-rc6-mm2/drivers/char/rio/unixrup.h	2006-03-15 16:07:34.000000000 +0000
@@ -45,9 +45,9 @@
 	struct CmdBlk *CmdsWaitingP;	/* Commands waiting to be done */
 	struct CmdBlk *CmdPendingP;	/* The command currently being sent */
 	struct RUP *RupP;	/* the Rup to send it to */
-	uint Id;		/* Id number */
-	uint BaseSysPort;	/* SysPort of first tty on this RTA */
-	uint ModTypes;		/* Modules on this RTA */
+	unsigned int Id;		/* Id number */
+	unsigned int BaseSysPort;	/* SysPort of first tty on this RTA */
+	unsigned int ModTypes;		/* Modules on this RTA */
 	spinlock_t RupLock;	/* Lock structure for MPX */
 	/*    struct lockb     RupLock;	*//* Lock structure for MPX */
 };

