Return-Path: <linux-kernel-owner+willy=40w.ods.org-S269042AbUJQDr6@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S269042AbUJQDr6 (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 16 Oct 2004 23:47:58 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S269043AbUJQDr6
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 16 Oct 2004 23:47:58 -0400
Received: from mail3.speakeasy.net ([216.254.0.203]:36073 "EHLO
	mail3.speakeasy.net") by vger.kernel.org with ESMTP id S269042AbUJQDrr
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 16 Oct 2004 23:47:47 -0400
Message-ID: <4171EB60.50800@speakeasy.net>
Date: Sat, 16 Oct 2004 23:47:44 -0400
From: Andrew <cmkrnl@speakeasy.net>
Reply-To: cmkrnl@speakeasy.net
User-Agent: Mozilla Thunderbird 0.5 (Windows/20040207)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: greg@kroah.com, linux-kernel@vger.kernel.org
Subject: [PATCH] kernel-2.6.9.rc4 lib/kobject.c
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



There are two conditions where kset_hotplug can exit without the call to 
call_usermodehelper() after incrementing the sequence_number.  This 
patch eliminates the first by getting the kobj_path before the 
sequence_number++. It also reduces the likelihood of the second by 
decrementing the sequence_number (if it can) if the call to 
kset->hotplug_ops->hotplug() fails.

Some user space programs (rightly or wrongly) are expecting there would 
be no "gaps" in hotplug event sequence numbers, and hang waiting for the 
"missing" events.


   Signed-off-by: Andrew Duggan <cmkrnl@speakeasy.net>



--- lib/kobject.c.orig    2004-10-16 20:51:01.450973973 -0400
+++ lib/kobject.c    2004-10-16 21:08:19.961602269 -0400
@@ -177,6 +177,10 @@ static void kset_hotplug(const char *act
    envp [i++] = scratch;
    scratch += sprintf(scratch, "ACTION=%s", action) + 1;

+    kobj_path = kobject_get_path(kset, kobj, GFP_KERNEL);
+    if (!kobj_path)
+        goto exit;
+
    spin_lock(&sequence_lock);
    seq = sequence_num++;
    spin_unlock(&sequence_lock);
@@ -184,10 +188,6 @@ static void kset_hotplug(const char *act
    envp [i++] = scratch;
    scratch += sprintf(scratch, "SEQNUM=%ld", seq) + 1;

-    kobj_path = kobject_get_path(kset, kobj, GFP_KERNEL);
-    if (!kobj_path)
-        goto exit;
-
    envp [i++] = scratch;
    scratch += sprintf (scratch, "DEVPATH=%s", kobj_path) + 1;

@@ -199,6 +199,13 @@ static void kset_hotplug(const char *act
        if (retval) {
            pr_debug ("%s - hotplug() returned %d\n",
                  __FUNCTION__, retval);
+            /* decr sequence_num since no event will happen
+               but only if it is consistent */
+            spin_lock(&sequence_lock);
+            if (sequence_num == seq+1)
+               sequence_num--;
+            spin_unlock(&sequence_lock);
+
            goto exit;
        }
    }



