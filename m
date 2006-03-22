Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932727AbWCVVBg@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932727AbWCVVBg (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 22 Mar 2006 16:01:36 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932730AbWCVVBf
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 22 Mar 2006 16:01:35 -0500
Received: from fmr17.intel.com ([134.134.136.16]:57744 "EHLO
	orsfmr002.jf.intel.com") by vger.kernel.org with ESMTP
	id S932727AbWCVVBe (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 22 Mar 2006 16:01:34 -0500
Date: Wed, 22 Mar 2006 13:00:55 -0800
From: Ashok Raj <ashok.raj@intel.com>
To: "Rafael J. Wysocki" <rjw@sisk.pl>
Cc: Ashok Raj <ashok.raj@intel.com>, akpm@osdl.org,
       Peter Williams <pwil3058@bigpond.net.au>,
       Linus Torvalds <torvalds@osdl.org>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       Pavel Machek <pavel@suse.cz>
Subject: Re: Linux v2.6.16
Message-ID: <20060322130055.A15217@unix-os.sc.intel.com>
References: <Pine.LNX.4.64.0603192216450.3622@g5.osdl.org> <200603221911.06576.rjw@sisk.pl> <20060322102717.A12901@unix-os.sc.intel.com> <200603222140.00912.rjw@sisk.pl>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
In-Reply-To: <200603222140.00912.rjw@sisk.pl>; from rjw@sisk.pl on Wed, Mar 22, 2006 at 09:40:00PM +0100
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Mar 22, 2006 at 09:40:00PM +0100, Rafael J. Wysocki wrote:
> > 
> > with that patch, try
> > 
> > CONFIG_X86_PC=n
> > CONFIG_GENERICARCH=y
> > CONFIG_HOTPLUG_CPU=y
> 
> Well, there's nothing like CONFIG_GENERICARCH on x86_64 or I'm obviously
> missing something. :-)
> 
> On x86_64 I can choose between X86_PC and X86_VSMP and I'm not sure I'd like
> to set X86_VSMP just in order to be able to suspend a box with a dual-core CPU.
> IMHO that would be over the top.
> 

This change is only for i386.. check the patch, its introduced only for arch/i386/Kconfig

There is no change to x86_64, we anyway choose physflat mode in x86_64 which is exactly 
same as bigsmp in i386.

We didnt change anything in x86_64...Why this speculation :(

Iam attaching that patch for your reference here... in case you lost it and looking at 
some other patch. :-)

Could you _please_ really check this and tell me if there is real concern... its pretty
simple patch... no other arch is affected...


This patch makes CONFIG_HOTPLUG_CPU depend on !X86_PC, so we need to turn on 
either CONFIG_GENERICARCH, CONFIG_BIGSMP or any other subarch except X86_PC

With 2.6.15+ kernels when CONFIG_HOTPLUG_CPU is turned on we switch to bigsmp mode for
sending IPI's and ioapic configurations that caused the following error message.

>> More than 8 CPUs detected and CONFIG_X86_PC cannot handle it.
>> Use CONFIG_X86_GENERICARCH or CONFIG_X86_BIGSMP.

Originally bigsmp was added just to handle >8 cpus, but now with hotplug cpu support
we need to use bigsmp mode (why? see below), that cause the above error message even 
if there were less than 8 cpus in the system.

The message is bogus, but we are cannot use logical flat mode due to issues with
broadcast IPI can confuse a CPU just comming up. We use flat physical mode just like x86_64
case. More details on why bigsmp now uses flat physical mode (vs. cluster mode)
in following link.

http://marc.theaimsgroup.com/?l=linux-kernel&m=113261865814107&w=2


Signed-off-by: Ashok Raj <ashok.raj@intel.com>
---------------------------------------------------------

 arch/i386/Kconfig |    2 +-
 1 files changed, 1 insertion(+), 1 deletion(-)

Index: linux-2.6.16-rc6-mm1/arch/i386/Kconfig
===================================================================
--- linux-2.6.16-rc6-mm1.orig/arch/i386/Kconfig
+++ linux-2.6.16-rc6-mm1/arch/i386/Kconfig
@@ -760,7 +760,7 @@ config PHYSICAL_START
 
 config HOTPLUG_CPU
 	bool "Support for hot-pluggable CPUs (EXPERIMENTAL)"
-	depends on SMP && HOTPLUG && EXPERIMENTAL && !X86_VOYAGER
+	depends on SMP && HOTPLUG && EXPERIMENTAL && !X86_VOYAGER && !X86_PC
 	---help---
 	  Say Y here to experiment with turning CPUs off and on.  CPUs
 	  can be controlled through /sys/devices/system/cpu.
