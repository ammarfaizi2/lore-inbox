Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751454AbWDOJR3@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751454AbWDOJR3 (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 15 Apr 2006 05:17:29 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751606AbWDOJR3
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 15 Apr 2006 05:17:29 -0400
Received: from emailhub.stusta.mhn.de ([141.84.69.5]:10253 "HELO
	mailout.stusta.mhn.de") by vger.kernel.org with SMTP
	id S1751454AbWDOJR2 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 15 Apr 2006 05:17:28 -0400
Date: Sat, 15 Apr 2006 11:17:27 +0200
From: Adrian Bunk <bunk@stusta.de>
To: thomas@winischhofer.net
Cc: gregkh@suse.de, linux-usb-devel@lists.sourceforge.net,
       linux-kernel@vger.kernel.org
Subject: [2.6 patch] drivers/usb/misc/sisusbvga/: possible cleanups
Message-ID: <20060415091726.GC15022@stusta.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.11+cvs20060403
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This patch contains the following possible cleanups:
- make needlessly global functions static
- function and struct declarations belong into header files
- make SiS_VCLKData const
- #if 0 the following unused global functions:
  - sisusb.c: sisusb_writew()
  - sisusb.c: sisusb_readw()
  - sisusb_init.c: SiSUSB_GetModeID()

Signed-off-by: Adrian Bunk <bunk@stusta.de>

---

This patch was already sent on:
- 19 Jan 2006

 drivers/usb/misc/sisusbvga/sisusb.c        |   35 +++------------------
 drivers/usb/misc/sisusbvga/sisusb_con.c    |   24 +-------------
 drivers/usb/misc/sisusbvga/sisusb_init.c   |    4 +-
 drivers/usb/misc/sisusbvga/sisusb_init.h   |   20 ++++++++++--
 drivers/usb/misc/sisusbvga/sisusb_struct.h |    2 -
 5 files changed, 28 insertions(+), 57 deletions(-)

--- linux-2.6.16-rc1-mm1-full/drivers/usb/misc/sisusbvga/sisusb_struct.h.old	2006-01-18 23:56:05.000000000 +0100
+++ linux-2.6.16-rc1-mm1-full/drivers/usb/misc/sisusbvga/sisusb_struct.h	2006-01-18 23:56:20.000000000 +0100
@@ -161,7 +161,7 @@
 	const struct SiS_Ext		*SiS_EModeIDTable;
 	const struct SiS_Ext2		*SiS_RefIndex;
 	const struct SiS_CRT1Table	*SiS_CRT1Table;
-	struct SiS_VCLKData		*SiS_VCLKData;
+	const struct SiS_VCLKData	*SiS_VCLKData;
 	const struct SiS_ModeResInfo	*SiS_ModeResInfo;
 };
 
--- linux-2.6.16-rc1-mm1-full/drivers/usb/misc/sisusbvga/sisusb_init.h.old	2006-01-18 23:23:03.000000000 +0100
+++ linux-2.6.16-rc1-mm1-full/drivers/usb/misc/sisusbvga/sisusb_init.h	2006-01-18 23:53:06.000000000 +0100
@@ -690,7 +690,7 @@
    0x41}}   /* 0x54 */
 };
 
-static struct SiS_VCLKData SiSUSB_VCLKData[] =
+static const struct SiS_VCLKData SiSUSB_VCLKData[] =
 {
 	{ 0x1b,0xe1, 25}, /* 0x00 */
 	{ 0x4e,0xe4, 28}, /* 0x01 */
@@ -808,8 +808,8 @@
 	{ 0x2b,0xc2, 35}  /* 0x71 768@576@60 */
 };
 
-void		SiSUSBRegInit(struct SiS_Private *SiS_Pr, unsigned long BaseAddr);
-unsigned short	SiSUSB_GetModeID(int HDisplay, int VDisplay, int Depth);
+extern struct mutex disconnect_mutex;
+
 int		SiSUSBSetMode(struct SiS_Private *SiS_Pr, unsigned short ModeNo);
 int		SiSUSBSetVESAMode(struct SiS_Private *SiS_Pr, unsigned short VModeNo);
 
@@ -826,5 +826,19 @@
 extern int	sisusb_setidxregand(struct sisusb_usb_data *sisusb, int port,
 					u8 idx, u8 myand);
 
+void sisusb_delete(struct kref *kref);
+int sisusb_writeb(struct sisusb_usb_data *sisusb, u32 adr, u8 data);
+int sisusb_readb(struct sisusb_usb_data *sisusb, u32 adr, u8 *data);
+int sisusb_copy_memory(struct sisusb_usb_data *sisusb, char *src,
+		       u32 dest, int length, size_t *bytes_written);
+int sisusb_reset_text_mode(struct sisusb_usb_data *sisusb, int init);
+int sisusbcon_do_font_op(struct sisusb_usb_data *sisusb, int set, int slot,
+			 u8 *arg, int cmapsz, int ch512, int dorecalc,
+			 struct vc_data *c, int fh, int uplock); 
+void sisusb_set_cursor(struct sisusb_usb_data *sisusb, unsigned int location);
+int sisusb_console_init(struct sisusb_usb_data *sisusb, int first, int last);
+void sisusb_console_exit(struct sisusb_usb_data *sisusb);
+void sisusb_init_concode(void);
+
 #endif
 
--- linux-2.6.16-rc1-mm1-full/drivers/usb/misc/sisusbvga/sisusb_con.c.old	2006-01-18 23:23:51.000000000 +0100
+++ linux-2.6.16-rc1-mm1-full/drivers/usb/misc/sisusbvga/sisusb_con.c	2006-01-18 23:31:59.000000000 +0100
@@ -70,27 +70,9 @@
 #include <linux/vmalloc.h>
 
 #include "sisusb.h"
+#include "sisusb_init.h"
 
 #ifdef INCL_SISUSB_CON
-extern int sisusb_setreg(struct sisusb_usb_data *, int, u8);
-extern int sisusb_getreg(struct sisusb_usb_data *, int, u8 *);
-extern int sisusb_setidxreg(struct sisusb_usb_data *, int, u8, u8);
-extern int sisusb_getidxreg(struct sisusb_usb_data *, int, u8, u8 *);
-extern int sisusb_setidxregor(struct sisusb_usb_data *, int, u8, u8);
-extern int sisusb_setidxregand(struct sisusb_usb_data *, int, u8, u8);
-extern int sisusb_setidxregandor(struct sisusb_usb_data *, int, u8, u8, u8);
-
-extern int sisusb_writeb(struct sisusb_usb_data *sisusb, u32 adr, u8 data);
-extern int sisusb_readb(struct sisusb_usb_data *sisusb, u32 adr, u8 *data);
-extern int sisusb_writew(struct sisusb_usb_data *sisusb, u32 adr, u16 data);
-extern int sisusb_readw(struct sisusb_usb_data *sisusb, u32 adr, u16 *data);
-extern int sisusb_copy_memory(struct sisusb_usb_data *sisusb, char *src,
-			u32 dest, int length, size_t *bytes_written);
-
-extern void sisusb_delete(struct kref *kref);
-extern int sisusb_reset_text_mode(struct sisusb_usb_data *sisusb, int init);
-
-extern int SiSUSBSetMode(struct SiS_Private *SiS_Pr, unsigned short ModeNo);
 
 #define sisusbcon_writew(val, addr)	(*(addr) = (val))
 #define sisusbcon_readw(addr)		(*(addr))
@@ -103,8 +85,6 @@
 /* Forward declaration */
 static const struct consw sisusb_con;
 
-extern struct mutex disconnect_mutex;
-
 static inline void
 sisusbcon_memsetw(u16 *s, u16 c, unsigned int count)
 {
@@ -1487,7 +1467,7 @@
 
 #define SISUSBCONDUMMY	(void *)sisusbdummycon_dummy
 
-const struct consw sisusb_dummy_con = {
+static const struct consw sisusb_dummy_con = {
 	.owner =		THIS_MODULE,
 	.con_startup =		sisusbdummycon_startup,
 	.con_init =		sisusbdummycon_init,
--- linux-2.6.16-rc1-mm1-full/drivers/usb/misc/sisusbvga/sisusb.c.old	2006-01-18 23:24:40.000000000 +0100
+++ linux-2.6.16-rc1-mm1-full/drivers/usb/misc/sisusbvga/sisusb.c	2006-01-18 23:28:46.000000000 +0100
@@ -53,6 +53,7 @@
 #include <linux/vmalloc.h>
 
 #include "sisusb.h"
+#include "sisusb_init.h"
 
 #ifdef INCL_SISUSB_CON
 #include <linux/font.h>
@@ -63,36 +64,6 @@
 /* Forward declarations / clean-up routines */
 
 #ifdef INCL_SISUSB_CON
-int	sisusb_setreg(struct sisusb_usb_data *sisusb, int port, u8 data);
-int	sisusb_getreg(struct sisusb_usb_data *sisusb, int port, u8 *data);
-int	sisusb_setidxreg(struct sisusb_usb_data *sisusb, int port, u8 index, u8 data);
-int	sisusb_getidxreg(struct sisusb_usb_data *sisusb, int port, u8 index, u8 *data);
-int	sisusb_setidxregandor(struct sisusb_usb_data *sisusb, int port, u8 idx,	u8 myand, u8 myor);
-int	sisusb_setidxregor(struct sisusb_usb_data *sisusb, int port, u8 index, u8 myor);
-int	sisusb_setidxregand(struct sisusb_usb_data *sisusb, int port, u8 idx, u8 myand);
-
-int	sisusb_writeb(struct sisusb_usb_data *sisusb, u32 adr, u8 data);
-int	sisusb_readb(struct sisusb_usb_data *sisusb, u32 adr, u8 *data);
-int	sisusb_writew(struct sisusb_usb_data *sisusb, u32 adr, u16 data);
-int	sisusb_readw(struct sisusb_usb_data *sisusb, u32 adr, u16 *data);
-int	sisusb_copy_memory(struct sisusb_usb_data *sisusb, char *src,
-			u32 dest, int length, size_t *bytes_written);
-
-int	sisusb_reset_text_mode(struct sisusb_usb_data *sisusb, int init);
-
-extern int  SiSUSBSetMode(struct SiS_Private *SiS_Pr, unsigned short ModeNo);
-extern int  SiSUSBSetVESAMode(struct SiS_Private *SiS_Pr, unsigned short VModeNo);
-
-extern void sisusb_init_concode(void);
-extern int  sisusb_console_init(struct sisusb_usb_data *sisusb, int first, int last);
-extern void sisusb_console_exit(struct sisusb_usb_data *sisusb);
-
-extern void sisusb_set_cursor(struct sisusb_usb_data *sisusb, unsigned int location);
-
-extern int  sisusbcon_do_font_op(struct sisusb_usb_data *sisusb, int set, int slot,
-		u8 *arg, int cmapsz, int ch512, int dorecalc,
-		struct vc_data *c, int fh, int uplock);
-
 static int sisusb_first_vc = 0;
 static int sisusb_last_vc = 0;
 module_param_named(first, sisusb_first_vc, int, 0);
@@ -1449,6 +1420,8 @@
 	return(sisusb_read_memio_byte(sisusb, SISUSB_TYPE_MEM, adr, data));
 }
 
+#if 0
+
 int
 sisusb_writew(struct sisusb_usb_data *sisusb, u32 adr, u16 data)
 {
@@ -1461,6 +1434,8 @@
 	return(sisusb_read_memio_word(sisusb, SISUSB_TYPE_MEM, adr, data));
 }
 
+#endif  /*  0  */
+
 int
 sisusb_copy_memory(struct sisusb_usb_data *sisusb, char *src,
 			u32 dest, int length, size_t *bytes_written)
--- linux-2.6.16-rc1-mm1-full/drivers/usb/misc/sisusbvga/sisusb_init.c.old	2006-01-18 23:32:34.000000000 +0100
+++ linux-2.6.16-rc1-mm1-full/drivers/usb/misc/sisusbvga/sisusb_init.c	2006-01-18 23:33:14.000000000 +0100
@@ -74,6 +74,7 @@
 /*            HELPER: Get ModeID             */
 /*********************************************/
 
+#if 0
 unsigned short
 SiSUSB_GetModeID(int HDisplay, int VDisplay, int Depth)
 {
@@ -157,6 +158,7 @@
 
 	return ModeIndex;
 }
+#endif  /*  0  */
 
 /*********************************************/
 /*          HELPER: SetReg, GetReg           */
@@ -233,7 +235,7 @@
 /*        HELPER: Init Port Addresses        */
 /*********************************************/
 
-void
+static void
 SiSUSBRegInit(struct SiS_Private *SiS_Pr, unsigned long BaseAddr)
 {
 	SiS_Pr->SiS_P3c4 = BaseAddr + 0x14;

