Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932074AbWH3VSn@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932074AbWH3VSn (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 30 Aug 2006 17:18:43 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932073AbWH3VSm
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 30 Aug 2006 17:18:42 -0400
Received: from e35.co.us.ibm.com ([32.97.110.153]:48561 "EHLO
	e35.co.us.ibm.com") by vger.kernel.org with ESMTP id S932074AbWH3VSl
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 30 Aug 2006 17:18:41 -0400
Message-ID: <44F600A9.4050207@us.ibm.com>
Date: Wed, 30 Aug 2006 14:18:33 -0700
From: "Darrick J. Wong" <djwong@us.ibm.com>
Reply-To: "Darrick J. Wong" <djwong@us.ibm.com>
Organization: IBM
User-Agent: Thunderbird 1.5.0.5 (X11/20060728)
MIME-Version: 1.0
To: "Darrick J. Wong" <djwong@us.ibm.com>,
       linux-scsi <linux-scsi@vger.kernel.org>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v3] aic94xx: Increase can_queue for better performance
References: <20060830190454.28371.qmail@web31807.mail.mud.yahoo.com> <44F5FB54.5010700@us.ibm.com>
In-Reply-To: <44F5FB54.5010700@us.ibm.com>
X-Enigmail-Version: 0.94.0.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Darrick J. Wong wrote:
> Hi all,
> 
> Below is a patch that sets can_queue in the aic94xx driver's scsi_host
> to better performing values than what's there currently.  It seems that
> asd_ha->seq.can_queue reflects the number of requests that can be
> queued per controller; so long as there's one scsi_host per controller,
> it seems logical that the scsi_host ought to have the same can_queue
> value.  To the best of my (still limited) knowledge, this method
> provides the correct value.
> 
> The effect of leaving this value set to 1 is terrible performance in
> the case of either (a) certain Maxtor SAS drives flying solo or (b)
> flooding several disks with I/O simultaneously (md-raid).  There may be
> more scenarios where we see similar problems that I haven't uncovered.

Let's try this again, after kicking Thunderbird in the head.

Signed-off-by: Darrick J. Wong <djwong@us.ibm.com>

diff --git a/drivers/scsi/aic94xx/aic94xx_init.c b/drivers/scsi/aic94xx/aic94xx_init.c
index 3e25e31..5c6d457 100644
--- a/drivers/scsi/aic94xx/aic94xx_init.c
+++ b/drivers/scsi/aic94xx/aic94xx_init.c
@@ -623,6 +623,8 @@ static int __devinit asd_pci_probe(struc
 		   asd_ha->hw_prof.bios.present ? "build " : "not present",
 		   asd_ha->hw_prof.bios.bld);
 
+	shost->can_queue = asd_ha->seq.can_queue;
+
 	if (use_msi)
 		pci_enable_msi(asd_ha->pcidev);
 
