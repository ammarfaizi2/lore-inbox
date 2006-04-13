Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964900AbWDMOEX@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964900AbWDMOEX (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 13 Apr 2006 10:04:23 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964943AbWDMOEX
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 13 Apr 2006 10:04:23 -0400
Received: from linux01.gwdg.de ([134.76.13.21]:10203 "EHLO linux01.gwdg.de")
	by vger.kernel.org with ESMTP id S964900AbWDMOEW (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 13 Apr 2006 10:04:22 -0400
Date: Thu, 13 Apr 2006 16:04:12 +0200 (MEST)
From: Jan Engelhardt <jengelh@linux01.gwdg.de>
To: Vishal Patil <vishpat@gmail.com>
cc: Jens Axboe <axboe@suse.de>, Antonio Vargas <windenntw@gmail.com>,
       Bill Davidsen <davidsen@tmr.com>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: CSCAN I/O scheduler for 2.6.10 kernel
In-Reply-To: <4745278c0604121653p68d7baf0uc3f8ebf952a4cb61@mail.gmail.com>
Message-ID: <Pine.LNX.4.61.0604131600540.17374@yvahk01.tjqt.qr>
References: <4745278c0603301955w26fea42eid6bcab91c573eaa3@mail.gmail.com> 
 <4745278c0603301958o4c2ed282x3513fdb459d8ec7c@mail.gmail.com> 
 <4432D6D4.2020102@tmr.com>  <4745278c0604041402n5c6329ebw71d7fdc5c3a9dd68@mail.gmail.com>
  <69304d110604050448x60fd5bb1ub74f66b720dc7d8a@mail.gmail.com> 
 <4745278c0604050646n668bc9fy2b8c18462439ae5d@mail.gmail.com> 
 <4745278c0604090955j2841ebacka990a90ffebc7841@mail.gmail.com> 
 <Pine.LNX.4.61.0604111334150.928@yvahk01.tjqt.qr>  <20060411113926.GD4791@suse.de>
  <Pine.LNX.4.61.0604111340550.928@yvahk01.tjqt.qr>
 <4745278c0604121653p68d7baf0uc3f8ebf952a4cb61@mail.gmail.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>Jan
>
>I am attaching a final CSCAN scheduler patch for the 2.6.16.2 kernel.
>The earlier patch that I had posted had a bug in the
>"cscan_merged_requests" function. This has been taken care of in the
>attached patch.  I would really appreciate if some one could help me
>in conducting performance tests for the attached patch.
>
>Many thanks for to all of you all for your inputs on this.

Looks good, and did not break so far.
At frst I was puzzled why it did not show up in menuconfig, and eventually 
I found out it was not assigned a name. Also allow building it as a module. 
Updated patch for the Kconfig.iosched file in block is below.

diff -Ndpru linux-2.6.17-rc1~/block/Kconfig.iosched linux-2.6.17-rc1-csc/block/Kconfig.iosched
--- linux-2.6.17-rc1~/block/Kconfig.iosched	2006-04-03 05:22:10.000000000 +0200
+++ linux-2.6.17-rc1-csc/block/Kconfig.iosched	2006-04-13 13:12:09.275805000 +0200
@@ -38,6 +38,19 @@ config IOSCHED_CFQ
 	  among all processes in the system. It should provide a fair
 	  working environment, suitable for desktop systems.
 
+config IOSCHED_CSCAN
+	tristate "CSCAN I/O scheduler"
+	default y
+	---help---
+        CSCAN I/O scheduler. Maintain two queues which will be sorted in
+        ascending order using Red Black Trees. When a disk request arrives and
+        if the block number it refers to is greater than the block number of the
+        current request being served add (merge) it to the first sorted queue or
+        else add (merge) it to the second sorted queue. Keep on servicing the
+        requests from the first request queue until it is empty after which
+        switch over to the second queue and now reverse the roles of the two
+        queues
+
 choice
 	prompt "Default I/O scheduler"
 	default DEFAULT_AS
@@ -54,6 +67,9 @@ choice
 	config DEFAULT_CFQ
 		bool "CFQ" if IOSCHED_CFQ=y
 
+	config DEFAULT_CSCAN
+		bool "CSCAN" if IOSCHED_CSCAN=y
+
 	config DEFAULT_NOOP
 		bool "No-op"
 
@@ -64,6 +80,7 @@ config DEFAULT_IOSCHED
 	default "anticipatory" if DEFAULT_AS
 	default "deadline" if DEFAULT_DEADLINE
 	default "cfq" if DEFAULT_CFQ
+	default "cscan" if DEFAULT_CSCAN
 	default "noop" if DEFAULT_NOOP
 
 endmenu
#<<eof>>


Jan Engelhardt
-- 
