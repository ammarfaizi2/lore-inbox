Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751392AbWCOMXK@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751392AbWCOMXK (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 15 Mar 2006 07:23:10 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752030AbWCOMXJ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 15 Mar 2006 07:23:09 -0500
Received: from outpipe-village-512-1.bc.nu ([81.2.110.250]:15064 "EHLO
	lxorguk.ukuu.org.uk") by vger.kernel.org with ESMTP
	id S1751392AbWCOMXH (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 15 Mar 2006 07:23:07 -0500
Subject: PATCH: rio driver rework continued  #3
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
To: linux-kernel@vger.kernel.org, akpm@osdl.org
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Date: Wed, 15 Mar 2006 12:29:22 +0000
Message-Id: <1142425762.5597.16.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Evolution 2.2.3 (2.2.3-2.fc4) 
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Second large chunk of code cleanup. The split between this and #3 and #4
is fairly arbitary and due to the message length limit on the list.
These patches continue the process of ripping out macros and typedefs
while cleaning up lots of 32bit assumptions. Several inlines for
compatibility also get removed and that causes a lot of noise.

Signed-off-by: Alan Cox <alan@redhat.com>

diff -u --new-file --recursive --exclude-from /usr/src/exclude linux.vanilla-2.6.16-rc6-mm1/drivers/char/rio/cmdblk.h linux-2.6.16-rc6-mm1/drivers/char/rio/cmdblk.h
--- linux.vanilla-2.6.16-rc6-mm1/drivers/char/rio/cmdblk.h	2006-03-14 12:59:37.000000000 +0000
+++ linux-2.6.16-rc6-mm1/drivers/char/rio/cmdblk.h	2006-03-14 15:48:32.000000000 +0000
@@ -48,10 +48,10 @@
 	struct CmdBlk *NextP;	/* Pointer to next command block */
 	struct PKT Packet;	/* A packet, to copy to the rup */
 	/* The func to call to check if OK */
-	int (*PreFuncP) (int, struct CmdBlk *);
+	int (*PreFuncP) (unsigned long, struct CmdBlk *);
 	int PreArg;		/* The arg for the func */
 	/* The func to call when completed */
-	int (*PostFuncP) (int, struct CmdBlk *);
+	int (*PostFuncP) (unsigned long, struct CmdBlk *);
 	int PostArg;		/* The arg for the func */
 };
 
diff -u --new-file --recursive --exclude-from /usr/src/exclude linux.vanilla-2.6.16-rc6-mm1/drivers/char/rio/func.h linux-2.6.16-rc6-mm1/drivers/char/rio/func.h
--- linux.vanilla-2.6.16-rc6-mm1/drivers/char/rio/func.h	2006-03-14 12:59:37.000000000 +0000
+++ linux-2.6.16-rc6-mm1/drivers/char/rio/func.h	2006-03-14 17:53:27.000000000 +0000
@@ -43,35 +43,34 @@
 
 /* rioboot.c */
 int RIOBootCodeRTA(struct rio_info *, struct DownLoad *);
-int RIOBootCodeHOST(struct rio_info *, register struct DownLoad *);
+int RIOBootCodeHOST(struct rio_info *, struct DownLoad *);
 int RIOBootCodeUNKNOWN(struct rio_info *, struct DownLoad *);
 void msec_timeout(struct Host *);
-int RIOBootRup(struct rio_info *, uint, struct Host *, struct PKT *);
-int RIOBootOk(struct rio_info *, struct Host *, ulong);
-int RIORtaBound(struct rio_info *, uint);
-void FillSlot(int, int, uint, struct Host *);
+int RIOBootRup(struct rio_info *, unsigned int, struct Host *, struct PKT *);
+int RIOBootOk(struct rio_info *, struct Host *, unsigned long);
+int RIORtaBound(struct rio_info *, unsigned int);
+void FillSlot(int, int, unsigned int, struct Host *);
 
 /* riocmd.c */
 int RIOFoadRta(struct Host *, struct Map *);
 int RIOZombieRta(struct Host *, struct Map *);
-int RIOCommandRta(struct rio_info *, uint, int (*func) (struct Host *, struct Map *));
-int RIOIdentifyRta(struct rio_info *, caddr_t);
-int RIOKillNeighbour(struct rio_info *, caddr_t);
+int RIOCommandRta(struct rio_info *, unsigned long, int (*func) (struct Host *, struct Map *));
+int RIOIdentifyRta(struct rio_info *, void *);
+int RIOKillNeighbour(struct rio_info *, void *);
 int RIOSuspendBootRta(struct Host *, int, int);
 int RIOFoadWakeup(struct rio_info *);
 struct CmdBlk *RIOGetCmdBlk(void);
 void RIOFreeCmdBlk(struct CmdBlk *);
-int RIOQueueCmdBlk(struct Host *, uint, struct CmdBlk *);
+int RIOQueueCmdBlk(struct Host *, unsigned int, struct CmdBlk *);
 void RIOPollHostCommands(struct rio_info *, struct Host *);
-int RIOWFlushMark(int, struct CmdBlk *);
-int RIORFlushEnable(int, struct CmdBlk *);
-int RIOUnUse(int, struct CmdBlk *);
-void ShowPacket(uint, struct PKT *);
+int RIOWFlushMark(unsigned long, struct CmdBlk *);
+int RIORFlushEnable(unsigned long, struct CmdBlk *);
+int RIOUnUse(unsigned long, struct CmdBlk *);
+void ShowPacket(unsigned int, struct PKT *);
 
 /* rioctrl.c */
-int copyin(int, caddr_t, int);
 int riocontrol(struct rio_info *, dev_t, int, caddr_t, int);
-int RIOPreemptiveCmd(struct rio_info *, struct Port *, uchar);
+int RIOPreemptiveCmd(struct rio_info *, struct Port *, unsigned char);
 
 /* rioinit.c */
 void rioinit(struct rio_info *, struct RioHostInfo *);
@@ -80,19 +79,19 @@
 int RIODoAT(struct rio_info *, int, int);
 caddr_t RIOCheckForATCard(int);
 int RIOAssignAT(struct rio_info *, int, caddr_t, int);
-int RIOBoardTest(paddr_t, caddr_t, uchar, int);
+int RIOBoardTest(paddr_t, caddr_t, unsigned char, int);
 void RIOAllocDataStructs(struct rio_info *);
 void RIOSetupDataStructs(struct rio_info *);
-int RIODefaultName(struct rio_info *, struct Host *, uint);
+int RIODefaultName(struct rio_info *, struct Host *, unsigned int);
 struct rioVersion *RIOVersid(void);
 int RIOMapin(paddr_t, int, caddr_t *);
 void RIOMapout(paddr_t, long, caddr_t);
-void RIOHostReset(uint, volatile struct DpRam *, uint);
+void RIOHostReset(unsigned int, struct DpRam *, unsigned int);
 
 /* riointr.c */
 void RIOTxEnable(char *);
 void RIOServiceHost(struct rio_info *, struct Host *, int);
-int riotproc(struct rio_info *, register struct ttystatics *, int, int);
+int riotproc(struct rio_info *, struct ttystatics *, int, int);
 
 /* rioparam.c */
 int RIOParam(struct Port *, int, int, int);
@@ -106,18 +105,18 @@
 void remove_receive(struct Port *);
 
 /* rioroute.c */
-int RIORouteRup(struct rio_info *, uint, struct Host *, struct PKT *);
-void RIOFixPhbs(struct rio_info *, struct Host *, uint);
-uint GetUnitType(uint);
+int RIORouteRup(struct rio_info *, unsigned int, struct Host *, struct PKT *);
+void RIOFixPhbs(struct rio_info *, struct Host *, unsigned int);
+unsigned int GetUnitType(unsigned int);
 int RIOSetChange(struct rio_info *);
-int RIOFindFreeID(struct rio_info *, struct Host *, uint *, uint *);
+int RIOFindFreeID(struct rio_info *, struct Host *, unsigned int *, unsigned int *);
 
 
 /* riotty.c */
 
 int riotopen(struct tty_struct *tty, struct file *filp);
 int riotclose(void *ptr);
-int riotioctl(struct rio_info *, struct tty_struct *, register int, register caddr_t);
+int riotioctl(struct rio_info *, struct tty_struct *, int, caddr_t);
 void ttyseth(struct Port *, struct ttystatics *, struct old_sgttyb *sg);
 
 /* riotable.c */
@@ -131,7 +130,7 @@
 #if 0
 /* riodrvr.c */
 struct rio_info *rio_install(struct RioHostInfo *);
-int rio_uninstall(register struct rio_info *);
+int rio_uninstall(struct rio_info *);
 int rio_open(struct rio_info *, int, struct file *);
 int rio_close(struct rio_info *, struct file *);
 int rio_read(struct rio_info *, struct file *, char *, int);
@@ -143,7 +142,7 @@
 struct rio_info *rio_info_store(int cmd, struct rio_info *p);
 #endif
 
-extern int rio_pcicopy(char *src, char *dst, int n);
+extern void rio_copy_to_card(void *to, void *from, int len);
 extern int rio_minor(struct tty_struct *tty);
 extern int rio_ismodem(struct tty_struct *tty);
 
diff -u --new-file --recursive --exclude-from /usr/src/exclude linux.vanilla-2.6.16-rc6-mm1/drivers/char/rio/riocmd.c linux-2.6.16-rc6-mm1/drivers/char/rio/riocmd.c
--- linux.vanilla-2.6.16-rc6-mm1/drivers/char/rio/riocmd.c	2006-03-14 12:59:37.000000000 +0000
+++ linux-2.6.16-rc6-mm1/drivers/char/rio/riocmd.c	2006-03-14 21:51:55.000000000 +0000
@@ -42,6 +42,7 @@
 #include <asm/system.h>
 #include <asm/string.h>
 #include <asm/semaphore.h>
+#include <asm/uaccess.h>
 
 #include <linux/termios.h>
 #include <linux/serial.h>
@@ -143,17 +144,17 @@
 	return 0;
 }
 
-int RIOCommandRta(struct rio_info *p, uint RtaUnique, int (*func) (struct Host * HostP, struct Map * MapP))
+int RIOCommandRta(struct rio_info *p, unsigned long RtaUnique, int (*func) (struct Host * HostP, struct Map * MapP))
 {
-	uint Host;
+	unsigned int Host;
 
-	rio_dprintk(RIO_DEBUG_CMD, "Command RTA 0x%x func 0x%x\n", RtaUnique, (int) func);
+	rio_dprintk(RIO_DEBUG_CMD, "Command RTA 0x%lx func 0x%p\n", RtaUnique, func);
 
 	if (!RtaUnique)
 		return (0);
 
 	for (Host = 0; Host < p->RIONumHosts; Host++) {
-		uint Rta;
+		unsigned int Rta;
 		struct Host *HostP = &p->RIOHosts[Host];
 
 		for (Rta = 0; Rta < RTAS_PER_HOST; Rta++) {
@@ -170,7 +171,7 @@
 				 ** any connections, we can get to it.
 				 */
 				for (Link = 0; Link < LINKS_PER_UNIT; Link++) {
-					if (MapP->Topology[Link].Unit <= (uchar) MAX_RUP) {
+					if (MapP->Topology[Link].Unit <= (u8) MAX_RUP) {
 						/*
 						 ** Its worth trying the operation...
 						 */
@@ -184,18 +185,18 @@
 }
 
 
-int RIOIdentifyRta(struct rio_info *p, caddr_t arg)
+int RIOIdentifyRta(struct rio_info *p, void * arg)
 {
-	uint Host;
+	unsigned int Host;
 
-	if (copyin((int) arg, (caddr_t) & IdRta, sizeof(IdRta)) == COPYFAIL) {
+	if (copy_from_user(&IdRta, arg, sizeof(IdRta))) {
 		rio_dprintk(RIO_DEBUG_CMD, "RIO_IDENTIFY_RTA copy failed\n");
 		p->RIOError.Error = COPYIN_FAILED;
 		return -EFAULT;
 	}
 
 	for (Host = 0; Host < p->RIONumHosts; Host++) {
-		uint Rta;
+		unsigned int Rta;
 		struct Host *HostP = &p->RIOHosts[Host];
 
 		for (Rta = 0; Rta < RTAS_PER_HOST; Rta++) {
@@ -211,7 +212,7 @@
 				 ** any connections, we can get to it.
 				 */
 				for (Link = 0; Link < LINKS_PER_UNIT; Link++) {
-					if (MapP->Topology[Link].Unit <= (uchar) MAX_RUP) {
+					if (MapP->Topology[Link].Unit <= (u8) MAX_RUP) {
 						/*
 						 ** Its worth trying the operation...
 						 */
@@ -249,7 +250,7 @@
 }
 
 
-int RIOKillNeighbour(struct rio_info *p, caddr_t arg)
+int RIOKillNeighbour(struct rio_info *p, void * arg)
 {
 	uint Host;
 	uint ID;
@@ -258,7 +259,7 @@
 
 	rio_dprintk(RIO_DEBUG_CMD, "KILL HOST NEIGHBOUR\n");
 
-	if (copyin((int) arg, (caddr_t) & KillUnit, sizeof(KillUnit)) == COPYFAIL) {
+	if (copy_from_user(&KillUnit, arg, sizeof(KillUnit))) {
 		rio_dprintk(RIO_DEBUG_CMD, "RIO_KILL_NEIGHBOUR copy failed\n");
 		p->RIOError.Error = COPYIN_FAILED;
 		return -EFAULT;
@@ -344,7 +345,7 @@
 int RIOFoadWakeup(struct rio_info *p)
 {
 	int port;
-	register struct Port *PortP;
+	struct Port *PortP;
 	unsigned long flags;
 
 	for (port = 0; port < RIO_PORTS; port++) {
@@ -379,10 +380,10 @@
 	struct PktCmd *PktCmdP = (struct PktCmd *) PacketP->data;
 	struct Port *PortP;
 	struct UnixRup *UnixRupP;
-	ushort SysPort;
-	ushort ReportedModemStatus;
-	ushort rup;
-	ushort subCommand;
+	unsigned short SysPort;
+	unsigned short ReportedModemStatus;
+	unsigned short rup;
+	unsigned short subCommand;
 	unsigned long flags;
 
 	func_enter();
@@ -395,18 +396,18 @@
 	 ** we can use PhbNum to get the rup number for the appropriate 8 port
 	 ** block (for the first block, this should be equal to 'Rup').
 	 */
-	rup = RBYTE(PktCmdP->PhbNum) / (ushort) PORTS_PER_RTA;
+	rup = readb(&PktCmdP->PhbNum) / (unsigned short) PORTS_PER_RTA;
 	UnixRupP = &HostP->UnixRups[rup];
-	SysPort = UnixRupP->BaseSysPort + (RBYTE(PktCmdP->PhbNum) % (ushort) PORTS_PER_RTA);
+	SysPort = UnixRupP->BaseSysPort + (readb(&PktCmdP->PhbNum) % (unsigned short) PORTS_PER_RTA);
 	rio_dprintk(RIO_DEBUG_CMD, "Command on rup %d, port %d\n", rup, SysPort);
 
 	if (UnixRupP->BaseSysPort == NO_PORT) {
 		rio_dprintk(RIO_DEBUG_CMD, "OBSCURE ERROR!\n");
 		rio_dprintk(RIO_DEBUG_CMD, "Diagnostics follow. Please WRITE THESE DOWN and report them to Specialix Technical Support\n");
-		rio_dprintk(RIO_DEBUG_CMD, "CONTROL information: Host number %d, name ``%s''\n", HostP - p->RIOHosts, HostP->Name);
+		rio_dprintk(RIO_DEBUG_CMD, "CONTROL information: Host number %Zd, name ``%s''\n", HostP - p->RIOHosts, HostP->Name);
 		rio_dprintk(RIO_DEBUG_CMD, "CONTROL information: Rup number  0x%x\n", rup);
 
-		if (Rup >= (ushort) MAX_RUP) {
+		if (Rup >= (unsigned short) MAX_RUP) {
 			rio_dprintk(RIO_DEBUG_CMD, "CONTROL information: This is the RUP for RTA ``%s''\n", HostP->Mapping[Rup].Name);
 		} else
 			rio_dprintk(RIO_DEBUG_CMD, "CONTROL information: This is the RUP for link ``%c'' of host ``%s''\n", ('A' + Rup - MAX_RUP), HostP->Name);
@@ -421,7 +422,7 @@
 	}
 	PortP = p->RIOPortp[SysPort];
 	rio_spin_lock_irqsave(&PortP->portSem, flags);
-	switch (RBYTE(PktCmdP->Command)) {
+	switch (readb(&PktCmdP->Command)) {
 	case BREAK_RECEIVED:
 		rio_dprintk(RIO_DEBUG_CMD, "Received a break!\n");
 		/* If the current line disc. is not multi-threading and
@@ -434,15 +435,15 @@
 		break;
 
 	case COMPLETE:
-		rio_dprintk(RIO_DEBUG_CMD, "Command complete on phb %d host %d\n", RBYTE(PktCmdP->PhbNum), HostP - p->RIOHosts);
+		rio_dprintk(RIO_DEBUG_CMD, "Command complete on phb %d host %Zd\n", readb(&PktCmdP->PhbNum), HostP - p->RIOHosts);
 		subCommand = 1;
-		switch (RBYTE(PktCmdP->SubCommand)) {
+		switch (readb(&PktCmdP->SubCommand)) {
 		case MEMDUMP:
-			rio_dprintk(RIO_DEBUG_CMD, "Memory dump cmd (0x%x) from addr 0x%x\n", RBYTE(PktCmdP->SubCommand), RWORD(PktCmdP->SubAddr));
+			rio_dprintk(RIO_DEBUG_CMD, "Memory dump cmd (0x%x) from addr 0x%x\n", readb(&PktCmdP->SubCommand), readw(&PktCmdP->SubAddr));
 			break;
 		case READ_REGISTER:
-			rio_dprintk(RIO_DEBUG_CMD, "Read register (0x%x)\n", RWORD(PktCmdP->SubAddr));
-			p->CdRegister = (RBYTE(PktCmdP->ModemStatus) & MSVR1_HOST);
+			rio_dprintk(RIO_DEBUG_CMD, "Read register (0x%x)\n", readw(&PktCmdP->SubAddr));
+			p->CdRegister = (readb(&PktCmdP->ModemStatus) & MSVR1_HOST);
 			break;
 		default:
 			subCommand = 0;
@@ -450,10 +451,10 @@
 		}
 		if (subCommand)
 			break;
-		rio_dprintk(RIO_DEBUG_CMD, "New status is 0x%x was 0x%x\n", RBYTE(PktCmdP->PortStatus), PortP->PortState);
-		if (PortP->PortState != RBYTE(PktCmdP->PortStatus)) {
+		rio_dprintk(RIO_DEBUG_CMD, "New status is 0x%x was 0x%x\n", readb(&PktCmdP->PortStatus), PortP->PortState);
+		if (PortP->PortState != readb(&PktCmdP->PortStatus)) {
 			rio_dprintk(RIO_DEBUG_CMD, "Mark status & wakeup\n");
-			PortP->PortState = RBYTE(PktCmdP->PortStatus);
+			PortP->PortState = readb(&PktCmdP->PortStatus);
 			/* What should we do here ...
 			   wakeup( &PortP->PortState );
 			 */
@@ -467,7 +468,7 @@
 		 ** to the check for modem status change (they're just there because
 		 ** it's a convenient place to put them!).
 		 */
-		ReportedModemStatus = RBYTE(PktCmdP->ModemStatus);
+		ReportedModemStatus = readb(&PktCmdP->ModemStatus);
 		if ((PortP->ModemState & MSVR1_HOST) == (ReportedModemStatus & MSVR1_HOST)) {
 			rio_dprintk(RIO_DEBUG_CMD, "Modem status unchanged 0x%x\n", PortP->ModemState);
 			/*
@@ -514,9 +515,6 @@
 							 */
 							if (PortP->State & (PORT_ISOPEN | RIO_WOPEN))
 								wake_up_interruptible(&PortP->gs.open_wait);
-#ifdef STATS
-							PortP->Stat.ModemOnCnt++;
-#endif
 						}
 					} else {
 						/*
@@ -527,9 +525,6 @@
 								tty_hangup(PortP->gs.tty);
 							PortP->State &= ~RIO_CARR_ON;
 							rio_dprintk(RIO_DEBUG_CMD, "Carrirer just went down\n");
-#ifdef STATS
-							PortP->Stat.ModemOffCnt++;
-#endif
 						}
 					}
 				}
@@ -539,7 +534,7 @@
 		break;
 
 	default:
-		rio_dprintk(RIO_DEBUG_CMD, "Unknown command %d on CMD_RUP of host %d\n", RBYTE(PktCmdP->Command), HostP - p->RIOHosts);
+		rio_dprintk(RIO_DEBUG_CMD, "Unknown command %d on CMD_RUP of host %Zd\n", readb(&PktCmdP->Command), HostP - p->RIOHosts);
 		break;
 	}
 	rio_spin_unlock_irqrestore(&PortP->portSem, flags);
@@ -566,10 +561,9 @@
 {
 	struct CmdBlk *CmdBlkP;
 
-	CmdBlkP = (struct CmdBlk *) sysbrk(sizeof(struct CmdBlk));
+	CmdBlkP = (struct CmdBlk *)kmalloc(sizeof(struct CmdBlk), GFP_ATOMIC);
 	if (CmdBlkP)
-		bzero(CmdBlkP, sizeof(struct CmdBlk));
-
+		memset(CmdBlkP, 0, sizeof(struct CmdBlk));
 	return CmdBlkP;
 }
 
@@ -578,7 +572,7 @@
 */
 void RIOFreeCmdBlk(struct CmdBlk *CmdBlkP)
 {
-	sysfree((void *) CmdBlkP, sizeof(struct CmdBlk));
+	kfree(CmdBlkP);
 }
 
 /*
@@ -591,7 +585,7 @@
 	struct UnixRup *UnixRupP;
 	unsigned long flags;
 
-	if (Rup >= (ushort) (MAX_RUP + LINKS_PER_UNIT)) {
+	if (Rup >= (unsigned short) (MAX_RUP + LINKS_PER_UNIT)) {
 		rio_dprintk(RIO_DEBUG_CMD, "Illegal rup number %d in RIOQueueCmdBlk\n", Rup);
 		RIOFreeCmdBlk(CmdBlkP);
 		return RIO_FAIL;
@@ -605,7 +599,7 @@
 	 ** If the RUP is currently inactive, then put the request
 	 ** straight on the RUP....
 	 */
-	if ((UnixRupP->CmdsWaitingP == NULL) && (UnixRupP->CmdPendingP == NULL) && (RWORD(UnixRupP->RupP->txcontrol) == TX_RUP_INACTIVE) && (CmdBlkP->PreFuncP ? (*CmdBlkP->PreFuncP) (CmdBlkP->PreArg, CmdBlkP)
+	if ((UnixRupP->CmdsWaitingP == NULL) && (UnixRupP->CmdPendingP == NULL) && (readw(&UnixRupP->RupP->txcontrol) == TX_RUP_INACTIVE) && (CmdBlkP->PreFuncP ? (*CmdBlkP->PreFuncP) (CmdBlkP->PreArg, CmdBlkP)
 																	     : TRUE)) {
 		rio_dprintk(RIO_DEBUG_CMD, "RUP inactive-placing command straight on. Cmd byte is 0x%x\n", CmdBlkP->Packet.data[0]);
 
@@ -622,7 +616,7 @@
 		/*
 		 ** set the command register
 		 */
-		WWORD(UnixRupP->RupP->txcontrol, TX_PACKET_READY);
+		writew(TX_PACKET_READY, &UnixRupP->RupP->txcontrol);
 
 		rio_spin_unlock_irqrestore(&UnixRupP->RupLock, flags);
 
@@ -634,20 +628,20 @@
 		rio_dprintk(RIO_DEBUG_CMD, "Rup active - command waiting\n");
 	if (UnixRupP->CmdPendingP != NULL)
 		rio_dprintk(RIO_DEBUG_CMD, "Rup active - command pending\n");
-	if (RWORD(UnixRupP->RupP->txcontrol) != TX_RUP_INACTIVE)
+	if (readw(&UnixRupP->RupP->txcontrol) != TX_RUP_INACTIVE)
 		rio_dprintk(RIO_DEBUG_CMD, "Rup active - command rup not ready\n");
 
 	Base = &UnixRupP->CmdsWaitingP;
 
-	rio_dprintk(RIO_DEBUG_CMD, "First try to queue cmdblk 0x%x at 0x%x\n", (int) CmdBlkP, (int) Base);
+	rio_dprintk(RIO_DEBUG_CMD, "First try to queue cmdblk 0x%p at 0x%p\n", CmdBlkP, Base);
 
 	while (*Base) {
-		rio_dprintk(RIO_DEBUG_CMD, "Command cmdblk 0x%x here\n", (int) (*Base));
+		rio_dprintk(RIO_DEBUG_CMD, "Command cmdblk 0x%p here\n", *Base);
 		Base = &((*Base)->NextP);
-		rio_dprintk(RIO_DEBUG_CMD, "Now try to queue cmd cmdblk 0x%x at 0x%x\n", (int) CmdBlkP, (int) Base);
+		rio_dprintk(RIO_DEBUG_CMD, "Now try to queue cmd cmdblk 0x%p at 0x%p\n", CmdBlkP, Base);
 	}
 
-	rio_dprintk(RIO_DEBUG_CMD, "Will queue cmdblk 0x%x at 0x%x\n", (int) CmdBlkP, (int) Base);
+	rio_dprintk(RIO_DEBUG_CMD, "Will queue cmdblk 0x%p at 0x%p\n", CmdBlkP, Base);
 
 	*Base = CmdBlkP;
 
@@ -664,10 +658,10 @@
 */
 void RIOPollHostCommands(struct rio_info *p, struct Host *HostP)
 {
-	register struct CmdBlk *CmdBlkP;
-	register struct UnixRup *UnixRupP;
+	struct CmdBlk *CmdBlkP;
+	struct UnixRup *UnixRupP;
 	struct PKT *PacketP;
-	ushort Rup;
+	unsigned short Rup;
 	unsigned long flags;
 
 
@@ -684,16 +678,16 @@
 		/*
 		 ** First check for incoming commands:
 		 */
-		if (RWORD(UnixRupP->RupP->rxcontrol) != RX_RUP_INACTIVE) {
+		if (readw(&UnixRupP->RupP->rxcontrol) != RX_RUP_INACTIVE) {
 			int FreeMe;
 
-			PacketP = (PKT *) RIO_PTR(HostP->Caddr, RWORD(UnixRupP->RupP->rxpkt));
+			PacketP = (PKT *) RIO_PTR(HostP->Caddr, readw(&UnixRupP->RupP->rxpkt));
 
 			ShowPacket(DBG_CMD, PacketP);
 
-			switch (RBYTE(PacketP->dest_port)) {
+			switch (readb(&PacketP->dest_port)) {
 			case BOOT_RUP:
-				rio_dprintk(RIO_DEBUG_CMD, "Incoming Boot %s packet '%x'\n", RBYTE(PacketP->len) & 0x80 ? "Command" : "Data", RBYTE(PacketP->data[0]));
+				rio_dprintk(RIO_DEBUG_CMD, "Incoming Boot %s packet '%x'\n", readb(&PacketP->len) & 0x80 ? "Command" : "Data", readb(&PacketP->data[0]));
 				rio_spin_unlock_irqrestore(&UnixRupP->RupLock, flags);
 				FreeMe = RIOBootRup(p, Rup, HostP, PacketP);
 				rio_spin_lock_irqsave(&UnixRupP->RupLock, flags);
@@ -708,7 +702,7 @@
 				rio_spin_unlock_irqrestore(&UnixRupP->RupLock, flags);
 				FreeMe = RIOCommandRup(p, Rup, HostP, PacketP);
 				if (PacketP->data[5] == MEMDUMP) {
-					rio_dprintk(RIO_DEBUG_CMD, "Memdump from 0x%x complete\n", *(ushort *) & (PacketP->data[6]));
+					rio_dprintk(RIO_DEBUG_CMD, "Memdump from 0x%x complete\n", *(unsigned short *) & (PacketP->data[6]));
 					HostP->Copy((caddr_t) & (PacketP->data[8]), (caddr_t) p->RIOMemDump, 32);
 				}
 				rio_spin_lock_irqsave(&UnixRupP->RupLock, flags);
@@ -721,7 +715,7 @@
 				break;
 
 			default:
-				rio_dprintk(RIO_DEBUG_CMD, "Unknown RUP %d\n", RBYTE(PacketP->dest_port));
+				rio_dprintk(RIO_DEBUG_CMD, "Unknown RUP %d\n", readb(&PacketP->dest_port));
 				FreeMe = 1;
 				break;
 			}
@@ -730,11 +724,11 @@
 				rio_dprintk(RIO_DEBUG_CMD, "Free processed incoming command packet\n");
 				put_free_end(HostP, PacketP);
 
-				WWORD(UnixRupP->RupP->rxcontrol, RX_RUP_INACTIVE);
+				writew(RX_RUP_INACTIVE, &UnixRupP->RupP->rxcontrol);
 
-				if (RWORD(UnixRupP->RupP->handshake) == PHB_HANDSHAKE_SET) {
+				if (readw(&UnixRupP->RupP->handshake) == PHB_HANDSHAKE_SET) {
 					rio_dprintk(RIO_DEBUG_CMD, "Handshake rup %d\n", Rup);
-					WWORD(UnixRupP->RupP->handshake, PHB_HANDSHAKE_SET | PHB_HANDSHAKE_RESET);
+					writew(PHB_HANDSHAKE_SET | PHB_HANDSHAKE_RESET, &UnixRupP->RupP->handshake);
 				}
 			}
 		}
@@ -744,7 +738,7 @@
 		 ** and it has completed, then tidy it up.
 		 */
 		if ((CmdBlkP = UnixRupP->CmdPendingP) &&	/* ASSIGN! */
-		    (RWORD(UnixRupP->RupP->txcontrol) == TX_RUP_INACTIVE)) {
+		    (readw(&UnixRupP->RupP->txcontrol) == TX_RUP_INACTIVE)) {
 			/*
 			 ** we are idle.
 			 ** there is a command in pending.
@@ -755,7 +749,7 @@
 			if (CmdBlkP->Packet.dest_port == BOOT_RUP)
 				rio_dprintk(RIO_DEBUG_CMD, "Free Boot %s Command Block '%x'\n", CmdBlkP->Packet.len & 0x80 ? "Command" : "Data", CmdBlkP->Packet.data[0]);
 
-			rio_dprintk(RIO_DEBUG_CMD, "Command 0x%x completed\n", (int) CmdBlkP);
+			rio_dprintk(RIO_DEBUG_CMD, "Command 0x%p completed\n", CmdBlkP);
 
 			/*
 			 ** Clear the Rup lock to prevent mutual exclusion.
@@ -782,16 +776,16 @@
 		 ** is idle, then process the command
 		 */
 		if ((CmdBlkP = UnixRupP->CmdsWaitingP) &&	/* ASSIGN! */
-		    (UnixRupP->CmdPendingP == NULL) && (RWORD(UnixRupP->RupP->txcontrol) == TX_RUP_INACTIVE)) {
+		    (UnixRupP->CmdPendingP == NULL) && (readw(&UnixRupP->RupP->txcontrol) == TX_RUP_INACTIVE)) {
 			/*
 			 ** if the pre-function is non-zero, call it.
 			 ** If it returns RIO_FAIL then don't
 			 ** send this command yet!
 			 */
 			if (!(CmdBlkP->PreFuncP ? (*CmdBlkP->PreFuncP) (CmdBlkP->PreArg, CmdBlkP) : TRUE)) {
-				rio_dprintk(RIO_DEBUG_CMD, "Not ready to start command 0x%x\n", (int) CmdBlkP);
+				rio_dprintk(RIO_DEBUG_CMD, "Not ready to start command 0x%p\n", CmdBlkP);
 			} else {
-				rio_dprintk(RIO_DEBUG_CMD, "Start new command 0x%x Cmd byte is 0x%x\n", (int) CmdBlkP, CmdBlkP->Packet.data[0]);
+				rio_dprintk(RIO_DEBUG_CMD, "Start new command 0x%p Cmd byte is 0x%x\n", CmdBlkP, CmdBlkP->Packet.data[0]);
 				/*
 				 ** Whammy! blat that pack!
 				 */
@@ -810,7 +804,7 @@
 				/*
 				 ** set the command register
 				 */
-				WWORD(UnixRupP->RupP->txcontrol, TX_PACKET_READY);
+				writew(TX_PACKET_READY, &UnixRupP->RupP->txcontrol);
 
 				/*
 				 ** the command block will be freed
@@ -822,7 +816,7 @@
 	} while (Rup);
 }
 
-int RIOWFlushMark(int iPortP, struct CmdBlk *CmdBlkP)
+int RIOWFlushMark(unsigned long iPortP, struct CmdBlk *CmdBlkP)
 {
 	struct Port *PortP = (struct Port *) iPortP;
 	unsigned long flags;
@@ -834,7 +828,7 @@
 	return RIOUnUse(iPortP, CmdBlkP);
 }
 
-int RIORFlushEnable(int iPortP, struct CmdBlk *CmdBlkP)
+int RIORFlushEnable(unsigned long iPortP, struct CmdBlk *CmdBlkP)
 {
 	struct Port *PortP = (struct Port *) iPortP;
 	PKT *PacketP;
@@ -848,19 +842,19 @@
 		put_free_end(PortP->HostP, PacketP);
 	}
 
-	if (RWORD(PortP->PhbP->handshake) == PHB_HANDSHAKE_SET) {
+	if (readw(&PortP->PhbP->handshake) == PHB_HANDSHAKE_SET) {
 		/*
 		 ** MAGIC! (Basically, handshake the RX buffer, so that
 		 ** the RTAs upstream can be re-enabled.)
 		 */
 		rio_dprintk(RIO_DEBUG_CMD, "Util: Set RX handshake bit\n");
-		WWORD(PortP->PhbP->handshake, PHB_HANDSHAKE_SET | PHB_HANDSHAKE_RESET);
+		writew(PHB_HANDSHAKE_SET | PHB_HANDSHAKE_RESET, &PortP->PhbP->handshake);
 	}
 	rio_spin_unlock_irqrestore(&PortP->portSem, flags);
 	return RIOUnUse(iPortP, CmdBlkP);
 }
 
-int RIOUnUse(int iPortP, struct CmdBlk *CmdBlkP)
+int RIOUnUse(unsigned long iPortP, struct CmdBlk *CmdBlkP)
 {
 	struct Port *PortP = (struct Port *) iPortP;
 	unsigned long flags;
@@ -890,7 +884,7 @@
 	 ** When PortP->InUse becomes NOT_INUSE, we must ensure that any data
 	 ** hanging around in the transmit buffer is sent immediately.
 	 */
-	WWORD(PortP->HostP->ParmMapP->tx_intr, 1);
+	writew(1, &PortP->HostP->ParmMapP->tx_intr);
 	/* What to do here ..
 	   wakeup( (caddr_t)&(PortP->InUse) );
 	 */
diff -u --new-file --recursive --exclude-from /usr/src/exclude linux.vanilla-2.6.16-rc6-mm1/drivers/char/rio/rio.h linux-2.6.16-rc6-mm1/drivers/char/rio/rio.h
--- linux.vanilla-2.6.16-rc6-mm1/drivers/char/rio/rio.h	2006-03-14 12:59:37.000000000 +0000
+++ linux-2.6.16-rc6-mm1/drivers/char/rio/rio.h	2006-03-14 17:18:47.000000000 +0000
@@ -186,8 +186,8 @@
 **	RIO_OBJ takes hostp->Caddr and a UNIX pointer to an object and
 **	returns the offset into the DP RAM area.
 */
-#define	RIO_PTR(C,O) (((caddr_t)(C))+(0xFFFF&(O)))
-#define	RIO_OFF(C,O) ((int)(O)-(int)(C))
+#define	RIO_PTR(C,O) (((unsigned char *)(C))+(0xFFFF&(O)))
+#define	RIO_OFF(C,O) ((long)(O)-(long)(C))
 
 /*
 **	How to convert from various different device number formats:
diff -u --new-file --recursive --exclude-from /usr/src/exclude linux.vanilla-2.6.16-rc6-mm1/drivers/char/rio/rioinit.c linux-2.6.16-rc6-mm1/drivers/char/rio/rioinit.c
--- linux.vanilla-2.6.16-rc6-mm1/drivers/char/rio/rioinit.c	2006-03-14 12:59:37.000000000 +0000
+++ linux-2.6.16-rc6-mm1/drivers/char/rio/rioinit.c	2006-03-14 21:51:55.000000000 +0000
@@ -82,9 +82,6 @@
 #include "rioioctl.h"
 #include "rio_linux.h"
 
-#undef bcopy
-#define bcopy rio_pcicopy
-
 int RIOPCIinit(struct rio_info *p, int Mode);
 
 static int RIOScrub(int, BYTE *, int);
@@ -99,12 +96,8 @@
 ** bits < 0 indicates 8 bit operation requested,
 ** bits > 0 indicates 16 bit operation.
 */
-int
-RIOAssignAT(p, Base, virtAddr, mode)
-struct rio_info *	p;
-int		Base;
-caddr_t	virtAddr;
-int		mode;
+
+int RIOAssignAT(struct rio_info *p, int	Base, caddr_t	virtAddr, int mode)
 {
 	int		bits;
 	struct DpRam *cardp = (struct DpRam *)virtAddr;
@@ -124,29 +117,25 @@
 	/*
 	** Revision 01 AT host cards don't support WORD operations,
 	*/
-	if ( RBYTE(cardp->DpRevision) == 01 )
+	if (readb(&cardp->DpRevision) == 01)
 		bits = BYTE_OPERATION;
 
 	p->RIOHosts[p->RIONumHosts].Type = RIO_AT;
-	p->RIOHosts[p->RIONumHosts].Copy = bcopy;
+	p->RIOHosts[p->RIONumHosts].Copy = rio_copy_to_card;
 											/* set this later */
 	p->RIOHosts[p->RIONumHosts].Slot = -1;
 	p->RIOHosts[p->RIONumHosts].Mode = SLOW_LINKS | SLOW_AT_BUS | bits;
-	WBYTE(p->RIOHosts[p->RIONumHosts].Control, 
-			BOOT_FROM_RAM | EXTERNAL_BUS_OFF | 
-			p->RIOHosts[p->RIONumHosts].Mode | 
-			INTERRUPT_DISABLE );
-	WBYTE(p->RIOHosts[p->RIONumHosts].ResetInt,0xff);
-	WBYTE(p->RIOHosts[p->RIONumHosts].Control,
-			BOOT_FROM_RAM | EXTERNAL_BUS_OFF | 
-			p->RIOHosts[p->RIONumHosts].Mode |
-			INTERRUPT_DISABLE );
-	WBYTE(p->RIOHosts[p->RIONumHosts].ResetInt,0xff);
+	writeb(BOOT_FROM_RAM | EXTERNAL_BUS_OFF | p->RIOHosts[p->RIONumHosts].Mode | INTERRUPT_DISABLE , 
+		&p->RIOHosts[p->RIONumHosts].Control);
+	writeb(0xFF, &p->RIOHosts[p->RIONumHosts].ResetInt);
+	writeb(BOOT_FROM_RAM | EXTERNAL_BUS_OFF | p->RIOHosts[p->RIONumHosts].Mode | INTERRUPT_DISABLE,
+		&p->RIOHosts[p->RIONumHosts].Control);
+	writeb(0xFF, &p->RIOHosts[p->RIONumHosts].ResetInt);
 	p->RIOHosts[p->RIONumHosts].UniqueNum =
-		((RBYTE(p->RIOHosts[p->RIONumHosts].Unique[0])&0xFF)<<0)|
-		((RBYTE(p->RIOHosts[p->RIONumHosts].Unique[1])&0xFF)<<8)|
-		((RBYTE(p->RIOHosts[p->RIONumHosts].Unique[2])&0xFF)<<16)|
-		((RBYTE(p->RIOHosts[p->RIONumHosts].Unique[3])&0xFF)<<24);
+		((readb(&p->RIOHosts[p->RIONumHosts].Unique[0])&0xFF)<<0)|
+		((readb(&p->RIOHosts[p->RIONumHosts].Unique[1])&0xFF)<<8)|
+		((readb(&p->RIOHosts[p->RIONumHosts].Unique[2])&0xFF)<<16)|
+		((readb(&p->RIOHosts[p->RIONumHosts].Unique[3])&0xFF)<<24);
 	rio_dprintk (RIO_DEBUG_INIT, "RIO-init: Uniquenum 0x%x\n",p->RIOHosts[p->RIONumHosts].UniqueNum);
 
 	p->RIONumHosts++;
@@ -154,7 +143,7 @@
 	return(1);
 }
 
-static	uchar	val[] = {
+static	u8	val[] = {
 #ifdef VERY_LONG_TEST
 	  0x00, 0x01, 0x02, 0x04, 0x08, 0x10, 0x20, 0x40, 0x80,
 	  0xa5, 0xff, 0x5a, 0x00, 0xff, 0xc9, 0x36, 
@@ -167,12 +156,7 @@
 ** RAM test a board. 
 ** Nothing too complicated, just enough to check it out.
 */
-int
-RIOBoardTest(paddr, caddr, type, slot)
-paddr_t	paddr;
-caddr_t	caddr;
-uchar	type;
-int		slot;
+int RIOBoardTest(paddr_t paddr, caddr_t	caddr, unsigned char type, int slot)
 {
 	struct DpRam *DpRam = (struct DpRam *)caddr;
 	char *ram[4];
@@ -180,8 +164,8 @@
 	int  op, bank;
 	int  nbanks;
 
-	rio_dprintk (RIO_DEBUG_INIT, "RIO-init: Reset host type=%d, DpRam=0x%x, slot=%d\n",
-			type,(int)DpRam, slot);
+	rio_dprintk (RIO_DEBUG_INIT, "RIO-init: Reset host type=%d, DpRam=0x%p, slot=%d\n",
+			type, DpRam, slot);
 
 	RIOHostReset(type, DpRam, slot);
 
@@ -209,12 +193,11 @@
 
 
 	if (nbanks == 3) {
-		rio_dprintk (RIO_DEBUG_INIT, "RIO-init: Memory: 0x%x(0x%x), 0x%x(0x%x), 0x%x(0x%x)\n",
-				(int)ram[0], size[0], (int)ram[1], size[1], (int)ram[2], size[2]);
+		rio_dprintk (RIO_DEBUG_INIT, "RIO-init: Memory: 0x%p(0x%x), 0x%p(0x%x), 0x%p(0x%x)\n",
+				ram[0], size[0], ram[1], size[1], ram[2], size[2]);
 	} else {
-		rio_dprintk (RIO_DEBUG_INIT, "RIO-init: 0x%x(0x%x), 0x%x(0x%x), 0x%x(0x%x), 0x%x(0x%x)\n",
-			(int)ram[0], size[0], (int)ram[1], size[1], (int)ram[2], size[2], (int)ram[3], 
-					size[3]);
+		rio_dprintk (RIO_DEBUG_INIT, "RIO-init: 0x%p(0x%x), 0x%p(0x%x), 0x%p(0x%x), 0x%p(0x%x)\n",
+				ram[0], size[0], ram[1], size[1], ram[2], size[2], ram[3], size[3]);
 	}
 
 	/*
@@ -248,13 +231,10 @@
 ** Call with op not zero, and the RAM will be read and compated with val[op-1]
 ** to check that the data from the previous phase was retained.
 */
-static int
-RIOScrub(op, ram, size)
-int		op;
-BYTE *	ram;
-int		size; 
+
+static int RIOScrub(int op, BYTE *ram, int size)
 {
-	int				off;
+	int off;
 	unsigned char	oldbyte;
 	unsigned char	newbyte;
 	unsigned char	invbyte;
@@ -279,15 +259,15 @@
 	*/
 	if (op) {
 		for (off=0; off<size; off++) {
-			if (RBYTE(ram[off]) != oldbyte) {
-				rio_dprintk (RIO_DEBUG_INIT, "RIO-init: Byte Pre Check 1: BYTE at offset 0x%x should have been=%x, was=%x\n", off, oldbyte, RBYTE(ram[off]));
+			if (readb(ram + off) != oldbyte) {
+				rio_dprintk (RIO_DEBUG_INIT, "RIO-init: Byte Pre Check 1: BYTE at offset 0x%x should have been=%x, was=%x\n", off, oldbyte, readb(ram + off));
 				return RIO_FAIL;
 			}
 		}
 		for (off=0; off<size; off+=2) {
-			if (*(ushort *)&ram[off] != oldword) {
-				rio_dprintk (RIO_DEBUG_INIT, "RIO-init: Word Pre Check: WORD at offset 0x%x should have been=%x, was=%x\n",off,oldword,*(ushort *)&ram[off]);
-				rio_dprintk (RIO_DEBUG_INIT, "RIO-init: Word Pre Check: BYTE at offset 0x%x is %x BYTE at offset 0x%x is %x\n", off, RBYTE(ram[off]), off+1, RBYTE(ram[off+1]));
+			if (readw(ram + off) != oldword) {
+				rio_dprintk (RIO_DEBUG_INIT, "RIO-init: Word Pre Check: WORD at offset 0x%x should have been=%x, was=%x\n",off,oldword, readw(ram + off));
+				rio_dprintk (RIO_DEBUG_INIT, "RIO-init: Word Pre Check: BYTE at offset 0x%x is %x BYTE at offset 0x%x is %x\n", off, readb(ram + off), off+1, readb(ram+off+1));
 				return RIO_FAIL;
 			}
 		}
@@ -301,13 +281,13 @@
 	** the BYTE read/write test.
 	*/
 	for (off=0; off<size; off++) {
-		if (op && (RBYTE(ram[off]) != oldbyte)) {
-			rio_dprintk (RIO_DEBUG_INIT, "RIO-init: Byte Pre Check 2: BYTE at offset 0x%x should have been=%x, was=%x\n", off, oldbyte, RBYTE(ram[off]));
+		if (op && (readb(ram + off) != oldbyte)) {
+			rio_dprintk (RIO_DEBUG_INIT, "RIO-init: Byte Pre Check 2: BYTE at offset 0x%x should have been=%x, was=%x\n", off, oldbyte, readb(ram + off));
 			return RIO_FAIL;
 		}
-		WBYTE(ram[off],invbyte);
-		if (RBYTE(ram[off]) != invbyte) {
-			rio_dprintk (RIO_DEBUG_INIT, "RIO-init: Byte Inv Check: BYTE at offset 0x%x should have been=%x, was=%x\n", off, invbyte, RBYTE(ram[off]));
+		writeb(invbyte, ram + off);
+		if (readb(ram + off) != invbyte) {
+			rio_dprintk (RIO_DEBUG_INIT, "RIO-init: Byte Inv Check: BYTE at offset 0x%x should have been=%x, was=%x\n", off, invbyte, readb(ram + off));
 			return RIO_FAIL;
 		}
 	}
@@ -320,16 +300,16 @@
 	** This is the WORD operation test.
 	*/
 	for (off=0; off<size; off+=2) {
-		if (*(ushort *)&ram[off] != invword) {
-			rio_dprintk (RIO_DEBUG_INIT, "RIO-init: Word Inv Check: WORD at offset 0x%x should have been=%x, was=%x\n", off, invword, *(ushort *)&ram[off]);
-		rio_dprintk (RIO_DEBUG_INIT, "RIO-init: Word Inv Check: BYTE at offset 0x%x is %x BYTE at offset 0x%x is %x\n", off, RBYTE(ram[off]), off+1, RBYTE(ram[off+1]));
+		if (readw(ram + off) != invword) {
+			rio_dprintk (RIO_DEBUG_INIT, "RIO-init: Word Inv Check: WORD at offset 0x%x should have been=%x, was=%x\n", off, invword, readw(ram + off));
+			rio_dprintk (RIO_DEBUG_INIT, "RIO-init: Word Inv Check: BYTE at offset 0x%x is %x BYTE at offset 0x%x is %x\n", off, readb(ram + off), off+1, readb(ram+off+1));
 			return RIO_FAIL;
 		}
 
-		*(ushort *)&ram[off] = newword;
-		if ( *(ushort *)&ram[off] != newword ) {
-			rio_dprintk (RIO_DEBUG_INIT, "RIO-init: Post Word Check 1: WORD at offset 0x%x should have been=%x, was=%x\n", off, newword, *(ushort *)&ram[off]);
-			rio_dprintk (RIO_DEBUG_INIT, "RIO-init: Post Word Check 1: BYTE at offset 0x%x is %x BYTE at offset 0x%x is %x\n", off, RBYTE(ram[off]), off+1, RBYTE(ram[off+1]));
+		writew(newword, ram + off);
+		if ( readw(ram + off) != newword ) {
+			rio_dprintk (RIO_DEBUG_INIT, "RIO-init: Post Word Check 1: WORD at offset 0x%x should have been=%x, was=%x\n", off, newword, readw(ram + off));
+			rio_dprintk (RIO_DEBUG_INIT, "RIO-init: Post Word Check 1: BYTE at offset 0x%x is %x BYTE at offset 0x%x is %x\n", off, readb(ram + off), off+1, readb(ram + off + 1));
 			return RIO_FAIL;
 		}
 	}
@@ -340,16 +320,16 @@
 	** required test data.
 	*/
 	for (off=0; off<size; off++) {
-		if (RBYTE(ram[off]) != newbyte) {
-			rio_dprintk (RIO_DEBUG_INIT, "RIO-init: Post Byte Check: BYTE at offset 0x%x should have been=%x, was=%x\n", off, newbyte, RBYTE(ram[off]));
+		if (readb(ram + off) != newbyte) {
+			rio_dprintk (RIO_DEBUG_INIT, "RIO-init: Post Byte Check: BYTE at offset 0x%x should have been=%x, was=%x\n", off, newbyte, readb(ram + off));
 			return RIO_FAIL;
 		}
 	}
 
 	for (off=0; off<size; off+=2) {
-		if ( *(ushort *)&ram[off] != newword ) {
-			rio_dprintk (RIO_DEBUG_INIT, "RIO-init: Post Word Check 2: WORD at offset 0x%x should have been=%x, was=%x\n", off, newword, *(ushort *)&ram[off]);
-			rio_dprintk (RIO_DEBUG_INIT, "RIO-init: Post Word Check 2: BYTE at offset 0x%x is %x BYTE at offset 0x%x is %x\n", off, RBYTE(ram[off]), off+1, RBYTE(ram[off+1]));
+		if (readw(ram + off) != newword ) {
+			rio_dprintk (RIO_DEBUG_INIT, "RIO-init: Post Word Check 2: WORD at offset 0x%x should have been=%x, was=%x\n", off, newword, readw(ram + off));
+			rio_dprintk (RIO_DEBUG_INIT, "RIO-init: Post Word Check 2: BYTE at offset 0x%x is %x BYTE at offset 0x%x is %x\n", off, readb(ram + off), off+1, readb(ram + off + 1));
 			return RIO_FAIL;
 		}
 	}
@@ -360,41 +340,37 @@
 	swapword = invbyte | (newbyte << 8);
 
 	for (off=0; off<size; off+=2) {
-		WBYTE(ram[off],invbyte);
-		WBYTE(ram[off+1],newbyte);
+		writeb(invbyte, &ram[off]);
+		writeb(newbyte, &ram[off+1]);
 	}
 
 	for ( off=0; off<size; off+=2 ) {
-		if (*(ushort *)&ram[off] != swapword) {
-			rio_dprintk (RIO_DEBUG_INIT, "RIO-init: SwapWord Check 1: WORD at offset 0x%x should have been=%x, was=%x\n", off, swapword, *((ushort *)&ram[off]));
-			rio_dprintk (RIO_DEBUG_INIT, "RIO-init: SwapWord Check 1: BYTE at offset 0x%x is %x BYTE at offset 0x%x is %x\n", off, RBYTE(ram[off]), off+1, RBYTE(ram[off+1]));
+		if (readw(ram + off) != swapword) {
+			rio_dprintk (RIO_DEBUG_INIT, "RIO-init: SwapWord Check 1: WORD at offset 0x%x should have been=%x, was=%x\n", off, swapword, readw(ram + off));
+			rio_dprintk (RIO_DEBUG_INIT, "RIO-init: SwapWord Check 1: BYTE at offset 0x%x is %x BYTE at offset 0x%x is %x\n", off, readb(ram + off), off+1, readb(ram + off + 1));
 			return RIO_FAIL;
 		}
-		*((ushort *)&ram[off]) = ~swapword;
+		writew(~swapword, ram + off);
 	}
 
 	for (off=0; off<size; off+=2) {
-		if (RBYTE(ram[off]) != newbyte) {
-			rio_dprintk (RIO_DEBUG_INIT, "RIO-init: SwapWord Check 2: BYTE at offset 0x%x should have been=%x, was=%x\n", off, newbyte, RBYTE(ram[off]));
+		if (readb(ram + off) != newbyte) {
+			rio_dprintk (RIO_DEBUG_INIT, "RIO-init: SwapWord Check 2: BYTE at offset 0x%x should have been=%x, was=%x\n", off, newbyte, readb(ram + off));
 			return RIO_FAIL;
 		}
-		if (RBYTE(ram[off+1]) != invbyte) {
-			rio_dprintk (RIO_DEBUG_INIT, "RIO-init: SwapWord Check 2: BYTE at offset 0x%x should have been=%x, was=%x\n", off+1, invbyte, RBYTE(ram[off+1]));
+		if (readb(ram + off + 1) != invbyte) {
+			rio_dprintk (RIO_DEBUG_INIT, "RIO-init: SwapWord Check 2: BYTE at offset 0x%x should have been=%x, was=%x\n", off+1, invbyte, readb(ram + off + 1));
 			return RIO_FAIL;
 		}
-		*((ushort *)&ram[off]) = newword;
+		writew(newword, ram + off);
 	}
 	return RIO_SUCCESS;
 }
 
 
-int
-RIODefaultName(p, HostP, UnitId)
-struct rio_info *	p;
-struct Host *	HostP;
-uint			UnitId;
+int RIODefaultName(struct rio_info *p, struct Host *HostP, unsigned int	UnitId)
 {
-	bcopy("UNKNOWN RTA X-XX",HostP->Mapping[UnitId].Name,17);
+	memcpy(HostP->Mapping[UnitId].Name, "UNKNOWN RTA X-XX", 17);
 	HostP->Mapping[UnitId].Name[12]='1'+(HostP-p->RIOHosts);
 	if ((UnitId+1) > 9) {
 		HostP->Mapping[UnitId].Name[14]='0'+((UnitId+1)/10);
@@ -412,8 +388,7 @@
 
 static struct rioVersion	stVersion;
 
-struct rioVersion *
-RIOVersid(void)
+struct rioVersion *RIOVersid(void)
 {
     strlcpy(stVersion.version, "RIO driver for linux V1.0",
 	    sizeof(stVersion.version));
@@ -423,40 +398,31 @@
     return &stVersion;
 }
 
-void
-RIOHostReset(Type, DpRamP, Slot)
-uint Type;
-volatile struct DpRam *DpRamP;
-uint Slot; 
+void RIOHostReset(unsigned int Type, struct DpRam *DpRamP, unsigned int Slot)
 {
 	/*
 	** Reset the Tpu
 	*/
 	rio_dprintk (RIO_DEBUG_INIT,  "RIOHostReset: type 0x%x", Type);
 	switch ( Type ) {
-		case RIO_AT:
-			rio_dprintk (RIO_DEBUG_INIT, " (RIO_AT)\n");
-			WBYTE(DpRamP->DpControl,  BOOT_FROM_RAM | EXTERNAL_BUS_OFF | 
-					  INTERRUPT_DISABLE | BYTE_OPERATION |
-					  SLOW_LINKS | SLOW_AT_BUS);
-			WBYTE(DpRamP->DpResetTpu, 0xFF);
-			udelay(3);
-
+	case RIO_AT:
+		rio_dprintk (RIO_DEBUG_INIT, " (RIO_AT)\n");
+		writeb(BOOT_FROM_RAM | EXTERNAL_BUS_OFF | INTERRUPT_DISABLE | BYTE_OPERATION |
+			SLOW_LINKS | SLOW_AT_BUS, &DpRamP->DpControl);
+		writeb(0xFF, &DpRamP->DpResetTpu);
+		udelay(3);
 			rio_dprintk (RIO_DEBUG_INIT,  "RIOHostReset: Don't know if it worked. Try reset again\n");
-			WBYTE(DpRamP->DpControl,  BOOT_FROM_RAM | EXTERNAL_BUS_OFF |
-					  INTERRUPT_DISABLE | BYTE_OPERATION |
-					  SLOW_LINKS | SLOW_AT_BUS);
-			WBYTE(DpRamP->DpResetTpu, 0xFF);
-			udelay(3);
-			break;
+		writeb(BOOT_FROM_RAM | EXTERNAL_BUS_OFF | INTERRUPT_DISABLE | 
+			BYTE_OPERATION | SLOW_LINKS | SLOW_AT_BUS, &DpRamP->DpControl);
+		writeb(0xFF, &DpRamP->DpResetTpu);
+		udelay(3);
+		break;
 	case RIO_PCI:
 		rio_dprintk (RIO_DEBUG_INIT, " (RIO_PCI)\n");
-		DpRamP->DpControl  = RIO_PCI_BOOT_FROM_RAM;
-		DpRamP->DpResetInt = 0xFF;
-		DpRamP->DpResetTpu = 0xFF;
+		writeb(RIO_PCI_BOOT_FROM_RAM, &DpRamP->DpControl);
+		writeb(0xFF, &DpRamP->DpResetInt);
+		writeb(0xFF, &DpRamP->DpResetTpu);
 		udelay(100);
-		/* for (i=0; i<6000; i++);  */
-		/* suspend( 3 ); */
 		break;
 	default:
 		rio_dprintk (RIO_DEBUG_INIT, " (UNKNOWN)\n");
diff -u --new-file --recursive --exclude-from /usr/src/exclude linux.vanilla-2.6.16-rc6-mm1/drivers/char/rio/riointr.c linux-2.6.16-rc6-mm1/drivers/char/rio/riointr.c
--- linux.vanilla-2.6.16-rc6-mm1/drivers/char/rio/riointr.c	2006-03-14 12:59:37.000000000 +0000
+++ linux-2.6.16-rc6-mm1/drivers/char/rio/riointr.c	2006-03-14 21:51:55.000000000 +0000
@@ -101,8 +101,7 @@
 
 #define	INCR( P, I )	((P) = (((P)+(I)) & p->RIOBufferMask))
 /* Enable and start the transmission of packets */
-void RIOTxEnable(en)
-char *en;
+void RIOTxEnable(char *en)
 {
 	struct Port *PortP;
 	struct rio_info *p;
@@ -186,10 +185,8 @@
 static int RupIntr;
 static int RxIntr;
 static int TxIntr;
-void RIOServiceHost(p, HostP, From)
-struct rio_info *p;
-struct Host *HostP;
-int From;
+
+void RIOServiceHost(struct rio_info *p, struct Host *HostP, int From)
 {
 	rio_spin_lock(&HostP->HostLock);
 	if ((HostP->Flags & RUN_STATE) != RC_RUNNING) {
@@ -201,22 +198,22 @@
 	}
 	rio_spin_unlock(&HostP->HostLock);
 
-	if (RWORD(HostP->ParmMapP->rup_intr)) {
-		WWORD(HostP->ParmMapP->rup_intr, 0);
+	if (readw(&HostP->ParmMapP->rup_intr)) {
+		writew(0, &HostP->ParmMapP->rup_intr);
 		p->RIORupCount++;
 		RupIntr++;
-		rio_dprintk(RIO_DEBUG_INTR, "rio: RUP interrupt on host %d\n", HostP - p->RIOHosts);
+		rio_dprintk(RIO_DEBUG_INTR, "rio: RUP interrupt on host %Zd\n", HostP - p->RIOHosts);
 		RIOPollHostCommands(p, HostP);
 	}
 
-	if (RWORD(HostP->ParmMapP->rx_intr)) {
+	if (readw(&HostP->ParmMapP->rx_intr)) {
 		int port;
 
-		WWORD(HostP->ParmMapP->rx_intr, 0);
+		writew(0, &HostP->ParmMapP->rx_intr);
 		p->RIORxCount++;
 		RxIntr++;
 
-		rio_dprintk(RIO_DEBUG_INTR, "rio: RX interrupt on host %d\n", HostP - p->RIOHosts);
+		rio_dprintk(RIO_DEBUG_INTR, "rio: RX interrupt on host %Zd\n", HostP - p->RIOHosts);
 		/*
 		 ** Loop through every port. If the port is mapped into
 		 ** the system ( i.e. has /dev/ttyXXXX associated ) then it is
@@ -277,26 +274,26 @@
 			 ** it's handshake bit is set, then we must clear the handshake,
 			 ** so that that downstream RTA is re-enabled.
 			 */
-			if (!can_remove_receive(&PacketP, PortP) && (RWORD(PortP->PhbP->handshake) == PHB_HANDSHAKE_SET)) {
+			if (!can_remove_receive(&PacketP, PortP) && (readw(&PortP->PhbP->handshake) == PHB_HANDSHAKE_SET)) {
 				/*
 				 ** MAGIC! ( Basically, handshake the RX buffer, so that
 				 ** the RTAs upstream can be re-enabled. )
 				 */
 				rio_dprintk(RIO_DEBUG_INTR, "Set RX handshake bit\n");
-				WWORD(PortP->PhbP->handshake, PHB_HANDSHAKE_SET | PHB_HANDSHAKE_RESET);
+				writew(PHB_HANDSHAKE_SET | PHB_HANDSHAKE_RESET, &PortP->PhbP->handshake);
 			}
 			rio_spin_unlock(&PortP->portSem);
 		}
 	}
 
-	if (RWORD(HostP->ParmMapP->tx_intr)) {
+	if (readw(&HostP->ParmMapP->tx_intr)) {
 		int port;
 
-		WWORD(HostP->ParmMapP->tx_intr, 0);
+		writew(0, &HostP->ParmMapP->tx_intr);
 
 		p->RIOTxCount++;
 		TxIntr++;
-		rio_dprintk(RIO_DEBUG_INTR, "rio: TX interrupt on host %d\n", HostP - p->RIOHosts);
+		rio_dprintk(RIO_DEBUG_INTR, "rio: TX interrupt on host %Zd\n", HostP - p->RIOHosts);
 
 		/*
 		 ** Loop through every port.
@@ -445,9 +442,9 @@
 					 */
 					PktCmdP = (struct PktCmd *) &PacketP->data[0];
 
-					WBYTE(PktCmdP->Command, WFLUSH);
+					writeb(WFLUSH, &PktCmdP->Command);
 
-					p = PortP->HostPort % (ushort) PORTS_PER_RTA;
+					p = PortP->HostPort % (u16) PORTS_PER_RTA;
 
 					/*
 					 ** If second block of ports for 16 port RTA, add 8
@@ -456,27 +453,27 @@
 					if (PortP->SecondBlock)
 						p += PORTS_PER_RTA;
 
-					WBYTE(PktCmdP->PhbNum, p);
+					writeb(p, &PktCmdP->PhbNum);
 
 					/*
 					 ** to make debuggery easier
 					 */
-					WBYTE(PacketP->data[2], 'W');
-					WBYTE(PacketP->data[3], 'F');
-					WBYTE(PacketP->data[4], 'L');
-					WBYTE(PacketP->data[5], 'U');
-					WBYTE(PacketP->data[6], 'S');
-					WBYTE(PacketP->data[7], 'H');
-					WBYTE(PacketP->data[8], ' ');
-					WBYTE(PacketP->data[9], '0' + PortP->WflushFlag);
-					WBYTE(PacketP->data[10], ' ');
-					WBYTE(PacketP->data[11], ' ');
-					WBYTE(PacketP->data[12], '\0');
+					writeb('W', &PacketP->data[2]);
+					writeb('F', &PacketP->data[3]);
+					writeb('L', &PacketP->data[4]);
+					writeb('U', &PacketP->data[5]);
+					writeb('S', &PacketP->data[6]);
+					writeb('H', &PacketP->data[7]);
+					writeb(' ', &PacketP->data[8]);
+					writeb('0' + PortP->WflushFlag, &PacketP->data[9]);
+					writeb(' ', &PacketP->data[10]);
+					writeb(' ', &PacketP->data[11]);
+					writeb('\0', &PacketP->data[12]);
 
 					/*
 					 ** its two bytes long!
 					 */
-					WBYTE(PacketP->len, PKT_CMD_BIT | 2);
+					writeb(PKT_CMD_BIT | 2, &PacketP->len);
 
 					/*
 					 ** queue it!
@@ -529,19 +526,15 @@
 }
 
 /*
-** Routine for handling received data for clist drivers.
-** NB: Called with the tty locked. The spl from the lockb( ) is passed.
-** we return the ttySpl level that we re-locked at.
+** Routine for handling received data for tty drivers
 */
-static void RIOReceive(p, PortP)
-struct rio_info *p;
-struct Port *PortP;
+static void RIOReceive(struct rio_info *p, struct Port *PortP)
 {
 	struct tty_struct *TtyP;
-	register ushort transCount;
+	unsigned short transCount;
 	struct PKT *PacketP;
-	register uint DataCnt;
-	uchar *ptr;
+	register unsigned int DataCnt;
+	unsigned char *ptr;
 	unsigned char *buf;
 	int copied = 0;
 
@@ -594,9 +587,6 @@
 		transCount = 1;
 		while (can_remove_receive(&PacketP, PortP)
 		       && transCount) {
-#ifdef STATS
-			PortP->Stat.RxIntCnt++;
-#endif				/* STATS */
 			RxIntCnt++;
 
 			/*
@@ -642,28 +632,15 @@
 			 ** to '#define', (this is the only place ___DEBUG_IT___ occurs in the
 			 ** driver).
 			 */
-#undef ___DEBUG_IT___
-#ifdef ___DEBUG_IT___
-			kkprintf("I:%d R:%d P:%d Q:%d C:%d F:%x ", intCount, RxIntCnt, PortP->PortNum, TtyP->rxqueue.count, transCount, TtyP->flags);
-#endif
-			ptr = (uchar *) PacketP->data + PortP->RxDataStart;
+			ptr = (unsigned char *) PacketP->data + PortP->RxDataStart;
 
 			tty_prepare_flip_string(TtyP, &buf, transCount);
 			rio_memcpy_fromio(buf, ptr, transCount);
-#ifdef STATS
-			/*
-			 ** keep a count for statistical purposes
-			 */
-			PortP->Stat.RxCharCnt += transCount;
-#endif
 			PortP->RxDataStart += transCount;
 			PacketP->len -= transCount;
 			copied += transCount;
 
 
-#ifdef ___DEBUG_IT___
-			kkprintf("T:%d L:%d\n", DataCnt, PacketP->len);
-#endif
 
 			if (PacketP->len == 0) {
 				/*
@@ -674,12 +651,6 @@
 				remove_receive(PortP);
 				put_free_end(PortP->HostP, PacketP);
 				PortP->RxDataStart = 0;
-#ifdef STATS
-				/*
-				 ** more lies ( oops, I mean statistics )
-				 */
-				PortP->Stat.RxPktCnt++;
-#endif				/* STATS */
 			}
 		}
 	}
@@ -691,215 +662,3 @@
 	return;
 }
 
-#ifdef FUTURE_RELEASE
-/*
-** The proc routine called by the line discipline to do the work for it.
-** The proc routine works hand in hand with the interrupt routine.
-*/
-int riotproc(p, tp, cmd, port)
-struct rio_info *p;
-register struct ttystatics *tp;
-int cmd;
-int port;
-{
-	register struct Port *PortP;
-	int SysPort;
-	struct PKT *PacketP;
-
-	SysPort = port;		/* Believe me, it works. */
-
-	if (SysPort < 0 || SysPort >= RIO_PORTS) {
-		rio_dprintk(RIO_DEBUG_INTR, "Illegal port %d derived from TTY in riotproc()\n", SysPort);
-		return 0;
-	}
-	PortP = p->RIOPortp[SysPort];
-
-	if ((uint) PortP->PhbP < (uint) PortP->Caddr || (uint) PortP->PhbP >= (uint) PortP->Caddr + SIXTY_FOUR_K) {
-		rio_dprintk(RIO_DEBUG_INTR, "RIO: NULL or BAD PhbP on sys port %d in proc routine\n", SysPort);
-		rio_dprintk(RIO_DEBUG_INTR, "	 PortP = 0x%x\n", PortP);
-		rio_dprintk(RIO_DEBUG_INTR, "	 PortP->PhbP = 0x%x\n", PortP->PhbP);
-		rio_dprintk(RIO_DEBUG_INTR, "	 PortP->Caddr = 0x%x\n", PortP->PhbP);
-		rio_dprintk(RIO_DEBUG_INTR, "	 PortP->HostPort = 0x%x\n", PortP->HostPort);
-		return 0;
-	}
-
-	switch (cmd) {
-	case T_WFLUSH:
-		rio_dprintk(RIO_DEBUG_INTR, "T_WFLUSH\n");
-		/*
-		 ** Because of the spooky way the RIO works, we don't need
-		 ** to issue a flush command on any of the SET*F commands,
-		 ** as that causes trouble with getty and login, which issue
-		 ** these commands to incur a READ flush, and rely on the fact
-		 ** that the line discipline does a wait for drain for them.
-		 ** As the rio doesn't wait for drain, the write flush would
-		 ** destroy the Password: prompt. This isn't very friendly, so
-		 ** here we only issue a WFLUSH command if we are in the interrupt
-		 ** routine, or we aren't executing a SET*F command.
-		 */
-		if (PortP->HostP->InIntr || !PortP->FlushCmdBodge) {
-			/*
-			 ** form a wflush packet - 1 byte long, no data
-			 */
-			if (PortP->State & RIO_DELETED) {
-				rio_dprintk(RIO_DEBUG_INTR, "WFLUSH on deleted RTA\n");
-			} else {
-				if (RIOPreemptiveCmd(p, PortP, WFLUSH) == RIO_FAIL) {
-					rio_dprintk(RIO_DEBUG_INTR, "T_WFLUSH Command failed\n");
-				} else
-					rio_dprintk(RIO_DEBUG_INTR, "T_WFLUSH Command\n");
-			}
-			/*
-			 ** WFLUSH operation - flush the data!
-			 */
-			PortP->TxBufferIn = PortP->TxBufferOut = 0;
-		} else {
-			rio_dprintk(RIO_DEBUG_INTR, "T_WFLUSH Command ignored\n");
-		}
-		/*
-		 ** sort out the line discipline
-		 */
-		if (PortP->CookMode == COOK_WELL)
-			goto start;
-		break;
-
-	case T_RESUME:
-		rio_dprintk(RIO_DEBUG_INTR, "T_RESUME\n");
-		/*
-		 ** send pre-emptive resume packet
-		 */
-		if (PortP->State & RIO_DELETED) {
-			rio_dprintk(RIO_DEBUG_INTR, "RESUME on deleted RTA\n");
-		} else {
-			if (RIOPreemptiveCmd(p, PortP, RESUME) == RIO_FAIL) {
-				rio_dprintk(RIO_DEBUG_INTR, "T_RESUME Command failed\n");
-			}
-		}
-		/*
-		 ** and re-start the sender software!
-		 */
-		if (PortP->CookMode == COOK_WELL)
-			goto start;
-		break;
-
-	case T_TIME:
-		rio_dprintk(RIO_DEBUG_INTR, "T_TIME\n");
-		/*
-		 ** T_TIME is called when xDLY is set in oflags and
-		 ** the line discipline timeout has expired. It's
-		 ** function in life is to clear the TIMEOUT flag
-		 ** and to re-start output to the port.
-		 */
-		/*
-		 ** Fall through and re-start output
-		 */
-	case T_OUTPUT:
-	      start:
-		if (PortP->MagicFlags & MAGIC_FLUSH) {
-			PortP->MagicFlags |= MORE_OUTPUT_EYGOR;
-			return 0;
-		}
-		RIOTxEnable((char *) PortP);
-		PortP->MagicFlags &= ~MORE_OUTPUT_EYGOR;
-		/*rio_dprint(RIO_DEBUG_INTR, PortP,DBG_PROC,"T_OUTPUT finished\n"); */
-		break;
-
-	case T_SUSPEND:
-		rio_dprintk(RIO_DEBUG_INTR, "T_SUSPEND\n");
-		/*
-		 ** send a suspend pre-emptive packet.
-		 */
-		if (PortP->State & RIO_DELETED) {
-			rio_dprintk(RIO_DEBUG_INTR, "SUSPEND deleted RTA\n");
-		} else {
-			if (RIOPreemptiveCmd(p, PortP, SUSPEND) == RIO_FAIL) {
-				rio_dprintk(RIO_DEBUG_INTR, "T_SUSPEND Command failed\n");
-			}
-		}
-		/*
-		 ** done!
-		 */
-		break;
-
-	case T_BLOCK:
-		rio_dprintk(RIO_DEBUG_INTR, "T_BLOCK\n");
-		break;
-
-	case T_RFLUSH:
-		rio_dprintk(RIO_DEBUG_INTR, "T_RFLUSH\n");
-		if (PortP->State & RIO_DELETED) {
-			rio_dprintk(RIO_DEBUG_INTR, "RFLUSH on deleted RTA\n");
-			PortP->RxDataStart = 0;
-		} else {
-			if (RIOPreemptiveCmd(p, PortP, RFLUSH) == RIO_FAIL) {
-				rio_dprintk(RIO_DEBUG_INTR, "T_RFLUSH Command failed\n");
-				return 0;
-			}
-			PortP->RxDataStart = 0;
-			while (can_remove_receive(&PacketP, PortP)) {
-				remove_receive(PortP);
-				ShowPacket(DBG_PROC, PacketP);
-				put_free_end(PortP->HostP, PacketP);
-			}
-			if (PortP->PhbP->handshake == PHB_HANDSHAKE_SET) {
-				/*
-				 ** MAGIC!
-				 */
-				rio_dprintk(RIO_DEBUG_INTR, "Set receive handshake bit\n");
-				PortP->PhbP->handshake |= PHB_HANDSHAKE_RESET;
-			}
-		}
-		break;
-		/* FALLTHROUGH */
-	case T_UNBLOCK:
-		rio_dprintk(RIO_DEBUG_INTR, "T_UNBLOCK\n");
-		/*
-		 ** If there is any data to receive set a timeout to service it.
-		 */
-		RIOReceive(p, PortP);
-		break;
-
-	case T_BREAK:
-		rio_dprintk(RIO_DEBUG_INTR, "T_BREAK\n");
-		/*
-		 ** Send a break command. For Sys V
-		 ** this is a timed break, so we
-		 ** send a SBREAK[time] packet
-		 */
-		/*
-		 ** Build a BREAK command
-		 */
-		if (PortP->State & RIO_DELETED) {
-			rio_dprintk(RIO_DEBUG_INTR, "BREAK on deleted RTA\n");
-		} else {
-			if (RIOShortCommand(PortP, SBREAK, 2, p->RIOConf.BreakInterval) == RIO_FAIL) {
-				rio_dprintk(RIO_DEBUG_INTR, "SBREAK RIOShortCommand failed\n");
-			}
-		}
-
-		/*
-		 ** done!
-		 */
-		break;
-
-	case T_INPUT:
-		rio_dprintk(RIO_DEBUG_INTR, "Proc T_INPUT called - I don't know what to do!\n");
-		break;
-	case T_PARM:
-		rio_dprintk(RIO_DEBUG_INTR, "Proc T_PARM called - I don't know what to do!\n");
-		break;
-
-	case T_SWTCH:
-		rio_dprintk(RIO_DEBUG_INTR, "Proc T_SWTCH called - I don't know what to do!\n");
-		break;
-
-	default:
-		rio_dprintk(RIO_DEBUG_INTR, "Proc UNKNOWN command %d\n", cmd);
-	}
-	/*
-	 ** T_OUTPUT returns without passing through this point!
-	 */
-	/*rio_dprint(RIO_DEBUG_INTR, PortP,DBG_PROC,"riotproc done\n"); */
-	return (0);
-}
-#endif
diff -u --new-file --recursive --exclude-from /usr/src/exclude linux.vanilla-2.6.16-rc6-mm1/drivers/char/rio/rio_linux.c linux-2.6.16-rc6-mm1/drivers/char/rio/rio_linux.c
--- linux.vanilla-2.6.16-rc6-mm1/drivers/char/rio/rio_linux.c	2006-03-14 12:59:37.000000000 +0000
+++ linux-2.6.16-rc6-mm1/drivers/char/rio/rio_linux.c	2006-03-14 21:51:55.000000000 +0000
@@ -297,7 +297,7 @@
 	unsigned char *addr = ad;
 
 	for (i = 0; i < len; i += 16) {
-		rio_dprintk(RIO_DEBUG_PARAM, "%08x ", (int) addr + i);
+		rio_dprintk(RIO_DEBUG_PARAM, "%08lx ", (unsigned long) addr + i);
 		for (j = 0; j < 16; j++) {
 			rio_dprintk(RIO_DEBUG_PARAM, "%02x %s", addr[j + i], (j == 7) ? " " : "");
 		}
@@ -340,13 +340,16 @@
 	return !RIO_FAIL;
 }
 
+void rio_copy_to_card(void *to, void *from, int len)
+{
+	rio_memcpy_toio(NULL, to, from, len);
+}
 
 int rio_minor(struct tty_struct *tty)
 {
 	return tty->index + (tty->driver == rio_driver) ? 0 : 256;
 }
 
-
 int rio_ismodem(struct tty_struct *tty)
 {
 	return 1;
@@ -379,7 +382,7 @@
 	case RIO_AT:
 	case RIO_MCA:
 	case RIO_PCI:
-		WBYTE(HostP->ResetInt, 0xff);
+		writeb(0xFF, &HostP->ResetInt);
 	}
 
 	func_exit();
@@ -397,9 +400,6 @@
 	/* AAargh! The order in which to do these things is essential and
 	   not trivial.
 
-	   - Rate limit goes before "recursive". Otherwise a series of
-	   recursive calls will hang the machine in the interrupt routine.
-
 	   - hardware twiddling goes before "recursive". Otherwise when we
 	   poll the card, and a recursive interrupt happens, we won't
 	   ack the card, so it might keep on interrupting us. (especially
@@ -414,26 +414,6 @@
 	   - The initialized test goes before recursive.
 	 */
 
-
-
-#ifdef IRQ_RATE_LIMIT
-	/* Aaargh! I'm ashamed. This costs more lines-of-code than the
-	   actual interrupt routine!. (Well, used to when I wrote that comment) */
-	{
-		static int lastjif;
-		static int nintr = 0;
-
-		if (lastjif == jiffies) {
-			if (++nintr > IRQ_RATE_LIMIT) {
-				free_irq(HostP->Ivec, ptr);
-				printk(KERN_ERR "rio: Too many interrupts. Turning off interrupt %d.\n", HostP->Ivec);
-			}
-		} else {
-			lastjif = jiffies;
-			nintr = 0;
-		}
-	}
-#endif
 	rio_dprintk(RIO_DEBUG_IFLOW, "rio: We've have noticed the interrupt\n");
 	if (HostP->Ivec == irq) {
 		/* Tell the card we've noticed the interrupt. */
@@ -444,13 +424,13 @@
 		return IRQ_HANDLED;
 
 	if (test_and_set_bit(RIO_BOARD_INTR_LOCK, &HostP->locks)) {
-		printk(KERN_ERR "Recursive interrupt! (host %d/irq%d)\n", (int) ptr, HostP->Ivec);
+		printk(KERN_ERR "Recursive interrupt! (host %p/irq%d)\n", ptr, HostP->Ivec);
 		return IRQ_HANDLED;
 	}
 
 	RIOServiceHost(p, HostP, irq);
 
-	rio_dprintk(RIO_DEBUG_IFLOW, "riointr() doing host %d type %d\n", (int) ptr, HostP->Type);
+	rio_dprintk(RIO_DEBUG_IFLOW, "riointr() doing host %p type %d\n", ptr, HostP->Type);
 
 	clear_bit(RIO_BOARD_INTR_LOCK, &HostP->locks);
 	rio_dprintk(RIO_DEBUG_IFLOW, "rio: exit rio_interrupt (%d/%d)\n", irq, HostP->Ivec);
@@ -873,7 +853,7 @@
 #define HOST_SZ sizeof(struct Host)
 #define PORT_SZ sizeof(struct Port *)
 #define TMIO_SZ sizeof(struct termios *)
-	rio_dprintk(RIO_DEBUG_INIT, "getting : %d %d %d %d %d bytes\n", RI_SZ, RIO_HOSTS * HOST_SZ, RIO_PORTS * PORT_SZ, RIO_PORTS * TMIO_SZ, RIO_PORTS * TMIO_SZ);
+	rio_dprintk(RIO_DEBUG_INIT, "getting : %Zd %Zd %Zd %Zd %Zd bytes\n", RI_SZ, RIO_HOSTS * HOST_SZ, RIO_PORTS * PORT_SZ, RIO_PORTS * TMIO_SZ, RIO_PORTS * TMIO_SZ);
 
 	if (!(p = ckmalloc(RI_SZ)))
 		goto free0;
@@ -963,22 +943,21 @@
 
 static void fix_rio_pci(struct pci_dev *pdev)
 {
-	unsigned int hwbase;
-	unsigned long rebase;
+	unsigned long hwbase;
+	unsigned char *rebase;
 	unsigned int t;
 
 #define CNTRL_REG_OFFSET        0x50
 #define CNTRL_REG_GOODVALUE     0x18260000
 
-	pci_read_config_dword(pdev, PCI_BASE_ADDRESS_0, &hwbase);
-	hwbase &= PCI_BASE_ADDRESS_MEM_MASK;
-	rebase = (ulong) ioremap(hwbase, 0x80);
+	hwbase = pci_resource_start(pdev, 0);
+	rebase = ioremap(hwbase, 0x80);
 	t = readl(rebase + CNTRL_REG_OFFSET);
 	if (t != CNTRL_REG_GOODVALUE) {
 		printk(KERN_DEBUG "rio: performing cntrl reg fix: %08x -> %08x\n", t, CNTRL_REG_GOODVALUE);
 		writel(CNTRL_REG_GOODVALUE, rebase + CNTRL_REG_OFFSET);
 	}
-	iounmap((char *) rebase);
+	iounmap(rebase);
 }
 #endif
 
@@ -1049,7 +1028,7 @@
 		hp->Caddr = ioremap(p->RIOHosts[p->RIONumHosts].PaddrP, RIO_WINDOW_LEN);
 		hp->CardP = (struct DpRam *) hp->Caddr;
 		hp->Type = RIO_PCI;
-		hp->Copy = rio_pcicopy;
+		hp->Copy = rio_copy_to_card;
 		hp->Mode = RIO_PCI_BOOT_FROM_RAM;
 		spin_lock_init(&hp->HostLock);
 		rio_reset_interrupt(hp);
@@ -1058,10 +1037,10 @@
 		rio_dprintk(RIO_DEBUG_PROBE, "Going to test it (%p/%p).\n", (void *) p->RIOHosts[p->RIONumHosts].PaddrP, p->RIOHosts[p->RIONumHosts].Caddr);
 		if (RIOBoardTest(p->RIOHosts[p->RIONumHosts].PaddrP, p->RIOHosts[p->RIONumHosts].Caddr, RIO_PCI, 0) == RIO_SUCCESS) {
 			rio_dprintk(RIO_DEBUG_INIT, "Done RIOBoardTest\n");
-			WBYTE(p->RIOHosts[p->RIONumHosts].ResetInt, 0xff);
+			writeb(0xFF, &p->RIOHosts[p->RIONumHosts].ResetInt);
 			p->RIOHosts[p->RIONumHosts].UniqueNum =
-			    ((RBYTE(p->RIOHosts[p->RIONumHosts].Unique[0]) & 0xFF) << 0) |
-			    ((RBYTE(p->RIOHosts[p->RIONumHosts].Unique[1]) & 0xFF) << 8) | ((RBYTE(p->RIOHosts[p->RIONumHosts].Unique[2]) & 0xFF) << 16) | ((RBYTE(p->RIOHosts[p->RIONumHosts].Unique[3]) & 0xFF) << 24);
+			    ((readb(&p->RIOHosts[p->RIONumHosts].Unique[0]) & 0xFF) << 0) |
+			    ((readb(&p->RIOHosts[p->RIONumHosts].Unique[1]) & 0xFF) << 8) | ((readb(&p->RIOHosts[p->RIONumHosts].Unique[2]) & 0xFF) << 16) | ((readb(&p->RIOHosts[p->RIONumHosts].Unique[3]) & 0xFF) << 24);
 			rio_dprintk(RIO_DEBUG_PROBE, "Hmm Tested ok, uniqid = %x.\n", p->RIOHosts[p->RIONumHosts].UniqueNum);
 
 			fix_rio_pci(pdev);
@@ -1099,7 +1078,7 @@
 		hp->Caddr = ioremap(p->RIOHosts[p->RIONumHosts].PaddrP, RIO_WINDOW_LEN);
 		hp->CardP = (struct DpRam *) hp->Caddr;
 		hp->Type = RIO_PCI;
-		hp->Copy = rio_pcicopy;
+		hp->Copy = rio_copy_to_card;
 		hp->Mode = RIO_PCI_BOOT_FROM_RAM;
 		spin_lock_init(&hp->HostLock);
 
@@ -1110,10 +1089,10 @@
 		rio_start_card_running(hp);
 		rio_dprintk(RIO_DEBUG_PROBE, "Going to test it (%p/%p).\n", (void *) p->RIOHosts[p->RIONumHosts].PaddrP, p->RIOHosts[p->RIONumHosts].Caddr);
 		if (RIOBoardTest(p->RIOHosts[p->RIONumHosts].PaddrP, p->RIOHosts[p->RIONumHosts].Caddr, RIO_PCI, 0) == RIO_SUCCESS) {
-			WBYTE(p->RIOHosts[p->RIONumHosts].ResetInt, 0xff);
+			writeb(0xFF, &p->RIOHosts[p->RIONumHosts].ResetInt);
 			p->RIOHosts[p->RIONumHosts].UniqueNum =
-			    ((RBYTE(p->RIOHosts[p->RIONumHosts].Unique[0]) & 0xFF) << 0) |
-			    ((RBYTE(p->RIOHosts[p->RIONumHosts].Unique[1]) & 0xFF) << 8) | ((RBYTE(p->RIOHosts[p->RIONumHosts].Unique[2]) & 0xFF) << 16) | ((RBYTE(p->RIOHosts[p->RIONumHosts].Unique[3]) & 0xFF) << 24);
+			    ((readb(&p->RIOHosts[p->RIONumHosts].Unique[0]) & 0xFF) << 0) |
+			    ((readb(&p->RIOHosts[p->RIONumHosts].Unique[1]) & 0xFF) << 8) | ((readb(&p->RIOHosts[p->RIONumHosts].Unique[2]) & 0xFF) << 16) | ((readb(&p->RIOHosts[p->RIONumHosts].Unique[3]) & 0xFF) << 24);
 			rio_dprintk(RIO_DEBUG_PROBE, "Hmm Tested ok, uniqid = %x.\n", p->RIOHosts[p->RIONumHosts].UniqueNum);
 
 			p->RIOLastPCISearch = RIO_SUCCESS;
@@ -1137,8 +1116,8 @@
 		hp->Caddr = ioremap(p->RIOHosts[p->RIONumHosts].PaddrP, RIO_WINDOW_LEN);
 		hp->CardP = (struct DpRam *) hp->Caddr;
 		hp->Type = RIO_AT;
-		hp->Copy = rio_pcicopy;	/* AT card PCI???? - PVDL
-					 * -- YES! this is now a normal copy. Only the
+		hp->Copy = rio_copy_to_card;	/* AT card PCI???? - PVDL
+                                         * -- YES! this is now a normal copy. Only the
 					 * old PCI card uses the special PCI copy.
 					 * Moreover, the ISA card will work with the
 					 * special PCI copy anyway. -- REW */

