Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261253AbVGBShp@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261253AbVGBShp (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 2 Jul 2005 14:37:45 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261251AbVGBShp
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 2 Jul 2005 14:37:45 -0400
Received: from stat16.steeleye.com ([209.192.50.48]:8615 "EHLO
	hancock.sc.steeleye.com") by vger.kernel.org with ESMTP
	id S261253AbVGBSgc (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 2 Jul 2005 14:36:32 -0400
Subject: Re: aic7xxx regression occuring after 2.6.12 final
From: James Bottomley <James.Bottomley@SteelEye.com>
To: Tony Vroon <chainsaw@gentoo.org>
Cc: Linux Kernel <linux-kernel@vger.kernel.org>,
       SCSI Mailing List <linux-scsi@vger.kernel.org>,
       Andy Whitcroft <apw@shadowen.org>
In-Reply-To: <1120326423.22057.3.camel@localhost>
References: <1120085446.9743.11.camel@localhost>
	 <1120318925.21935.9.camel@localhost>  <1120321322.5073.4.camel@mulgrave>
	 <1120322788.22046.2.camel@localhost>  <1120323691.5073.12.camel@mulgrave>
	 <1120324426.21967.1.camel@localhost>  <1120325613.5073.16.camel@mulgrave>
	 <1120326423.22057.3.camel@localhost>
Content-Type: text/plain
Date: Sat, 02 Jul 2005 14:36:29 -0400
Message-Id: <1120329389.5073.21.camel@mulgrave>
Mime-Version: 1.0
X-Mailer: Evolution 2.0.4 (2.0.4-4) 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 2005-07-02 at 18:47 +0100, Tony Vroon wrote:
> (scsi0:A:0:0): Sending PPR bus_width 1, period 9, offset 7f, ppr_options
> 7
> (scsi0:A:0:0): Received PPR bus_width 1, period 9, offset 7f,
> ppr_options 7
> Filtered to width 0, period 0, offset 0, options 0

Well, I think this is it.  The drive is actually offering IU and QAS.
That's fun; I've never seen a u160 drive that could do those before.
Although the aic7xxx driver is apparently coded to allow this, it looks
like the code paths have never been exercised.

So, although I think this patch will fix up the first error, there's
probably a long line behind it ...

James

diff --git a/drivers/scsi/aic7xxx/aic7xxx_core.c
b/drivers/scsi/aic7xxx/aic7xxx_core.c
--- a/drivers/scsi/aic7xxx/aic7xxx_core.c
+++ b/drivers/scsi/aic7xxx/aic7xxx_core.c
@@ -3258,7 +3258,8 @@ ahc_parse_msg(struct ahc_softc *ahc, str
 			 * on any controller.  Transfer options are
 			 * only available if we are negotiating wide.
 			 */
-			ppr_options &= MSG_EXT_PPR_DT_REQ;
+			ppr_options &= MSG_EXT_PPR_DT_REQ |
+			  MSG_EXT_PPR_QAS_REQ | MSG_EXT_PPR_IU_REQ;
 			if (bus_width == 0)
 				ppr_options = 0;
 


