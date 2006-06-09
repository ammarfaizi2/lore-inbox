Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964838AbWFIIoU@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964838AbWFIIoU (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 9 Jun 2006 04:44:20 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932188AbWFIIoM
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 9 Jun 2006 04:44:12 -0400
Received: from py-out-1112.google.com ([64.233.166.180]:59923 "EHLO
	py-out-1112.google.com") by vger.kernel.org with ESMTP
	id S1751455AbWFIInx (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 9 Jun 2006 04:43:53 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:user-agent:mime-version:to:cc:subject:content-type:content-transfer-encoding;
        b=By8jZQJnTCVCsQHmO4CatblgyFrCcsweBdNq2AMBaXaxKid0Mhg7YzHmyFkOJ7Ky/qTnkux6iJHV3SzSe38KHaFvu9HGi6D1BN5LxZ8PVBU7UUT7uRqmEmglnPU9OM38kJAA+pbe+cVlIXvmArF49J6cMDzKz3Xd3kwsS+plBmU=
Message-ID: <448933F7.5080605@gmail.com>
Date: Fri, 09 Jun 2006 16:40:23 +0800
From: "Antonino A. Daplas" <adaplas@gmail.com>
User-Agent: Thunderbird 1.5.0.4 (X11/20060516)
MIME-Version: 1.0
To: Andrew Morton <akpm@osdl.org>
CC: Linux Fbdev development list 
	<linux-fbdev-devel@lists.sourceforge.net>,
       Linux Kernel Development <linux-kernel@vger.kernel.org>
Subject: [PATCH 4/5] VT binding: fbcon: Update documentation
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Update Documentation/fb/fbcon.txt to reflect the following changes:

1. Simple illustration of the binding of the console down to individual
framebuffer drivers

2. Usage of userspace tools to help with recovery of text console

3. How to use the attributes in /sys/class/tty/console to unload fbcon
and the framebuffer drivers

Signed-off-by: Antonino Daplas <adaplas@pol.net>
---

 Documentation/fb/fbcon.txt |   73 ++++++++++++++++++++++++++++++--------------
 1 files changed, 50 insertions(+), 23 deletions(-)

diff --git a/Documentation/fb/fbcon.txt b/Documentation/fb/fbcon.txt
index f3a3be0..b91aea5 100644
--- a/Documentation/fb/fbcon.txt
+++ b/Documentation/fb/fbcon.txt
@@ -150,14 +150,42 @@ C. Boot options
 
 C. Attaching, Detaching and Unloading
 
-It's possible to detach/attach the framebuffer console from the vt layer by
-echoing anything to the following sysfs attributes found
-/sys/class/graphics/fbcon.
+Before going on on how to attach, detach and unload the framebuffer console, an
+illustration of the dependencies may help.
 
-	   attach - attach framebuffer console to vt layer
-	   detach - detach framebuffer console to vt layer
+The console layer, as with most subsystems, needs a driver that interfaces with
+the hardware. Thus, in a VGA console:
 
-If fbcon is detached from the vt layer, your boot console driver (which is
+console ---> VGA driver ---> hardware.
+
+Assuming the VGA driver can be unloaded, one must first unbind the VGA driver
+from the console layer before unloading the driver.  The VGA driver cannot be
+unloaded if it is still bound to the console layer. (See
+Documentation/console/console.txt for more information).
+
+This is more complicated in the case of the the framebuffer console (fbcon),
+because fbcon is an intermediate layer between the console and the drivers:
+
+console ---> fbcon ---> fbdev drivers ---> hardware
+
+The fbdev drivers cannot be unloaded if it's bound to fbcon, and fbcon cannot
+be unloaded if it's bound to the console layer.
+
+So to unload the fbdev drivers, one must first unbind fbcon from the console,
+then unbind the fbdev drivers from fbcon.  Fortunately, unbinding fbcon from
+the console layer will automatically unbind framebuffer drivers from
+fbcon. Thus, there is no need to explicitly unbind the fbdev drivers from
+fbcon.
+
+So, how do we unbind fbcon from the console? Part of the answer is in
+Documentation/console/console.txt. To summarize:
+
+Echo the ID number of the 'frame buffer driver' to:
+
+sys/class/tty/console/bind - attach framebuffer console to console layer
+sys/class/tty/console/unbind - detach framebuffer console from console layer
+
+If fbcon is detached from the console layer, your boot console driver (which is
 usually VGA text mode) will take over.  A few drivers (rivafb and i810fb) will
 restore VGA text mode for you.  With the rest, before detaching fbcon, you
 must take a few additional steps to make sure that your VGA text mode is
@@ -183,27 +211,26 @@ restored properly. The following is one 
 
 5. Now to detach fbcon:
 
-       vbetool vbestate restore < <vga state file> && \
-       echo 1 > /sys/class/graphics/fbcon/detach
+       'cat /sys/class/tty/console/backend' and take note of the ID
 
-6. That's it, you're back to VGA mode. And if you compiled your drivers as
-   modules, you can unload them at will.  So if you want to change your driver
-   from xxxfb to yyyfb, you can do this:
+The above is probably needed only once. Then:
 
-	detach fbcon
-	rmmod xxxfb
-	modprobe yyyfb
+       vbetool vbestate restore < <vga state file> && \
+       echo <ID> > /sys/class/tty/console/unbind
 
-	Of course, con2fbmap can do the same thing but will not work if xxxfb
-	and yyyfb are not compatible (ie, cannot be loaded at the same time).
+6. That's it, you're back to VGA mode. And if you compiled fbcon as a module,
+   you can unload it by 'rmmod fbcon'
 
 7. To reattach fbcon:
 
-       echo 1 > /sys/class/graphics/fbcon/attach
+       echo <ID> > /sys/class/tty/console/bind
 
-8. Once the framebuffer console is detached, and if it is compiled as a module,
-the module can be unloaded with 'rmmod fbcon'.  This feature is great for
-developers.
+8. Once fbcon is unbound, all drivers registered to the system will also
+become unbound.  This means that fbcon and individual framebuffer drivers
+can be unloaded or reloaded at will. Reloading the drivers or fbcon will
+automatically bind the console, fbcon and the drivers together. Unloading
+all the drivers without unloading fbcon will make it impossible for the
+console to bind fbcon.
 
 Notes for vesafb users:
 =======================
@@ -227,11 +254,11 @@ Variation 1:
     c. Attach fbcon
 
         vbetool vbestate restore < <vesa state file> && \
-	echo 1 > /sys/class/graphics/fbcon/attach
-
 Variation 2:
 
     a. Before detaching fbcon, do:
+	echo <ID> > /sys/class/tty/console/bind
+
 
        vbetool vbemode get
 
@@ -242,7 +269,7 @@ Variation 2:
     c. Attach fbcon:
 
        vbetool vbemode set <mode number> && \
-       echo 1 > /sys/class/graphics/fbcon/attach
+	echo <ID> > /sys/class/tty/console/bind
 
 --
 Antonino Daplas <adaplas@pol.net>



