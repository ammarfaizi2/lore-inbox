Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129055AbRBEORr>; Mon, 5 Feb 2001 09:17:47 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129134AbRBEORi>; Mon, 5 Feb 2001 09:17:38 -0500
Received: from delta.ds2.pg.gda.pl ([153.19.144.1]:37603 "EHLO
	delta.ds2.pg.gda.pl") by vger.kernel.org with ESMTP
	id <S129055AbRBEORV>; Mon, 5 Feb 2001 09:17:21 -0500
Date: Mon, 5 Feb 2001 15:14:51 +0100 (MET)
From: "Maciej W. Rozycki" <macro@ds2.pg.gda.pl>
Reply-To: "Maciej W. Rozycki" <macro@ds2.pg.gda.pl>
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
cc: Tjeerd Mulder <tjeerd.mulder@fujitsu-siemens.com>,
        linux-kernel@vger.kernel.org
Subject: [patch] 2.4.1-ac1: defxx fixes -- a next iteration
Message-ID: <Pine.GSO.3.96.1010205150311.18067N-100000@delta.ds2.pg.gda.pl>
Organization: Technical University of Gdansk
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Alan,

 I've noticed the oops has been fixed but the driver still fails due to a
memory exaustion.  I've worked on merging 2.4.1-ac1 changes with what I
developed so far.  Following is the result.  No more memory exaustion, as
skbs are not allocated with GFP_ATOMIC upon startup anymore (no change to
the rx interrupt handler, of course).

 I've also changed drivers/net/Config.in -- the driver handles EISA DEFEA
boards as well.

 I'm not sure who is responsible for 2.4.1-ac1 fixes to the driver so I
put a change log entry with no ID.

  Maciej

-- 
+  Maciej W. Rozycki, Technical University of Gdansk, Poland   +
+--------------------------------------------------------------+
+        e-mail: macro@ds2.pg.gda.pl, PGP key available        +

patch-2.4.1-ac1-defxx-8
diff -up --recursive --new-file linux-2.4.1-ac1.macro/drivers/net/Config.in linux-2.4.1-ac1/drivers/net/Config.in
--- linux-2.4.1-ac1.macro/drivers/net/Config.in	Sat Feb  3 12:16:31 2001
+++ linux-2.4.1-ac1/drivers/net/Config.in	Sat Feb  3 13:03:29 2001
@@ -192,7 +192,9 @@ endmenu
 
 bool 'FDDI driver support' CONFIG_FDDI
 if [ "$CONFIG_FDDI" = "y" ]; then
-   dep_tristate '  Digital DEFEA and DEFPA adapter support' CONFIG_DEFXX $CONFIG_PCI
+   if [ "$CONFIG_PCI" = "y" -o "$CONFIG_EISA" = "y" ]; then
+      tristate '  Digital DEFEA and DEFPA adapter support' CONFIG_DEFXX
+   fi
    tristate '  SysKonnect FDDI PCI support' CONFIG_SKFP
 fi
 
diff -up --recursive --new-file linux-2.4.1-ac1.macro/drivers/net/defxx.c linux-2.4.1-ac1/drivers/net/defxx.c
--- linux-2.4.1-ac1.macro/drivers/net/defxx.c	Sat Feb  3 12:16:33 2001
+++ linux-2.4.1-ac1/drivers/net/defxx.c	Sat Feb  3 14:22:52 2001
@@ -195,6 +195,7 @@
  *		Jun 2000	jgarzik		PCI and resource alloc cleanups
  *		Jul 2000	tjeerd		Much cleanup and some bug fixes
  *		Sep 2000	tjeerd		Fix leak on unload, cosmetic code cleanup
+ *		Feb 2001			Skb allocation fixes
  */
 
 /* Include files */
@@ -225,7 +226,7 @@
 /* Version information string - should be updated prior to each new release!!! */
 
 static char version[] __devinitdata =
-	"defxx.c:v1.05d 2000/09/05  Lawrence V. Stefani and others\n";
+	"defxx.c:v1.05e 2001/02/03  Lawrence V. Stefani and others\n";
 
 #define DYNAMIC_BUFFERS 1
 
@@ -242,7 +243,7 @@ static void		dfx_bus_init(struct net_dev
 static void		dfx_bus_config_check(DFX_board_t *bp);
 
 static int		dfx_driver_init(struct net_device *dev);
-static int		dfx_adap_init(DFX_board_t *bp);
+static int		dfx_adap_init(DFX_board_t *bp, int get_buffers);
 
 static int		dfx_open(struct net_device *dev);
 static int		dfx_close(struct net_device *dev);
@@ -264,7 +265,7 @@ static void		dfx_hw_adap_reset(DFX_board
 static int		dfx_hw_adap_state_rd(DFX_board_t *bp);
 static int		dfx_hw_dma_uninit(DFX_board_t *bp, PI_UINT32 type);
 
-static int		dfx_rcv_init(DFX_board_t *bp);
+static int		dfx_rcv_init(DFX_board_t *bp, int get_buffers);
 static void		dfx_rcv_queue_process(DFX_board_t *bp);
 static void		dfx_rcv_flush(DFX_board_t *bp);
 
@@ -973,6 +974,7 @@ static int __devinit dfx_driver_init(str
  *       
  * Arguments:
  *   bp - pointer to board information
+ *   get_buffers - non-zero if buffers to be allocated
  *
  * Functional Description:
  *   Issues the low-level firmware/hardware calls necessary to bring
@@ -992,7 +994,7 @@ static int __devinit dfx_driver_init(str
  *   upon a successful return of this routine.
  */
 
-static int dfx_adap_init(DFX_board_t *bp)
+static int dfx_adap_init(DFX_board_t *bp, int get_buffers)
 	{
 	DBG_printk("In dfx_adap_init...\n");
 
@@ -1132,14 +1134,16 @@ static int dfx_adap_init(DFX_board_t *bp
 	 * reinitialized)
 	 */
 
-	dfx_rcv_flush(bp);
+	if (get_buffers)
+		dfx_rcv_flush(bp);
 
 	/* Initialize receive descriptor block and produce buffers */
 
-	if (dfx_rcv_init(bp))
+	if (dfx_rcv_init(bp, get_buffers))
 	        {
 		printk("%s: Receive buffer allocation failed\n", bp->dev->name);
-		dfx_rcv_flush(bp);
+		if (get_buffers)
+			dfx_rcv_flush(bp);
 		return(DFX_K_FAILURE);
 		}
 
@@ -1149,7 +1153,8 @@ static int dfx_adap_init(DFX_board_t *bp
 	if (dfx_hw_dma_cmd_req(bp) != DFX_K_SUCCESS)
 		{
 		printk("%s: Start command failed\n", bp->dev->name);
-		dfx_rcv_flush(bp);
+		if (get_buffers)
+			dfx_rcv_flush(bp);
 		return(DFX_K_FAILURE);
 		}
 
@@ -1235,7 +1240,7 @@ static int dfx_open(struct net_device *d
 	/* Reset and initialize adapter */
 
 	bp->reset_type = PI_PDATA_A_RESET_M_SKIP_ST;	/* skip self-test */
-	if (dfx_adap_init(bp) != DFX_K_SUCCESS)
+	if (dfx_adap_init(bp, 1) != DFX_K_SUCCESS)
 	{
 		printk(KERN_ERR "%s: Adapter open failed!\n", dev->name);
 		free_irq(dev->irq, dev);
@@ -1512,7 +1517,7 @@ static void dfx_int_type_0_process(DFX_b
 		bp->link_available = PI_K_FALSE;	/* link is no longer available */
 		bp->reset_type = 0;					/* rerun on-board diagnostics */
 		printk("%s: Resetting adapter...\n", bp->dev->name);
-		if (dfx_adap_init(bp) != DFX_K_SUCCESS)
+		if (dfx_adap_init(bp, 0) != DFX_K_SUCCESS)
 			{
 			printk("%s: Adapter reset failed!  Disabling adapter interrupts.\n", bp->dev->name);
 			dfx_port_write_long(bp, PI_PDQ_K_REG_HOST_INT_ENB, PI_HOST_INT_K_DISABLE_ALL_INTS);
@@ -1560,7 +1565,7 @@ static void dfx_int_type_0_process(DFX_b
 			bp->link_available = PI_K_FALSE;	/* link is no longer available */
 			bp->reset_type = 0;					/* rerun on-board diagnostics */
 			printk("%s: Resetting adapter...\n", bp->dev->name);
-			if (dfx_adap_init(bp) != DFX_K_SUCCESS)
+			if (dfx_adap_init(bp, 0) != DFX_K_SUCCESS)
 				{
 				printk("%s: Adapter reset failed!  Disabling adapter interrupts.\n", bp->dev->name);
 				dfx_port_write_long(bp, PI_PDQ_K_REG_HOST_INT_ENB, PI_HOST_INT_K_DISABLE_ALL_INTS);
@@ -2634,7 +2639,28 @@ static int dfx_hw_dma_uninit(DFX_board_t
 		return(DFX_K_HW_TIMEOUT);
 	return(DFX_K_SUCCESS);
 	}
+
+/*
+ * =================
+ * = dfx_alloc_skb =
+ * =================
+ *
+ * Overview:
+ *   Allocate an skbuff for sending.
+ *
+ * Functional Description:
+ *  Same as dev_alloc_skb(), but it may sleep.
+ */
 
+static inline struct sk_buff *dfx_alloc_skb(unsigned int length)
+{
+	struct sk_buff *skb;
+
+	skb = alloc_skb(length + 16, GFP_BUFFER);
+	if (skb)
+		skb_reserve(skb, 16);
+	return skb;
+}
 
 /*
  *	Align an sk_buff to a boundary power of 2
@@ -2665,6 +2691,7 @@ static void my_skb_align(struct sk_buff 
  *       
  * Arguments:
  *   bp - pointer to board information
+ *   get_buffers - non-zero if buffers to be allocated
  *
  * Functional Description:
  *   This routine can be called during dfx_adap_init() or during an adapter
@@ -2686,7 +2713,7 @@ static void my_skb_align(struct sk_buff 
  *   is notified.
  */
 
-static int dfx_rcv_init(DFX_board_t *bp)
+static int dfx_rcv_init(DFX_board_t *bp, int get_buffers)
 	{
 	int	i, j;					/* used in for loop */
 
@@ -2708,13 +2735,14 @@ static int dfx_rcv_init(DFX_board_t *bp)
 	 *		driver initialization when we allocated memory for the receive buffers.
 	 */
 
+	if (get_buffers) {
 #ifdef DYNAMIC_BUFFERS
 	for (i = 0; i < (int)(bp->rcv_bufs_to_post); i++)
 		for (j = 0; (i + j) < (int)PI_RCV_DATA_K_NUM_ENTRIES; j += bp->rcv_bufs_to_post)
 		{
-			struct sk_buff *newskb = dev_alloc_skb(NEW_SKB_SIZE);
+			struct sk_buff *newskb = dfx_alloc_skb(NEW_SKB_SIZE);
 			if (!newskb)
-			    return -ENOMEM;
+				return -ENOMEM;
 			bp->descr_block_virt->rcv_data[i+j].long_0 = (u32) (PI_RCV_DESCR_M_SOP |
 				((PI_RCV_DATA_K_SIZE_MAX / PI_ALIGN_K_RCV_DATA_BUFF) << PI_RCV_DESCR_V_SEG_LEN));
 			/*
@@ -2740,6 +2768,7 @@ static int dfx_rcv_init(DFX_board_t *bp)
 			bp->p_rcv_buff_va[i+j] = (char *) (bp->rcv_block_virt + (i * PI_RCV_DATA_K_SIZE_MAX));
 			}
 #endif
+	}
 
 	/* Update receive producer and Type 2 register */
 
@@ -3221,7 +3250,8 @@ static void dfx_rcv_flush( DFX_board_t *
 	for (i = 0; i < (int)(bp->rcv_bufs_to_post); i++)
 		for (j = 0; (i + j) < (int)PI_RCV_DATA_K_NUM_ENTRIES; j += bp->rcv_bufs_to_post)
 		{
-			struct sk_buff *skb = bp->p_rcv_buff_va[i+j];
+			struct sk_buff *skb;
+			skb = (struct sk_buff *)bp->p_rcv_buff_va[i+j];
 			if (skb)
 				dev_kfree_skb(skb);
 			bp->p_rcv_buff_va[i+j] = NULL;


-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
