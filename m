Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751192AbWFRPsi@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751192AbWFRPsi (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 18 Jun 2006 11:48:38 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751200AbWFRPsW
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 18 Jun 2006 11:48:22 -0400
Received: from py-out-1112.google.com ([64.233.166.177]:3219 "EHLO
	py-out-1112.google.com") by vger.kernel.org with ESMTP
	id S1751192AbWFRPsH (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 18 Jun 2006 11:48:07 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:user-agent:mime-version:to:cc:subject:content-type:content-transfer-encoding;
        b=BHVwitsibb+P+ncjQSzPUP/9zuyWBpdQIYomr9DYtNAV+U9Ls2EhFSEjfmdV3FP3K9i2E0LnsL88rI62ujN5euN/tFM9dhScbLSos9ZUPIRreS9yGcxDSS7p3K5L5t6VKTtN0e2jxqW4xMtoK3UT4JuWfOihMtKO35Use6U4T8Y=
Message-ID: <449570E1.9020904@gmail.com>
Date: Sun, 18 Jun 2006 23:27:29 +0800
From: "Antonino A. Daplas" <adaplas@gmail.com>
User-Agent: Thunderbird 1.5.0.4 (X11/20060516)
MIME-Version: 1.0
To: Andrew Morton <akpm@osdl.org>
CC: Linux Fbdev development list 
	<linux-fbdev-devel@lists.sourceforge.net>,
       Linux Kernel Development <linux-kernel@vger.kernel.org>,
       Greg KH <gregkh@suse.de>
Subject: [PATCH 5/9] VT binding: Update documentation
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Update Documentation/fb/fbcon.txt and Documentatin/console/console.txt to
reflect the following changes:

1. sysfs attributes are relocated to /sys/class/vtconsole

2. feature is selectable in Kconfig

3. add sample scripts to fbcon.txt

Signed-off-by: Antonino Daplas <adaplas@pol.net>
---

 Documentation/console/console.txt |   67 +++++++++++++++++++++++--------------
 Documentation/fb/fbcon.txt        |   67 ++++++++++++++++++++++++++++++++++---
 2 files changed, 103 insertions(+), 31 deletions(-)

diff --git a/Documentation/console/console.txt b/Documentation/console/console.txt
index 4f3f285..d3e1744 100644
--- a/Documentation/console/console.txt
+++ b/Documentation/console/console.txt
@@ -27,45 +27,62 @@ In newer kernels, the following are also
 	 register_con_driver()
 	 unregister_con_driver()
 
-If sysfs is enabled, the contents of /sys/class/tty/console/backend can be
-examined. This shows the console drivers currently registered by the system. On
-an x86 system with the framebuffer console enabled, the contents of this
-attribute may be like this:
+If sysfs is enabled, the contents of /sys/class/vtconsole can be
+examined. This shows the console backends currently registered by the
+system which are named vtcon<n> where <n> is an integer fro 0 to 15. Thus:
 
-cat /sys/class/tty/console/backend
-0 S: VGA+
-1 B: frame buffer device
+       ls /sys/class/vtconsole
+       .  ..  vtcon0  vtcon1
 
-The first line shows the VGA console driver, while the second line shows
-the framebuffer console driver.
+Each directory in /sys/class/vtconsole has 3 files:
 
-The leftmost numeric character is the driver ID.  The middle character with
-the colon describes the status of the driver.
+     ls /sys/class/vtconsole/vtcon0
+     .  ..  bind  name  uevent
 
-    S: - system driver (binding unspecified)
-    B: - bound modular driver
-    U: - unbound modular driver
+What do these files signify?
 
-The last column is the description of the driver.
+     1. bind - this is a read/write file. It shows the status of the driver if
+        read, or acts to bind or unbind the driver to the virtual consoles
+        when written to. The possible values are:
 
-Under /sys/class/tty/console are two other attributes, 'bind' and
-'unbind'. What does these 2 attributes do? As their name implies, echo'ing the
-driver ID to 'bind' will bind an unbound modular driver, and to 'unbind' will
-unbind a bound modular driver. Echo'ing the ID of a system driver to either
-attribute will do nothing.
+	0 - means the driver is not bound and if echo'ed, commands the driver
+	    to unbind
 
-Thus:
+        1 - means the driver is bound and if echo'ed, commands the driver to
+	    bind
 
-echo 1 > /sys/class/tty/console/unbind
-cat /sys/class/tty/console/backend
-0 S: VGA+
-1 U: frame buffer device
+     2. name - read-only file. Shows the name of the driver in this format:
+
+	cat /sys/class/vtconsole/vtcon0/name
+	(S) VGA+
+
+	    '(S)' stands for a (S)ystem driver, ie, it cannot be directly
+	    commanded to bind or unbind
+
+	    'VGA+' is the name of the driver
+
+	cat /sys/class/vtconsole/vtcon1/name
+	(M) frame buffer device
+
+	    In this case, '(M)' stands for a (M)odular driver, one that can be
+	    directly commanded to bind or unbind.
+
+     3. uevent - ignore this file
 
 When unbinding, the modular driver is detached first, and then the system
 driver takes over the consoles vacated by the driver. Binding, on the other
 hand, will bind the driver to the consoles that are currently occupied by a
 system driver.
 
+NOTE1: Binding and binding must be selected in Kconfig. It's under:
+
+Device Drivers -> Character devices -> Support for binding and unbinding
+console drivers
+
+NOTE2: If any of the virtual consoles are in KD_GRAPHICS mode, then binding or
+unbinding will not succeed. An example of an application that sets the console
+to KD_GRAPHICS is X.
+
 How useful is this feature? This is very useful for console driver
 developers. By unbinding the driver from the console layer, one can unload the
 driver, make changes, recompile, reload and rebind the driver without any need
diff --git a/Documentation/fb/fbcon.txt b/Documentation/fb/fbcon.txt
index b91aea5..b7b0a8c 100644
--- a/Documentation/fb/fbcon.txt
+++ b/Documentation/fb/fbcon.txt
@@ -180,10 +180,13 @@ fbcon.
 So, how do we unbind fbcon from the console? Part of the answer is in
 Documentation/console/console.txt. To summarize:
 
-Echo the ID number of the 'frame buffer driver' to:
+Echo a value to the bind file that represents the framebuffer console
+driver. So assuming vtcon1 represents fbcon, then:
 
-sys/class/tty/console/bind - attach framebuffer console to console layer
-sys/class/tty/console/unbind - detach framebuffer console from console layer
+echo 1 > sys/class/vtconsole/vtcon1/bind - attach framebuffer console to
+                                           console layer
+echo 0 > sys/class/vtconsole/vtcon1/bind - detach framebuffer console from
+                                           console layer
 
 If fbcon is detached from the console layer, your boot console driver (which is
 usually VGA text mode) will take over.  A few drivers (rivafb and i810fb) will
@@ -211,19 +214,21 @@ restored properly. The following is one 
 
 5. Now to detach fbcon:
 
+	Assuming vtcon1 represents fbcon, then:
+
        'cat /sys/class/tty/console/backend' and take note of the ID
 
 The above is probably needed only once. Then:
 
        vbetool vbestate restore < <vga state file> && \
-       echo <ID> > /sys/class/tty/console/unbind
+       echo 0 > /sys/class/vtconsole/vtcon1/bind
 
 6. That's it, you're back to VGA mode. And if you compiled fbcon as a module,
    you can unload it by 'rmmod fbcon'
 
 7. To reattach fbcon:
 
-       echo <ID> > /sys/class/tty/console/bind
+       echo 1 > /sys/class/vtconsole/vtcon1/bind
 
 8. Once fbcon is unbound, all drivers registered to the system will also
 become unbound.  This means that fbcon and individual framebuffer drivers
@@ -254,6 +259,8 @@ Variation 1:
     c. Attach fbcon
 
         vbetool vbestate restore < <vesa state file> && \
+	echo 1 > /sys/class/vtconsole/vtcon1/bind
+
 Variation 2:
 
     a. Before detaching fbcon, do:
@@ -269,7 +276,55 @@ Variation 2:
     c. Attach fbcon:
 
        vbetool vbemode set <mode number> && \
-	echo <ID> > /sys/class/tty/console/bind
+       echo 1 > /sys/class/vtconsole/vtcon1/bind
+
+Samples:
+========
+
+Here are 2 sample bash scripts that you can use to bind or unbind the
+framebuffer console driver if you are in an X86 box:
+
+---------------------------------------------------------------------------
+#!/bin/bash
+# Unbind fbcon
+
+# Change this to where your actual vgastate file is located
+# Or Use VGASTATE=$1 to indicate the state file at runtime
+VGASTATE=/tmp/vgastate
+
+# path to vbetool
+VBETOOL=/usr/local/bin
+
+
+for (( i = 0; i < 16; i++))
+do
+  if test -x /sys/class/vtconsole/vtcon$i; then
+      if [ `cat /sys/class/vtconsole/vtcon$i/name | grep -c "frame buffer"` \
+           = 1 ]; then
+	    if text -x $VBETOOL/vbetool; then
+	       echo Unbinding vtcon$i
+	       $VBETOOL/vbetool vbestate restore < $VGASTATE
+	       echo 0 > /sys/class/vtconsole/vtcon$i/bind
+	    fi
+      fi
+  fi
+done
+
+---------------------------------------------------------------------------
+#!/bin/bash
+# Bind fbcon
+
+for (( i = 0; i < 16; i++))
+do
+  if test -x /sys/class/vtconsole/vtcon$i; then
+      if [ `cat /sys/class/vtconsole/vtcon$i/name | grep -c "frame buffer"` \
+           = 1 ]; then
+	  echo Unbinding vtcon$i
+	  echo 1 > /sys/class/vtconsole/vtcon$i/bind
+      fi
+  fi
+done
+---------------------------------------------------------------------------
 
 --
 Antonino Daplas <adaplas@pol.net>

