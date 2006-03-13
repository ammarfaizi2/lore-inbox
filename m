Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751666AbWCMXTM@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751666AbWCMXTM (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 13 Mar 2006 18:19:12 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751518AbWCMXTL
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 13 Mar 2006 18:19:11 -0500
Received: from pat.qlogic.com ([198.70.193.2]:20319 "EHLO avexch02.qlogic.com")
	by vger.kernel.org with ESMTP id S1751418AbWCMXTJ (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 13 Mar 2006 18:19:09 -0500
Date: Mon, 13 Mar 2006 15:19:03 -0800
From: Andrew Vasquez <andrew.vasquez@qlogic.com>
To: Maxim Kozover <maximkoz@netvision.net.il>
Cc: linux-kernel@vger.kernel.org, linux-scsi@vger.kernel.org,
       Michael Reed <mdr@sgi.com>, James.Smart@Emulex.Com
Subject: Re: Re[8]: problems with scsi_transport_fc and qla2xxx
Message-ID: <20060313231903.GK11755@andrew-vasquezs-powerbook-g4-15.local>
References: <1229893529.20060307000953@netvision.net.il> <20060306232831.GS6278@andrew-vasquezs-powerbook-g4-15.local> <1219491790.20060307124035@netvision.net.il> <20060307172227.GE6275@andrew-vasquezs-powerbook-g4-15.local> <1343850424.20060307231141@netvision.net.il> <20060308080050.GF9956@andrew-vasquezs-powerbook-g4-15.local> <20060308154341.GA1779@andrew-vasquezs-powerbook-g4-15.local> <1502511597.20060308213247@netvision.net.il> <20060310231344.GB641@andrew-vasquezs-powerbook-g4-15.local> <1699632492.20060312001014@netvision.net.il>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1699632492.20060312001014@netvision.net.il>
Organization: QLogic Corporation
User-Agent: Mutt/1.5.11
X-OriginalArrivalTime: 13 Mar 2006 23:19:04.0981 (UTC) FILETIME=[85591450:01C646F4]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 12 Mar 2006, Maxim Kozover wrote:

> Congratulations! The kernel from scsi-rc-fixes git and your patch are
> working.

Actually Mike R. and James S. deserve the credit for the composite
patch which consists of:

1) [PATCH] FC transport : Avoid device offline cases by stalling aborts until device unblocked
   http://marc.theaimsgroup.com/?l=linux-scsi&m=114225658724378&w=2

2) Serialize scan work during fc_remote_port_delete() so rport removal
doesn't deadlock midlayer scans.  The problem you were seeing.  (Mike
R.)

3) rport race fixes during removal (James S.).

> By the way, could you, please, tell me how I get only scsi patches
> from the git repository, cause I got the whole kernel by using
> cg-clone http://kernel.org/pub/scm/linux/kernel/git/jejb/scsi-rc-fixes-2.6.git
> 
> Now the process looks like following:
> Mar 11 23:54:22 multipath kernel: qla2xxx 0000:03:01.0: LOOP DOWN detected (2).
> Mar 11 23:54:28 multipath kernel:  rport-4:0-0: blocked FC remote port time out:
>  removing target and saving binding
> Mar 11 23:54:37 multipath kernel: qla2xxx 0000:03:01.0: LIP reset occured (f7f7).
> Mar 11 23:54:37 multipath kernel: qla2xxx 0000:03:01.0: LOOP UP detected (2 Gbps).
> Mar 11 23:54:59 multipath kernel:  4:0:0:0: timing out command, waited 22s
> 
> And the disks appear.
> Could you tell me, please, where this 22sec timeout came from?

Essentially there's currently several issues with rport consumers
making delete() calls during mid-layer scanning.

I'm hoping at a minimum we can get Mike R's fixes into 2.6.16, and
address the additional races going forward...  James/Mike?

Here's a minimal the serialize scan-work patch, could you check to see
that this addresses your issue?  Start with any latest linux-2.6.git
tree.

Thanks,
Andrew

---

diff --git a/drivers/scsi/scsi_transport_fc.c b/drivers/scsi/scsi_transport_fc.c
index 929032e..3d09920 100644
--- a/drivers/scsi/scsi_transport_fc.c
+++ b/drivers/scsi/scsi_transport_fc.c
@@ -1649,6 +1649,8 @@ fc_remote_port_delete(struct fc_rport  *
 		return;
 	}
 
+	/* flush any scan work */ /* which can sleep */
+	scsi_flush_work(rport_to_shost(rport));
 	scsi_target_block(&rport->dev);
 
 	/* cap the length the devices can be blocked until they are deleted */
