Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S290012AbSBFDwc>; Tue, 5 Feb 2002 22:52:32 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S290017AbSBFDwK>; Tue, 5 Feb 2002 22:52:10 -0500
Received: from wb2-a.mail.utexas.edu ([128.83.126.136]:43536 "HELO
	mail.utexas.edu") by vger.kernel.org with SMTP id <S290012AbSBFDv6>;
	Tue, 5 Feb 2002 22:51:58 -0500
Date: Tue, 5 Feb 2002 21:52:55 -0600 (CST)
From: Brent Cook <busterb@mail.utexas.edu>
X-X-Sender: busterb@ozma.union.utexas.edu
To: linux-kernel@vger.kernel.org
cc: busterb@mail.utexas.edu
Subject: Fix for duplicate /proc entries
Message-ID: <20020205213544.J3054-100000@ozma.union.utexas.edu>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

 I think that I have found a problem with proc_dir_entry(). It seems to
allow multiple /proc entries to be created with the same name, without
returning a NULL pointer. I asked the folks on #kernelnewbies, and they
said that perhaps this is a feature. In either case, I believe that the
following patch fixes the issue by checking if a proc entry already exists
before creating it. This mirrors the behavior of remove_proc_entry, which
checks for the presense of a proc entry before deleting it.

Thank you
 - Brent

--- linux/fs/proc/generic.bak	Tue Feb  5 10:51:30 2002
+++ linux/fs/proc/generic.c	Tue Feb  5 11:03:24 2002
@@ -418,6 +418,7 @@
 					  mode_t mode,
 					  nlink_t nlink)
 {
+	struct proc_dir_entry **p;
 	struct proc_dir_entry *ent = NULL;
 	const char *fn = name;
 	int len;
@@ -429,6 +430,12 @@
 		goto out;
 	len = strlen(fn);

+	/* check for a duplication */
+	for (p = &(*parent)->subdir; *p; p=&(*p)->next ) {
+		if (proc_match(len, fn, *p))
+			goto out;
+	}
+
 	ent = kmalloc(sizeof(struct proc_dir_entry) + len + 1, GFP_KERNEL);
 	if (!ent) goto out;

