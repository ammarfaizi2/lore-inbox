Return-Path: <linux-kernel-owner+willy=40w.ods.org-S266366AbUGJTtf@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266366AbUGJTtf (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 10 Jul 2004 15:49:35 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266370AbUGJTtf
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 10 Jul 2004 15:49:35 -0400
Received: from smtp805.mail.sc5.yahoo.com ([66.163.168.184]:4266 "HELO
	smtp805.mail.sc5.yahoo.com") by vger.kernel.org with SMTP
	id S266366AbUGJTtd (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 10 Jul 2004 15:49:33 -0400
From: Dmitry Torokhov <dtor_core@ameritech.net>
To: linux-kernel@vger.kernel.org
Subject: Re: [OOPS] linux-2.6.7-bk20: possible use-after-free in platform_device_unregister()
Date: Sat, 10 Jul 2004 14:49:29 -0500
User-Agent: KMail/1.6.2
Cc: Denis Vlasenko <vda@port.imtp.ilyichevsk.odessa.ua>
References: <200407102131.10194.vda@port.imtp.ilyichevsk.odessa.ua>
In-Reply-To: <200407102131.10194.vda@port.imtp.ilyichevsk.odessa.ua>
MIME-Version: 1.0
Content-Disposition: inline
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Message-Id: <200407101449.30408.dtor_core@ameritech.net>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Saturday 10 July 2004 01:31 pm, Denis Vlasenko wrote:
> void platform_device_unregister(struct platform_device * pdev)
> {
> ? ? ? ? int i;
> 
> ? ? ? ? if (pdev) {
> ? ? ? ? ? ? ? ? device_unregister(&pdev->dev);
>

Here depca_platform_release kicks in and frees platform device structure.
platform_device_unregister should save pointer to resources. 
 
> ? ? ? ? ? ? ? ? for (i = 0; i < pdev->num_resources; i++) {
> ? ? ? ? ? ? ? ? ? ? ? ? struct resource *r = &pdev->resource[i];
> ===> ? ? ? ? ? ? ? ? ? ?if (r->flags & (IORESOURCE_MEM|IORESOURCE_IO))
> ? ? ? ? ? ? ? ? ? ? ? ? ? ? ? ? release_resource(r);
> ? ? ? ? ? ? ? ? }
> ? ? ? ? }
> }
> 

Does the following help (hopefully it will apply - I have just a tad
different tree):

===== drivers/base/platform.c 1.21 vs edited =====
--- 1.21/drivers/base/platform.c	2004-07-04 19:56:37 -05:00
+++ edited/drivers/base/platform.c	2004-07-10 14:44:51 -05:00
@@ -143,13 +143,15 @@
  */
 void platform_device_unregister(struct platform_device * pdev)
 {
-	int i;
-
 	if (pdev) {
+		int i, num_resources = pdev->num_resources;
+		struct resource *r, *resources = pdev->resource;
+
+		/* this call may free pdev, that's why we saved resource data */
 		device_unregister(&pdev->dev);
 
-		for (i = 0; i < pdev->num_resources; i++) {
-			struct resource *r = &pdev->resource[i];
+		for (i = 0; i < num_resources; i++) {
+			r = &resources[i];
 			if (r->flags & (IORESOURCE_MEM|IORESOURCE_IO))
 				release_resource(r);
 		}
