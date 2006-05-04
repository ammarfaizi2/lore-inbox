Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030291AbWEDSp0@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030291AbWEDSp0 (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 4 May 2006 14:45:26 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030293AbWEDSp0
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 4 May 2006 14:45:26 -0400
Received: from redflag.CS.Princeton.EDU ([128.112.136.72]:23802 "EHLO
	redflag.CS.Princeton.EDU") by vger.kernel.org with ESMTP
	id S1030291AbWEDSpZ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 4 May 2006 14:45:25 -0400
Message-ID: <445A4B50.8060104@cs.princeton.edu>
Date: Thu, 04 May 2006 14:43:28 -0400
From: Mark Huang <mlhuang@CS.Princeton.EDU>
Organization: Princeton University
User-Agent: Mozilla/5.0 (X11; U; Linux x86_64; en-US; rv:1.7.12) Gecko/20050929 Thunderbird/1.0.7 Fedora/1.0.7-1.1.fc4 Mnenhy/0.7.3.0
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org
Subject: [PATCH] initramfs: fix CPIO hardlink check
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlx=-1 adultscore=0 adjust=0 reason=safe engine=3.0.0-06042601 definitions=3.0.0-06050411
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Copy the filenames of hardlinks when inserting them into the hash, since
the "name" pointer may point to scratch space (name_buf). Not doing so
results in corruption if the scratch space is later overwritten: the 
wrong file may be hardlinked, or, if the scratch space contains garbage, 
the link will fail and a 0-byte file will be created instead.

Cc: me on responses.

Signed-off-by: Mark Huang <mlhuang@cs.princeton.edu>

--- linux-2.6.16.13/init/initramfs.c	2006-05-02 17:38:44.000000000 -0400
+++ linux-2.6.16.13.initramfs/init/initramfs.c	2006-05-04 
14:26:44.000000000 -0400
@@ -26,10 +26,12 @@ static void __init free(void *where)

  /* link hash */

+#define N_ALIGN(len) ((((len) + 1) & ~3) + 2)
+
  static __initdata struct hash {
  	int ino, minor, major;
  	struct hash *next;
-	char *name;
+	char name[N_ALIGN(PATH_MAX)];
  } *head[32];

  static inline int hash(int major, int minor, int ino)
@@ -57,7 +59,7 @@ static char __init *find_link(int major,
  	q->ino = ino;
  	q->minor = minor;
  	q->major = major;
-	q->name = name;
+	strcpy(q->name, name);
  	q->next = NULL;
  	*p = q;
  	return NULL;
@@ -133,8 +135,6 @@ static inline void eat(unsigned n)
  	count -= n;
  }

-#define N_ALIGN(len) ((((len) + 1) & ~3) + 2)
-
  static __initdata char *collected;
  static __initdata int remains;
  static __initdata char *collect;

