Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750706AbWFTRiR@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750706AbWFTRiR (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 20 Jun 2006 13:38:17 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750720AbWFTRiO
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 20 Jun 2006 13:38:14 -0400
Received: from mx1.redhat.com ([66.187.233.31]:18898 "EHLO mx1.redhat.com")
	by vger.kernel.org with ESMTP id S1750722AbWFTRhz (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 20 Jun 2006 13:37:55 -0400
From: David Howells <dhowells@redhat.com>
Subject: [PATCH 5/6] Keys: Restrict contents of /proc/keys to Viewable keys [try #3]
Date: Tue, 20 Jun 2006 18:37:46 +0100
To: torvalds@osdl.org, akpm@osdl.org
Cc: linux-kernel@vger.kernel.org, keyrings@linux-nfs.org
Message-Id: <20060620173746.5034.74939.stgit@warthog.cambridge.redhat.com>
In-Reply-To: <20060620173735.5034.11436.stgit@warthog.cambridge.redhat.com>
References: <20060620173735.5034.11436.stgit@warthog.cambridge.redhat.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

From: Michael LeMay <mdlemay@epoch.ncsc.mil>

This patch restricts /proc/keys such that only those keys to which the current
task is granted View permission are presented.

The documentation is also updated to reflect these changes.

Signed-off-by: Michael LeMay <mdlemay@epoch.ncsc.mil>
Signed-off-by: James Morris <jmorris@namei.org>
Signed-Off-By: David Howells <dhowells@redhat.com>
---

 Documentation/keys.txt |   16 ++++++++++++----
 security/Kconfig       |   20 +++++++++++++-------
 security/keys/proc.c   |    7 +++++++
 3 files changed, 32 insertions(+), 11 deletions(-)

diff --git a/Documentation/keys.txt b/Documentation/keys.txt
index 3bbe157..70e83cf 100644
--- a/Documentation/keys.txt
+++ b/Documentation/keys.txt
@@ -270,9 +270,17 @@ about the status of the key service:
 
  (*) /proc/keys
 
-     This lists all the keys on the system, giving information about their
-     type, description and permissions. The payload of the key is not available
-     this way:
+     This lists the keys that are currently viewable by the task reading the
+     file, giving information about their type, description and permissions.
+     It is not possible to view the payload of the key this way, though some
+     information about it may be given.
+
+     The only keys included in the list are those that grant View permission to
+     the reading process whether or not it possesses them.  Note that LSM
+     security checks are still performed, and may further filter out keys that
+     the current process is not authorised to view.
+
+     The contents of the file look like this:
 
 	SERIAL   FLAGS  USAGE EXPY PERM     UID   GID   TYPE      DESCRIPTION: SUMMARY
 	00000001 I-----    39 perm 1f3f0000     0     0 keyring   _uid_ses.0: 1/4
@@ -300,7 +308,7 @@ about the status of the key service:
  (*) /proc/key-users
 
      This file lists the tracking data for each user that has at least one key
-     on the system. Such data includes quota information and statistics:
+     on the system.  Such data includes quota information and statistics:
 
 	[root@andromeda root]# cat /proc/key-users
 	0:     46 45/45 1/100 13/10000
diff --git a/security/Kconfig b/security/Kconfig
index 34f5934..67785df 100644
--- a/security/Kconfig
+++ b/security/Kconfig
@@ -22,16 +22,22 @@ config KEYS
 	  If you are unsure as to whether this is required, answer N.
 
 config KEYS_DEBUG_PROC_KEYS
-	bool "Enable the /proc/keys file by which all keys may be viewed"
+	bool "Enable the /proc/keys file by which keys may be viewed"
 	depends on KEYS
 	help
-	  This option turns on support for the /proc/keys file through which
-	  all the keys on the system can be listed.
+	  This option turns on support for the /proc/keys file - through which
+	  can be listed all the keys on the system that are viewable by the
+	  reading process.
 
-	  This option is a slight security risk in that it makes it possible
-	  for anyone to see all the keys on the system. Normally the manager
-	  pretends keys that are inaccessible to a process don't exist as far
-	  as that process is concerned.
+	  The only keys included in the list are those that grant View
+	  permission to the reading process whether or not it possesses them.
+	  Note that LSM security checks are still performed, and may further
+	  filter out keys that the current process is not authorised to view.
+
+	  Only key attributes are listed here; key payloads are not included in
+	  the resulting table.
+
+	  If you are unsure as to whether this is required, answer N.
 
 config SECURITY
 	bool "Enable different security models"
diff --git a/security/keys/proc.c b/security/keys/proc.c
index 12b750e..686a9ee 100644
--- a/security/keys/proc.c
+++ b/security/keys/proc.c
@@ -137,6 +137,13 @@ static int proc_keys_show(struct seq_fil
 	struct timespec now;
 	unsigned long timo;
 	char xbuf[12];
+	int rc;
+
+	/* check whether the current task is allowed to view the key (assuming
+	 * non-possession) */
+	rc = key_task_permission(make_key_ref(key, 0), current, KEY_VIEW);
+	if (rc < 0)
+		return 0;
 
 	now = current_kernel_time();
 

