Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262209AbUKQEgv@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262209AbUKQEgv (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 16 Nov 2004 23:36:51 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262210AbUKQEgv
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 16 Nov 2004 23:36:51 -0500
Received: from emailhub.stusta.mhn.de ([141.84.69.5]:51467 "HELO
	mailout.stusta.mhn.de") by vger.kernel.org with SMTP
	id S262209AbUKQEek (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 16 Nov 2004 23:34:40 -0500
Date: Wed, 17 Nov 2004 05:32:18 +0100
From: Adrian Bunk <bunk@stusta.de>
To: Andrew Morton <akpm@osdl.org>
Cc: R.E.Wolff@BitWizard.nl, linux-kernel@vger.kernel.org
Subject: [2.6 patch] small drivers/char/rio/ cleanups (fwd)
Message-ID: <20041117043218.GD4943@stusta.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.6+20040907i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


The atch below still compiles and applies against 2.6.10-rc2-mm1.

Please apply.


----- Forwarded message from Adrian Bunk <bunk@stusta.de> -----

Date:	Sat, 6 Nov 2004 23:28:46 +0100
From: Adrian Bunk <bunk@stusta.de>
To: R.E.Wolff@BitWizard.nl
Cc: linux-kernel@vger.kernel.org
Subject: [2.6 patch] small drivers/char/rio/ cleanups

The patch below does cleanups under drivers/char/rio/ including the 
following:
- remove some completely unused code
- make some needlessly global code static
- remove #ifndef linux code
- remove never enabled #ifdef XPRINT_SUPPORT code
- RIOStrlen -> string.h strlen
- RIOStrCmp -> string.h strcmp


diffstat output:
 drivers/char/rio/func.h      |   21 ----
 drivers/char/rio/rio_linux.c |   25 +----
 drivers/char/rio/rioboot.c   |    4 
 drivers/char/rio/riocmd.c    |   58 ------------
 drivers/char/rio/rioctrl.c   |   33 ------
 drivers/char/rio/rioinit.c   |   57 +++---------
 drivers/char/rio/riointr.c   |  166 -----------------------------------
 drivers/char/rio/rioroute.c  |   18 ++-
 drivers/char/rio/riotable.c  |   19 ----
 drivers/char/rio/riotty.c    |   17 ++-
 10 files changed, 57 insertions(+), 361 deletions(-)


Signed-off-by: Adrian Bunk <bunk@stusta.de>

--- linux-2.6.10-rc1-mm3-full/drivers/char/rio/func.h.old	2004-11-06 22:34:20.000000000 +0100
+++ linux-2.6.10-rc1-mm3-full/drivers/char/rio/func.h	2004-11-06 23:04:31.000000000 +0100
@@ -47,7 +47,6 @@
 int RIOBootCodeUNKNOWN(struct rio_info *, struct DownLoad *);
 void msec_timeout(struct Host *);
 int RIOBootRup(struct rio_info *, uint, struct Host *, struct PKT *);
-int RIOBootComplete(struct rio_info *, struct Host *, uint, struct PktCmd *);
 int RIOBootOk(struct rio_info *,struct Host *, ulong);
 int RIORtaBound(struct rio_info *, uint); 
 void FillSlot(int, int, uint, struct Host *);
@@ -61,15 +60,10 @@
 int RIOKillNeighbour(struct rio_info *, caddr_t);
 int RIOSuspendBootRta(struct Host *, int, int);
 int RIOFoadWakeup(struct rio_info *);
-int RIOCommandRup(struct rio_info *, uint, struct Host *, struct PKT *);
 struct CmdBlk * RIOGetCmdBlk(void);
 void RIOFreeCmdBlk(struct CmdBlk *);
 int RIOQueueCmdBlk(struct Host *, uint, struct CmdBlk *);
 void RIOPollHostCommands(struct rio_info *, struct Host *);
-int RIOStrlen(register char *);
-int RIOStrCmp(register char *, register char *);
-int RIOStrnCmp(register char *, register char *, int);
-void  RIOStrNCpy(char *, char *, int);
 int RIOWFlushMark(int, struct CmdBlk *);
 int RIORFlushEnable(int, struct CmdBlk *);
 int RIOUnUse(int, struct CmdBlk *);
@@ -77,7 +71,6 @@
 
 /* rioctrl.c */
 int copyin(int, caddr_t, int);
-int copyout(caddr_t, int, int);
 int riocontrol(struct rio_info *, dev_t,int,caddr_t,int); 
 int RIOPreemptiveCmd(struct rio_info *,struct Port *,uchar);
 
@@ -89,24 +82,17 @@
 caddr_t RIOCheckForATCard(int);
 int RIOAssignAT(struct rio_info *, int, caddr_t, int);
 int RIOBoardTest(paddr_t, caddr_t, uchar, int);
-int RIOScrub(int, BYTE *, int);
-void RIOAllocateInterrupts(struct rio_info *);
-void RIOStopInterrupts(struct rio_info *, int, int);
 void RIOAllocDataStructs(struct rio_info *);
 void RIOSetupDataStructs(struct rio_info *);
 int RIODefaultName(struct rio_info *, struct Host *, uint);
-int RIOReport(struct rio_info *);
 struct rioVersion * RIOVersid(void);
 int RIOMapin(paddr_t, int, caddr_t *);
 void RIOMapout(paddr_t, long, caddr_t);
 void RIOHostReset(uint, volatile struct DpRam *, uint);
 
 /* riointr.c */
-void riopoll(struct rio_info *);
-void riointr(struct rio_info *);
 void RIOTxEnable(char *);
 void RIOServiceHost(struct rio_info *, struct Host *, int);
-void RIOReceive(struct rio_info *, struct Port *);
 int riotproc(struct rio_info *, register struct ttystatics *, int, int);
 
 /* rioparam.c */
@@ -123,22 +109,15 @@
 /* rioroute.c */
 int RIORouteRup(struct rio_info *, uint, struct Host *, struct PKT *);
 void RIOFixPhbs(struct rio_info *, struct Host *, uint); 
-int RIOCheckIsolated(struct rio_info *, struct Host *, uint);
-int RIOIsolate(struct rio_info *, struct Host *, uint);
-int RIOCheck(struct Host *, uint);
 uint GetUnitType(uint);
 int RIOSetChange(struct rio_info *);
-void RIOConCon(struct rio_info *, struct Host *, uint, uint, uint, uint, int);
 int RIOFindFreeID(struct rio_info *, struct Host *, uint *, uint *);
-int RIOFreeDisconnected(struct rio_info *, struct Host *, int );
-int RIORemoveFromSavedTable(struct rio_info *, struct Map *);
 
 
 /* riotty.c */
 
 int riotopen(struct tty_struct * tty, struct file * filp);
 int riotclose(void  *ptr);
-int RIOCookMode(struct ttystatics *);
 int riotioctl(struct rio_info *, struct tty_struct *, register int, register caddr_t); 
 void ttyseth(struct Port *, struct ttystatics *, struct old_sgttyb *sg);
 
--- linux-2.6.10-rc1-mm3-full/drivers/char/rio/rio_linux.c.old	2004-11-06 22:30:51.000000000 +0100
+++ linux-2.6.10-rc1-mm3-full/drivers/char/rio/rio_linux.c	2004-11-06 22:33:14.000000000 +0100
@@ -33,10 +33,6 @@
  * */
 
 
-#define RCS_ID "$Id: rio.c,v 1.1 1999/07/11 10:13:54 wolff Exp wolff $"
-#define RCS_REV "$Revision: 1.1 $"
-
-
 #include <linux/module.h>
 #include <linux/config.h> 
 #include <linux/kdev_t.h>
@@ -198,7 +194,7 @@
 		         unsigned int cmd, unsigned long arg);
 static int rio_init_drivers(void);
 
-void my_hd (void *addr, int len);
+static void my_hd (void *addr, int len);
 
 static struct tty_driver *rio_driver, *rio_driver2;
 
@@ -206,11 +202,6 @@
 sources use all over the place. */
 struct rio_info *p;
 
-/* struct rio_board boards[RIO_HOSTS]; */
-struct rio_port *rio_ports;
-
-int rio_initialized;
-int rio_nports;
 int rio_debug;
 
 
@@ -218,12 +209,12 @@
     - Set rio_poll to 1 to poll every timer tick (10ms on Intel). 
       This is used when the card cannot use an interrupt for some reason.
 */
-int rio_poll = 1;
+static int rio_poll = 1;
 
 
 /* These are the only open spaces in my computer. Yours may have more
    or less.... */
-int rio_probe_addrs[]= {0xc0000, 0xd0000, 0xe0000};
+static int rio_probe_addrs[]= {0xc0000, 0xd0000, 0xe0000};
 
 #define NR_RIO_ADDRS (sizeof(rio_probe_addrs)/sizeof (int))
 
@@ -264,7 +255,7 @@
 	.ioctl		= rio_fw_ioctl,
 };
 
-struct miscdevice rio_fw_device = {
+static struct miscdevice rio_fw_device = {
 	RIOCTL_MISC_MINOR, "rioctl", &rio_fw_fops
 };
 
@@ -302,7 +293,7 @@
 
 
 #ifdef DEBUG
-void my_hd (void *ad, int len)
+static void my_hd (void *ad, int len)
 {
   int i, j, ch;
   unsigned char *addr = ad;
@@ -387,7 +378,7 @@
 }
 
 
-void rio_reset_interrupt (struct Host *HostP)
+static void rio_reset_interrupt (struct Host *HostP)
 {
   func_enter();
 
@@ -824,7 +815,7 @@
  * ********************************************************************** */
 
 
-struct vpd_prom *get_VPD_PROM (struct Host *hp)
+static struct vpd_prom *get_VPD_PROM (struct Host *hp)
 {
   static struct vpd_prom vpdp;
   char *p;
@@ -1045,7 +1036,7 @@
    EEprom.  As the bit is read/write for the CPU, we can fix it here,
    if we detect that it isn't set correctly. -- REW */
 
-void fix_rio_pci (struct pci_dev *pdev)
+static void fix_rio_pci (struct pci_dev *pdev)
 {
   unsigned int hwbase;
   unsigned long rebase;
--- linux-2.6.10-rc1-mm3-full/drivers/char/rio/rioboot.c.old	2004-11-06 22:34:35.000000000 +0100
+++ linux-2.6.10-rc1-mm3-full/drivers/char/rio/rioboot.c	2004-11-06 22:36:07.000000000 +0100
@@ -80,6 +80,8 @@
 #include "cmdblk.h"
 #include "route.h"
 
+static int RIOBootComplete( struct rio_info *p, struct Host *HostP, uint Rup, struct PktCmd *PktCmdP );
+
 static uchar
 RIOAtVec2Ctrl[] =
 {
@@ -802,7 +804,7 @@
 ** If booted by an RTA, HostP->Mapping[Rup].RtaUniqueNum is the booting RTA.
 ** RtaUniq is the booted RTA.
 */
-int RIOBootComplete( struct rio_info *p, struct Host *HostP, uint Rup, struct PktCmd *PktCmdP )
+static int RIOBootComplete( struct rio_info *p, struct Host *HostP, uint Rup, struct PktCmd *PktCmdP )
 {
 	struct Map	*MapP = NULL;
 	struct Map	*MapP2 = NULL;
--- linux-2.6.10-rc1-mm3-full/drivers/char/rio/riocmd.c.old	2004-11-06 22:37:01.000000000 +0100
+++ linux-2.6.10-rc1-mm3-full/drivers/char/rio/riocmd.c	2004-11-06 22:47:21.000000000 +0100
@@ -397,7 +397,7 @@
 /*
 ** Incoming command on the COMMAND_RUP to be processed.
 */
-int
+static int
 RIOCommandRup(p, Rup, HostP, PacketP)
 struct rio_info *	p;
 uint Rup;
@@ -917,62 +917,6 @@
 	} while ( Rup );
 }
 
-
-/*
-** Return the length of the named string
-*/
-int
-RIOStrlen(Str)
-register char *Str;
-{
-	register int len = 0;
-
-	while ( *Str++ )
-		len++;
-	return len;
-}
-
-/*
-** compares s1 to s2 and return 0 if they match.
-*/
-int
-RIOStrCmp(s1, s2)
-register char *s1;
-register char *s2;
-{
-	while ( *s1 && *s2 && *s1==*s2 )
-		s1++, s2++;
-	return *s1-*s2;
-}
-
-/*
-** compares s1 to s2 for upto n bytes and return 0 if they match.
-*/
-int
-RIOStrnCmp(s1, s2, n)
-register char *s1;
-register char *s2;
-int n;
-{
-	while ( n && *s1 && *s2 && *s1==*s2 )
-		n--, s1++, s2++;
-	return n ? *s1!=*s2 : 0;
-}
-
-/*
-** copy up to 'len' bytes from 'from' to 'to'.
-*/
-void
-RIOStrNCpy(to, from, len)
-char *to;
-char *from;
-int len; 
-{
-	while ( len-- && (*to++ = *from++) )
-		;
-	to[-1]='\0';
-}
-
 int
 RIOWFlushMark(iPortP, CmdBlkP)
 int iPortP;
--- linux-2.6.10-rc1-mm3-full/drivers/char/rio/riotable.c.old	2004-11-06 22:41:49.000000000 +0100
+++ linux-2.6.10-rc1-mm3-full/drivers/char/rio/riotable.c	2004-11-06 22:48:10.000000000 +0100
@@ -37,6 +37,7 @@
 #include <linux/slab.h>
 #include <linux/errno.h>
 #include <linux/interrupt.h>
+#include <linux/string.h>
 
 #include <asm/io.h>
 #include <asm/system.h>
@@ -276,7 +277,7 @@
 						return -ENXIO;
 					}
 					rio_dprintk (RIO_DEBUG_TABLE, "RIONewTable: entering(9)\n"); 
-					if (RIOStrCmp(MapP->Name,
+					if (strcmp(MapP->Name,
 							p->RIOConnectTable[SubEnt].Name)==0 && !(MapP->Flags & RTA16_SECOND_SLOT)) { /* (9) */
 						rio_dprintk (RIO_DEBUG_TABLE, "RTA name %s used twice\n", MapP->Name);
 						p->RIOError.Error = NAME_USED_TWICE;
@@ -405,7 +406,7 @@
 			for ( Host2=0; Host2<p->RIONumHosts; Host2++ ) {
 				if (Host2 == Host)
 					continue;
-				if (RIOStrCmp(p->RIOHosts[Host].Name, p->RIOHosts[Host2].Name)
+				if (strcmp(p->RIOHosts[Host].Name, p->RIOHosts[Host2].Name)
 									 == 0) {
 					NameIsUnique = 0;
 					Host1++;
@@ -940,20 +941,6 @@
 		PortP->FirstOpen	= 1;
 
 		/*
-		** handle the xprint issues
-		*/
-#ifdef XPRINT_SUPPORT
-		PortP->Xprint.XpActive	= 0;
-		PortP->Xprint.XttyP = &riox_tty[SysPort];
-		/*				TO				FROM			MAXLEN */
-		RIOStrNCpy( PortP->Xprint.XpOn,	RIOConf.XpOn,	MAX_XP_CTRL_LEN );
-		RIOStrNCpy( PortP->Xprint.XpOff, RIOConf.XpOff, MAX_XP_CTRL_LEN );
-		PortP->Xprint.XpCps = RIOConf.XpCps;
-		PortP->Xprint.XpLen = RIOStrlen(PortP->Xprint.XpOn)+
-									RIOStrlen(PortP->Xprint.XpOff);
-#endif
-
-		/*
 		** Buffers 'n things
 		*/
 		PortP->RxDataStart	= 0;
--- linux-2.6.10-rc1-mm3-full/drivers/char/rio/riotty.c.old	2004-11-06 22:44:54.000000000 +0100
+++ linux-2.6.10-rc1-mm3-full/drivers/char/rio/riotty.c	2004-11-06 23:13:06.000000000 +0100
@@ -40,6 +40,7 @@
 #include <linux/slab.h>
 #include <linux/errno.h>
 #include <linux/tty.h>
+#include <linux/string.h>
 #include <asm/io.h>
 #include <asm/system.h>
 #include <asm/string.h>
@@ -97,6 +98,9 @@
 int RIOShortCommand(struct rio_info *p, struct Port *PortP, 
 			   int command, int len, int arg);
 
+#if 0
+static int RIOCookMode(struct ttystatics *);
+#endif
 
 extern int	conv_vb[];	/* now defined in ttymgr.c */
 extern int	conv_bv[];	/* now defined in ttymgr.c */
@@ -726,7 +730,8 @@
 ** COOK_WELL if the line discipline must be used to do the processing
 ** COOK_MEDIUM if the card can do all the processing necessary.
 */
-int
+#if 0
+static int
 RIOCookMode(struct ttystatics *tp)
 {
 	/*
@@ -757,7 +762,7 @@
 	*/
 	return COOK_MEDIUM;
 }
-
+#endif
 
 static void
 RIOClearUp(PortP)
@@ -1011,8 +1016,8 @@
 				pseterr(EFAULT);
 			}
 			PortP->Xprint.XpOn[MAX_XP_CTRL_LEN-1] = '\0';
-			PortP->Xprint.XpLen = RIOStrlen(PortP->Xprint.XpOn)+
-												RIOStrlen(PortP->Xprint.XpOff);
+			PortP->Xprint.XpLen = strlen(PortP->Xprint.XpOn)+
+												strlen(PortP->Xprint.XpOff);
 			rio_spin_unlock_irqrestore(&PortP->portSem, flags);
 			return 0;
 
@@ -1026,8 +1031,8 @@
 				pseterr(EFAULT);
 			}
 			PortP->Xprint.XpOff[MAX_XP_CTRL_LEN-1] = '\0';
-			PortP->Xprint.XpLen = RIOStrlen(PortP->Xprint.XpOn)+
-										RIOStrlen(PortP->Xprint.XpOff);
+			PortP->Xprint.XpLen = strlen(PortP->Xprint.XpOn)+
+										strlen(PortP->Xprint.XpOff);
 			rio_spin_unlock_irqrestore(&PortP->portSem, flags);
 			return 0;
 
--- linux-2.6.10-rc1-mm3-full/drivers/char/rio/rioctrl.c.old	2004-11-06 22:49:27.000000000 +0100
+++ linux-2.6.10-rc1-mm3-full/drivers/char/rio/rioctrl.c	2004-11-06 22:51:02.000000000 +0100
@@ -130,7 +130,6 @@
 
 #define drv_makedev(maj, min) ((((uint) maj & 0xff) << 8) | ((uint) min & 0xff))
 
-#ifdef linux
 int copyin (int arg, caddr_t dp, int siz)
 {
   int rv;
@@ -141,8 +140,7 @@
   else return rv;
 }
 
-
-int copyout (caddr_t dp, int arg, int siz)
+static int copyout (caddr_t dp, int arg, int siz)
 {
   int rv;
 
@@ -152,35 +150,6 @@
   else return rv;
 }
 
-#else
-
-int
-copyin(arg, dp, siz)
-int arg;
-caddr_t dp;
-int siz; 
-{
-	if (rbounds ((unsigned long) arg) >= siz) {
-		bcopy ( arg, dp, siz );
-		return OK;
-	} else
-		return ( COPYFAIL );
-}
-
-int
-copyout (dp, arg, siz)
-caddr_t dp;
-int arg;
-int siz;
-{
-	if (wbounds ((unsigned long) arg) >=  siz ) {
-		bcopy ( dp, arg, siz );
-		return OK;
-	} else
-		return ( COPYFAIL );
-}
-#endif
-
 int
 riocontrol(p, dev, cmd, arg, su)
 struct rio_info	* p;
--- linux-2.6.10-rc1-mm3-full/drivers/char/rio/rioinit.c.old	2004-11-06 22:52:19.000000000 +0100
+++ linux-2.6.10-rc1-mm3-full/drivers/char/rio/rioinit.c	2004-11-06 23:16:55.000000000 +0100
@@ -84,9 +84,15 @@
 #undef bcopy
 #define bcopy rio_pcicopy
 
-int
-RIOPCIinit(struct rio_info *p, int Mode);
+int RIOPCIinit(struct rio_info *p, int Mode);
+
+#if 0
+static void RIOAllocateInterrupts(struct rio_info *);
+static int RIOReport(struct rio_info *);
+static void RIOStopInterrupts(struct rio_info *, int, int);
+#endif
 
+static int RIOScrub(int, BYTE *, int);
 
 #if 0
 extern int	rio_intr();
@@ -1116,7 +1122,7 @@
 ** Call with op not zero, and the RAM will be read and compated with val[op-1]
 ** to check that the data from the previous phase was retained.
 */
-int
+static int
 RIOScrub(op, ram, size)
 int		op;
 BYTE *	ram;
@@ -1262,7 +1268,8 @@
 ** and force into polled mode if told to. Patch up the
 ** interrupt vector & salute The Queen when you've done.
 */
-void
+#if 0
+static void
 RIOAllocateInterrupts(p)
 struct rio_info *	p;
 {
@@ -1301,7 +1308,7 @@
 ** new-fangled interrupt thingies. Set everything up to just
 ** poll.
 */
-void
+static void
 RIOStopInterrupts(p, Reason, Host)
 struct rio_info *	p;
 int	Reason;
@@ -1360,7 +1367,6 @@
 	}
 }
 
-#if 0
 /*
 ** This function is called at init time to setup the data structures.
 */
@@ -1476,7 +1482,8 @@
 #define RIO_RELEASE	"Linux"
 #define RELEASE_ID	"1.0"
 
-int
+#if 0
+static int
 RIOReport(p)
 struct rio_info *	p;
 {
@@ -1500,41 +1507,7 @@
 	}
 	return 0;
 }
-
-/*
-** This function returns release/version information as used by ioctl() calls
-** It returns a MAX_VERSION_LEN byte string, null terminated.
-*/
-char *
-OLD_RIOVersid( void )
-{
-	static char	Info[MAX_VERSION_LEN];
-	char *	RIORelease = RIO_RELEASE;
-	char *	cp;
-	int		ct = 0;
-
-	for ( ct=0; RIORelease[ct] && ct<MAX_VERSION_LEN; ct++ )
-		Info[ct] = RIORelease[ct];
-	if ( ct>=MAX_VERSION_LEN ) {
-		Info[MAX_VERSION_LEN-1] = '\0';
-		return Info;
-	}
-	Info[ct++]=' ';
-	if ( ct>=MAX_VERSION_LEN ) {
-		Info[MAX_VERSION_LEN-1] = '\0';
-		return Info;
-	}
-
-	cp="";	/* Fill the RCS Id here */
-
-	while ( *cp && ct<MAX_VERSION_LEN )
-		Info[ct++] = *cp++;
-	if ( ct<MAX_VERSION_LEN-1 )
-		Info[ct] = '\0';
-	Info[MAX_VERSION_LEN-1] = '\0';
-	return Info;
-}
-
+#endif
 
 static struct rioVersion	stVersion;
 
--- linux-2.6.10-rc1-mm3-full/drivers/char/rio/riointr.c.old	2004-11-06 22:55:10.000000000 +0100
+++ linux-2.6.10-rc1-mm3-full/drivers/char/rio/riointr.c	2004-11-06 23:09:28.000000000 +0100
@@ -84,83 +84,10 @@
 #include "rioioctl.h"
 
 
+static void RIOReceive(struct rio_info *, struct Port *);
 
 
-/*
-** riopoll is called every clock tick. Once the /dev/rio device has been
-** opened, and polldistributed( ) has been called, this routine is called
-** every clock tick *by every cpu*. The 'interesting' piece of code that
-** manipulates 'RIONumCpus' and 'RIOCpuCountdown' is used to fair-share
-** the work between the CPUs. If there are 'N' cpus, then each poll time
-** we increment a counter, modulo 'N-1'. When this counter is 0, we call
-** the interrupt handler. This has the effect that polls are serviced
-** by processor 'N', 'N-1', 'N-2', ... '0', round and round. Neat.
-*/
-void
-riopoll(p)
-struct rio_info *	p;
-{
-	int   host;
-
-	/*
-	** Here's the deal. We try to fair share as much as possible amongst
-	** all the processors that are available. Since each processor 
-	** should generate HZ ticks per second and since we only need HZ ticks
-	** in total for proper operation we simply attempt to cycle round each
-	** processor in turn, using RIOCpuCountdown to decide whether to call
-	** the interrupt routine. ( In fact the count zeroes when it reaches
-	** one less than the total number of processors - so e.g. on a two
-	** processor system RIOService will get called 2*HZ times per second. )
-	** this_cpu (cur_cpu()) tells us the number of the current processor
-	** as follows:
-	**
-	**		0 - default CPU
-	**		1 - first extra CPU
-	**		2 - second extra CPU
-	**		etc.
-	*/
-
-	/*
-	** okay, we've got a cpu that hasn't had a go recently 
-	** - lets check to see what needs doing.
-	*/
-	for ( host=0; host<p->RIONumHosts; host++ ) {
-		struct Host *HostP = &p->RIOHosts[host];
-
-		rio_spin_lock( &HostP->HostLock );
-
-		if ( ( (HostP->Flags & RUN_STATE) != RC_RUNNING ) ||
-		     HostP->InIntr ) {
-			rio_spin_unlock (&HostP->HostLock); 
-			continue;
-		}
-
-		if ( RWORD( HostP->ParmMapP->rup_intr ) ||
-			 RWORD( HostP->ParmMapP->rx_intr  ) ||
-			 RWORD( HostP->ParmMapP->tx_intr  ) ) {
-			HostP->InIntr = 1;
-
-#ifdef FUTURE_RELEASE
-			if( HostP->Type == RIO_EISA )
-				INBZ( HostP->Slot, EISA_INTERRUPT_RESET );
-			else
-#endif
-				WBYTE( HostP->ResetInt , 0xff );
-
-			rio_spin_lock(&HostP->HostLock); 
-
-			p->_RIO_Polled++;
-			RIOServiceHost(p, HostP, 'p' );
-			rio_spin_lock( &HostP->HostLock); 
-			HostP->InIntr = 0;
-			rio_spin_unlock (&HostP->HostLock);
-		}
-	}
-	rio_spin_unlock (&p->RIOIntrSem); 
-}
-
-
-char *firstchars (char *p, int nch)
+static char *firstchars (char *p, int nch)
 {
   static char buf[2][128];
   static int t=0;
@@ -258,93 +185,6 @@
 
 
 /*
-** When a real-life interrupt comes in here, we try to find out
-** which host card it belongs to, and then service only that host
-** Notice the cunning way that, once we've found a candidate, we
-** continue just in case we are sharing interrupts.
-*/
-void
-riointr(p)
-struct rio_info *	p;
-{
-	int host;
-
-	for ( host=0; host<p->RIONumHosts; host++ ) {
-		struct Host *HostP = &p->RIOHosts[host];
-
-		rio_dprintk (RIO_DEBUG_INTR,  "riointr() doing host %d type %d\n", host, HostP->Type);
-
-		switch( HostP->Type ) {
-			case RIO_AT:
-			case RIO_MCA:
-			case RIO_PCI:
-			  	rio_spin_lock(&HostP->HostLock);
-				WBYTE(HostP->ResetInt , 0xff);
-				if ( !HostP->InIntr ) {
-					HostP->InIntr = 1;
-					rio_spin_unlock (&HostP->HostLock);
-					p->_RIO_Interrupted++;
-					RIOServiceHost(p, HostP, 'i');
-					rio_spin_lock(&HostP->HostLock);
-					HostP->InIntr = 0;
-				}
-				rio_spin_unlock(&HostP->HostLock); 
-				break;
-#ifdef FUTURE_RELEASE
-		case RIO_EISA:
-			if ( ivec == HostP->Ivec )
-			{
-				OldSpl = LOCKB( &HostP->HostLock );
-				INBZ( HostP->Slot, EISA_INTERRUPT_RESET );
-				if ( !HostP->InIntr )
-				{
-					HostP->InIntr = 1;
-					UNLOCKB( &HostP->HostLock, OldSpl );
-					if ( this_cpu < RIO_CPU_LIMIT )
-					{
-						int intrSpl = LOCKB( &RIOIntrLock );
-						UNLOCKB( &RIOIntrLock, intrSpl );
-					}
-						p->_RIO_Interrupted++;
-					RIOServiceHost( HostP, 'i' );
-					OldSpl = LOCKB( &HostP->HostLock );
-					HostP->InIntr = 0;
-				}
-				UNLOCKB( &HostP->HostLock, OldSpl );
-				done++;
-			}
-			break;
-#endif
-		}
-
-		HostP->IntSrvDone++;
-	}
-
-#ifdef FUTURE_RELEASE
-	if ( !done )
-	{
-		cmn_err( CE_WARN, "RIO: Interrupt received with vector 0x%x\n", ivec );
-		cmn_err( CE_CONT, "	 Valid vectors are:\n");
-		for ( host=0; host<RIONumHosts; host++ )
-		{
-			switch( RIOHosts[host].Type )
-			{
-				case RIO_AT:
-				case RIO_MCA:
-				case RIO_EISA:
-						cmn_err( CE_CONT, "0x%x ", RIOHosts[host].Ivec );
-						break;
-				case RIO_PCI:
-						cmn_err( CE_CONT, "0x%x ", get_intr_arg( RIOHosts[host].PciDevInfo.busnum, IDIST_PCI_IRQ( RIOHosts[host].PciDevInfo.slotnum, RIOHosts[host].PciDevInfo.funcnum ) ));
-						break;
-			}
-		}
-		cmn_err( CE_CONT, "\n" );
-	}
-#endif
-}
-
-/*
 ** RIO Host Service routine. Does all the work traditionally associated with an
 ** interrupt.
 */
@@ -710,7 +550,7 @@
 ** NB: Called with the tty locked. The spl from the lockb( ) is passed.
 ** we return the ttySpl level that we re-locked at.
 */
-void
+static void
 RIOReceive(p, PortP)
 struct rio_info *	p;
 struct Port *		PortP;
--- linux-2.6.10-rc1-mm3-full/drivers/char/rio/rioroute.c.old	2004-11-06 22:59:46.000000000 +0100
+++ linux-2.6.10-rc1-mm3-full/drivers/char/rio/rioroute.c	2004-11-06 23:10:31.000000000 +0100
@@ -83,6 +83,12 @@
 #include "list.h"
 #include "sam.h"
 
+static int RIOCheckIsolated(struct rio_info *, struct Host *, uint);
+static int RIOIsolate(struct rio_info *, struct Host *, uint);
+static int RIOCheck(struct Host *, uint);
+static void RIOConCon(struct rio_info *, struct Host *, uint, uint, uint, uint, int);
+
+
 /*
 ** Incoming on the ROUTE_RUP
 ** I wrote this while I was tired. Forgive me.
@@ -717,7 +723,7 @@
 ** the world about it. This is done to ensure that the configurator
 ** only gets up-to-date information about what is going on.
 */
-int
+static int
 RIOCheckIsolated(p, HostP, UnitId)
 struct rio_info *	p;
 struct Host *HostP;
@@ -747,7 +753,7 @@
 ** all the units attached to it. This will mean that the entire
 ** subnet will re-introduce itself.
 */
-int
+static int
 RIOIsolate(p, HostP, UnitId)
 struct rio_info *	p;
 struct Host *		HostP;
@@ -782,7 +788,7 @@
 	return 1;
 }
 
-int
+static int
 RIOCheck(HostP, UnitId)
 struct Host *HostP;
 uint UnitId;
@@ -883,7 +889,7 @@
 	return(0);
 }
 
-void
+static void
 RIOConCon(p, HostP, FromId, FromLink, ToId, ToLink, Change)
 struct rio_info *	p;
 struct Host *HostP;
@@ -966,7 +972,7 @@
 ** Delete and RTA entry from the saved table given to us
 ** by the configuration program.
 */
-int
+static int
 RIORemoveFromSavedTable(struct rio_info *p, struct Map *pMap)
 {
     int		entry;
@@ -993,7 +999,7 @@
 ** Scan the unit links to and return zero if the unit is completely
 ** disconnected.
 */
-int
+static int
 RIOFreeDisconnected(struct rio_info *p, struct Host *HostP, int unit)
 {
     int		link;

-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
Please read the FAQ at  http://www.tux.org/lkml/

----- End forwarded message -----

