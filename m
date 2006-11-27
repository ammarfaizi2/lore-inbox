Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1756367AbWK0Df7@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756367AbWK0Df7 (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 26 Nov 2006 22:35:59 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1756411AbWK0Df7
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 26 Nov 2006 22:35:59 -0500
Received: from nz-out-0102.google.com ([64.233.162.197]:25318 "EHLO
	nz-out-0102.google.com") by vger.kernel.org with ESMTP
	id S1756378AbWK0Df6 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 26 Nov 2006 22:35:58 -0500
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:date:from:to:cc:subject:message-id:references:mime-version:content-type:content-disposition:in-reply-to:user-agent;
        b=E0zwxmZSIiPBhXUfuY4rW6uJBvZI/rNef00mI2lX1F0Tt7MWcJ3CZQ9Qy+KyemWxo4pDWGCDtON3PqZlml4jjAP788z8E7E25prY2t8vLrtGAmWMQbZH0NheuqwogpdwZ6o5NDG1vVJsZVKqnKIHlB2o8NPVc3tv4Ug1lRcbzKk=
Date: Mon, 27 Nov 2006 12:35:50 +0900
From: Tejun Heo <htejun@gmail.com>
To: "Berck E. Nash" <flyboy@gmail.com>
Cc: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: 2.6.18 - AHCI detection pauses excessively
Message-ID: <20061127033550.GB11250@htj.dyndns.org>
References: <4557B7D2.2050004@gmail.com> <455B0BD7.20108@gmail.com> <455B5ADF.2040503@gmail.com>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="5vNYLRcllDrimb99"
Content-Disposition: inline
In-Reply-To: <455B5ADF.2040503@gmail.com>
User-Agent: Mutt/1.5.13 (2006-08-11)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--5vNYLRcllDrimb99
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Wed, Nov 15, 2006 at 11:22:23AM -0700, Berck E. Nash wrote:
> Tejun Heo wrote:
> >Hmmm.. Can you try with the attached patch applied?  Also, please turn 
> >on kernel config 'Kernel Hacking -> Show timing info on printks' and 
> >report boot dmesg.
> 
> Looks like you forgot to attach the patch, so I couldn't test it:) 
> Here's the section with the annoying hang with timing info.  I noticed 
> that there are similar messages repeated later, but without as much 
> hang, so I've attached the entire dmesg as well, in case it's of any help.

Yeah, I did and forgot about this thread too.  Sorry.  This is on the
top of my to-do list now.  I'm attaching the patch.  TIA.

-- 
tejun

--5vNYLRcllDrimb99
Content-Type: text/plain; charset=us-ascii
Content-Disposition: attachment; filename=patch

diff --git a/drivers/ata/libata-core.c b/drivers/ata/libata-core.c
index 3fd7c79..89aa449 100644
--- a/drivers/ata/libata-core.c
+++ b/drivers/ata/libata-core.c
@@ -2669,20 +2669,26 @@ int sata_phy_debounce(struct ata_port *a
 
 		/* DET stable? */
 		if (cur == last) {
+			printk("SATA PHY: stable DET=%x\n", cur);
 			if (cur == 1 && time_before(jiffies, timeout))
 				continue;
-			if (time_after(jiffies, last_jiffies + duration))
+			if (time_after(jiffies, last_jiffies + duration)) {
+				printk("SATA PHY: debounced\n");
 				return 0;
+			}
 			continue;
 		}
 
+		printk("SATA PHY: unstable DET=%x->%x\n", last, cur);
 		/* unstable, start over */
 		last = cur;
 		last_jiffies = jiffies;
 
 		/* check timeout */
-		if (time_after(jiffies, timeout))
+		if (time_after(jiffies, timeout)) {
+			printk("SATA PHY: failed to debounce\n");
 			return -EBUSY;
+		}
 	}
 }
 
diff --git a/include/linux/libata.h b/include/linux/libata.h
index 9080789..8220ca3 100644
--- a/include/linux/libata.h
+++ b/include/linux/libata.h
@@ -689,10 +689,11 @@ extern const struct ata_port_operations
 static inline const unsigned long *
 sata_ehc_deb_timing(struct ata_eh_context *ehc)
 {
-	if (ehc->i.flags & ATA_EHI_HOTPLUGGED)
+/*	if (ehc->i.flags & ATA_EHI_HOTPLUGGED)
 		return sata_deb_timing_hotplug;
 	else
-		return sata_deb_timing_normal;
+		return sata_deb_timing_normal;*/
+	return sata_deb_timing_long;
 }
 
 static inline int ata_port_is_dummy(struct ata_port *ap)

--5vNYLRcllDrimb99--
