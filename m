Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932384AbWB0Wjw@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932384AbWB0Wjw (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 27 Feb 2006 17:39:52 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932378AbWB0Wbw
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 27 Feb 2006 17:31:52 -0500
Received: from 216-99-217-87.dsl.aracnet.com ([216.99.217.87]:5506 "EHLO
	sorel.sous-sol.org") by vger.kernel.org with ESMTP id S932359AbWB0Wbt
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 27 Feb 2006 17:31:49 -0500
Message-Id: <20060227223404.094845000@sorel.sous-sol.org>
References: <20060227223200.865548000@sorel.sous-sol.org>
Date: Mon, 27 Feb 2006 14:32:33 -0800
From: Chris Wright <chrisw@sous-sol.org>
To: linux-kernel@vger.kernel.org, stable@kernel.org
Cc: Justin Forbes <jmforbes@linuxtx.org>,
       Zwane Mwaikambo <zwane@arm.linux.org.uk>,
       "Theodore Ts'o" <tytso@mit.edu>, Randy Dunlap <rdunlap@xenotime.net>,
       Dave Jones <davej@redhat.com>, Chuck Wolber <chuckw@quantumlinux.com>,
       torvalds@osdl.org, akpm@osdl.org, alan@lxorguk.ukuu.org.uk,
       Andi Kleen <ak@suse.de>, Suresh Siddha <suresh.b.siddha@intel.com>
Subject: [patch 33/39] [PATCH] x86_64: Check for bad elf entry address
Content-Disposition: inline; filename=x86_64-check-for-bad-elf-entry-address.patch
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

-stable review patch.  If anyone has any objections, please let us know.
------------------

Fixes a local DOS on Intel systems that lead to an endless
recursive fault.  AMD machines don't seem to be affected.

Signed-off-by: Suresh Siddha <suresh.b.siddha@intel.com>
Signed-off-by: Andi Kleen <ak@suse.de>
Signed-off-by: Chris Wright <chrisw@sous-sol.org>
---
 fs/binfmt_elf.c |    5 +++++
 1 files changed, 5 insertions(+)

--- linux-2.6.15.4.orig/fs/binfmt_elf.c
+++ linux-2.6.15.4/fs/binfmt_elf.c
@@ -932,6 +932,11 @@ static int load_elf_binary(struct linux_
 		kfree(elf_interpreter);
 	} else {
 		elf_entry = loc->elf_ex.e_entry;
+		if (BAD_ADDR(elf_entry)) {
+			send_sig(SIGSEGV, current, 0);
+			retval = -ENOEXEC; /* Nobody gets to see this, but.. */
+			goto out_free_dentry;
+		}
 	}
 
 	kfree(elf_phdata);

--
