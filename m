Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S276831AbRJCBu7>; Tue, 2 Oct 2001 21:50:59 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S276832AbRJCBuj>; Tue, 2 Oct 2001 21:50:39 -0400
Received: from neon-gw-l3.transmeta.com ([63.209.4.196]:35591 "EHLO
	neon-gw.transmeta.com") by vger.kernel.org with ESMTP
	id <S276831AbRJCBud>; Tue, 2 Oct 2001 21:50:33 -0400
To: linux-kernel@vger.kernel.org
From: torvalds@transmeta.com (Linus Torvalds)
Subject: Re: 2.4.10 bad ELF kills system bug
Date: Wed, 3 Oct 2001 01:50:25 +0000 (UTC)
Organization: Transmeta Corporation
Message-ID: <9pdqt1$2eh$1@penguin.transmeta.com>
In-Reply-To: <200110030040.f930eF921188@www.hockin.org>
X-Trace: palladium.transmeta.com 1002073847 28480 127.0.0.1 (3 Oct 2001 01:50:47 GMT)
X-Complaints-To: news@transmeta.com
NNTP-Posting-Date: 3 Oct 2001 01:50:47 GMT
Cache-Post-Path: palladium.transmeta.com!unknown@penguin.transmeta.com
X-Cache: nntpcache 2.4.0b5 (see http://www.nntpcache.org/)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

In article <200110030040.f930eF921188@www.hockin.org>,
Tim Hockin  <thockin@hockin.org> wrote:
>I can't believe how nonchalant everyone is about this bug.  Is there a
>definate fix yet?  If so, what is it?  Will there be a rushed 2.4.11, or
>will it languish for a while?

Well, the bug is actually ancient. The fix is something along the lines
of the attached, although there are people with prettier versions
(Andrea is looking at other buglets in the ELF loader).

		Linus

----
--- pre2/linux/fs/binfmt_elf.c	Tue Oct  2 16:24:18 2001
+++ linux/fs/binfmt_elf.c	Tue Oct  2 16:23:33 2001
@@ -298,6 +298,8 @@
 	    	elf_type |= MAP_FIXED;
 
 	    map_addr = elf_map(interpreter, load_addr + vaddr, eppnt, elf_prot, elf_type);
+	    if (map_addr > TASK_SIZE)
+	    	goto out_close;
 
 	    if (!load_addr_set && interp_elf_ex->e_type == ET_DYN) {
 		load_addr = map_addr - ELF_PAGESTART(vaddr);
@@ -649,6 +651,8 @@
 		}
 
 		error = elf_map(bprm->file, load_bias + vaddr, elf_ppnt, elf_prot, elf_flags);
+		if (error > TASK_SIZE)
+			continue;
 
 		if (!load_addr_set) {
 			load_addr_set = 1;

