Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S276591AbRKSJpY>; Mon, 19 Nov 2001 04:45:24 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S276477AbRKSJpP>; Mon, 19 Nov 2001 04:45:15 -0500
Received: from ns.virtualhost.dk ([195.184.98.160]:27660 "EHLO virtualhost.dk")
	by vger.kernel.org with ESMTP id <S276591AbRKSJpE>;
	Mon, 19 Nov 2001 04:45:04 -0500
Date: Mon, 19 Nov 2001 10:44:11 +0100
From: Jens Axboe <axboe@suse.de>
To: Marco Berizzi <pupilla@hotmail.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: Kernel Panic: too few segs for DMA mapping increase AHC_NSEG
Message-ID: <20011119104411.U11826@suse.de>
In-Reply-To: <LAW2-OE70z82buW5RNB000007e5@hotmail.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="1yeeQ81UyVL57Vl7"
Content-Disposition: inline
In-Reply-To: <LAW2-OE70z82buW5RNB000007e5@hotmail.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--1yeeQ81UyVL57Vl7
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Mon, Nov 19 2001, Marco Berizzi wrote:
> Hi everybody.
> 
> I have just upgraded my PC from 768MB RAM to 1GB.
> I have recompiled the kernel (2.4.14) for hi mem support (4GB).
> 
> Now it's appening a very strange behaviour.
> I have several file system on the same disk (vfat file system). I have
> compiled vfat driver as a module. So before try to mount I must issue a
> 'modprobe vfat'. I'm using Slackware 8.0. modutils version is 2.4.6
> 
> Then if I try to copy a file from that filesystem to the root filesystem
> I get this error:
> 
> Kernel panic: too few segs for DMA mappings increase AHC_NSEG

Aha! Finally someone that can provoke this easily. Could you please
apply attached patch and reproduce? Thanks.

-- 
Jens Axboe


--1yeeQ81UyVL57Vl7
Content-Type: text/plain; charset=us-ascii
Content-Disposition: attachment; filename=aic7xxx-nsegs-1

--- drivers/scsi/aic7xxx/aic7xxx_linux.c~	Mon Nov 19 10:36:12 2001
+++ drivers/scsi/aic7xxx/aic7xxx_linux.c	Mon Nov 19 10:43:26 2001
@@ -624,9 +624,10 @@
 {
 	int	 consumed;
 
-	if ((scb->sg_count + 1) > AHC_NSEG)
-		panic("Too few segs for dma mapping.  "
-		      "Increase AHC_NSEG\n");
+	if ((scb->sg_count + 1) > AHC_NSEG) {
+		printk("Too few segs for dma mapping. Increase AHC_NSEG\n");
+		return -1;
+	}
 
 	consumed = 1;
 	sg->addr = ahc_htole32(addr & 0xFFFFFFFF);
@@ -1674,6 +1675,13 @@
 				len = sg_dma_len(cur_seg);
 				consumed = ahc_linux_map_seg(ahc, scb,
 							     sg, addr, len);
+				if (consumed == -1) {
+					printk("aic7xxx: scsi segs %d,
+						pci segs %d, aic segs %d\n",
+						cmd->use_sg, nseg,
+						scb->sg_count);
+					BUG();
+				}
 				sg += consumed;
 				scb->sg_count += consumed;
 				cur_seg++;
@@ -1705,6 +1713,8 @@
 			scb->sg_count = ahc_linux_map_seg(ahc, scb,
 							  sg, addr,
 							  cmd->request_bufflen);
+			if (scb->sg_count == -1)
+				BUG();
 			sg->len |= ahc_htole32(AHC_DMA_LAST_SEG);
 
 			/*

--1yeeQ81UyVL57Vl7--
