Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261275AbUKSGww@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261275AbUKSGww (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 19 Nov 2004 01:52:52 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261276AbUKSGwv
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 19 Nov 2004 01:52:51 -0500
Received: from e34.co.us.ibm.com ([32.97.110.132]:36502 "EHLO
	e34.co.us.ibm.com") by vger.kernel.org with ESMTP id S261275AbUKSGwr
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 19 Nov 2004 01:52:47 -0500
Date: Fri, 19 Nov 2004 12:22:58 +0530
From: Ananth N Mavinakayanahalli <ananth@in.ibm.com>
To: Andrew Morton <akpm@osdl.org>
Cc: linux-kernel@vger.kernel.org, linuxppc64-dev@ozlabs.org,
       davem@davemloft.net, prasanna@in.ibm.com, suparna@in.ibm.com
Subject: Re: [PATCH] Kprobes: wrapper to define jprobe.entry
Message-ID: <20041119065258.GA6863@in.ibm.com>
Reply-To: ananth@in.ibm.com
References: <20041118102641.GB8830@in.ibm.com> <20041118144746.7daa9395.akpm@osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20041118144746.7daa9395.akpm@osdl.org>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Nov 18, 2004 at 02:47:46PM -0800, Andrew Morton wrote:
> Ananth N Mavinakayanahalli <ananth@in.ibm.com> wrote:

Hi Andrew,

> >
> > Here is a patch that adds a wrapper for defining jprobe.entry to make
> > it easy to handle the three dword function descriptors defined by the
> > PowerPC ELF ABI.
> > 
> > Current patch against 2.6.10-rc2-mm1 + kprobes patch for ppc64.
> 
> I don't have the kprobes-for-ppc64 patch here.
> 
> > Changes for adding this wrapper for x86, ppc64 (tested) and x86_64 
> > (untested) below. The earlier method of defining jprobe.entry will
> > continue to work.
> 
> So what should I do with this?  I'm inclined to drop it until the x86_64
> part has been tested and Dave has had a go at the sparc64 version.

I have now tested the patch succesfully on x86_64 and updated it for
sparc64 too (Dave says the change looks good).

Please apply.

Thanks,
Ananth

Signed-off-by: Ananth N Mavinakayanahalli <ananth@in.ibm.com>

diff -Naurp temp/linux-2.6.10-rc2/include/asm-i386/kprobes.h linux-2.6.10-rc2/include/asm-i386/kprobes.h
--- temp/linux-2.6.10-rc2/include/asm-i386/kprobes.h	2004-11-19 10:14:44.000000000 +0530
+++ linux-2.6.10-rc2/include/asm-i386/kprobes.h	2004-11-19 10:05:16.000000000 +0530
@@ -38,6 +38,8 @@ typedef u8 kprobe_opcode_t;
 	? (MAX_STACK_SIZE) \
 	: (((unsigned long)current_thread_info()) + THREAD_SIZE - (ADDR)))
 
+#define JPROBE_ENTRY(pentry)	(kprobe_opcode_t *)pentry
+
 /* Architecture specific copy of original instruction*/
 struct arch_specific_insn {
 	/* copy of the original instruction */
diff -Naurp temp/linux-2.6.10-rc2/include/asm-ppc64/kprobes.h linux-2.6.10-rc2/include/asm-ppc64/kprobes.h
--- temp/linux-2.6.10-rc2/include/asm-ppc64/kprobes.h	2004-11-19 10:14:44.000000000 +0530
+++ linux-2.6.10-rc2/include/asm-ppc64/kprobes.h	2004-11-19 10:05:16.000000000 +0530
@@ -35,6 +35,8 @@ typedef unsigned int kprobe_opcode_t;
 #define BREAKPOINT_INSTRUCTION	0x7fe00008	/* trap */
 #define MAX_INSN_SIZE 1
 
+#define JPROBE_ENTRY(pentry)	(kprobe_opcode_t *)((func_descr_t *)pentry)
+
 /* Architecture specific copy of original instruction */
 struct arch_specific_insn {
 	/* copy of original instruction */
diff -Naurp temp/linux-2.6.10-rc2/include/asm-sparc64/kprobes.h linux-2.6.10-rc2/include/asm-sparc64/kprobes.h
--- temp/linux-2.6.10-rc2/include/asm-sparc64/kprobes.h	2004-11-15 06:57:53.000000000 +0530
+++ linux-2.6.10-rc2/include/asm-sparc64/kprobes.h	2004-11-19 10:07:24.000000000 +0530
@@ -10,6 +10,8 @@ typedef u32 kprobe_opcode_t;
 #define BREAKPOINT_INSTRUCTION_2 0x91d02071 /* ta 0x71 */
 #define MAX_INSN_SIZE 2
 
+#define JPROBE_ENTRY(pentry)	(kprobe_opcode_t *)pentry
+
 /* Architecture specific copy of original instruction*/
 struct arch_specific_insn {
 	/* copy of the original instruction */
diff -Naurp temp/linux-2.6.10-rc2/include/asm-x86_64/kprobes.h linux-2.6.10-rc2/include/asm-x86_64/kprobes.h
--- temp/linux-2.6.10-rc2/include/asm-x86_64/kprobes.h	2004-11-19 10:14:44.000000000 +0530
+++ linux-2.6.10-rc2/include/asm-x86_64/kprobes.h	2004-11-19 10:05:16.000000000 +0530
@@ -37,6 +37,8 @@ typedef u8 kprobe_opcode_t;
 	? (MAX_STACK_SIZE) \
 	: (((unsigned long)current_thread_info()) + THREAD_SIZE - (ADDR)))
 
+#define JPROBE_ENTRY(pentry)	(kprobe_opcode_t *)pentry
+
 /* Architecture specific copy of original instruction*/
 struct arch_specific_insn {
 	/* copy of the original instruction */
