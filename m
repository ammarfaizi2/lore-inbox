Return-Path: <linux-kernel-owner+willy=40w.ods.org-S265196AbUHMIKC@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265196AbUHMIKC (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 13 Aug 2004 04:10:02 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S269028AbUHMIKC
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 13 Aug 2004 04:10:02 -0400
Received: from pop.gmx.net ([213.165.64.20]:53168 "HELO mail.gmx.net")
	by vger.kernel.org with SMTP id S265196AbUHMIJW (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 13 Aug 2004 04:09:22 -0400
X-Authenticated: #12437197
Date: Fri, 13 Aug 2004 11:09:42 +0300
From: Dan Aloni <da-x@colinux.org>
To: Benno <benjl@cse.unsw.edu.au>,
       Linux Kernel List <linux-kernel@vger.kernel.org>
Subject: [PATCH 1/2] Re: Generation of *.s files from *.S files in kbuild
Message-ID: <20040813080941.GA7639@callisto.yi.org>
References: <20040812192535.GA20953@callisto.yi.org> <20040813003743.GF30576@cse.unsw.edu.au> <20040813050424.GA7417@mars.ravnborg.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20040813050424.GA7417@mars.ravnborg.org>
User-Agent: Mutt/1.5.6+20040803i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Aug 13, 2004 at 07:04:24AM +0200, Sam Ravnborg wrote:
> On Fri, Aug 13, 2004 at 10:37:43AM +1000, Benno wrote:
> > 
> > The solution is fairly striaght forward -- just change the suffixes,
> > the problem is exactly how to change them. I would propose changing it
> > such that was stick with "vmlinux.lds.S" and have it generate "vmlinux.lds"
> > 
> > This would require the fewest changes to implement, just
> > 1/ change %.s %.S rule to %.lds %.lds.S
> > 2/ change the link flags from "-T vmlinux.lds.s" -> "-T vmlinux.lds"
> 
> I agree with this approach, and see no defencies.
> 
> Care to send two patches.
> One that do what you suggest for i386, and another that cover the rest
> of the architectures?

Here's the first patch:

Signed-off-by: Dan Aloni <da-x@colinux.org>

diff -X /home/karrde/colinux/bin/dontdiff -urN linux-2.6.7/Makefile linux-2.6.7-work/Makefile
--- linux-2.6.7/Makefile	2004-08-13 10:26:11.000000000 +0300
+++ linux-2.6.7-work/Makefile	2004-08-13 10:59:19.000000000 +0300
@@ -549,7 +549,7 @@
 	$(NM) $@ | grep -v '\(compiled\)\|\(\.o$$\)\|\( [aUw] \)\|\(\.\.ng$$\)\|\(LASH[RL]DI\)' | sort > System.map
 endef
 
-LDFLAGS_vmlinux += -T arch/$(ARCH)/kernel/vmlinux.lds.s
+LDFLAGS_vmlinux += -T arch/$(ARCH)/kernel/vmlinux.lds
 
 #	Generate section listing all symbols and add it into vmlinux
 #	It's a three stage process:
@@ -575,23 +575,23 @@
 .tmp_kallsyms%.S: .tmp_vmlinux%
 	$(call cmd,kallsyms)
 
-.tmp_vmlinux1: $(vmlinux-objs) arch/$(ARCH)/kernel/vmlinux.lds.s FORCE
+.tmp_vmlinux1: $(vmlinux-objs) arch/$(ARCH)/kernel/vmlinux.lds FORCE
 	+$(call if_changed_rule,vmlinux__)
 
-.tmp_vmlinux2: $(vmlinux-objs) .tmp_kallsyms1.o arch/$(ARCH)/kernel/vmlinux.lds.s FORCE
+.tmp_vmlinux2: $(vmlinux-objs) .tmp_kallsyms1.o arch/$(ARCH)/kernel/vmlinux.lds FORCE
 	$(call if_changed_rule,vmlinux__)
 
 endif
 
 #	Finally the vmlinux rule
 
-vmlinux: $(vmlinux-objs) $(kallsyms.o) arch/$(ARCH)/kernel/vmlinux.lds.s FORCE
+vmlinux: $(vmlinux-objs) $(kallsyms.o) arch/$(ARCH)/kernel/vmlinux.lds FORCE
 	$(call if_changed_rule,vmlinux)
 
 #	The actual objects are generated when descending, 
 #	make sure no implicit rule kicks in
 
-$(sort $(vmlinux-objs)) arch/$(ARCH)/kernel/vmlinux.lds.s: $(vmlinux-dirs) ;
+$(sort $(vmlinux-objs)) arch/$(ARCH)/kernel/vmlinux.lds: $(vmlinux-dirs) ;
 
 # 	Handle descending into subdirectories listed in $(vmlinux-dirs)
 
@@ -632,10 +632,10 @@
 # All the preparing..
 prepare-all: prepare0 prepare
 
-#	Leave this as default for preprocessing vmlinux.lds.s, which is now
+#	Leave this as default for preprocessing vmlinux.lds, which is now
 #	done in arch/$(ARCH)/kernel/Makefile
 
-export AFLAGS_vmlinux.lds.o += -P -C -U$(ARCH)
+export AFLAGS_vmlinux.o += -P -C -U$(ARCH)
 
 # Single targets
 # ---------------------------------------------------------------------------
diff -X /home/karrde/colinux/bin/dontdiff -urN linux-2.6.7/arch/i386/kernel/Makefile linux-2.6.7-work/arch/i386/kernel/Makefile
--- linux-2.6.7/arch/i386/kernel/Makefile	2004-06-22 09:23:56.000000000 +0300
+++ linux-2.6.7-work/arch/i386/kernel/Makefile	2004-08-13 10:32:15.000000000 +0300
@@ -2,7 +2,7 @@
 # Makefile for the linux kernel.
 #
 
-extra-y := head.o init_task.o vmlinux.lds.s
+extra-y := head.o init_task.o vmlinux.lds
 
 obj-y	:= process.o semaphore.o signal.o entry.o traps.o irq.o vm86.o \
 		ptrace.o i8259.o ioport.o ldt.o setup.o time.o sys_i386.o \
diff -X /home/karrde/colinux/bin/dontdiff -urN linux-2.6.7/scripts/Makefile.build linux-2.6.7-work/scripts/Makefile.build
--- linux-2.6.7/scripts/Makefile.build	2004-06-16 08:19:52.000000000 +0300
+++ linux-2.6.7-work/scripts/Makefile.build	2004-08-13 10:23:52.000000000 +0300
@@ -194,11 +194,11 @@
 $(real-objs-m)      : modkern_aflags := $(AFLAGS_MODULE)
 $(real-objs-m:.o=.s): modkern_aflags := $(AFLAGS_MODULE)
 
-quiet_cmd_as_s_S = CPP $(quiet_modtag) $@
-cmd_as_s_S       = $(CPP) $(a_flags)   -o $@ $< 
+quiet_cmd_as_lds_lds_S = CPP $(quiet_modtag) $@
+cmd_as_lds_lds_S       = $(CPP) $(a_flags)   -o $@ $< 
 
-%.s: %.S FORCE
-	$(call if_changed_dep,as_s_S)
+%.lds: %.lds.S FORCE
+	$(call if_changed_dep,as_lds_lds_S)
 
 quiet_cmd_as_o_S = AS $(quiet_modtag)  $@
 cmd_as_o_S       = $(CC) $(a_flags) -c -o $@ $<


-- 
Dan Aloni
da-x@colinux.org
