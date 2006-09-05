Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030218AbWIETcu@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030218AbWIETcu (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 5 Sep 2006 15:32:50 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030235AbWIETcu
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 5 Sep 2006 15:32:50 -0400
Received: from e35.co.us.ibm.com ([32.97.110.153]:678 "EHLO e35.co.us.ibm.com")
	by vger.kernel.org with ESMTP id S1030218AbWIETct (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 5 Sep 2006 15:32:49 -0400
Date: Tue, 5 Sep 2006 15:32:22 -0400
From: Vivek Goyal <vgoyal@in.ibm.com>
To: Morton Andrew Morton <akpm@osdl.org>,
       linux kernel mailing list <linux-kernel@vger.kernel.org>
Cc: Fastboot mailing list <fastboot@lists.osdl.org>,
       "Eric W. Biederman" <ebiederm@xmission.com>
Subject: [PATCH] Kcore elf note namesz field fix
Message-ID: <20060905193222.GA29478@in.ibm.com>
Reply-To: vgoyal@in.ibm.com
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.11
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org




o As per ELF specifications, it looks like that elf note "namesz" field contains
  the length of "name" including the size of null character. And 
  currently we are filling "namesz" without taking into the consideration
  the null character size.

o Kexec-tools performs this check deligently hence I ran into the issue
  while trying to open /proc/kcore in kexec-tools for some info.

Signed-off-by: Vivek Goyal <vgoyal@in.ibm.com>
---

 fs/proc/kcore.c |    4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff -puN fs/proc/kcore.c~kcore-elf-note-namesz-fix fs/proc/kcore.c
--- linux-2.6.18-rc3-1M/fs/proc/kcore.c~kcore-elf-note-namesz-fix	2006-08-31 16:10:41.000000000 -0400
+++ linux-2.6.18-rc3-1M-root/fs/proc/kcore.c	2006-08-31 16:10:41.000000000 -0400
@@ -100,7 +100,7 @@ static int notesize(struct memelfnote *e
 	int sz;
 
 	sz = sizeof(struct elf_note);
-	sz += roundup(strlen(en->name), 4);
+	sz += roundup((strlen(en->name) + 1), 4);
 	sz += roundup(en->datasz, 4);
 
 	return sz;
@@ -116,7 +116,7 @@ static char *storenote(struct memelfnote
 
 #define DUMP_WRITE(addr,nr) do { memcpy(bufp,addr,nr); bufp += nr; } while(0)
 
-	en.n_namesz = strlen(men->name);
+	en.n_namesz = strlen(men->name) + 1;
 	en.n_descsz = men->datasz;
 	en.n_type = men->type;
 
_
