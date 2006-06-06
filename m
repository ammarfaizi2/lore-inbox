Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751209AbWFFLKT@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751209AbWFFLKT (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 6 Jun 2006 07:10:19 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751227AbWFFLKT
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 6 Jun 2006 07:10:19 -0400
Received: from wx-out-0102.google.com ([66.249.82.198]:53140 "EHLO
	wx-out-0102.google.com") by vger.kernel.org with ESMTP
	id S1751209AbWFFLKR (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 6 Jun 2006 07:10:17 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:user-agent:mime-version:to:cc:subject:content-type:content-transfer-encoding;
        b=LKgpa1YudZ9jGpmve+k8PBaGcPpKRC+2fK7+wRVdhCGHNuW09ql+OsNsv9mZALBFR44f99OSI79GCkAtxBRlRXmti4lwNnxYQG+k6RfHNukbTd3yGm2avbvrJe7aYZ9kBKCEHvrufj1PMd+rGCKLodOxcL9N831WVuQoEim9k1M=
Message-ID: <44856223.9010606@gmail.com>
Date: Tue, 06 Jun 2006 19:08:19 +0800
From: "Antonino A. Daplas" <adaplas@gmail.com>
User-Agent: Thunderbird 1.5.0.4 (X11/20060516)
MIME-Version: 1.0
To: Andrew Morton <akpm@osdl.org>
CC: Linux Fbdev development list 
	<linux-fbdev-devel@lists.sourceforge.net>,
       Linux Kernel Development <linux-kernel@vger.kernel.org>
Subject: [PATCH 0/7] Detaching fbcon
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

One of the limitations of the framebuffer console system is its inablity to
unload or detach itself from the console layer.  And once it loads, it also
locks in framebuffer drivers preventing their unload. Although the con2fbmap
utility does provide a means to unload individual drivers, it requires that at
least one framebuffer driver is loaded for use by fbcon.

With this change, it is possible to detach fbcon from the console layer. If it
is detached, it will reattach the boot console driver (which is permanently
loaded) back to the console layer so the system can continue to work.  As a
consequence, fbcon will also decrement its reference count of individual
framebuffer drivers, allowing all of these drivers to be unloaded even if
fbcon is still loaded.

Unless you use drivers that restores the display to text mode (rivafb and
i810fb, for example), detaching fbcon does require assistance from userspace
tools (ie, vbetools) for text mode to be restored completely.  Without the
help of these tools, fbcon will leave the VGA console corrupted. The methods
that can be used will be described in Documentation/fb/fbcon.txt.

Because the vt layer also increments the module reference count for each
console driver, fbcon cannot be directly unloaded.  It must be detached first
prior to unload.

Similarly, fbcon can be reattached to the console layer without having to
reload the module.  A nice feature if fbcon is compiled statically.

Attaching and detaching fbcon is done via sysfs attributes. A class device
entry for fbcon is created in /sys/class/graphics. The two attributes that
controls this feature are detach and attach. Two other attributes that are
piggybacked under /sys/class/graphics/fb[n] that are fbcon-specific,
'con_rotate' and 'con_rotate_all' are moved to fbcon.  They are renamed as
'rotate' and 'rotate_all' respectively.

Overall, this feature is a great help for developers working in the
framebuffer or console layer.  There is not need to continually reboot the
kernel for every small change. It is also useful for regular users who wants
to choose between a graphical console or a text console without having to
reboot.

Example usage for x86:

/* start in text mode */
modprobe xxxfb
modprobe fbcon
/* graphical mode with fbcon using xxxfb */
echo 1 > /sys/class/graphics/fbcon/detach
/* back to text mode, will produce corrupt display unless vbetool is used */
rmmod xxxfb
modprobe yyyfb
/* back to graphical mode with fbcon using yyyfb */

Before trying out this feature, please read Documentation/fb/fbcon.txt.





