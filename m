Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S131517AbRAAGW6>; Mon, 1 Jan 2001 01:22:58 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S131638AbRAAGWs>; Mon, 1 Jan 2001 01:22:48 -0500
Received: from freya.yggdrasil.com ([209.249.10.20]:58278 "EHLO
	freya.yggdrasil.com") by vger.kernel.org with ESMTP
	id <S131517AbRAAGWn>; Mon, 1 Jan 2001 01:22:43 -0500
Date: Sun, 31 Dec 2000 21:52:16 -0800
From: "Adam J. Richter" <adam@yggdrasil.com>
To: faith@valinux.com, linux-kernel@vger.kernel.org
Subject: Patch(?): linux-2.4.0-prerelease/drivers/char/drm/Makefile libdrm symbol versioning fix
Message-ID: <20001231215216.A17686@baldur.yggdrasil.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="FCuugMFkClbJLl1L"
Content-Disposition: inline
User-Agent: Mutt/1.2i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--FCuugMFkClbJLl1L
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

	There is a thread in linux-kernel about how somewhere in
linux-2.4.0-test13-preX, the Makefile for drivers/char/drm started
building libdrm.a and not versioning the symbols.  I believe the
following patch fixes the problem, but I have not tried it for the
nonmodular case.

	The change is that libdrm.o is built instead of libdrm.a.  This
object is linked into the kernel if at least one driver that needs it
is also linked into the kernel.  Otherwise, it is built as a helper
module which is automatically loaded by modprobe when a module that
needs it is loaded.  This change takes advantage of the new style
Makefile rules to achieve this end.  I think it basically is the
correct approach, although I have not yet tested compilation into
the kernel.

	Any testing and feedback would be appreciated.

-- 
Adam J. Richter     __     ______________   4880 Stevens Creek Blvd, Suite 104
adam@yggdrasil.com     \ /                  San Jose, California 95129-1034
+1 408 261-6630         | g g d r a s i l   United States of America
fax +1 408 261-6631      "Free Software For The Rest Of Us."

--FCuugMFkClbJLl1L
Content-Type: text/plain; charset=us-ascii
Content-Disposition: attachment; filename="drm.diff"

--- linux-2.4.0-prerelease/drivers/char/drm/Makefile	Fri Dec 29 14:07:21 2000
+++ linux/drivers/char/drm/Makefile	Fri Dec 22 01:50:11 2000
@@ -44,43 +44,37 @@
 mga-objs   := mga_drv.o   mga_dma.o     mga_context.o  mga_bufs.o  mga_state.o
 i810-objs  := i810_drv.o  i810_dma.o    i810_context.o i810_bufs.o
 
-obj-$(CONFIG_DRM_GAMMA) += gamma.o
-obj-$(CONFIG_DRM_TDFX)  += tdfx.o
-obj-$(CONFIG_DRM_R128)  += r128.o
-obj-$(CONFIG_DRM_FFB)   += ffb.o
-obj-$(CONFIG_DRM_MGA)   += mga.o
-obj-$(CONFIG_DRM_I810)  += i810.o
+obj-$(CONFIG_DRM_GAMMA) += gamma.o drmlib.o
+obj-$(CONFIG_DRM_TDFX)  += tdfx.o drmlib.o
+obj-$(CONFIG_DRM_R128)  += r128.o drmlib.o
+obj-$(CONFIG_DRM_FFB)   += ffb.o drmlib.o
+obj-$(CONFIG_DRM_MGA)   += mga.o drmlib.o
+obj-$(CONFIG_DRM_I810)  += i810.o drmlib.o
 
 
 # When linking into the kernel, link the library just once. 
 # If making modules, we include the library into each module
 
-ifdef MAKING_MODULES
-  lib = drmlib.a
-else
-  obj-y += drmlib.a
-endif
-
 include $(TOPDIR)/Rules.make
 
-drmlib.a: $(lib-objs)
+drmlib.o: $(lib-objs)
 	rm -f $@
-	$(AR) $(EXTRA_ARFLAGS) rcs $@ $(lib-objs)
+	$(LD) -r -o $@ $(lib-objs)
 
-gamma.o: $(gamma-objs) $(lib)
-	$(LD) -r -o $@ $(gamma-objs) $(lib)
+gamma.o: $(gamma-objs)
+	$(LD) -r -o $@ $(gamma-objs)
 
-tdfx.o: $(tdfx-objs) $(lib)
-	$(LD) -r -o $@ $(tdfx-objs) $(lib)
+tdfx.o: $(tdfx-objs)
+	$(LD) -r -o $@ $(tdfx-objs)
 
-mga.o: $(mga-objs) $(lib)
-	$(LD) -r -o $@ $(mga-objs) $(lib)
+mga.o: $(mga-objs)
+	$(LD) -r -o $@ $(mga-objs)
 
-i810.o: $(i810-objs) $(lib)
-	$(LD) -r -o $@ $(i810-objs) $(lib)
+i810.o: $(i810-objs)
+	$(LD) -r -o $@ $(i810-objs)
 
-r128.o: $(r128-objs) $(lib)
-	$(LD) -r -o $@ $(r128-objs) $(lib)
+r128.o: $(r128-objs)
+	$(LD) -r -o $@ $(r128-objs)
 
-ffb.o: $(ffb-objs) $(lib)
-	$(LD) -r -o $@ $(ffb-objs) $(lib)
+ffb.o: $(ffb-objs)
+	$(LD) -r -o $@ $(ffb-objs)

--FCuugMFkClbJLl1L--
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
