Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262870AbUJ2EYY@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262870AbUJ2EYY (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 29 Oct 2004 00:24:24 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262882AbUJ2EYY
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 29 Oct 2004 00:24:24 -0400
Received: from umhlanga.stratnet.net ([12.162.17.40]:32985 "EHLO
	umhlanga.STRATNET.NET") by vger.kernel.org with ESMTP
	id S262870AbUJ2EYT (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 29 Oct 2004 00:24:19 -0400
To: kladit@t-online.de (Klaus Dittrich), greg@kroah.com
Cc: linux mailing-list <linux-kernel@vger.kernel.org>
X-Message-Flag: Warning: May contain useful information
References: <20041027115943.GA1674@xeon2.local.here>
From: Roland Dreier <roland@topspin.com>
Date: Thu, 28 Oct 2004 21:24:15 -0700
In-Reply-To: <20041027115943.GA1674@xeon2.local.here> (Klaus Dittrich's
 message of "Wed, 27 Oct 2004 13:59:43 +0200")
Message-ID: <52pt32ywwg.fsf@topspin.com>
User-Agent: Gnus/5.1006 (Gnus v5.10.6) XEmacs/21.4 (Security Through
 Obscurity, linux)
MIME-Version: 1.0
X-SA-Exim-Connect-IP: <locally generated>
X-SA-Exim-Mail-From: roland@topspin.com
Subject: [PATCH] kobject hotplug: don't let SEQNUM overwrite other vars (was
 Re: usb hotplug $DEVICE empty)
Content-Type: text/plain; charset=us-ascii
X-SA-Exim-Version: 4.1 (built Tue, 17 Aug 2004 11:06:07 +0200)
X-SA-Exim-Scanned: Yes (on eddore)
X-OriginalArrivalTime: 29 Oct 2004 04:24:16.0658 (UTC) FILETIME=[27007F20:01C4BD6F]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I think this trivial patch should fix this for you.  (Greg, not sure
if you have this already -- it's not in Linus's tree yet in any case)

Prevent SEQNUM from overwriting kset-specific hotplug environment vars.

Signed-off-by: Roland Dreier <roland@topspin.com>

Index: linux-bk/lib/kobject_uevent.c
===================================================================
--- linux-bk.orig/lib/kobject_uevent.c	2004-10-28 21:20:10.000000000 -0700
+++ linux-bk/lib/kobject_uevent.c	2004-10-28 21:21:10.000000000 -0700
@@ -258,6 +258,13 @@
 	envp [i++] = scratch;
 	scratch += sprintf(scratch, "SUBSYSTEM=%s", name) + 1;
 
+	spin_lock(&sequence_lock);
+	seq = ++hotplug_seqnum;
+	spin_unlock(&sequence_lock);
+
+	envp [i++] = scratch;
+	scratch += sprintf(scratch, "SEQNUM=%lld", (long long)seq) + 1;
+
 	if (hotplug_ops->hotplug) {
 		/* have the kset specific function add its stuff */
 		retval = hotplug_ops->hotplug (kset, kobj,
@@ -270,13 +277,6 @@
 		}
 	}
 
-	spin_lock(&sequence_lock);
-	seq = ++hotplug_seqnum;
-	spin_unlock(&sequence_lock);
-
-	envp [i++] = scratch;
-	scratch += sprintf(scratch, "SEQNUM=%lld", (long long)seq) + 1;
-
 	pr_debug ("%s: %s %s seq=%lld %s %s %s %s %s\n",
 		  __FUNCTION__, argv[0], argv[1], (long long)seq,
 		  envp[0], envp[1], envp[2], envp[3], envp[4]);
