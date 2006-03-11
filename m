Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751183AbWCKPMR@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751183AbWCKPMR (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 11 Mar 2006 10:12:17 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751203AbWCKPMR
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 11 Mar 2006 10:12:17 -0500
Received: from mailout.stusta.mhn.de ([141.84.69.5]:17929 "HELO
	mailout.stusta.mhn.de") by vger.kernel.org with SMTP
	id S1751183AbWCKPLz (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 11 Mar 2006 10:11:55 -0500
Date: Sat, 11 Mar 2006 16:11:54 +0100
From: Adrian Bunk <bunk@stusta.de>
To: "Brown, Len" <len.brown@intel.com>
Cc: linux-acpi@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [2.6 patch] drivers/acpi/video.c: fix a NULL pointer dereference
Message-ID: <20060311151154.GR21864@stusta.de>
References: <F7DC2337C7631D4386A2DF6E8FB22B3006596EE5@hdsmsx401.amr.corp.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <F7DC2337C7631D4386A2DF6E8FB22B3006596EE5@hdsmsx401.amr.corp.intel.com>
User-Agent: Mutt/1.5.11+cvs20060126
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Mar 10, 2006 at 11:00:45PM -0500, Brown, Len wrote:
> 
> >The Coverity checker spotted this obvious bug in 
> >acpi_video_device_lcd_query_levels().
> >
> >
> >
> >Signed-off-by: Adrian Bunk <bunk@stusta.de>
> >
> >--- linux-2.6.16-rc5-mm3-full/drivers/acpi/video.c.old	
> >2006-03-10 18:04:18.000000000 +0100
> >+++ linux-2.6.16-rc5-mm3-full/drivers/acpi/video.c	
> >2006-03-10 18:04:33.000000000 +0100
> >@@ -321,11 +321,11 @@ acpi_video_device_lcd_query_levels(struc
> > 
> > 	status = acpi_evaluate_object(device->handle, "_BCL", 
> >NULL, &buffer);
> > 	if (!ACPI_SUCCESS(status))
> > 		return_VALUE(status);
> > 	obj = (union acpi_object *)buffer.pointer;
> >-	if (!obj && (obj->type != ACPI_TYPE_PACKAGE)) {
> >+	if (obj && (obj->type != ACPI_TYPE_PACKAGE)) {
> 
> how about
> +	if (!obj || (obj->type != ACPI_TYPE_PACKAGE)) {
>...

Yes, thanks for the correction.

cu
Adrian


<--  snip  -->


The Coverity checker spotted this bug in
acpi_video_device_lcd_query_levels().


Signed-off-by: Adrian Bunk <bunk@stusta.de>

--- linux-2.6.16-rc5-mm3-full/drivers/acpi/video.c.old	2006-03-10 18:04:18.000000000 +0100
+++ linux-2.6.16-rc5-mm3-full/drivers/acpi/video.c	2006-03-10 18:04:33.000000000 +0100
@@ -321,11 +321,11 @@ acpi_video_device_lcd_query_levels(struc
 
 	status = acpi_evaluate_object(device->handle, "_BCL", NULL, &buffer);
 	if (!ACPI_SUCCESS(status))
 		return_VALUE(status);
 	obj = (union acpi_object *)buffer.pointer;
-	if (!obj && (obj->type != ACPI_TYPE_PACKAGE)) {
+	if (!obj || (obj->type != ACPI_TYPE_PACKAGE)) {
 		ACPI_ERROR((AE_INFO, "Invalid _BCL data"));
 		status = -EFAULT;
 		goto err;
 	}
 

