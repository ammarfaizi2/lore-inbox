Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751108AbWDVTzz@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751108AbWDVTzz (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 22 Apr 2006 15:55:55 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751112AbWDVTzz
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 22 Apr 2006 15:55:55 -0400
Received: from zeus1.kernel.org ([204.152.191.4]:16069 "EHLO zeus1.kernel.org")
	by vger.kernel.org with ESMTP id S1751108AbWDVTzy (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 22 Apr 2006 15:55:54 -0400
Date: Fri, 21 Apr 2006 21:05:08 -0700 (PDT)
From: dean gaudet <dean@arctic.org>
To: linux-kernel@vger.kernel.org
cc: len.brown@intel.com
Subject: [PATCH] off-by-1 in kernel/power/main.c
Message-ID: <Pine.LNX.4.64.0604212055390.24100@twinlark.arctic.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

there's an off-by-1 in 2.6.16.9 (and 2.6.17-rc2) 
kernel/power/main.c:state_store() ... if your kernel just happens to have 
some non-zero data at pm_states[PM_SUSPEND_MAX] (i.e. one past the end of 
the array) then it'll let you write anything you want to /sys/power/state 
and in response the box will enter S5.

i randomly discovered this because i really wanted to put my box into S5 
(for wake on lan) and tried "echo off >/sys/power/state" and was quite 
happy that the box entered S5... happy until i compiled a different kernel 
and this S5 trick stopped working :)

anyhow, this begs the question, what is the correct way to get a box to 
shutdown into s5?  on a fc4 box i have here it does that happily, but 
ubuntu boxes don't seem to go into s5... and i couldn't figure out from 
fc4 patches if they'd changed anything in this area.  pointers 
appreciated.

btw i can whip up a patch making "off" a valid value for /sys/power/state 
...

-dean

Signed-off-by: dean gaudet <dean@arctic.org>

--- linux/kernel/power/main.c.orig	2006-03-19 21:53:29.000000000 -0800
+++ linux/kernel/power/main.c	2006-04-21 20:54:12.000000000 -0700
@@ -272,7 +272,7 @@
 		if (*s && !strncmp(buf, *s, len))
 			break;
 	}
-	if (*s)
+	if (state < PM_SUSPEND_MAX && *s)
 		error = enter_state(state);
 	else
 		error = -EINVAL;
