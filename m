Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262044AbVCHNXE@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262044AbVCHNXE (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 8 Mar 2005 08:23:04 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262047AbVCHNWu
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 8 Mar 2005 08:22:50 -0500
Received: from [195.23.16.24] ([195.23.16.24]:36252 "EHLO
	bipbip.comserver-pie.com") by vger.kernel.org with ESMTP
	id S262046AbVCHNWJ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 8 Mar 2005 08:22:09 -0500
Message-ID: <422DA69D.6070105@grupopie.com>
Date: Tue, 08 Mar 2005 13:20:29 +0000
From: Paulo Marques <pmarques@grupopie.com>
Organization: Grupo PIE
User-Agent: Mozilla Thunderbird 0.7.1 (X11/20040626)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Andrew Morton <akpm@osdl.org>
Cc: linux-kernel@vger.kernel.org
Subject: Re: sizeof(ptr) or sizeof(*ptr)?
References: <1109535904.42222ca0b0b78@webmail.grupopie.com>	<20050227204524.GA29026@one-eyed-alien.net>	<1109546013.4222541d5db16@webmail.grupopie.com> <20050227213946.199e82af.akpm@osdl.org>
In-Reply-To: <20050227213946.199e82af.akpm@osdl.org>
Content-Type: multipart/mixed;
 boundary="------------080100040205040705070207"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is a multi-part message in MIME format.
--------------080100040205040705070207
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit

Andrew Morton wrote:
> "" <pmarques@grupopie.com> wrote:
> 
>>Anyway, after improving the tool and checking for false positives, there is only
>> one more suspicious piece of code in drivers/acpi/video.c:561
>>
>> 	status = acpi_video_device_lcd_query_levels(device, &obj);
>>
>> 	if (obj && obj->type == ACPI_TYPE_PACKAGE && obj->package.count >= 2) {
>> 		int count = 0;
>> 		union acpi_object *o;
>>
>> 		br = kmalloc(sizeof &br, GFP_KERNEL);
> 
> 
> yup, bug.
> 
> 
>> 		if (!br) {
>> 			printk(KERN_ERR "can't allocate memory\n");
>> 		} else {
>> 			memset(br, 0, sizeof &br);
>> 			br->levels = kmalloc(obj->package.count * sizeof &br->levels, GFP_KERNEL);
> 
> 
> And another one, although it happens to work out OK.
> 
> I'll get these all fixed up, thanks.

I just checked the 2.6.11-mm1 release and this is only half-fixed there, 
and it is the worst of both halves: the kmalloc only mallocs the size of 
a pointer, but the memset is fixed, so it memset's the size of a 
structure (oops). This is partially my fault for not sending the patch 
in the first place, together with the bug report.

The attached patch against 2.6.11-mm1 should fix the kmalloc.

By the way, I haven't got any response from an alsa developer about the 
bug in sound/core/control.c, but this is already fixed in 2.6.11-mm1, 
along with several other changes to that file. So the status is: it was 
a bug, but it is already fixed :)

-- 
Paulo Marques - www.grupopie.com

All that is necessary for the triumph of evil is that good men do nothing.
Edmund Burke (1729 - 1797)

--------------080100040205040705070207
Content-Type: text/plain;
 name="acpipatch"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="acpipatch"

--- ./drivers/acpi/video.c.orig	2005-03-08 13:07:42.000000000 +0000
+++ ./drivers/acpi/video.c	2005-03-08 13:09:05.000000000 +0000
@@ -564,11 +564,11 @@ acpi_video_device_find_cap (struct acpi_
 		int count = 0;
 		union acpi_object *o;
 		
-		br = kmalloc(sizeof &br, GFP_KERNEL);
+		br = kmalloc(sizeof(*br), GFP_KERNEL);
 		if (!br) {
 			printk(KERN_ERR "can't allocate memory\n");
 		} else {
-			memset(br, 0, sizeof *br);
+			memset(br, 0, sizeof(*br));
 			br->levels = kmalloc(obj->package.count *
 					sizeof *(br->levels), GFP_KERNEL);
 			if (!br->levels)

--------------080100040205040705070207--
