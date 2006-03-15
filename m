Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751047AbWCOMVg@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751047AbWCOMVg (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 15 Mar 2006 07:21:36 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751392AbWCOMVg
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 15 Mar 2006 07:21:36 -0500
Received: from outpipe-village-512-1.bc.nu ([81.2.110.250]:9192 "EHLO
	lxorguk.ukuu.org.uk") by vger.kernel.org with ESMTP
	id S1751047AbWCOMVf (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 15 Mar 2006 07:21:35 -0500
Subject: PATCH: rio driver rework continued  #2
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
To: linux-kernel@vger.kernel.org, akpm@osdl.org
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Date: Wed, 15 Mar 2006 12:27:36 +0000
Message-Id: <1142425657.5597.13.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Evolution 2.2.3 (2.2.3-2.fc4) 
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

First large chunk of code cleanup. The split between this and #3 and #4
is fairly arbitary and due to the message length limit on the list.
These patches continue the process of ripping out macros and typedefs
while cleaning up lots of 32bit assumptions. Several inlines for
compatibility also get removed and that causes a lot of noise.

Signed-off-by: Alan Cox <alan@redhat.com>

diff -u --new-file --recursive --exclude-from /usr/src/exclude linux.vanilla-2.6.16-rc6-mm1/drivers/char/rio/rioparam.c linux-2.6.16-rc6-mm1/drivers/char/rio/rioparam.c
--- linux.vanilla-2.6.16-rc6-mm1/drivers/char/rio/rioparam.c	2006-03-14 12:59:37.000000000 +0000
+++ linux-2.6.16-rc6-mm1/drivers/char/rio/rioparam.c	2006-03-14 21:51:55.000000000 +0000
@@ -157,20 +157,16 @@
 ** NB. for MPX
 **	tty lock must NOT have been previously acquired.
 */
-int RIOParam(PortP, cmd, Modem, SleepFlag)
-struct Port *PortP;
-int cmd;
-int Modem;
-int SleepFlag;
+int RIOParam(struct Port *PortP, int cmd, int Modem, int SleepFlag)
 {
-	register struct tty_struct *TtyP;
+	struct tty_struct *TtyP;
 	int retval;
-	register struct phb_param *phb_param_ptr;
+	struct phb_param *phb_param_ptr;
 	PKT *PacketP;
 	int res;
-	uchar Cor1 = 0, Cor2 = 0, Cor4 = 0, Cor5 = 0;
-	uchar TxXon = 0, TxXoff = 0, RxXon = 0, RxXoff = 0;
-	uchar LNext = 0, TxBaud = 0, RxBaud = 0;
+	u8 Cor1 = 0, Cor2 = 0, Cor4 = 0, Cor5 = 0;
+	u8 TxXon = 0, TxXoff = 0, RxXon = 0, RxXoff = 0;
+	u8 LNext = 0, TxBaud = 0, RxBaud = 0;
 	int retries = 0xff;
 	unsigned long flags;
 
@@ -226,15 +222,12 @@
 		if (retval == RIO_FAIL) {
 			rio_dprintk(RIO_DEBUG_PARAM, "wait for can_add_transmit broken by signal\n");
 			rio_spin_unlock_irqrestore(&PortP->portSem, flags);
-			pseterr(EINTR);
 			func_exit();
-
-			return RIO_FAIL;
+			return -EINTR;
 		}
 		if (PortP->State & RIO_DELETED) {
 			rio_spin_unlock_irqrestore(&PortP->portSem, flags);
 			func_exit();
-
 			return RIO_SUCCESS;
 		}
 	}
@@ -247,7 +240,7 @@
 	}
 
 	rio_dprintk(RIO_DEBUG_PARAM, "can_add_transmit() returns %x\n", res);
-	rio_dprintk(RIO_DEBUG_PARAM, "Packet is 0x%x\n", (int) PacketP);
+	rio_dprintk(RIO_DEBUG_PARAM, "Packet is 0x%p\n", PacketP);
 
 	phb_param_ptr = (struct phb_param *) PacketP->data;
 
@@ -474,9 +467,6 @@
 		e(115200);	/* e(230400);e(460800); e(921600);  */
 	}
 
-	/* XXX MIssing conversion table. XXX */
-	/*       (TtyP->termios->c_cflag & V_CBAUD); */
-
 	rio_dprintk(RIO_DEBUG_PARAM, "tx baud 0x%x, rx baud 0x%x\n", TxBaud, RxBaud);
 
 
@@ -552,23 +542,23 @@
 	/*
 	 ** Actually write the info into the packet to be sent
 	 */
-	WBYTE(phb_param_ptr->Cmd, cmd);
-	WBYTE(phb_param_ptr->Cor1, Cor1);
-	WBYTE(phb_param_ptr->Cor2, Cor2);
-	WBYTE(phb_param_ptr->Cor4, Cor4);
-	WBYTE(phb_param_ptr->Cor5, Cor5);
-	WBYTE(phb_param_ptr->TxXon, TxXon);
-	WBYTE(phb_param_ptr->RxXon, RxXon);
-	WBYTE(phb_param_ptr->TxXoff, TxXoff);
-	WBYTE(phb_param_ptr->RxXoff, RxXoff);
-	WBYTE(phb_param_ptr->LNext, LNext);
-	WBYTE(phb_param_ptr->TxBaud, TxBaud);
-	WBYTE(phb_param_ptr->RxBaud, RxBaud);
+	writeb(cmd, &phb_param_ptr->Cmd);
+	writeb(Cor1, &phb_param_ptr->Cor1);
+	writeb(Cor2, &phb_param_ptr->Cor2);
+	writeb(Cor4, &phb_param_ptr->Cor4);
+	writeb(Cor5, &phb_param_ptr->Cor5);
+	writeb(TxXon, &phb_param_ptr->TxXon);
+	writeb(RxXon, &phb_param_ptr->RxXon);
+	writeb(TxXoff, &phb_param_ptr->TxXoff);
+	writeb(RxXoff, &phb_param_ptr->RxXoff);
+	writeb(LNext, &phb_param_ptr->LNext);
+	writeb(TxBaud, &phb_param_ptr->TxBaud);
+	writeb(RxBaud, &phb_param_ptr->RxBaud);
 
 	/*
 	 ** Set the length/command field
 	 */
-	WBYTE(PacketP->len, 12 | PKT_CMD_BIT);
+	writeb(12 | PKT_CMD_BIT, &PacketP->len);
 
 	/*
 	 ** The packet is formed - now, whack it off
@@ -597,15 +587,13 @@
 ** We can add another packet to a transmit queue if the packet pointer pointed
 ** to by the TxAdd pointer has PKT_IN_USE clear in its address.
 */
-int can_add_transmit(PktP, PortP)
-PKT **PktP;
-struct Port *PortP;
+int can_add_transmit(PKT **PktP, struct Port *PortP)
 {
-	register PKT *tp;
+	PKT *tp;
 
-	*PktP = tp = (PKT *) RIO_PTR(PortP->Caddr, RWORD(*PortP->TxAdd));
+	*PktP = tp = (PKT *) RIO_PTR(PortP->Caddr, readw(PortP->TxAdd));
 
-	return !((uint) tp & PKT_IN_USE);
+	return !((unsigned long) tp & PKT_IN_USE);
 }
 
 /*
@@ -613,24 +601,21 @@
 ** and then move the TxAdd pointer along one position to point to the next
 ** packet pointer. You must wrap the pointer from the end back to the start.
 */
-void add_transmit(PortP)
-struct Port *PortP;
+void add_transmit(struct Port *PortP)
 {
-	if (RWORD(*PortP->TxAdd) & PKT_IN_USE) {
+	if (readw(PortP->TxAdd) & PKT_IN_USE) {
 		rio_dprintk(RIO_DEBUG_PARAM, "add_transmit: Packet has been stolen!");
 	}
-	WWORD(*(ushort *) PortP->TxAdd, RWORD(*PortP->TxAdd) | PKT_IN_USE);
+	writew(readw(PortP->TxAdd) | PKT_IN_USE, PortP->TxAdd);
 	PortP->TxAdd = (PortP->TxAdd == PortP->TxEnd) ? PortP->TxStart : PortP->TxAdd + 1;
-	WWORD(PortP->PhbP->tx_add, RIO_OFF(PortP->Caddr, PortP->TxAdd));
+	writew(RIO_OFF(PortP->Caddr, PortP->TxAdd), &PortP->PhbP->tx_add);
 }
 
 /****************************************
  * Put a packet onto the end of the
  * free list
  ****************************************/
-void put_free_end(HostP, PktP)
-struct Host *HostP;
-PKT *PktP;
+void put_free_end(struct Host *HostP, PKT *PktP)
 {
 	FREE_LIST *tmp_pointer;
 	ushort old_end, new_end;
@@ -643,21 +628,21 @@
 	*
 	************************************************/
 
-	rio_dprintk(RIO_DEBUG_PFE, "put_free_end(PktP=%x)\n", (int) PktP);
+	rio_dprintk(RIO_DEBUG_PFE, "put_free_end(PktP=%p)\n", PktP);
 
-	if ((old_end = RWORD(HostP->ParmMapP->free_list_end)) != TPNULL) {
+	if ((old_end = readw(&HostP->ParmMapP->free_list_end)) != TPNULL) {
 		new_end = RIO_OFF(HostP->Caddr, PktP);
 		tmp_pointer = (FREE_LIST *) RIO_PTR(HostP->Caddr, old_end);
-		WWORD(tmp_pointer->next, new_end);
-		WWORD(((FREE_LIST *) PktP)->prev, old_end);
-		WWORD(((FREE_LIST *) PktP)->next, TPNULL);
-		WWORD(HostP->ParmMapP->free_list_end, new_end);
+		writew(new_end, &tmp_pointer->next);
+		writew(old_end, &((FREE_LIST *) PktP)->prev);
+		writew(TPNULL, &((FREE_LIST *) PktP)->next);
+		writew(new_end, &HostP->ParmMapP->free_list_end);
 	} else {		/* First packet on the free list this should never happen! */
 		rio_dprintk(RIO_DEBUG_PFE, "put_free_end(): This should never happen\n");
-		WWORD(HostP->ParmMapP->free_list_end, RIO_OFF(HostP->Caddr, PktP));
+		writew(RIO_OFF(HostP->Caddr, PktP), &HostP->ParmMapP->free_list_end);
 		tmp_pointer = (FREE_LIST *) PktP;
-		WWORD(tmp_pointer->prev, TPNULL);
-		WWORD(tmp_pointer->next, TPNULL);
+		writew(TPNULL, &tmp_pointer->prev);
+		writew(TPNULL, &tmp_pointer->next);
 	}
 	rio_dprintk(RIO_DEBUG_CMD, "Before unlock: %p\n", &HostP->HostLock);
 	rio_spin_unlock_irqrestore(&HostP->HostLock, flags);
@@ -669,12 +654,10 @@
 ** relevant packet, [having cleared the PKT_IN_USE bit]. If PKT_IN_USE is clear,
 ** then can_remove_receive() returns 0.
 */
-int can_remove_receive(PktP, PortP)
-PKT **PktP;
-struct Port *PortP;
+int can_remove_receive(PKT **PktP, struct Port *PortP)
 {
-	if (RWORD(*PortP->RxRemove) & PKT_IN_USE) {
-		*PktP = (PKT *) RIO_PTR(PortP->Caddr, RWORD(*PortP->RxRemove) & ~PKT_IN_USE);
+	if (readw(PortP->RxRemove) & PKT_IN_USE) {
+		*PktP = (PKT *) RIO_PTR(PortP->Caddr, readw(PortP->RxRemove) & ~PKT_IN_USE);
 		return 1;
 	}
 	return 0;
@@ -685,10 +668,9 @@
 ** and then bump the pointers. Once the pointers get to the end, they must
 ** be wrapped back to the start.
 */
-void remove_receive(PortP)
-struct Port *PortP;
+void remove_receive(struct Port *PortP)
 {
-	WWORD(*PortP->RxRemove, RWORD(*PortP->RxRemove) & ~PKT_IN_USE);
+	writew(readw(PortP->RxRemove) & ~PKT_IN_USE, PortP->RxRemove);
 	PortP->RxRemove = (PortP->RxRemove == PortP->RxEnd) ? PortP->RxStart : PortP->RxRemove + 1;
-	WWORD(PortP->PhbP->rx_remove, RIO_OFF(PortP->Caddr, PortP->RxRemove));
+	writew(RIO_OFF(PortP->Caddr, PortP->RxRemove), &PortP->PhbP->rx_remove);
 }
diff -u --new-file --recursive --exclude-from /usr/src/exclude linux.vanilla-2.6.16-rc6-mm1/drivers/char/rio/rioroute.c linux-2.6.16-rc6-mm1/drivers/char/rio/rioroute.c
--- linux.vanilla-2.6.16-rc6-mm1/drivers/char/rio/rioroute.c	2006-03-14 12:59:37.000000000 +0000
+++ linux-2.6.16-rc6-mm1/drivers/char/rio/rioroute.c	2006-03-14 21:51:55.000000000 +0000
@@ -115,7 +115,7 @@
 	/*
 	 ** Is this unit telling us it's current link topology?
 	 */
-	if (RBYTE(PktCmdP->Command) == ROUTE_TOPOLOGY) {
+	if (readb(&PktCmdP->Command) == ROUTE_TOPOLOGY) {
 		MapP = HostP->Mapping;
 
 		/*
@@ -151,11 +151,11 @@
 			 ** it won't lie about network interconnect, total disconnects
 			 ** and no-IDs. (or at least, it doesn't *matter* if it does)
 			 */
-			if (RBYTE(PktCmdP->RouteTopology[ThisLink].Unit) > (ushort) MAX_RUP)
+			if (readb(&PktCmdP->RouteTopology[ThisLink].Unit) > (ushort) MAX_RUP)
 				continue;
 
 			for (NewLink = ThisLinkMin; NewLink < ThisLink; NewLink++) {
-				if ((RBYTE(PktCmdP->RouteTopology[ThisLink].Unit) == RBYTE(PktCmdP->RouteTopology[NewLink].Unit)) && (RBYTE(PktCmdP->RouteTopology[ThisLink].Link) == RBYTE(PktCmdP->RouteTopology[NewLink].Link))) {
+				if ((readb(&PktCmdP->RouteTopology[ThisLink].Unit) == readb(&PktCmdP->RouteTopology[NewLink].Unit)) && (readb(&PktCmdP->RouteTopology[ThisLink].Link) == readb(&PktCmdP->RouteTopology[NewLink].Link))) {
 					Lies++;
 				}
 			}
@@ -164,10 +164,10 @@
 		if (Lies) {
 			rio_dprintk(RIO_DEBUG_ROUTE, "LIES! DAMN LIES! %d LIES!\n", Lies);
 			rio_dprintk(RIO_DEBUG_ROUTE, "%d:%c %d:%c %d:%c %d:%c\n",
-				    RBYTE(PktCmdP->RouteTopology[0].Unit),
-				    'A' + RBYTE(PktCmdP->RouteTopology[0].Link),
-				    RBYTE(PktCmdP->RouteTopology[1].Unit),
-				    'A' + RBYTE(PktCmdP->RouteTopology[1].Link), RBYTE(PktCmdP->RouteTopology[2].Unit), 'A' + RBYTE(PktCmdP->RouteTopology[2].Link), RBYTE(PktCmdP->RouteTopology[3].Unit), 'A' + RBYTE(PktCmdP->RouteTopology[3].Link));
+				    readb(&PktCmdP->RouteTopology[0].Unit),
+				    'A' + readb(&PktCmdP->RouteTopology[0].Link),
+				    readb(&PktCmdP->RouteTopology[1].Unit),
+				    'A' + readb(&PktCmdP->RouteTopology[1].Link), readb(&PktCmdP->RouteTopology[2].Unit), 'A' + readb(&PktCmdP->RouteTopology[2].Link), readb(&PktCmdP->RouteTopology[3].Unit), 'A' + readb(&PktCmdP->RouteTopology[3].Link));
 			return TRUE;
 		}
 
@@ -184,8 +184,8 @@
 			/*
 			 ** this is what it is now connected to
 			 */
-			NewUnit = RBYTE(PktCmdP->RouteTopology[ThisLink].Unit);
-			NewLink = RBYTE(PktCmdP->RouteTopology[ThisLink].Link);
+			NewUnit = readb(&PktCmdP->RouteTopology[ThisLink].Unit);
+			NewLink = readb(&PktCmdP->RouteTopology[ThisLink].Link);
 
 			if (OldUnit != NewUnit || OldLink != NewLink) {
 				/*
@@ -219,7 +219,7 @@
 
 					if (NewUnit == ROUTE_INTERCONNECT) {
 						if (!p->RIONoMessage)
-							cprintf("%s '%s' (%c) is connected to another network.\n", MyType, MyName, 'A' + ThisLink);
+							printk(KERN_DEBUG "rio: %s '%s' (%c) is connected to another network.\n", MyType, MyName, 'A' + ThisLink);
 					}
 
 					/*
@@ -264,12 +264,12 @@
 	/*
 	 ** The only other command we recognise is a route_request command
 	 */
-	if (RBYTE(PktCmdP->Command) != ROUTE_REQUEST) {
-		rio_dprintk(RIO_DEBUG_ROUTE, "Unknown command %d received on rup %d host %d ROUTE_RUP\n", RBYTE(PktCmdP->Command), Rup, (int) HostP);
+	if (readb(&PktCmdP->Command) != ROUTE_REQUEST) {
+		rio_dprintk(RIO_DEBUG_ROUTE, "Unknown command %d received on rup %d host %p ROUTE_RUP\n", readb(&PktCmdP->Command), Rup, HostP);
 		return TRUE;
 	}
 
-	RtaUniq = (RBYTE(PktCmdP->UniqNum[0])) + (RBYTE(PktCmdP->UniqNum[1]) << 8) + (RBYTE(PktCmdP->UniqNum[2]) << 16) + (RBYTE(PktCmdP->UniqNum[3]) << 24);
+	RtaUniq = (readb(&PktCmdP->UniqNum[0])) + (readb(&PktCmdP->UniqNum[1]) << 8) + (readb(&PktCmdP->UniqNum[2]) << 16) + (readb(&PktCmdP->UniqNum[3]) << 24);
 
 	/*
 	 ** Determine if 8 or 16 port RTA
@@ -278,7 +278,7 @@
 
 	rio_dprintk(RIO_DEBUG_ROUTE, "Received a request for an ID for serial number %x\n", RtaUniq);
 
-	Mod = RBYTE(PktCmdP->ModuleTypes);
+	Mod = readb(&PktCmdP->ModuleTypes);
 	Mod1 = LONYBLE(Mod);
 	if (RtaType == TYPE_RTA16) {
 		/*
@@ -348,7 +348,7 @@
 			if ((HostP->Mapping[ThisUnit].Flags & SLOT_IN_USE) && !(HostP->Mapping[ThisUnit].Flags & RTA_BOOTED)) {
 				if (!(HostP->Mapping[ThisUnit].Flags & MSG_DONE)) {
 					if (!p->RIONoMessage)
-						cprintf("RTA '%s' is being updated.\n", HostP->Mapping[ThisUnit].Name);
+						printk(KERN_DEBUG "rio: RTA '%s' is being updated.\n", HostP->Mapping[ThisUnit].Name);
 					HostP->Mapping[ThisUnit].Flags |= MSG_DONE;
 				}
 				PktReplyP->Command = ROUTE_FOAD;
@@ -475,7 +475,7 @@
 
 		if (!UnknownMesgDone) {
 			if (!p->RIONoMessage)
-				cprintf("One or more unknown RTAs are being updated.\n");
+				printk(KERN_DEBUG "rio: One or more unknown RTAs are being updated.\n");
 			UnknownMesgDone = 1;
 		}
 
@@ -527,7 +527,7 @@
 		 */
 		PortP = p->RIOPortp[HostP->Mapping[dest_unit - 1].SysPort];
 
-		link = RWORD(PortP->PhbP->link);
+		link = readw(&PortP->PhbP->link);
 
 		for (port = 0; port < PORTS_PER_RTA; port++, PortN++) {
 			ushort dest_port = port + 8;
@@ -569,18 +569,18 @@
 				 ** card. This needs to be translated into a 32 bit pointer
 				 ** so it can be accessed from the driver.
 				 */
-				Pkt = (PKT *) RIO_PTR(HostP->Caddr, RINDW(TxPktP));
+				Pkt = (PKT *) RIO_PTR(HostP->Caddr, readw(TxPktP));
 
 				/*
 				 ** If the packet is used, reset it.
 				 */
-				Pkt = (PKT *) ((uint) Pkt & ~PKT_IN_USE);
-				WBYTE(Pkt->dest_unit, dest_unit);
-				WBYTE(Pkt->dest_port, dest_port);
-			}
-			rio_dprintk(RIO_DEBUG_ROUTE, "phb dest: Old %x:%x New %x:%x\n", RWORD(PortP->PhbP->destination) & 0xff, (RWORD(PortP->PhbP->destination) >> 8) & 0xff, dest_unit, dest_port);
-			WWORD(PortP->PhbP->destination, dest_unit + (dest_port << 8));
-			WWORD(PortP->PhbP->link, link);
+				Pkt = (PKT *) ((unsigned long) Pkt & ~PKT_IN_USE);
+				writeb(dest_unit, &Pkt->dest_unit);
+				writeb(dest_port, &Pkt->dest_port);
+			}
+			rio_dprintk(RIO_DEBUG_ROUTE, "phb dest: Old %x:%x New %x:%x\n", readw(&PortP->PhbP->destination) & 0xff, (readw(&PortP->PhbP->destination) >> 8) & 0xff, dest_unit, dest_port);
+			writew(dest_unit + (dest_port << 8), &PortP->PhbP->destination);
+			writew(link, &PortP->PhbP->link);
 
 			rio_spin_unlock_irqrestore(&PortP->portSem, flags);
 		}
@@ -590,9 +590,9 @@
 		 */
 		if (link > 3)
 			return;
-		if (((unit * 8) + 7) > RWORD(HostP->LinkStrP[link].last_port)) {
+		if (((unit * 8) + 7) > readw(&HostP->LinkStrP[link].last_port)) {
 			rio_dprintk(RIO_DEBUG_ROUTE, "last port on host link %d: %d\n", link, (unit * 8) + 7);
-			WWORD(HostP->LinkStrP[link].last_port, (unit * 8) + 7);
+			writew((unit * 8) + 7, &HostP->LinkStrP[link].last_port);
 		}
 	}
 }
@@ -818,7 +818,7 @@
 	ToType = ToId ? "RTA" : "HOST";
 
 	rio_dprintk(RIO_DEBUG_ROUTE, "Link between %s '%s' (%c) and %s '%s' (%c) %s.\n", FromType, FromName, 'A' + FromLink, ToType, ToName, 'A' + ToLink, (Change == CONNECT) ? "established" : "disconnected");
-	cprintf("Link between %s '%s' (%c) and %s '%s' (%c) %s.\n", FromType, FromName, 'A' + FromLink, ToType, ToName, 'A' + ToLink, (Change == CONNECT) ? "established" : "disconnected");
+	printk(KERN_DEBUG "rio: Link between %s '%s' (%c) and %s '%s' (%c) %s.\n", FromType, FromName, 'A' + FromLink, ToType, ToName, 'A' + ToLink, (Change == CONNECT) ? "established" : "disconnected");
 }
 
 /*
@@ -838,7 +838,7 @@
 	 */
 	for (entry = 0; entry < TOTAL_MAP_ENTRIES; entry++) {
 		if (p->RIOSavedTable[entry].RtaUniqueNum == pMap->RtaUniqueNum) {
-			bzero((caddr_t) & p->RIOSavedTable[entry], sizeof(struct Map));
+			memset(&p->RIOSavedTable[entry], 0, sizeof(struct Map));
 		}
 	}
 	return 0;
@@ -898,7 +898,7 @@
 		int nOther = (HostP->Mapping[unit].ID2) - 1;
 
 		rio_dprintk(RIO_DEBUG_ROUTE, "RioFreedis second slot %d.\n", nOther);
-		bzero((caddr_t) & HostP->Mapping[nOther], sizeof(struct Map));
+		memset(&HostP->Mapping[nOther], 0, sizeof(struct Map));
 	}
 	RIORemoveFromSavedTable(p, &HostP->Mapping[unit]);
 
@@ -997,7 +997,7 @@
 				/*
 				 ** Clear out this slot now that we intend to use it.
 				 */
-				bzero(&HostP->Mapping[unit], sizeof(struct Map));
+				memset(&HostP->Mapping[unit], 0, sizeof(struct Map));
 
 				/*
 				 ** If the second ID is not needed then we can return
@@ -1015,7 +1015,7 @@
 				/*
 				 ** Clear out this slot now that we intend to use it.
 				 */
-				bzero(&HostP->Mapping[unit], sizeof(struct Map));
+				memset(&HostP->Mapping[unit], 0, sizeof(struct Map));
 
 				/* At this point under the right(wrong?) conditions
 				 ** we may have a first unit ID being higher than the
diff -u --new-file --recursive --exclude-from /usr/src/exclude linux.vanilla-2.6.16-rc6-mm1/drivers/char/rio/riotable.c linux-2.6.16-rc6-mm1/drivers/char/rio/riotable.c
--- linux.vanilla-2.6.16-rc6-mm1/drivers/char/rio/riotable.c	2006-03-14 12:59:37.000000000 +0000
+++ linux-2.6.16-rc6-mm1/drivers/char/rio/riotable.c	2006-03-14 21:51:55.000000000 +0000
@@ -91,8 +91,7 @@
 ** A configuration table has been loaded. It is now up to us
 ** to sort it out and use the information contained therein.
 */
-int RIONewTable(p)
-struct rio_info *p;
+int RIONewTable(struct rio_info *p)
 {
 	int Host, Host1, Host2, NameIsUnique, Entry, SubEnt;
 	struct Map *MapP;
@@ -298,9 +297,9 @@
 	 */
 	for (Host = 0; Host < RIO_HOSTS; Host++) {
 		for (Entry = 0; Entry < MAX_RUP; Entry++) {
-			bzero((caddr_t) & p->RIOHosts[Host].Mapping[Entry], sizeof(struct Map));
+			memset(&p->RIOHosts[Host].Mapping[Entry], 0, sizeof(struct Map));
 		}
-		bzero((caddr_t) & p->RIOHosts[Host].Name[0], sizeof(p->RIOHosts[Host].Name));
+		memset(&p->RIOHosts[Host].Name[0], 0, sizeof(p->RIOHosts[Host].Name));
 	}
 
 	/*
@@ -409,9 +408,10 @@
 /*
 ** User process needs the config table - build it from first
 ** principles.
+**
+*	FIXME: SMP locking
 */
-int RIOApel(p)
-struct rio_info *p;
+int RIOApel(struct rio_info *p)
 {
 	int Host;
 	int link;
@@ -419,17 +419,17 @@
 	int Next = 0;
 	struct Map *MapP;
 	struct Host *HostP;
-	long oldspl;
-
-	disable(oldspl);	/* strange but true! */
+	unsigned long flags;
 
 	rio_dprintk(RIO_DEBUG_TABLE, "Generating a table to return to config.rio\n");
 
-	bzero((caddr_t) & p->RIOConnectTable[0], sizeof(struct Map) * TOTAL_MAP_ENTRIES);
+	memset(&p->RIOConnectTable[0], 0, sizeof(struct Map) * TOTAL_MAP_ENTRIES);
 
 	for (Host = 0; Host < RIO_HOSTS; Host++) {
 		rio_dprintk(RIO_DEBUG_TABLE, "Processing host %d\n", Host);
 		HostP = &p->RIOHosts[Host];
+		rio_spin_lock_irqsave(&HostP->HostLock, flags);
+		
 		MapP = &p->RIOConnectTable[Next++];
 		MapP->HostUniqueNum = HostP->UniqueNum;
 		if ((HostP->Flags & RUN_STATE) != RC_RUNNING)
@@ -453,8 +453,8 @@
 				Next++;
 			}
 		}
+		rio_spin_unlock_irqrestore(&HostP->HostLock, flags);
 	}
-	restore(oldspl);
 	return 0;
 }
 
@@ -463,9 +463,7 @@
 ** if the entry is suitably inactive, then we can gob on it and remove
 ** it from the table.
 */
-int RIODeleteRta(p, MapP)
-struct rio_info *p;
-struct Map *MapP;
+int RIODeleteRta(struct rio_info *p, struct Map *MapP)
 {
 	int host, entry, port, link;
 	int SysPort;
@@ -543,7 +541,7 @@
 						if (PortP->SecondBlock) {
 							ushort dest_unit = HostMapP->ID;
 							ushort dest_port = port - SysPort;
-							WORD *TxPktP;
+							u16 *TxPktP;
 							PKT *Pkt;
 
 							for (TxPktP = PortP->TxStart; TxPktP <= PortP->TxEnd; TxPktP++) {
@@ -554,19 +552,19 @@
 								 ** a 32 bit pointer so it can be
 								 ** accessed from the driver.
 								 */
-								Pkt = (PKT *) RIO_PTR(HostP->Caddr, RWORD(*TxPktP));
+								Pkt = (PKT *) RIO_PTR(HostP->Caddr, readw(&*TxPktP));
 								rio_dprintk(RIO_DEBUG_TABLE, "Tx packet (%x) destination: Old %x:%x New %x:%x\n", *TxPktP, Pkt->dest_unit, Pkt->dest_port, dest_unit, dest_port);
-								WWORD(Pkt->dest_unit, dest_unit);
-								WWORD(Pkt->dest_port, dest_port);
+								writew(dest_unit, &Pkt->dest_unit);
+								writew(dest_port, &Pkt->dest_port);
 							}
 							rio_dprintk(RIO_DEBUG_TABLE, "Port %d phb destination: Old %x:%x New %x:%x\n", port, PortP->PhbP->destination & 0xff, (PortP->PhbP->destination >> 8) & 0xff, dest_unit, dest_port);
-							WWORD(PortP->PhbP->destination, dest_unit + (dest_port << 8));
+							writew(dest_unit + (dest_port << 8), &PortP->PhbP->destination);
 						}
 						rio_spin_unlock_irqrestore(&PortP->portSem, sem_flags);
 					}
 				}
 				rio_dprintk(RIO_DEBUG_TABLE, "Entry nulled.\n");
-				bzero((char *) HostMapP, sizeof(struct Map));
+				memset(HostMapP, 0, sizeof(struct Map));
 				work_done++;
 			}
 		}
@@ -576,11 +574,11 @@
 	/* XXXXX lock me up */
 	for (entry = 0; entry < TOTAL_MAP_ENTRIES; entry++) {
 		if (p->RIOSavedTable[entry].RtaUniqueNum == MapP->RtaUniqueNum) {
-			bzero((char *) &p->RIOSavedTable[entry], sizeof(struct Map));
+			memset(&p->RIOSavedTable[entry], 0, sizeof(struct Map));
 			work_done++;
 		}
 		if (p->RIOConnectTable[entry].RtaUniqueNum == MapP->RtaUniqueNum) {
-			bzero((char *) &p->RIOConnectTable[entry], sizeof(struct Map));
+			memset(&p->RIOConnectTable[entry], 0, sizeof(struct Map));
 			work_done++;
 		}
 	}
@@ -742,12 +740,9 @@
 }
 
 
-int RIOReMapPorts(p, HostP, HostMapP)
-struct rio_info *p;
-struct Host *HostP;
-struct Map *HostMapP;
+int RIOReMapPorts(struct rio_info *p, struct Host *HostP, struct Map *HostMapP)
 {
-	register struct Port *PortP;
+	struct Port *PortP;
 	uint SubEnt;
 	uint HostPort;
 	uint SysPort;
@@ -794,12 +789,12 @@
 		 */
 		if ((HostP->Flags & RUN_STATE) == RC_RUNNING) {
 			struct PHB *PhbP = PortP->PhbP = &HostP->PhbP[HostPort];
-			PortP->TxAdd = (WORD *) RIO_PTR(HostP->Caddr, RWORD(PhbP->tx_add));
-			PortP->TxStart = (WORD *) RIO_PTR(HostP->Caddr, RWORD(PhbP->tx_start));
-			PortP->TxEnd = (WORD *) RIO_PTR(HostP->Caddr, RWORD(PhbP->tx_end));
-			PortP->RxRemove = (WORD *) RIO_PTR(HostP->Caddr, RWORD(PhbP->rx_remove));
-			PortP->RxStart = (WORD *) RIO_PTR(HostP->Caddr, RWORD(PhbP->rx_start));
-			PortP->RxEnd = (WORD *) RIO_PTR(HostP->Caddr, RWORD(PhbP->rx_end));
+			PortP->TxAdd = (u16 *) RIO_PTR(HostP->Caddr, readw(&PhbP->tx_add));
+			PortP->TxStart = (u16 *) RIO_PTR(HostP->Caddr, readw(&PhbP->tx_start));
+			PortP->TxEnd = (u16 *) RIO_PTR(HostP->Caddr, readw(&PhbP->tx_end));
+			PortP->RxRemove = (u16 *) RIO_PTR(HostP->Caddr, readw(&PhbP->rx_remove));
+			PortP->RxStart = (u16 *) RIO_PTR(HostP->Caddr, readw(&PhbP->rx_start));
+			PortP->RxEnd = (u16 *) RIO_PTR(HostP->Caddr, readw(&PhbP->rx_end));
 		} else
 			PortP->PhbP = NULL;
 
@@ -866,9 +861,6 @@
 		PortP->RxDataStart = 0;
 		PortP->Cor2Copy = 0;
 		PortP->Name = &HostMapP->Name[0];
-#ifdef STATS
-		bzero((caddr_t) & PortP->Stat, sizeof(struct RIOStats));
-#endif
 		PortP->statsGather = 0;
 		PortP->txchars = 0;
 		PortP->rxchars = 0;
@@ -876,10 +868,10 @@
 		PortP->closes = 0;
 		PortP->ioctls = 0;
 		if (PortP->TxRingBuffer)
-			bzero(PortP->TxRingBuffer, p->RIOBufferSize);
+			memset(PortP->TxRingBuffer, 0, p->RIOBufferSize);
 		else if (p->RIOBufferSize) {
-			PortP->TxRingBuffer = sysbrk(p->RIOBufferSize);
-			bzero(PortP->TxRingBuffer, p->RIOBufferSize);
+			PortP->TxRingBuffer = kmalloc(p->RIOBufferSize, GFP_KERNEL);
+			memset(PortP->TxRingBuffer, 0, p->RIOBufferSize);
 		}
 		PortP->TxBufferOut = 0;
 		PortP->TxBufferIn = 0;
@@ -890,7 +882,7 @@
 		 ** If the same, we have received the same rx pkt from the RTA
 		 ** twice. Initialise to a value not equal to PHB_RX_TGL or 0.
 		 */
-		PortP->LastRxTgl = ~(uchar) PHB_RX_TGL;
+		PortP->LastRxTgl = ~(u8) PHB_RX_TGL;
 
 		/*
 		 ** and mark the port as usable
@@ -906,9 +898,7 @@
 	return 0;
 }
 
-int RIOChangeName(p, MapP)
-struct rio_info *p;
-struct Map *MapP;
+int RIOChangeName(struct rio_info *p, struct Map *MapP)
 {
 	int host;
 	struct Map *HostMapP;
diff -u --new-file --recursive --exclude-from /usr/src/exclude linux.vanilla-2.6.16-rc6-mm1/drivers/char/rio/riotty.c linux-2.6.16-rc6-mm1/drivers/char/rio/riotty.c
--- linux.vanilla-2.6.16-rc6-mm1/drivers/char/rio/riotty.c	2006-03-14 12:59:37.000000000 +0000
+++ linux-2.6.16-rc6-mm1/drivers/char/rio/riotty.c	2006-03-14 21:51:55.000000000 +0000
@@ -136,7 +136,7 @@
 
 int riotopen(struct tty_struct *tty, struct file *filp)
 {
-	register uint SysPort;
+	unsigned int SysPort;
 	int Modem;
 	int repeat_this = 250;
 	struct Port *PortP;	/* pointer to the port structure */
@@ -155,7 +155,6 @@
 
 	if (p->RIOFailed) {
 		rio_dprintk(RIO_DEBUG_TTY, "System initialisation failed\n");
-		pseterr(ENXIO);
 		func_exit();
 		return -ENXIO;
 	}
@@ -170,7 +169,6 @@
 	 */
 	if (SysPort >= RIO_PORTS) {	/* out of range ? */
 		rio_dprintk(RIO_DEBUG_TTY, "Illegal port number %d\n", SysPort);
-		pseterr(ENXIO);
 		func_exit();
 		return -ENXIO;
 	}
@@ -187,7 +185,6 @@
 		 */
 		rio_dprintk(RIO_DEBUG_TTY, "port not mapped into system\n");
 		func_exit();
-		pseterr(ENXIO);
 		return -ENXIO;
 	}
 
@@ -209,7 +206,6 @@
 	 */
 	if ((PortP->HostP->Flags & RUN_STATE) != RC_RUNNING) {
 		rio_dprintk(RIO_DEBUG_TTY, "Host not running\n");
-		pseterr(ENXIO);
 		func_exit();
 		return -ENXIO;
 	}
@@ -429,9 +425,6 @@
 
 	rio_dprintk(RIO_DEBUG_TTY, "high level open done\n");
 
-#ifdef STATS
-	PortP->Stat.OpenCnt++;
-#endif
 	/*
 	 ** Count opens for port statistics reporting
 	 */
@@ -466,10 +459,10 @@
 	rio_dprintk(RIO_DEBUG_TTY, "port close SysPort %d\n", PortP->PortNum);
 
 	/* PortP = p->RIOPortp[SysPort]; */
-	rio_dprintk(RIO_DEBUG_TTY, "Port is at address 0x%x\n", (int) PortP);
+	rio_dprintk(RIO_DEBUG_TTY, "Port is at address 0x%p\n", PortP);
 	/* tp = PortP->TtyP; *//* Get tty */
 	tty = PortP->gs.tty;
-	rio_dprintk(RIO_DEBUG_TTY, "TTY is at address 0x%x\n", (int) tty);
+	rio_dprintk(RIO_DEBUG_TTY, "TTY is at address 0x%p\n", tty);
 
 	if (PortP->gs.closing_wait)
 		end_time = jiffies + PortP->gs.closing_wait;
@@ -536,7 +529,6 @@
 
 	if (!deleted)
 		while ((PortP->InUse != NOT_INUSE) && !p->RIOHalted && (PortP->TxBufferIn != PortP->TxBufferOut)) {
-			cprintf("Need to flush the ttyport\n");
 			if (repeat_this-- <= 0) {
 				rv = -EINTR;
 				rio_dprintk(RIO_DEBUG_TTY, "Waiting for not idle closed broken by signal\n");
@@ -615,9 +607,6 @@
 */
 	PortP->Config &= ~(RIO_CTSFLOW | RIO_RTSFLOW);
 
-#ifdef STATS
-	PortP->Stat.CloseCnt++;
-#endif
 	/*
 	 ** Count opens for port statistics reporting
 	 */
@@ -722,15 +711,15 @@
 	/*
 	 ** set the command byte and the argument byte
 	 */
-	WBYTE(PacketP->data[0], command);
+	writeb(command, &PacketP->data[0]);
 
 	if (len == 2)
-		WBYTE(PacketP->data[1], arg);
+		writeb(arg, &PacketP->data[1]);
 
 	/*
 	 ** set the length of the packet and set the command bit.
 	 */
-	WBYTE(PacketP->len, PKT_CMD_BIT | len);
+	writeb(PKT_CMD_BIT | len, &PacketP->len);
 
 	add_transmit(PortP);
 	/*

