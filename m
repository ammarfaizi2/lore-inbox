Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261184AbVALNVH@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261184AbVALNVH (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 12 Jan 2005 08:21:07 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261180AbVALNVH
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 12 Jan 2005 08:21:07 -0500
Received: from gprs214-158.eurotel.cz ([160.218.214.158]:1005 "EHLO amd.ucw.cz")
	by vger.kernel.org with ESMTP id S261184AbVALNTK (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 12 Jan 2005 08:19:10 -0500
Date: Wed, 12 Jan 2005 14:18:54 +0100
From: Pavel Machek <pavel@ucw.cz>
To: Andrew Morton <akpm@zip.com.au>,
       kernel list <linux-kernel@vger.kernel.org>
Subject: swsusp: update docs
Message-ID: <20050112131854.GA1543@elf.ucw.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Warning: Reading this can be dangerous to your mental health.
User-Agent: Mutt/1.5.6+20040907i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!

This updates swsusp documentation. Please apply,

Signed-off-by: Pavel Machek <pavel@ucw.cz>
								Pavel


--- clean/Documentation/power/swsusp.txt	2004-12-25 13:34:57.000000000 +0100
+++ linux/Documentation/power/swsusp.txt	2005-01-12 10:57:23.000000000 +0100
@@ -15,6 +15,9 @@
  * If you change kernel command line between suspend and resume...
  *			        ...prepare for nasty fsck or worse.
  *
+ * If you change your hardware while system is suspended...
+ *			        ...well, it was not good idea.
+ *
  * (*) suspend/resume support is needed to make it safe.
 
 You need to append resume=/dev/your_swap_partition to kernel command
@@ -183,3 +186,50 @@
 
 "platform" is actually right thing to do, but "shutdown" is most
 reliable.
+
+Q: I do not understand why you have such strong objections to idea of
+selective suspend.
+
+A: Do selective suspend during runtime power managment, that's okay. But
+its useless for suspend-to-disk. (And I do not see how you could use
+it for suspend-to-ram, I hope you do not want that).
+
+Lets see, so you suggest to
+
+* SUSPEND all but swap device and parents
+* Snapshot
+* Write image to disk
+* SUSPEND swap device and parents
+* Powerdown
+
+Oh no, that does not work, if swap device or its parents uses DMA,
+you've corrupted data. You'd have to do
+
+* SUSPEND all but swap device and parents
+* FREEZE swap device and parents
+* Snapshot
+* UNFREEZE swap device and parents
+* Write
+* SUSPEND swap device and parents
+
+Which means that you still need that FREEZE state, and you get more
+complicated code. (And I have not yet introduce details like system
+devices).
+
+Q: There don't seem to be any generally useful behavioral
+distinctions between SUSPEND and FREEZE.
+
+A: Doing SUSPEND when you are asked to do FREEZE is always correct,
+but it may be unneccessarily slow. If you want USB to stay simple,
+slowness may not matter to you. It can always be fixed later.
+
+For devices like disk it does matter, you do not want to spindown for
+FREEZE.
+
+Q: After resuming, system is paging heavilly, leading to very bad interactivity.
+
+A: Try running
+
+cat `cat /proc/[0-9]*/maps | grep / | sed 's:.* /:/:' | sort -u` > /dev/null
+
+after resume. swapoff -a; swapon -a may also be usefull.

-- 
People were complaining that M$ turns users into beta-testers...
...jr ghea gurz vagb qrirybcref, naq gurl frrz gb yvxr vg gung jnl!
