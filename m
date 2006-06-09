Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751452AbWFIIoL@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751452AbWFIIoL (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 9 Jun 2006 04:44:11 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751464AbWFIIoK
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 9 Jun 2006 04:44:10 -0400
Received: from py-out-1112.google.com ([64.233.166.181]:53780 "EHLO
	py-out-1112.google.com") by vger.kernel.org with ESMTP
	id S1751456AbWFIIoD (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 9 Jun 2006 04:44:03 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:user-agent:mime-version:to:cc:subject:content-type:content-transfer-encoding;
        b=UImec0gjLSlqrkJMJeeNG6W/8/bCA04olppKO2oV2/VmoVLYt13xIlgVoIUa+EV/29q5rJpYl32qh7IvnW6UQNJBICXNch/aiBIyoEwOOxdM+xbefcsgG5R7P+/v/gKjQN1fxeqkpMXHnjXfM9mGrVH0+kIG47Agmr2iVyDvHfs=
Message-ID: <44893407.4020507@gmail.com>
Date: Fri, 09 Jun 2006 16:40:39 +0800
From: "Antonino A. Daplas" <adaplas@gmail.com>
User-Agent: Thunderbird 1.5.0.4 (X11/20060516)
MIME-Version: 1.0
To: Andrew Morton <akpm@osdl.org>
CC: Linux Fbdev development list 
	<linux-fbdev-devel@lists.sourceforge.net>,
       Linux Kernel Development <linux-kernel@vger.kernel.org>
Subject: [PATCH 5/5] VT binding: Add new doc file describing the feature
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This newly added file will:

- Describe the characteristics of 2 general types of console drivers
- How to use the sysfs to unbind and bind console drivers
- Uses for this feature

Signed-off-by: Antonino Daplas <adaplas@pol.net>
---

 Documentation/console/console.txt |  127 +++++++++++++++++++++++++++++++++++++
 1 files changed, 127 insertions(+), 0 deletions(-)

diff --git a/Documentation/console/console.txt b/Documentation/console/console.txt
new file mode 100644
index 0000000..4f3f285
--- /dev/null
+++ b/Documentation/console/console.txt
@@ -0,0 +1,127 @@
+Console Drivers
+===============
+
+The linux kernel has 2 general types of console drivers.  The first type is
+assigned by the kernel to all the virtual consoles during the boot process.
+This type will be called 'system driver', and only one system driver is allowed
+to exist. The system driver is persistent and it can never be unloaded, though
+it may become inactive.
+
+The second type has to be explicitly loaded and unloaded. This will be called
+'modular driver' by this document. Multiple modular drivers can coexist at
+any time with each driver sharing the console with other drivers including
+the system driver. However, modular drivers cannot take over the console
+that is currently occupied by another modular driver. (Exception: Drivers that
+call take_over_console() will succeed in the takeover regardless of the type
+of driver occupying the consoles.) They can only take over the console that is
+occupied by the system driver. In the same token, if the modular driver is
+released by the console, the system driver will take over.
+
+Modular drivers, from the programmer's point of view, has to call:
+
+	 take_over_console() - load and bind driver to console layer
+	 give_up_console() - unbind and unload driver
+
+In newer kernels, the following are also available:
+
+	 register_con_driver()
+	 unregister_con_driver()
+
+If sysfs is enabled, the contents of /sys/class/tty/console/backend can be
+examined. This shows the console drivers currently registered by the system. On
+an x86 system with the framebuffer console enabled, the contents of this
+attribute may be like this:
+
+cat /sys/class/tty/console/backend
+0 S: VGA+
+1 B: frame buffer device
+
+The first line shows the VGA console driver, while the second line shows
+the framebuffer console driver.
+
+The leftmost numeric character is the driver ID.  The middle character with
+the colon describes the status of the driver.
+
+    S: - system driver (binding unspecified)
+    B: - bound modular driver
+    U: - unbound modular driver
+
+The last column is the description of the driver.
+
+Under /sys/class/tty/console are two other attributes, 'bind' and
+'unbind'. What does these 2 attributes do? As their name implies, echo'ing the
+driver ID to 'bind' will bind an unbound modular driver, and to 'unbind' will
+unbind a bound modular driver. Echo'ing the ID of a system driver to either
+attribute will do nothing.
+
+Thus:
+
+echo 1 > /sys/class/tty/console/unbind
+cat /sys/class/tty/console/backend
+0 S: VGA+
+1 U: frame buffer device
+
+When unbinding, the modular driver is detached first, and then the system
+driver takes over the consoles vacated by the driver. Binding, on the other
+hand, will bind the driver to the consoles that are currently occupied by a
+system driver.
+
+How useful is this feature? This is very useful for console driver
+developers. By unbinding the driver from the console layer, one can unload the
+driver, make changes, recompile, reload and rebind the driver without any need
+for rebooting the kernel. For regular users who may want to switch from
+framebuffer console to VGA console and vice versa, this feature also makes
+this possible. (NOTE NOTE NOTE: Please read fbcon.txt under Documentation/fb
+for more details).
+
+Notes for developers:
+=====================
+
+take_over_console() is now broken up into:
+
+     register_con_driver()
+     bind_con_driver() - private function
+
+give_up_console() is a wrapper to unregister_con_driver(), and a driver must
+be fully unbound for this call to succeed. con_is_bound() will check if the
+driver is bound or not.
+
+Guidelines for console driver writers:
+=====================================
+
+In order for binding to and unbinding from the console to properly work,
+console drivers must follow these guidelines:
+
+1. All drivers, except system drivers, must call either register_con_driver()
+   or take_over_console(). register_con_driver() will just add the driver to
+   the console's internal list. It won't take over the
+   console. take_over_console(), as it name implies, will also take over (or
+   bind to) the console.
+
+2. All resources allocated during con->con_init() must be released in
+   con->con_deinit().
+
+3. All resources allocated in con->con_startup() must be released when the
+   driver, which was previously bound, becomes unbound.  The console layer
+   does not have a complementary call to con->con_startup() so it's up to the
+   driver to check when it's legal to release these resources. Calling
+   con_is_bound() in con->con_deinit() will help.  If the call returned
+   false(), then it's safe to release the resources.  This balance has to be
+   ensured because con->con_startup() can be called again when a request to
+   rebind the driver to the console arrives.
+
+4. Upon exit of the driver, ensure that the driver is totally unbound. If the
+   condition is satisfied, then the driver must call unregister_con_driver()
+   or give_up_console().
+
+5. unregister_con_driver() can also be called on conditions which make it
+   impossible for the driver to service console requests.  This can happen
+   with the framebuffer console that suddenly lost all of its drivers.
+
+The current crop of console drivers should still work correctly, but binding
+and unbinding them may cause problems. With minimal fixes, these drivers can
+be made to work correctly.
+
+==========================
+Antonino Daplas <adaplas@pol.net>
+


