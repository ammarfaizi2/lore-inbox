Return-Path: <linux-kernel-owner+willy=40w.ods.org-S265246AbUFBXDF@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265246AbUFBXDF (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 2 Jun 2004 19:03:05 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265299AbUFBXDF
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 2 Jun 2004 19:03:05 -0400
Received: from mtvcafw.sgi.com ([192.48.171.6]:58099 "EHLO omx2.sgi.com")
	by vger.kernel.org with ESMTP id S265246AbUFBXC5 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 2 Jun 2004 19:02:57 -0400
Date: Wed, 2 Jun 2004 16:11:15 -0700
From: Paul Jackson <pj@sgi.com>
To: linux-kernel@vger.kernel.org
Cc: Andrew Morton <akpm@osdl.org>, Andi Kleen <ak@suse.de>
Subject: [PATCH] fix sys cpumap for > 352 NR_CPUS
Message-Id: <20040602161115.1340f698.pj@sgi.com>
Organization: SGI
X-Mailer: Sylpheed version 0.8.10claws (GTK+ 1.2.10; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Due to a bug in the 2.6 kernel, the cpumap files, such as:

  /sys/devices/system/node/node1/cpumap

only display the high order 352 CPUs.  If you compile a kernel with
NR_CPUS=512, such as SGI's Altix is usually compiled, then the low order
512-352 == 160 CPU positions are not shown.

This bug breaks Andi Kleens numactl and libnuma user code which depends
on this file presenting correctly.  Andi has reviewed this fix, and it
builds, boots and fixes the breakage (ia64 with sn2_defconfig).

Please apply the following patch (a hack, but better than the hack that
was there before).

Signed-off-by: Paul Jackson <pj@sgi.com>

===================================================================
--- 2.6.7-rc2-mm1-bitmapv6.orig/drivers/base/node.c 2004-06-02 02:04:12.000000000 -0700
+++ 2.6.7-rc2-mm1-bitmapv6/drivers/base/node.c	    2004-06-02 15:38:15.000000000 -0700
@@ -21,9 +21,21 @@ static ssize_t node_read_cpumap(struct s
 	cpumask_t mask = node_dev->cpumap;
 	int len;
 
-	/* FIXME - someone should pass us a buffer size (count) or
-	 * use seq_file or something to avoid buffer overrun risk. */
-	len = cpumask_scnprintf(buf, 99 /* XXX FIXME */, mask);
+	/*
+	 * Hack alert:
+	 * 1) This could overwrite a buffer w/o warning.  Someone should
+	 *     pass us a buffer size (count) or use seq_file or something
+	 *     to avoid buffer overrun risks.
+	 * 2) This can return a count larger than the read size requested
+	 *     by the user code - possibly confusing it.
+	 * 3) Following hardcodes that mask scnprintf format requires 9
+	 *     chars of output for each 32 bits of mask or fraction.
+	 * 4) Following prints stale node_dev->cpumap value, instead of
+	 *     evaluating afresh node_to_cpumask(node_dev->sysdev.id).
+	 * 5) Why does struct node even has the field cpumap.  Won't it
+	 *     just get stale, especially in the face of cpu hotplug?
+	 */
+	len = cpumask_scnprintf(buf, ((NR_CPUS+31)/32)*9 /* XXX FIXME */, mask);
 	len += sprintf(buf + len, "\n");
 	return len;
 }


-- 
                          I won't rest till it's the best ...
                          Programmer, Linux Scalability
                          Paul Jackson <pj@sgi.com> 1.650.933.1373
