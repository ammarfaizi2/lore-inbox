Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030456AbVIAWVh@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030456AbVIAWVh (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 1 Sep 2005 18:21:37 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030461AbVIAWVh
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 1 Sep 2005 18:21:37 -0400
Received: from gateway-1237.mvista.com ([12.44.186.158]:51448 "EHLO
	av.mvista.com") by vger.kernel.org with ESMTP id S1030456AbVIAWVg convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 1 Sep 2005 18:21:36 -0400
Subject: Re: [PATCH 2.6.13] Unhandled error condition in aic79xx
From: Daniel Walker <dwalker@mvista.com>
Reply-To: dwalker@mvista.com
To: Alexey Dobriyan <adobriyan@gmail.com>
Cc: akpm@osdl.org, linux-kernel@vger.kernel.org, jirislaby@gmail.com
In-Reply-To: <20050901201029.GA10893@mipter.zuzino.mipt.ru>
References: <1125603501.4867.21.camel@dhcp153.mvista.com>
	 <20050901201029.GA10893@mipter.zuzino.mipt.ru>
Content-Type: text/plain
Organization: MontaVista
Date: Thu, 01 Sep 2005 15:21:29 -0700
Message-Id: <1125613289.16067.4.camel@dhcp153.mvista.com>
Mime-Version: 1.0
X-Mailer: Evolution 2.0.2 (2.0.2-3) 
Content-Transfer-Encoding: 8BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 2005-09-02 at 00:10 +0400, Alexey Dobriyan wrote:

> I see malloc(), kernel_thread() and multiple ahd_linux_alloc_target()
> above. Ditto for 7xxx patch.

It looks like it's all handled inside ahd_free() . Here's the updated
patch. Any concerns? 

Signed-Off-By: Daniel Walker <dwalker@mvista.com>

Index: linux-2.6.13/drivers/scsi/aic7xxx/aic79xx_osm.c
===================================================================
--- linux-2.6.13.orig/drivers/scsi/aic7xxx/aic79xx_osm.c	2005-08-28 23:41:01.000000000 +0000
+++ linux-2.6.13/drivers/scsi/aic7xxx/aic79xx_osm.c	2005-09-01 22:16:10.000000000 +0000
@@ -1989,6 +1989,7 @@ ahd_linux_register_host(struct ahd_softc
 	char	*new_name;
 	u_long	s;
 	u_long	target;
+	int error = 0;
 
 	template->name = ahd->description;
 	host = scsi_host_alloc(template, sizeof(struct ahd_softc *));
@@ -2064,10 +2065,14 @@ ahd_linux_register_host(struct ahd_softc
 	ahd_linux_start_dv(ahd);
 	ahd_unlock(ahd, &s);
 
-#if LINUX_VERSION_CODE >= KERNEL_VERSION(2,5,0)
-	scsi_add_host(host, &ahd->dev_softc->dev); /* XXX handle failure */
+	error = scsi_add_host(host, &ahd->dev_softc->dev); 
+	if (error) {
+		ahd_free(ahd);
+		scsi_host_put(host);
+		return error;
+	}
 	scsi_scan_host(host);
-#endif
+
 	return (0);
 }
 
c link

aph

–h›)





ph

D
 
÷c link


Î
;

h@ 
c link



dw

»Î
===h

h@ 

