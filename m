Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261511AbVB0XQo@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261511AbVB0XQo (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 27 Feb 2005 18:16:44 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261513AbVB0XQo
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 27 Feb 2005 18:16:44 -0500
Received: from [195.23.16.24] ([195.23.16.24]:33713 "EHLO
	bipbip.comserver-pie.com") by vger.kernel.org with ESMTP
	id S261511AbVB0XQl convert rfc822-to-8bit (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 27 Feb 2005 18:16:41 -0500
Message-ID: <1109546013.4222541d5db16@webmail.grupopie.com>
Date: Sun, 27 Feb 2005 23:13:33 +0000
From: "" <pmarques@grupopie.com>
To: Matthew Dharm <mdharm-kernel@one-eyed-alien.net>
Cc: "" <linux-kernel@vger.kernel.org>, "" <perex@suse.cz>,
       "" <luming.yu@intel.com>
Subject: Re: sizeof(ptr) or sizeof(*ptr)?
References: <1109535904.42222ca0b0b78@webmail.grupopie.com> <20050227204524.GA29026@one-eyed-alien.net>
In-Reply-To: <20050227204524.GA29026@one-eyed-alien.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
User-Agent: Internet Messaging Program (IMP) 3.2.2
X-Originating-IP: 82.154.89.181
Content-Transfer-Encoding: 7BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Quoting Matthew Dharm <mdharm-kernel@one-eyed-alien.net>:
> [...]
> 	us->host = scsi_host_alloc(&usb_stor_host_template, sizeof(*us));
> 
> This is actually correct as-is.  We're allocating a host, and asking for
> the sizeof(pointer) in the 'extra storage' section.  We then store the
> pointer (not what it points to) in the extra storage section a few lines
> down.

Thanks for clarifying that. I guess the weekend effect got me, because at a
certain point I was starting to read the scsi_host_alloc as if it were a
kmalloc or something... :P

Anyway, after improving the tool and checking for false positives, there is only
one more suspicious piece of code in drivers/acpi/video.c:561

	status = acpi_video_device_lcd_query_levels(device, &obj);

	if (obj && obj->type == ACPI_TYPE_PACKAGE && obj->package.count >= 2) {
		int count = 0;
		union acpi_object *o;

		br = kmalloc(sizeof &br, GFP_KERNEL);
		if (!br) {
			printk(KERN_ERR "can't allocate memory\n");
		} else {
			memset(br, 0, sizeof &br);
			br->levels = kmalloc(obj->package.count * sizeof &br->levels, GFP_KERNEL);
			if (!br->levels)
				goto out;

"br" if of type "struct acpi_video_device_brightness *". 

"sizeof &br" doesn't make much sense there (besides the unconventional use of
sizeof without parenthesis) because the rest of the code seem to suggest that a
whole structure should have been allocated. This is the last case I've seen,
and I've added the maintainer to the cc list, so that he can check the code for
correctness.

Well, sorry about bothering you with a false positive (that I should've
recognised on my own, anyway), and thanks for the help.

--
Paulo Marques - www.grupopie.com
 
All that is necessary for the triumph of evil is that good men do nothing.
Edmund Burke (1729 - 1797)

