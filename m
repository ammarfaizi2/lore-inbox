Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263437AbUCTPSN (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 20 Mar 2004 10:18:13 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263441AbUCTPSN
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 20 Mar 2004 10:18:13 -0500
Received: from lindsey.linux-systeme.com ([62.241.33.80]:59914 "EHLO
	mx00.linux-systeme.com") by vger.kernel.org with ESMTP
	id S263437AbUCTPSJ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 20 Mar 2004 10:18:09 -0500
From: Marc-Christian Petersen <m.c.p@wolk-project.de>
To: lkml <linux-kernel@vger.kernel.org>
Subject: [PATCH 2.6.5-rc2] Add missing -EFAULT for sysctl
Date: Sat, 20 Mar 2004 16:17:04 +0100
User-Agent: KMail/1.6.1
Cc: Andrew Morton <akpm@osdl.org>, Linus Torvalds <torvalds@osdl.org>
X-Operating-System: Linux 2.6.4-wolk2.1 i686 GNU/Linux
MIME-Version: 1.0
Content-Disposition: inline
Organization: Working Overloaded Linux Kernel
Message-Id: <200403201617.04712@WOLK>
Content-Type: Multipart/Mixed;
  boundary="Boundary-00=_wBGXAcwiu1JTD4D"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--Boundary-00=_wBGXAcwiu1JTD4D
Content-Type: text/plain;
  charset="iso-8859-15"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

Hi Linus, Andrew,

Kernel 2.6 lacks two -EFAULT returns in get_user() in kernel/sysctl.c.

It's already fixed in 2.4 9 months ago, but I forgot to send it for 2.6.

It's basically this one:

http://linux.bkbits.net:8080/linux-2.4/diffs/kernel/sysctl.c@1.23?nav=index.html|
src/|src/kernel|hist/kernel/sysctl.c

Please apply.

ciao, Marc

--Boundary-00=_wBGXAcwiu1JTD4D
Content-Type: text/x-diff;
  charset="iso-8859-15";
  name="missing-EFAULT-sysctl.patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment;
	filename="missing-EFAULT-sysctl.patch"

--- old/kernel/sysctl.c	2004-03-20 15:53:22.000000000 +0100
+++ wolk-for-2.6/kernel/sysctl.c	2004-03-20 16:05:32.000000000 +0100
@@ -1107,7 +1107,8 @@ int do_sysctl_strategy (ctl_table *table
 	 * zero, proceed with automatic r/w */
 	if (table->data && table->maxlen) {
 		if (oldval && oldlenp) {
-			get_user(len, oldlenp);
+			if (get_user(len, oldlenp))
+				return -EFAULT;
 			if (len) {
 				if (len > table->maxlen)
 					len = table->maxlen;
@@ -1406,7 +1407,7 @@ int proc_dostring(ctl_table *table, int 
 		len = 0;
 		p = buffer;
 		while (len < *lenp) {
-			if(get_user(c, p++))
+			if (get_user(c, p++))
 				return -EFAULT;
 			if (c == 0 || c == '\n')
 				break;
@@ -1573,7 +1574,7 @@ static int do_proc_dointvec(ctl_table *t
 		p = (char *) buffer;
 		while (left) {
 			char c;
-			if(get_user(c, p++))
+			if (get_user(c, p++))
 				return -EFAULT;
 			if (!isspace(c))
 				break;
@@ -1808,7 +1809,7 @@ static int do_proc_doulongvec_minmax(ctl
 		p = (char *) buffer;
 		while (left) {
 			char c;
-			if(get_user(c, p++))
+			if (get_user(c, p++))
 				return -EFAULT;
 			if (!isspace(c))
 				break;
@@ -2033,7 +2034,7 @@ int sysctl_string(ctl_table *table, int 
 		return -ENOTDIR;
 	
 	if (oldval && oldlenp) {
-		if(get_user(len, oldlenp))
+		if (get_user(len, oldlenp))
 			return -EFAULT;
 		if (len) {
 			l = strlen(table->data);
@@ -2090,7 +2091,8 @@ int sysctl_intvec(ctl_table *table, int 
 
 		for (i = 0; i < length; i++) {
 			int value;
-			get_user(value, vec + i);
+			if (get_user(value, vec + i))
+				return -EFAULT;
 			if (min && value < min[i])
 				return -EINVAL;
 			if (max && value > max[i])

--Boundary-00=_wBGXAcwiu1JTD4D--
