Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1161185AbWGIWgf@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161185AbWGIWgf (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 9 Jul 2006 18:36:35 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1161206AbWGIWgf
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 9 Jul 2006 18:36:35 -0400
Received: from ogre.sisk.pl ([217.79.144.158]:47558 "EHLO ogre.sisk.pl")
	by vger.kernel.org with ESMTP id S1161185AbWGIWgf (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 9 Jul 2006 18:36:35 -0400
From: "Rafael J. Wysocki" <rjw@sisk.pl>
To: Andrew Morton <akpm@osdl.org>
Subject: Re: 2.6.18-rc1-mm1 fails on amd64 (smp_call_function_single)
Date: Mon, 10 Jul 2006 00:37:14 +0200
User-Agent: KMail/1.9.3
Cc: gregoire.favre@gmail.com, linux-kernel@vger.kernel.org, ak@suse.de,
       Vojtech Pavlik <vojtech@suse.cz>
References: <20060709021106.9310d4d1.akpm@osdl.org> <200607092239.48065.rjw@sisk.pl> <20060709140322.fc5afac1.akpm@osdl.org>
In-Reply-To: <20060709140322.fc5afac1.akpm@osdl.org>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200607100037.14958.rjw@sisk.pl>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sunday 09 July 2006 23:03, Andrew Morton wrote:
> On Sun, 9 Jul 2006 22:39:48 +0200
> "Rafael J. Wysocki" <rjw@sisk.pl> wrote:
> 
> > On Sunday 09 July 2006 13:49, Gregoire Favre wrote:
> > > Hello,
> > > 
> > > can't compil it :
> > > 
> > >   CHK     include/linux/compile.h
> > >   UPD     include/linux/compile.h
> > >   CC      init/version.o
> > >   LD      init/built-in.o
> > >   LD      .tmp_vmlinux1
> > > arch/x86_64/kernel/built-in.o: In function `vsyscall_set_cpu':
> > > (.init.text+0x1e87): undefined reference to `smp_call_function_single'
> > > make: *** [.tmp_vmlinux1] Error 1
> > 
> > This is because of x86_64-mm-getcpu-vsyscall.patch which breaks
> > compilation without SMP and is not obviously fixable.
> 
> Is it not as simple as adding a !SMP implementation of
> smp_call_function_single(), which just calls the thing?

Like this:

 arch/x86_64/kernel/vsyscall.c |    6 ++++++
 1 files changed, 6 insertions(+)

Index: linux-2.6.18-rc1-mm1/arch/x86_64/kernel/vsyscall.c
===================================================================
--- linux-2.6.18-rc1-mm1.orig/arch/x86_64/kernel/vsyscall.c
+++ linux-2.6.18-rc1-mm1/arch/x86_64/kernel/vsyscall.c
@@ -241,10 +241,12 @@ static ctl_table kernel_root_table2[] = 
 
 #endif
 
+#ifdef CONFIG_SMP
 static void __cpuinit write_rdtscp_cb(void *info)
 {
 	write_rdtscp_aux((unsigned long)info);
 }
+#endif
 
 void __cpuinit vsyscall_set_cpu(int cpu)
 {
@@ -254,10 +256,14 @@ void __cpuinit vsyscall_set_cpu(int cpu)
 	node = cpu_to_node[cpu];
 #endif
 	if (cpu_has(&cpu_data[cpu], X86_FEATURE_RDTSCP)) {
+#ifdef CONFIG_SMP
 		/* the notifier is unfortunately not executed on the
 		   target CPU */
 		void *info = (void *)((node << 12) | cpu);
 		smp_call_function_single(cpu, write_rdtscp_cb, info, 0, 1);
+#else
+		write_rdtscp_aux(0);
+#endif
 	}
 
 	/* Store cpu number in limit so that it can be loaded quickly
