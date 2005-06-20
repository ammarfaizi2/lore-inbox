Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261621AbVFTVfS@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261621AbVFTVfS (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 20 Jun 2005 17:35:18 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261635AbVFTVcO
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 20 Jun 2005 17:32:14 -0400
Received: from mx1.redhat.com ([66.187.233.31]:53739 "EHLO mx1.redhat.com")
	by vger.kernel.org with ESMTP id S261632AbVFTVbB (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 20 Jun 2005 17:31:01 -0400
Date: Mon, 20 Jun 2005 17:30:54 -0400
From: Dave Jones <davej@redhat.com>
To: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Cc: jgarzik@pobox.com
Subject: Re: [SCSI] allow sleeping in ->eh_device_reset_handler()
Message-ID: <20050620213054.GA14191@redhat.com>
Mail-Followup-To: Dave Jones <davej@redhat.com>,
	Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
	jgarzik@pobox.com
References: <200506181820.j5IIKLlm021250@hera.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200506181820.j5IIKLlm021250@hera.kernel.org>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Jun 18, 2005 at 11:20:21AM -0700, Linux Kernel wrote:
 > tree 1609752ea7a9adb28583147f0bea33a9f10877d7
 > parent 8fa728a26886f56a9ee10a44fea0ddda301d21c3
 > author Jeff Garzik <jgarzik@pobox.com> Sat, 28 May 2005 15:55:48 -0400
 > committer Jeff Garzik <jgarzik@pobox.com> Fri, 17 Jun 2005 22:05:03 -0500
 > 
 > [SCSI] allow sleeping in ->eh_device_reset_handler()
 > 
 > Signed-off-by: James Bottomley <James.Bottomley@SteelEye.com>

 .. deletia ...
 
 > ===================================================================
 > --- 105ead5c90057400abae0c8aa9e2b5ba1818c327/drivers/scsi/megaraid.c  (mode:100644 sha1:8d707b29027da4dcab34942adcc7aac9f5e11a8e)
 > +++ 1609752ea7a9adb28583147f0bea33a9f10877d7/drivers/scsi/megaraid.c  (mode:100644 sha1:80b0c40c522b7023369c6498ad24165892b8ff55)
 > @@ -1938,7 +1938,7 @@ megaraid_abort(Scsi_Cmnd *cmd)
 >  
 >  
 >  static int
 > -megaraid_reset(Scsi_Cmnd *cmd)
 > +__megaraid_reset(Scsi_Cmnd *cmd)
 >  {
 >  	adapter_t	*adapter;
 >  	megacmd_t	mc;
 > @@ -1972,6 +1972,18 @@ megaraid_reset(Scsi_Cmnd *cmd)
 >  	return rval;
 >  }
 >  
 > +static int
 > +megaraid_reset(Scsi_Cmnd *cmd)
 > +{
 > +	adapter = (adapter_t *)cmd->device->host->hostdata;
 > +	int rc;
 > +
 > +	spin_lock_irq(&adapter->lock);
 > +	rc = __megaraid_reset(cmd);
 > +	spin_unlock_irq(&adapter->lock);
 > +
 > +	return rc;
 > +}

This doesn't compile.

drivers/scsi/megaraid.c:1978: error: 'adapter' undeclared (first use in this function)
drivers/scsi/megaraid.c:1978: error: (Each undeclared identifier is reported only once
drivers/scsi/megaraid.c:1978: error: for each function it appears in.)
drivers/scsi/megaraid.c:1979: warning: ISO C90 forbids mixed declarations and code

This should fix it.. (untested due to lack of hardware)

Signed-off-by: Dave Jones <davej@redhat.com>

--- linux-2.6.12/drivers/scsi/megaraid.c~	2005-06-20 17:23:27.000000000 -0400
+++ linux-2.6.12/drivers/scsi/megaraid.c	2005-06-20 17:29:03.000000000 -0400
@@ -1975,9 +1975,11 @@ __megaraid_reset(Scsi_Cmnd *cmd)
 static int
 megaraid_reset(Scsi_Cmnd *cmd)
 {
-	adapter = (adapter_t *)cmd->device->host->hostdata;
+	adapter_t *adapter;
 	int rc;
 
+	adapter = cmd->device->host->hostdata;
+
 	spin_lock_irq(&adapter->lock);
 	rc = __megaraid_reset(cmd);
 	spin_unlock_irq(&adapter->lock);

