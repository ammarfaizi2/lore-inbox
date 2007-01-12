Return-Path: <linux-kernel-owner+w=401wt.eu-S1160996AbXALFVB@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1160996AbXALFVB (ORCPT <rfc822;w@1wt.eu>);
	Fri, 12 Jan 2007 00:21:01 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1160997AbXALFVB
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 12 Jan 2007 00:21:01 -0500
Received: from smtp.osdl.org ([65.172.181.24]:33872 "EHLO smtp.osdl.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1160996AbXALFVA (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 12 Jan 2007 00:21:00 -0500
Date: Thu, 11 Jan 2007 21:20:39 -0800
From: Andrew Morton <akpm@osdl.org>
To: "Serge E. Hallyn" <serue@us.ibm.com>
Cc: lkml <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH -mm 7/8] user_ns: handle file sigio
Message-Id: <20070111212039.68e57e65.akpm@osdl.org>
In-Reply-To: <20070104181257.GH11377@sergelap.austin.ibm.com>
References: <20070104180635.GA11377@sergelap.austin.ibm.com>
	<20070104181257.GH11377@sergelap.austin.ibm.com>
X-Mailer: Sylpheed version 2.2.7 (GTK+ 2.8.17; x86_64-unknown-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 4 Jan 2007 12:12:57 -0600
"Serge E. Hallyn" <serue@us.ibm.com> wrote:

> A process in one user namespace could set a fowner and sigio on a file in a
> shared vfsmount, ending up killing a task in another user namespace.
> 
> Prevent this by adding a user namespace pointer to the fown_struct, and
> enforcing that a process causing a signal to be sent be in the same
> user namespace as the file owner.

This patch breaks the X server (stock FC5 install) with CONFIG_USER_NS=n. 
Neither the USB mouse nor the trackpad work.  They work OK under GPM.

Setting CONFIG_USER_NS=y "fixes" this.  This bug was not observed in
2.6.20-rc3-mm1 because that kernel had user-ns-always-on.patch for other
reasons.  (I'll restore that patch).

There's nothing very interesting here:


sony:/home/akpm> diff -u Xorg.0.log.good Xorg.0.log.bad          
--- Xorg.0.log.good     2007-01-11 21:11:11.000000000 -0800
+++ Xorg.0.log.bad      2007-01-11 21:17:31.000000000 -0800
@@ -6,7 +6,7 @@
 Release Date: 21 December 2005
 X Protocol Version 11, Revision 0, Release 7.0
 Build Operating System:Linux 2.6.9-22.18.bz155725.ELsmp i686Red Hat, Inc.
-Current Operating System: Linux sony 2.6.20-rc4-mm1 #15 Thu Jan 11 21:07:58 PST 2007 i686
+Current Operating System: Linux sony 2.6.20-rc4-mm1 #16 Thu Jan 11 21:14:03 PST 2007 i686
 Build Date: 22 March 2006
        Before reporting problems, check http://wiki.x.org
        to make sure that you have the latest version.
@@ -14,7 +14,7 @@
 Markers: (--) probed, (**) from config file, (==) default setting,
        (++) from command line, (!!) notice, (II) informational,
        (WW) warning, (EE) error, (NI) not implemented, (??) unknown.
-(==) Log file: "/var/log/Xorg.0.log", Time: Thu Jan 11 21:10:16 2007
+(==) Log file: "/var/log/Xorg.0.log", Time: Thu Jan 11 21:16:39 2007
 (==) Using config file: "/etc/X11/xorg.conf"
 (==) ServerLayout "single head configuration"
 (**) |-->Screen "Screen0" (0)
@@ -2117,9 +2117,9 @@
 (II) I810(0): Allocated 128 kB for the ring buffer at 0x0
 (II) I810(0): Allocating at least 256 scanlines for pixmap cache
 (II) I810(0): Initial framebuffer allocation size: 12288 kByte
-(II) I810(0): Allocated 4 kB for HW cursor at 0xffff000 (0x35dd3000)
-(II) I810(0): Allocated 16 kB for HW (ARGB) cursor at 0xfffb000 (0x35e78000)
-(II) I810(0): Allocated 4 kB for Overlay registers at 0xfffa000 (0x35e39000).
+(II) I810(0): Allocated 4 kB for HW cursor at 0xffff000 (0x358d5000)
+(II) I810(0): Allocated 16 kB for HW (ARGB) cursor at 0xfffb000 (0x35888000)
+(II) I810(0): Allocated 4 kB for Overlay registers at 0xfffa000 (0x358d7000).
 (II) I810(0): Allocated 64 kB for the scratch buffer at 0xffea000
 drmOpenDevice: node name is /dev/dri/card0
 drmOpenDevice: open result is -1, (No such device or address)
@@ -2137,8 +2137,8 @@
 (II) I810(0): [drm] loaded kernel module for "i915" driver
 (II) I810(0): [drm] DRM interface version 1.3
 (II) I810(0): [drm] created "i915" driver at busid "pci:0000:00:02.0"
-(II) I810(0): [drm] added 8192 byte SAREA at 0xf8e46000
-(II) I810(0): [drm] mapped SAREA 0xf8e46000 to 0xb7eec000
+(II) I810(0): [drm] added 8192 byte SAREA at 0xf8d4a000
+(II) I810(0): [drm] mapped SAREA 0xf8d4a000 to 0xb7f23000
 (II) I810(0): [drm] framebuffer handle = 0xc0020000
 (II) I810(0): [drm] added 1 reserved context for kernel
 (II) I810(0): Allocated 32 kB for the logical context at 0xffe2000.
