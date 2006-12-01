Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1162220AbWLAXUG@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1162220AbWLAXUG (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 1 Dec 2006 18:20:06 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1162225AbWLAXUG
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 1 Dec 2006 18:20:06 -0500
Received: from nf-out-0910.google.com ([64.233.182.190]:24596 "EHLO
	nf-out-0910.google.com") by vger.kernel.org with ESMTP
	id S1162220AbWLAXUE (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 1 Dec 2006 18:20:04 -0500
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:from:to:subject:date:user-agent:cc:mime-version:content-type:content-transfer-encoding:content-disposition:message-id;
        b=WGdKCkA+jTv6bX7A2xb7Vya6gM+o8dizBG+6FsFdI21jAYlN/dLUw058KTV2fWC7gKj+aJ9PWPsN+vBNUO5Qd2yAMeS8cWm5cqdyR7Y7VWet9FtsAhZ09KL3n2JTMmsBAfrKkw2Q+0vMPVnonyGbu08PFK9Nojqcs5cr1NWi+6k=
From: Jesper Juhl <jesper.juhl@gmail.com>
To: linux-kernel@vger.kernel.org
Subject: [PATCH] Be a bit defensive in quirk_nvidia_ck804() so we don't risk dereferencing a NULL pdev.
Date: Sat, 2 Dec 2006 00:21:56 +0100
User-Agent: KMail/1.9.4
Cc: Martin Mares <mj@ucw.cz>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200612020021.56250.jesper.juhl@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

pci_get_slot() may return NULL if nothing was found. 
quirk_nvidia_ck804() does not check the value returned from pci_get_slot(),
so it may end up causing a NULL pointer deref.


Signed-off-by: Jesper Juhl <jesper.juhl@gmail.com>
---

 drivers/pci/quirks.c |    2 ++
 1 files changed, 2 insertions(+), 0 deletions(-)

diff --git a/drivers/pci/quirks.c b/drivers/pci/quirks.c
index 5b44838..d3dcbda 100644
--- a/drivers/pci/quirks.c
+++ b/drivers/pci/quirks.c
@@ -1741,6 +1741,8 @@ static void __devinit quirk_nvidia_ck804
 	 * a single one having MSI is enough to be sure that MSI are supported.
 	 */
 	pdev = pci_get_slot(dev->bus, 0);
+	if (!pdev)
+		return;
 	if (dev->subordinate && !msi_ht_cap_enabled(dev)
 	    && !msi_ht_cap_enabled(pdev)) {
 		printk(KERN_WARNING "PCI: MSI quirk detected. "


