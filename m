Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261702AbTCLSsX>; Wed, 12 Mar 2003 13:48:23 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261884AbTCLSsX>; Wed, 12 Mar 2003 13:48:23 -0500
Received: from home.linuxhacker.ru ([194.67.236.68]:6561 "EHLO linuxhacker.ru")
	by vger.kernel.org with ESMTP id <S261702AbTCLSsW>;
	Wed, 12 Mar 2003 13:48:22 -0500
Date: Wed, 12 Mar 2003 21:58:06 +0300
From: Oleg Drokin <green@linuxhacker.ru>
To: scott.feldman@intel.com, alan@redhat.com, torvalds@transmeta.com,
       linux-kernel@vger.kernel.org
Subject: Memleak in e100 driver
Message-ID: <20030312185806.GA27489@linuxhacker.ru>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello!

    There is a memleak in e100 driver from intel, both in 2.4 and 2.5
    e100_ethtool_gstrings does not free "strings" variable if it cannot
    copy it to userspace.
    See the patch (identical for both 2.4 and 2.5).
    Found with help of smatch + enhanced unfree script.

Bye,
    Oleg

===== drivers/net/e100/e100_main.c 1.23 vs edited =====
--- 1.23/drivers/net/e100/e100_main.c	Sat Feb  1 22:38:18 2003
+++ edited/drivers/net/e100/e100_main.c	Wed Mar 12 21:50:32 2003
@@ -3824,11 +3824,15 @@
 		return -EOPNOTSUPP;
 	}
 
-	if (copy_to_user(ifr->ifr_data, &info, sizeof (info)))
+	if (copy_to_user(ifr->ifr_data, &info, sizeof (info))) {
+		kfree(strings);
 		return -EFAULT;
+	}
 
-	if (copy_to_user(usr_strings, strings, info.len * ETH_GSTRING_LEN))
+	if (copy_to_user(usr_strings, strings, info.len * ETH_GSTRING_LEN)) {
+		kfree(strings);
 		return -EFAULT;
+	}
 
 	kfree(strings);
 	return 0;
