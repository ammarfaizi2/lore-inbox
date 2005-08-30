Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751381AbVH3ATX@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751381AbVH3ATX (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 29 Aug 2005 20:19:23 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751426AbVH3ATX
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 29 Aug 2005 20:19:23 -0400
Received: from fmr17.intel.com ([134.134.136.16]:3036 "EHLO
	orsfmr002.jf.intel.com") by vger.kernel.org with ESMTP
	id S1751381AbVH3ATW (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 29 Aug 2005 20:19:22 -0400
Date: Mon, 29 Aug 2005 17:19:05 -0700
From: Rusty Lynch <rusty@linux.intel.com>
To: Andi Kleen <ak@suse.de>
Cc: Christoph Lameter <clameter@engr.sgi.com>,
       Rusty Lynch <rusty.lynch@intel.com>, linux-mm@kvack.org,
       prasanna@in.ibm.com, linux-ia64@vger.kernel.org,
       linux-kernel@vger.kernel.org, anil.s.keshavamurthy@intel.com
Subject: Re: [PATCH] Only process_die notifier in ia64_do_page_fault if KPROBES is configured.
Message-ID: <20050830001905.GA18279@linux.jf.intel.com>
References: <200508262246.j7QMkEoT013490@linux.jf.intel.com> <Pine.LNX.4.62.0508261559450.17433@schroedinger.engr.sgi.com> <200508270224.26423.ak@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200508270224.26423.ak@suse.de>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Aug 27, 2005 at 02:24:25AM +0200, Andi Kleen wrote:
> On Saturday 27 August 2005 01:05, Christoph Lameter wrote:
> > On Fri, 26 Aug 2005, Rusty Lynch wrote:
> > > Just to be sure everyone understands the overhead involved, kprobes only
> > > registers a single notifier.  If kprobes is disabled (CONFIG_KPROBES is
> > > off) then the overhead on a page fault is the overhead to execute an
> > > empty notifier chain.
> >
> > Its the overhead of using registers to pass parameters, performing a
> > function call that does nothing etc. A waste of computing resources. All
> > of that unconditionally in a performance critical execution path that
> > is executed a gazillion times for an optional feature that I frankly
> > find not useful at all and that is disabled by default.
> 
> In the old days notifier_call_chain used to be inline. Then someone looking
> at code size out of lined it. Perhaps it should be inlined again or notifier.h
> could supply a special faster inline version for time critical code.
> 
> Then it would be simple if (global_var != NULL) { ... } in the fast path.
> In addition the call chain could be declared __read_mostly.
> 
> I suspect with these changes Christoph's concerns would go away, right?
> 
> -Andi

So, assuming inlining the notifier_call_chain would address Christoph's
conserns, is the following patch something like what you are sugesting?  
This would make all the kdebug.h::notify_die() calls use the inline version. 

(WARNING:  The following has only been tested on ia64.)

 include/asm-i386/kdebug.h    |    2 +-
 include/asm-ia64/kdebug.h    |    2 +-
 include/asm-ppc64/kdebug.h   |    2 +-
 include/asm-sparc64/kdebug.h |    2 +-
 include/asm-x86_64/kdebug.h  |    2 +-
 include/linux/notifier.h     |   18 ++++++++++++++++++
 kernel/sys.c                 |   14 +-------------
 7 files changed, 24 insertions(+), 18 deletions(-)

Index: linux-2.6.13/include/linux/notifier.h
===================================================================
--- linux-2.6.13.orig/include/linux/notifier.h
+++ linux-2.6.13/include/linux/notifier.h
@@ -72,5 +72,23 @@ extern int notifier_call_chain(struct no
 #define CPU_DOWN_FAILED		0x0006 /* CPU (unsigned)v NOT going down */
 #define CPU_DEAD		0x0007 /* CPU (unsigned)v dead */
 
+static inline int fast_notifier_call_chain(struct notifier_block **n,
+					   unsigned long val, void *v)
+{
+	int ret=NOTIFY_DONE;
+	struct notifier_block *nb = *n;
+
+	while(nb)
+	{
+		ret=nb->notifier_call(nb,val,v);
+		if(ret&NOTIFY_STOP_MASK)
+		{
+			return ret;
+		}
+		nb=nb->next;
+	}
+	return ret;
+}
+
 #endif /* __KERNEL__ */
 #endif /* _LINUX_NOTIFIER_H */
Index: linux-2.6.13/kernel/sys.c
===================================================================
--- linux-2.6.13.orig/kernel/sys.c
+++ linux-2.6.13/kernel/sys.c
@@ -169,19 +169,7 @@ EXPORT_SYMBOL(notifier_chain_unregister)
  
 int notifier_call_chain(struct notifier_block **n, unsigned long val, void *v)
 {
-	int ret=NOTIFY_DONE;
-	struct notifier_block *nb = *n;
-
-	while(nb)
-	{
-		ret=nb->notifier_call(nb,val,v);
-		if(ret&NOTIFY_STOP_MASK)
-		{
-			return ret;
-		}
-		nb=nb->next;
-	}
-	return ret;
+	return fast_notifier_call_chain(n, val, v);
 }
 
 EXPORT_SYMBOL(notifier_call_chain);
Index: linux-2.6.13/include/asm-ia64/kdebug.h
===================================================================
--- linux-2.6.13.orig/include/asm-ia64/kdebug.h
+++ linux-2.6.13/include/asm-ia64/kdebug.h
@@ -55,7 +55,7 @@ static inline int notify_die(enum die_va
 		.signr  = sig
 	};
 
-	return notifier_call_chain(&ia64die_chain, val, &args);
+	return fast_notifier_call_chain(&ia64die_chain, val, &args);
 }
 
 #endif
Index: linux-2.6.13/include/asm-i386/kdebug.h
===================================================================
--- linux-2.6.13.orig/include/asm-i386/kdebug.h
+++ linux-2.6.13/include/asm-i386/kdebug.h
@@ -44,7 +44,7 @@ enum die_val {
 static inline int notify_die(enum die_val val,char *str,struct pt_regs *regs,long err,int trap, int sig)
 {
 	struct die_args args = { .regs=regs, .str=str, .err=err, .trapnr=trap,.signr=sig };
-	return notifier_call_chain(&i386die_chain, val, &args);
+	return fast_notifier_call_chain(&i386die_chain, val, &args);
 }
 
 #endif
Index: linux-2.6.13/include/asm-ppc64/kdebug.h
===================================================================
--- linux-2.6.13.orig/include/asm-ppc64/kdebug.h
+++ linux-2.6.13/include/asm-ppc64/kdebug.h
@@ -37,7 +37,7 @@ enum die_val {
 static inline int notify_die(enum die_val val,char *str,struct pt_regs *regs,long err,int trap, int sig)
 {
 	struct die_args args = { .regs=regs, .str=str, .err=err, .trapnr=trap,.signr=sig };
-	return notifier_call_chain(&ppc64_die_chain, val, &args);
+	return fast_notifier_call_chain(&ppc64_die_chain, val, &args);
 }
 
 #endif
Index: linux-2.6.13/include/asm-sparc64/kdebug.h
===================================================================
--- linux-2.6.13.orig/include/asm-sparc64/kdebug.h
+++ linux-2.6.13/include/asm-sparc64/kdebug.h
@@ -46,7 +46,7 @@ static inline int notify_die(enum die_va
 				 .trapnr	= trap,
 				 .signr		= sig };
 
-	return notifier_call_chain(&sparc64die_chain, val, &args);
+	return fast_notifier_call_chain(&sparc64die_chain, val, &args);
 }
 
 #endif
Index: linux-2.6.13/include/asm-x86_64/kdebug.h
===================================================================
--- linux-2.6.13.orig/include/asm-x86_64/kdebug.h
+++ linux-2.6.13/include/asm-x86_64/kdebug.h
@@ -38,7 +38,7 @@ enum die_val { 
 static inline int notify_die(enum die_val val,char *str,struct pt_regs *regs,long err,int trap, int sig)
 { 
 	struct die_args args = { .regs=regs, .str=str, .err=err, .trapnr=trap,.signr=sig }; 
-	return notifier_call_chain(&die_chain, val, &args); 
+	return fast_notifier_call_chain(&die_chain, val, &args);
 } 
 
 extern int printk_address(unsigned long address);
