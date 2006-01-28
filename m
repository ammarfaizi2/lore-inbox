Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1422816AbWA1Cuz@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1422816AbWA1Cuz (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 27 Jan 2006 21:50:55 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751380AbWA1Cuz
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 27 Jan 2006 21:50:55 -0500
Received: from bsamwel.xs4all.nl ([82.92.179.183]:46755 "EHLO samwel.tk")
	by vger.kernel.org with ESMTP id S1751236AbWA1Cud (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 27 Jan 2006 21:50:33 -0500
Message-ID: <43DADB28.5020704@samwel.tk>
Date: Sat, 28 Jan 2006 03:47:04 +0100
From: Bart Samwel <bart@samwel.tk>
User-Agent: Thunderbird 1.5 (Windows/20051201)
MIME-Version: 1.0
To: Andrew Morton <akpm@osdl.org>
CC: linux-kernel@vger.kernel.org
Subject: [PATCH 3/3] Range checking in do_proc_dointvec_(userhz_)jiffies_conv
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
X-SA-Exim-Connect-IP: 127.0.0.1
X-SA-Exim-Mail-From: bart@samwel.tk
X-SA-Exim-Scanned: No (on samwel.tk); SAEximRunCond expanded to false
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


When (integer) sysctl values are in either seconds or centiseconds,
but represented internally as jiffies, the allowable value range
is decreased. This patch adds range checks to the conversion
routines.

For values in seconds: maximum LONG_MAX / HZ.

For values in centiseconds: maximum (LONG_MAX / HZ) * USER_HZ.


(BTW, does anyone else feel that an interface in seconds should not be
accepting negative values?)


Signed-off-by: Bart Samwel <bart@samwel.tk>


--- linux-2.6.16-rc1.orig/kernel/sysctl.c	2006-01-28 01:47:24.000000000 +0100
+++ linux-2.6.16-rc1/kernel/sysctl.c	2006-01-28 02:03:14.000000000 +0100
@@ -2008,6 +2008,8 @@
  					 int write, void *data)
  {
  	if (write) {
+		if (*lvalp > LONG_MAX / HZ)
+			return 1;		
  		*valp = *negp ? -(*lvalp*HZ) : (*lvalp*HZ);
  	} else {
  		int val = *valp;
@@ -2029,6 +2031,8 @@
  						int write, void *data)
  {
  	if (write) {
+		if (USER_HZ < HZ && *lvalp > (LONG_MAX / HZ) * USER_HZ)
+			return 1;
  		*valp = clock_t_to_jiffies(*negp ? -*lvalp : *lvalp);
  	} else {
  		int val = *valp;
