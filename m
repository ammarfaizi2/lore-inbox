Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1752063AbWCOMZo@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752063AbWCOMZo (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 15 Mar 2006 07:25:44 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752059AbWCOMZo
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 15 Mar 2006 07:25:44 -0500
Received: from outpipe-village-512-1.bc.nu ([81.2.110.250]:16856 "EHLO
	lxorguk.ukuu.org.uk") by vger.kernel.org with ESMTP
	id S1752063AbWCOMZm (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 15 Mar 2006 07:25:42 -0500
Subject: PATCH: rio driver rework continued  #4
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
To: linux-kernel@vger.kernel.org, akpm@osdl.org
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Date: Wed, 15 Mar 2006 12:32:01 +0000
Message-Id: <1142425921.5597.23.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Evolution 2.2.3 (2.2.3-2.fc4) 
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Third large chunk of code cleanup. The split between this and #3 and #4
is fairly arbitary and due to the message length limit on the list.
These patches continue the process of ripping out macros and typedefs
while cleaning up lots of 32bit assumptions. Several inlines for
compatibility also get removed and that causes a lot of noise.

Signed-off-by: Alan Cox <alan@redhat.com>

diff -u --new-file --recursive --exclude-from /usr/src/exclude linux.vanilla-2.6.16-rc6-mm1/drivers/char/rio/rioctrl.c linux-2.6.16-rc6-mm1/drivers/char/rio/rioctrl.c
--- linux.vanilla-2.6.16-rc6-mm1/drivers/char/rio/rioctrl.c	2006-03-14 12:59:37.000000000 +0000
+++ linux-2.6.16-rc6-mm1/drivers/char/rio/rioctrl.c	2006-03-14 21:51:55.000000000 +0000
@@ -131,30 +131,6 @@
 
 #define drv_makedev(maj, min) ((((uint) maj & 0xff) << 8) | ((uint) min & 0xff))
 
-int copyin(int arg, caddr_t dp, int siz)
-{
-	int rv;
-
-	rio_dprintk(RIO_DEBUG_CTRL, "Copying %d bytes from user %p to %p.\n", siz, (void *) arg, dp);
-	rv = copy_from_user(dp, (void *) arg, siz);
-	if (rv)
-		return COPYFAIL;
-	else
-		return rv;
-}
-
-static int copyout(caddr_t dp, int arg, int siz)
-{
-	int rv;
-
-	rio_dprintk(RIO_DEBUG_CTRL, "Copying %d bytes to user %p from %p.\n", siz, (void *) arg, dp);
-	rv = copy_to_user((void *) arg, dp, siz);
-	if (rv)
-		return COPYFAIL;
-	else
-		return rv;
-}
-
 int riocontrol(p, dev, cmd, arg, su)
 struct rio_info *p;
 dev_t dev;
@@ -178,7 +154,7 @@
 	Host = 0;
 	PortP = NULL;
 
-	rio_dprintk(RIO_DEBUG_CTRL, "control ioctl cmd: 0x%x arg: 0x%x\n", cmd, (int) arg);
+	rio_dprintk(RIO_DEBUG_CTRL, "control ioctl cmd: 0x%x arg: 0x%p\n", cmd, arg);
 
 	switch (cmd) {
 		/*
@@ -189,90 +165,34 @@
 		 ** otherwise just the specified host card will be changed.
 		 */
 	case RIO_SET_TIMER:
-		rio_dprintk(RIO_DEBUG_CTRL, "RIO_SET_TIMER to %dms\n", (uint) arg);
+		rio_dprintk(RIO_DEBUG_CTRL, "RIO_SET_TIMER to %ldms\n", (unsigned long)arg);
 		{
 			int host, value;
-			host = (uint) arg >> 16;
-			value = (uint) arg & 0x0000ffff;
+			host = ((unsigned long) arg >> 16) & 0x0000FFFF;
+			value = (unsigned long) arg & 0x0000ffff;
 			if (host == -1) {
 				for (host = 0; host < p->RIONumHosts; host++) {
 					if (p->RIOHosts[host].Flags == RC_RUNNING) {
-						WWORD(p->RIOHosts[host].ParmMapP->timer, value);
+						writew(value, &p->RIOHosts[host].ParmMapP->timer);
 					}
 				}
 			} else if (host >= p->RIONumHosts) {
 				return -EINVAL;
 			} else {
 				if (p->RIOHosts[host].Flags == RC_RUNNING) {
-					WWORD(p->RIOHosts[host].ParmMapP->timer, value);
+					writew(value, &p->RIOHosts[host].ParmMapP->timer);
 				}
 			}
 		}
 		return 0;
 
-	case RIO_IDENTIFY_DRIVER:
-		/*
-		 ** 15.10.1998 ARG - ESIL 0760 part fix
-		 ** Added driver ident string output.
-		 **
-		 #ifndef __THIS_RELEASE__
-		 #warning Driver Version string not defined !
-		 #endif
-		 cprintf("%s %s %s %s\n",
-		 RIO_DRV_STR,
-		 __THIS_RELEASE__,
-		 __DATE__, __TIME__ );
-
-		 return 0;
-
-		 case RIO_DISPLAY_HOST_CFG:
-		 **
-		 ** 15.10.1998 ARG - ESIL 0760 part fix
-		 ** Added driver host card ident string output.
-		 **
-		 ** Note that the only types currently supported
-		 ** are ISA and PCI. Also this driver does not
-		 ** (yet) distinguish between the Old PCI card
-		 ** and the Jet PCI card. In fact I think this
-		 ** driver only supports JET PCI !
-		 **
-
-		 for (Host = 0; Host < p->RIONumHosts; Host++)
-		 {
-		 HostP = &(p->RIOHosts[Host]);
-
-		 switch ( HostP->Type )
-		 {
-		 case RIO_AT :
-		 strcpy( host_type, RIO_AT_HOST_STR );
-		 break;
-
-		 case RIO_PCI :
-		 strcpy( host_type, RIO_PCI_HOST_STR );
-		 break;
-
-		 default :
-		 strcpy( host_type, "Unknown" );
-		 break;
-		 }
-
-		 cprintf(
-		 "RIO Host %d - Type:%s Addr:%X IRQ:%d\n",
-		 Host, host_type,
-		 (uint)HostP->PaddrP,
-		 (int)HostP->Ivec - 32  );
-		 }
-		 return 0;
-		 **
-		 */
-
 	case RIO_FOAD_RTA:
 		rio_dprintk(RIO_DEBUG_CTRL, "RIO_FOAD_RTA\n");
-		return RIOCommandRta(p, (uint) arg, RIOFoadRta);
+		return RIOCommandRta(p, (unsigned long)arg, RIOFoadRta);
 
 	case RIO_ZOMBIE_RTA:
 		rio_dprintk(RIO_DEBUG_CTRL, "RIO_ZOMBIE_RTA\n");
-		return RIOCommandRta(p, (uint) arg, RIOZombieRta);
+		return RIOCommandRta(p, (unsigned long)arg, RIOZombieRta);
 
 	case RIO_IDENTIFY_RTA:
 		rio_dprintk(RIO_DEBUG_CTRL, "RIO_IDENTIFY_RTA\n");
@@ -287,7 +207,7 @@
 			struct CmdBlk *CmdBlkP;
 
 			rio_dprintk(RIO_DEBUG_CTRL, "SPECIAL_RUP_CMD\n");
-			if (copyin((int) arg, (caddr_t) & SpecialRupCmd, sizeof(SpecialRupCmd)) == COPYFAIL) {
+			if (copy_from_user(&SpecialRupCmd, arg, sizeof(SpecialRupCmd))) {
 				rio_dprintk(RIO_DEBUG_CTRL, "SPECIAL_RUP_CMD copy failed\n");
 				p->RIOError.Error = COPYIN_FAILED;
 				return -EFAULT;
@@ -302,7 +222,7 @@
 				SpecialRupCmd.Host = 0;
 			rio_dprintk(RIO_DEBUG_CTRL, "Queue special rup command for host %d rup %d\n", SpecialRupCmd.Host, SpecialRupCmd.RupNum);
 			if (RIOQueueCmdBlk(&p->RIOHosts[SpecialRupCmd.Host], SpecialRupCmd.RupNum, CmdBlkP) == RIO_FAIL) {
-				cprintf("FAILED TO QUEUE SPECIAL RUP COMMAND\n");
+				printk(KERN_WARNING "rio: FAILED TO QUEUE SPECIAL RUP COMMAND\n");
 			}
 			return 0;
 		}
@@ -324,7 +244,7 @@
 		if ((retval = RIOApel(p)) != 0)
 			return retval;
 
-		if (copyout((caddr_t) p->RIOConnectTable, (int) arg, TOTAL_MAP_ENTRIES * sizeof(struct Map)) == COPYFAIL) {
+		if (copy_to_user(arg, p->RIOConnectTable, TOTAL_MAP_ENTRIES * sizeof(struct Map))) {
 			rio_dprintk(RIO_DEBUG_CTRL, "RIO_GET_TABLE copy failed\n");
 			p->RIOError.Error = COPYOUT_FAILED;
 			return -EFAULT;
@@ -369,7 +289,7 @@
 			p->RIOError.Error = NOT_SUPER_USER;
 			return -EPERM;
 		}
-		if (copyin((int) arg, (caddr_t) & p->RIOConnectTable[0], TOTAL_MAP_ENTRIES * sizeof(struct Map)) == COPYFAIL) {
+		if (copy_from_user(&p->RIOConnectTable[0], arg, TOTAL_MAP_ENTRIES * sizeof(struct Map))) {
 			rio_dprintk(RIO_DEBUG_CTRL, "RIO_PUT_TABLE copy failed\n");
 			p->RIOError.Error = COPYIN_FAILED;
 			return -EFAULT;
@@ -415,7 +335,7 @@
 			p->RIOError.Error = NOT_SUPER_USER;
 			return -EPERM;
 		}
-		if (copyout((caddr_t) p->RIOBindTab, (int) arg, (sizeof(ulong) * MAX_RTA_BINDINGS)) == COPYFAIL) {
+		if (copy_to_user(arg, p->RIOBindTab, (sizeof(ulong) * MAX_RTA_BINDINGS))) {
 			rio_dprintk(RIO_DEBUG_CTRL, "RIO_GET_BINDINGS copy failed\n");
 			p->RIOError.Error = COPYOUT_FAILED;
 			return -EFAULT;
@@ -434,7 +354,7 @@
 			p->RIOError.Error = NOT_SUPER_USER;
 			return -EPERM;
 		}
-		if (copyin((int) arg, (caddr_t) & p->RIOBindTab[0], (sizeof(ulong) * MAX_RTA_BINDINGS)) == COPYFAIL) {
+		if (copy_from_user(&p->RIOBindTab[0], arg, (sizeof(ulong) * MAX_RTA_BINDINGS))) {
 			rio_dprintk(RIO_DEBUG_CTRL, "RIO_PUT_BINDINGS copy failed\n");
 			p->RIOError.Error = COPYIN_FAILED;
 			return -EFAULT;
@@ -458,12 +378,12 @@
 			for (Entry = 0; Entry < MAX_RTA_BINDINGS; Entry++) {
 				if ((EmptySlot == -1) && (p->RIOBindTab[Entry] == 0L))
 					EmptySlot = Entry;
-				else if (p->RIOBindTab[Entry] == (int) arg) {
+				else if (p->RIOBindTab[Entry] == (long)arg) {
 					/*
 					 ** Already exists - delete
 					 */
 					p->RIOBindTab[Entry] = 0L;
-					rio_dprintk(RIO_DEBUG_CTRL, "Removing Rta %x from p->RIOBindTab\n", (int) arg);
+					rio_dprintk(RIO_DEBUG_CTRL, "Removing Rta %ld from p->RIOBindTab\n", (unsigned long)arg);
 					return 0;
 				}
 			}
@@ -471,10 +391,10 @@
 			 ** Dosen't exist - add
 			 */
 			if (EmptySlot != -1) {
-				p->RIOBindTab[EmptySlot] = (int) arg;
-				rio_dprintk(RIO_DEBUG_CTRL, "Adding Rta %x to p->RIOBindTab\n", (int) arg);
+				p->RIOBindTab[EmptySlot] = (unsigned long)arg;
+				rio_dprintk(RIO_DEBUG_CTRL, "Adding Rta %lx to p->RIOBindTab\n", (unsigned long) arg);
 			} else {
-				rio_dprintk(RIO_DEBUG_CTRL, "p->RIOBindTab full! - Rta %x not added\n", (int) arg);
+				rio_dprintk(RIO_DEBUG_CTRL, "p->RIOBindTab full! - Rta %lx not added\n", (unsigned long) arg);
 				return -ENOMEM;
 			}
 			return 0;
@@ -482,7 +402,7 @@
 
 	case RIO_RESUME:
 		rio_dprintk(RIO_DEBUG_CTRL, "RIO_RESUME\n");
-		port = (uint) arg;
+		port = (unsigned long) arg;
 		if ((port < 0) || (port > 511)) {
 			rio_dprintk(RIO_DEBUG_CTRL, "RIO_RESUME: Bad port number %d\n", port);
 			p->RIOError.Error = PORT_NUMBER_OUT_OF_RANGE;
@@ -518,8 +438,7 @@
 			p->RIOError.Error = NOT_SUPER_USER;
 			return -EPERM;
 		}
-		if (copyin((int) arg, (caddr_t) & MapEnt, sizeof(MapEnt))
-		    == COPYFAIL) {
+		if (copy_from_user(&MapEnt, arg, sizeof(MapEnt))) {
 			rio_dprintk(RIO_DEBUG_CTRL, "Copy from user space failed\n");
 			p->RIOError.Error = COPYIN_FAILED;
 			return -EFAULT;
@@ -533,8 +452,7 @@
 			p->RIOError.Error = NOT_SUPER_USER;
 			return -EPERM;
 		}
-		if (copyin((int) arg, (caddr_t) & MapEnt, sizeof(MapEnt))
-		    == COPYFAIL) {
+		if (copy_from_user(&MapEnt, arg, sizeof(MapEnt))) {
 			rio_dprintk(RIO_DEBUG_CTRL, "Copy from user space failed\n");
 			p->RIOError.Error = COPYIN_FAILED;
 			return -EFAULT;
@@ -548,8 +466,7 @@
 			p->RIOError.Error = NOT_SUPER_USER;
 			return -EPERM;
 		}
-		if (copyin((int) arg, (caddr_t) & MapEnt, sizeof(MapEnt))
-		    == COPYFAIL) {
+		if (copy_from_user(&MapEnt, arg, sizeof(MapEnt))) {
 			rio_dprintk(RIO_DEBUG_CTRL, "Copy from data space failed\n");
 			p->RIOError.Error = COPYIN_FAILED;
 			return -EFAULT;
@@ -557,30 +474,14 @@
 		return RIODeleteRta(p, &MapEnt);
 
 	case RIO_QUICK_CHECK:
-		/*
-		 ** 09.12.1998 ARG - ESIL 0776 part fix
-		 ** A customer was using this to get the RTAs
-		 ** connect/disconnect status.
-		 ** RIOConCon() had been botched use RIOHalted
-		 ** to keep track of RTA connections and
-		 ** disconnections. That has been changed and
-		 ** RIORtaDisCons in the rio_info struct now
-		 ** does the job. So we need to return the value
-		 ** of RIORtaCons instead of RIOHalted.
-		 **
-		 if (copyout((caddr_t)&p->RIOHalted,(int)arg,
-		 sizeof(uint))==COPYFAIL) {
-		 **
-		 */
-
-		if (copyout((caddr_t) & p->RIORtaDisCons, (int) arg, sizeof(uint)) == COPYFAIL) {
+		if (copy_to_user(arg, &p->RIORtaDisCons, sizeof(unsigned int))) {
 			p->RIOError.Error = COPYOUT_FAILED;
 			return -EFAULT;
 		}
 		return 0;
 
 	case RIO_LAST_ERROR:
-		if (copyout((caddr_t) & p->RIOError, (int) arg, sizeof(struct Error)) == COPYFAIL)
+		if (copy_to_user(arg, &p->RIOError, sizeof(struct Error)))
 			return -EFAULT;
 		return 0;
 
@@ -589,7 +490,7 @@
 		return -EINVAL;
 
 	case RIO_GET_MODTYPE:
-		if (copyin((int) arg, (caddr_t) & port, sizeof(uint)) == COPYFAIL) {
+		if (copy_from_user(&port, arg, sizeof(unsigned int))) {
 			p->RIOError.Error = COPYIN_FAILED;
 			return -EFAULT;
 		}
@@ -609,36 +510,11 @@
 		 ** Return module type of port
 		 */
 		port = PortP->HostP->UnixRups[PortP->RupNum].ModTypes;
-		if (copyout((caddr_t) & port, (int) arg, sizeof(uint)) == COPYFAIL) {
+		if (copy_to_user(arg, &port, sizeof(unsigned int))) {
 			p->RIOError.Error = COPYOUT_FAILED;
 			return -EFAULT;
 		}
 		return (0);
-		/*
-		 ** 02.03.1999 ARG - ESIL 0820 fix
-		 ** We are no longer using "Boot Mode", so these ioctls
-		 ** are not required :
-		 **
-		 case RIO_GET_BOOT_MODE :
-		 rio_dprint(RIO_DEBUG_CTRL, ("Get boot mode - %x\n", p->RIOBootMode));
-		 **
-		 ** Return boot state of system - BOOT_ALL, BOOT_OWN or BOOT_NONE
-		 **
-		 if (copyout((caddr_t)&p->RIOBootMode, (int)arg,
-		 sizeof(p->RIOBootMode)) == COPYFAIL) {
-		 p->RIOError.Error = COPYOUT_FAILED;
-		 return -EFAULT;
-		 }
-		 return(0);
-
-		 case RIO_SET_BOOT_MODE :
-		 p->RIOBootMode = (uint) arg;
-		 rio_dprint(RIO_DEBUG_CTRL, ("Set boot mode to 0x%x\n", p->RIOBootMode));
-		 return(0);
-		 **
-		 ** End ESIL 0820 fix
-		 */
-
 	case RIO_BLOCK_OPENS:
 		rio_dprintk(RIO_DEBUG_CTRL, "Opens block until booted\n");
 		for (Entry = 0; Entry < RIO_PORTS; Entry++) {
@@ -650,8 +526,7 @@
 
 	case RIO_SETUP_PORTS:
 		rio_dprintk(RIO_DEBUG_CTRL, "Setup ports\n");
-		if (copyin((int) arg, (caddr_t) & PortSetup, sizeof(PortSetup))
-		    == COPYFAIL) {
+		if (copy_from_user(&PortSetup, arg, sizeof(PortSetup))) {
 			p->RIOError.Error = COPYIN_FAILED;
 			rio_dprintk(RIO_DEBUG_CTRL, "EFAULT");
 			return -EFAULT;
@@ -667,7 +542,7 @@
 			return -EINVAL;
 		}
 		if (!p->RIOPortp) {
-			cprintf("No p->RIOPortp array!\n");
+			printk(KERN_ERR "rio: No p->RIOPortp array!\n");
 			rio_dprintk(RIO_DEBUG_CTRL, "No p->RIOPortp array!\n");
 			return -EIO;
 		}
@@ -681,8 +556,7 @@
 
 	case RIO_GET_PORT_SETUP:
 		rio_dprintk(RIO_DEBUG_CTRL, "Get port setup\n");
-		if (copyin((int) arg, (caddr_t) & PortSetup, sizeof(PortSetup))
-		    == COPYFAIL) {
+		if (copy_from_user(&PortSetup, arg, sizeof(PortSetup))) {
 			p->RIOError.Error = COPYIN_FAILED;
 			return -EFAULT;
 		}
@@ -703,8 +577,7 @@
 		PortSetup.XpOn[MAX_XP_CTRL_LEN - 1] = '\0';
 		PortSetup.XpOff[MAX_XP_CTRL_LEN - 1] = '\0';
 
-		if (copyout((caddr_t) & PortSetup, (int) arg, sizeof(PortSetup))
-		    == COPYFAIL) {
+		if (copy_to_user(arg, &PortSetup, sizeof(PortSetup))) {
 			p->RIOError.Error = COPYOUT_FAILED;
 			return -EFAULT;
 		}
@@ -712,7 +585,7 @@
 
 	case RIO_GET_PORT_PARAMS:
 		rio_dprintk(RIO_DEBUG_CTRL, "Get port params\n");
-		if (copyin((int) arg, (caddr_t) & PortParams, sizeof(struct PortParams)) == COPYFAIL) {
+		if (copy_from_user(&PortParams, arg, sizeof(struct PortParams))) {
 			p->RIOError.Error = COPYIN_FAILED;
 			return -EFAULT;
 		}
@@ -725,7 +598,7 @@
 		PortParams.State = PortP->State;
 		rio_dprintk(RIO_DEBUG_CTRL, "Port %d\n", PortParams.Port);
 
-		if (copyout((caddr_t) & PortParams, (int) arg, sizeof(struct PortParams)) == COPYFAIL) {
+		if (copy_to_user(arg, &PortParams, sizeof(struct PortParams))) {
 			p->RIOError.Error = COPYOUT_FAILED;
 			return -EFAULT;
 		}
@@ -733,8 +606,7 @@
 
 	case RIO_GET_PORT_TTY:
 		rio_dprintk(RIO_DEBUG_CTRL, "Get port tty\n");
-		if (copyin((int) arg, (caddr_t) & PortTty, sizeof(struct PortTty))
-		    == COPYFAIL) {
+		if (copy_from_user(&PortTty, arg, sizeof(struct PortTty))) {
 			p->RIOError.Error = COPYIN_FAILED;
 			return -EFAULT;
 		}
@@ -745,14 +617,14 @@
 
 		rio_dprintk(RIO_DEBUG_CTRL, "Port %d\n", PortTty.port);
 		PortP = (p->RIOPortp[PortTty.port]);
-		if (copyout((caddr_t) & PortTty, (int) arg, sizeof(struct PortTty)) == COPYFAIL) {
+		if (copy_to_user(arg, &PortTty, sizeof(struct PortTty))) {
 			p->RIOError.Error = COPYOUT_FAILED;
 			return -EFAULT;
 		}
 		return retval;
 
 	case RIO_SET_PORT_TTY:
-		if (copyin((int) arg, (caddr_t) & PortTty, sizeof(struct PortTty)) == COPYFAIL) {
+		if (copy_from_user(&PortTty, arg, sizeof(struct PortTty))) {
 			p->RIOError.Error = COPYIN_FAILED;
 			return -EFAULT;
 		}
@@ -767,8 +639,7 @@
 
 	case RIO_SET_PORT_PARAMS:
 		rio_dprintk(RIO_DEBUG_CTRL, "Set port params\n");
-		if (copyin((int) arg, (caddr_t) & PortParams, sizeof(PortParams))
-		    == COPYFAIL) {
+		if (copy_from_user(&PortParams, arg, sizeof(PortParams))) {
 			p->RIOError.Error = COPYIN_FAILED;
 			return -EFAULT;
 		}
@@ -784,7 +655,7 @@
 
 	case RIO_GET_PORT_STATS:
 		rio_dprintk(RIO_DEBUG_CTRL, "RIO_GET_PORT_STATS\n");
-		if (copyin((int) arg, (caddr_t) & portStats, sizeof(struct portStats)) == COPYFAIL) {
+		if (copy_from_user(&portStats, arg, sizeof(struct portStats))) {
 			p->RIOError.Error = COPYIN_FAILED;
 			return -EFAULT;
 		}
@@ -799,14 +670,14 @@
 		portStats.opens = PortP->opens;
 		portStats.closes = PortP->closes;
 		portStats.ioctls = PortP->ioctls;
-		if (copyout((caddr_t) & portStats, (int) arg, sizeof(struct portStats)) == COPYFAIL) {
+		if (copy_to_user(arg, &portStats, sizeof(struct portStats))) {
 			p->RIOError.Error = COPYOUT_FAILED;
 			return -EFAULT;
 		}
 		return retval;
 
 	case RIO_RESET_PORT_STATS:
-		port = (uint) arg;
+		port = (unsigned long) arg;
 		rio_dprintk(RIO_DEBUG_CTRL, "RIO_RESET_PORT_STATS\n");
 		if (port >= RIO_PORTS) {
 			p->RIOError.Error = PORT_NUMBER_OUT_OF_RANGE;
@@ -824,7 +695,7 @@
 
 	case RIO_GATHER_PORT_STATS:
 		rio_dprintk(RIO_DEBUG_CTRL, "RIO_GATHER_PORT_STATS\n");
-		if (copyin((int) arg, (caddr_t) & portStats, sizeof(struct portStats)) == COPYFAIL) {
+		if (copy_from_user(&portStats, arg, sizeof(struct portStats))) {
 			p->RIOError.Error = COPYIN_FAILED;
 			return -EFAULT;
 		}
@@ -840,7 +711,7 @@
 
 	case RIO_READ_CONFIG:
 		rio_dprintk(RIO_DEBUG_CTRL, "RIO_READ_CONFIG\n");
-		if (copyout((caddr_t) & p->RIOConf, (int) arg, sizeof(struct Conf)) == COPYFAIL) {
+		if (copy_to_user(arg, &p->RIOConf, sizeof(struct Conf))) {
 			p->RIOError.Error = COPYOUT_FAILED;
 			return -EFAULT;
 		}
@@ -852,8 +723,7 @@
 			p->RIOError.Error = NOT_SUPER_USER;
 			return -EPERM;
 		}
-		if (copyin((int) arg, (caddr_t) & p->RIOConf, sizeof(struct Conf))
-		    == COPYFAIL) {
+		if (copy_from_user(&p->RIOConf, arg, sizeof(struct Conf))) {
 			p->RIOError.Error = COPYIN_FAILED;
 			return -EFAULT;
 		}
@@ -862,7 +732,7 @@
 		 */
 		for (Host = 0; Host < p->RIONumHosts; Host++)
 			if ((p->RIOHosts[Host].Flags & RUN_STATE) == RC_RUNNING)
-				WWORD(p->RIOHosts[Host].ParmMapP->timer, p->RIOConf.Timer);
+				writew(p->RIOConf.Timer, &p->RIOHosts[Host].ParmMapP->timer);
 		return retval;
 
 	case RIO_START_POLLER:
@@ -881,8 +751,7 @@
 	case RIO_SETDEBUG:
 	case RIO_GETDEBUG:
 		rio_dprintk(RIO_DEBUG_CTRL, "RIO_SETDEBUG/RIO_GETDEBUG\n");
-		if (copyin((int) arg, (caddr_t) & DebugCtrl, sizeof(DebugCtrl))
-		    == COPYFAIL) {
+		if (copy_from_user(&DebugCtrl, arg, sizeof(DebugCtrl))) {
 			p->RIOError.Error = COPYIN_FAILED;
 			return -EFAULT;
 		}
@@ -899,7 +768,7 @@
 				rio_dprintk(RIO_DEBUG_CTRL, "Get global debug 0x%x wait 0x%x\n", p->rio_debug, p->RIODebugWait);
 				DebugCtrl.Debug = p->rio_debug;
 				DebugCtrl.Wait = p->RIODebugWait;
-				if (copyout((caddr_t) & DebugCtrl, (int) arg, sizeof(DebugCtrl)) == COPYFAIL) {
+				if (copy_to_user(arg, &DebugCtrl, sizeof(DebugCtrl))) {
 					rio_dprintk(RIO_DEBUG_CTRL, "RIO_SET/GET DEBUG: bad port number %d\n", DebugCtrl.SysPort);
 					p->RIOError.Error = COPYOUT_FAILED;
 					return -EFAULT;
@@ -921,7 +790,7 @@
 		} else {
 			rio_dprintk(RIO_DEBUG_CTRL, "RIO_GETDEBUG 0x%x\n", p->RIOPortp[DebugCtrl.SysPort]->Debug);
 			DebugCtrl.Debug = p->RIOPortp[DebugCtrl.SysPort]->Debug;
-			if (copyout((caddr_t) & DebugCtrl, (int) arg, sizeof(DebugCtrl)) == COPYFAIL) {
+			if (copy_to_user(arg, &DebugCtrl, sizeof(DebugCtrl))) {
 				rio_dprintk(RIO_DEBUG_CTRL, "RIO_GETDEBUG: Bad copy to user space\n");
 				p->RIOError.Error = COPYOUT_FAILED;
 				return -EFAULT;
@@ -936,43 +805,20 @@
 		 ** textual null terminated string.
 		 */
 		rio_dprintk(RIO_DEBUG_CTRL, "RIO_VERSID\n");
-		if (copyout((caddr_t) RIOVersid(), (int) arg, sizeof(struct rioVersion)) == COPYFAIL) {
+		if (copy_to_user(arg, RIOVersid(), sizeof(struct rioVersion))) {
 			rio_dprintk(RIO_DEBUG_CTRL, "RIO_VERSID: Bad copy to user space (host=%d)\n", Host);
 			p->RIOError.Error = COPYOUT_FAILED;
 			return -EFAULT;
 		}
 		return retval;
 
-		/*
-		 ** !!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!
-		 ** !! commented out previous 'RIO_VERSID' functionality !!
-		 ** !!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!
-		 **
-		 case RIO_VERSID:
-		 **
-		 ** Enquire about the release and version.
-		 ** We return MAX_VERSION_LEN bytes, being a textual null
-		 ** terminated string.
-		 **
-		 rio_dprint(RIO_DEBUG_CTRL, ("RIO_VERSID\n"));
-		 if (copyout((caddr_t)RIOVersid(),
-		 (int)arg, MAX_VERSION_LEN ) == COPYFAIL ) {
-		 rio_dprint(RIO_DEBUG_CTRL, ("RIO_VERSID: Bad copy to user space\n",Host));
-		 p->RIOError.Error = COPYOUT_FAILED;
-		 return -EFAULT;
-		 }
-		 return retval;
-		 **
-		 ** !!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!
-		 */
-
 	case RIO_NUM_HOSTS:
 		/*
 		 ** Enquire as to the number of hosts located
 		 ** at init time.
 		 */
 		rio_dprintk(RIO_DEBUG_CTRL, "RIO_NUM_HOSTS\n");
-		if (copyout((caddr_t) & p->RIONumHosts, (int) arg, sizeof(p->RIONumHosts)) == COPYFAIL) {
+		if (copy_to_user(arg, &p->RIONumHosts, sizeof(p->RIONumHosts))) {
 			rio_dprintk(RIO_DEBUG_CTRL, "RIO_NUM_HOSTS: Bad copy to user space\n");
 			p->RIOError.Error = COPYOUT_FAILED;
 			return -EFAULT;
@@ -983,7 +829,7 @@
 		/*
 		 ** Kill host. This may not be in the final version...
 		 */
-		rio_dprintk(RIO_DEBUG_CTRL, "RIO_HOST_FOAD %d\n", (int) arg);
+		rio_dprintk(RIO_DEBUG_CTRL, "RIO_HOST_FOAD %ld\n", (unsigned long) arg);
 		if (!su) {
 			rio_dprintk(RIO_DEBUG_CTRL, "RIO_HOST_FOAD: Not super user\n");
 			p->RIOError.Error = NOT_SUPER_USER;
@@ -994,7 +840,7 @@
 
 		for (Host = 0; Host < p->RIONumHosts; Host++) {
 			(void) RIOBoardTest(p->RIOHosts[Host].PaddrP, p->RIOHosts[Host].Caddr, p->RIOHosts[Host].Type, p->RIOHosts[Host].Slot);
-			bzero((caddr_t) & p->RIOHosts[Host].Flags, ((int) &p->RIOHosts[Host].____end_marker____) - ((int) &p->RIOHosts[Host].Flags));
+			memset(&p->RIOHosts[Host].Flags, 0, ((char *) &p->RIOHosts[Host].____end_marker____) - ((char *) &p->RIOHosts[Host].Flags));
 			p->RIOHosts[Host].Flags = RC_WAITING;
 		}
 		RIOFoadWakeup(p);
@@ -1017,7 +863,7 @@
 			p->RIOError.Error = NOT_SUPER_USER;
 			return -EPERM;
 		}
-		if (copyin((int) arg, (caddr_t) & DownLoad, sizeof(DownLoad)) == COPYFAIL) {
+		if (copy_from_user(&DownLoad, arg, sizeof(DownLoad))) {
 			rio_dprintk(RIO_DEBUG_CTRL, "RIO_DOWNLOAD: Copy in from user space failed\n");
 			p->RIOError.Error = COPYIN_FAILED;
 			return -EFAULT;
@@ -1045,9 +891,9 @@
 
 	case RIO_PARMS:
 		{
-			uint host;
+			unsigned int host;
 
-			if (copyin((int) arg, (caddr_t) & host, sizeof(host)) == COPYFAIL) {
+			if (copy_from_user(&host, arg, sizeof(host))) {
 				rio_dprintk(RIO_DEBUG_CTRL, "RIO_HOST_REQ: Copy in from user space failed\n");
 				p->RIOError.Error = COPYIN_FAILED;
 				return -EFAULT;
@@ -1056,7 +902,7 @@
 			 ** Fetch the parmmap
 			 */
 			rio_dprintk(RIO_DEBUG_CTRL, "RIO_PARMS\n");
-			if (copyout((caddr_t) p->RIOHosts[host].ParmMapP, (int) arg, sizeof(PARM_MAP)) == COPYFAIL) {
+			if (copy_to_user(arg, p->RIOHosts[host].ParmMapP, sizeof(PARM_MAP))) {
 				p->RIOError.Error = COPYOUT_FAILED;
 				rio_dprintk(RIO_DEBUG_CTRL, "RIO_PARMS: Copy out to user space failed\n");
 				return -EFAULT;
@@ -1066,7 +912,7 @@
 
 	case RIO_HOST_REQ:
 		rio_dprintk(RIO_DEBUG_CTRL, "RIO_HOST_REQ\n");
-		if (copyin((int) arg, (caddr_t) & HostReq, sizeof(HostReq)) == COPYFAIL) {
+		if (copy_from_user(&HostReq, arg, sizeof(HostReq))) {
 			rio_dprintk(RIO_DEBUG_CTRL, "RIO_HOST_REQ: Copy in from user space failed\n");
 			p->RIOError.Error = COPYIN_FAILED;
 			return -EFAULT;
@@ -1078,7 +924,7 @@
 		}
 		rio_dprintk(RIO_DEBUG_CTRL, "Request for host %d\n", HostReq.HostNum);
 
-		if (copyout((caddr_t) & p->RIOHosts[HostReq.HostNum], (int) HostReq.HostP, sizeof(struct Host)) == COPYFAIL) {
+		if (copy_to_user(HostReq.HostP, &p->RIOHosts[HostReq.HostNum], sizeof(struct Host))) {
 			p->RIOError.Error = COPYOUT_FAILED;
 			rio_dprintk(RIO_DEBUG_CTRL, "RIO_HOST_REQ: Bad copy to user space\n");
 			return -EFAULT;
@@ -1087,7 +933,7 @@
 
 	case RIO_HOST_DPRAM:
 		rio_dprintk(RIO_DEBUG_CTRL, "Request for DPRAM\n");
-		if (copyin((int) arg, (caddr_t) & HostDpRam, sizeof(HostDpRam)) == COPYFAIL) {
+		if (copy_from_user(&HostDpRam, arg, sizeof(HostDpRam))) {
 			rio_dprintk(RIO_DEBUG_CTRL, "RIO_HOST_DPRAM: Copy in from user space failed\n");
 			p->RIOError.Error = COPYIN_FAILED;
 			return -EFAULT;
@@ -1104,13 +950,13 @@
 			/* It's hardware like this that really gets on my tits. */
 			static unsigned char copy[sizeof(struct DpRam)];
 			for (off = 0; off < sizeof(struct DpRam); off++)
-				copy[off] = p->RIOHosts[HostDpRam.HostNum].Caddr[off];
-			if (copyout((caddr_t) copy, (int) HostDpRam.DpRamP, sizeof(struct DpRam)) == COPYFAIL) {
+				copy[off] = readb(&p->RIOHosts[HostDpRam.HostNum].Caddr[off]);
+			if (copy_to_user(HostDpRam.DpRamP, copy, sizeof(struct DpRam))) {
 				p->RIOError.Error = COPYOUT_FAILED;
 				rio_dprintk(RIO_DEBUG_CTRL, "RIO_HOST_DPRAM: Bad copy to user space\n");
 				return -EFAULT;
 			}
-		} else if (copyout((caddr_t) p->RIOHosts[HostDpRam.HostNum].Caddr, (int) HostDpRam.DpRamP, sizeof(struct DpRam)) == COPYFAIL) {
+		} else if (copy_to_user(HostDpRam.DpRamP, p->RIOHosts[HostDpRam.HostNum].Caddr, sizeof(struct DpRam))) {
 			p->RIOError.Error = COPYOUT_FAILED;
 			rio_dprintk(RIO_DEBUG_CTRL, "RIO_HOST_DPRAM: Bad copy to user space\n");
 			return -EFAULT;
@@ -1119,13 +965,13 @@
 
 	case RIO_SET_BUSY:
 		rio_dprintk(RIO_DEBUG_CTRL, "RIO_SET_BUSY\n");
-		if ((int) arg < 0 || (int) arg > 511) {
-			rio_dprintk(RIO_DEBUG_CTRL, "RIO_SET_BUSY: Bad port number %d\n", (int) arg);
+		if ((unsigned long) arg > 511) {
+			rio_dprintk(RIO_DEBUG_CTRL, "RIO_SET_BUSY: Bad port number %ld\n", (unsigned long) arg);
 			p->RIOError.Error = PORT_NUMBER_OUT_OF_RANGE;
 			return -EINVAL;
 		}
 		rio_spin_lock_irqsave(&PortP->portSem, flags);
-		p->RIOPortp[(int) arg]->State |= RIO_BUSY;
+		p->RIOPortp[(unsigned long) arg]->State |= RIO_BUSY;
 		rio_spin_unlock_irqrestore(&PortP->portSem, flags);
 		return retval;
 
@@ -1135,7 +981,7 @@
 		 ** (probably for debug reasons)
 		 */
 		rio_dprintk(RIO_DEBUG_CTRL, "RIO_HOST_PORT\n");
-		if (copyin((int) arg, (caddr_t) & PortReq, sizeof(PortReq)) == COPYFAIL) {
+		if (copy_from_user(&PortReq, arg, sizeof(PortReq))) {
 			rio_dprintk(RIO_DEBUG_CTRL, "RIO_HOST_PORT: Copy in from user space failed\n");
 			p->RIOError.Error = COPYIN_FAILED;
 			return -EFAULT;
@@ -1147,7 +993,7 @@
 			return -ENXIO;
 		}
 		rio_dprintk(RIO_DEBUG_CTRL, "Request for port %d\n", PortReq.SysPort);
-		if (copyout((caddr_t) p->RIOPortp[PortReq.SysPort], (int) PortReq.PortP, sizeof(struct Port)) == COPYFAIL) {
+		if (copy_to_user(PortReq.PortP, p->RIOPortp[PortReq.SysPort], sizeof(struct Port))) {
 			p->RIOError.Error = COPYOUT_FAILED;
 			rio_dprintk(RIO_DEBUG_CTRL, "RIO_HOST_PORT: Bad copy to user space\n");
 			return -EFAULT;
@@ -1160,7 +1006,7 @@
 		 ** (probably for debug reasons)
 		 */
 		rio_dprintk(RIO_DEBUG_CTRL, "RIO_HOST_RUP\n");
-		if (copyin((int) arg, (caddr_t) & RupReq, sizeof(RupReq)) == COPYFAIL) {
+		if (copy_from_user(&RupReq, arg, sizeof(RupReq))) {
 			rio_dprintk(RIO_DEBUG_CTRL, "RIO_HOST_RUP: Copy in from user space failed\n");
 			p->RIOError.Error = COPYIN_FAILED;
 			return -EFAULT;
@@ -1184,7 +1030,7 @@
 		}
 		rio_dprintk(RIO_DEBUG_CTRL, "Request for rup %d from host %d\n", RupReq.RupNum, RupReq.HostNum);
 
-		if (copyout((caddr_t) HostP->UnixRups[RupReq.RupNum].RupP, (int) RupReq.RupP, sizeof(struct RUP)) == COPYFAIL) {
+		if (copy_to_user(HostP->UnixRups[RupReq.RupNum].RupP, RupReq.RupP, sizeof(struct RUP))) {
 			p->RIOError.Error = COPYOUT_FAILED;
 			rio_dprintk(RIO_DEBUG_CTRL, "RIO_HOST_RUP: Bad copy to user space\n");
 			return -EFAULT;
@@ -1197,7 +1043,7 @@
 		 ** (probably for debug reasons)
 		 */
 		rio_dprintk(RIO_DEBUG_CTRL, "RIO_HOST_LPB\n");
-		if (copyin((int) arg, (caddr_t) & LpbReq, sizeof(LpbReq)) == COPYFAIL) {
+		if (copy_from_user(&LpbReq, arg, sizeof(LpbReq))) {
 			rio_dprintk(RIO_DEBUG_CTRL, "RIO_HOST_LPB: Bad copy from user space\n");
 			p->RIOError.Error = COPYIN_FAILED;
 			return -EFAULT;
@@ -1221,7 +1067,7 @@
 		}
 		rio_dprintk(RIO_DEBUG_CTRL, "Request for lpb %d from host %d\n", LpbReq.Link, LpbReq.Host);
 
-		if (copyout((caddr_t) & HostP->LinkStrP[LpbReq.Link], (int) LpbReq.LpbP, sizeof(struct LPB)) == COPYFAIL) {
+		if (copy_to_user(LpbReq.LpbP, &HostP->LinkStrP[LpbReq.Link], sizeof(struct LPB))) {
 			rio_dprintk(RIO_DEBUG_CTRL, "RIO_HOST_LPB: Bad copy to user space\n");
 			p->RIOError.Error = COPYOUT_FAILED;
 			return -EFAULT;
@@ -1252,12 +1098,13 @@
 			p->RIOError.Error = SIGNALS_ALREADY_SET;
 			return -EBUSY;
 		}
-		p->RIOSignalProcess = getpid();
+		/* FIXME: PID tracking */
+		p->RIOSignalProcess = current->pid;
 		p->RIOPrintDisabled = DONT_PRINT;
 		return retval;
 
 	case RIO_SIGNALS_OFF:
-		if (p->RIOSignalProcess != getpid()) {
+		if (p->RIOSignalProcess != current->pid) {
 			p->RIOError.Error = NOT_RECEIVING_PROCESS;
 			return -EPERM;
 		}
@@ -1294,7 +1141,7 @@
 	case RIO_MAP_B110_TO_110:
 	case RIO_MAP_B110_TO_115200:
 		rio_dprintk(RIO_DEBUG_CTRL, "Baud rate mapping\n");
-		port = (uint) arg;
+		port = (unsigned long) arg;
 		if (port < 0 || port > 511) {
 			rio_dprintk(RIO_DEBUG_CTRL, "Baud rate mapping: Bad port number %d\n", port);
 			p->RIOError.Error = PORT_NUMBER_OUT_OF_RANGE;
@@ -1324,7 +1171,7 @@
 
 	case RIO_SEND_PACKET:
 		rio_dprintk(RIO_DEBUG_CTRL, "RIO_SEND_PACKET\n");
-		if (copyin((int) arg, (caddr_t) & SendPack, sizeof(SendPack)) == COPYFAIL) {
+		if (copy_from_user(&SendPack, arg, sizeof(SendPack))) {
 			rio_dprintk(RIO_DEBUG_CTRL, "RIO_SEND_PACKET: Bad copy from user space\n");
 			p->RIOError.Error = COPYIN_FAILED;
 			return -EFAULT;
@@ -1344,9 +1191,9 @@
 		}
 
 		for (loop = 0; loop < (ushort) (SendPack.Len & 127); loop++)
-			WBYTE(PacketP->data[loop], SendPack.Data[loop]);
+			writeb(SendPack.Data[loop], &PacketP->data[loop]);
 
-		WBYTE(PacketP->len, SendPack.Len);
+		writeb(SendPack.Len, &PacketP->len);
 
 		add_transmit(PortP);
 		/*
@@ -1368,7 +1215,7 @@
 		return su ? 0 : -EPERM;
 
 	case RIO_WHAT_MESG:
-		if (copyout((caddr_t) & p->RIONoMessage, (int) arg, sizeof(p->RIONoMessage)) == COPYFAIL) {
+		if (copy_to_user(arg, &p->RIONoMessage, sizeof(p->RIONoMessage))) {
 			rio_dprintk(RIO_DEBUG_CTRL, "RIO_WHAT_MESG: Bad copy to user space\n");
 			p->RIOError.Error = COPYOUT_FAILED;
 			return -EFAULT;
@@ -1376,7 +1223,7 @@
 		return 0;
 
 	case RIO_MEM_DUMP:
-		if (copyin((int) arg, (caddr_t) & SubCmd, sizeof(struct SubCmdStruct)) == COPYFAIL) {
+		if (copy_from_user(&SubCmd, arg, sizeof(struct SubCmdStruct))) {
 			p->RIOError.Error = COPYIN_FAILED;
 			return -EFAULT;
 		}
@@ -1406,7 +1253,7 @@
 			PortP->State |= RIO_BUSY;
 
 		rio_spin_unlock_irqrestore(&PortP->portSem, flags);
-		if (copyout((caddr_t) p->RIOMemDump, (int) arg, MEMDUMP_SIZE) == COPYFAIL) {
+		if (copy_to_user(arg, p->RIOMemDump, MEMDUMP_SIZE)) {
 			rio_dprintk(RIO_DEBUG_CTRL, "RIO_MEM_DUMP copy failed\n");
 			p->RIOError.Error = COPYOUT_FAILED;
 			return -EFAULT;
@@ -1414,30 +1261,30 @@
 		return 0;
 
 	case RIO_TICK:
-		if ((int) arg < 0 || (int) arg >= p->RIONumHosts)
+		if ((unsigned long) arg >= p->RIONumHosts)
 			return -EINVAL;
-		rio_dprintk(RIO_DEBUG_CTRL, "Set interrupt for host %d\n", (int) arg);
-		WBYTE(p->RIOHosts[(int) arg].SetInt, 0xff);
+		rio_dprintk(RIO_DEBUG_CTRL, "Set interrupt for host %ld\n", (unsigned long) arg);
+		writeb(0xFF, &p->RIOHosts[(unsigned long) arg].SetInt);
 		return 0;
 
 	case RIO_TOCK:
-		if ((int) arg < 0 || (int) arg >= p->RIONumHosts)
+		if ((unsigned long) arg >= p->RIONumHosts)
 			return -EINVAL;
-		rio_dprintk(RIO_DEBUG_CTRL, "Clear interrupt for host %d\n", (int) arg);
-		WBYTE((p->RIOHosts[(int) arg].ResetInt), 0xff);
+		rio_dprintk(RIO_DEBUG_CTRL, "Clear interrupt for host %ld\n", (unsigned long) arg);
+		writeb(0xFF, &p->RIOHosts[(unsigned long) arg].ResetInt);
 		return 0;
 
 	case RIO_READ_CHECK:
 		/* Check reads for pkts with data[0] the same */
 		p->RIOReadCheck = !p->RIOReadCheck;
-		if (copyout((caddr_t) & p->RIOReadCheck, (int) arg, sizeof(uint)) == COPYFAIL) {
+		if (copy_to_user(arg, &p->RIOReadCheck, sizeof(unsigned int))) {
 			p->RIOError.Error = COPYOUT_FAILED;
 			return -EFAULT;
 		}
 		return 0;
 
 	case RIO_READ_REGISTER:
-		if (copyin((int) arg, (caddr_t) & SubCmd, sizeof(struct SubCmdStruct)) == COPYFAIL) {
+		if (copy_from_user(&SubCmd, arg, sizeof(struct SubCmdStruct))) {
 			p->RIOError.Error = COPYIN_FAILED;
 			return -EFAULT;
 		}
@@ -1472,7 +1319,7 @@
 			PortP->State |= RIO_BUSY;
 
 		rio_spin_unlock_irqrestore(&PortP->portSem, flags);
-		if (copyout((caddr_t) & p->CdRegister, (int) arg, sizeof(uint)) == COPYFAIL) {
+		if (copy_to_user(arg, &p->CdRegister, sizeof(unsigned int))) {
 			rio_dprintk(RIO_DEBUG_CTRL, "RIO_READ_REGISTER copy failed\n");
 			p->RIOError.Error = COPYOUT_FAILED;
 			return -EFAULT;
@@ -1485,21 +1332,22 @@
 		 */
 	case RIO_MAKE_DEV:
 		{
-			uint port = (uint) arg & RIO_MODEM_MASK;
+			unsigned int port = (unsigned long) arg & RIO_MODEM_MASK;
+			unsigned int ret;
 
-			switch ((uint) arg & RIO_DEV_MASK) {
+			switch ((unsigned long) arg & RIO_DEV_MASK) {
 			case RIO_DEV_DIRECT:
-				arg = (caddr_t) drv_makedev(MAJOR(dev), port);
-				rio_dprintk(RIO_DEBUG_CTRL, "Makedev direct 0x%x is 0x%x\n", port, (int) arg);
-				return (int) arg;
+				ret = drv_makedev(MAJOR(dev), port);
+				rio_dprintk(RIO_DEBUG_CTRL, "Makedev direct 0x%x is 0x%x\n", port, ret);
+				return ret;
 			case RIO_DEV_MODEM:
-				arg = (caddr_t) drv_makedev(MAJOR(dev), (port | RIO_MODEM_BIT));
-				rio_dprintk(RIO_DEBUG_CTRL, "Makedev modem 0x%x is 0x%x\n", port, (int) arg);
-				return (int) arg;
+				ret = drv_makedev(MAJOR(dev), (port | RIO_MODEM_BIT));
+				rio_dprintk(RIO_DEBUG_CTRL, "Makedev modem 0x%x is 0x%x\n", port, ret);
+				return ret;
 			case RIO_DEV_XPRINT:
-				arg = (caddr_t) drv_makedev(MAJOR(dev), port);
-				rio_dprintk(RIO_DEBUG_CTRL, "Makedev printer 0x%x is 0x%x\n", port, (int) arg);
-				return (int) arg;
+				ret = drv_makedev(MAJOR(dev), port);
+				rio_dprintk(RIO_DEBUG_CTRL, "Makedev printer 0x%x is 0x%x\n", port, ret);
+				return ret;
 			}
 			rio_dprintk(RIO_DEBUG_CTRL, "MAKE Device is called\n");
 			return -EINVAL;
@@ -1513,18 +1361,19 @@
 		{
 			dev_t dv;
 			int mino;
+			unsigned long ret;
 
-			dv = (dev_t) ((int) arg);
+			dv = (dev_t) ((unsigned long) arg);
 			mino = RIO_UNMODEM(dv);
 
 			if (RIO_ISMODEM(dv)) {
 				rio_dprintk(RIO_DEBUG_CTRL, "Minor for device 0x%x: modem %d\n", dv, mino);
-				arg = (caddr_t) (mino | RIO_DEV_MODEM);
+				ret = mino | RIO_DEV_MODEM;
 			} else {
 				rio_dprintk(RIO_DEBUG_CTRL, "Minor for device 0x%x: direct %d\n", dv, mino);
-				arg = (caddr_t) (mino | RIO_DEV_DIRECT);
+				ret = mino | RIO_DEV_DIRECT;
 			}
-			return (int) arg;
+			return ret;
 		}
 	}
 	rio_dprintk(RIO_DEBUG_CTRL, "INVALID DAEMON IOCTL 0x%x\n", cmd);
@@ -1537,10 +1386,7 @@
 /*
 ** Pre-emptive commands go on RUPs and are only one byte long.
 */
-int RIOPreemptiveCmd(p, PortP, Cmd)
-struct rio_info *p;
-struct Port *PortP;
-uchar Cmd;
+int RIOPreemptiveCmd(struct rio_info *p, struct Port *PortP, u8 Cmd)
 {
 	struct CmdBlk *CmdBlkP;
 	struct PktCmd_M *PktCmdP;
@@ -1558,7 +1404,7 @@
 		return RIO_FAIL;
 	}
 
-	rio_dprintk(RIO_DEBUG_CTRL, "Command blk 0x%x - InUse now %d\n", (int) CmdBlkP, PortP->InUse);
+	rio_dprintk(RIO_DEBUG_CTRL, "Command blk 0x%p - InUse now %d\n", CmdBlkP, PortP->InUse);
 
 	PktCmdP = (struct PktCmd_M *) &CmdBlkP->Packet.data[0];
 
@@ -1572,7 +1418,7 @@
 	CmdBlkP->Packet.dest_port = COMMAND_RUP;
 	CmdBlkP->Packet.len = PKT_CMD_BIT | 2;
 	CmdBlkP->PostFuncP = RIOUnUse;
-	CmdBlkP->PostArg = (int) PortP;
+	CmdBlkP->PostArg = (unsigned long) PortP;
 	PktCmdP->Command = Cmd;
 	port = PortP->HostPort % (ushort) PORTS_PER_RTA;
 	/*
@@ -1584,38 +1430,38 @@
 
 	switch (Cmd) {
 	case MEMDUMP:
-		rio_dprintk(RIO_DEBUG_CTRL, "Queue MEMDUMP command blk 0x%x (addr 0x%x)\n", (int) CmdBlkP, (int) SubCmd.Addr);
+		rio_dprintk(RIO_DEBUG_CTRL, "Queue MEMDUMP command blk 0x%p (addr 0x%x)\n", CmdBlkP, (int) SubCmd.Addr);
 		PktCmdP->SubCommand = MEMDUMP;
 		PktCmdP->SubAddr = SubCmd.Addr;
 		break;
 	case FCLOSE:
-		rio_dprintk(RIO_DEBUG_CTRL, "Queue FCLOSE command blk 0x%x\n", (int) CmdBlkP);
+		rio_dprintk(RIO_DEBUG_CTRL, "Queue FCLOSE command blk 0x%p\n", CmdBlkP);
 		break;
 	case READ_REGISTER:
-		rio_dprintk(RIO_DEBUG_CTRL, "Queue READ_REGISTER (0x%x) command blk 0x%x\n", (int) SubCmd.Addr, (int) CmdBlkP);
+		rio_dprintk(RIO_DEBUG_CTRL, "Queue READ_REGISTER (0x%x) command blk 0x%p\n", (int) SubCmd.Addr, CmdBlkP);
 		PktCmdP->SubCommand = READ_REGISTER;
 		PktCmdP->SubAddr = SubCmd.Addr;
 		break;
 	case RESUME:
-		rio_dprintk(RIO_DEBUG_CTRL, "Queue RESUME command blk 0x%x\n", (int) CmdBlkP);
+		rio_dprintk(RIO_DEBUG_CTRL, "Queue RESUME command blk 0x%p\n", CmdBlkP);
 		break;
 	case RFLUSH:
-		rio_dprintk(RIO_DEBUG_CTRL, "Queue RFLUSH command blk 0x%x\n", (int) CmdBlkP);
+		rio_dprintk(RIO_DEBUG_CTRL, "Queue RFLUSH command blk 0x%p\n", CmdBlkP);
 		CmdBlkP->PostFuncP = RIORFlushEnable;
 		break;
 	case SUSPEND:
-		rio_dprintk(RIO_DEBUG_CTRL, "Queue SUSPEND command blk 0x%x\n", (int) CmdBlkP);
+		rio_dprintk(RIO_DEBUG_CTRL, "Queue SUSPEND command blk 0x%p\n", CmdBlkP);
 		break;
 
 	case MGET:
-		rio_dprintk(RIO_DEBUG_CTRL, "Queue MGET command blk 0x%x\n", (int) CmdBlkP);
+		rio_dprintk(RIO_DEBUG_CTRL, "Queue MGET command blk 0x%p\n", CmdBlkP);
 		break;
 
 	case MSET:
 	case MBIC:
 	case MBIS:
 		CmdBlkP->Packet.data[4] = (char) PortP->ModemLines;
-		rio_dprintk(RIO_DEBUG_CTRL, "Queue MSET/MBIC/MBIS command blk 0x%x\n", (int) CmdBlkP);
+		rio_dprintk(RIO_DEBUG_CTRL, "Queue MSET/MBIC/MBIS command blk 0x%p\n", CmdBlkP);
 		break;
 
 	case WFLUSH:
@@ -1629,7 +1475,7 @@
 			RIOFreeCmdBlk(CmdBlkP);
 			return (RIO_FAIL);
 		} else {
-			rio_dprintk(RIO_DEBUG_CTRL, "Queue WFLUSH command blk 0x%x\n", (int) CmdBlkP);
+			rio_dprintk(RIO_DEBUG_CTRL, "Queue WFLUSH command blk 0x%p\n", CmdBlkP);
 			CmdBlkP->PostFuncP = RIOWFlushMark;
 		}
 		break;

