Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751972AbWCOML2@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751972AbWCOML2 (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 15 Mar 2006 07:11:28 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752024AbWCOML2
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 15 Mar 2006 07:11:28 -0500
Received: from outpipe-village-512-1.bc.nu ([81.2.110.250]:925 "EHLO
	lxorguk.ukuu.org.uk") by vger.kernel.org with ESMTP
	id S1751972AbWCOML1 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 15 Mar 2006 07:11:27 -0500
Subject: PATCH: rio driver rework continued  #1
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
To: linux-kernel@vger.kernel.org, akpm@osdl.org
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Date: Wed, 15 Mar 2006 12:17:32 +0000
Message-Id: <1142425052.5597.3.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Evolution 2.2.3 (2.2.3-2.fc4) 
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

More header cleanups, strip out typedefs and remove cruft. There are a
lot of magic macros that can go and also a great deal of abuse of
volatile that is not needed any more as this patch set cleans up the
misuse of pointer access to ISA and PCI space.

It now builds cleanly on 64bit, although there is more work left to do

Signed-off-by: Alan Cox <alan@redhat.com>

diff -u --new-file --recursive --exclude-from /usr/src/exclude linux.vanilla-2.6.16-rc6-mm1/drivers/char/rio/cmdpkt.h linux-2.6.16-rc6-mm1/drivers/char/rio/cmdpkt.h
--- linux.vanilla-2.6.16-rc6-mm1/drivers/char/rio/cmdpkt.h	2006-03-14 13:00:22.000000000 +0000
+++ linux-2.6.16-rc6-mm1/drivers/char/rio/cmdpkt.h	2006-03-14 13:51:57.000000000 +0000
@@ -118,45 +118,45 @@
 	union {
 		struct {
 			struct {
-				uchar PcCommand;
+				u8 PcCommand;
 				union {
-					uchar PcPhbNum;
-					uchar PcLinkNum;
-					uchar PcIDNum;
+					u8 PcPhbNum;
+					u8 PcLinkNum;
+					u8 PcIDNum;
 				} U0;
 			} CmdHdr;
 			struct {
-				ushort NumPackets;
-				ushort LoadBase;
-				ushort CodeSize;
+				u16 NumPackets;
+				u16 LoadBase;
+				u16 CodeSize;
 			} PcBootSequence;
 		} S1;
 		struct {
-			ushort PcSequence;
-			uchar PcBootData[RTA_BOOT_DATA_SIZE];
+			u16 PcSequence;
+			u8 PcBootData[RTA_BOOT_DATA_SIZE];
 		} S2;
 		struct {
-			ushort __crud__;
-			uchar PcUniqNum[4];	/* this is really a uint. */
-			uchar PcModuleTypes;	/* what modules are fitted */
+			u16 __crud__;
+			u8 PcUniqNum[4];	/* this is really a uint. */
+			u8 PcModuleTypes;	/* what modules are fitted */
 		} S3;
 		struct {
-			ushort __cmd_hdr__;
-			uchar __undefined__;
-			uchar PcModemStatus;
-			uchar PcPortStatus;
-			uchar PcSubCommand;
-			ushort PcSubAddr;
-			uchar PcSubData[64];
+			u16 __cmd_hdr__;
+			u8 __undefined__;
+			u8 PcModemStatus;
+			u8 PcPortStatus;
+			u8 PcSubCommand;
+			u16 PcSubAddr;
+			u8 PcSubData[64];
 		} S4;
 		struct {
-			ushort __cmd_hdr__;
-			uchar PcCommandText[1];
-			uchar __crud__[20];
-			uchar PcIDNum2;	/* Tacked on end */
+			u16 __cmd_hdr__;
+			u8 PcCommandText[1];
+			u8 __crud__[20];
+			u8 PcIDNum2;	/* Tacked on end */
 		} S5;
 		struct {
-			ushort __cmd_hdr__;
+			u16 __cmd_hdr__;
 			struct Top Topology[LINKS_PER_UNIT];
 		} S6;
 	} U1;
diff -u --new-file --recursive --exclude-from /usr/src/exclude linux.vanilla-2.6.16-rc6-mm1/drivers/char/rio/daemon.h linux-2.6.16-rc6-mm1/drivers/char/rio/daemon.h
--- linux.vanilla-2.6.16-rc6-mm1/drivers/char/rio/daemon.h	2006-03-14 12:59:37.000000000 +0000
+++ linux-2.6.16-rc6-mm1/drivers/char/rio/daemon.h	2006-03-14 13:53:10.000000000 +0000
@@ -45,15 +45,15 @@
 */
 
 struct Error {
-	uint Error;
-	uint Entry;
-	uint Other;
+	unsigned int Error;
+	unsigned int Entry;
+	unsigned int Other;
 };
 
 struct DownLoad {
 	char *DataP;
-	uint Count;
-	uint ProductCode;
+	unsigned int Count;
+	unsigned int ProductCode;
 };
 
 /*
@@ -68,69 +68,64 @@
 #endif
 
 struct PortSetup {
-	uint From;		/* Set/Clear XP & IXANY Control from this port.... */
-	uint To;		/* .... to this port */
-	uint XpCps;		/* at this speed */
+	unsigned int From;		/* Set/Clear XP & IXANY Control from this port.... */
+	unsigned int To;		/* .... to this port */
+	unsigned int XpCps;		/* at this speed */
 	char XpOn[MAX_XP_CTRL_LEN];	/* this is the start string */
 	char XpOff[MAX_XP_CTRL_LEN];	/* this is the stop string */
-	uchar IxAny;		/* enable/disable IXANY */
-	uchar IxOn;		/* enable/disable IXON */
-	uchar Lock;		/* lock port params */
-	uchar Store;		/* store params across closes */
-	uchar Drain;		/* close only when drained */
+	u8 IxAny;			/* enable/disable IXANY */
+	u8 IxOn;			/* enable/disable IXON */
+	u8 Lock;			/* lock port params */
+	u8 Store;			/* store params across closes */
+	u8 Drain;			/* close only when drained */
 };
 
 struct LpbReq {
-	uint Host;
-	uint Link;
+	unsigned int Host;
+	unsigned int Link;
 	struct LPB *LpbP;
 };
 
 struct RupReq {
-	uint HostNum;
-	uint RupNum;
+	unsigned int HostNum;
+	unsigned int RupNum;
 	struct RUP *RupP;
 };
 
 struct PortReq {
-	uint SysPort;
+	unsigned int SysPort;
 	struct Port *PortP;
 };
 
 struct StreamInfo {
-	uint SysPort;
-#if 0
-	queue_t RQueue;
-	queue_t WQueue;
-#else
+	unsigned int SysPort;
 	int RQueue;
 	int WQueue;
-#endif
 };
 
 struct HostReq {
-	uint HostNum;
+	unsigned int HostNum;
 	struct Host *HostP;
 };
 
 struct HostDpRam {
-	uint HostNum;
+	unsigned int HostNum;
 	struct DpRam *DpRamP;
 };
 
 struct DebugCtrl {
-	uint SysPort;
-	uint Debug;
-	uint Wait;
+	unsigned int SysPort;
+	unsigned int Debug;
+	unsigned int Wait;
 };
 
 struct MapInfo {
-	uint FirstPort;		/* 8 ports, starting from this (tty) number */
-	uint RtaUnique;		/* reside on this RTA (unique number) */
+	unsigned int FirstPort;		/* 8 ports, starting from this (tty) number */
+	unsigned int RtaUnique;		/* reside on this RTA (unique number) */
 };
 
 struct MapIn {
-	uint NumEntries;	/* How many port sets are we mapping? */
+	unsigned int NumEntries;	/* How many port sets are we mapping? */
 	struct MapInfo *MapInfoP;	/* Pointer to (user space) info */
 };
 
@@ -147,13 +142,13 @@
 };
 
 struct IdentifyRta {
-	ulong RtaUnique;
-	uchar ID;
+	unsigned long RtaUnique;
+	u8 ID;
 };
 
 struct KillNeighbour {
-	ulong UniqueNum;
-	uchar Link;
+	unsigned long UniqueNum;
+	u8 Link;
 };
 
 struct rioVersion {
diff -u --new-file --recursive --exclude-from /usr/src/exclude linux.vanilla-2.6.16-rc6-mm1/drivers/char/rio/host.h linux-2.6.16-rc6-mm1/drivers/char/rio/host.h
--- linux.vanilla-2.6.16-rc6-mm1/drivers/char/rio/host.h	2006-03-14 12:59:37.000000000 +0000
+++ linux-2.6.16-rc6-mm1/drivers/char/rio/host.h	2006-03-14 17:47:14.000000000 +0000
@@ -50,22 +50,20 @@
 **    the host.
 */
 struct Host {
-	uchar Type;		/* RIO_EISA, RIO_MCA, ... */
-	uchar Ivec;		/* POLLED or ivec number */
-	uchar Mode;		/* Control stuff */
-	uchar Slot;		/* Slot */
-	volatile caddr_t Caddr;	/* KV address of DPRAM */
-	volatile struct DpRam *CardP;	/* KV address of DPRAM, with overlay */
-	paddr_t PaddrP;		/* Phys. address of DPRAM */
+	unsigned char Type;		/* RIO_EISA, RIO_MCA, ... */
+	unsigned char Ivec;		/* POLLED or ivec number */
+	unsigned char Mode;		/* Control stuff */
+	unsigned char Slot;		/* Slot */
+	caddr_t Caddr;			/* KV address of DPRAM */
+	struct DpRam *CardP;		/* KV address of DPRAM, with overlay */
+	paddr_t PaddrP;			/* Phys. address of DPRAM */
 	char Name[MAX_NAME_LEN];	/* The name of the host */
-	uint UniqueNum;		/* host unique number */
+	unsigned int UniqueNum;		/* host unique number */
 	spinlock_t HostLock;	/* Lock structure for MPX */
-	/*struct pci_devinfo    PciDevInfo; *//* PCI Bus/Device/Function stuff */
-	/*struct lockb          HostLock;  *//* Lock structure for MPX */
-	uint WorkToBeDone;	/* set to true each interrupt */
-	uint InIntr;		/* Being serviced? */
-	uint IntSrvDone;	/* host's interrupt has been serviced */
-	int (*Copy) (caddr_t, caddr_t, int);	/* copy func */
+	unsigned int WorkToBeDone;	/* set to true each interrupt */
+	unsigned int InIntr;		/* Being serviced? */
+	unsigned int IntSrvDone;	/* host's interrupt has been serviced */
+	void (*Copy) (void *, void *, int);	/* copy func */
 	struct timer_list timer;
 	/*
 	 **               I M P O R T A N T !
@@ -74,7 +72,7 @@
 	 ** a RIO_HOST_FOAD command.
 	 */
 
-	ulong Flags;		/* Whats going down */
+	unsigned long Flags;			/* Whats going down */
 #define RC_WAITING            0
 #define RC_STARTUP            1
 #define RC_RUNNING            2
@@ -88,28 +86,28 @@
 ** Boot mode applies to the way in which hosts in this system will
 ** boot RTAs
 */
-#define RC_BOOT_ALL           0x8	/* Boot all RTAs attached */
-#define RC_BOOT_OWN           0x10	/* Only boot RTAs bound to this system */
-#define RC_BOOT_NONE          0x20	/* Don't boot any RTAs (slave mode) */
+#define RC_BOOT_ALL           0x8		/* Boot all RTAs attached */
+#define RC_BOOT_OWN           0x10		/* Only boot RTAs bound to this system */
+#define RC_BOOT_NONE          0x20		/* Don't boot any RTAs (slave mode) */
 
 	struct Top Topology[LINKS_PER_UNIT];	/* one per link */
-	struct Map Mapping[MAX_RUP];	/* Mappings for host */
-	struct PHB *PhbP;	/* Pointer to the PHB array */
-	ushort *PhbNumP;	/* Ptr to Number of PHB's */
-	struct LPB *LinkStrP;	/* Link Structure Array */
-	struct RUP *RupP;	/* Sixteen real rups here */
-	struct PARM_MAP *ParmMapP;	/* points to the parmmap */
-	uint ExtraUnits[MAX_EXTRA_UNITS];	/* unknown things */
-	uint NumExtraBooted;	/* how many of the above */
+	struct Map Mapping[MAX_RUP];		/* Mappings for host */
+	struct PHB *PhbP;			/* Pointer to the PHB array */
+	unsigned short *PhbNumP;		/* Ptr to Number of PHB's */
+	struct LPB *LinkStrP;			/* Link Structure Array */
+	struct RUP *RupP;			/* Sixteen real rups here */
+	struct PARM_MAP *ParmMapP;		/* points to the parmmap */
+	unsigned int ExtraUnits[MAX_EXTRA_UNITS];	/* unknown things */
+	unsigned int NumExtraBooted;		/* how many of the above */
 	/*
 	 ** Twenty logical rups.
 	 ** The first sixteen are the real Rup entries (above), the last four
 	 ** are the link RUPs.
 	 */
 	struct UnixRup UnixRups[MAX_RUP + LINKS_PER_UNIT];
-	int timeout_id;		/* For calling 100 ms delays */
-	int timeout_sem;	/* For calling 100 ms delays */
-	long locks;		/* long req'd for set_bit --RR */
+	int timeout_id;				/* For calling 100 ms delays */
+	int timeout_sem;			/* For calling 100 ms delays */
+	long locks;				/* long req'd for set_bit --RR */
 	char ____end_marker____;
 };
 #define Control      CardP->DpControl
diff -u --new-file --recursive --exclude-from /usr/src/exclude linux.vanilla-2.6.16-rc6-mm1/drivers/char/rio/link.h linux-2.6.16-rc6-mm1/drivers/char/rio/link.h
--- linux.vanilla-2.6.16-rc6-mm1/drivers/char/rio/link.h	2006-03-14 13:00:22.000000000 +0000
+++ linux-2.6.16-rc6-mm1/drivers/char/rio/link.h	2006-03-14 13:55:12.000000000 +0000
@@ -68,8 +68,8 @@
 	u16 mon_ltt;
 	u16 mon_lrt;
 	u16 WaitNoBoot;	/* Secs to hold off booting */
-	PKT_ptr add_packet_list;	/* Add packets to here */
-	PKT_ptr remove_packet_list;	/* Send packets from here */
+	u16 add_packet_list;	/* Add packets to here */
+	u16 remove_packet_list;	/* Send packets from here */
 
 	Channel_ptr lrt_fail_chan;	/* Lrt's failure channel */
 	Channel_ptr ltt_fail_chan;	/* Ltt's failure channel */
diff -u --new-file --recursive --exclude-from /usr/src/exclude linux.vanilla-2.6.16-rc6-mm1/drivers/char/rio/linux_compat.h linux-2.6.16-rc6-mm1/drivers/char/rio/linux_compat.h
--- linux.vanilla-2.6.16-rc6-mm1/drivers/char/rio/linux_compat.h	2006-03-14 12:59:37.000000000 +0000
+++ linux-2.6.16-rc6-mm1/drivers/char/rio/linux_compat.h	2006-03-14 15:12:00.000000000 +0000
@@ -19,56 +19,16 @@
 #include <linux/interrupt.h>
 
 
-#define disable(oldspl) save_flags (oldspl)
-#define restore(oldspl) restore_flags (oldspl)
-
-#define sysbrk(x) kmalloc ((x),in_interrupt()? GFP_ATOMIC : GFP_KERNEL)
-#define sysfree(p,size) kfree ((p))
-
-#define WBYTE(p,v) writeb(v, &p)
-#define RBYTE(p)   readb (&p)
-#define WWORD(p,v) writew(v, &p)
-#define RWORD(p)   readw(&p)
-#define WINDW(p,v) writew(v, p)
-#define RINDW(p)   readw(p)
-
 #define DEBUG_ALL
 
-#define cprintf printk
-
-#ifdef __KERNEL__
-#define INKERNEL
-#endif
-
 struct ttystatics {
 	struct termios tm;
 };
 
-#define bzero(d, n)         memset((d), 0, (n))
 #define bcopy(src, dest, n) memcpy ((dest), (src), (n))
 
 #define SEM_SIGIGNORE 0x1234
 
-#ifdef DEBUG_SEM
-#define swait(a,b)      printk ("waiting:    " __FILE__ " line %d\n", __LINE__)
-#define ssignal(sem)    printk ("signalling: " __FILE__ " line %d\n", __LINE__)
-
-#define sreset(sem)     printk ("sreset:     " __FILE__ "\n")
-#define sem_init(sem,v) printk ("sreset:     " __FILE__ "\n")
-#endif
-
-
-#define getpid()    (current->pid)
-
-#define QSIZE SERIAL_XMIT_SIZE
-
-#define pseterr(errno) return (- errno)
-
-#define V_CBAUD CBAUD
-
-/* For one reason or another rioboot.c uses delay instead of RIODelay. */
-#define delay(x,y) RIODelay(NULL, y)
-
 extern int rio_debug;
 
 #define RIO_DEBUG_INIT         0x000001
@@ -91,6 +51,7 @@
 #define RIO_DEBUG_DELAY        0x020000
 #define RIO_DEBUG_MOD_COUNT    0x040000
 
+
 /* Copied over from riowinif.h . This is ugly. The winif file declares
 also much other stuff which is incompatible with the headers from
 the older driver. The older driver includes "brates.h" which shadows
diff -u --new-file --recursive --exclude-from /usr/src/exclude linux.vanilla-2.6.16-rc6-mm1/drivers/char/rio/port.h linux-2.6.16-rc6-mm1/drivers/char/rio/port.h
--- linux.vanilla-2.6.16-rc6-mm1/drivers/char/rio/port.h	2006-03-14 13:00:22.000000000 +0000
+++ linux-2.6.16-rc6-mm1/drivers/char/rio/port.h	2006-03-14 17:26:39.000000000 +0000
@@ -40,7 +40,7 @@
 	struct gs_port gs;
 	int PortNum;			/* RIO port no., 0-511 */
 	struct Host *HostP;
-	volatile caddr_t Caddr;
+	caddr_t Caddr;
 	unsigned short HostPort;	/* Port number on host card */
 	unsigned char RupNum;		/* Number of RUP for port */
 	unsigned char ID2;		/* Second ID of RTA for port */
diff -u --new-file --recursive --exclude-from /usr/src/exclude linux.vanilla-2.6.16-rc6-mm1/drivers/char/rio/riodrvr.h linux-2.6.16-rc6-mm1/drivers/char/rio/riodrvr.h
--- linux.vanilla-2.6.16-rc6-mm1/drivers/char/rio/riodrvr.h	2006-03-14 12:59:37.000000000 +0000
+++ linux-2.6.16-rc6-mm1/drivers/char/rio/riodrvr.h	2006-03-14 14:59:44.000000000 +0000
@@ -72,42 +72,42 @@
 */
 	int RIOHalted;		/* halted ? */
 	int RIORtaDisCons;	/* RTA connections/disconnections */
-	uint RIOReadCheck;	/* Rio read check */
-	uint RIONoMessage;	/* To display message or not */
-	uint RIONumBootPkts;	/* how many packets for an RTA */
-	uint RIOBootCount;	/* size of RTA code */
-	uint RIOBooting;	/* count of outstanding boots */
-	uint RIOSystemUp;	/* Booted ?? */
-	uint RIOCounting;	/* for counting interrupts */
-	uint RIOIntCount;	/* # of intr since last check */
-	uint RIOTxCount;	/* number of xmit intrs  */
-	uint RIORxCount;	/* number of rx intrs */
-	uint RIORupCount;	/* number of rup intrs */
+	unsigned int RIOReadCheck;	/* Rio read check */
+	unsigned int RIONoMessage;	/* To display message or not */
+	unsigned int RIONumBootPkts;	/* how many packets for an RTA */
+	unsigned int RIOBootCount;	/* size of RTA code */
+	unsigned int RIOBooting;	/* count of outstanding boots */
+	unsigned int RIOSystemUp;	/* Booted ?? */
+	unsigned int RIOCounting;	/* for counting interrupts */
+	unsigned int RIOIntCount;	/* # of intr since last check */
+	unsigned int RIOTxCount;	/* number of xmit intrs  */
+	unsigned int RIORxCount;	/* number of rx intrs */
+	unsigned int RIORupCount;	/* number of rup intrs */
 	int RIXTimer;
 	int RIOBufferSize;	/* Buffersize */
 	int RIOBufferMask;	/* Buffersize */
 
 	int RIOFirstMajor;	/* First host card's major no */
 
-	uint RIOLastPortsMapped;	/* highest port number known */
-	uint RIOFirstPortsMapped;	/* lowest port number known */
+	unsigned int RIOLastPortsMapped;	/* highest port number known */
+	unsigned int RIOFirstPortsMapped;	/* lowest port number known */
 
-	uint RIOLastPortsBooted;	/* highest port number running */
-	uint RIOFirstPortsBooted;	/* lowest port number running */
+	unsigned int RIOLastPortsBooted;	/* highest port number running */
+	unsigned int RIOFirstPortsBooted;	/* lowest port number running */
 
-	uint RIOLastPortsOpened;	/* highest port number running */
-	uint RIOFirstPortsOpened;	/* lowest port number running */
+	unsigned int RIOLastPortsOpened;	/* highest port number running */
+	unsigned int RIOFirstPortsOpened;	/* lowest port number running */
 
 	/* Flag to say that the topology information has been changed. */
-	uint RIOQuickCheck;
-	uint CdRegister;	/* ??? */
+	unsigned int RIOQuickCheck;
+	unsigned int CdRegister;	/* ??? */
 	int RIOSignalProcess;	/* Signalling process */
 	int rio_debug;		/* To debug ... */
 	int RIODebugWait;	/* For what ??? */
 	int tpri;		/* Thread prio */
 	int tid;		/* Thread id */
-	uint _RIO_Polled;	/* Counter for polling */
-	uint _RIO_Interrupted;	/* Counter for interrupt */
+	unsigned int _RIO_Polled;	/* Counter for polling */
+	unsigned int _RIO_Interrupted;	/* Counter for interrupt */
 	int intr_tid;		/* iointset return value */
 	int TxEnSem;		/* TxEnable Semaphore */
 
@@ -121,9 +121,9 @@
 	struct Map RIOSavedTable[TOTAL_MAP_ENTRIES];
 
 	/* RTA to host binding table for master/slave operation */
-	ulong RIOBindTab[MAX_RTA_BINDINGS];
+	unsigned long RIOBindTab[MAX_RTA_BINDINGS];
 	/* RTA memory dump variable */
-	uchar RIOMemDump[MEMDUMP_SIZE];
+	unsigned char RIOMemDump[MEMDUMP_SIZE];
 	struct ModuleInfo RIOModuleTypes[MAX_MODULE_TYPES];
 
 };
@@ -138,7 +138,5 @@
 
 
 #define RIO_RESET_INT	0x7d80
-#define WRBYTE(x,y)		*(volatile unsigned char *)((x)) = \
-					(unsigned char)(y)
 
 #endif				/* __riodrvr.h */
diff -u --new-file --recursive --exclude-from /usr/src/exclude linux.vanilla-2.6.16-rc6-mm1/drivers/char/rio/rup.h linux-2.6.16-rc6-mm1/drivers/char/rio/rup.h
--- linux.vanilla-2.6.16-rc6-mm1/drivers/char/rio/rup.h	2006-03-14 13:00:22.000000000 +0000
+++ linux-2.6.16-rc6-mm1/drivers/char/rio/rup.h	2006-03-14 13:55:28.000000000 +0000
@@ -53,8 +53,8 @@
 #define RUP_NO_OWNER             0xff	/* RUP not owned by any process */
 
 struct RUP {
-	PKT_ptr txpkt;		/* Outgoing packet */
-	PKT_ptr rxpkt;		/* Incoming packet */
+	u16 txpkt;		/* Outgoing packet */
+	u16 rxpkt;		/* Incoming packet */
 	u16 link;		/* Which link to send down? */
 	u8 rup_dest_unit[2];	/* Destination unit */
 	u16 handshake;		/* For handshaking */
diff -u --new-file --recursive --exclude-from /usr/src/exclude linux.vanilla-2.6.16-rc6-mm1/drivers/char/rio/top.h linux-2.6.16-rc6-mm1/drivers/char/rio/top.h
--- linux.vanilla-2.6.16-rc6-mm1/drivers/char/rio/top.h	2006-03-14 12:59:37.000000000 +0000
+++ linux-2.6.16-rc6-mm1/drivers/char/rio/top.h	2006-03-14 15:00:00.000000000 +0000
@@ -41,8 +41,8 @@
 ** Topology information
 */
 struct Top {
-	uchar Unit;
-	uchar Link;
+	u8 Unit;
+	u8 Link;
 };
 
 #endif				/* __rio_top_h__ */
diff -u --new-file --recursive --exclude-from /usr/src/exclude linux.vanilla-2.6.16-rc6-mm1/drivers/char/rio/typdef.h linux-2.6.16-rc6-mm1/drivers/char/rio/typdef.h
--- linux.vanilla-2.6.16-rc6-mm1/drivers/char/rio/typdef.h	2006-03-14 13:00:22.000000000 +0000
+++ linux-2.6.16-rc6-mm1/drivers/char/rio/typdef.h	2006-03-14 17:26:58.000000000 +0000
@@ -39,10 +39,10 @@
 ** These types are ONLY to be used for refering to data structures
 ** on the RIO Host card!
 */
-typedef volatile u8 BYTE;
-typedef volatile u16 WORD;
-typedef volatile u32 DWORD;
-typedef volatile u16 RIOP;
+typedef u8 BYTE;
+typedef u16 WORD;
+typedef u32 DWORD;
+typedef u16 RIOP;
 
 
 /*
@@ -57,8 +57,7 @@
 typedef unsigned char uchar_t;
 typedef unsigned char queue_t;
 typedef unsigned char mblk_t;
-typedef unsigned int paddr_t;
-typedef unsigned char uchar;
+typedef unsigned long paddr_t;
 
 #define	TPNULL	((ushort)(0x8000))
 

