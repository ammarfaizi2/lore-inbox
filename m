Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267754AbTAXP6o>; Fri, 24 Jan 2003 10:58:44 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267780AbTAXP6o>; Fri, 24 Jan 2003 10:58:44 -0500
Received: from havoc.daloft.com ([64.213.145.173]:56509 "EHLO havoc.gtf.org")
	by vger.kernel.org with ESMTP id <S267754AbTAXP6l>;
	Fri, 24 Jan 2003 10:58:41 -0500
Date: Fri, 24 Jan 2003 11:07:48 -0500
From: Jeff Garzik <jgarzik@pobox.com>
To: Andrey Nekrasov <andy@spylog.ru>,
       "Eric W. Biederman" <ebiederm@xmission.com>,
       Michael Fu <michael.fu@linux.co.intel.com>,
       linux-kernel@vger.kernel.org
Subject: Re: [BUG] e100 driver fails to initialize the hardware after kernel bootup through kexec
Message-ID: <20030124160748.GB18428@gtf.org>
References: <1042450072.1744.75.camel@aminoacin.sh.intel.com> <1043390954.892.10.camel@aminoacin.sh.intel.com> <m18yxaeje3.fsf@frodo.biederman.org> <20030124145754.GA1116@an.local>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20030124145754.GA1116@an.local>
User-Agent: Mutt/1.3.28i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jan 24, 2003 at 05:57:55PM +0300, Andrey Nekrasov wrote:
> or "e100" driver and with patch:
> 
> 
> --- drivers/net/e100/e100.h-    Wed Dec  4 15:16:08 2002 
> +++ drivers/net/e100/e100.h     Wed Dec  4 15:16:20 2002 
> @@ -100,7 +100,7 @@
>  
>  #define E100_MAX_NIC 16
>  
> -#define E100_MAX_SCB_WAIT      100     /* Max udelays in wait_scb */ 
> +#define E100_MAX_SCB_WAIT      5000    /* Max udelays in wait_scb */ 
>  #define E100_MAX_CU_IDLE_WAIT  50      /* Max udelays in wait_cus_idle */




No, don't use this patch, it's awful.  The latest Marcelo tree in
BitKeeper has this fixed...  the right way.  See the following e100
patch, which is what Intel emailed me, and what I merged into the
Marcelo tree.

	Jeff




# --------------------------------------------
# 03/01/16	scott.feldman@intel.com	1.884.23.2
# [netdrvr e100] udelay a better way
# * Bug Fix: TCO workaround after hard reset of controller to wait for TCO
#   traffic to settle.  Workaround requires issuing a CU load base command
#   after hard reset, followed by a wait for scb and finally a wait for
#   TCO traffic bit to clear.  Affects 82559s and above wired to SMBus.
# --------------------------------------------
#
diff -Nru a/drivers/net/e100/e100_main.c b/drivers/net/e100/e100_main.c
--- a/drivers/net/e100/e100_main.c	Fri Jan 24 11:06:35 2003
+++ b/drivers/net/e100/e100_main.c	Fri Jan 24 11:06:35 2003
@@ -196,6 +196,7 @@
 char *e100_get_brand_msg(struct e100_private *);
 static u8 e100_pci_setup(struct pci_dev *, struct e100_private *);
 static u8 e100_sw_init(struct e100_private *);
+static void e100_tco_walkaround(struct e100_private *);
 static unsigned char e100_alloc_space(struct e100_private *);
 static void e100_dealloc_space(struct e100_private *);
 static int e100_alloc_tcb_pool(struct e100_private *);
@@ -213,7 +214,7 @@
 
 static unsigned char e100_clr_cntrs(struct e100_private *);
 static unsigned char e100_load_microcode(struct e100_private *);
-static unsigned char e100_hw_init(struct e100_private *, u32);
+static unsigned char e100_hw_init(struct e100_private *);
 static unsigned char e100_setup_iaaddr(struct e100_private *, u8 *);
 static unsigned char e100_update_stats(struct e100_private *bdp);
 
@@ -1265,7 +1266,7 @@
 	/* read NIC's part number */
 	e100_rd_pwa_no(bdp);
 
-	if (!e100_hw_init(bdp, PORT_SOFTWARE_RESET)) {
+	if (!e100_hw_init(bdp)) {
 		printk(KERN_ERR "e100: hw init failed\n");
 		return false;
 	}
@@ -1314,10 +1315,46 @@
 	return 1;
 }
 
+static void __devinit
+e100_tco_walkaround(struct e100_private *bdp)
+{
+	int i;
+
+	/* Do software reset */
+	e100_sw_reset(bdp, PORT_SOFTWARE_RESET);
+
+	/* Do a dummy LOAD CU BASE command. */
+	/* This gets us out of pre-driver to post-driver. */
+	e100_exec_cmplx(bdp, 0, SCB_CUC_LOAD_BASE);
+
+	/* Wait 20 msec for reset to take effect */
+	set_current_state(TASK_UNINTERRUPTIBLE);
+	schedule_timeout(HZ / 50);
+
+	/* disable interrupts since they are enabled */
+	/* after device reset                        */
+	e100_disable_clear_intr(bdp);
+
+	/* Wait for command to be cleared up to 1 sec */
+	for (i=0; i<1000; i++) {
+		if (!readb(&bdp->scb->scb_cmd_low))
+			break;
+		set_current_state(TASK_UNINTERRUPTIBLE);
+		schedule_timeout(HZ / 1000);
+	}
+
+	/* Wait for TCO request bit in PMDR register to be clear */
+	for (i=0; i<500; i++) {
+		if (!(readb(&bdp->scb->scb_ext.d101m_scb.scb_pmdr) & BIT_1))
+			break;
+		set_current_state(TASK_UNINTERRUPTIBLE);
+		schedule_timeout(HZ / 1000);
+	}
+}
+
 /**
  * e100_hw_init - initialized tthe hardware
  * @bdp: atapter's private data struct
- * @reset_cmd: s/w reset or selective reset
  *
  * This routine performs a reset on the adapter, and configures the adapter.
  * This includes configuring the 82557 LAN controller, validating and setting
@@ -1329,13 +1366,16 @@
  *      false - If the adapter failed initialization
  */
 unsigned char __devinit
-e100_hw_init(struct e100_private *bdp, u32 reset_cmd)
+e100_hw_init(struct e100_private *bdp)
 {
 	if (!e100_phy_init(bdp))
 		return false;
 
-	/* Issue a software reset to the e100 */
-	e100_sw_reset(bdp, reset_cmd);
+	e100_sw_reset(bdp, PORT_SELECTIVE_RESET);
+
+	/* Only 82559 or above needs TCO walkaround */
+	if (bdp->rev_id >= D101MA_REV_ID)
+		e100_tco_walkaround(bdp);
 
 	/* Load the CU BASE (set to 0, because we use linear mode) */
 	if (!e100_wait_exec_cmplx(bdp, 0, SCB_CUC_LOAD_BASE, 0))
