Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264906AbTFLRdA (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 12 Jun 2003 13:33:00 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264913AbTFLRc7
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 12 Jun 2003 13:32:59 -0400
Received: from adsl-206-170-148-147.dsl.snfc21.pacbell.net ([206.170.148.147]:31759
	"EHLO gw.goop.org") by vger.kernel.org with ESMTP id S264906AbTFLRc4
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 12 Jun 2003 13:32:56 -0400
Subject: Re: Cisco Aironet mini-PCI wireless card (MPI-350) [Was: Re: Intel
	PRO/Wireless 2100 vs. Broadcom BCM9430x]
From: Jeremy Fitzhardinge <jeremy@goop.org>
To: Jan Mynarik <mynarikj@phoenix.inf.upol.cz>
Cc: Linux Kernel List <linux-kernel@vger.kernel.org>
In-Reply-To: <1055438410.930.15.camel@narsil>
References: <Pine.LNX.4.44.0306120813380.411-100000@twin.uoregon.edu>
	 <1055438410.930.15.camel@narsil>
Content-Type: multipart/mixed; boundary="=-hE4QbfPAi76DP+4V/OS0"
Message-Id: <1055439997.10219.54.camel@ixodes.goop.org>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.3.92 (Preview Release)
Date: 12 Jun 2003 10:46:38 -0700
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--=-hE4QbfPAi76DP+4V/OS0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit

On Thu, 2003-06-12 at 10:20, Jan Mynarik wrote:
> Cisco's linux support is great until you have IBM's ThinkPad R40. With
> this notebook, their newest Linux driver (version 2.0, older ones do not
> support my card) module (mpi350.o) can't be inserted to kernel (oops and
> module remains 'initializing' forever). Module is compiled successfully
> against both 2.4.20 and 2.4.21-rc7 kernels.
> 
> I'm just fighting their bureaucracy (in support) and trying to reach
> someone who actually wrote the driver (module says Roland Wilcher). I
> want to help him with testing and provide him with all possible
> information.

Downgrade your firmware.  On the Cisco site, there's a Linux driver
paired with a particular firmware version.  Use it: there's a bug in the
kernel driver in which it reads stuff out of the card's RIDs into a
local structure, but using the card's RID size.  The newer firmware has
increased the structure sizes for some RIDs, which overruns the stack
and crashes.

I have attached a patch for the driver to fix the crash, but I'm not
confident the card works well without the correct firmware.

	J


--=-hE4QbfPAi76DP+4V/OS0
Content-Disposition: attachment; filename=rid-size-fix.diff
Content-Type: text/plain; name=rid-size-fix.diff; charset=ISO-8859-15
Content-Transfer-Encoding: 7bit

--- mpi350.c.orig	2003-05-22 17:20:42.000000000 -0700
+++ mpi350.c	2003-05-23 15:37:26.000000000 -0700
@@ -135,7 +135,7 @@
 struct net_device *init_venus_card(struct pci_dev *);
 void   venus_remove(void);
 static int  venus_probe(struct pci_dev *);
-static int vreadrid(struct venus_info *,unsigned short,unsigned char *);
+static int vreadrid(struct venus_info *,unsigned short,unsigned char *,unsigned int);
 static int vwriterid(struct venus_info *,unsigned short,unsigned char *);
 static void venus_interrupt( int irq, void* dev_id, struct pt_regs    *regs);
 static int venus_ioctl(struct net_device *dev, struct ifreq *rq, int cmd);
@@ -442,7 +442,7 @@
     printk(KERN_INFO "MIC interrupt\n");
 #endif
     venusout(v_info,V_EVACK,EV_MIC);
-    vreadrid((struct venus_info *)dev->priv,RID_MIC,(char *)&mic);
+    vreadrid((struct venus_info *)dev->priv,RID_MIC,(char *)&mic,sizeof(mic));
     micinit(v_info,&mic);
     enable_interrupts(v_info);
     spin_unlock(&v_info->mpi_lock);
@@ -845,7 +845,7 @@
 	memset( data->wbuffer, 0, 33*3 );
 	data->on_close = proc_ssid_on_close;
 	
-	vreadrid(vi,RID_SSLIST,(unsigned char *)SSID_rid);
+	vreadrid(vi,RID_SSLIST,(unsigned char *)SSID_rid,sizeof(blargbuf));
 
 	ptr = data->rbuffer;
 
@@ -881,8 +881,8 @@
 	data = (struct proc_data *)file->private_data;
 	data->rbuffer = kmalloc( 2048, GFP_KERNEL );
 	
-	vreadrid(vi,RID_STATUS,(unsigned char *)&status_rid);
-	vreadrid(vi,RID_CAPABILITIES,(unsigned char *)&cap_rid);
+	vreadrid(vi,RID_STATUS,(unsigned char *)&status_rid,sizeof(status_rid));
+	vreadrid(vi,RID_CAPABILITIES,(unsigned char *)&cap_rid,sizeof(cap_rid));
 
 	sprintf( data->rbuffer, "Mode: %x\n"
 		 "Signal Strength: %d\n"
@@ -935,7 +935,7 @@
  * Return 0 on sucess or other on failure . Uses the len value of all rids 
  * in the first 2 bytes .
  */
-static int vreadrid(struct venus_info *v_info,unsigned short rid,unsigned char *ridp){
+static int vreadrid(struct venus_info *v_info,unsigned short rid,unsigned char *ridp,unsigned ridsz){
   Cmd            cmd;
   Resp           rsp;
   int            status;
@@ -962,8 +962,14 @@
     return rsp.rsp0;  /* return error qualifier */
 
   if(!status){
+    unsigned len = ridsz;
     ridlen = VADDR(unsigned short,v_info->ConfigDesc);
-    memcpy((char *)ridp,(char *)v_info->ConfigDesc.VirtualHostAddress,*ridlen);
+    if (*ridlen <= len)
+      len = *ridlen;
+    else
+      printk(KERN_INFO "vreadrid: rid=%04x ridlen=%d ridsz=%d\n",
+	     rid, *ridlen, ridsz);
+    memcpy((char *)ridp,(char *)v_info->ConfigDesc.VirtualHostAddress,len);
   }
   return status;
 }
@@ -1509,8 +1515,8 @@
   pci_set_master (v_info->pcip); /* Gets called twice no harm */
 
   cfg = (ConfigRid *)iobuf;
-  vreadrid((struct venus_info *)dev->priv,RID_CAPABILITIES,(char *)&xcaps);
-  vreadrid((struct venus_info *)dev->priv,RID_CONFIG,iobuf);
+  vreadrid((struct venus_info *)dev->priv,RID_CAPABILITIES,(char *)&xcaps,sizeof(xcaps));
+  vreadrid((struct venus_info *)dev->priv,RID_CONFIG,iobuf,sizeof(iobuf));
 
   /*
    * Find out if an extended capability rid was returned
@@ -1536,7 +1542,7 @@
   for(i=0;i!=6;i++){
     dev->dev_addr[i] = cfg->macAddr[i];
   }
-  printk( KERN_INFO "MPI350 start: MAC  %x:%x:%x:%x:%x:%x\n",
+  printk( KERN_INFO "MPI350 start: MAC  %02x:%02x:%02x:%02x:%02x:%02x\n",
 	  dev->dev_addr[0],dev->dev_addr[1],dev->dev_addr[2],
 	  dev->dev_addr[3],dev->dev_addr[4],dev->dev_addr[5]); 
 
@@ -1735,7 +1741,7 @@
       break;
     }
 
-  vreadrid((struct venus_info *)dev->priv,ridcode,iobuf);
+  vreadrid((struct venus_info *)dev->priv,ridcode,iobuf,sizeof(iobuf));
   
   if (copy_to_user(comp->data, iobuf, MIN (comp->len, sizeof(iobuf))))
     return -EFAULT;
@@ -1799,7 +1805,7 @@
     case AIROPSTCLR:
       ridcode = RID_STATSDELTACLEAR;
       memset((char *)&v_info->micstats,0,sizeof(v_info->micstats)); /*Clear micstats */
-      vreadrid((struct venus_info *)dev->priv,ridcode,iobuf);
+      vreadrid((struct venus_info *)dev->priv,ridcode,iobuf,sizeof(iobuf));
       
       if (copy_to_user(comp->data,blargo,MIN(comp->len,sizeof(blargo))))
 	return -EFAULT;

--=-hE4QbfPAi76DP+4V/OS0--

