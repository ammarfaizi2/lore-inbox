Return-Path: <linux-kernel-owner+willy=40w.ods.org-S268180AbUJVXPv@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S268180AbUJVXPv (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 22 Oct 2004 19:15:51 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S268228AbUJVXPa
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 22 Oct 2004 19:15:30 -0400
Received: from mail.kroah.org ([69.55.234.183]:19875 "EHLO perch.kroah.org")
	by vger.kernel.org with ESMTP id S269093AbUJVXKR convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 22 Oct 2004 19:10:17 -0400
X-Donotread: and you are reading this why?
Subject: Re: [PATCH] Driver Core patches for 2.6.10-rc1
In-Reply-To: <10984865723197@kroah.com>
X-Patch: quite boring stuff, it's just source code...
Date: Fri, 22 Oct 2004 16:09:32 -0700
Message-Id: <10984865721186@kroah.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
To: linux-kernel@vger.kernel.org
Content-Transfer-Encoding: 7BIT
From: Greg KH <greg@kroah.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

ChangeSet 1.2023, 2004/10/22 15:43:17-07:00, greg@kroah.com

hotplug: prevent skips in sequence number from happening

Signed-off-by: Greg Kroah-Hartman <greg@kroah.com>


 lib/kobject_uevent.c |   17 +++++++++--------
 1 files changed, 9 insertions(+), 8 deletions(-)


diff -Nru a/lib/kobject_uevent.c b/lib/kobject_uevent.c
--- a/lib/kobject_uevent.c	2004-10-22 15:59:34 -07:00
+++ b/lib/kobject_uevent.c	2004-10-22 15:59:34 -07:00
@@ -255,13 +255,6 @@
 	envp [i++] = scratch;
 	scratch += sprintf (scratch, "DEVPATH=%s", kobj_path) + 1;
 
-	spin_lock(&sequence_lock);
-	seq = ++hotplug_seqnum;
-	spin_unlock(&sequence_lock);
-
-	envp [i++] = scratch;
-	scratch += sprintf(scratch, "SEQNUM=%lld", (long long)seq) + 1;
-
 	envp [i++] = scratch;
 	scratch += sprintf(scratch, "SUBSYSTEM=%s", name) + 1;
 
@@ -277,7 +270,15 @@
 		}
 	}
 
-	pr_debug ("%s: %s %s %s %s %s %s %s\n", __FUNCTION__, argv[0], argv[1],
+	spin_lock(&sequence_lock);
+	seq = ++hotplug_seqnum;
+	spin_unlock(&sequence_lock);
+
+	envp [i++] = scratch;
+	scratch += sprintf(scratch, "SEQNUM=%lld", (long long)seq) + 1;
+
+	pr_debug ("%s: %s %s seq=%lld %s %s %s %s %s\n",
+		  __FUNCTION__, argv[0], argv[1], (long long)seq,
 		  envp[0], envp[1], envp[2], envp[3], envp[4]);
 
 	send_uevent(action_string, kobj_path, buffer, scratch - buffer, GFP_KERNEL);

