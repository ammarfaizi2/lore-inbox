Return-Path: <linux-kernel-owner+willy=40w.ods.org-S965225AbWEaWt6@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965225AbWEaWt6 (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 31 May 2006 18:49:58 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965224AbWEaWt6
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 31 May 2006 18:49:58 -0400
Received: from mx2.mail.elte.hu ([157.181.151.9]:60805 "EHLO mx2.mail.elte.hu")
	by vger.kernel.org with ESMTP id S965223AbWEaWt5 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 31 May 2006 18:49:57 -0400
Date: Thu, 1 Jun 2006 00:50:13 +0200
From: Ingo Molnar <mingo@elte.hu>
To: Martin Bligh <mbligh@google.com>
Cc: "Martin J. Bligh" <mbligh@mbligh.org>, Andrew Morton <akpm@osdl.org>,
       linux-kernel@vger.kernel.org, apw@shadowen.org
Subject: Re: 2.6.17-rc5-mm1
Message-ID: <20060531225013.GA7125@elte.hu>
References: <20060531211530.GA2716@elte.hu> <447E0A49.4050105@mbligh.org> <20060531213340.GA3535@elte.hu> <447E0DEC.60203@mbligh.org> <20060531215315.GB4059@elte.hu> <447E11B5.7030203@mbligh.org> <20060531221242.GA5269@elte.hu> <447E16E6.7020804@google.com> <20060531223243.GC5269@elte.hu> <447E1A7B.2000200@google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <447E1A7B.2000200@google.com>
User-Agent: Mutt/1.4.2.1i
X-ELTE-SpamScore: -3.1
X-ELTE-SpamLevel: 
X-ELTE-SpamCheck: no
X-ELTE-SpamVersion: ELTE 2.0 
X-ELTE-SpamCheck-Details: score=-3.1 required=5.9 tests=ALL_TRUSTED,AWL,BAYES_50,UPPERCASE_25_50 autolearn=no SpamAssassin version=3.0.3
	-3.3 ALL_TRUSTED            Did not pass through any untrusted hosts
	0.0 BAYES_50               BODY: Bayesian spam probability is 40 to 60%
	[score: 0.5000]
	0.0 UPPERCASE_25_50        message body is 25-50% uppercase
	0.2 AWL                    AWL: From: address is in the auto white-list
X-ELTE-VirusStatus: clean
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


* Martin Bligh <mbligh@google.com> wrote:

> >>Adding new runs is easy. Changing the harness is hard ;-)
> >
> >
> >ok. How about a CONFIG_DEBUG_NO_OVERHEAD option, that would default to 
> >disabled but which you could set to y. Then we could make all the more 
> >expensive debug options:
> >
> >	default y if !CONFIG_DEBUG_NO_OVERHEAD
> >
> >this would still mean you'd have to turn off CONFIG_DEBUG_NO_OVERHEAD, 
> >but it would be automatically maintainable for you after that initial 
> >effort, and we'd be careful to always flag new debugging options with 
> >this flag, if they are expensive. And initially i'd define "expensive" 
> >as "anything that adds runtime overhead".
> >
> >would this be acceptable to you?
> 
> Sure, makes sense. I don't care which way up it is, ie 
> CONFIG_DEBUG_OVERHEAD vs CONFIG_DEBUG_NO_OVERHEAD, as long as it's 
> easily separable.
> 
> There's probably other debug stuff we can turn on too, if we do that.

i've attached an updated patch that renames 
DEBUG_KERNEL_RUNTIME_OVERHEAD to DEBUG_KERNEL_OVERHEAD :-)

i like the DEBUG_KERNEL_OVERHEAD approach a lot better, because it 
relieves you of this constant (and apparently often losing) battle with 
Kconfig default values. It also gives us freedom to mark most of the 
transparent debugging options as default-enabled.

i think i'll also do a DEBUG_KERNEL_ALLCHECKS flag that if set will 
select and enable all the transparent runtime checks. Often people just 
want to enable everything that still leaves us with a usable kernel, and 
filtering out those debug options can be a challenge.

	Ingo

Index: linux/lib/Kconfig.debug
===================================================================
--- linux.orig/lib/Kconfig.debug
+++ linux/lib/Kconfig.debug
@@ -54,6 +54,15 @@ config DEBUG_KERNEL
 	  Say Y here if you are developing drivers or trying to debug and
 	  identify kernel problems.
 
+config DEBUG_KERNEL_OVERHEAD
+	bool "Enable new debug options by default"
+	default y
+	help
+	  Say Y here if you want to have new debugging options
+	  enabled by default even if they cause runtime overhead.
+	  (you can still disable/enable them manually, independently
+	   of this switch)
+
 config LOG_BUF_SHIFT
 	int "Kernel log buffer size (16 => 64KB, 17 => 128KB)" if DEBUG_KERNEL
 	range 12 21
@@ -113,7 +122,7 @@ config DEBUG_SLAB
 config DEBUG_SLAB_LEAK
 	bool "Slab memory leak debugging"
 	depends on DEBUG_SLAB
-	default y
+	default y if DEBUG_KERNEL_OVERHEAD
 	help
 	  Enable /proc/slab_allocators - provides detailed information about
 	  which parts of the kernel are using slab objects.  May be used for
@@ -122,7 +131,7 @@ config DEBUG_SLAB_LEAK
 config DEBUG_PREEMPT
 	bool "Debug preemptible kernel"
 	depends on DEBUG_KERNEL && PREEMPT
-	default y
+	default y if DEBUG_KERNEL_OVERHEAD
 	depends on TRACE_IRQFLAGS_SUPPORT
 	help
 	  If you say Y here then the kernel will use a debug variant of the
@@ -132,7 +141,7 @@ config DEBUG_PREEMPT
 
 config DEBUG_MUTEXES
 	bool "Mutex debugging, basic checks"
-	default n
+	default y if DEBUG_KERNEL_OVERHEAD
 	depends on DEBUG_KERNEL
 	help
 	 This feature allows mutex semantics violations to be detected and
@@ -140,7 +149,7 @@ config DEBUG_MUTEXES
 
 config DEBUG_MUTEX_ALLOC
 	bool "Detect incorrect freeing of live mutexes"
-	default n
+	default y if DEBUG_KERNEL_OVERHEAD
 	depends on DEBUG_MUTEXES
 	help
 	 This feature will check whether any held mutex is incorrectly
@@ -150,7 +159,7 @@ config DEBUG_MUTEX_ALLOC
 
 config DEBUG_MUTEX_DEADLOCKS
 	bool "Detect mutex related deadlocks"
-	default n
+	default y if DEBUG_KERNEL_OVERHEAD
 	depends on DEBUG_MUTEXES
 	help
 	 This feature will automatically detect and report mutex related
@@ -158,7 +167,7 @@ config DEBUG_MUTEX_DEADLOCKS
 
 config DEBUG_RT_MUTEXES
 	bool "RT Mutex debugging, deadlock detection"
-	default n
+	default y if DEBUG_KERNEL_OVERHEAD
 	depends on DEBUG_KERNEL && RT_MUTEXES
 	help
 	 This allows rt mutex semantics violations and rt mutex related
@@ -166,7 +175,7 @@ config DEBUG_RT_MUTEXES
 
 config DEBUG_PI_LIST
 	bool
-	default n
+	default y if DEBUG_KERNEL_OVERHEAD
 	depends on DEBUG_RT_MUTEXES
 
 config RT_MUTEX_TESTER
@@ -179,6 +188,7 @@ config RT_MUTEX_TESTER
 config DEBUG_SPINLOCK
 	bool "Spinlock debugging"
 	depends on DEBUG_KERNEL
+	default y if DEBUG_KERNEL_OVERHEAD
 	help
 	  Say Y here and build SMP to catch missing spinlock initialization
 	  and certain other kinds of spinlock errors commonly made.  This is
@@ -188,7 +198,7 @@ config DEBUG_SPINLOCK
 config PROVE_SPIN_LOCKING
 	bool "Prove spin-locking correctness"
 	depends on X86
-	default n
+	default y if DEBUG_KERNEL_OVERHEAD
 	help
 	 This feature enables the kernel to prove that all spinlock
 	 locking that occurs in the kernel runtime is mathematically
@@ -226,7 +236,7 @@ config PROVE_SPIN_LOCKING
 config PROVE_RW_LOCKING
 	bool "Prove rw-locking correctness"
 	depends on X86
-	default n
+	default y if DEBUG_KERNEL_OVERHEAD
 	help
 	 This feature enables the kernel to prove that all rwlock
 	 locking that occurs in the kernel runtime is mathematically
@@ -264,7 +274,7 @@ config PROVE_RW_LOCKING
 config PROVE_MUTEX_LOCKING
 	bool "Prove mutex-locking correctness"
 	depends on X86
-	default n
+	default y if DEBUG_KERNEL_OVERHEAD
 	help
 	 This feature enables the kernel to prove that all mutexlock
 	 locking that occurs in the kernel runtime is mathematically
@@ -302,7 +312,7 @@ config PROVE_MUTEX_LOCKING
 config PROVE_RWSEM_LOCKING
 	bool "Prove rwsem-locking correctness"
 	depends on X86
-	default n
+	default y if DEBUG_KERNEL_OVERHEAD
 	help
 	 This feature enables the kernel to prove that all rwsemlock
 	 locking that occurs in the kernel runtime is mathematically
@@ -348,7 +358,7 @@ config LOCKDEP
 config DEBUG_LOCKDEP
 	bool "Lock dependency engine debugging"
 	depends on LOCKDEP
-	default y
+	default y if DEBUG_KERNEL_OVERHEAD
 	depends on TRACE_IRQFLAGS_SUPPORT
 	help
 	  If you say Y here, the lock dependency engine will do
@@ -363,6 +373,7 @@ config TRACE_IRQFLAGS
 
 config DEBUG_SPINLOCK_SLEEP
 	bool "Sleep-inside-spinlock checking"
+	default y if DEBUG_KERNEL_OVERHEAD
 	depends on DEBUG_KERNEL
 	help
 	  If you say Y here, various routines which may sleep will become very
@@ -390,6 +401,7 @@ config DEBUG_KOBJECT
 config DEBUG_HIGHMEM
 	bool "Highmem debugging"
 	depends on DEBUG_KERNEL && HIGHMEM
+	default y if DEBUG_KERNEL_OVERHEAD
 	help
 	  This options enables addition error checking for high memory systems.
 	  Disable for production systems.
@@ -398,7 +410,7 @@ config DEBUG_BUGVERBOSE
 	bool "Verbose BUG() reporting (adds 70K)" if DEBUG_KERNEL && EMBEDDED
 	depends on BUG
 	depends on ARM || ARM26 || M32R || M68K || SPARC32 || SPARC64 || X86_32 || FRV
-	default !EMBEDDED
+	default y if DEBUG_KERNEL_OVERHEAD && !EMBEDDED
 	help
 	  Say Y here to make BUG() panics output the file name and line number
 	  of the BUG call as well as the EIP and oops trace.  This aids
@@ -437,6 +449,7 @@ config DEBUG_FS
 config DEBUG_VM
 	bool "Debug VM"
 	depends on DEBUG_KERNEL
+	default y if DEBUG_KERNEL_OVERHEAD
 	help
 	  Enable this to turn on extended checks in the virtual-memory system
           that may impact performance.
@@ -446,7 +459,7 @@ config DEBUG_VM
 config FRAME_POINTER
 	bool "Compile the kernel with frame pointers"
 	depends on DEBUG_KERNEL && (X86 || CRIS || M68K || M68KNOMMU || FRV || UML)
-	default y
+	default y if DEBUG_KERNEL_OVERHEAD
 	help
 	  If you say Y here the resulting kernel image will be slightly larger
 	  and slower, but it might give very useful debugging information on
