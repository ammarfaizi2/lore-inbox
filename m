Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S135713AbRDSVGu>; Thu, 19 Apr 2001 17:06:50 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S135714AbRDSVGl>; Thu, 19 Apr 2001 17:06:41 -0400
Received: from pille1.addcom.de ([62.96.128.35]:8709 "HELO pille1.addcom.de")
	by vger.kernel.org with SMTP id <S135713AbRDSVGa>;
	Thu, 19 Apr 2001 17:06:30 -0400
Date: Thu, 19 Apr 2001 23:06:37 +0200 (CEST)
From: Kai Germaschewski <kai@thphy.uni-duesseldorf.de>
X-X-Sender: <kai@vaio>
To: "Eric S. Raymond" <esr@thyrsus.com>
cc: CML2 <linux-kernel@vger.kernel.org>, <kbuild-devel@lists.sourceforge.net>,
        <i4ldeveloper@listserv.isdn4linux.de>
Subject: Re: [kbuild-devel] Dead symbol elimination, stage 1
In-Reply-To: <20010419131944.A3049@thyrsus.com>
Message-ID: <Pine.LNX.4.33.0104192251090.1232-100000@vaio>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 19 Apr 2001, Eric S. Raymond wrote:

> The following patch cleans dead symbols out of the defconfigs in the 2.4.4pre4
> source tree.  It corrects a typo involving CONFIG_GEN_RTC.  Another typo
> involving CONFIG_SOUND_YMPCI doesn't need to be corrected, as the symbol
> is never set in these files.

While I think your work CONFIG_ cleanup is generally a good idea and will
remove a lot of cruft, I don't think the defconfigs are worth the effort
(but maybe I'm missing something).

First, they are only used as defaults, and any inconsistency should get
cleaned up before the user even sees it.

Second, removing dead entries is not all which is needed to get a
defconfig which is necessarily consistent. So if you want to have these,
why don't you do a

	cp arch/$ARCH/defconfig .config
	make oldconfig

AFAICS, this should remove old cruft and provide a .config (to be used as
defconfig) which is consistent with the current config.in's.


Anyway, I put together a patch which should clean up some issues which I
was reminded of because of your work in the ISDN subsystem. I appended it,
I hope the maintainer of the Eicon code (Armin) will clean up the missing
Configure.help entries for his drivers.

--Kai

diff -ur linux-2.4.4-pre4/Documentation/Configure.help linux-2.4.4-pre4.config/Documentation/Configure.help
--- linux-2.4.4-pre4/Documentation/Configure.help	Thu Apr 19 21:49:17 2001
+++ linux-2.4.4-pre4.config/Documentation/Configure.help	Thu Apr 19 23:00:40 2001
@@ -15430,6 +15430,16 @@
   This enables HiSax support for the AMD7930 chips on some SPARCs.
   This code is not finished yet.

+ELSA PCMCIA MicroLink cards
+CONFIG_HISAX_ELSA_CS
+  This enables the PCMCIA client driver for the Elsa PCMCIA MicroLink
+  card
+
+Sedlbauer PCMCIA cards
+CONFIG_HISAX_SEDLBAUER_CS $CONFIG_PCMCIA
+  This enables the PCMCIA client driver for the Sedlbauer Speed Star
+  and Speed Star II cards.
+
 PCBIT-D support
 CONFIG_ISDN_DRV_PCBIT
   This enables support for the PCBIT ISDN-card. This card is
@@ -15503,6 +15513,33 @@
   compile it as a module, say M here and read
   Documentation/modules.txt.

+CAPI2.0 /dev/capi20 support
+CONFIG_ISDN_CAPI_CAPI20
+  This option will provide the CAPI 2.0 interface to userspace
+  applications via /dev/capi20. Applications should use the standardized
+  libcapi20 to access this functionality. You should say Y/M here.
+
+CAPI2.0 Middleware support
+CONFIG_ISDN_CAPI_MIDDLEWARE
+  This option will enhance the capabilities of the /dev/capi20 interface.
+  It will provide a means of moving a data connection, established
+  via the usual /dev/capi20 interface to a special tty device. If you want
+  to use pppd with pppdcapiplugin to dial up to your ISP, say Y here.
+
+CAPI2.0 filesystem support
+CONFIG_ISDN_CAPI_CAPIFS_BOOL
+  This option provides a special file system, similar to /dev/pts with
+  device nodes for the special ttys established by using the middleware
+  extension above. If you want to use pppd with pppdcapiplugin to dial up
+  to your ISP, say Y here.
+
+CAPI2.0 capidrv interface support
+CONFIG_ISDN_CAPI_CAPIDRV
+  This option provides the glue code to hook up CAPI driven cards to
+  the legacy isdn4linux link layer. If you have a card which is supported
+  by a CAPI driver, but still want to use old features like ippp
+  interfaces or ttyI emulation, say Y/M here.
+
 AVM B1 ISA support
 CONFIG_ISDN_DRV_AVMB1_B1ISA
   Enable support for the ISA version of the AVM B1 card.
@@ -15523,6 +15560,11 @@
 AVM B1/M1/M2 PCMCIA support
 CONFIG_ISDN_DRV_AVMB1_B1PCMCIA
   Enable support for the PCMCIA version of the AVM B1 card.
+
+AVM B1/M1/M2 PCMCIA cs module
+CONFIG_ISDN_DRV_AVMB1_AVM_CS
+  Enable the PCMCIA client driver for the AVM B1/M1/M2
+  PCMCIA cards.

 AVM T1/T1-B PCI support
 CONFIG_ISDN_DRV_AVMB1_T1PCI
diff -ur linux-2.4.4-pre4/drivers/isdn/Config.in linux-2.4.4-pre4.config/drivers/isdn/Config.in
--- linux-2.4.4-pre4/drivers/isdn/Config.in	Thu Apr 19 21:49:37 2001
+++ linux-2.4.4-pre4.config/drivers/isdn/Config.in	Thu Apr 19 22:49:07 2001
@@ -110,8 +110,8 @@
 tristate           'CAPI2.0 support' CONFIG_ISDN_CAPI
 if [ "$CONFIG_ISDN_CAPI" != "n" ]; then
    bool            '  Verbose reason code reporting (kernel size +=7K)' CONFIG_ISDN_DRV_AVMB1_VERBOSE_REASON
-   dep_bool        '  CAPI2.0 Middleware support (EXPERIMENTAL)' CONFIG_ISDN_CAPI_MIDDLEWARE $CONFIG_EXPERIMENTAL
    dep_tristate    '  CAPI2.0 /dev/capi support' CONFIG_ISDN_CAPI_CAPI20 $CONFIG_ISDN_CAPI
+   dep_mbool       '  CAPI2.0 Middleware support (EXPERIMENTAL)' CONFIG_ISDN_CAPI_MIDDLEWARE $CONFIG_ISDN_CAPI_CAPI20 $CONFIG_EXPERIMENTAL
    if [ "$CONFIG_ISDN_CAPI_MIDDLEWARE" = "y" ]; then
       dep_mbool    '    CAPI2.0 filesystem support' CONFIG_ISDN_CAPI_CAPIFS_BOOL $CONFIG_ISDN_CAPI_CAPI20
       if [ "$CONFIG_ISDN_CAPI_CAPIFS_BOOL" = "y" ]; then
diff -ur linux-2.4.4-pre4/drivers/isdn/avmb1/b1dma.c linux-2.4.4-pre4.config/drivers/isdn/avmb1/b1dma.c
--- linux-2.4.4-pre4/drivers/isdn/avmb1/b1dma.c	Fri Mar 30 10:40:56 2001
+++ linux-2.4.4-pre4.config/drivers/isdn/avmb1/b1dma.c	Thu Apr 19 22:09:56 2001
@@ -71,6 +71,9 @@
 #include "capicmd.h"
 #include "capiutil.h"

+#undef B1DMA_DEBUG
+#undef B1DMA_POLLDEBUG
+
 static char *revision = "$Revision: 1.11.6.3 $";

 /* ------------------------------------------------------------- */
@@ -412,7 +415,7 @@

 	skb = skb_dequeue(&dma->send_queue);
 	if (!skb) {
-#ifdef CONFIG_B1DMA_DEBUG
+#ifdef B1DMA_DEBUG
 		printk(KERN_DEBUG "tx(%d): underrun\n", inint);
 #endif
 	        restore_flags(flags);
@@ -437,17 +440,17 @@
 			_put_slice(&p, skb->data, len);
 		}
 		txlen = (__u8 *)p - (__u8 *)dma->sendbuf;
-#ifdef CONFIG_B1DMA_DEBUG
+#ifdef B1DMA_DEBUG
 		printk(KERN_DEBUG "tx(%d): put msg len=%d\n",
 				inint, txlen);
 #endif
 	} else {
 		txlen = skb->len-2;
-#ifdef CONFIG_B1DMA_POLLDEBUG
+#ifdef B1DMA_POLLDEBUG
 		if (skb->data[2] == SEND_POLLACK)
 			printk(KERN_INFO "%s: send ack\n", card->name);
 #endif
-#ifdef CONFIG_B1DMA_DEBUG
+#ifdef B1DMA_DEBUG
 		printk(KERN_DEBUG "tx(%d): put 0x%x len=%d\n",
 				inint, skb->data[2], txlen);
 #endif
@@ -502,7 +505,7 @@
 	__u32 ApplId, MsgLen, DataB3Len, NCCI, WindowSize;
 	__u8 b1cmd =  _get_byte(&p);

-#ifdef CONFIG_B1DMA_DEBUG
+#ifdef B1DMA_DEBUG
 	printk(KERN_DEBUG "rx: 0x%x %lu\n", b1cmd, (unsigned long)dma->recvlen);
 #endif

@@ -562,7 +565,7 @@
 		break;

 	case RECEIVE_START:
-#ifdef CONFIG_B1DMA_POLLDEBUG
+#ifdef B1DMA_POLLDEBUG
 		printk(KERN_INFO "%s: receive poll\n", card->name);
 #endif
 		if (!suppress_pollack)
diff -ur linux-2.4.4-pre4/drivers/isdn/avmb1/c4.c linux-2.4.4-pre4.config/drivers/isdn/avmb1/c4.c
--- linux-2.4.4-pre4/drivers/isdn/avmb1/c4.c	Fri Mar 30 10:40:56 2001
+++ linux-2.4.4-pre4.config/drivers/isdn/avmb1/c4.c	Thu Apr 19 22:10:19 2001
@@ -120,8 +120,8 @@

 static char *revision = "$Revision: 1.20.6.5 $";

-#undef CONFIG_C4_DEBUG
-#undef CONFIG_C4_POLLDEBUG
+#undef C4_DEBUG
+#undef C4_POLLDEBUG

 /* ------------------------------------------------------------- */

@@ -512,7 +512,7 @@

 	skb = skb_dequeue(&dma->send_queue);
 	if (!skb) {
-#ifdef CONFIG_C4_DEBUG
+#ifdef C4_DEBUG
 		printk(KERN_DEBUG "%s: tx underrun\n", card->name);
 #endif
 	        restore_flags(flags);
@@ -537,16 +537,16 @@
 			_put_slice(&p, skb->data, len);
 		}
 		txlen = (__u8 *)p - (__u8 *)dma->sendbuf;
-#ifdef CONFIG_C4_DEBUG
+#ifdef C4_DEBUG
 		printk(KERN_DEBUG "%s: tx put msg len=%d\n", card->name, txlen);
 #endif
 	} else {
 		txlen = skb->len-2;
-#ifdef CONFIG_C4_POLLDEBUG
+#ifdef C4_POLLDEBUG
 		if (skb->data[2] == SEND_POLLACK)
 			printk(KERN_INFO "%s: ack to c4\n", card->name);
 #endif
-#ifdef CONFIG_C4_DEBUG
+#ifdef C4_DEBUG
 		printk(KERN_DEBUG "%s: tx put 0x%x len=%d\n",
 				card->name, skb->data[2], txlen);
 #endif
@@ -602,7 +602,7 @@
 	__u32 cidx;


-#ifdef CONFIG_C4_DEBUG
+#ifdef C4_DEBUG
 	printk(KERN_DEBUG "%s: rx 0x%x len=%lu\n", card->name,
 				b1cmd, (unsigned long)dma->recvlen);
 #endif
@@ -681,7 +681,7 @@
 		break;

 	case RECEIVE_START:
-#ifdef CONFIG_C4_POLLDEBUG
+#ifdef C4_POLLDEBUG
 		printk(KERN_INFO "%s: poll from c4\n", card->name);
 #endif
 		if (!suppress_pollack)
diff -ur linux-2.4.4-pre4/drivers/isdn/avmb1/kcapi.c linux-2.4.4-pre4.config/drivers/isdn/avmb1/kcapi.c
--- linux-2.4.4-pre4/drivers/isdn/avmb1/kcapi.c	Fri Mar 30 10:40:56 2001
+++ linux-2.4.4-pre4.config/drivers/isdn/avmb1/kcapi.c	Thu Apr 19 22:12:29 2001
@@ -124,7 +124,7 @@
  *   PCMCIA cards (now patch for pcmcia-cs-3.0.13 needed) done.
  *
  */
-#define CONFIG_AVMB1_COMPAT
+#define AVMB1_COMPAT

 #include <linux/config.h>
 #include <linux/module.h>
@@ -144,7 +144,7 @@
 #include "capicmd.h"
 #include "capiutil.h"
 #include "capilli.h"
-#ifdef CONFIG_AVMB1_COMPAT
+#ifdef AVMB1_COMPAT
 #include <linux/b1lli.h>
 #endif

@@ -1415,7 +1415,7 @@
 	return dp;
 }

-#ifdef CONFIG_AVMB1_COMPAT
+#ifdef AVMB1_COMPAT
 static int old_capi_manufacturer(unsigned int cmd, void *data)
 {
 	avmb1_loadandconfigdef ldef;
@@ -1617,7 +1617,7 @@
 	int retval;

 	switch (cmd) {
-#ifdef CONFIG_AVMB1_COMPAT
+#ifdef AVMB1_COMPAT
 	case AVMB1_ADDCARD:
 	case AVMB1_ADDCARD_WITH_TYPE:
 	case AVMB1_LOAD:
diff -ur linux-2.4.4-pre4/drivers/isdn/avmb1/t1pci.c linux-2.4.4-pre4.config/drivers/isdn/avmb1/t1pci.c
--- linux-2.4.4-pre4/drivers/isdn/avmb1/t1pci.c	Fri Mar 30 10:40:56 2001
+++ linux-2.4.4-pre4.config/drivers/isdn/avmb1/t1pci.c	Thu Apr 19 22:12:57 2001
@@ -96,9 +96,6 @@

 static char *revision = "$Revision: 1.13.6.3 $";

-#undef CONFIG_T1PCI_DEBUG
-#undef CONFIG_T1PCI_POLLDEBUG
-
 /* ------------------------------------------------------------- */

 static struct pci_device_id t1pci_pci_tbl[] __initdata = {
diff -ur linux-2.4.4-pre4/drivers/isdn/hisax/elsa_ser.c linux-2.4.4-pre4.config/drivers/isdn/hisax/elsa_ser.c
--- linux-2.4.4-pre4/drivers/isdn/hisax/elsa_ser.c	Fri Mar 30 10:40:57 2001
+++ linux-2.4.4-pre4.config/drivers/isdn/hisax/elsa_ser.c	Thu Apr 19 22:18:10 2001
@@ -61,21 +61,12 @@
 static inline unsigned int serial_inp(struct IsdnCardState *cs, int offset)
 {
 #ifdef SERIAL_DEBUG_REG
-#ifdef CONFIG_SERIAL_NOPAUSE_IO
-	u_int val = inb(cs->hw.elsa.base + 8 + offset);
-	debugl1(cs,"inp  %s %02x",ModemIn[offset], val);
-#else
 	u_int val = inb_p(cs->hw.elsa.base + 8 + offset);
 	debugl1(cs,"inP  %s %02x",ModemIn[offset], val);
-#endif
 	return(val);
 #else
-#ifdef CONFIG_SERIAL_NOPAUSE_IO
-	return inb(cs->hw.elsa.base + 8 + offset);
-#else
 	return inb_p(cs->hw.elsa.base + 8 + offset);
 #endif
-#endif
 }

 static inline void serial_out(struct IsdnCardState *cs, int offset, int value)
@@ -90,17 +81,9 @@
 			       int value)
 {
 #ifdef SERIAL_DEBUG_REG
-#ifdef CONFIG_SERIAL_NOPAUSE_IO
-	debugl1(cs,"outp %s %02x",ModemOut[offset], value);
-#else
 	debugl1(cs,"outP %s %02x",ModemOut[offset], value);
 #endif
-#endif
-#ifdef CONFIG_SERIAL_NOPAUSE_IO
-	outb(value, cs->hw.elsa.base + 8 + offset);
-#else
     	outb_p(value, cs->hw.elsa.base + 8 + offset);
-#endif
 }

 /*
diff -ur linux-2.4.4-pre4/include/linux/isdn.h linux-2.4.4-pre4.config/include/linux/isdn.h
--- linux-2.4.4-pre4/include/linux/isdn.h	Thu Apr 19 21:49:59 2001
+++ linux-2.4.4-pre4.config/include/linux/isdn.h	Thu Apr 19 21:55:35 2001
@@ -47,22 +47,6 @@
 #define ISDN_MINOR_PPPMAX   (128 + (ISDN_MAX_CHANNELS-1))
 #define ISDN_MINOR_STATUS   255

-#undef CONFIG_ISDN_WITH_ABC_CALLB
-#undef CONFIG_ISDN_WITH_ABC_UDP_CHECK
-#undef CONFIG_ISDN_WITH_ABC_UDP_CHECK_HANGUP
-#undef CONFIG_ISDN_WITH_ABC_UDP_CHECK_DIAL
-#undef CONFIG_ISDN_WITH_ABC_OUTGOING_EAZ
-#undef CONFIG_ISDN_WITH_ABC_LCR_SUPPORT
-#undef CONFIG_ISDN_WITH_ABC_IPV4_TCP_KEEPALIVE
-#undef CONFIG_ISDN_WITH_ABC_IPV4_DYNADDR
-#undef CONFIG_ISDN_WITH_ABC_RCV_NO_HUPTIMER
-#undef CONFIG_ISDN_WITH_ABC_ICALL_BIND
-#undef CONFIG_ISDN_WITH_ABC_CH_EXTINUSE
-#undef CONFIG_ISDN_WITH_ABC_CONN_ERROR
-#undef CONFIG_ISDN_WITH_ABC_RAWIPCOMPRESS
-#undef CONFIG_ISDN_WITH_ABC_IPTABLES_NETFILTER
-
-
 /* New ioctl-codes */
 #define IIOCNETAIF  _IO('I',1)
 #define IIOCNETDIF  _IO('I',2)


