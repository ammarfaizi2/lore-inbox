Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262529AbVF1Evd@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262529AbVF1Evd (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 28 Jun 2005 00:51:33 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262530AbVF1Evd
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 28 Jun 2005 00:51:33 -0400
Received: from e34.co.us.ibm.com ([32.97.110.132]:38856 "EHLO
	e34.co.us.ibm.com") by vger.kernel.org with ESMTP id S262529AbVF1EvV
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 28 Jun 2005 00:51:21 -0400
Date: Tue, 28 Jun 2005 10:21:12 +0530
From: Vivek Goyal <vgoyal@in.ibm.com>
To: gdb@sources.redhat.com, dan@debian.org
Cc: Fastboot mailing list <fastboot@lists.osdl.org>,
       linux kernel mailing list <linux-kernel@vger.kernel.org>,
       Morton Andrew Morton <akpm@osdl.org>, bunk@stusta.de
Subject: Re: [Fastboot] Re: [-mm patch] i386: enable REGPARM by default
Message-ID: <20050628045111.GB4296@in.ibm.com>
Reply-To: vgoyal@in.ibm.com
References: <20050624200916.GJ6656@stusta.de> <20050624132826.4cdfb63c.akpm@osdl.org> <20050627132941.GD3764@in.ibm.com> <20050627140029.GB29121@nevyn.them.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20050627140029.GB29121@nevyn.them.org>
User-Agent: Mutt/1.4.2.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jun 27, 2005 at 10:00:29AM -0400, Daniel Jacobowitz wrote:
> On Mon, Jun 27, 2005 at 06:59:41PM +0530, Vivek Goyal wrote:
> > On Fri, Jun 24, 2005 at 01:28:26PM -0700, Andrew Morton wrote:
> > > Adrian Bunk <bunk@stusta.de> wrote:
> > > >
> > > > This patch:
> > > > - removes the dependency of REGPARM on EXPERIMENTAL
> > > > - let REGPARM default to y
> > > 
> > > hm, a compromise.
> > > 
> > > One other concern I have with this is that I expect -mregparm will make
> > > kgdb (and now crashdump) less useful.  When incoming args are on the stack
> > > you have a good chance of being able to see what their value is by walking
> > > the stack slots.
> > > 
> > > When the incoming args are in registers I'd expect that it would be a lot
> > > harder (or impossible) to work out their value.
> > > 
> > > Have the kdump guys thought about (or encountered) this?
> 
> GDB is more than capable of handling this - if your compiler is saving
> arguments to the stack and dumping out useful information for the
> debugger about where it put them.  Recent GCC versions are generally
> pretty good about either saving the argument or clearly telling GDB
> that it was not saved.
>

Thanks. Any idea what might be amiss with my case where I am not seeing 
proper function parameter values while analyzing kdump generated crash
dump with gdb. I am using following gdb and gcc versions.

GNU gdb Red Hat Linux (6.1post-1.20040607.62rh)
gcc (GCC) 3.4.3 20041212 (Red Hat 3.4.3-9.EL4)

Inlined with the mail is a test patch. This patch just invokes func1()
and func2() upon reading a sysfs file "debug_stack" and finally calls panic()
and boots into a new kernel.

Associated stack traces retrieved from core dump file are available at 
following link.

http://marc.theaimsgroup.com/?l=linux-kernel&m=111988996408170&w=2

Thanks
Vivek



---

 linux-2.6.12-rc6-mm1-1M-root/kernel/ksysfs.c |   24 ++++++++++++++++++++++++
 1 files changed, 24 insertions(+)

diff -puN kernel/ksysfs.c~kdump-gdb-stack-debug kernel/ksysfs.c
--- linux-2.6.12-rc6-mm1-1M/kernel/ksysfs.c~kdump-gdb-stack-debug	2005-06-27 16:32:18.000000000 +0530
+++ linux-2.6.12-rc6-mm1-1M-root/kernel/ksysfs.c	2005-06-27 17:26:56.000000000 +0530
@@ -30,6 +30,19 @@ static ssize_t hotplug_seqnum_show(struc
 KERNEL_ATTR_RO(hotplug_seqnum);
 #endif
 
+int func2(int a, int *b, char c)
+{
+        printk("a=%d, b=%p, c=%c \n", a, b, c);
+	panic("Vivek: Invoked panic\n");
+	return 0;
+}
+int func1(int a, int *b, char c)
+{
+        printk("a=%d, b=%p, c=%c\n", a, b, c);
+        func2(a, b, c);
+	return 0;
+}
+
 #ifdef CONFIG_KEXEC
 #include <asm/kexec.h>
 
@@ -38,6 +51,16 @@ static ssize_t crash_notes_show(struct s
 	return sprintf(page, "%p\n", (void *)crash_notes);
 }
 KERNEL_ATTR_RO(crash_notes);
+static ssize_t stack_debug_show(struct subsystem *subsys, char *page)
+{
+	int a=20;
+	int *b=&a;
+	char c='d';
+	printk("Vivek: value of b is %p\n", b);
+	func1(a, b, c);
+	return sprintf(page, "%s\n", "Vivek copied");
+}
+KERNEL_ATTR_RO(stack_debug);
 #endif
 
 decl_subsys(kernel, NULL, NULL);
@@ -49,6 +72,7 @@ static struct attribute * kernel_attrs[]
 #endif
 #ifdef CONFIG_KEXEC
 	&crash_notes_attr.attr,
+	&stack_debug_attr.attr,
 #endif
 	NULL
 };
_
