Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261936AbVCHCUN@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261936AbVCHCUN (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 7 Mar 2005 21:20:13 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261284AbVCHCTK
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 7 Mar 2005 21:19:10 -0500
Received: from ipp23-131.piekary.net ([80.48.23.131]:61621 "EHLO spock.one.pl")
	by vger.kernel.org with ESMTP id S261776AbVCHCRL (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 7 Mar 2005 21:17:11 -0500
Date: Tue, 8 Mar 2005 03:17:06 +0100
From: Michal Januszewski <spock@gentoo.org>
To: linux-kernel@vger.kernel.org
Cc: linux-fbdev-devel@lists.sourceforge.net
Subject: [announce 7/7] fbsplash - documentation
Message-ID: <20050308021706.GH26249@spock.one.pl>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-2
Content-Disposition: inline
User-Agent: Mutt/1.5.8i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Signed-off-by: Michael Januszewski <spock@gentoo.org>

---
diff -Nru a/Documentation/fb/00-INDEX b/Documentation/fb/00-INDEX
--- a/Documentation/fb/00-INDEX	2005-03-07 16:50:34 +01:00
+++ b/Documentation/fb/00-INDEX	2005-03-07 16:50:34 +01:00
@@ -19,6 +19,8 @@
 	- info on the Matrox frame buffer driver
 pvr2fb.txt
 	- info on the PowerVR 2 frame buffer driver
+splash.txt
+	- info on the Framebuffer Splash
 tgafb.txt
 	- info on the TGA (DECChip 21030) frame buffer driver
 vesafb.txt
diff -Nru a/Documentation/fb/splash.txt b/Documentation/fb/splash.txt
--- /dev/null	Wed Dec 31 16:00:00 196900
+++ b/Documentation/fb/splash.txt	2005-03-07 16:50:34 +01:00
@@ -0,0 +1,207 @@
+What is it?
+-----------
+
+The framebuffer splash is a kernel feature that allows displaying a background
+picture on selected consoles.
+
+What do I need to get it to work?
+---------------------------------
+
+To get fb splash up-and-running you will have to:
+ 1) get a copy of splashutils [1] or a similar program
+ 2) get some splash themes
+ 3) build the kernel helper program
+ 4) build your kernel with the FB_SPLASH option enabled.
+
+To get fb splash operational right after fbcon initialization is finished, you
+will have to include a theme and the kernel helper into your initramfs image.
+Please refer to splashutils documentation for instructions on how to do that.
+
+[1] The splashutils package can be downloaded from:
+    http://dev.gentoo.org/~spock/projects/splashutils/
+
+The userspace helper
+--------------------
+
+The userspace splash helper (by default: /sbin/splash_helper) is called by the
+kernel whenever an important event occurs and the kernel needs some kind of
+job to be carried out. Important events include console switches and graphic
+mode switches (the kernel requests background images and configuration
+parameters for the current console). The splash helper must be accessible at 
+all times. If it's not, fbsplash will be switched off automatically.
+
+It's possible to set path to the splash helper by writing it to 
+/proc/sys/kernel/fbsplash.
+
+*****************************************************************************
+
+The information below is mostly technical stuff. There's probably no need to 
+read it unless you plan to develop a userspace helper.
+
+The splash protocol
+-------------------
+
+The splash protocol defines a communication interface between the kernel and 
+the userspace splash helper.
+
+The kernel side is responsible for:
+
+ o rendering console text, using an image as a background (instead of a
+   standard solid color fbcon uses),
+ o accepting commands from the user via ioctls on the fbsplash device,
+ o calling the userspace helper to set things up as soon as the fb subsystem 
+   is initialized.
+
+The userspace helper is responsible for everything else, including parsing
+configuration files, decompressing the image files whenever the kernel needs
+it, and communicating with the kernel if necessary.
+
+The splash protocol specifies how communication is done in both ways:
+kernel->userspace and userspace->helper.
+  
+Kernel -> Userspace
+-------------------
+
+The kernel communicates with the userspace helper by calling it and specifying
+the task to be done in a series of arguments.
+
+The arguments follow the pattern:
+<splash protocol version> <command> <parameters>
+
+All commands defined in splash protocol v2 have the following parameters:
+ virtual console
+ framebuffer number
+ theme
+
+Splash protocol v1 specified an additional 'fbsplash mode' after the 
+framebuffer number. Splash protocol v1 is deprecated and should not be used.
+
+Splash protocol v2 specifies the following commands:
+
+getpic
+------
+ The kernel issues this command to request image data. It's up to the userspace
+ helper to find a background image appropriate for the specified theme and the 
+ current resolution. The userspace helper should respond by issuing the
+ FBIOSPLASH_SETPIC ioctl.
+
+init
+----
+ The kernel issues this command after the fbsplash device is created and
+ the fbsplash interface is initialized. Upon receiving 'init', the userspace 
+ helper should parse the kernel command line (/proc/cmdline) or otherwise
+ decide whether fbsplash is to be activated. 
+
+ To activate fbsplash on the first console the helper should issue the
+ FBIOSPLASH_SETCFG, FBIOSPLASH_SETPIC and FBIOSPLASH_SETSTATE commands,
+ in the above-mentioned order.
+
+ When the userspace helper is called in an early phase of the boot process
+ (right after the initialization of fbcon), no filesystems will be mounted.
+ The helper program should mount sysfs and then create the appropriate 
+ framebuffer, fbsplash and tty0 devices (if they don't already exist) to get 
+ current display settings and to be able to communicate with the kernel side.
+ It should probably also mount the procfs to be able to parse the kernel 
+ command line parameters.
+
+ Note that the console sem is not held when the kernel calls splash_helper
+ with the 'init' command. The splash helper should perform all ioctls with
+ origin set to FB_SPLASH_IO_ORIG_USER.
+
+modechange
+----------
+ The kernel issues this command on a mode change. The helper's response should
+ be similar to the response to the 'init' command. Note that this time the
+ console sem is held and all ioctls must be performed with origin set to
+ FB_SPLASH_IO_ORIG_KERNEL.
+
+
+Userspace -> Kernel
+-------------------
+
+Userspace programs can communicate with fbsplash via ioctls on the fbsplash 
+device. These ioctls are to be used by both the userspace helper (called 
+only by the kernel) and userspace configuration tools (run by the users).
+
+The splash helper should set the origin field to FB_SPLASH_IO_ORIG_KERNEL 
+when doing the appropriate ioctls. All userspace configuration tools should 
+use FB_SPLASH_IO_ORIG_USER. Failure to set the appropriate value in the origin
+field when performing ioctls from the kernel helper will most likely result 
+in a console deadlock.
+
+FB_SPLASH_IO_ORIG_KERNEL instructs fbsplash not to try to acquire the console
+semaphore. Not surprisingly, FB_SPLASH_IO_ORIG_USER instructs it to acquire
+the console sem.
+
+The framebuffer splash provides the following ioctls (all defined in 
+linux/fb.h):
+
+FBIOSPLASH_SETPIC
+description: loads a background picture for a virtual console
+argument: struct fb_splash_iowrapper*; data: struct fb_image*
+notes: 
+If called for consoles other than the current foreground one, the picture data 
+will be ignored.
+
+If the current virtual console is running in a 8-bpp mode, the cmap substruct
+of fb_image has to be filled appropriately: start should be set to 16 (first 
+16 colors are reserved for fbcon), len to a value <= 240 and red, green and
+blue should point to valid cmap data. The transp field is ingored. The fields
+dx, dy, bg_color, fg_color in fb_image are ignored as well.
+
+FBIOSPLASH_SETCFG
+description: sets the fbsplash config for a virtual console
+argument: struct fb_splash_iowrapper*; data: struct vc_splash*
+notes: The structure has to be filled with valid data.
+
+FBIOSPLASH_GETCFG
+description: gets the fbsplash config for a virtual console
+argument: struct fb_splash_iowrapper*; data: struct vc_splash*
+
+FBIOSPLASH_SETSTATE
+description: sets the fbsplash state for a virtual console
+argument: struct fb_splash_iowrapper*; data: unsigned int*
+	  values: 0 = disabled, 1 = enabled.
+
+FBIOSPLASH_GETSTATE
+description: gets the fbsplash state for a virtual console
+argument: struct fb_splash_iowrapper*; data: unsigned int*
+          values: as in FBIOSPLASH_SETSTATE
+
+Info on used structures:
+
+Definition of struct vc_splash can be found in linux/console_splash.h. It's
+heavily commented. Note that the 'theme' field should point to a string
+no longer than FB_SPLASH_THEME_LEN. When FBIOSPLASH_GETCFG call is 
+performed, the theme field should point to a char buffer of length
+FB_SPLASH_THEME_LEN.
+
+Definition of struct fb_splash_iowrapper can be found in linux/fb.h.
+The fields in this struct have the following meaning:
+
+vc: 
+Virtual console number.
+
+origin: 
+Specifies if the ioctl is performed as a response to a kernel request. The
+splash helper should set this field to FB_SPLASH_IO_ORIG_KERNEL, userspace
+programs should set it to FB_SPLASH_IO_ORIG_USER. This field is necessary to
+avoid console semaphore deadlocks.
+
+data: 
+Pointer to a data structure appropriate for the performed ioctl. Type of
+the data struct is specified in the ioctls description.
+
+*****************************************************************************
+
+Credit
+------
+
+Original 'bootsplash' project & implementation by:
+  Volker Poplawski <volker@poplawski.de>, Stefan Reinauer <stepan@suse.de>,
+  Steffen Winterfeldt <snwint@suse.de>, Michael Schroeder <mls@suse.de>,
+  Ken Wimer <wimer@suse.de>.
+
+Fbsplash, splash protocol design, current implementation & docs by:
+  Michael Januszewski <spock@gentoo.org>
+




