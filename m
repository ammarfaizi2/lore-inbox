Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S271864AbRIMQra>; Thu, 13 Sep 2001 12:47:30 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S271847AbRIMQrL>; Thu, 13 Sep 2001 12:47:11 -0400
Received: from mail.pha.ha-vel.cz ([195.39.72.3]:17413 "HELO
	mail.pha.ha-vel.cz") by vger.kernel.org with SMTP
	id <S271856AbRIMQqw>; Thu, 13 Sep 2001 12:46:52 -0400
Date: Thu, 13 Sep 2001 18:32:29 +0200
From: Vojtech Pavlik <vojtech@suse.cz>
To: torvalds@transmeta.com
Subject: [x86-64 patch 3/11] Fix flags definitions to be longs
Message-ID: <20010913183229.A2559@suse.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!

This is a larger patch that fixes hopefully all definitions of flags
(used with save/restore_flags and spin_[un]lock_irqsave/restore) to
long. This breaks on x86-64 and probably also on other architectures.

diff -urN linux/drivers/char/rio/riotable.c linux-64-latest/drivers/char/rio/riotable.c
--- linux/drivers/char/rio/riotable.c	Sat Jul 21 15:04:16 2001
+++ linux-64-latest/drivers/char/rio/riotable.c	Thu Sep 13 13:00:51 2001
@@ -445,7 +445,7 @@
 	int Next = 0;
 	struct Map *MapP;
 	struct Host *HostP;
-	int oldspl;
+	long oldspl;
 
 	disable(oldspl);		/* strange but true! */
  
diff -urN linux/drivers/char/synclink.c linux-64-latest/drivers/char/synclink.c
--- linux/drivers/char/synclink.c	Wed Aug 15 09:52:57 2001
+++ linux-64-latest/drivers/char/synclink.c	Thu Sep 13 12:30:11 2001
@@ -8013,7 +8013,8 @@
 int mgsl_sppp_open(struct net_device *d)
 {
 	struct mgsl_struct *info = d->priv;
-	int err, flags;
+	int err;
+	long flags;
 
 	if (debug_level >= DEBUG_LEVEL_INFO)
 		printk("mgsl_sppp_open(%s)\n",info->netname);	
@@ -8056,7 +8057,7 @@
 void mgsl_sppp_tx_timeout(struct net_device *dev)
 {
 	struct mgsl_struct *info = dev->priv;
-	int flags;
+	long flags;
 
 	if (debug_level >= DEBUG_LEVEL_INFO)
 		printk("mgsl_sppp_tx_timeout(%s)\n",info->netname);	
diff -urN linux/drivers/isdn/divert/divert_init.c linux-64-latest/drivers/isdn/divert/divert_init.c
--- linux/drivers/isdn/divert/divert_init.c	Thu Apr 19 22:01:36 2001
+++ linux-64-latest/drivers/isdn/divert/divert_init.c	Thu Sep 13 09:49:40 2001
@@ -70,7 +70,7 @@
 /* Module deinit code */
 /**********************/
 static void __exit divert_exit(void)
-{ int flags;
+{ long flags;
   int i;
 
   save_flags(flags);
diff -urN linux/drivers/isdn/divert/divert_procfs.c linux-64-latest/drivers/isdn/divert/divert_procfs.c
--- linux/drivers/isdn/divert/divert_procfs.c	Thu Aug 23 18:14:42 2001
+++ linux-64-latest/drivers/isdn/divert/divert_procfs.c	Thu Sep 13 09:49:20 2001
@@ -50,7 +50,7 @@
 put_info_buffer(char *cp)
 {
 	struct divert_info *ib;
-	int flags;
+	long flags;
 
 	if (if_used <= 0)
 		return;
@@ -145,7 +145,7 @@
 static int
 isdn_divert_open(struct inode *ino, struct file *filep)
 {
-	int flags;
+	long flags;
 
 	lock_kernel();
 	save_flags(flags);
@@ -168,7 +168,7 @@
 isdn_divert_close(struct inode *ino, struct file *filep)
 {
 	struct divert_info *inf;
-	int flags;
+	long flags;
 
 	lock_kernel();
 	save_flags(flags);
@@ -198,7 +198,8 @@
 		  uint cmd, ulong arg)
 {
 	divert_ioctl dioctl;
-	int i, flags;
+	int i;
+	long flags;
 	divert_rule *rulep;
 	char *cp;
 
diff -urN linux/drivers/isdn/divert/isdn_divert.c linux-64-latest/drivers/isdn/divert/isdn_divert.c
--- linux/drivers/isdn/divert/isdn_divert.c	Thu Apr 19 22:01:36 2001
+++ linux-64-latest/drivers/isdn/divert/isdn_divert.c	Thu Sep 13 09:48:40 2001
@@ -67,7 +67,7 @@
 /* timer callback function */
 /***************************/
 static void deflect_timer_expire(ulong arg)
-{ int flags;
+{ long flags;
   struct call_struc *cs = (struct call_struc *) arg;
 
   save_flags(flags);
@@ -125,7 +125,8 @@
 int cf_command(int drvid, int mode, 
                u_char proc, char *msn, 
                u_char service, char *fwd_nr, ulong *procid)
-{ int retval,msnlen,flags;
+{ long flags;
+  int retval,msnlen;
   int fwd_len;
   char *p,*ielenp,tmp[60];
   struct call_struc *cs;
@@ -220,7 +221,7 @@
 int deflect_extern_action(u_char cmd, ulong callid, char *to_nr)
 { struct call_struc *cs;
   isdn_ctrl ic;
-  int flags;
+  long flags;
   int i;
 
   if ((cmd & 0x7F) > 2) return(-EINVAL); /* invalid command */
@@ -291,7 +292,7 @@
 /********************************/
 int insertrule(int idx, divert_rule *newrule)
 { struct deflect_struc *ds,*ds1=NULL;
-  int flags;
+  long flags;
 
   if (!(ds = (struct deflect_struc *) kmalloc(sizeof(struct deflect_struc), 
                                               GFP_KERNEL))) 
@@ -337,7 +338,7 @@
 /***********************************/
 int deleterule(int idx)
 { struct deflect_struc *ds,*ds1;
-  int flags;
+  long flags;
   
   if (idx < 0) 
    { save_flags(flags);
@@ -405,7 +406,7 @@
 /*************************************************/
 int isdn_divert_icall(isdn_ctrl *ic)
 { int retval = 0;
-  int flags;
+  long flags;
   struct call_struc *cs = NULL; 
   struct deflect_struc *dv;
   char *p,*p1;
@@ -557,7 +558,7 @@
 
 void deleteprocs(void)
 { struct call_struc *cs, *cs1; 
-  int flags;
+  long flags;
 
   save_flags(flags);
   cli();
@@ -714,7 +715,8 @@
 /*********************************************/
 int prot_stat_callback(isdn_ctrl *ic)
 { struct call_struc *cs, *cs1;
-  int i,flags;
+  int i;
+  long flags;
 
   cs = divert_head; /* start of list */
   cs1 = NULL;
@@ -805,7 +807,8 @@
 /***************************/
 int isdn_divert_stat_callback(isdn_ctrl *ic)
 { struct call_struc *cs, *cs1;
-  int flags, retval;
+  long flags;
+  int retval;
 
   retval = -1;
   cs = divert_head; /* start of list */
diff -urN linux/drivers/isdn/eicon/linio.c linux-64-latest/drivers/isdn/eicon/linio.c
--- linux/drivers/isdn/eicon/linio.c	Thu Apr 19 22:01:35 2001
+++ linux-64-latest/drivers/isdn/eicon/linio.c	Thu Sep 13 10:03:59 2001
@@ -683,7 +683,7 @@
 	kfree(ptr);
 }
 
-int UxCardLock(ux_diva_card_t *card)
+long UxCardLock(ux_diva_card_t *card)
 {
 	unsigned long flags;
 
@@ -695,7 +695,7 @@
 	
 }
 
-void UxCardUnlock(ux_diva_card_t *card, int ipl)
+void UxCardUnlock(ux_diva_card_t *card, long ipl)
 {
 	//spin_unlock_irqrestore(&diva_lock, ipl);
 
diff -urN linux/drivers/isdn/eicon/uxio.h linux-64-latest/drivers/isdn/eicon/uxio.h
--- linux/drivers/isdn/eicon/uxio.h	Thu Aug 23 18:14:43 2001
+++ linux-64-latest/drivers/isdn/eicon/uxio.h	Thu Sep 13 10:04:48 2001
@@ -75,8 +75,8 @@
  * Lock and unlock access to a card
  */
 
-int		UxCardLock(ux_diva_card_t *card);
-void	UxCardUnlock(ux_diva_card_t *card, int ipl);
+long		UxCardLock(ux_diva_card_t *card);
+void	UxCardUnlock(ux_diva_card_t *card, long ipl);
 
 /*
  * Set the mapping address for PCI cards
diff -urN linux/drivers/isdn/hisax/hfc_pci.c linux-64-latest/drivers/isdn/hisax/hfc_pci.c
--- linux/drivers/isdn/hisax/hfc_pci.c	Wed Aug 15 09:53:01 2001
+++ linux-64-latest/drivers/isdn/hisax/hfc_pci.c	Thu Sep 13 10:07:04 2001
@@ -84,7 +84,7 @@
 void
 release_io_hfcpci(struct IsdnCardState *cs)
 {
-	int flags;
+	long flags;
 
 	save_flags(flags);
 	cli();
@@ -299,7 +299,8 @@
 	u_char *ptr, *ptr1, new_f2;
 	struct sk_buff *skb;
 	struct IsdnCardState *cs = bcs->cs;
-	int flags, total, maxlen, new_z2;
+	long flags;
+	int total, maxlen, new_z2;
 	z_type *zp;
 
 	save_flags(flags);
@@ -633,7 +634,8 @@
 hfcpci_fill_fifo(struct BCState *bcs)
 {
 	struct IsdnCardState *cs = bcs->cs;
-	int flags, maxlen, fcnt;
+	long flags;
+	int maxlen, fcnt;
 	int count, new_z1;
 	bzfifo_type *bz;
 	u_char *bdata;
@@ -810,7 +812,7 @@
 static int
 hfcpci_auxcmd(struct IsdnCardState *cs, isdn_ctrl * ic)
 {
-	int flags;
+	long flags;
 	int i = *(unsigned int *) ic->parm.num;
 
 	if ((ic->arg == 98) &&
@@ -1160,7 +1162,7 @@
 {
 	struct IsdnCardState *cs = (struct IsdnCardState *) st->l1.hardware;
 	struct sk_buff *skb = arg;
-	int flags;
+	long flags;
 
 	switch (pr) {
 		case (PH_DATA | REQUEST):
@@ -1314,7 +1316,8 @@
 mode_hfcpci(struct BCState *bcs, int mode, int bc)
 {
 	struct IsdnCardState *cs = bcs->cs;
-	int flags, fifo2;
+	long flags;
+	int fifo2;
 
 	if (cs->debug & L1_DEB_HSCX)
 		debugl1(cs, "HFCPCI bchannel mode %d bchan %d/%d",
@@ -1548,7 +1551,7 @@
 static void
 hfcpci_bh(struct IsdnCardState *cs)
 {
-	int flags;
+	long flags;
 /*      struct PStack *stptr;
  */
 	if (!cs)
diff -urN linux/drivers/isdn/hisax/hfc_sx.c linux-64-latest/drivers/isdn/hisax/hfc_sx.c
--- linux/drivers/isdn/hisax/hfc_sx.c	Sat Jul 21 15:04:20 2001
+++ linux-64-latest/drivers/isdn/hisax/hfc_sx.c	Thu Sep 13 10:08:41 2001
@@ -73,7 +73,7 @@
 /******************************/
 static inline void
 Write_hfc(struct IsdnCardState *cs, u_char regnum, u_char val)
-{       register int flags;
+{       long flags;
 
         save_flags(flags);
 	cli();
@@ -84,8 +84,8 @@
 
 static inline u_char
 Read_hfc(struct IsdnCardState *cs, u_char regnum)
-{       register int flags;
-        register u_char ret; 
+{       long flags;
+        u_char ret; 
 
         save_flags(flags);
 	cli();
@@ -101,7 +101,7 @@
 /**************************************************/
 static void
 fifo_select(struct IsdnCardState *cs, u_char fifo)
-{       int flags;
+{       long flags;
 
         if (fifo == cs->hw.hfcsx.last_fifo) 
 	  return; /* still valid */
@@ -123,7 +123,7 @@
 /******************************************/
 static void
 reset_fifo(struct IsdnCardState *cs, u_char fifo)
-{       int flags;
+{       long flags;
 
         save_flags(flags); 
 	cli();
@@ -337,7 +337,7 @@
 void
 release_io_hfcsx(struct IsdnCardState *cs)
 {
-	int flags;
+	long flags;
 
 	save_flags(flags);
 	cli();
@@ -599,7 +599,7 @@
 hfcsx_fill_fifo(struct BCState *bcs)
 {
 	struct IsdnCardState *cs = bcs->cs;
-	int flags;
+	long flags;
 
 	if (!bcs->tx_skb)
 		return;
@@ -670,7 +670,7 @@
 static int
 hfcsx_auxcmd(struct IsdnCardState *cs, isdn_ctrl * ic)
 {
-	int flags;
+	long flags;
 	int i = *(unsigned int *) ic->parm.num;
 
 	if ((ic->arg == 98) &&
@@ -729,7 +729,7 @@
 static void
 receive_emsg(struct IsdnCardState *cs)
 {
-	int flags;
+	long flags;
 	int count = 5;
 	u_char *ptr;
 	struct sk_buff *skb;
@@ -961,7 +961,7 @@
 {
 	struct IsdnCardState *cs = (struct IsdnCardState *) st->l1.hardware;
 	struct sk_buff *skb = arg;
-	int flags;
+	long flags;
 
 	switch (pr) {
 		case (PH_DATA | REQUEST):
@@ -1115,7 +1115,8 @@
 mode_hfcsx(struct BCState *bcs, int mode, int bc)
 {
 	struct IsdnCardState *cs = bcs->cs;
-	int flags, fifo2;
+	long flags;
+	int fifo2;
 
 	if (cs->debug & L1_DEB_HSCX)
 		debugl1(cs, "HFCSX bchannel mode %d bchan %d/%d",
@@ -1338,7 +1339,7 @@
 static void
 hfcsx_bh(struct IsdnCardState *cs)
 {
-	int flags;
+	long flags;
 /*      struct PStack *stptr;
  */
 	if (!cs)
@@ -1478,7 +1479,7 @@
 {
 	struct IsdnCardState *cs = card->cs;
 	char tmp[64];
-	int flags;
+	long flags;
 
 	strcpy(tmp, hfcsx_revision);
 	printk(KERN_INFO "HiSax: HFC-SX driver Rev. %s\n", HiSax_getrev(tmp));
diff -urN linux/drivers/isdn/hisax/l3dss1.c linux-64-latest/drivers/isdn/hisax/l3dss1.c
--- linux/drivers/isdn/hisax/l3dss1.c	Thu Apr 19 22:01:35 2001
+++ linux-64-latest/drivers/isdn/hisax/l3dss1.c	Thu Sep 13 10:09:25 2001
@@ -44,7 +44,8 @@
 static unsigned char new_invoke_id(struct PStack *p)
 {
 	unsigned char retval;
-	int flags,i;
+	long flags;
+	int i;
   
 	i = 32; /* maximum search depth */
 
@@ -72,7 +73,7 @@
 /* free a used invoke id */
 /*************************/
 static void free_invoke_id(struct PStack *p, unsigned char id)
-{ int flags;
+{ long flags;
 
   if (!id) return; /* 0 = invalid value */
 
diff -urN linux/drivers/isdn/hisax/l3ni1.c linux-64-latest/drivers/isdn/hisax/l3ni1.c
--- linux/drivers/isdn/hisax/l3ni1.c	Thu Apr 19 22:01:35 2001
+++ linux-64-latest/drivers/isdn/hisax/l3ni1.c	Thu Sep 13 10:11:27 2001
@@ -48,7 +48,8 @@
 static unsigned char new_invoke_id(struct PStack *p)
 {
 	unsigned char retval;
-	int flags,i;
+	long flags;
+	int i;
   
 	i = 32; /* maximum search depth */
 
@@ -76,7 +77,7 @@
 /* free a used invoke id */
 /*************************/
 static void free_invoke_id(struct PStack *p, unsigned char id)
-{ int flags;
+{ long flags;
 
   if (!id) return; /* 0 = invalid value */
 
diff -urN linux/drivers/isdn/icn/icn.c linux-64-latest/drivers/isdn/icn/icn.c
--- linux/drivers/isdn/icn/icn.c	Thu Aug 23 18:14:44 2001
+++ linux-64-latest/drivers/isdn/icn/icn.c	Thu Sep 13 10:12:17 2001
@@ -607,7 +607,7 @@
 	int left;
 	u_char c;
 	int ch;
-	int flags;
+	long flags;
 	int i;
 	u_char *p;
 	isdn_ctrl cmd;
diff -urN linux/drivers/isdn/isdn_common.c linux-64-latest/drivers/isdn/isdn_common.c
--- linux/drivers/isdn/isdn_common.c	Thu Aug 23 18:14:41 2001
+++ linux-64-latest/drivers/isdn/isdn_common.c	Thu Sep 13 09:53:02 2001
@@ -280,7 +280,7 @@
 	}
 	if (tf) 
 	{
-		int flags;
+		long flags;
 
 		save_flags(flags);
 		cli();
@@ -292,7 +292,8 @@
 void
 isdn_timer_ctrl(int tf, int onoff)
 {
-	int flags, old_tflags;
+	long flags;
+	int old_tflags;
 
 	save_flags(flags);
 	cli();
@@ -2393,7 +2394,7 @@
  */
 static void __exit isdn_exit(void)
 {
-	int flags;
+	long flags;
 	int i;
 
 #ifdef CONFIG_ISDN_PPP
diff -urN linux/drivers/isdn/isdn_net.c linux-64-latest/drivers/isdn/isdn_net.c
--- linux/drivers/isdn/isdn_net.c	Wed Aug 15 09:53:01 2001
+++ linux-64-latest/drivers/isdn/isdn_net.c	Thu Sep 13 09:52:02 2001
@@ -583,7 +583,7 @@
 	isdn_net_dev *p = dev->netdev;
 	int anymore = 0;
 	int i;
-	int flags;
+	ulong flags;
 	isdn_ctrl cmd;
 
 	while (p) {
@@ -2787,7 +2787,7 @@
 			chidx = lp->pre_channel;
 		}
 		if (cfg->exclusive > 0) {
-			int flags;
+			ulong flags;
 
 			/* If binding is exclusive, try to grab the channel */
 			save_flags(flags);
@@ -3043,7 +3043,7 @@
 	int inout = phone->outgoing & 1;
 	isdn_net_phone *n;
 	isdn_net_phone *m;
-	int flags;
+	ulong flags;
 
 	if (p) {
 		save_flags(flags);
@@ -3079,7 +3079,7 @@
 {
 	isdn_net_phone *n;
 	isdn_net_phone *m;
-	int flags;
+	ulong flags;
 	int i;
 
 	save_flags(flags);
@@ -3128,7 +3128,7 @@
 static int
 isdn_net_realrm(isdn_net_dev * p, isdn_net_dev * q)
 {
-	int flags;
+	ulong flags;
 
 	save_flags(flags);
 	cli();
@@ -3214,7 +3214,7 @@
 int
 isdn_net_rmall(void)
 {
-	int flags;
+	ulong flags;
 	int ret;
 
 	/* Walk through netdev-chain */
diff -urN linux/drivers/isdn/isdnloop/isdnloop.c linux-64-latest/drivers/isdn/isdnloop/isdnloop.c
--- linux/drivers/isdn/isdnloop/isdnloop.c	Thu Aug 23 18:14:45 2001
+++ linux-64-latest/drivers/isdn/isdnloop/isdnloop.c	Thu Sep 13 09:50:28 2001
@@ -323,7 +323,7 @@
 	int left;
 	u_char c;
 	int ch;
-	int flags;
+	unsigned long flags;
 	u_char *p;
 	isdn_ctrl cmd;
 
diff -urN linux/drivers/net/dl2k.c linux-64-latest/drivers/net/dl2k.c
--- linux/drivers/net/dl2k.c	Sat Jul 21 15:04:25 2001
+++ linux-64-latest/drivers/net/dl2k.c	Wed Sep 12 22:32:17 2001
@@ -470,7 +470,7 @@
 	unsigned entry;
 	u32 ioaddr;
 	int tx_shift;
-	unsigned flags;
+	unsigned long flags;
 
 	ioaddr = dev->base_addr;
 	entry = np->cur_tx % TX_RING_SIZE;
diff -urN linux/drivers/net/irda/vlsi_ir.c linux-64-latest/drivers/net/irda/vlsi_ir.c
--- linux/drivers/net/irda/vlsi_ir.c	Thu Aug 23 18:14:51 2001
+++ linux-64-latest/drivers/net/irda/vlsi_ir.c	Thu Sep 13 11:13:57 2001
@@ -728,7 +728,7 @@
 	u8		irintr;
 	int 		boguscount = 20;
 	int		no_speed_check = 0;
-	unsigned	flags;
+	unsigned long	flags;
 
 
 	iobase = ndev->base_addr;
diff -urN linux/drivers/net/wan/cycx_x25.c linux-64-latest/drivers/net/wan/cycx_x25.c
--- linux/drivers/net/wan/cycx_x25.c	Thu Aug 23 18:14:52 2001
+++ linux-64-latest/drivers/net/wan/cycx_x25.c	Thu Sep 13 11:24:02 2001
@@ -1347,7 +1347,7 @@
 {
 	x25_channel_t *chan = dev->priv;
 	cycx_t *card = chan->card;
-	u32 flags = 0;
+	long flags;
 	char *string_state = NULL;
 
 	spin_lock_irqsave(&card->lock, flags);
diff -urN linux/drivers/net/wireless/airo.c linux-64-latest/drivers/net/wireless/airo.c
--- linux/drivers/net/wireless/airo.c	Thu Aug 23 18:14:52 2001
+++ linux-64-latest/drivers/net/wireless/airo.c	Thu Sep 13 13:53:54 2001
@@ -1228,7 +1228,7 @@
 	/* Check to see if there is something to receive */
 	if ( status & EV_RX  ) {
 		struct sk_buff *skb = NULL;
-		int flags;
+		long flags;
 		u16 fc, len, hdrlen = 0;
 		struct {
 			u16 status, len;
@@ -1559,7 +1559,7 @@
         // Im really paranoid about letting it run forever!
 	int max_tries = 600000;  
         int rc = SUCCESS;
-	int flags;
+	long flags;
 
 	spin_lock_irqsave(&ai->cmd_lock, flags);
 	OUT4500(ai, PARAM0, pCmd->parm0);
@@ -1664,7 +1664,7 @@
 	u16 next;
 	int words;
 	int i;
-	int flags;
+	long flags;
 
 	spin_lock_irqsave(&ai->aux_lock, flags);
 	page = IN4500(ai, SWS0+whichbap);
@@ -1738,7 +1738,7 @@
 static int PC4500_readrid(struct airo_info *ai, u16 rid, void *pBuf, int len)
 {
 	u16 status;
-        int flags;
+        long flags;
         int rc = SUCCESS;
 
 	spin_lock_irqsave(&ai->bap1_lock, flags);
@@ -1780,7 +1780,7 @@
 			   const void *pBuf, int len)
 {
 	u16 status;
-        int flags;
+        long flags;
 	int rc = SUCCESS;
 
 	spin_lock_irqsave(&ai->bap1_lock, flags);
@@ -1810,7 +1810,7 @@
 	Resp rsp;
 	u16 txFid;
 	u16 txControl;
-        int flags;
+        long flags;
 
 	cmd.cmd = CMD_ALLOCATETX;
 	cmd.parm0 = lenPayload;
diff -urN linux/drivers/sound/gus_wave.c linux-64-latest/drivers/sound/gus_wave.c
--- linux/drivers/sound/gus_wave.c	Fri Jul  6 01:29:21 2001
+++ linux-64-latest/drivers/sound/gus_wave.c	Thu Sep 13 12:12:55 2001
@@ -1952,7 +1952,7 @@
 	int voice, cmd;
 	unsigned short p1, p2;
 	unsigned int plong;
-	unsigned flags;
+	unsigned long flags;
 
 	cmd = event_rec[2];
 	voice = event_rec[3];
diff -urN linux/drivers/usb/pwc-if.c linux-64-latest/drivers/usb/pwc-if.c
--- linux/drivers/usb/pwc-if.c	Thu Aug 23 18:15:03 2001
+++ linux-64-latest/drivers/usb/pwc-if.c	Wed Sep 12 22:30:16 2001
@@ -461,7 +461,8 @@
  */
 static inline int pwc_next_fill_frame(struct pwc_device *pdev)
 {
-	int ret, flags;
+	int ret;
+	unsigned long flags;
 	
 	ret = 0;
 	spin_lock_irqsave(&pdev->ptrlock, flags);
@@ -512,7 +513,8 @@
  */
 static void pwc_reset_buffers(struct pwc_device *pdev)
 {
-	int i, flags;
+	int i;
+	unsigned long flags;
 
 	spin_lock_irqsave(&pdev->ptrlock, flags);
 	pdev->full_frames = NULL;
@@ -541,7 +543,8 @@
  */
 static int pwc_handle_frame(struct pwc_device *pdev)
 {
-	int ret = 0, flags;
+	int ret = 0;
+	unsigned long flags;
 	
 	spin_lock_irqsave(&pdev->ptrlock, flags);
 	/* First grab our read_frame; this is removed from all lists, so
diff -urN linux/drivers/video/sis/sis_main.c linux-64-latest/drivers/video/sis/sis_main.c
--- linux/drivers/video/sis/sis_main.c	Thu Aug 23 18:15:05 2001
+++ linux-64-latest/drivers/video/sis/sis_main.c	Thu Sep 13 11:15:56 2001
@@ -593,7 +593,7 @@
 	struct fb_fix_screeninfo fix;
 	struct display *display;
 	struct display_switch *sw;
-	u32 flags;
+	long flags;
 
 	if (con >= 0)
 		display = &fb_display[con];

-- 
Vojtech Pavlik
SuSE Labs

