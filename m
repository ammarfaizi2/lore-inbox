Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261165AbVCXUkx@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261165AbVCXUkx (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 24 Mar 2005 15:40:53 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261287AbVCXUkw
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 24 Mar 2005 15:40:52 -0500
Received: from mailout.stusta.mhn.de ([141.84.69.5]:39438 "HELO
	mailout.stusta.mhn.de") by vger.kernel.org with SMTP
	id S261165AbVCXUhr (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 24 Mar 2005 15:37:47 -0500
Date: Thu, 24 Mar 2005 21:37:44 +0100
From: Adrian Bunk <bunk@stusta.de>
To: len.brown@intel.com
Cc: acpi-devel@lists.sourceforge.net, linux-kernel@vger.kernel.org
Subject: drivers/acpi/video.c: null pointer dereference
Message-ID: <20050324203744.GB3966@stusta.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.6+20040907i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

The Coverity checker found the following null pointer dereference in 
drivers/acpi/video.c:

<--  snip  -->

...
static int
acpi_video_switch_output(
...
{
...
        struct acpi_video_device *dev=NULL;
...
        list_for_each_safe(node, next, &video->video_device_list) {
                struct acpi_video_device * dev = container_of(node, struct acpi_video_device, entry);
...
        }
...
        switch (event) {
        case ACPI_VIDEO_NOTIFY_CYCLE:
        case ACPI_VIDEO_NOTIFY_NEXT_OUTPUT:
                acpi_video_device_set_state(dev, 0);
                acpi_video_device_set_state(dev_next, 0x80000001);
                break;
        case ACPI_VIDEO_NOTIFY_PREV_OUTPUT:
                acpi_video_device_set_state(dev, 0);
                acpi_video_device_set_state(dev_prev, 0x80000001);
...

<--  snip  -->


Two different variables of the same name within 40 lines of code are a 
good indication that something's wrong...


The outer "dev" variable is never assigned any value different from 
NULL.

acpi_video_device_set_state dereferences this variable.


cu
Adrian

-- 

       "Is there not promise of rain?" Ling Tan asked suddenly out
        of the darkness. There had been need of rain for many days.
       "Only a promise," Lao Er said.
                                       Pearl S. Buck - Dragon Seed

