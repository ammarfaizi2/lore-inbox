Return-Path: <linux-kernel-owner+w=401wt.eu-S932337AbWLLStm@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932337AbWLLStm (ORCPT <rfc822;w@1wt.eu>);
	Tue, 12 Dec 2006 13:49:42 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932338AbWLLStm
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 12 Dec 2006 13:49:42 -0500
Received: from rrcs-24-153-217-226.sw.biz.rr.com ([24.153.217.226]:37905 "EHLO
	smtp.opengridcomputing.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S932337AbWLLStl (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 12 Dec 2006 13:49:41 -0500
Subject: Re: 2.6.19-git3 panics on boot - ata_piix/PCI related [still in
	-git17]
From: Steve Wise <swise@opengridcomputing.com>
To: Jeff Garzik <jeff@garzik.org>
Cc: Alan <alan@lxorguk.ukuu.org.uk>,
       Alessandro Suardi <alessandro.suardi@gmail.com>,
       linux-kernel <linux-kernel@vger.kernel.org>,
       Andrew Morton <akpm@osdl.org>
In-Reply-To: <457EEF1F.8040906@garzik.org>
References: <5a4c581d0612110526j26a07b31q26edc075d4981cd8@mail.gmail.com>
	 <1165873362.20877.22.camel@stevo-desktop>
	 <1165941542.24482.5.camel@stevo-desktop>
	 <20061212173516.1b7dc654@localhost.localdomain>
	 <457EEF1F.8040906@garzik.org>
Content-Type: text/plain
Date: Tue, 12 Dec 2006 12:49:41 -0600
Message-Id: <1165949381.24482.10.camel@stevo-desktop>
Mime-Version: 1.0
X-Mailer: Evolution 2.4.0 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 2006-12-12 at 13:04 -0500, Jeff Garzik wrote:
> Alan wrote:
> > On Tue, 12 Dec 2006 10:39:02 -0600
> > Steve Wise <swise@opengridcomputing.com> wrote:
> > 
> >> All,
> >>
> >> Bisecting reveals that this commit causes the problem:
> > 
> > Yes we know. There is a libata patch missing. As I said - if it is still
> > missing by -rc1 I'll sort out a diff.
> 
> What's the patch?  Message-id?  I don't have anything from you in my 
> patch queue.
> 
> 	Jeff
> 
> 
> 

I dug up the patch below from here: 

http://marc.theaimsgroup.com/?l=linux-kernel&m=116343564202844&q=raw

This patch fixes my problem, and I don't think its in Linus's tree at
this point.


Steve.


diff --git a/drivers/ata/libata-sff.c b/drivers/ata/libata-sff.c
index 10ee22a..40a2bfa 100644
--- a/drivers/ata/libata-sff.c
+++ b/drivers/ata/libata-sff.c
@@ -1027,13 +1027,13 @@ #if defined(CONFIG_NO_ATA_LEGACY)
 #endif
 	}
 
-	rc = pci_request_regions(pdev, DRV_NAME);
-	if (rc) {
-		disable_dev_on_err = 0;
-		goto err_out;
-	}
-
-	if (legacy_mode) {
+	if (!legacy_mode) {
+		rc = pci_request_regions(pdev, DRV_NAME);
+		if (rc) {
+			disable_dev_on_err = 0;
+			goto err_out;
+		}
+	} else {
 		if (!request_region(ATA_PRIMARY_CMD, 8, "libata")) {
 			struct resource *conflict, res;
 			res.start = ATA_PRIMARY_CMD;


