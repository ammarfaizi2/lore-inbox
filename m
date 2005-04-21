Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261278AbVDULEh@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261278AbVDULEh (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 21 Apr 2005 07:04:37 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261280AbVDULEh
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 21 Apr 2005 07:04:37 -0400
Received: from gprs189-60.eurotel.cz ([160.218.189.60]:49793 "EHLO amd.ucw.cz")
	by vger.kernel.org with ESMTP id S261278AbVDULEZ (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 21 Apr 2005 07:04:25 -0400
Date: Thu, 21 Apr 2005 13:03:36 +0200
From: Pavel Machek <pavel@ucw.cz>
To: Andrew Morton <akpm@zip.com.au>,
       kernel list <linux-kernel@vger.kernel.org>
Subject: [patch] swsusp: documentation updates
Message-ID: <20050421110336.GA12292@elf.ucw.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Warning: Reading this can be dangerous to your mental health.
User-Agent: Mutt/1.5.6+20040907i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


This updates documentation and fixes pointers in MAINTAINERS file.

Signed-off-by: Pavel Machek <pavel@suse.cz>

--- clean/Documentation/power/swsusp.txt	2005-01-22 21:24:50.000000000 +0100
+++ linux/Documentation/power/swsusp.txt	2005-04-17 21:06:32.000000000 +0200
@@ -164,11 +171,11 @@
 should be held at that point and it must be safe to sleep there), and
 add:
 
-            if (current->flags & PF_FREEZE)
-                    refrigerator(PF_FREEZE);
+	try_to_freeze(PF_FREEZE);
 
 If the thread is needed for writing the image to storage, you should
-instead set the PF_NOFREEZE process flag when creating the thread.
+instead set the PF_NOFREEZE process flag when creating the thread (and
+be very carefull).
 
 
 Q: What is the difference between between "platform", "shutdown" and
@@ -233,3 +240,81 @@
 cat `cat /proc/[0-9]*/maps | grep / | sed 's:.* /:/:' | sort -u` > /dev/null
 
 after resume. swapoff -a; swapon -a may also be usefull.
+
+Q: What happens to devices during swsusp? They seem to be resumed
+during system suspend?
+
+A: That's correct. We need to resume them if we want to write image to
+disk. Whole sequence goes like
+
+      Suspend part
+      ~~~~~~~~~~~~
+      running system, user asks for suspend-to-disk
+
+      user processes are stopped
+      
+      suspend(PMSG_FREEZE): devices are frozen so that they don't interfere
+      		      with state snapshot
+		
+      state snapshot: copy of whole used memory is taken with interrupts disabled
+      
+      resume(): devices are woken up so that we can write image to swap
+      
+      write image to swap
+      
+      suspend(PMSG_SUSPEND): suspend devices so that we can power off
+      
+      turn the power off
+      
+      Resume part
+      ~~~~~~~~~~~
+      (is actually pretty similar)
+      
+      running system, user asks for suspend-to-disk
+      
+      user processes are stopped (in common case there are none, but with resume-from-initrd, noone knows)
+      
+      read image from disk
+      
+      suspend(PMSG_FREEZE): devices are frozen so that they don't interfere
+      		      with image restoration
+		
+      image restoration: rewrite memory with image
+      
+      resume(): devices are woken up so that system can continue
+      
+      thaw all user processes
+
+Q: What is this 'Encrypt suspend image' for?
+
+A: First of all: it is not a replacement for dm-crypt encrypted swap.
+It cannot protect your computer while it is suspended. Instead it does
+protect from leaking sensitive data after resume from suspend.
+
+Think of the following: you suspend while an application is running
+that keeps sensitive data in memory. The application itself prevents
+the data from being swapped out. Suspend, however, must write these
+data to swap to be able to resume later on. Without suspend encryption
+your sensitive data are then stored in plaintext on disk.  This means
+that after resume your sensitive data are accessible to all
+applications having direct access to the swap device which was used
+for suspend. If you don't need swap after resume these data can remain
+on disk virtually forever. Thus it can happen that your system gets
+broken in weeks later and sensitive data which you thought were
+encrypted and protected are retrieved and stolen from the swap device.
+To prevent this situation you should use 'Encrypt suspend image'.
+
+During suspend a temporary key is created and this key is used to
+encrypt the data written to disk. When, during resume, the data was
+read back into memory the temporary key is destroyed which simply
+means that all data written to disk during suspend are then
+inaccessible so they can't be stolen later on.  The only thing that
+you must then take care of is that you call 'mkswap' for the swap
+partition used for suspend as early as possible during regular
+boot. This asserts that any temporary key from an oopsed suspend or
+from a failed or aborted resume is erased from the swap device.
+
+As a rule of thumb use encrypted swap to protect your data while your
+system is shut down or suspended. Additionally use the encrypted
+suspend image to prevent sensitive data from being stolen after
+resume.
--- clean/MAINTAINERS	2005-04-21 12:00:27.000000000 +0200
+++ linux/MAINTAINERS	2005-04-21 12:02:36.000000000 +0200
@@ -2090,9 +2090,7 @@
 SOFTWARE SUSPEND:
 P:	Pavel Machek
 M:	pavel@suse.cz
-M:	pavel@ucw.cz
-L:	http://lister.fornax.hu/mailman/listinfo/swsusp
-W:	http://swsusp.sf.net/
+L:	linux-pm@osdl.org
 S:	Maintained
 
 SONIC NETWORK DRIVER

-- 
Boycott Kodak -- for their patent abuse against Java.
