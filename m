Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129098AbRBHNuV>; Thu, 8 Feb 2001 08:50:21 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S130605AbRBHNuM>; Thu, 8 Feb 2001 08:50:12 -0500
Received: from probity.mcc.ac.uk ([130.88.200.94]:33548 "EHLO
	probity.mcc.ac.uk") by vger.kernel.org with ESMTP
	id <S129098AbRBHNuC>; Thu, 8 Feb 2001 08:50:02 -0500
Date: Thu, 8 Feb 2001 13:50:00 +0000 (GMT)
From: John Levon <moz@compsoc.man.ac.uk>
To: alan@redhat.com, linux-kernel@vger.kernel.org
Subject: [PATCH] Small kernel-hacking.tmpl update
Message-ID: <Pine.LNX.4.21.0102081348160.16687-100000@mrworry.compsoc.man.ac.uk>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


I hope this is OK, comments more than welcome


--- Documentation/DocBook/kernel-hacking.tmpl.old	Tue Feb  6 20:06:15 2001
+++ Documentation/DocBook/kernel-hacking.tmpl	Tue Feb  6 21:14:42 2001
@@ -336,6 +336,11 @@
   </para>
 
   <para>
+   If all your routine does is read or write some parameter, consider
+   implementing a <function>sysctl</function> interface instead.
+  </para>
+
+  <para>
    Inside the ioctl you're in user context to a process.  When a
    error occurs you return a negated errno (see
    <filename class=headerfile>include/linux/errno.h</filename>),
@@ -407,7 +412,7 @@
   <para>
    Note that some functions may sleep implicitly: common ones are
    the user space access functions (*_user) and memory allocation
-   functions without GFP_ATOMIC.
+   functions without <symbol>GFP_ATOMIC</symbol>.
   </para>
 
   <para>
@@ -608,7 +613,8 @@
     for some weird device, you have a problem: it is poorly supported
     in Linux because after some time memory fragmentation in a running
     kernel makes it hard.  The best way is to allocate the block early
-    in the boot process.
+    in the boot process via the <function>alloc_bootmem()</function>
+    routine.
    </para>
 
    <para>
@@ -631,6 +637,20 @@
    </para>
   </sect1>
 
+  <sect1 id="routines-udelay">
+   <title><function>udelay()</function>/<function>mdelay()</function>
+     <filename class=headerfile>include/asm/delay.h</filename> 
+     <filename class=headerfile>include/linux/delay.h</filename> 
+   </title>
+
+   <para>
+    The <function>udelay()</function> function can be used for small pauses.
+    Do not use large values with <function>udelay()</function> as you risk
+    overflow - the helper function <function>mdelay()</function> is useful
+    here, or even consider <function>schedule_timeout()</function>.
+   </para> 
+  </sect1>
+ 
   <sect1 id="routines-local-irqs">
    <title><function>local_irq_save()</function>/<function>local_irq_restore()</function>
     <filename class=headerfile>include/asm/system.h</filename>
@@ -687,8 +707,14 @@
     modules this directive is currently ignored).  <type>__exit</type>
     is used to declare a function which is only required on exit: the
     function will be dropped if this file is not compiled as a module.
-    See the header file for use.
+    See the header file for use. Note that it makes no sense for a function
+    marked with <type>__init</type> to be exported to modules with 
+    <function>EXPORT_SYMBOL()</function> - this will break.
    </para>
+   <para>
+   Static data structures marked as <type>__initdata</type> must be initialised
+   (as opposed to ordinary static data which is zeroed BSS).
+   </para> 
 
   </sect1>
 
@@ -775,6 +801,21 @@
         return 0;
 }
    </programlisting>
+
+   <para>
+   You can often avoid having to deal with these problems by using the 
+   <structfield>owner</structfield> field of the 
+   <structname>file_operations</structname> structure. Set this field
+   as the macro <symbol>THIS_MODULE</symbol>.
+   </para>
+
+   <para>
+   For more complicated module unload locking requirements, you can set the
+   <structfield>can_unload</structfield> function pointer to your own routine,
+   which should return <returnvalue>0</returnvalue> if the module is
+   unloadable, or <returnvalue>-EBUSY</returnvalue> otherwise.
+   </para> 
+  
   </sect1>
  </chapter>
 
@@ -822,6 +863,17 @@
     <returnvalue>-ERESTARTSYS</returnvalue> if a signal is received.
     The <function>wait_event()</function> version ignores signals.
    </para>
+   <para>
+   Do not use the <function>sleep_on()</function> function family -
+   it is very easy to accidentally introduce races; almost certainly
+   one of the <function>wait_event()</function> family will do, or a
+   loop around <function>schedule_timeout()</function>. If you choose
+   to loop around <function>schedule_timeout()</function> remember
+   you must set the task state (with 
+   <function>set_current_state()</function>) on each iteration to avoid
+   busy-looping.
+   </para>
+ 
   </sect1>
 
   <sect1 id="queue-waking">
@@ -1212,6 +1264,13 @@
      <filename>MAINTAINERS</filename> means you want to be consulted
      when changes are made to a subsystem, and hear about bugs; it
      implies a more-than-passing commitment to some part of the code.
+    </para>
+   </listitem>
+   
+   <listitem>
+    <para>
+     Finally, don't forget to read <filename>Documentation/SubmittingPatches</filename>
+     and possibly <filename>Documentation/SubmittingDrivers</filename>.
     </para>
    </listitem>
   </itemizedlist>


-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
