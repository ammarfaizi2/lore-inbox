Return-Path: <linux-kernel-owner+willy=40w.ods.org-S263675AbUD0B6X@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263675AbUD0B6X (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 26 Apr 2004 21:58:23 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263676AbUD0B6W
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 26 Apr 2004 21:58:22 -0400
Received: from mtvcafw.sgi.com ([192.48.171.6]:10951 "EHLO omx3.sgi.com")
	by vger.kernel.org with ESMTP id S263675AbUD0B6V (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 26 Apr 2004 21:58:21 -0400
Date: Mon, 26 Apr 2004 18:56:33 -0700
From: Paul Jackson <pj@sgi.com>
To: Andrew Morton <akpm@osdl.org>, John Reiser <jreiser@BitWagon.com>,
       mike@navi.cx, pageexec@freemail.hu
Cc: linux-kernel@vger.kernel.org
Subject: arch/ia64/ia32/binfmt_elf32.c: elf32_map() broken ia64 build
Message-Id: <20040426185633.7969ca0d.pj@sgi.com>
Organization: SGI
X-Mailer: Sylpheed version 0.9.8 (GTK+ 1.2.10; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Not sure how (no lkml thread that I can see), but it seems from Andrew's
broken out patch "bssprot.patch" in 2.6.6-rc2-mm2 that John Reiser
and/or others on the To list above conspired to break the build of
arch/ia64/ia32/binfmt_elf32.c: elf32_map().

They added a patch that amongst other things, did:

- elf_map(): new parameter total_size allows for holes between PT_LOAD; in
  fs/binfmt_elf.c, arch/x86_64/ia32/ia32_binfmt.c, arch/s390/kernel/
  binfmt_elf32.c.

but they didn't change (note elf32_map is just elf_map, via a #define) this:


===== arch/ia64/ia32/binfmt_elf32.c 1.22 vs edited =====
223c223
< elf32_map (struct file *filep, unsigned long addr, struct elf_phdr *eppnt, int prot, int type)
---
> elf32_map (struct file *filep, unsigned long addr, struct elf_phdr const *eppnt, int prot, int type, unsigned long total_size)


If I make the above function signature change, I can at least recompile
arch ia64 with CONFIG_IA32_SUPPORT enabled.  But I doubt that this is
ideal - as it is making no use of the new 'total_size' parameter.

Would someone care to recommend a proper fix?

-- 
                          I won't rest till it's the best ...
                          Programmer, Linux Scalability
                          Paul Jackson <pj@sgi.com> 1.650.933.1373
