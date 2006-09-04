Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751407AbWIDSZo@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751407AbWIDSZo (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 4 Sep 2006 14:25:44 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751417AbWIDSZo
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 4 Sep 2006 14:25:44 -0400
Received: from ebiederm.dsl.xmission.com ([166.70.28.69]:6533 "EHLO
	ebiederm.dsl.xmission.com") by vger.kernel.org with ESMTP
	id S1751407AbWIDSZn (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 4 Sep 2006 14:25:43 -0400
From: ebiederm@xmission.com (Eric W. Biederman)
To: Matthew Wilcox <matthew@wil.cx>
Cc: Adrian Bunk <bunk@stusta.de>, Andrew Morton <akpm@osdl.org>,
       Sukadev Bhattiprolu <sukadev@us.ibm.com>, linux-kernel@vger.kernel.org,
       parisc-linux@parisc-linux.org
Subject: [PATCH] Fix conflict with the is_init identifier on parisc
References: <20060901015818.42767813.akpm@osdl.org>
	<20060904114130.GN4416@stusta.de>
	<20060904134826.GF2558@parisc-linux.org>
Date: Mon, 04 Sep 2006 12:24:27 -0600
In-Reply-To: <20060904134826.GF2558@parisc-linux.org> (Matthew Wilcox's
	message of "Mon, 4 Sep 2006 07:48:27 -0600")
Message-ID: <m164g37an8.fsf_-_@ebiederm.dsl.xmission.com>
User-Agent: Gnus/5.110004 (No Gnus v0.4) Emacs/21.4 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Matthew Wilcox <matthew@wil.cx> writes:

> On Mon, Sep 04, 2006 at 01:41:30PM +0200, Adrian Bunk wrote:
>> pidspace-is_init.patch causes the following compile error on parisc:
>> 
>> <--  snip  -->
>> 
>> ...
>>   CC      arch/parisc/kernel/module.o
>>
> /home/bunk/linux/kernel-2.6/linux-2.6.18-rc5-mm1/arch/parisc/kernel/module.c:76:
> error: conflicting types for 'is_init'
>> /home/bunk/linux/kernel-2.6/linux-2.6.18-rc5-mm1/include/linux/sched.h:1090:
> error: previous definition of 'is_init' was here
>> make[2]: *** [arch/parisc/kernel/module.o] Error 1
>> 
>> <--  snip  -->
>
> Looks like ia64 calls the same function in_init().  I'm tempted to
> change parisc to have the same name.

How does the following patch look?
Since I don't have a parisc compiler so I haven't compile tested it.
But it is a simple substitute and replace and I can't see any problems
by inspection so it should work.

----

This appears to be the only usage of is_init in the kernel
besides the usage in sched.h.   On ia64 the same function is
called in_init.    So to remove the conflict and make the kernel
more consistent rename is_init is_core is_local and is_local_section
to in_init in_core in_local and in_local_section respectively.

Thanks to Adrian Bunk who spotted this, and to Matthew Wilcox
who suggested this fix.

Singed-off-by: Eric Biederman <ebiederm@xmission.com>
---
 arch/parisc/kernel/module.c |   32 ++++++++++++++++----------------
 1 files changed, 16 insertions(+), 16 deletions(-)

diff --git a/arch/parisc/kernel/module.c b/arch/parisc/kernel/module.c
index aee3118..f50b982 100644
--- a/arch/parisc/kernel/module.c
+++ b/arch/parisc/kernel/module.c
@@ -27,7 +27,7 @@
  *    - SEGREL32 handling
  *      We are not doing SEGREL32 handling correctly. According to the ABI, we
  *      should do a value offset, like this:
- *			if (is_init(me, (void *)val))
+ *			if (in_init(me, (void *)val))
  *				val -= (uint32_t)me->module_init;
  *			else
  *				val -= (uint32_t)me->module_core;
@@ -72,27 +72,27 @@ #define MAX_GOTS	1023
 
 /* three functions to determine where in the module core
  * or init pieces the location is */
-static inline int is_init(struct module *me, void *loc)
+static inline int in_init(struct module *me, void *loc)
 {
 	return (loc >= me->module_init &&
 		loc <= (me->module_init + me->init_size));
 }
 
-static inline int is_core(struct module *me, void *loc)
+static inline int in_core(struct module *me, void *loc)
 {
 	return (loc >= me->module_core &&
 		loc <= (me->module_core + me->core_size));
 }
 
-static inline int is_local(struct module *me, void *loc)
+static inline int in_local(struct module *me, void *loc)
 {
-	return is_init(me, loc) || is_core(me, loc);
+	return in_init(me, loc) || in_core(me, loc);
 }
 
-static inline int is_local_section(struct module *me, void *loc, void *dot)
+static inline int in_local_section(struct module *me, void *loc, void *dot)
 {
-	return (is_init(me, loc) && is_init(me, dot)) ||
-		(is_core(me, loc) && is_core(me, dot));
+	return (in_init(me, loc) && in_init(me, dot)) ||
+		(in_core(me, loc) && in_core(me, dot));
 }
 
 
@@ -566,14 +566,14 @@ #endif
 			break;
 		case R_PARISC_PCREL17F:
 			/* 17-bit PC relative address */
-			val = get_stub(me, val, addend, ELF_STUB_GOT, is_init(me, loc));
+			val = get_stub(me, val, addend, ELF_STUB_GOT, in_init(me, loc));
 			val = (val - dot - 8)/4;
 			CHECK_RELOC(val, 17)
 			*loc = (*loc & ~0x1f1ffd) | reassemble_17(val);
 			break;
 		case R_PARISC_PCREL22F:
 			/* 22-bit PC relative address; only defined for pa20 */
-			val = get_stub(me, val, addend, ELF_STUB_GOT, is_init(me, loc));
+			val = get_stub(me, val, addend, ELF_STUB_GOT, in_init(me, loc));
 			DEBUGP("STUB FOR %s loc %lx+%lx at %lx\n", 
 			       strtab + sym->st_name, (unsigned long)loc, addend, 
 			       val)
@@ -670,9 +670,9 @@ #endif
 			       strtab + sym->st_name,
 			       loc, val);
 			/* can we reach it locally? */
-			if(!is_local_section(me, (void *)val, (void *)dot)) {
+			if(!in_local_section(me, (void *)val, (void *)dot)) {
 
-				if (is_local(me, (void *)val))
+				if (in_local(me, (void *)val))
 					/* this is the case where the
 					 * symbol is local to the
 					 * module, but in a different
@@ -680,14 +680,14 @@ #endif
 					 * in case it's more than 22
 					 * bits away */
 					val = get_stub(me, val, addend, ELF_STUB_DIRECT,
-						       is_init(me, loc));
+						       in_init(me, loc));
 				else if (strncmp(strtab + sym->st_name, "$$", 2)
 				    == 0)
 					val = get_stub(me, val, addend, ELF_STUB_MILLI,
-						       is_init(me, loc));
+						       in_init(me, loc));
 				else
 					val = get_stub(me, val, addend, ELF_STUB_GOT,
-						       is_init(me, loc));
+						       in_init(me, loc));
 			}
 			DEBUGP("STUB FOR %s loc %lx, val %lx+%lx at %lx\n", 
 			       strtab + sym->st_name, loc, sym->st_value,
@@ -720,7 +720,7 @@ #endif
 			break;
 		case R_PARISC_FPTR64:
 			/* 64-bit function address */
-			if(is_local(me, (void *)(val + addend))) {
+			if(in_local(me, (void *)(val + addend))) {
 				*loc64 = get_fdesc(me, val+addend);
 				DEBUGP("FDESC for %s at %p points to %lx\n",
 				       strtab + sym->st_name, *loc64,
-- 
1.4.2.rc3.g7e18e-dirty

