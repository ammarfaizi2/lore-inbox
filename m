Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262856AbRFTQJx>; Wed, 20 Jun 2001 12:09:53 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S263060AbRFTQJm>; Wed, 20 Jun 2001 12:09:42 -0400
Received: from [128.165.17.16] ([128.165.17.16]:48146 "EHLO cic-mail.lanl.gov")
	by vger.kernel.org with ESMTP id <S262856AbRFTQJf>;
	Wed, 20 Jun 2001 12:09:35 -0400
Date: Wed, 20 Jun 2001 10:09:33 -0600
From: "Eric H. Weigle" <ehw@lanl.gov>
To: linux-kernel@vger.kernel.org
Subject: [BUG][PATCH] /proc duplicate entries
Message-ID: <20010620100933.B1457@lanl.gov>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
X-Eric-Unconspiracy: There ought to be a conspiracy
X-Editor: Vim, http://www.vim.org
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello-

Hopefully this isn't redundant, I haven't checked the latest -ac or -pre
releases. I just noticed on my 2.4.5 box that I have two /proc/dri/ directory
entries (I've got both on-board and AGP video in the box and both are trying
to register entries).

Yes, code that tries to register the same name twice is broken, but the
filesystem still shouldn't allow bad code to break its semantics (duplicate
entries of the same name).

The following patch performs a duplicate name check.

--------------------------------------------------------------------------------
--- fs/proc/generic.c.orig	Tue Jun 19 15:44:05 2001
+++ fs/proc/generic.c	Wed Jun 20 10:02:32 2001
@@ -421,6 +421,14 @@
 		goto out;
 	len = strlen(fn);
 
+	/* check for name conflicts */
+	for (ent=(*parent)->subdir; ent; ent=ent->next) {
+		if (proc_match(len,name,ent)) {
+			ent = NULL;
+			goto out;
+		}
+	}
+
 	ent = kmalloc(sizeof(struct proc_dir_entry) + len + 1, GFP_KERNEL);
 	if (!ent) goto out;
--------------------------------------------------------------------------------

Thanks
-Eric

-- 
--------------------------------------------
 Eric H. Weigle   CCS-1, RADIANT team
 ehw@lanl.gov     Los Alamos National Lab
 (505) 665-4937   http://home.lanl.gov/ehw/
--------------------------------------------
