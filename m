Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1757342AbWK0IHF@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757342AbWK0IHF (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 27 Nov 2006 03:07:05 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1757343AbWK0IHF
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 27 Nov 2006 03:07:05 -0500
Received: from arroyo.ext.ti.com ([192.94.94.40]:57756 "EHLO arroyo.ext.ti.com")
	by vger.kernel.org with ESMTP id S1757342AbWK0IHC convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 27 Nov 2006 03:07:02 -0500
X-MimeOLE: Produced By Microsoft Exchange V6.5
Content-class: urn:content-classes:message
MIME-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Subject: [2.6 PATCH] sysctl: String length calculated is wrong if it contains negative numbers
Date: Mon, 27 Nov 2006 13:36:54 +0530
Message-ID: <B2EAB41A1AF603458C6A01E3CC809C4402A65361@dbde01.ent.ti.com>
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
Thread-Topic: [2.6 PATCH] sysctl: String length calculated is wrong if it contains negative numbers
Thread-Index: AccR+wCkoQkrqx+aR8WmNKowofxyiw==
From: "BP, Praveen" <praveenbp@ti.com>
To: <linux-kernel@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi All,

In the functions do_proc_dointvec() and do_proc_doulongvec_minmax(),
there seems to be a bug in string length calculation if string contains
negative integer.

The console log given below explains the bug. Setting negative values
may not be a right thing to do for "console log level" but then the test
(given below) can be used to demonstrate the bug in the code. 

# echo "-1 -1 -1 -123456" > /proc/sys/kernel/printk
# cat /proc/sys/kernel/printk
-1      -1      -1      -1234
#
# echo "-1 -1 -1 123456" > /proc/sys/kernel/printk
# cat /proc/sys/kernel/printk
-1      -1      -1      1234
#

It works as expected if string contains all +ve integers

# echo "1 2 3 4" > /proc/sys/kernel/printk
# cat /proc/sys/kernel/printk
1       2       3       4
#

The patch given below fixes the issue.
Patch is generated against linux-2.6.18.3

Signed-off-by: Praveen BP <praveenbp@ti.com>

sysctl.c |    4 ++--
1 files changed, 2 insertions(+), 2 deletions(-)

--- a/kernel/sysctl.c	2006-11-19 08:58:22.000000000 +0530
+++ b/kernel/sysctl.c	2006-11-24 17:33:23.000000000 +0530
@@ -1748,7 +1748,7 @@
 			p = buf;
 			if (*p == '-' && left > 1) {
 				neg = 1;
-				left--, p++;
+				p++;
 			}
 			if (*p < '0' || *p > '9')
 				break;
@@ -1989,7 +1989,7 @@
 			p = buf;
 			if (*p == '-' && left > 1) {
 				neg = 1;
-				left--, p++;
+				p++;
 			}
 			if (*p < '0' || *p > '9')
 				break;



Thanks,
Praveen.
