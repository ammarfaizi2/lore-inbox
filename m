Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751403AbWILHWP@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751403AbWILHWP (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 12 Sep 2006 03:22:15 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751404AbWILHWP
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 12 Sep 2006 03:22:15 -0400
Received: from rwcrmhc15.comcast.net ([216.148.227.155]:33996 "EHLO
	rwcrmhc15.comcast.net") by vger.kernel.org with ESMTP
	id S1751403AbWILHWP (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 12 Sep 2006 03:22:15 -0400
Subject: sbpcd.c: fix check_region to request_region
From: Hil <ubuntu@comcast.net>
Reply-To: freehil@gmail.com
To: "Andrew J. Kroll" <ag784@freenet.sis.buffalo.edu>,
       kernel-janitor-discuss@lists.sourceforge.net,
       linux-kernel@vger.kernel.org
Cc: Eberhard Moenkeberg <emoenke@gwdg.de>
Content-Type: text/plain
Date: Tue, 12 Sep 2006 00:22:13 -0700
Message-Id: <1158045733.23931.16.camel@localhost>
Mime-Version: 1.0
X-Mailer: Evolution 2.6.1 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I looked at Linux Kernel Janitor project. There is a request of fixing
the old check_region function to request_region function. I did a grep
on the source tree and found several check_region. I will continue
fixing them after this patch is accepted. Please tell me if I'm doing
the submission correctly.

ChangeLog

- The file needs to be patched because it used deprecated check_region
function

- The check_region in the file simply checks if the region of memory is
available. I replaced that line with request_region followed by
release_region to make the check

- I do not have testing result available. I am sending this email to the
maintainer for testing. The maintainer probably has the specific CD-ROMs
to test my patch.

The kernel version for the patch is 2.6.18-rc6


--- linux-2.6.17/drivers/cdrom/sbpcd.c~	2006-09-11 14:19:53.000000000
-0700
+++ linux-2.6.17/drivers/cdrom/sbpcd.c	2006-09-11 23:47:48.000000000
-0700
@@ -5671,11 +5671,12 @@ int __init sbpcd_init(void)
 	{
 		addr[1]=sbpcd[port_index];
 		if (addr[1]==0) break;
-		if (check_region(addr[1],4))
+		if (!request_region(addr[1],4,major_name))
 		{
 			msg(DBG_INF,"check_region: %03X is not free.\n",addr[1]);
 			continue;
 		}
+		release_region(addr[1],4);
 		if (sbpcd[port_index+1]==2) type=str_sp;
 		else if (sbpcd[port_index+1]==1) type=str_sb;
 		else if (sbpcd[port_index+1]==3) type=str_t16;

Signed-off-by: Hil Liao <ubuntu@comcast.net>

