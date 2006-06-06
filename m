Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751237AbWFFLLk@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751237AbWFFLLk (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 6 Jun 2006 07:11:40 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751241AbWFFLLk
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 6 Jun 2006 07:11:40 -0400
Received: from wx-out-0102.google.com ([66.249.82.198]:53140 "EHLO
	wx-out-0102.google.com") by vger.kernel.org with ESMTP
	id S1751233AbWFFLLU (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 6 Jun 2006 07:11:20 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:user-agent:mime-version:to:cc:subject:content-type:content-transfer-encoding;
        b=AbDV0uqG93cRiJGj8ID7t2pMGbYfcMsuFVvpIEgYSpbhSd+Nzf73oiWCcTWb/efFvQj5WNSWZDhGs138Wz72xpnrfcIno6hNbGUDf5eXlcN+v+Cu4JcxWij6eVXeM5Uep3EPZCQ2Z7xbNpfRWpPO6aC2LdjV3OxDhz5H417algM=
Message-ID: <44856251.6050909@gmail.com>
Date: Tue, 06 Jun 2006 19:09:05 +0800
From: "Antonino A. Daplas" <adaplas@gmail.com>
User-Agent: Thunderbird 1.5.0.4 (X11/20060516)
MIME-Version: 1.0
To: Andrew Morton <akpm@osdl.org>
CC: Linux Fbdev development list 
	<linux-fbdev-devel@lists.sourceforge.net>,
       Linux Kernel Development <linux-kernel@vger.kernel.org>
Subject: [PATCH 7/7] Detaching fbcon: Update documentation
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Update Documentation/fb/fbcon.txt on the following:

1. sysfs attributes are now located in class/graphics/fbcon
2. instructions on how to attach, detach and/or unload fbcon

Signed-off-by: Antonino Daplas <adaplas@pol.net>
---

 Documentation/fb/fbcon.txt |  104 ++++++++++++++++++++++++++++++++++++++++++--
 1 files changed, 100 insertions(+), 4 deletions(-)

diff --git a/Documentation/fb/fbcon.txt b/Documentation/fb/fbcon.txt
index 08dce0f..f3a3be0 100644
--- a/Documentation/fb/fbcon.txt
+++ b/Documentation/fb/fbcon.txt
@@ -135,10 +135,10 @@ C. Boot options
 
 	The angle can be changed anytime afterwards by 'echoing' the same
 	numbers to any one of the 2 attributes found in
-	/sys/class/graphics/fb{x}
+	 /sys/class/graphics/fbcon
 
-		con_rotate     - rotate the display of the active console
-		con_rotate_all - rotate the display of all consoles
+		rotate     - rotate the display of the active console
+		rotate_all - rotate the display of all consoles
 
 	Console rotation will only become available if Console Rotation
 	Support is compiled in your kernel.
@@ -148,5 +148,101 @@ C. Boot options
 	Actually, the underlying fb driver is totally ignorant of console
 	rotation.
 
----
+C. Attaching, Detaching and Unloading
+
+It's possible to detach/attach the framebuffer console from the vt layer by
+echoing anything to the following sysfs attributes found
+/sys/class/graphics/fbcon.
+
+	   attach - attach framebuffer console to vt layer
+	   detach - detach framebuffer console to vt layer
+
+If fbcon is detached from the vt layer, your boot console driver (which is
+usually VGA text mode) will take over.  A few drivers (rivafb and i810fb) will
+restore VGA text mode for you.  With the rest, before detaching fbcon, you
+must take a few additional steps to make sure that your VGA text mode is
+restored properly. The following is one of the several methods that you can do:
+
+1. Download or install vbetool.  This utility is included with most
+   distributions nowadays, and is usually part of the suspend/resume tool.
+
+2. In your kernel configuration, ensure that CONFIG_FRAMEBUFFER_CONSOLE is set
+   to 'y' or 'm'. Enable one or more of your favorite framebuffer drivers.
+
+3. Boot into text mode and as root run:
+
+	vbetool vbestate save > <vga state file>
+
+	The above command saves the register contents of your graphics
+	hardware to <vga state file>.  You need to do this step only once as
+	the state file can be reused.
+
+4. If fbcon is compiled as a module, load fbcon by doing:
+
+       modprobe fbcon
+
+5. Now to detach fbcon:
+
+       vbetool vbestate restore < <vga state file> && \
+       echo 1 > /sys/class/graphics/fbcon/detach
+
+6. That's it, you're back to VGA mode. And if you compiled your drivers as
+   modules, you can unload them at will.  So if you want to change your driver
+   from xxxfb to yyyfb, you can do this:
+
+	detach fbcon
+	rmmod xxxfb
+	modprobe yyyfb
+
+	Of course, con2fbmap can do the same thing but will not work if xxxfb
+	and yyyfb are not compatible (ie, cannot be loaded at the same time).
+
+7. To reattach fbcon:
+
+       echo 1 > /sys/class/graphics/fbcon/attach
+
+8. Once the framebuffer console is detached, and if it is compiled as a module,
+the module can be unloaded with 'rmmod fbcon'.  This feature is great for
+developers.
+
+Notes for vesafb users:
+=======================
+
+Unfortunately, if your bootline includes a vga=xxx parameter that sets the
+hardware in graphics mode, such as when loading vesafb, vgacon will not load.
+Instead, vgacon will replace the default boot console with dummycon, and you
+won't get any display after detaching fbcon. Your machine is still alive, so
+you can reattach vesafb. However, to reattach vesafb, you need to do one of
+the following:
+
+Variation 1:
+
+    a. Before detaching fbcon, do
+
+       vbetool vbemode save > <vesa state file> # do once for each vesafb mode,
+						# the file can be reused
+
+    b. Detach fbcon as in step 5.
+
+    c. Attach fbcon
+
+        vbetool vbestate restore < <vesa state file> && \
+	echo 1 > /sys/class/graphics/fbcon/attach
+
+Variation 2:
+
+    a. Before detaching fbcon, do:
+
+       vbetool vbemode get
+
+    b. Take note of the mode number
+
+    b. Detach fbcon as in step 5.
+
+    c. Attach fbcon:
+
+       vbetool vbemode set <mode number> && \
+       echo 1 > /sys/class/graphics/fbcon/attach
+
+--
 Antonino Daplas <adaplas@pol.net>




