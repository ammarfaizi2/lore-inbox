Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262077AbUB2R0M (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 29 Feb 2004 12:26:12 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262081AbUB2R0M
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 29 Feb 2004 12:26:12 -0500
Received: from tench.street-vision.com ([212.18.235.100]:16343 "EHLO
	tench.street-vision.com") by vger.kernel.org with ESMTP
	id S262077AbUB2R0I (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 29 Feb 2004 12:26:08 -0500
Subject: Re: [PATCH/RFT] libata "DMA timeout" fix
From: Justin Cormack <justin@street-vision.com>
To: Jeff Garzik <jgarzik@pobox.com>
Cc: James Bottomley <James.Bottomley@steeleye.com>,
       Linux Kernel <linux-kernel@vger.kernel.org>
In-Reply-To: <404106D7.8050809@pobox.com>
References: <4040E7B5.4020709@pobox.com> <1078001357.2020.90.camel@mulgrave>
	 <404106D7.8050809@pobox.com>
Content-Type: text/plain
Message-Id: <1078075560.12938.1420.camel@lotte.street-vision.com>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.5 
Date: Sun, 29 Feb 2004 17:26:01 +0000
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Thanks, testing James's fix on one machine at the moment. Will have
another six or so machines as a libata test farm tomorrow.

Justin


On Sat, 2004-02-28 at 21:23, Jeff Garzik wrote:
> James Bottomley wrote:
> > On Sat, 2004-02-28 at 13:10, Jeff Garzik wrote:
> > 
> >>===== drivers/scsi/libata-core.c 1.19 vs edited =====
> >>--- 1.19/drivers/scsi/libata-core.c	Wed Feb 25 22:41:13 2004
> >>+++ edited/drivers/scsi/libata-core.c	Sat Feb 28 14:03:18 2004
> >>@@ -2130,6 +2130,14 @@
> >> 				cmd->result = SAM_STAT_CHECK_CONDITION;
> >> 			else
> >> 				ata_to_sense_error(qc);
> >>+
> >>+			/* hack alert! we need this to get past the
> >>+			 * first check in scsi_done().  libata is the
> >>+			 * -only- user of ->eh_strategy_handler() in
> >>+			 * any kernel tree, which exposes some incorrect
> >>+			 * assumptions in the SCSI layer.
> >>+			 */
> >>+			scsi_add_timer(cmd, 2000 * HZ, NULL);
> >> 		} else {
> >> 			cmd->result = SAM_STAT_GOOD;
> >> 		}
> > 
> > 
> > You can't do this.  Supposing there command's delayed, the timer fires
> > and then the command returns with a sense error?  The done will go
> > through automatically completing the command, but your strategy handler
> > will still think it has a failed command to handle.
> 
> hmmm, yeah that will be a problem iff we are not already in the strategy 
> handler.
> 
> 
> > The correct fix is this, I think (uncompiled, but you get the idea):
> 
> Yeah, that's much better.  That function is not exported though ;-)
> 
> 	Jeff
> 
> 
> 
> -
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/

