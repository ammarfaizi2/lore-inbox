Return-Path: <linux-kernel-owner+willy=40w.ods.org-S267278AbUJFRrT@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S267278AbUJFRrT (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 6 Oct 2004 13:47:19 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S269324AbUJFRrT
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 6 Oct 2004 13:47:19 -0400
Received: from fw.osdl.org ([65.172.181.6]:11922 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S267278AbUJFRpI (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 6 Oct 2004 13:45:08 -0400
Date: Wed, 6 Oct 2004 10:43:50 -0700 (PDT)
From: Linus Torvalds <torvalds@osdl.org>
To: Jeff Garzik <jgarzik@pobox.com>,
       Arnaldo Carvalho de Melo <acme@conectiva.com.br>,
       Corey Thomas <corey@world.std.com>
cc: netdev@oss.sgi.com, Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Raylink/WebGear testing - ray_cs.c iomem bug?
Message-ID: <Pine.LNX.4.58.0410061032410.8290@ppc970.osdl.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Does anybody have a raylink/WebGear card any more? I used to have one, and 
as a result, I still had it in the default config for my laptop, and that 
in turn caused me to fix up the sparse-warnings for iomem annotations.

That cleanup in turn seems to show that the driver was fundamentally buggy
in a way that really surprises me: it adds "CCS_BASE" to the PCI window
base in order to get to both the "struct ccs" pointer _and_ to the "struct
rcs" pointer.

The RCS_BASE offset (which would seem to be the obvious one for the
"struct rcs" pointer) is totally unused by the driver.

If somebody has access to this card and can test it, can you email me? I'd 
hate to apply even an "obvious" fix when the bug may be hidden by other 
bugs, and the obvious fix might end up breaking things for silly reasons.

I append the cleanup-patch, which leaves "rcs_base()" being calculated
using the CCS_BASE offset. It looks strange as hell, but that's what the
code used to do.. What I'd like people to test is changing that
"rcs_base()" function to use RCS_BASE instead, and seeing if that still
results in a working driver (or maybe even fixes something).

		Linus

-----
===== drivers/net/wireless/ray_cs.c 1.28 vs edited =====
--- 1.28/drivers/net/wireless/ray_cs.c	2004-07-13 06:29:35 -07:00
+++ edited/drivers/net/wireless/ray_cs.c	2004-10-06 10:27:05 -07:00
@@ -112,9 +112,9 @@
 static int ray_dev_start_xmit(struct sk_buff *skb, struct net_device *dev);
 static void set_multicast_list(struct net_device *dev);
 static void ray_update_multi_list(struct net_device *dev, int all);
-static int translate_frame(ray_dev_t *local, struct tx_msg *ptx,
+static int translate_frame(ray_dev_t *local, struct tx_msg __iomem *ptx,
                 unsigned char *data, int len);
-static void ray_build_header(ray_dev_t *local, struct tx_msg *ptx, UCHAR msg_type,
+static void ray_build_header(ray_dev_t *local, struct tx_msg __iomem *ptx, UCHAR msg_type,
                 unsigned char *data);
 static void untranslate(ray_dev_t *local, struct sk_buff *skb, int len);
 #if WIRELESS_EXT > 7	/* If wireless extension exist in the kernel */
@@ -140,14 +140,14 @@
 /* Prototypes for interrpt time functions **********************************/
 static irqreturn_t ray_interrupt (int reg, void *dev_id, struct pt_regs *regs);
 static void clear_interrupt(ray_dev_t *local);
-static void rx_deauthenticate(ray_dev_t *local, struct rcs *prcs, 
+static void rx_deauthenticate(ray_dev_t *local, struct rcs __iomem *prcs, 
                        unsigned int pkt_addr, int rx_len);
 static int copy_from_rx_buff(ray_dev_t *local, UCHAR *dest, int pkt_addr, int len);
-static void ray_rx(struct net_device *dev, ray_dev_t *local, struct rcs *prcs);
-static void release_frag_chain(ray_dev_t *local, struct rcs *prcs);
-static void rx_authenticate(ray_dev_t *local, struct rcs *prcs,
+static void ray_rx(struct net_device *dev, ray_dev_t *local, struct rcs __iomem *prcs);
+static void release_frag_chain(ray_dev_t *local, struct rcs __iomem *prcs);
+static void rx_authenticate(ray_dev_t *local, struct rcs __iomem *prcs,
                      unsigned int pkt_addr, int rx_len);
-static void rx_data(struct net_device *dev, struct rcs *prcs, unsigned int pkt_addr, 
+static void rx_data(struct net_device *dev, struct rcs __iomem *prcs, unsigned int pkt_addr, 
              int rx_len);
 static void associate(ray_dev_t *local);
 
@@ -540,7 +540,7 @@
     CS_CHECK(RequestWindow, pcmcia_request_window(&link->handle, &req, &link->win));
     mem.CardOffset = 0x0000; mem.Page = 0;
     CS_CHECK(MapMemPage, pcmcia_map_mem_page(link->win, &mem));
-    local->sram = (UCHAR *)(ioremap(req.Base,req.Size));
+    local->sram = ioremap(req.Base,req.Size);
 
 /*** Set up 16k window for shared memory (receive buffer) ***************/
     req.Attributes = WIN_DATA_WIDTH_8 | WIN_MEMORY_TYPE_CM | WIN_ENABLE | WIN_USE_WAIT;
@@ -550,7 +550,7 @@
     CS_CHECK(RequestWindow, pcmcia_request_window(&link->handle, &req, &local->rmem_handle));
     mem.CardOffset = 0x8000; mem.Page = 0;
     CS_CHECK(MapMemPage, pcmcia_map_mem_page(local->rmem_handle, &mem));
-    local->rmem = (UCHAR *)(ioremap(req.Base,req.Size));
+    local->rmem = ioremap(req.Base,req.Size);
 
 /*** Set up window for attribute memory ***********************************/
     req.Attributes = WIN_DATA_WIDTH_8 | WIN_MEMORY_TYPE_AM | WIN_ENABLE | WIN_USE_WAIT;
@@ -560,7 +560,7 @@
     CS_CHECK(RequestWindow, pcmcia_request_window(&link->handle, &req, &local->amem_handle));
     mem.CardOffset = 0x0000; mem.Page = 0;
     CS_CHECK(MapMemPage, pcmcia_map_mem_page(local->amem_handle, &mem));
-    local->amem = (UCHAR *)(ioremap(req.Base,req.Size));
+    local->amem = ioremap(req.Base,req.Size);
 
     DEBUG(3,"ray_config sram=%p\n",local->sram);
     DEBUG(3,"ray_config rmem=%p\n",local->rmem);
@@ -593,12 +593,28 @@
 
     ray_release(link);
 } /* ray_config */
+
+static inline struct ccs __iomem *ccs_base(ray_dev_t *dev)
+{
+	return dev->sram + CCS_BASE;
+}
+
+static inline struct rcs __iomem *rcs_base(ray_dev_t *dev)
+{
+	/*
+	 * Is this really right? Should it be RCS_BASE?
+	 * All the users used CCS_BASE, but this makes
+	 * no sense naming-wise not logically..
+	 */
+	return dev->sram + CCS_BASE;
+}
+
 /*===========================================================================*/
 static int ray_init(struct net_device *dev)
 {
     int i;
     UCHAR *p;
-    struct ccs *pccs;
+    struct ccs __iomem *pccs;
     ray_dev_t *local = (ray_dev_t *)dev->priv;
     dev_link_t *link = local->finder;
     DEBUG(1, "ray_init(0x%p)\n", dev);
@@ -632,7 +648,7 @@
         local->tib_length = local->startup_res.tib_length;
     DEBUG(2,"ray_init tib_length = 0x%02x\n", local->tib_length);
     /* Initialize CCS's to buffer free state */
-    pccs = (struct ccs *)(local->sram + CCS_BASE);
+    pccs = ccs_base(local);
     for (i=0;  i<NUMBER_OF_CCS;  i++) {
         writeb(CCS_BUFFER_FREE, &(pccs++)->buffer_status);
     }
@@ -661,7 +677,7 @@
 {
     int ccsindex;
     ray_dev_t *local = (ray_dev_t *)dev->priv;
-    struct ccs *pccs;
+    struct ccs __iomem *pccs;
     dev_link_t *link = local->finder;
 
     DEBUG(1,"dl_startup_params entered\n");
@@ -682,7 +698,7 @@
     /* Fill in the CCS fields for the ECF */
     if ((ccsindex = get_free_ccs(local)) < 0) return -1;
     local->dl_param_ccs = ccsindex;
-    pccs = ((struct ccs *)(local->sram + CCS_BASE)) + ccsindex;
+    pccs = ccs_base(local) + ccsindex;
     writeb(CCS_DOWNLOAD_STARTUP_PARAMS, &pccs->cmd);
     DEBUG(2,"dl_startup_params start ccsindex = %d\n", local->dl_param_ccs);
     /* Interrupt the firmware to process the command */
@@ -767,7 +783,7 @@
 static void verify_dl_startup(u_long data)
 {
     ray_dev_t *local = (ray_dev_t *)data;
-    struct ccs *pccs = ((struct ccs *)(local->sram + CCS_BASE)) + local->dl_param_ccs;
+    struct ccs __iomem *pccs = ccs_base(local) + local->dl_param_ccs;
     UCHAR status;
     dev_link_t *link = local->finder;
 
@@ -807,7 +823,7 @@
 static void start_net(u_long data)
 {
     ray_dev_t *local = (ray_dev_t *)data;
-    struct ccs *pccs;
+    struct ccs __iomem *pccs;
     int ccsindex;
     dev_link_t *link = local->finder;
     if (!(link->state & DEV_PRESENT)) {
@@ -816,7 +832,7 @@
     }
     /* Fill in the CCS fields for the ECF */
     if ((ccsindex = get_free_ccs(local)) < 0) return;
-    pccs = ((struct ccs *)(local->sram + CCS_BASE)) + ccsindex;
+    pccs = ccs_base(local) + ccsindex;
     writeb(CCS_START_NETWORK, &pccs->cmd);
     writeb(0, &pccs->var.start_network.update_param);
     /* Interrupt the firmware to process the command */
@@ -834,7 +850,7 @@
 {
     ray_dev_t *local = (ray_dev_t *)data;
 
-    struct ccs *pccs;
+    struct ccs __iomem *pccs;
     int ccsindex;
     dev_link_t *link = local->finder;
     
@@ -844,7 +860,7 @@
     }
     /* Fill in the CCS fields for the ECF */
     if ((ccsindex = get_free_ccs(local)) < 0) return;
-    pccs = ((struct ccs *)(local->sram + CCS_BASE)) + ccsindex;
+    pccs = ccs_base(local) + ccsindex;
     writeb(CCS_JOIN_NETWORK, &pccs->cmd);
     writeb(0, &pccs->var.join_network.update_param);
     writeb(0, &pccs->var.join_network.net_initiated);
@@ -1049,10 +1065,10 @@
                 UCHAR msg_type)
 {
     ray_dev_t *local = (ray_dev_t *)dev->priv;
-    struct ccs *pccs;
+    struct ccs __iomem *pccs;
     int ccsindex;
     int offset;
-    struct tx_msg *ptx; /* Address of xmit buffer in PC space */
+    struct tx_msg __iomem *ptx; /* Address of xmit buffer in PC space */
     short int addr;     /* Address of xmit buffer in card space */
     
     DEBUG(3,"ray_hw_xmit(data=%p, len=%d, dev=%p)\n",data,len,dev);
@@ -1079,7 +1095,7 @@
         local->stats.tx_packets++;
     }
 
-    ptx = (struct tx_msg *)(local->sram + addr);
+    ptx = local->sram + addr;
 
     ray_build_header(local, ptx, msg_type, data);
     if (translate) {
@@ -1092,7 +1108,7 @@
     }
 
     /* fill in the CCS */
-    pccs = ((struct ccs *)(local->sram + CCS_BASE)) + ccsindex;
+    pccs = ccs_base(local) + ccsindex;
     len += TX_HEADER_LENGTH + offset;
     writeb(CCS_TX_REQUEST, &pccs->cmd);
     writeb(addr >> 8, &pccs->var.tx_request.tx_data_ptr[0]);
@@ -1119,21 +1135,21 @@
     return XMIT_OK;
 } /* end ray_hw_xmit */
 /*===========================================================================*/
-static int translate_frame(ray_dev_t *local, struct tx_msg *ptx, unsigned char *data,
+static int translate_frame(ray_dev_t *local, struct tx_msg __iomem *ptx, unsigned char *data,
                     int len)
 {
     unsigned short int proto = ((struct ethhdr *)data)->h_proto;
     if (ntohs(proto) >= 1536) { /* DIX II ethernet frame */
         DEBUG(3,"ray_cs translate_frame DIX II\n");
         /* Copy LLC header to card buffer */
-        memcpy_toio((UCHAR *)&ptx->var, eth2_llc, sizeof(eth2_llc));
-        memcpy_toio( ((UCHAR *)&ptx->var) + sizeof(eth2_llc), (UCHAR *)&proto, 2);
+        memcpy_toio(&ptx->var, eth2_llc, sizeof(eth2_llc));
+        memcpy_toio( ((void __iomem *)&ptx->var) + sizeof(eth2_llc), (UCHAR *)&proto, 2);
         if ((proto == 0xf380) || (proto == 0x3781)) {
             /* This is the selective translation table, only 2 entries */
-            writeb(0xf8, (UCHAR *) &((struct snaphdr_t *)ptx->var)->org[3]);
+            writeb(0xf8, &((struct snaphdr_t __iomem *)ptx->var)->org[3]);
         }
         /* Copy body of ethernet packet without ethernet header */
-        memcpy_toio((UCHAR *)&ptx->var + sizeof(struct snaphdr_t), \
+        memcpy_toio((void __iomem *)&ptx->var + sizeof(struct snaphdr_t), \
                     data + ETH_HLEN,  len - ETH_HLEN);
         return (int) sizeof(struct snaphdr_t) - ETH_HLEN;
     }
@@ -1141,16 +1157,16 @@
         DEBUG(3,"ray_cs translate_frame 802\n");
         if (proto == 0xffff) { /* evil netware IPX 802.3 without LLC */
         DEBUG(3,"ray_cs translate_frame evil IPX\n");
-            memcpy_toio((UCHAR *)&ptx->var, data + ETH_HLEN,  len - ETH_HLEN);
+            memcpy_toio(&ptx->var, data + ETH_HLEN,  len - ETH_HLEN);
             return 0 - ETH_HLEN;
         }
-        memcpy_toio((UCHAR *)&ptx->var, data + ETH_HLEN,  len - ETH_HLEN);
+        memcpy_toio(&ptx->var, data + ETH_HLEN,  len - ETH_HLEN);
         return 0 - ETH_HLEN;
     }
     /* TBD do other frame types */
 } /* end translate_frame */
 /*===========================================================================*/
-static void ray_build_header(ray_dev_t *local, struct tx_msg *ptx, UCHAR msg_type,
+static void ray_build_header(ray_dev_t *local, struct tx_msg __iomem *ptx, UCHAR msg_type,
                 unsigned char *data)
 {
     writeb(PROTOCOL_VER | msg_type, &ptx->mac.frame_ctl_1);
@@ -1633,7 +1649,7 @@
 {
   ray_dev_t *	local = (ray_dev_t *) dev->priv;
   dev_link_t *link = local->finder;
-  struct status *p = (struct status *)(local->sram + STATUS_BASE);
+  struct status __iomem *p = local->sram + STATUS_BASE;
 
   if(local == (ray_dev_t *) NULL)
     return (iw_stats *) NULL;
@@ -1755,7 +1771,7 @@
 static int get_free_tx_ccs(ray_dev_t *local)
 {
     int i;
-    struct ccs *pccs = (struct ccs *)(local->sram + CCS_BASE);
+    struct ccs __iomem *pccs = ccs_base(local);
     dev_link_t *link = local->finder;
 
     if (!(link->state & DEV_PRESENT)) {
@@ -1786,7 +1802,7 @@
 static int get_free_ccs(ray_dev_t *local)
 {
     int i;
-    struct ccs *pccs = (struct ccs *)(local->sram + CCS_BASE);
+    struct ccs __iomem *pccs = ccs_base(local);
     dev_link_t *link = local->finder;
 
     if (!(link->state & DEV_PRESENT)) {
@@ -1863,7 +1879,7 @@
 {
     ray_dev_t *local = (ray_dev_t *)dev->priv;
     dev_link_t *link = local->finder;
-    struct status *p = (struct status *)(local->sram + STATUS_BASE);
+    struct status __iomem *p = local->sram + STATUS_BASE;
     if (!(link->state & DEV_PRESENT)) {
         DEBUG(2,"ray_cs net_device_stats - device not present\n");
         return &local->stats;
@@ -1895,7 +1911,7 @@
     dev_link_t *link = local->finder;
     int ccsindex;
     int i;
-    struct ccs *pccs;
+    struct ccs __iomem *pccs;
 
     if (!(link->state & DEV_PRESENT)) {
         DEBUG(2,"ray_update_parm - device not present\n");
@@ -1907,7 +1923,7 @@
         DEBUG(0,"ray_update_parm - No free ccs\n");
         return;
     }
-    pccs = ((struct ccs *)(local->sram + CCS_BASE)) + ccsindex;
+    pccs = ccs_base(local) + ccsindex;
     writeb(CCS_UPDATE_PARAMS, &pccs->cmd);
     writeb(objid, &pccs->var.update_param.object_id);
     writeb(1, &pccs->var.update_param.number_objects);
@@ -1926,11 +1942,11 @@
 {
     struct dev_mc_list *dmi, **dmip;
     int ccsindex;
-    struct ccs *pccs;
+    struct ccs __iomem *pccs;
     int i = 0;
     ray_dev_t *local = (ray_dev_t *)dev->priv;
     dev_link_t *link = local->finder;
-    UCHAR *p = local->sram + HOST_TO_ECF_BASE;
+    void __iomem *p = local->sram + HOST_TO_ECF_BASE;
 
     if (!(link->state & DEV_PRESENT)) {
         DEBUG(2,"ray_update_multi_list - device not present\n");
@@ -1943,7 +1959,7 @@
         DEBUG(1,"ray_update_multi - No free ccs\n");
         return;
     }
-    pccs = ((struct ccs *)(local->sram + CCS_BASE)) + ccsindex;
+    pccs = ccs_base(local) + ccsindex;
     writeb(CCS_UPDATE_MULTICAST_LIST, &pccs->cmd);
 
     if (all) {
@@ -2011,8 +2027,8 @@
     struct net_device *dev = (struct net_device *)dev_id;
     dev_link_t *link;
     ray_dev_t *local;
-    struct ccs *pccs;
-    struct rcs *prcs;
+    struct ccs __iomem *pccs;
+    struct rcs __iomem *prcs;
     UCHAR rcsindex;
     UCHAR tmp;
     UCHAR cmd;
@@ -2029,7 +2045,7 @@
         DEBUG(2,"ray_cs interrupt from device not present or suspended.\n");
         return IRQ_NONE;
     }
-    rcsindex = readb(&((struct scb *)(local->sram))->rcs_index);
+    rcsindex = readb(&((struct scb __iomem *)(local->sram))->rcs_index);
 
     if (rcsindex >= (NUMBER_OF_CCS + NUMBER_OF_RCS))
     {
@@ -2039,7 +2055,7 @@
     }
     if (rcsindex < NUMBER_OF_CCS) /* If it's a returned CCS */
     {
-        pccs = ((struct ccs *) (local->sram + CCS_BASE)) + rcsindex;
+        pccs = ccs_base(local) + rcsindex;
         cmd = readb(&pccs->cmd);
         status = readb(&pccs->buffer_status);
         switch (cmd)
@@ -2153,7 +2169,7 @@
     }
     else /* It's an RCS */
     {
-        prcs = ((struct rcs *)(local->sram + CCS_BASE)) + rcsindex;
+        prcs = rcs_base(local) + rcsindex;
     
         switch (readb(&prcs->interrupt_id))
         {
@@ -2194,11 +2210,11 @@
     return IRQ_HANDLED;
 } /* ray_interrupt */
 /*===========================================================================*/
-static void ray_rx(struct net_device *dev, ray_dev_t *local, struct rcs *prcs)
+static void ray_rx(struct net_device *dev, ray_dev_t *local, struct rcs __iomem *prcs)
 {
     int rx_len;
     unsigned int pkt_addr;
-    UCHAR *pmsg;
+    void __iomem *pmsg;
     DEBUG(4,"ray_rx process rx packet\n");
 
     /* Calculate address of packet within Rx buffer */
@@ -2248,11 +2264,11 @@
 
 } /* end ray_rx */
 /*===========================================================================*/
-static void rx_data(struct net_device *dev, struct rcs *prcs, unsigned int pkt_addr, 
+static void rx_data(struct net_device *dev, struct rcs __iomem *prcs, unsigned int pkt_addr, 
              int rx_len)
 {
     struct sk_buff *skb = NULL;
-    struct rcs *prcslink = prcs;
+    struct rcs __iomem *prcslink = prcs;
     ray_dev_t *local = dev->priv;
     UCHAR *rx_ptr;
     int total_len;
@@ -2294,7 +2310,7 @@
                 +   readb(&prcslink->var.rx_packet.rx_data_length[1]);
             if (readb(&prcslink->var.rx_packet.next_frag_rcs_index) == 0xFF
                 || tmp < 0) break;
-            prcslink = ((struct rcs *)(local->sram + CCS_BASE))
+            prcslink = rcs_base(local)
                 + readb(&prcslink->link_field);
         } while (1);
 
@@ -2355,7 +2371,7 @@
         prcslink = prcs;
         DEBUG(1,"ray_cs rx_data in fragment loop\n");
         do {
-            prcslink = ((struct rcs *)(local->sram + CCS_BASE))
+            prcslink = rcs_base(local)
                 + readb(&prcslink->var.rx_packet.next_frag_rcs_index);
             rx_len = (( readb(&prcslink->var.rx_packet.rx_data_length[0]) << 8)
                       + readb(&prcslink->var.rx_packet.rx_data_length[1]))
@@ -2529,9 +2545,9 @@
     return length;
 }
 /*===========================================================================*/
-static void release_frag_chain(ray_dev_t *local, struct rcs* prcs)
+static void release_frag_chain(ray_dev_t *local, struct rcs __iomem * prcs)
 {
-    struct rcs *prcslink = prcs;
+    struct rcs __iomem *prcslink = prcs;
     int tmp = 17;
     unsigned rcsindex = readb(&prcs->var.rx_packet.next_frag_rcs_index);
 
@@ -2541,7 +2557,7 @@
             DEBUG(1,"ray_cs interrupt bad rcsindex = 0x%x\n",rcsindex);
             break;      
         }   
-        prcslink = ((struct rcs *)(local->sram + CCS_BASE)) + rcsindex;
+        prcslink = rcs_base(local) + rcsindex;
         rcsindex = readb(&prcslink->var.rx_packet.next_frag_rcs_index);
     }
     writeb(CCS_BUFFER_FREE, &prcslink->buffer_status);
@@ -2569,7 +2585,7 @@
     local->authentication_state = AWAITING_RESPONSE;
 } /* end authenticate */
 /*===========================================================================*/
-static void rx_authenticate(ray_dev_t *local, struct rcs *prcs,
+static void rx_authenticate(ray_dev_t *local, struct rcs __iomem *prcs,
                      unsigned int pkt_addr, int rx_len)
 {
     UCHAR buff[256];
@@ -2614,7 +2630,7 @@
 /*===========================================================================*/
 static void associate(ray_dev_t *local)
 {
-    struct ccs *pccs;
+    struct ccs __iomem *pccs;
     dev_link_t *link = local->finder;
     struct net_device *dev = link->priv;
     int ccsindex;
@@ -2630,7 +2646,7 @@
         return;
     }
     DEBUG(1,"ray_cs Starting association with access point\n");
-    pccs = ((struct ccs *)(local->sram + CCS_BASE)) + ccsindex;
+    pccs = ccs_base(local) + ccsindex;
     /* fill in the CCS */
     writeb(CCS_START_ASSOCIATION, &pccs->cmd);
     /* Interrupt the firmware to process the command */
@@ -2650,7 +2666,7 @@
 
 } /* end associate */
 /*===========================================================================*/
-static void rx_deauthenticate(ray_dev_t *local, struct rcs *prcs, 
+static void rx_deauthenticate(ray_dev_t *local, struct rcs __iomem *prcs, 
                        unsigned int pkt_addr, int rx_len)
 {
 /*  UCHAR buff[256];
@@ -2798,8 +2814,8 @@
 static int build_auth_frame(ray_dev_t *local, UCHAR *dest, int auth_type)
 {
     int addr;
-    struct ccs *pccs;
-    struct tx_msg *ptx;
+    struct ccs __iomem *pccs;
+    struct tx_msg __iomem *ptx;
     int ccsindex;
 
     /* If no tx buffers available, return */
@@ -2809,7 +2825,7 @@
         return -1;
     }
 
-    pccs = ((struct ccs *)(local->sram + CCS_BASE)) + ccsindex;
+    pccs = ccs_base(local) + ccsindex;
 
     /* Address in card space */
     addr = TX_BUF_BASE + (ccsindex << 11);
@@ -2821,7 +2837,7 @@
     writeb(TX_AUTHENTICATE_LENGTH_LSB,pccs->var.tx_request.tx_data_length + 1);
     writeb(0, &pccs->var.tx_request.pow_sav_mode);
 
-    ptx = (struct tx_msg *)(local->sram + addr);
+    ptx = local->sram + addr;
     /* fill in the mac header */
     writeb(PROTOCOL_VER | AUTHENTIC_TYPE, &ptx->mac.frame_ctl_1);
     writeb(0, &ptx->mac.frame_ctl_2);
===== drivers/net/wireless/ray_cs.h 1.2 vs edited =====
--- 1.2/drivers/net/wireless/ray_cs.h	2003-02-18 17:22:50 -08:00
+++ edited/drivers/net/wireless/ray_cs.h	2004-10-06 10:04:52 -07:00
@@ -28,9 +28,9 @@
     dev_node_t  node;
     window_handle_t amem_handle;   /* handle to window for attribute memory  */
     window_handle_t rmem_handle;   /* handle to window for rx buffer on card */
-    UCHAR *sram;                   /* pointer to beginning of shared RAM     */
-    UCHAR *amem;                   /* pointer to attribute mem window        */
-    UCHAR *rmem;                   /* pointer to receive buffer window       */
+    void __iomem *sram;            /* pointer to beginning of shared RAM     */
+    void __iomem *amem;            /* pointer to attribute mem window        */
+    void __iomem *rmem;            /* pointer to receive buffer window       */
     dev_link_t *finder;            /* pointer back to dev_link_t for card    */
     struct timer_list timer;
     long tx_ccs_lock;
