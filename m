Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932437AbWCBRit@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932437AbWCBRit (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 2 Mar 2006 12:38:49 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932423AbWCBRit
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 2 Mar 2006 12:38:49 -0500
Received: from pat.qlogic.com ([198.70.193.2]:59880 "EHLO avexch02.qlogic.com")
	by vger.kernel.org with ESMTP id S932408AbWCBRis (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 2 Mar 2006 12:38:48 -0500
Date: Thu, 2 Mar 2006 09:38:46 -0800
From: Andrew Vasquez <andrew.vasquez@qlogic.com>
To: Maxim Kozover <maximkoz@netvision.net.il>
Cc: Stefan Kaltenbrunner <mm-mailinglist@madness.at>,
       Andrew Morton <akpm@osdl.org>, linux-kernel@vger.kernel.org,
       linux-scsi@vger.kernel.org
Subject: Re: Re:Re: problems with scsi_transport_fc and qla2xxx
Message-ID: <20060302173846.GF498@andrew-vasquezs-powerbook-g4-15.local>
References: <1413265398.20060227150526@netvision.net.il> <978150825.20060227210552@netvision.net.il> <20060228221422.282332ef.akpm@osdl.org> <4406034B.9030105@madness.at> <20060301210802.GA7288@spe2> <957728045.20060302193248@netvision.net.il>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <957728045.20060302193248@netvision.net.il>
Organization: QLogic Corporation
User-Agent: Mutt/1.5.11
X-OriginalArrivalTime: 02 Mar 2006 17:38:47.0912 (UTC) FILETIME=[29485680:01C63E20]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 02 Mar 2006, Maxim Kozover wrote:

> Today I tested disconnecting QLogic port.
> Adapter 4 is connected via switch to a storage and 3 LUNs are seen via
> the adapter.
> Only 1 rport is created (for FCP Target) while in Emulex case there
> were 3: (Fabric Port, Directory Server and FCP Target, FCP Initiator).

That's correct, we currently don't make an upcall for the SNS server
port nor the switch fabric port.

> # ls /sys/class/fc_remote_ports/
> rport-4:0-0
> # cat /sys/class/fc_remote_ports/*/roles
> FCP Target
> 
> Default dev_loss_tmo is 6 (1+5) while in Emulex case the default was 35.
> 
> After disconnecting the cable between the HBA and the switch
> qla2xxx 0000:03:01.0: LOOP DOWN detected (2).
>  rport-4:0-0: blocked FC remote port time out: removing target and saving binding
> 
> # ls /sys/class/fc_remote_ports/
> rport-4:0-0
> # cat /sys/class/fc_remote_ports/*/roles
> unknown
> 
> Relevant scsi devices are removed from /proc/scsi/scsi.
> 
> After reconnecting the cable
> qla2xxx 0000:03:01.0: LIP reset occured (f7f7).
> qla2xxx 0000:03:01.0: LOOP UP detected (2 Gbps).
> 
> # ls /sys/class/fc_remote_ports/
> rport-4:0-0
> # cat /sys/class/fc_remote_ports/*/roles
> FCP Target
> 
> However, scsi devices don't reappear in /proc/scsi/scsi.
> When I issue rescan, the command is stuck
> echo - - - > /sys/class/scsi_host/host4/scan
> 
> Please advise.

Could you add the enable-debug patch I sent you earlier and retry the
test?  Again forward the relevent snippets from var/log/messages.

Here's the patch again.

--
av

---

diff --git a/drivers/scsi/qla2xxx/qla_dbg.h b/drivers/scsi/qla2xxx/qla_dbg.h
index 935a59a..632f653 100644
--- a/drivers/scsi/qla2xxx/qla_dbg.h
+++ b/drivers/scsi/qla2xxx/qla_dbg.h
@@ -9,6 +9,7 @@
  */
 /* #define QL_DEBUG_LEVEL_1  */ /* Output register accesses to COM1 */
 /* #define QL_DEBUG_LEVEL_2  */ /* Output error msgs to COM1 */
+#define QL_DEBUG_LEVEL_2   /* Output error msgs to COM1 */
 /* #define QL_DEBUG_LEVEL_3  */ /* Output function trace msgs to COM1 */
 /* #define QL_DEBUG_LEVEL_4  */ /* Output NVRAM trace msgs to COM1 */
 /* #define QL_DEBUG_LEVEL_5  */ /* Output ring trace msgs to COM1 */
diff --git a/drivers/scsi/qla2xxx/qla_settings.h b/drivers/scsi/qla2xxx/qla_settings.h
index 363205c..b2e22b0 100644
--- a/drivers/scsi/qla2xxx/qla_settings.h
+++ b/drivers/scsi/qla2xxx/qla_settings.h
@@ -8,7 +8,7 @@
  * Compile time Options:
  *     0 - Disable and 1 - Enable
  */
-#define DEBUG_QLA2100		0	/* For Debug of qla2x00 */
+#define DEBUG_QLA2100		1	/* For Debug of qla2x00 */
 
 #define USE_ABORT_TGT		1	/* Use Abort Target mbx cmd */
 


