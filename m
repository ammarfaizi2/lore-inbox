Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S315039AbSDWDWi>; Mon, 22 Apr 2002 23:22:38 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S315045AbSDWDWh>; Mon, 22 Apr 2002 23:22:37 -0400
Received: from sydney1.au.ibm.com ([202.135.142.193]:46864 "EHLO
	wagner.rustcorp.com.au") by vger.kernel.org with ESMTP
	id <S315039AbSDWDWh>; Mon, 22 Apr 2002 23:22:37 -0400
Date: Tue, 23 Apr 2002 13:25:24 +1000
From: Rusty Russell <rusty@rustcorp.com.au>
To: paulus@samba.org
Cc: rml@tech9.net, george@mvista.com, linux-kernel@vger.kernel.org
Subject: Re: in_interrupt race
Message-Id: <20020423132524.2056739f.rusty@rustcorp.com.au>
In-Reply-To: <15556.38775.439624.762586@argo.ozlabs.ibm.com>
X-Mailer: Sylpheed version 0.7.4 (GTK+ 1.2.10; powerpc-debian-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 23 Apr 2002 09:06:31 +1000 (EST)
Paul Mackerras <paulus@samba.org> wrote:
> No.  The point is that in_interrupt() asks two separate questions:
> (1) which cpu are we on?  (2) is that cpu in interrupt context?
> If we switch cpus between (1) and (2) then we can get a false positive
> from in_interrupt().

Yes: the old CPU happens to be processing an interrupt now.
The neat solution is to follow Linus' original instinct and make
PREEMPT an option only for UP: I only like preempt because it brings
UP into line with SMP, effectively enlarging the SMP userbase to reasonable
size.

diff -urN -I \$.*\$ --exclude TAGS -X /home/rusty/devel/kernel/kernel-patches/current-dontdiff --minimal linux-2.5.9/arch/i386/config.in working-2.5.9-preempt/arch/i386/config.in
--- linux-2.5.9/arch/i386/config.in	Tue Apr 23 11:39:32 2002
+++ working-2.5.9-preempt/arch/i386/config.in	Tue Apr 23 13:19:58 2002
@@ -184,7 +184,6 @@
 bool 'Math emulation' CONFIG_MATH_EMULATION
 bool 'MTRR (Memory Type Range Register) support' CONFIG_MTRR
 bool 'Symmetric multi-processing support' CONFIG_SMP
-bool 'Preemptible Kernel' CONFIG_PREEMPT
 if [ "$CONFIG_SMP" != "y" ]; then
    bool 'Local APIC support on uniprocessors' CONFIG_X86_UP_APIC
    dep_bool 'IO-APIC support on uniprocessors' CONFIG_X86_UP_IOAPIC $CONFIG_X86_UP_APIC
@@ -195,6 +194,7 @@
       define_bool CONFIG_X86_IO_APIC y
    fi
 else
+   bool 'Preemptible Kernel' CONFIG_PREEMPT 
    bool 'Multiquad NUMA system' CONFIG_MULTIQUAD
 fi
 
diff -urN -I \$.*\$ --exclude TAGS -X /home/rusty/devel/kernel/kernel-patches/current-dontdiff --minimal linux-2.5.9/arch/sparc64/config.in working-2.5.9-preempt/arch/sparc64/config.in
--- linux-2.5.9/arch/sparc64/config.in	Thu Mar 21 14:14:42 2002
+++ working-2.5.9-preempt/arch/sparc64/config.in	Tue Apr 23 13:20:48 2002
@@ -15,7 +15,7 @@
 define_bool CONFIG_VT_CONSOLE y
 
 bool 'Symmetric multi-processing support' CONFIG_SMP
-bool 'Preemptible kernel' CONFIG_PREEMPT
+dep_bool 'Preemptible kernel' CONFIG_PREEMPT $CONFIG_SMP
 
 # Identify this as a Sparc64 build
 define_bool CONFIG_SPARC64 y
diff -urN -I \$.*\$ --exclude TAGS -X /home/rusty/devel/kernel/kernel-patches/current-dontdiff --minimal linux-2.5.9/arch/x86_64/config.in working-2.5.9-preempt/arch/x86_64/config.in
--- linux-2.5.9/arch/x86_64/config.in	Tue Apr 23 11:39:33 2002
+++ working-2.5.9-preempt/arch/x86_64/config.in	Tue Apr 23 13:20:59 2002
@@ -42,7 +42,7 @@
 #currently broken:
 #bool 'MTRR (Memory Type Range Register) support' CONFIG_MTRR
 bool 'Symmetric multi-processing support' CONFIG_SMP
-bool 'Preemptible Kernel' CONFIG_PREEMPT
+dep_bool 'Preemptible Kernel' CONFIG_PREEMPT $CONFIG_SMP
 if [ "$CONFIG_SMP" = "y" -a "$CONFIG_X86_CMPXCHG" = "y" ]; then
     define_bool CONFIG_HAVE_DEC_LOCK y
 fi

-- 
   there are those who do and those who hang on and you don't see too
   many doers quoting their contemporaries.  -- Larry McVoy
