Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id <S129524AbQK1T7p>; Tue, 28 Nov 2000 14:59:45 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
        id <S129543AbQK1T7f>; Tue, 28 Nov 2000 14:59:35 -0500
Received: from penguin.e-mind.com ([195.223.140.120]:32628 "EHLO
        penguin.e-mind.com") by vger.kernel.org with ESMTP
        id <S129524AbQK1T7V>; Tue, 28 Nov 2000 14:59:21 -0500
Date: Tue, 28 Nov 2000 20:29:10 +0100
From: Andrea Arcangeli <andrea@suse.de>
To: Andreas Schwab <schwab@suse.de>, Linus Torvalds <torvalds@transmeta.com>,
        Karsten Keil <kkeil@suse.de>
Cc: Alexander Viro <viro@math.psu.edu>, kumon@flab.fujitsu.co.jp,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] removal of "static foo = 0"
Message-ID: <20001128202910.G14675@athlon.random>
In-Reply-To: <Pine.GSO.4.21.0011272234550.7352-100000@weyl.math.psu.edu> <200011280955.eAS9t6I22393@hawking.suse.de> <20001128161612.B14675@athlon.random> <200011281609.eASG9mP04909@hawking.suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200011281609.eASG9mP04909@hawking.suse.de>; from schwab@suse.de on Tue, Nov 28, 2000 at 05:09:48PM +0100
X-GnuPG-Key-URL: http://e-mind.com/~andrea/aa.gnupg.asc
X-PGP-Key-URL: http://e-mind.com/~andrea/aa.asc
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Nov 28, 2000 at 05:09:48PM +0100, Andreas Schwab wrote:
> including the Linux kernel. :-)

As it's a worthless extension it's always trivial to fixup after its removal :).

The fixup also shown that the sis_300 and sis_301 driver would break if used at
the same time (probably unlikely to happen as they're FB drivers though).

This patch compiles 2.4.0-test12-pre2 with -fno-common and it fixups some minor
compilation problem around the kernel. Karsten note the lc_start_delay_check
change I did to make it to compile, it's not implemented yet, it only compiles
right now.

Patch is verified to compile with almost everything linked into the kernel, and
it boots with my normal configuration.

--- 2.4.0-test12-pre2-fno-common/drivers/char/applicom.c.~1~	Thu Jul 13 06:58:42 2000
+++ 2.4.0-test12-pre2-fno-common/drivers/char/applicom.c	Tue Nov 28 19:07:05 2000
@@ -63,8 +63,8 @@
 #define PCI_DEVICE_ID_APPLICOM_PCIGENERIC     0x0001
 #define PCI_DEVICE_ID_APPLICOM_PCI2000IBS_CAN 0x0002
 #define PCI_DEVICE_ID_APPLICOM_PCI2000PFB     0x0003
-#define MAX_PCI_DEVICE_NUM 3
 #endif
+#define MAX_PCI_DEVICE_NUM 3
 
 static char *applicom_pci_devnames[] = {
 	"PCI board",
--- 2.4.0-test12-pre2-fno-common/drivers/isdn/hisax/isdnl3.c.~1~	Tue Nov 28 18:40:29 2000
+++ 2.4.0-test12-pre2-fno-common/drivers/isdn/hisax/isdnl3.c	Tue Nov 28 19:46:08 2000
@@ -522,6 +522,11 @@
 	l3ml3p(st, DL_RELEASE | CONFIRM);
 }
 
+static void
+lc_start_delay_check(struct FsmInst *fi, int event, void *arg)
+{
+	/* FIXME */
+}
 
 /* *INDENT-OFF* */
 static struct FsmNode L3FnList[] __initdata =
--- 2.4.0-test12-pre2-fno-common/drivers/isdn/hisax/nj_s.c.~1~	Tue Nov 28 18:40:29 2000
+++ 2.4.0-test12-pre2-fno-common/drivers/isdn/hisax/nj_s.c	Tue Nov 28 19:47:21 2000
@@ -75,7 +75,7 @@
 			(cs->hw.njet.last_is0 & NETJET_IRQM0_READ))
 			/* we have a read dma int */
 			read_tiger(cs);
-		if (cs->hw.njet.irqstat0 & NETJET_IRQM0_WRITE) !=
+		if ((cs->hw.njet.irqstat0 & NETJET_IRQM0_WRITE) !=
 			(cs->hw.njet.last_is0 & NETJET_IRQM0_WRITE))
 			/* we have a write dma int */
 			write_tiger(cs);
--- 2.4.0-test12-pre2-fno-common/drivers/isdn/hisax/nj_u.c.~1~	Tue Nov 28 18:40:29 2000
+++ 2.4.0-test12-pre2-fno-common/drivers/isdn/hisax/nj_u.c	Tue Nov 28 19:48:52 2000
@@ -11,6 +11,7 @@
 #include <linux/pci.h>
 #include <linux/interrupt.h>
 #include <linux/ppp_defs.h>
+#include <linux/init.h>
 #include "netjet.h"
 
 const char *NETjet_U_revision = "$Revision: 2.8 $";
@@ -131,7 +132,7 @@
 	return(0);
 }
 
-static struct pci_dev *dev_netjet __initdata;
+static struct pci_dev *dev_netjet __initdata = 0;
 
 int __init
 setup_netjet_u(struct IsdnCard *card)
--- 2.4.0-test12-pre2-fno-common/drivers/isdn/hisax/config.c.~1~	Tue Nov 28 18:40:29 2000
+++ 2.4.0-test12-pre2-fno-common/drivers/isdn/hisax/config.c	Tue Nov 28 20:04:59 2000
@@ -376,7 +376,7 @@
 #endif /* IO0_IO1 */
 #endif /* MODULE */
 
-static int nrcards;
+int nrcards;
 
 extern char *l1_revision;
 extern char *l2_revision;
--- 2.4.0-test12-pre2-fno-common/drivers/media/video/bttv.h.~1~	Tue Nov 28 18:50:21 2000
+++ 2.4.0-test12-pre2-fno-common/drivers/media/video/bttv.h	Tue Nov 28 18:51:19 2000
@@ -179,9 +179,9 @@
 
 /* i2c */
 #define I2C_CLIENTS_MAX 8
-struct i2c_algo_bit_data bttv_i2c_algo_template;
-struct i2c_adapter bttv_i2c_adap_template;
-struct i2c_client bttv_i2c_client_template;
+extern struct i2c_algo_bit_data bttv_i2c_algo_template;
+extern struct i2c_adapter bttv_i2c_adap_template;
+extern struct i2c_client bttv_i2c_client_template;
 void bttv_bit_setscl(void *data, int state);
 void bttv_bit_setsda(void *data, int state);
 void bttv_call_i2c_clients(struct bttv *btv, unsigned int cmd, void *arg);
--- 2.4.0-test12-pre2-fno-common/drivers/net/arlan.h.~1~	Tue Nov 28 19:10:06 2000
+++ 2.4.0-test12-pre2-fno-common/drivers/net/arlan.h	Tue Nov 28 19:11:44 2000
@@ -321,7 +321,7 @@
       int tx_queue_len;
 };
 
-struct arlan_conf_stru arlan_conf[MAX_ARLANS];
+extern struct arlan_conf_stru arlan_conf[MAX_ARLANS];
 
 struct TxParam
 {
--- 2.4.0-test12-pre2-fno-common/drivers/usb/storage/usb.h.~1~	Tue Nov 28 19:25:37 2000
+++ 2.4.0-test12-pre2-fno-common/drivers/usb/storage/usb.h	Tue Nov 28 19:40:11 2000
@@ -187,7 +187,7 @@
 extern struct semaphore us_list_semaphore;
 
 /* The structure which defines our driver */
-struct usb_driver usb_storage_driver;
+extern struct usb_driver usb_storage_driver;
 
 /* Function to fill an inquiry response. See usb.c for details */
 extern void fill_inquiry_response(struct us_data *us,
--- 2.4.0-test12-pre2-fno-common/drivers/video/sis/sis_300.h.~1~	Tue Nov 28 18:40:01 2000
+++ 2.4.0-test12-pre2-fno-common/drivers/video/sis/sis_300.h	Tue Nov 28 19:28:42 2000
@@ -95,15 +95,6 @@
 
 #endif
 
-USHORT      P3c4,P3d4,P3c0,P3ce,P3c2,P3ca,P3c6,P3c7,P3c8,P3c9,P3da;
-USHORT	 CRT1VCLKLen; //VCLKData table length of bytes of each entry
-USHORT   flag_clearbuffer; //0: no clear frame buffer 1:clear frame buffer
-int      RAMType;
-int      ModeIDOffset,StandTable,CRT1Table,ScreenOffset,VCLKData,MCLKData, ECLKData;
-int      REFIndex,ModeType;
-USHORT	 IF_DEF_LVDS,IF_DEF_TRUMPION;
-USHORT   VBInfo,LCDResInfo,LCDTypeInfo,LCDInfo;
-
 //int    init300(int,int,int);
 VOID   SetMemoryClock(ULONG);
 VOID   SetDRAMSize(PHW_DEVICE_EXTENSION);
--- 2.4.0-test12-pre2-fno-common/drivers/video/sis/sis_301.c.~1~	Tue Nov 28 18:40:01 2000
+++ 2.4.0-test12-pre2-fno-common/drivers/video/sis/sis_301.c	Tue Nov 28 19:39:25 2000
@@ -3,6 +3,14 @@
 #include <linux/config.h>
 #include "sis_301.h"
 
+static USHORT   P3c4,P3d4,P3c0,P3ce,P3c2,P3ca,P3c6,P3c7,P3c8,P3c9,P3da;
+static USHORT	flag_clearbuffer; //0:no clear frame buffer 1:clear frame buffer
+static int      RAMType;
+static int      ModeIDOffset,StandTable,CRT1Table,ScreenOffset,VCLKData,MCLKData, ECLKData;
+static int      REFIndex,ModeType;
+static USHORT VBInfo,LCDResInfo,LCDTypeInfo,LCDInfo;
+static USHORT	 IF_DEF_LVDS,IF_DEF_TRUMPION;
+
 #ifndef CONFIG_FB_SIS_LINUXBIOS
 
 BOOLEAN SetCRT2Group(USHORT BaseAddr,ULONG ROMAddr,USHORT ModeNo,
--- 2.4.0-test12-pre2-fno-common/drivers/video/sis/sis_300.c.~1~	Tue Nov 28 18:40:01 2000
+++ 2.4.0-test12-pre2-fno-common/drivers/video/sis/sis_300.c	Tue Nov 28 19:29:04 2000
@@ -7,6 +7,14 @@
 #pragma alloc_text(PAGE,SiSInit300)
 #endif
 
+static USHORT      P3c4,P3d4,P3c0,P3ce,P3c2,P3ca,P3c6,P3c7,P3c8,P3c9,P3da;
+static USHORT	 CRT1VCLKLen; //VCLKData table length of bytes of each entry
+static USHORT   flag_clearbuffer; //0: no clear frame buffer 1:clear frame buffer
+static int      RAMType;
+static int      ModeIDOffset,StandTable,CRT1Table,ScreenOffset,VCLKData,MCLKData, ECLKData;
+static int      REFIndex,ModeType;
+static USHORT	 IF_DEF_LVDS,IF_DEF_TRUMPION;
+static USHORT   VBInfo,LCDResInfo,LCDTypeInfo,LCDInfo;
 
 #ifdef NOBIOS
 BOOLEAN SiSInit300(PHW_DEVICE_EXTENSION HwDeviceExtension)
--- 2.4.0-test12-pre2-fno-common/drivers/video/sis/sis_301.h.~1~	Tue Nov 28 18:40:01 2000
+++ 2.4.0-test12-pre2-fno-common/drivers/video/sis/sis_301.h	Tue Nov 28 19:31:11 2000
@@ -3,7 +3,6 @@
 
 USHORT SetFlag,RVBHCFACT,RVBHCMAX,VGAVT,VGAHT,VT,HT,VGAVDE,VGAHDE;
 USHORT VDE,HDE,RVBHRS,NewFlickerMode,RY1COE,RY2COE,RY3COE,RY4COE;                
-;USHORT LCDResInfo,LCDTypeInfo,LCDInfo;
 USHORT VCLKLen;
 USHORT LCDHDES,LCDVDES;
 
@@ -180,14 +179,6 @@
 extern USHORT CGA_DAC[];
 extern USHORT EGA_DAC[];
 extern USHORT VGA_DAC[];
-
-extern USHORT   P3c4,P3d4,P3c0,P3ce,P3c2,P3ca,P3c6,P3c7,P3c8,P3c9,P3da;
-extern USHORT	flag_clearbuffer; //0:no clear frame buffer 1:clear frame buffer
-extern int      RAMType;
-extern int      ModeIDOffset,StandTable,CRT1Table,ScreenOffset,VCLKData,MCLKData, ECLKData;
-extern int      REFIndex,ModeType;
-extern USHORT VBInfo,LCDResInfo,LCDTypeInfo,LCDInfo;
-extern USHORT	 IF_DEF_LVDS,IF_DEF_TRUMPION;
 
 extern VOID     SetMemoryClock(ULONG);
 extern VOID     SetDRAMSize(PHW_DEVICE_EXTENSION);
--- 2.4.0-test12-pre2-fno-common/include/linux/vt_kern.h.~1~	Tue Nov 28 18:44:22 2000
+++ 2.4.0-test12-pre2-fno-common/include/linux/vt_kern.h	Tue Nov 28 18:46:26 2000
@@ -30,7 +30,7 @@
 	wait_queue_head_t paste_wait;
 } *vt_cons[MAX_NR_CONSOLES];
 
-void (*kd_mksound)(unsigned int hz, unsigned int ticks);
+extern void (*kd_mksound)(unsigned int hz, unsigned int ticks);
 
 /* console.c */
 
--- 2.4.0-test12-pre2-fno-common/include/linux/if_frad.h.~1~	Tue Nov 28 19:08:18 2000
+++ 2.4.0-test12-pre2-fno-common/include/linux/if_frad.h	Tue Nov 28 19:09:01 2000
@@ -192,7 +192,7 @@
 int register_frad(const char *name);
 int unregister_frad(const char *name);
 
-int (*dlci_ioctl_hook)(unsigned int, void *);
+extern int (*dlci_ioctl_hook)(unsigned int, void *);
 
 #endif __KERNEL__
 
--- 2.4.0-test12-pre2-fno-common/net/atm/lec.h.~1~	Tue Nov 28 20:01:59 2000
+++ 2.4.0-test12-pre2-fno-common/net/atm/lec.h	Tue Nov 28 20:02:45 2000
@@ -16,9 +16,9 @@
 
 #if defined (CONFIG_BRIDGE) || defined(CONFIG_BRIDGE_MODULE)
 #include <linux/if_bridge.h>
-struct net_bridge_fdb_entry *(*br_fdb_get_hook)(struct net_bridge *br,
+extern struct net_bridge_fdb_entry *(*br_fdb_get_hook)(struct net_bridge *br,
                                                 unsigned char *addr);
-void (*br_fdb_put_hook)(struct net_bridge_fdb_entry *ent);
+extern void (*br_fdb_put_hook)(struct net_bridge_fdb_entry *ent);
 #endif /* defined(CONFIG_BRIDGE) || defined(CONFIG_BRIDGE_MODULE) */
 
 #define LEC_HEADER_LEN 16
--- 2.4.0-test12-pre2-fno-common/net/bridge/br_private.h.~1~	Tue Nov 28 19:57:02 2000
+++ 2.4.0-test12-pre2-fno-common/net/bridge/br_private.h	Tue Nov 28 19:59:43 2000
@@ -112,8 +112,8 @@
 	int				gc_interval;
 };
 
-struct notifier_block br_device_notifier;
-unsigned char bridge_ula[6];
+extern struct notifier_block br_device_notifier;
+extern unsigned char bridge_ula[6];
 
 /* br.c */
 void br_dec_use_count(void);
--- 2.4.0-test12-pre2-fno-common/Makefile.~1~	Tue Nov 28 18:40:28 2000
+++ 2.4.0-test12-pre2-fno-common/Makefile	Tue Nov 28 18:42:50 2000
@@ -16,7 +16,7 @@
 FINDHPATH	= $(HPATH)/asm $(HPATH)/linux $(HPATH)/scsi $(HPATH)/net
 
 HOSTCC  	= gcc
-HOSTCFLAGS	= -Wall -Wstrict-prototypes -O2 -fomit-frame-pointer
+HOSTCFLAGS	= -Wall -Wstrict-prototypes -O2 -fomit-frame-pointer -fno-common
 
 CROSS_COMPILE 	=
 
@@ -87,7 +87,7 @@
 
 CPPFLAGS := -D__KERNEL__ -I$(HPATH)
 
-CFLAGS := $(CPPFLAGS) -Wall -Wstrict-prototypes -O2 -fomit-frame-pointer -fno-strict-aliasing
+CFLAGS := $(CPPFLAGS) -Wall -Wstrict-prototypes -O2 -fomit-frame-pointer -fno-strict-aliasing -fno-common
 AFLAGS := -D__ASSEMBLY__ $(CPPFLAGS)
 
 #



I'd suggest to include it into 2.4 until -fno-common will become the default in
gcc.

Patch is here too:

	ftp://ftp.us.kernel.org/pub/linux/kernel/people/andrea/patches/v2.4/2.4.0-test12-pre2/gcc-fno-common-1

Andrea
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
