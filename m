Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267406AbTBIRqU>; Sun, 9 Feb 2003 12:46:20 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267408AbTBIRqU>; Sun, 9 Feb 2003 12:46:20 -0500
Received: from home.linuxhacker.ru ([194.67.236.68]:17283 "EHLO linuxhacker.ru")
	by vger.kernel.org with ESMTP id <S267406AbTBIRqN>;
	Sun, 9 Feb 2003 12:46:13 -0500
Date: Sun, 9 Feb 2003 20:53:49 +0300
From: Oleg Drokin <green@linuxhacker.ru>
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: 2.4.21-pre4 comparison bugs (More of those)
Message-ID: <20030209175349.GA20635@linuxhacker.ru>
References: <20030208171838.GA2230@linuxhacker.ru> <1044752320.18908.18.camel@irongate.swansea.linux.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1044752320.18908.18.camel@irongate.swansea.linux.org.uk>
User-Agent: Mutt/1.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello!

On Sun, Feb 09, 2003 at 12:58:40AM +0000, Alan Cox wrote:
> > -	if((autodma = ide_setup_pci_controller(dev, d, noisy, &tried_config)) < 0)
> > +	if((int)(autodma = ide_setup_pci_controller(dev, d, noisy, &tried_config)) < 0)
> >  		return index;
> Well caught. I don't like your fix. I'd prefer to do the job properly
> and either make it return a signed value or split error/value reporting
> in these various cases.
> I'll fix them for the next -ac

Ok, here is some more for you ;)
This time I changed the type of variable to signed type whenever
I felt it was appropriate.
When I was not sure (or unsigned type was in some commonly used
structure), I still used a cast just to highlight a problem, so that someone
more knowledgeable created better fix.
See the patch.
Mostly we do incorrect stuff on errors. Sigh, nobody likes errors ;)

Bye,
    Oleg 
===== drivers/char/mwave/mwavedd.c 1.3 vs edited =====
--- 1.3/drivers/char/mwave/mwavedd.c	Wed Feb 13 15:43:48 2002
+++ edited/drivers/char/mwave/mwavedd.c	Sun Feb  9 20:13:45 2003
@@ -500,7 +500,7 @@
 {
 	int i;
 	int retval = 0;
-	unsigned int resultMiscRegister;
+	int resultMiscRegister;
 	pMWAVE_DEVICE_DATA pDrvData = &mwave_s_mdd;
 
 	memset(&mwave_s_mdd, 0, sizeof(MWAVE_DEVICE_DATA));
===== drivers/isdn/hisax/st5481_usb.c 1.8 vs edited =====
--- 1.8/drivers/isdn/hisax/st5481_usb.c	Mon Jan 27 23:49:41 2003
+++ edited/drivers/isdn/hisax/st5481_usb.c	Sun Feb  9 20:21:32 2003
@@ -576,7 +576,7 @@
 	     pipd < pend; 
 	     pipd++) {
 		
-		if (pipd->status < 0) {
+		if ((int)pipd->status < 0) {
 			return (pipd->status);
 		}
 	
===== drivers/message/fusion/mptbase.c 1.7 vs edited =====
--- 1.7/drivers/message/fusion/mptbase.c	Wed Nov 20 23:27:21 2002
+++ edited/drivers/message/fusion/mptbase.c	Sun Feb  9 20:25:57 2003
@@ -1801,7 +1801,7 @@
 {
 	if (this != NULL) {
 		int sz;
-		u32 state;
+		int state;
 
 		/* Disable the FW */
 		state = mpt_GetIocState(this, 1);
===== drivers/mtd/devices/slram.c 1.6 vs edited =====
--- 1.6/drivers/mtd/devices/slram.c	Sat Jan 25 03:25:20 2003
+++ edited/drivers/mtd/devices/slram.c	Sun Feb  9 20:30:10 2003
@@ -246,8 +246,8 @@
 int parse_cmdline(char *devname, char *szstart, char *szlength)
 {
 	char *buffer;
-	unsigned long devstart;
-	unsigned long devlength;
+	long devstart;
+	long devlength;
 	
 	if ((!devname) || (!szstart) || (!szlength)) {
 		unregister_devices();
===== drivers/net/acenic.c 1.27 vs edited =====
--- 1.27/drivers/net/acenic.c	Fri Sep 20 03:49:29 2002
+++ edited/drivers/net/acenic.c	Sun Feb  9 20:34:09 2003
@@ -1157,8 +1157,8 @@
 	struct pci_dev *pdev;
 	unsigned long myjif;
 	u64 tmp_ptr;
-	u32 tig_ver, mac1, mac2, tmp, pci_state;
-	int board_idx, ecode = 0;
+	u32 tig_ver, mac1, mac2, pci_state;
+	int board_idx, ecode = 0, tmp;
 	short i;
 	unsigned char cache_size;
 
===== drivers/net/wan/8253x/8253xini.c 1.1 vs edited =====
--- 1.1/drivers/net/wan/8253x/8253xini.c	Thu Apr  4 23:05:10 2002
+++ edited/drivers/net/wan/8253x/8253xini.c	Sun Feb  9 20:31:37 2003
@@ -2196,7 +2196,7 @@
 	SAB_BOARD *boardptr;
 	SAB_PORT *portptr;
 	struct net_device *dev;
-	unsigned int result;
+	int result;
 	unsigned int namelength;
 	unsigned int portno;
 	int intr_val;
===== drivers/net/wan/8253x/8253xtty.c 1.1 vs edited =====
--- 1.1/drivers/net/wan/8253x/8253xtty.c	Thu Apr  4 23:05:10 2002
+++ edited/drivers/net/wan/8253x/8253xtty.c	Sun Feb  9 20:32:38 2003
@@ -135,7 +135,7 @@
 	register unsigned int slopspace;
 	register int sendsize;
 	unsigned int totaltransmit;
-	unsigned fifospace;
+	int  fifospace;
 	unsigned loadedcount;
 	struct tty_struct *tty = port->tty;
 	
===== drivers/scsi/osst.c 1.10 vs edited =====
--- 1.10/drivers/scsi/osst.c	Tue Feb  5 17:06:58 2002
+++ edited/drivers/scsi/osst.c	Sun Feb  9 20:38:01 2003
@@ -4680,7 +4680,7 @@
 	 unsigned int cmd_in, unsigned long arg)
 {
 	int i, cmd_nr, cmd_type, retval = 0;
-	unsigned int blk;
+	int blk;
 	OS_Scsi_Tape *STp;
 	ST_mode *STm;
 	ST_partstat *STps;
===== drivers/scsi/aacraid/aachba.c 1.3 vs edited =====
--- 1.3/drivers/scsi/aacraid/aachba.c	Mon Jul 29 16:58:43 2002
+++ edited/drivers/scsi/aacraid/aachba.c	Sun Feb  9 20:35:01 2003
@@ -233,7 +233,8 @@
 int aac_get_containers(struct aac_dev *dev)
 {
 	struct fsa_scsi_hba *fsa_dev_ptr;
-	u32 index, status = 0;
+	u32 index;
+	int status = 0;
 	struct aac_query_mount *dinfo;
 	struct aac_mount *dresp;
 	struct fib * fibptr;
===== drivers/usb/hcd/ehci-sched.c 1.7 vs edited =====
--- 1.7/drivers/usb/hcd/ehci-sched.c	Fri Dec 20 10:33:27 2002
+++ edited/drivers/usb/hcd/ehci-sched.c	Sun Feb  9 20:49:44 2003
@@ -549,7 +549,7 @@
 	u64		temp;
 	u32		buf1;
 	unsigned	i, epnum, maxp, multi;
-	unsigned	length;
+	int	length;
 	int		is_input;
 
 	itd->hw_next = EHCI_LIST_END;
===== fs/intermezzo/psdev.c 1.7 vs edited =====
--- 1.7/fs/intermezzo/psdev.c	Fri Oct 11 02:24:51 2002
+++ edited/fs/intermezzo/psdev.c	Sun Feb  9 20:44:48 2003
@@ -605,7 +605,7 @@
             if (req->rq_flags & REQ_WRITE) {
                     out = (struct izo_upcall_resp *)req->rq_data;
                     /* here we map positive Lento errors to kernel errors */
-                    if ( out->result < 0 ) {
+                    if ( (int)out->result < 0 ) {
                             CERROR("Tell Peter: Lento returns negative error %d, for oc %d!\n",
                                    out->result, out->opcode);
                           out->result = EINVAL;
===== fs/intermezzo/super.c 1.4 vs edited =====
--- 1.4/fs/intermezzo/super.c	Fri Oct 11 02:24:51 2002
+++ edited/fs/intermezzo/super.c	Sun Feb  9 20:45:35 2003
@@ -200,7 +200,7 @@
         char *fileset = NULL;
         char *channel = NULL;
         int err; 
-        unsigned int minor;
+        int minor;
 
         ENTRY;
 
===== net/decnet/af_decnet.c 1.12 vs edited =====
--- 1.12/net/decnet/af_decnet.c	Tue Aug 13 00:43:21 2002
+++ edited/net/decnet/af_decnet.c	Sun Feb  9 20:47:24 2003
@@ -1180,7 +1180,7 @@
 	struct sock *sk = sock->sk;
 	struct dn_scp *scp = DN_SK(sk);
 	int err = -EOPNOTSUPP;
-	unsigned long amount = 0;
+	long amount = 0;
 	struct sk_buff *skb;
 	int val;
 
===== net/ipv4/netfilter/ip_conntrack_irc.c 1.5 vs edited =====
--- 1.5/net/ipv4/netfilter/ip_conntrack_irc.c	Thu Aug  8 18:49:17 2002
+++ edited/net/ipv4/netfilter/ip_conntrack_irc.c	Sun Feb  9 20:48:02 2003
@@ -37,7 +37,7 @@
 static int ports[MAX_PORTS];
 static int ports_c = 0;
 static int max_dcc_channels = 8;
-static unsigned int dcc_timeout = 300;
+static int dcc_timeout = 300;
 
 MODULE_AUTHOR("Harald Welte <laforge@gnumonks.org>");
 MODULE_DESCRIPTION("IRC (DCC) connection tracking module");
