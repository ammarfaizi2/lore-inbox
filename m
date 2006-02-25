Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932434AbWBYH0p@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932434AbWBYH0p (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 25 Feb 2006 02:26:45 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932437AbWBYH0p
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 25 Feb 2006 02:26:45 -0500
Received: from smtp.osdl.org ([65.172.181.4]:53475 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S932434AbWBYH0o (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 25 Feb 2006 02:26:44 -0500
Date: Fri, 24 Feb 2006 23:22:22 -0800
From: Andrew Morton <akpm@osdl.org>
To: Adrian Bunk <bunk@stusta.de>
Cc: rusty@rustcorp.com.au, linux-kernel@vger.kernel.org,
       Karsten Keil <kkeil@suse.de>
Subject: Re: 2.6.16-rc4-mm2: drivers/isdn/hysdn/hysdn_net.c module_param()
 compile error
Message-Id: <20060224232222.73803498.akpm@osdl.org>
In-Reply-To: <20060225033855.GG3674@stusta.de>
References: <20060224031002.0f7ff92a.akpm@osdl.org>
	<20060225033855.GG3674@stusta.de>
X-Mailer: Sylpheed version 1.0.4 (GTK+ 1.2.10; i386-redhat-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Adrian Bunk <bunk@stusta.de> wrote:
>
>  On Fri, Feb 24, 2006 at 03:10:02AM -0800, Andrew Morton wrote:
>  >...
>  > Changes since 2.6.16-rc4-mm1:
>  >...
>  > +remove-module_parm.patch
>  >...
>  >  Current 2.6.16 queue.  Some of these are a bit questionable at this stage.
>  >...
> 
>  This causes the following compile error:
> 
>  <--  snip  -->
> 
>  ...
>    CC [M]  drivers/isdn/hysdn/hysdn_net.o
>  drivers/isdn/hysdn/hysdn_net.c:27: error: syntax error before 'int'
>  drivers/isdn/hysdn/hysdn_net.c:27: error: syntax error before ',' token
>  drivers/isdn/hysdn/hysdn_net.c:27: error: 'param_set_unsigned' undeclared here (not in a function)
>  drivers/isdn/hysdn/hysdn_net.c:27: error: syntax error before 'int'
>  drivers/isdn/hysdn/hysdn_net.c:27: error: 'param_get_unsigned' undeclared here (not in a function)
>  make[3]: *** [drivers/isdn/hysdn/hysdn_net.o] Error 1

That's a bit nasty.

	module_param(hynet_enable, uint, 0);

module_param() does funny things with macros, and relies upon things like
`uint' having a special-to-moduleparam.h meaning.

But ISDN defines its own meaning for uint and trips up the
moduleparam.h macros.

Bad Rusty should have chosen less generic-sounding identifiers.

Bad ISDN shouldn't have gone off and defined its own types, either.

Kasrten, this nukes the hysdn custom types.  Is it acceptable?

 drivers/isdn/hysdn/boardergo.c      |   31 +++++------
 drivers/isdn/hysdn/boardergo.h      |   46 ++++++++--------
 drivers/isdn/hysdn/hycapi.c         |    2 
 drivers/isdn/hysdn/hysdn_boot.c     |   28 +++++-----
 drivers/isdn/hysdn/hysdn_defs.h     |   71 ++++++++++++--------------
 drivers/isdn/hysdn/hysdn_init.c     |    4 -
 drivers/isdn/hysdn/hysdn_net.c      |    6 +-
 drivers/isdn/hysdn/hysdn_pof.h      |   12 ++--
 drivers/isdn/hysdn/hysdn_procconf.c |   14 ++---
 drivers/isdn/hysdn/hysdn_proclog.c  |   10 +--
 drivers/isdn/hysdn/hysdn_sched.c    |   11 ++--
 drivers/isdn/hysdn/ince1pc.h        |   18 +++---
 12 files changed, 127 insertions(+), 126 deletions(-)

diff -puN drivers/isdn/hysdn/hysdn_defs.h~hysdn-remove-custom-types drivers/isdn/hysdn/hysdn_defs.h
--- devel/drivers/isdn/hysdn/hysdn_defs.h~hysdn-remove-custom-types	2006-02-24 23:17:06.000000000 -0800
+++ devel-akpm/drivers/isdn/hysdn/hysdn_defs.h	2006-02-24 23:17:06.000000000 -0800
@@ -20,14 +20,6 @@
 #include <linux/workqueue.h>
 #include <linux/skbuff.h>
 
-/****************************/
-/* storage type definitions */
-/****************************/
-#define uchar unsigned char
-#define uint unsigned int
-#define ulong unsigned long
-#define word unsigned short
-
 #include "ince1pc.h"
 
 #ifdef CONFIG_HYSDN_CAPI
@@ -147,18 +139,18 @@ typedef struct HYSDN_CARD {
 
 	/* general variables for the cards */
 	int myid;		/* own driver card id */
-	uchar bus;		/* pci bus the card is connected to */
-	uchar devfn;		/* slot+function bit encoded */
-	word subsysid;		/* PCI subsystem id */
-	uchar brdtype;		/* type of card */
-	uint bchans;		/* number of available B-channels */
-	uint faxchans;		/* number of available fax-channels */
-	uchar mac_addr[6];	/* MAC Address read from card */
-	uint irq;		/* interrupt number */
-	uint iobase;		/* IO-port base address */
-	ulong plxbase;		/* PLX memory base */
-	ulong membase;		/* DPRAM memory base */
-	ulong memend;		/* DPRAM memory end */
+	unsigned char bus;	/* pci bus the card is connected to */
+	unsigned char devfn;	/* slot+function bit encoded */
+	unsigned short subsysid;/* PCI subsystem id */
+	unsigned char brdtype;	/* type of card */
+	unsigned int bchans;	/* number of available B-channels */
+	unsigned int faxchans;	/* number of available fax-channels */
+	unsigned char mac_addr[6];/* MAC Address read from card */
+	unsigned int irq;	/* interrupt number */
+	unsigned int iobase;	/* IO-port base address */
+	unsigned long plxbase;	/* PLX memory base */
+	unsigned long membase;	/* DPRAM memory base */
+	unsigned long memend;	/* DPRAM memory end */
 	void *dpram;		/* mapped dpram */
 	int state;		/* actual state of card -> CARD_STATE_** */
 	struct HYSDN_CARD *next;	/* pointer to next card */
@@ -168,26 +160,26 @@ typedef struct HYSDN_CARD {
 	void *procconf;		/* pointer to procconf filesystem specific data */
 
 	/* debugging and logging */
-	uchar err_log_state;	/* actual error log state of the card */
-	ulong debug_flags;	/* tells what should be debugged and where */
+	unsigned char err_log_state;/* actual error log state of the card */
+	unsigned long debug_flags;/* tells what should be debugged and where */
 	void (*set_errlog_state) (struct HYSDN_CARD *, int);
 
 	/* interrupt handler + interrupt synchronisation */
 	struct work_struct irq_queue;	/* interrupt task queue */
-	uchar volatile irq_enabled;	/* interrupt enabled if != 0 */
-	uchar volatile hw_lock;	/* hardware is currently locked -> no access */
+	unsigned char volatile irq_enabled;/* interrupt enabled if != 0 */
+	unsigned char volatile hw_lock;/* hardware is currently locked -> no access */
 
 	/* boot process */
 	void *boot;		/* pointer to boot private data */
-	int (*writebootimg) (struct HYSDN_CARD *, uchar *, ulong);
-	int (*writebootseq) (struct HYSDN_CARD *, uchar *, int);
+	int (*writebootimg) (struct HYSDN_CARD *, unsigned char *, unsigned long);
+	int (*writebootseq) (struct HYSDN_CARD *, unsigned char *, int);
 	int (*waitpofready) (struct HYSDN_CARD *);
 	int (*testram) (struct HYSDN_CARD *);
 
 	/* scheduler for data transfer (only async parts) */
-	uchar async_data[256];	/* async data to be sent (normally for config) */
-	word volatile async_len;	/* length of data to sent */
-	word volatile async_channel;	/* channel number for async transfer */
+	unsigned char async_data[256];/* async data to be sent (normally for config) */
+	unsigned short volatile async_len;/* length of data to sent */
+	unsigned short volatile async_channel;/* channel number for async transfer */
 	int volatile async_busy;	/* flag != 0 sending in progress */
 	int volatile net_tx_busy;	/* a network packet tx is in progress */
 
@@ -251,15 +243,18 @@ extern int ergo_inithardware(hysdn_card 
 
 /* hysdn_boot.c */
 extern int pof_write_close(hysdn_card *);	/* close proc file after writing pof */
-extern int pof_write_open(hysdn_card *, uchar **);	/* open proc file for writing pof */
+extern int pof_write_open(hysdn_card *, unsigned char **);	/* open proc file for writing pof */
 extern int pof_write_buffer(hysdn_card *, int);		/* write boot data to card */
-extern int EvalSysrTokData(hysdn_card *, uchar *, int);		/* Check Sysready Token Data */
+extern int EvalSysrTokData(hysdn_card *, unsigned char *, int);		/* Check Sysready Token Data */
 
 /* hysdn_sched.c */
-extern int hysdn_sched_tx(hysdn_card *, uchar *, word volatile *, word volatile *,
-			  word);
-extern int hysdn_sched_rx(hysdn_card *, uchar *, word, word);
-extern int hysdn_tx_cfgline(hysdn_card *, uchar *, word);	/* send one cfg line */
+extern int hysdn_sched_tx(hysdn_card *, unsigned char *,
+			unsigned short volatile *, unsigned short volatile *,
+			unsigned short);
+extern int hysdn_sched_rx(hysdn_card *, unsigned char *, unsigned short,
+			unsigned short);
+extern int hysdn_tx_cfgline(hysdn_card *, unsigned char *,
+			unsigned short);	/* send one cfg line */
 
 /* hysdn_net.c */
 extern unsigned int hynet_enable; 
@@ -269,14 +264,16 @@ extern int hysdn_net_release(hysdn_card 
 extern char *hysdn_net_getname(hysdn_card *);	/* get name of net interface */
 extern void hysdn_tx_netack(hysdn_card *);	/* acknowledge a packet tx */
 extern struct sk_buff *hysdn_tx_netget(hysdn_card *);	/* get next network packet */
-extern void hysdn_rx_netpkt(hysdn_card *, uchar *, word);	/* rxed packet from network */
+extern void hysdn_rx_netpkt(hysdn_card *, unsigned char *,
+			unsigned short);	/* rxed packet from network */
 
 #ifdef CONFIG_HYSDN_CAPI
 extern unsigned int hycapi_enable; 
 extern int hycapi_capi_create(hysdn_card *);	/* create a new capi device */
 extern int hycapi_capi_release(hysdn_card *);	/* delete the device */
 extern int hycapi_capi_stop(hysdn_card *card);   /* suspend */
-extern void hycapi_rx_capipkt(hysdn_card * card, uchar * buf, word len);
+extern void hycapi_rx_capipkt(hysdn_card * card, unsigned char * buf,
+				unsigned short len);
 extern void hycapi_tx_capiack(hysdn_card * card);
 extern struct sk_buff *hycapi_tx_capiget(hysdn_card *card);
 extern int hycapi_init(void);
diff -puN drivers/isdn/hysdn/ince1pc.h~hysdn-remove-custom-types drivers/isdn/hysdn/ince1pc.h
--- devel/drivers/isdn/hysdn/ince1pc.h~hysdn-remove-custom-types	2006-02-24 23:17:06.000000000 -0800
+++ devel-akpm/drivers/isdn/hysdn/ince1pc.h	2006-02-24 23:17:06.000000000 -0800
@@ -62,7 +62,7 @@
  *                     s. RotlCRC algorithm
  *
  *  RotlCRC algorithm:
- *      ucSum= 0                        1 uchar
+ *      ucSum= 0                        1 unsigned char
  *      for all NonEndTokenChunk bytes:
  *          ROTL(ucSum,1)               rotate left by 1
  *          ucSum += Char;              add current byte with swap around
@@ -85,13 +85,13 @@
 
 typedef struct ErrLogEntry_tag {
 	
-/*00 */ ulong ulErrType;
+/*00 */ unsigned long ulErrType;
 	
-/*04 */ ulong ulErrSubtype;
+/*04 */ unsigned long ulErrSubtype;
 	
-/*08 */ uchar ucTextSize;
+/*08 */ unsigned char ucTextSize;
 	
-	/*09 */ uchar ucText[ERRLOG_TEXT_SIZE];
+	/*09 */ unsigned char ucText[ERRLOG_TEXT_SIZE];
 	/* ASCIIZ of len ucTextSize-1 */
 	
 /*40 */ 
@@ -111,13 +111,13 @@ typedef struct ErrLogEntry_tag {
 #define DPRAM_SPOOLER_DATA_SIZE 0x20
 typedef struct DpramBootSpooler_tag {
 	
-/*00 */ uchar Len;
+/*00 */ unsigned char Len;
 	
-/*01 */ volatile uchar RdPtr;
+/*01 */ volatile unsigned char RdPtr;
 	
-/*02 */ uchar WrPtr;
+/*02 */ unsigned char WrPtr;
 	
-/*03 */ uchar Data[DPRAM_SPOOLER_DATA_SIZE];
+/*03 */ unsigned char Data[DPRAM_SPOOLER_DATA_SIZE];
 	
 /*23 */ 
 } tDpramBootSpooler;
diff -puN drivers/isdn/hysdn/hysdn_net.c~hysdn-remove-custom-types drivers/isdn/hysdn/hysdn_net.c
--- devel/drivers/isdn/hysdn/hysdn_net.c~hysdn-remove-custom-types	2006-02-24 23:17:06.000000000 -0800
+++ devel-akpm/drivers/isdn/hysdn/hysdn_net.c	2006-02-24 23:17:06.000000000 -0800
@@ -83,12 +83,12 @@ net_open(struct net_device *dev)
 
 	/* Fill in the MAC-level header (if not already set) */
 	if (!card->mac_addr[0]) {
-		for (i = 0; i < ETH_ALEN - sizeof(ulong); i++)
+		for (i = 0; i < ETH_ALEN - sizeof(unsigned long); i++)
 			dev->dev_addr[i] = 0xfc;
 		if ((in_dev = dev->ip_ptr) != NULL) {
 			struct in_ifaddr *ifa = in_dev->ifa_list;
 			if (ifa != NULL)
-				memcpy(dev->dev_addr + (ETH_ALEN - sizeof(ulong)), &ifa->ifa_local, sizeof(ulong));
+				memcpy(dev->dev_addr + (ETH_ALEN - sizeof(unsigned long)), &ifa->ifa_local, sizeof(unsigned long));
 		}
 	} else
 		memcpy(dev->dev_addr, card->mac_addr, ETH_ALEN);
@@ -197,7 +197,7 @@ hysdn_tx_netack(hysdn_card * card)
 /* we got a packet from the network, go and queue it */
 /*****************************************************/
 void
-hysdn_rx_netpkt(hysdn_card * card, uchar * buf, word len)
+hysdn_rx_netpkt(hysdn_card * card, unsigned char *buf, unsigned short len)
 {
 	struct net_local *lp = card->netif;
 	struct sk_buff *skb;
diff -puN drivers/isdn/hysdn/boardergo.c~hysdn-remove-custom-types drivers/isdn/hysdn/boardergo.c
--- devel/drivers/isdn/hysdn/boardergo.c~hysdn-remove-custom-types	2006-02-24 23:17:06.000000000 -0800
+++ devel-akpm/drivers/isdn/hysdn/boardergo.c	2006-02-24 23:17:06.000000000 -0800
@@ -38,8 +38,8 @@ ergo_interrupt(int intno, void *dev_id, 
 {
 	hysdn_card *card = dev_id;	/* parameter from irq */
 	tErgDpram *dpr;
-	ulong flags;
-	uchar volatile b;
+	unsigned long flags;
+	unsigned char volatile b;
 
 	if (!card)
 		return IRQ_NONE;		/* error -> spurious interrupt */
@@ -77,7 +77,7 @@ ergo_irq_bh(hysdn_card * card)
 {
 	tErgDpram *dpr;
 	int again;
-	ulong flags;
+	unsigned long flags;
 
 	if (card->state != CARD_STATE_RUN)
 		return;		/* invalid call */
@@ -131,8 +131,8 @@ ergo_irq_bh(hysdn_card * card)
 static void
 ergo_stopcard(hysdn_card * card)
 {
-	ulong flags;
-	uchar val;
+	unsigned long flags;
+	unsigned char val;
 
 	hysdn_net_release(card);	/* first release the net device if existing */
 #ifdef CONFIG_HYSDN_CAPI
@@ -157,7 +157,7 @@ ergo_stopcard(hysdn_card * card)
 static void
 ergo_set_errlog_state(hysdn_card * card, int on)
 {
-	ulong flags;
+	unsigned long flags;
 
 	if (card->state != CARD_STATE_RUN) {
 		card->err_log_state = ERRLOG_STATE_OFF;		/* must be off */
@@ -217,9 +217,10 @@ ergo_testram(hysdn_card * card)
 /* Negative return values are interpreted as errors.                         */
 /*****************************************************************************/
 static int
-ergo_writebootimg(struct HYSDN_CARD *card, uchar * buf, ulong offs)
+ergo_writebootimg(struct HYSDN_CARD *card, unsigned char *buf,
+			unsigned long offs)
 {
-	uchar *dst;
+	unsigned char *dst;
 	tErgDpram *dpram;
 	int cnt = (BOOT_IMG_SIZE >> 2);		/* number of words to move and swap (byte order!) */
 	
@@ -264,14 +265,14 @@ ergo_writebootimg(struct HYSDN_CARD *car
 /* case of errors a negative error value is returned.                           */
 /********************************************************************************/
 static int
-ergo_writebootseq(struct HYSDN_CARD *card, uchar * buf, int len)
+ergo_writebootseq(struct HYSDN_CARD *card, unsigned char *buf, int len)
 {
 	tDpramBootSpooler *sp = (tDpramBootSpooler *) card->dpram;
-	uchar *dst;
-	uchar buflen;
+	unsigned char *dst;
+	unsigned char buflen;
 	int nr_write;
-	uchar tmp_rdptr;
-	uchar wr_mirror;
+	unsigned char tmp_rdptr;
+	unsigned char wr_mirror;
 	int i;
 
 	if (card->debug_flags & LOG_POF_CARD)
@@ -330,7 +331,7 @@ ergo_waitpofready(struct HYSDN_CARD *car
 {
 	tErgDpram *dpr = card->dpram;	/* pointer to DPRAM structure */
 	int timecnt = 10000 / 50;	/* timeout is 10 secs max. */
-	ulong flags;
+	unsigned long flags;
 	int msg_size;
 	int i;
 
@@ -345,7 +346,7 @@ ergo_waitpofready(struct HYSDN_CARD *car
 			if ((dpr->ToPcChannel != CHAN_SYSTEM) ||
 			    (dpr->ToPcSize < MIN_RDY_MSG_SIZE) ||
 			    (dpr->ToPcSize > MAX_RDY_MSG_SIZE) ||
-			    ((*(ulong *) dpr->ToPcBuf) != RDY_MAGIC))
+			    ((*(unsigned long *) dpr->ToPcBuf) != RDY_MAGIC))
 				break;	/* an error occurred */
 
 			/* Check for additional data delivered during SysReady */
diff -puN drivers/isdn/hysdn/hycapi.c~hysdn-remove-custom-types drivers/isdn/hysdn/hycapi.c
--- devel/drivers/isdn/hysdn/hycapi.c~hysdn-remove-custom-types	2006-02-24 23:17:06.000000000 -0800
+++ devel-akpm/drivers/isdn/hysdn/hycapi.c	2006-02-24 23:17:06.000000000 -0800
@@ -523,7 +523,7 @@ New nccis are created if necessary.
 *******************************************************************/
 
 void
-hycapi_rx_capipkt(hysdn_card * card, uchar * buf, word len)
+hycapi_rx_capipkt(hysdn_card * card, unsigned char *buf, unsigned short len)
 {
 	struct sk_buff *skb;
 	hycapictrl_info *cinfo = card->hyctrlinfo;
diff -puN drivers/isdn/hysdn/hysdn_boot.c~hysdn-remove-custom-types drivers/isdn/hysdn/hysdn_boot.c
--- devel/drivers/isdn/hysdn/hysdn_boot.c~hysdn-remove-custom-types	2006-02-24 23:17:06.000000000 -0800
+++ devel-akpm/drivers/isdn/hysdn/hysdn_boot.c	2006-02-24 23:17:06.000000000 -0800
@@ -30,17 +30,17 @@
 /* needed during boot and so allocated dynamically.         */
 /************************************************************/
 struct boot_data {
-	word Cryptor;		/* for use with Decrypt function */
-	word Nrecs;		/* records remaining in file */
-	uchar pof_state;	/* actual state of read handler */
-	uchar is_crypted;	/* card data is crypted */
+	unsigned short Cryptor;	/* for use with Decrypt function */
+	unsigned short Nrecs;	/* records remaining in file */
+	unsigned char pof_state;/* actual state of read handler */
+	unsigned char is_crypted;/* card data is crypted */
 	int BufSize;		/* actual number of bytes bufferd */
 	int last_error;		/* last occurred error */
-	word pof_recid;		/* actual pof recid */
-	ulong pof_reclen;	/* total length of pof record data */
-	ulong pof_recoffset;	/* actual offset inside pof record */
+	unsigned short pof_recid;/* actual pof recid */
+	unsigned long pof_reclen;/* total length of pof record data */
+	unsigned long pof_recoffset;/* actual offset inside pof record */
 	union {
-		uchar BootBuf[BOOT_BUF_SIZE];	/* buffer as byte count */
+		unsigned char BootBuf[BOOT_BUF_SIZE];/* buffer as byte count */
 		tPofRecHdr PofRecHdr;	/* header for actual record/chunk */
 		tPofFileHdr PofFileHdr;		/* header from POF file */
 		tPofTimeStamp PofTime;	/* time information */
@@ -69,11 +69,11 @@ StartDecryption(struct boot_data *boot)
 static void
 DecryptBuf(struct boot_data *boot, int cnt)
 {
-	uchar *bufp = boot->buf.BootBuf;
+	unsigned char *bufp = boot->buf.BootBuf;
 
 	while (cnt--) {
 		boot->Cryptor = (boot->Cryptor >> 1) ^ ((boot->Cryptor & 1U) ? CRYPT_FEEDTERM : 0);
-		*bufp++ ^= (uchar) boot->Cryptor;
+		*bufp++ ^= (unsigned char)boot->Cryptor;
 	}
 }				/* DecryptBuf */
 
@@ -86,7 +86,7 @@ pof_handle_data(hysdn_card * card, int d
 {
 	struct boot_data *boot = card->boot;	/* pointer to boot specific data */
 	long l;
-	uchar *imgp;
+	unsigned char *imgp;
 	int img_len;
 
 	/* handle the different record types */
@@ -197,7 +197,7 @@ pof_write_buffer(hysdn_card * card, int 
 				break;
 			}
 			/* Setup the new state and vars */
-			boot->Nrecs = (word) (boot->buf.PofFileHdr.N_PofRecs);	/* limited to 65535 */
+			boot->Nrecs = (unsigned short)(boot->buf.PofFileHdr.N_PofRecs);	/* limited to 65535 */
 			boot->pof_state = POF_READ_TAG_HEAD;	/* now start with single tags */
 			boot->last_error = sizeof(tPofRecHdr);	/* new length */
 			break;
@@ -268,7 +268,7 @@ pof_write_buffer(hysdn_card * card, int 
 /* occurred. Additionally the pointer to the buffer data area is set on success */
 /*******************************************************************************/
 int
-pof_write_open(hysdn_card * card, uchar ** bufp)
+pof_write_open(hysdn_card * card, unsigned char **bufp)
 {
 	struct boot_data *boot;	/* pointer to boot specific data */
 
@@ -335,7 +335,7 @@ pof_write_close(hysdn_card * card)
 /* when POF has been booted. A return value of 0 is used if no error occurred.    */
 /*********************************************************************************/
 int
-EvalSysrTokData(hysdn_card * card, uchar * cp, int len)
+EvalSysrTokData(hysdn_card *card, unsigned char *cp, int len)
 {
 	u_char *p;
 	u_char crc;
diff -puN drivers/isdn/hysdn/hysdn_init.c~hysdn-remove-custom-types drivers/isdn/hysdn/hysdn_init.c
--- devel/drivers/isdn/hysdn/hysdn_init.c~hysdn-remove-custom-types	2006-02-24 23:17:06.000000000 -0800
+++ devel-akpm/drivers/isdn/hysdn/hysdn_init.c	2006-02-24 23:17:06.000000000 -0800
@@ -41,8 +41,8 @@ hysdn_card *card_root = NULL;	/* pointer
 /* the last entry contains all 0              */
 /**********************************************/
 static struct {
-	word subid;		/* PCI sub id */
-	uchar cardtyp;		/* card type assigned */
+	unsigned short subid;		/* PCI sub id */
+	unsigned char cardtyp;		/* card type assigned */
 } pci_subid_map[] = {
 
 	{
diff -puN drivers/isdn/hysdn/hysdn_procconf.c~hysdn-remove-custom-types drivers/isdn/hysdn/hysdn_procconf.c
--- devel/drivers/isdn/hysdn/hysdn_procconf.c~hysdn-remove-custom-types	2006-02-24 23:17:06.000000000 -0800
+++ devel-akpm/drivers/isdn/hysdn/hysdn_procconf.c	2006-02-24 23:17:06.000000000 -0800
@@ -36,9 +36,9 @@ struct conf_writedata {
 	int buf_size;		/* actual number of bytes in the buffer */
 	int needed_size;	/* needed size when reading pof */
 	int state;		/* actual interface states from above constants */
-	uchar conf_line[CONF_LINE_LEN];		/* buffered conf line */
-	word channel;		/* active channel number */
-	uchar *pof_buffer;	/* buffer when writing pof */
+	unsigned char conf_line[CONF_LINE_LEN];	/* buffered conf line */
+	unsigned short channel;		/* active channel number */
+	unsigned char *pof_buffer;	/* buffer when writing pof */
 };
 
 /***********************************************************************/
@@ -49,7 +49,7 @@ struct conf_writedata {
 static int
 process_line(struct conf_writedata *cnf)
 {
-	uchar *cp = cnf->conf_line;
+	unsigned char *cp = cnf->conf_line;
 	int i;
 
 	if (cnf->card->debug_flags & LOG_CNF_LINE)
@@ -92,7 +92,7 @@ hysdn_conf_write(struct file *file, cons
 {
 	struct conf_writedata *cnf;
 	int i;
-	uchar ch, *cp;
+	unsigned char ch, *cp;
 
 	if (!count)
 		return (0);	/* nothing to handle */
@@ -390,7 +390,7 @@ int
 hysdn_procconf_init(void)
 {
 	hysdn_card *card;
-	uchar conf_name[20];
+	unsigned char conf_name[20];
 
 	hysdn_proc_entry = proc_mkdir(PROC_SUBDIR_NAME, proc_net);
 	if (!hysdn_proc_entry) {
@@ -423,7 +423,7 @@ void
 hysdn_procconf_release(void)
 {
 	hysdn_card *card;
-	uchar conf_name[20];
+	unsigned char conf_name[20];
 
 	card = card_root;	/* start with first card */
 	while (card) {
diff -puN drivers/isdn/hysdn/hysdn_proclog.c~hysdn-remove-custom-types drivers/isdn/hysdn/hysdn_proclog.c
--- devel/drivers/isdn/hysdn/hysdn_proclog.c~hysdn-remove-custom-types	2006-02-24 23:17:06.000000000 -0800
+++ devel-akpm/drivers/isdn/hysdn/hysdn_proclog.c	2006-02-24 23:17:06.000000000 -0800
@@ -28,7 +28,7 @@ static void put_log_buffer(hysdn_card * 
 /*************************************************/
 struct log_data {
 	struct log_data *next;
-	ulong usage_cnt;	/* number of files still to work */
+	unsigned long usage_cnt;/* number of files still to work */
 	void *proc_ctrl;	/* pointer to own control procdata structure */
 	char log_start[2];	/* log string start (final len aligned by size) */
 };
@@ -42,7 +42,7 @@ struct procdata {
 	struct log_data *log_head, *log_tail;	/* head and tail for queue */
 	int if_used;		/* open count for interface */
 	int volatile del_lock;	/* lock for delete operations */
-	uchar logtmp[LOG_MAX_LINELEN];
+	unsigned char logtmp[LOG_MAX_LINELEN];
 	wait_queue_head_t rd_queue;
 };
 
@@ -153,9 +153,9 @@ put_log_buffer(hysdn_card * card, char *
 static ssize_t
 hysdn_log_write(struct file *file, const char __user *buf, size_t count, loff_t * off)
 {
-	ulong u = 0;
+	unsigned long u = 0;
 	int found = 0;
-	uchar *cp, valbuf[128];
+	unsigned char *cp, valbuf[128];
 	long base = 10;
 	hysdn_card *card = (hysdn_card *) file->private_data;
 
@@ -249,7 +249,7 @@ hysdn_log_open(struct inode *ino, struct
 {
 	hysdn_card *card;
 	struct procdata *pd = NULL;
-	ulong flags;
+	unsigned long flags;
 
 	lock_kernel();
 	card = card_root;
diff -puN drivers/isdn/hysdn/hysdn_sched.c~hysdn-remove-custom-types drivers/isdn/hysdn/hysdn_sched.c
--- devel/drivers/isdn/hysdn/hysdn_sched.c~hysdn-remove-custom-types	2006-02-24 23:17:06.000000000 -0800
+++ devel-akpm/drivers/isdn/hysdn/hysdn_sched.c	2006-02-24 23:18:06.000000000 -0800
@@ -30,7 +30,8 @@
 /* to keep the data until later.                                             */
 /*****************************************************************************/
 int
-hysdn_sched_rx(hysdn_card * card, uchar * buf, word len, word chan)
+hysdn_sched_rx(hysdn_card *card, unsigned char *buf, unsigned short len,
+			unsigned short chan)
 {
 
 	switch (chan) {
@@ -72,7 +73,9 @@ hysdn_sched_rx(hysdn_card * card, uchar 
 /* sending.                                                                  */
 /*****************************************************************************/
 int
-hysdn_sched_tx(hysdn_card * card, uchar * buf, word volatile *len, word volatile *chan, word maxlen)
+hysdn_sched_tx(hysdn_card *card, unsigned char *buf,
+		unsigned short volatile *len, unsigned short volatile *chan,
+		unsigned short maxlen)
 {
 	struct sk_buff *skb;
 
@@ -145,10 +148,10 @@ hysdn_sched_tx(hysdn_card * card, uchar 
 /* are to be sent and this happens very seldom.                              */
 /*****************************************************************************/
 int
-hysdn_tx_cfgline(hysdn_card * card, uchar * line, word chan)
+hysdn_tx_cfgline(hysdn_card *card, unsigned char *line, unsigned short chan)
 {
 	int cnt = 50;		/* timeout intervalls */
-	ulong flags;
+	unsigned long flags;
 
 	if (card->debug_flags & LOG_SCHED_ASYN)
 		hysdn_addlog(card, "async tx-cfg chan=%d len=%d", chan, strlen(line) + 1);
diff -puN drivers/isdn/hysdn/boardergo.h~hysdn-remove-custom-types drivers/isdn/hysdn/boardergo.h
--- devel/drivers/isdn/hysdn/boardergo.h~hysdn-remove-custom-types	2006-02-24 23:17:06.000000000 -0800
+++ devel-akpm/drivers/isdn/hysdn/boardergo.h	2006-02-24 23:17:06.000000000 -0800
@@ -23,36 +23,36 @@
 
 /* following DPRAM layout copied from OS2-driver boarderg.h */
 typedef struct ErgDpram_tag {
-/*0000 */ uchar ToHyBuf[ERG_TO_HY_BUF_SIZE];
-/*0E00 */ uchar ToPcBuf[ERG_TO_PC_BUF_SIZE];
+/*0000 */ unsigned char ToHyBuf[ERG_TO_HY_BUF_SIZE];
+/*0E00 */ unsigned char ToPcBuf[ERG_TO_PC_BUF_SIZE];
 
-	/*1C00 */ uchar bSoftUart[SIZE_RSV_SOFT_UART];
+	/*1C00 */ unsigned char bSoftUart[SIZE_RSV_SOFT_UART];
 	/* size 0x1B0 */
 
-	/*1DB0 *//* tErrLogEntry */ uchar volatile ErrLogMsg[64];
+	/*1DB0 *//* tErrLogEntry */ unsigned char volatile ErrLogMsg[64];
 	/* size 64 bytes */
-	/*1DB0  ulong ulErrType;               */
-	/*1DB4  ulong ulErrSubtype;            */
-	/*1DB8  ulong ucTextSize;              */
-	/*1DB9  ulong ucText[ERRLOG_TEXT_SIZE]; *//* ASCIIZ of len ucTextSize-1 */
+	/*1DB0  unsigned long ulErrType;               */
+	/*1DB4  unsigned long ulErrSubtype;            */
+	/*1DB8  unsigned long ucTextSize;              */
+	/*1DB9  unsigned long ucText[ERRLOG_TEXT_SIZE]; *//* ASCIIZ of len ucTextSize-1 */
 	/*1DF0 */
 
-/*1DF0 */ word volatile ToHyChannel;
-/*1DF2 */ word volatile ToHySize;
-	/*1DF4 */ uchar volatile ToHyFlag;
+/*1DF0 */ unsigned short volatile ToHyChannel;
+/*1DF2 */ unsigned short volatile ToHySize;
+	/*1DF4 */ unsigned char volatile ToHyFlag;
 	/* !=0: msg for Hy waiting */
-	/*1DF5 */ uchar volatile ToPcFlag;
+	/*1DF5 */ unsigned char volatile ToPcFlag;
 	/* !=0: msg for PC waiting */
-/*1DF6 */ word volatile ToPcChannel;
-/*1DF8 */ word volatile ToPcSize;
-	/*1DFA */ uchar bRes1DBA[0x1E00 - 0x1DFA];
+/*1DF6 */ unsigned short volatile ToPcChannel;
+/*1DF8 */ unsigned short volatile ToPcSize;
+	/*1DFA */ unsigned char bRes1DBA[0x1E00 - 0x1DFA];
 	/* 6 bytes */
 
-/*1E00 */ uchar bRestOfEntryTbl[0x1F00 - 0x1E00];
-/*1F00 */ ulong TrapTable[62];
-	/*1FF8 */ uchar bRes1FF8[0x1FFB - 0x1FF8];
+/*1E00 */ unsigned char bRestOfEntryTbl[0x1F00 - 0x1E00];
+/*1F00 */ unsigned long TrapTable[62];
+	/*1FF8 */ unsigned char bRes1FF8[0x1FFB - 0x1FF8];
 	/* low part of reset vetor */
-/*1FFB */ uchar ToPcIntMetro;
+/*1FFB */ unsigned char ToPcIntMetro;
 	/* notes:
 	 * - metro has 32-bit boot ram - accessing
 	 *   ToPcInt and ToHyInt would be the same;
@@ -65,16 +65,16 @@ typedef struct ErgDpram_tag {
 	 *   so E1 side should NOT change this byte
 	 *   when writing!
 	 */
-/*1FFC */ uchar volatile ToHyNoDpramErrLog;
+/*1FFC */ unsigned char volatile ToHyNoDpramErrLog;
 	/* note: ToHyNoDpramErrLog is used to inform
 	 *       boot loader, not to use DPRAM based
 	 *       ErrLog; when DOS driver is rewritten
 	 *       this becomes obsolete
 	 */
-/*1FFD */ uchar bRes1FFD;
-	/*1FFE */ uchar ToPcInt;
+/*1FFD */ unsigned char bRes1FFD;
+	/*1FFE */ unsigned char ToPcInt;
 	/* E1_intclear; on CHAMP2: E1_intset   */
-	/*1FFF */ uchar ToHyInt;
+	/*1FFF */ unsigned char ToHyInt;
 	/* E1_intset;   on CHAMP2: E1_intclear */
 } tErgDpram;
 
diff -puN drivers/isdn/hysdn/hysdn_pof.h~hysdn-remove-custom-types drivers/isdn/hysdn/hysdn_pof.h
--- devel/drivers/isdn/hysdn/hysdn_pof.h~hysdn-remove-custom-types	2006-02-24 23:17:06.000000000 -0800
+++ devel-akpm/drivers/isdn/hysdn/hysdn_pof.h	2006-02-24 23:17:06.000000000 -0800
@@ -47,20 +47,20 @@
 
 /*--------------------------------------POF file record structs------------*/
 typedef struct PofFileHdr_tag {	/* Pof file header */
-/*00 */ ulong Magic __attribute__((packed));
-/*04 */ ulong N_PofRecs __attribute__((packed));
+/*00 */ unsigned long Magic __attribute__((packed));
+/*04 */ unsigned long N_PofRecs __attribute__((packed));
 /*08 */
 } tPofFileHdr;
 
 typedef struct PofRecHdr_tag {	/* Pof record header */
-/*00 */ word PofRecId __attribute__((packed));
-/*02 */ ulong PofRecDataLen __attribute__((packed));
+/*00 */ unsigned short PofRecId __attribute__((packed));
+/*02 */ unsigned long PofRecDataLen __attribute__((packed));
 /*06 */
 } tPofRecHdr;
 
 typedef struct PofTimeStamp_tag {
-/*00 */ ulong UnixTime __attribute__((packed));
-	/*04 */ uchar DateTimeText[0x28] __attribute__((packed));
+/*00 */ unsigned long UnixTime __attribute__((packed));
+	/*04 */ unsigned char DateTimeText[0x28] __attribute__((packed));
 	/* =40 */
 /*2C */
 } tPofTimeStamp;
_

