Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262417AbVHAH0v@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262417AbVHAH0v (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 1 Aug 2005 03:26:51 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262425AbVHAH0u
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 1 Aug 2005 03:26:50 -0400
Received: from ozlabs.org ([203.10.76.45]:20197 "EHLO ozlabs.org")
	by vger.kernel.org with ESMTP id S262417AbVHAH0L (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 1 Aug 2005 03:26:11 -0400
Subject: [PATCH] Update Documentation/DocBook/kernel-hacking.tmpl
From: Rusty Russell <rusty@rustcorp.com.au>
To: Andrew Morton <akpm@osdl.org>
Cc: lkml - Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain
Date: Mon, 01 Aug 2005 17:26:09 +1000
Message-Id: <1122881171.8000.8.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Evolution 2.2.3 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This has been sitting around for at least two years.  Ran through it
briefly again and submitting now.  More work welcome.

Cheers,
Rusty.

Name: Update Hacking Guide For 2.6
Signed-off-by: Rusty Russell <rusty@rustcorp.com.au> (authored)

Update the hacking guide, before CONFIG_PREEMPT_RT goes in and it
needs rewriting again.

Changes include modernization of quotes, removal of most references to
bottom halves (some mention required because we still use bh in places
to mean softirq).

It would be nice to have a discussion of sparse and various
annotations.  Please send patches straight to akpm.

Index: linux-2.6.13-rc4-git3-Misc/Documentation/DocBook/kernel-hacking.tmpl
===================================================================
--- linux-2.6.13-rc4-git3-Misc.orig/Documentation/DocBook/kernel-hacking.tmpl	2005-07-15 04:38:25.000000000 +1000
+++ linux-2.6.13-rc4-git3-Misc/Documentation/DocBook/kernel-hacking.tmpl	2005-08-01 17:16:59.000000000 +1000
@@ -8,8 +8,7 @@
   
   <authorgroup>
    <author>
-    <firstname>Paul</firstname>
-    <othername>Rusty</othername>
+    <firstname>Rusty</firstname>
     <surname>Russell</surname>
     <affiliation>
      <address>
@@ -20,7 +19,7 @@
   </authorgroup>
 
   <copyright>
-   <year>2001</year>
+   <year>2005</year>
    <holder>Rusty Russell</holder>
   </copyright>
 
@@ -64,7 +63,7 @@
  <chapter id="introduction">
   <title>Introduction</title>
   <para>
-   Welcome, gentle reader, to Rusty's Unreliable Guide to Linux
+   Welcome, gentle reader, to Rusty's Remarkably Unreliable Guide to Linux
    Kernel Hacking.  This document describes the common routines and
    general requirements for kernel code: its goal is to serve as a
    primer for Linux kernel development for experienced C
@@ -96,13 +95,13 @@
 
    <listitem>
     <para>
-     not associated with any process, serving a softirq, tasklet or bh;
+     not associated with any process, serving a softirq or tasklet;
     </para>
    </listitem>
 
    <listitem>
     <para>
-     running in kernel space, associated with a process;
+     running in kernel space, associated with a process (user context);
     </para>
    </listitem>
 
@@ -114,11 +113,12 @@
   </itemizedlist>
 
   <para>
-   There is a strict ordering between these: other than the last
-   category (userspace) each can only be pre-empted by those above.
-   For example, while a softirq is running on a CPU, no other
-   softirq will pre-empt it, but a hardware interrupt can.  However,
-   any other CPUs in the system execute independently.
+   There is an ordering between these.  The bottom two can preempt
+   each other, but above that is a strict hierarchy: each can only be
+   preempted by the ones above it.  For example, while a softirq is
+   running on a CPU, no other softirq will preempt it, but a hardware
+   interrupt can.  However, any other CPUs in the system execute
+   independently.
   </para>
 
   <para>
@@ -130,10 +130,10 @@
    <title>User Context</title>
 
    <para>
-    User context is when you are coming in from a system call or
-    other trap: you can sleep, and you own the CPU (except for
-    interrupts) until you call <function>schedule()</function>.  
-    In other words, user context (unlike userspace) is not pre-emptable.
+    User context is when you are coming in from a system call or other
+    trap: like userspace, you can be preempted by more important tasks
+    and by interrupts.  You can sleep, by calling
+    <function>schedule()</function>.
    </para>
 
    <note>
@@ -153,7 +153,7 @@
 
    <caution>
     <para>
-     Beware that if you have interrupts or bottom halves disabled 
+     Beware that if you have preemption or softirqs disabled
      (see below), <function>in_interrupt()</function> will return a 
      false positive.
     </para>
@@ -168,10 +168,10 @@
     <hardware>keyboard</hardware> are examples of real
     hardware which produce interrupts at any time.  The kernel runs
     interrupt handlers, which services the hardware.  The kernel
-    guarantees that this handler is never re-entered: if another
+    guarantees that this handler is never re-entered: if the same
     interrupt arrives, it is queued (or dropped).  Because it
     disables interrupts, this handler has to be fast: frequently it
-    simply acknowledges the interrupt, marks a `software interrupt'
+    simply acknowledges the interrupt, marks a 'software interrupt'
     for execution and exits.
    </para>
 
@@ -188,60 +188,52 @@
   </sect1>
 
   <sect1 id="basics-softirqs">
-   <title>Software Interrupt Context: Bottom Halves, Tasklets, softirqs</title>
+   <title>Software Interrupt Context: Softirqs and Tasklets</title>
 
    <para>
     Whenever a system call is about to return to userspace, or a
-    hardware interrupt handler exits, any `software interrupts'
+    hardware interrupt handler exits, any 'software interrupts'
     which are marked pending (usually by hardware interrupts) are
     run (<filename>kernel/softirq.c</filename>).
    </para>
 
    <para>
     Much of the real interrupt handling work is done here.  Early in
-    the transition to <acronym>SMP</acronym>, there were only `bottom 
+    the transition to <acronym>SMP</acronym>, there were only 'bottom 
     halves' (BHs), which didn't take advantage of multiple CPUs.  Shortly 
     after we switched from wind-up computers made of match-sticks and snot,
-    we abandoned this limitation.
+    we abandoned this limitation and switched to 'softirqs'.
    </para>
 
    <para>
     <filename class="headerfile">include/linux/interrupt.h</filename> lists the
-    different BH's.  No matter how many CPUs you have, no two BHs will run at 
-    the same time. This made the transition to SMP simpler, but sucks hard for
-    scalable performance.  A very important bottom half is the timer
-    BH (<filename class="headerfile">include/linux/timer.h</filename>): you
-    can register to have it call functions for you in a given length of time.
+    different softirqs.  A very important softirq is the
+    timer softirq (<filename
+    class="headerfile">include/linux/timer.h</filename>): you can
+    register to have it call functions for you in a given length of
+    time.
    </para>
 
    <para>
-    2.3.43 introduced softirqs, and re-implemented the (now
-    deprecated) BHs underneath them.  Softirqs are fully-SMP
-    versions of BHs: they can run on as many CPUs at once as
-    required.  This means they need to deal with any races in shared
-    data using their own locks.  A bitmask is used to keep track of
-    which are enabled, so the 32 available softirqs should not be
-    used up lightly.  (<emphasis>Yes</emphasis>, people will
-    notice).
-   </para>
-
-   <para>
-    tasklets (<filename class="headerfile">include/linux/interrupt.h</filename>)
-    are like softirqs, except they are dynamically-registrable (meaning you 
-    can have as many as you want), and they also guarantee that any tasklet 
-    will only run on one CPU at any time, although different tasklets can 
-    run simultaneously (unlike different BHs).  
+    Softirqs are often a pain to deal with, since the same softirq
+    will run simultaneously on more than one CPU.  For this reason,
+    tasklets (<filename
+    class="headerfile">include/linux/interrupt.h</filename>) are more
+    often used: they are dynamically-registrable (meaning you can have
+    as many as you want), and they also guarantee that any tasklet
+    will only run on one CPU at any time, although different tasklets
+    can run simultaneously.
    </para>
    <caution>
     <para>
-     The name `tasklet' is misleading: they have nothing to do with `tasks', 
+     The name 'tasklet' is misleading: they have nothing to do with 'tasks', 
      and probably more to do with some bad vodka Alexey Kuznetsov had at the 
      time.
     </para>
    </caution>
 
    <para>
-    You can tell you are in a softirq (or bottom half, or tasklet)
+    You can tell you are in a softirq (or tasklet)
     using the <function>in_softirq()</function> macro 
     (<filename class="headerfile">include/linux/interrupt.h</filename>).
    </para>
@@ -288,11 +280,10 @@
     <term>A rigid stack limit</term>
     <listitem>
      <para>
-      The kernel stack is about 6K in 2.2 (for most
-      architectures: it's about 14K on the Alpha), and shared
-      with interrupts so you can't use it all.  Avoid deep
-      recursion and huge local arrays on the stack (allocate
-      them dynamically instead).
+      Depending on configuration options the kernel stack is about 3K to 6K for most 32-bit architectures: it's
+      about 14K on most 64-bit archs, and often shared with interrupts
+      so you can't use it all.  Avoid deep recursion and huge local
+      arrays on the stack (allocate them dynamically instead).
      </para>
     </listitem>
    </varlistentry>
@@ -339,7 +330,7 @@
 
   <para>
    If all your routine does is read or write some parameter, consider
-   implementing a <function>sysctl</function> interface instead.
+   implementing a <function>sysfs</function> interface instead.
   </para>
 
   <para>
@@ -417,7 +408,10 @@
   </para>
 
   <para>
-   You will eventually lock up your box if you break these rules.  
+   You should always compile your kernel
+   <symbol>CONFIG_DEBUG_SPINLOCK_SLEEP</symbol> on, and it will warn
+   you if you break these rules.  If you <emphasis>do</emphasis> break
+   the rules, you will eventually lock up your box.
   </para>
 
   <para>
@@ -515,8 +509,7 @@
       success).
      </para>
     </caution>
-    [Yes, this moronic interface makes me cringe.  Please submit a
-    patch and become my hero --RR.]
+    [Yes, this moronic interface makes me cringe.  The flamewar comes up every year or so. --RR.]
    </para>
    <para>
     The functions may sleep implicitly. This should never be called
@@ -587,10 +580,11 @@
    </variablelist>
 
    <para>
-    If you see a <errorname>kmem_grow: Called nonatomically from int
-    </errorname> warning message you called a memory allocation function
-    from interrupt context without <constant>GFP_ATOMIC</constant>.
-    You should really fix that.  Run, don't walk.
+    If you see a <errorname>sleeping function called from invalid
+    context</errorname> warning message, then maybe you called a
+    sleeping allocation function from interrupt context without
+    <constant>GFP_ATOMIC</constant>.  You should really fix that.
+    Run, don't walk.
    </para>
 
    <para>
@@ -639,16 +633,16 @@
   </sect1>
 
   <sect1 id="routines-udelay">
-   <title><function>udelay()</function>/<function>mdelay()</function>
+   <title><function>mdelay()</function>/<function>udelay()</function>
      <filename class="headerfile">include/asm/delay.h</filename>
      <filename class="headerfile">include/linux/delay.h</filename>
    </title>
 
    <para>
-    The <function>udelay()</function> function can be used for small pauses.
-    Do not use large values with <function>udelay()</function> as you risk
+    The <function>udelay()</function> and <function>ndelay()</function> functions can be used for small pauses.
+    Do not use large values with them as you risk
     overflow - the helper function <function>mdelay()</function> is useful
-    here, or even consider <function>schedule_timeout()</function>.
+    here, or consider <function>msleep()</function>.
    </para> 
   </sect1>
  
@@ -698,8 +692,8 @@
     These routines disable soft interrupts on the local CPU, and
     restore them.  They are reentrant; if soft interrupts were
     disabled before, they will still be disabled after this pair
-    of functions has been called.  They prevent softirqs, tasklets
-    and bottom halves from running on the current CPU.
+    of functions has been called.  They prevent softirqs and tasklets
+    from running on the current CPU.
    </para>
   </sect1>
 
@@ -708,10 +702,16 @@
     <filename class="headerfile">include/asm/smp.h</filename></title>
    
    <para>
-    <function>smp_processor_id()</function> returns the current
-    processor number, between 0 and <symbol>NR_CPUS</symbol> (the
-    maximum number of CPUs supported by Linux, currently 32).  These
-    values are not necessarily continuous.
+    <function>get_cpu()</function> disables preemption (so you won't
+    suddenly get moved to another CPU) and returns the current
+    processor number, between 0 and <symbol>NR_CPUS</symbol>.  Note
+    that the CPU numbers are not necessarily continuous.  You return
+    it again with <function>put_cpu()</function> when you are done.
+   </para>
+   <para>
+    If you know you cannot be preempted by another task (ie. you are
+    in interrupt context, or have preemption disabled) you can use
+    smp_processor_id().
    </para>
   </sect1>
 
@@ -722,19 +722,14 @@
    <para>
     After boot, the kernel frees up a special section; functions
     marked with <type>__init</type> and data structures marked with
-    <type>__initdata</type> are dropped after boot is complete (within
-    modules this directive is currently ignored).  <type>__exit</type>
+    <type>__initdata</type> are dropped after boot is complete: similarly
+    modules discard this memory after initialization.  <type>__exit</type>
     is used to declare a function which is only required on exit: the
     function will be dropped if this file is not compiled as a module.
     See the header file for use. Note that it makes no sense for a function
     marked with <type>__init</type> to be exported to modules with 
     <function>EXPORT_SYMBOL()</function> - this will break.
    </para>
-   <para>
-   Static data structures marked as <type>__initdata</type> must be initialised
-   (as opposed to ordinary static data which is zeroed BSS) and cannot be 
-   <type>const</type>.
-   </para> 
 
   </sect1>
 
@@ -762,9 +757,8 @@
    <para>
     The function can return a negative error number to cause
     module loading to fail (unfortunately, this has no effect if
-    the module is compiled into the kernel).  For modules, this is
-    called in user context, with interrupts enabled, and the
-    kernel lock held, so it can sleep.
+    the module is compiled into the kernel).  This function is
+    called in user context with interrupts enabled, so it can sleep.
    </para>
   </sect1>
   
@@ -779,6 +773,34 @@
     reached zero.  This function can also sleep, but cannot fail:
     everything must be cleaned up by the time it returns.
    </para>
+
+   <para>
+    Note that this macro is optional: if it is not present, your
+    module will not be removable (except for 'rmmod -f').
+   </para>
+  </sect1>
+
+  <sect1 id="routines-module-use-counters">
+   <title> <function>try_module_get()</function>/<function>module_put()</function>
+    <filename class="headerfile">include/linux/module.h</filename></title>
+
+   <para>
+    These manipulate the module usage count, to protect against
+    removal (a module also can't be removed if another module uses one
+    of its exported symbols: see below).  Before calling into module
+    code, you should call <function>try_module_get()</function> on
+    that module: if it fails, then the module is being removed and you
+    should act as if it wasn't there.  Otherwise, you can safely enter
+    the module, and call <function>module_put()</function> when you're
+    finished.
+   </para>
+
+   <para>
+   Most registerable structures have an
+   <structfield>owner</structfield> field, such as in the
+   <structname>file_operations</structname> structure. Set this field
+   to the macro <symbol>THIS_MODULE</symbol>.
+   </para>
   </sect1>
 
  <!-- add info on new-style module refcounting here -->
@@ -821,7 +843,7 @@
     There is a macro to do this:
     <function>wait_event_interruptible()</function>
 
-    <filename class="headerfile">include/linux/sched.h</filename> The
+    <filename class="headerfile">include/linux/wait.h</filename> The
     first argument is the wait queue head, and the second is an
     expression which is evaluated; the macro returns
     <returnvalue>0</returnvalue> when this expression is true, or
@@ -847,10 +869,11 @@
    <para>
     Call <function>wake_up()</function>
 
-    <filename class="headerfile">include/linux/sched.h</filename>;,
+    <filename class="headerfile">include/linux/wait.h</filename>;,
     which will wake up every process in the queue.  The exception is
     if one has <constant>TASK_EXCLUSIVE</constant> set, in which case
-    the remainder of the queue will not be woken.
+    the remainder of the queue will not be woken.  There are other variants
+    of this basic function available in the same header.
    </para>
   </sect1>
  </chapter>
@@ -863,7 +886,7 @@
    first class of operations work on <type>atomic_t</type>
 
    <filename class="headerfile">include/asm/atomic.h</filename>; this
-   contains a signed integer (at least 24 bits long), and you must use
+   contains a signed integer (at least 32 bits long), and you must use
    these functions to manipulate or read atomic_t variables.
    <function>atomic_read()</function> and
    <function>atomic_set()</function> get and set the counter,
@@ -882,13 +905,12 @@
 
   <para>
    Note that these functions are slower than normal arithmetic, and
-   so should not be used unnecessarily.  On some platforms they
-   are much slower, like 32-bit Sparc where they use a spinlock.
+   so should not be used unnecessarily.
   </para>
 
   <para>
-   The second class of atomic operations is atomic bit operations on a
-   <type>long</type>, defined in
+   The second class of atomic operations is atomic bit operations on an
+   <type>unsigned long</type>, defined in
 
    <filename class="headerfile">include/linux/bitops.h</filename>.  These
    operations generally take a pointer to the bit pattern, and a bit
@@ -899,7 +921,7 @@
    <function>test_and_clear_bit()</function> and
    <function>test_and_change_bit()</function> do the same thing,
    except return true if the bit was previously set; these are
-   particularly useful for very simple locking.
+   particularly useful for atomically setting flags.
   </para>
   
   <para>
@@ -907,12 +929,6 @@
    than BITS_PER_LONG.  The resulting behavior is strange on big-endian
    platforms though so it is a good idea not to do this.
   </para>
-
-  <para>
-   Note that the order of bits depends on the architecture, and in
-   particular, the bitfield passed to these operations must be at
-   least as large as a <type>long</type>.
-  </para>
  </chapter>
 
  <chapter id="symbols">
@@ -932,11 +948,8 @@
     <filename class="headerfile">include/linux/module.h</filename></title>
 
    <para>
-    This is the classic method of exporting a symbol, and it works
-    for both modules and non-modules.  In the kernel all these
-    declarations are often bundled into a single file to help
-    genksyms (which searches source files for these declarations).
-    See the comment on genksyms and Makefiles below.
+    This is the classic method of exporting a symbol: dynamically
+    loaded modules will be able to use the symbol as normal.
    </para>
   </sect1>
 
@@ -949,7 +962,8 @@
     symbols exported by <function>EXPORT_SYMBOL_GPL()</function> can
     only be seen by modules with a
     <function>MODULE_LICENSE()</function> that specifies a GPL
-    compatible license.
+    compatible license.  It implies that the function is considered 
+    an internal implementation issue, and not really an interface.
    </para>
   </sect1>
  </chapter>
@@ -962,12 +976,13 @@
     <filename class="headerfile">include/linux/list.h</filename></title>
 
    <para>
-    There are three sets of linked-list routines in the kernel
-    headers, but this one seems to be winning out (and Linus has
-    used it).  If you don't have some particular pressing need for
-    a single list, it's a good choice.  In fact, I don't care
-    whether it's a good choice or not, just use it so we can get
-    rid of the others.
+    There used to be three sets of linked-list routines in the kernel
+    headers, but this one is the winner.  If you don't have some
+    particular pressing need for a single list, it's a good choice.
+   </para>
+
+   <para>
+    In particular, <function>list_for_each_entry</function> is useful.
    </para>
   </sect1>
 
@@ -979,14 +994,13 @@
     convention, and return <returnvalue>0</returnvalue> for success,
     and a negative error number
     (eg. <returnvalue>-EFAULT</returnvalue>) for failure.  This can be
-    unintuitive at first, but it's fairly widespread in the networking
-    code, for example.
+    unintuitive at first, but it's fairly widespread in the kernel.
    </para>
 
    <para>
-    The filesystem code uses <function>ERR_PTR()</function>
+    Using <function>ERR_PTR()</function>
 
-    <filename class="headerfile">include/linux/fs.h</filename>; to
+    <filename class="headerfile">include/linux/err.h</filename>; to
     encode a negative error number into a pointer, and
     <function>IS_ERR()</function> and <function>PTR_ERR()</function>
     to get it back out again: avoids a separate pointer parameter for
@@ -1040,7 +1054,7 @@
     supported, due to lack of general use, but the following are
     considered standard (see the GCC info page section "C
     Extensions" for more details - Yes, really the info page, the
-    man page is only a short summary of the stuff in info):
+    man page is only a short summary of the stuff in info).
    </para>
    <itemizedlist>
     <listitem>
@@ -1091,7 +1105,7 @@
     </listitem>
     <listitem>
      <para>
-      Function names as strings (__FUNCTION__)
+      Function names as strings (__func__).
      </para>
     </listitem>
     <listitem>
@@ -1164,63 +1178,35 @@
    <listitem>
     <para>
      Usually you want a configuration option for your kernel hack.
-     Edit <filename>Config.in</filename> in the appropriate directory
-     (but under <filename>arch/</filename> it's called
-     <filename>config.in</filename>).  The Config Language used is not
-     bash, even though it looks like bash; the safe way is to use only
-     the constructs that you already see in
-     <filename>Config.in</filename> files (see
-     <filename>Documentation/kbuild/kconfig-language.txt</filename>).
-     It's good to run "make xconfig" at least once to test (because
-     it's the only one with a static parser).
-    </para>
-
-    <para>
-     Variables which can be Y or N use <type>bool</type> followed by a
-     tagline and the config define name (which must start with
-     CONFIG_).  The <type>tristate</type> function is the same, but
-     allows the answer M (which defines
-     <symbol>CONFIG_foo_MODULE</symbol> in your source, instead of
-     <symbol>CONFIG_FOO</symbol>) if <symbol>CONFIG_MODULES</symbol>
-     is enabled.
+     Edit <filename>Kconfig</filename> in the appropriate directory.
+     The Config language is simple to use by cut and paste, and there's
+     complete documentation in 
+     <filename>Documentation/kbuild/kconfig-language.txt</filename>.
     </para>
 
     <para>
      You may well want to make your CONFIG option only visible if
      <symbol>CONFIG_EXPERIMENTAL</symbol> is enabled: this serves as a
      warning to users.  There many other fancy things you can do: see
-     the various <filename>Config.in</filename> files for ideas.
+     the various <filename>Kconfig</filename> files for ideas.
     </para>
-   </listitem>
 
-   <listitem>
     <para>
-     Edit the <filename>Makefile</filename>: the CONFIG variables are
-     exported here so you can conditionalize compilation with `ifeq'.
-     If your file exports symbols then add the names to
-     <varname>export-objs</varname> so that genksyms will find them.
-     <caution>
-      <para>
-       There is a restriction on the kernel build system that objects
-       which export symbols must have globally unique names.
-       If your object does not have a globally unique name then the
-       standard fix is to move the
-       <function>EXPORT_SYMBOL()</function> statements to their own
-       object with a unique name.
-       This is why several systems have separate exporting objects,
-       usually suffixed with ksyms.
-      </para>
-     </caution>
+     In your description of the option, make sure you address both the
+     expert user and the user who knows nothing about your feature.  Mention
+     incompatibilities and issues here.  <emphasis> Definitely
+     </emphasis> end your description with <quote> if in doubt, say N
+     </quote> (or, occasionally, `Y'); this is for people who have no
+     idea what you are talking about.
     </para>
    </listitem>
 
    <listitem>
     <para>
-     Document your option in Documentation/Configure.help.  Mention
-     incompatibilities and issues here.  <emphasis> Definitely
-     </emphasis> end your description with <quote> if in doubt, say N
-     </quote> (or, occasionally, `Y'); this is for people who have no
-     idea what you are talking about.
+     Edit the <filename>Makefile</filename>: the CONFIG variables are
+     exported here so you can usually just add a "obj-$(CONFIG_xxx) +=
+     xxx.o" line.  The syntax is documented in
+     <filename>Documentation/kbuild/makefiles.txt</filename>.
     </para>
    </listitem>
 
@@ -1253,20 +1239,12 @@
   </para>
 
   <para>
-   <filename>include/linux/brlock.h:</filename>
+   <filename>include/asm-i386/delay.h:</filename>
   </para>
   <programlisting>
-extern inline void br_read_lock (enum brlock_indices idx)
-{
-        /*
-         * This causes a link-time bug message if an
-         * invalid index is used:
-         */
-        if (idx >= __BR_END)
-                __br_lock_usage_bug();
-
-        read_lock(&amp;__brlock_array[smp_processor_id()][idx]);
-}
+#define ndelay(n) (__builtin_constant_p(n) ? \
+        ((n) > 20000 ? __bad_ndelay() : __const_udelay((n) * 5ul)) : \
+        __ndelay(n))
   </programlisting>
 
   <para>

-- 
A bad analogy is like a leaky screwdriver -- Richard Braakman

