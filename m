Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S286708AbRL2V7e>; Sat, 29 Dec 2001 16:59:34 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S286330AbRL2V7Z>; Sat, 29 Dec 2001 16:59:25 -0500
Received: from leibniz.math.psu.edu ([146.186.130.2]:3498 "EHLO math.psu.edu")
	by vger.kernel.org with ESMTP id <S286794AbRL2V7N>;
	Sat, 29 Dec 2001 16:59:13 -0500
Date: Sat, 29 Dec 2001 16:59:09 -0500 (EST)
From: Alexander Viro <viro@math.psu.edu>
To: Linus Torvalds <torvalds@transmeta.com>
cc: Marcelo Tosatti <marcelo@conectiva.com.br>, linux-kernel@vger.kernel.org
Subject: [PATCH] fix to oopsable race in binfmt_elf.c
Message-ID: <Pine.GSO.4.21.0112291655390.7103-100000@weyl.math.psu.edu>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

	Changing current->fs requires task_lock(current) if old value
is non-NULL.  Otherwise we are risking oops on access to /proc/<pid>/{cwd,root}

diff -urN C2-pre3/fs/binfmt_elf.c C2-pre3-fs/fs/binfmt_elf.c
--- C2-pre3/fs/binfmt_elf.c	Sat Oct 20 22:16:59 2001
+++ C2-pre3-fs/fs/binfmt_elf.c	Sat Dec 29 15:14:18 2001
@@ -517,11 +517,13 @@
 				set_personality(PER_SVR4);
 				interpreter = open_exec(elf_interpreter);
 
+				task_lock(current);
 				new_domain = current->exec_domain;
 				new_fs = current->fs;
 				current->personality = old_pers;
 				current->exec_domain = old_domain;
 				current->fs = old_fs;
+				task_unlock(current);
 				put_exec_domain(new_domain);
 				put_fs_struct(new_fs);
 			} else

