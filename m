Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261927AbVCaD2P@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261927AbVCaD2P (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 30 Mar 2005 22:28:15 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261928AbVCaD2P
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 30 Mar 2005 22:28:15 -0500
Received: from fmr24.intel.com ([143.183.121.16]:38618 "EHLO
	scsfmr004.sc.intel.com") by vger.kernel.org with ESMTP
	id S261927AbVCaD2G (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 30 Mar 2005 22:28:06 -0500
Subject: Re: drivers/acpi/video.c: null pointer dereference
From: Len Brown <len.brown@intel.com>
To: Adrian Bunk <bunk@stusta.de>
Cc: ACPI Developers <acpi-devel@lists.sourceforge.net>,
       linux-kernel@vger.kernel.org, Luming Yu <luming.yu@intel.com>
In-Reply-To: <20050324203744.GB3966@stusta.de>
References: <20050324203744.GB3966@stusta.de>
Content-Type: multipart/mixed; boundary="=-JipfZAoNh4K1u0fiKgtp"
Organization: 
Message-Id: <1112239614.2175.68.camel@d845pe>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.2.3 
Date: 30 Mar 2005 22:26:55 -0500
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--=-JipfZAoNh4K1u0fiKgtp
Content-Type: text/plain
Content-Transfer-Encoding: 7bit

On Thu, 2005-03-24 at 15:37, Adrian Bunk wrote:
> The Coverity checker found the following null pointer dereference in
> drivers/acpi/video.c:
> 
> <--  snip  -->
> 
> ...
> static int
> acpi_video_switch_output(
> ...
> {
> ...
>         struct acpi_video_device *dev=NULL;
> ...
>         list_for_each_safe(node, next, &video->video_device_list) {
>                 struct acpi_video_device * dev = container_of(node,
> struct acpi_video_device, entry);
> ...
>         }
> ...
>         switch (event) {
>         case ACPI_VIDEO_NOTIFY_CYCLE:
>         case ACPI_VIDEO_NOTIFY_NEXT_OUTPUT:
>                 acpi_video_device_set_state(dev, 0);
>                 acpi_video_device_set_state(dev_next, 0x80000001);
>                 break;
>         case ACPI_VIDEO_NOTIFY_PREV_OUTPUT:
>                 acpi_video_device_set_state(dev, 0);
>                 acpi_video_device_set_state(dev_prev, 0x80000001);
> ...
> 
> <--  snip  -->
> 
> 
> Two different variables of the same name within 40 lines of code are a
> good indication that something's wrong...
> 
> 
> The outer "dev" variable is never assigned any value different from
> NULL.
> 
> acpi_video_device_set_state dereferences this variable.
> 
> 
> cu
> Adrian

Looks like we should do this:



--=-JipfZAoNh4K1u0fiKgtp
Content-Disposition: attachment; filename=video.patch
Content-Type: text/plain; name=video.patch; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit

===== drivers/acpi/video.c 1.8 vs edited =====
--- 1.8/drivers/acpi/video.c	2005-01-06 02:06:20 -05:00
+++ edited/drivers/acpi/video.c	2005-03-24 15:44:33 -05:00
@@ -1585,7 +1585,7 @@
 	ACPI_FUNCTION_TRACE("acpi_video_switch_output");
 
 	list_for_each_safe(node, next, &video->video_device_list) {
-		struct acpi_video_device * dev = container_of(node, struct acpi_video_device, entry);
+		dev = container_of(node, struct acpi_video_device, entry);
 		status = acpi_video_device_get_state(dev, &state);
 		if (state & 0x2){
 			dev_next = container_of(node->next, struct acpi_video_device, entry);

--=-JipfZAoNh4K1u0fiKgtp--

