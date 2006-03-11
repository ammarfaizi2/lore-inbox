Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751192AbWCKQFZ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751192AbWCKQFZ (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 11 Mar 2006 11:05:25 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751203AbWCKQFY
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 11 Mar 2006 11:05:24 -0500
Received: from 85.8.13.51.se.wasadata.net ([85.8.13.51]:7051 "EHLO
	smtp.drzeus.cx") by vger.kernel.org with ESMTP id S1751192AbWCKQFY
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 11 Mar 2006 11:05:24 -0500
Message-ID: <4412F53B.5010309@drzeus.cx>
Date: Sat, 11 Mar 2006 17:05:15 +0100
From: Pierre Ossman <drzeus-list@drzeus.cx>
User-Agent: Thunderbird 1.5 (X11/20060210)
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="=_hermes.drzeus.cx-6740-1142093117-0001-2"
To: Kay Sievers <kay.sievers@vrfy.org>, akpm@osdl.org
CC: ambx1@neo.rr.com, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] [PNP] 'modalias' sysfs export
References: <20060227214018.3937.14572.stgit@poseidon.drzeus.cx> <20060301194532.GB25907@vrfy.org> <4406AF27.9040700@drzeus.cx> <20060302165816.GA13127@vrfy.org> <44082E14.5010201@drzeus.cx>
In-Reply-To: <44082E14.5010201@drzeus.cx>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is a MIME-formatted message.  If you see this text it means that your
E-mail software does not support MIME-formatted messages.

--=_hermes.drzeus.cx-6740-1142093117-0001-2
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: 7bit

Here is a patch for doing multi line modalias for PNP devices. This will
break udev, so that needs to be updated first.

I had a longer look at the card part and it seems that module aliases
cannot be reliably used for it. Not without restructuring the system at
least. The possible combinations explode when you notice that the driver
ids needs to be just at subset of the card, without any ordering.

If I got my calculations right, a PNP card would have to have roughly
2^(2n) aliases, where n is the number of device ids. So right now, I
lean towards only adding modalias support for the non-card part of the
PNP layer.

Andrew, do you want a fix for the patch in -mm or can you remove the
part of it that modifies drivers/pnp/card.c by yourself?

Rgds
Pierre


--=_hermes.drzeus.cx-6740-1142093117-0001-2
Content-Type: text/x-patch; name="pnp-sysfs-modalias-multiline.patch"; charset=iso-8859-1
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="pnp-sysfs-modalias-multiline.patch"

[PNP] Export all aliases through the modalias attribute

From: Pierre Ossman <drzeus@drzeus.cx>

In order to be backwards compatible, we previously only exported the first
of all the PNP module aliases. We should instead export all aliases,
delimited by newlines.
---

 drivers/pnp/interface.c |    8 ++++++--
 1 files changed, 6 insertions(+), 2 deletions(-)

diff --git a/drivers/pnp/interface.c b/drivers/pnp/interface.c
index 67bd17c..8e78923 100644
--- a/drivers/pnp/interface.c
+++ b/drivers/pnp/interface.c
@@ -461,11 +461,15 @@ static DEVICE_ATTR(id,S_IRUGO,pnp_show_c
 
 static ssize_t pnp_modalias_show(struct device *dmdev, struct device_attribute *attr, char *buf)
 {
+	char *str = buf;
 	struct pnp_dev *dev = to_pnp_dev(dmdev);
 	struct pnp_id * pos = dev->id;
 
-	/* FIXME: modalias can only do one alias */
-	return sprintf(buf, "pnp:d%s\n", pos->id);
+	while (pos) {
+		str += sprintf(str,"pnp:d%s\n", pos->id);
+		pos = pos->next;
+	}
+	return (str - buf);
 }
 
 static DEVICE_ATTR(modalias,S_IRUGO,pnp_modalias_show,NULL);

--=_hermes.drzeus.cx-6740-1142093117-0001-2--
