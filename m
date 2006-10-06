Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932603AbWJFUfm@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932603AbWJFUfm (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 6 Oct 2006 16:35:42 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932604AbWJFUfm
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 6 Oct 2006 16:35:42 -0400
Received: from e34.co.us.ibm.com ([32.97.110.152]:730 "EHLO e34.co.us.ibm.com")
	by vger.kernel.org with ESMTP id S932603AbWJFUfj (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 6 Oct 2006 16:35:39 -0400
Date: Fri, 6 Oct 2006 16:35:00 -0400
From: Vivek Goyal <vgoyal@in.ibm.com>
To: linux kernel mailing list <linux-kernel@vger.kernel.org>,
       Andi Kleen <ak@muc.de>
Cc: Fastboot mailing list <fastboot@lists.osdl.org>,
       "Eric W. Biederman" <ebiederm@xmission.com>,
       Magnus Damm <magnus@valinux.co.jp>, Ian.Campbell@XenSource.com
Subject: [PATCH] x86_64: Overlapping program headers in physical addr space fix
Message-ID: <20061006203500.GA13634@in.ibm.com>
Reply-To: vgoyal@in.ibm.com
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.11
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Andi,

Can you please apply following patch. Magnus verified that it fixed
his problem.

o A recent change to vmlinux.ld.S file broke kexec as now resulting vmlinux
  program headers are overlapping in physical address space.

o Now all the vsyscall related sections are placed after data and after
  that mostly init data sections are placed. To avoid physical overlap
  among phdrs, there are three possible solutions.	
	- Place vsyscall sections also in data phdrs instead of user
	- move vsyscal sections after init data in bss.
	- create another phdrs say data.init and move all the sections
	  after vsyscall into this new phdr.

o This patch implements the third solution. 

Signed-off-by: Vivek Goyal <vgoyal@in.ibm.com>
---

 arch/x86_64/kernel/vmlinux.lds.S |    3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff -puN arch/x86_64/kernel/vmlinux.lds.S~x86_64-physical-addr-space-overlap-in-phdrs-fix arch/x86_64/kernel/vmlinux.lds.S
--- linux-2.6.19-rc1-1M/arch/x86_64/kernel/vmlinux.lds.S~x86_64-physical-addr-space-overlap-in-phdrs-fix	2006-10-05 12:15:00.000000000 -0400
+++ linux-2.6.19-rc1-1M-root/arch/x86_64/kernel/vmlinux.lds.S	2006-10-05 12:15:00.000000000 -0400
@@ -17,6 +17,7 @@ PHDRS {
 	text PT_LOAD FLAGS(5);	/* R_E */
 	data PT_LOAD FLAGS(7);	/* RWE */
 	user PT_LOAD FLAGS(7);	/* RWE */
+	data.init PT_LOAD FLAGS(7);	/* RWE */
 	note PT_NOTE FLAGS(4);	/* R__ */
 }
 SECTIONS
@@ -131,7 +132,7 @@ SECTIONS
   . = ALIGN(8192);		/* init_task */
   .data.init_task : AT(ADDR(.data.init_task) - LOAD_OFFSET) {
 	*(.data.init_task)
-  } :data
+  }:data.init
 
   . = ALIGN(4096);
   .data.page_aligned : AT(ADDR(.data.page_aligned) - LOAD_OFFSET) {
_
