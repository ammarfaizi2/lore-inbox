Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S314067AbSDKOO2>; Thu, 11 Apr 2002 10:14:28 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S314069AbSDKOO1>; Thu, 11 Apr 2002 10:14:27 -0400
Received: from e1.ny.us.ibm.com ([32.97.182.101]:753 "EHLO e1.ny.us.ibm.com")
	by vger.kernel.org with ESMTP id <S314067AbSDKOO0>;
	Thu, 11 Apr 2002 10:14:26 -0400
Date: Thu, 11 Apr 2002 19:45:43 +0530
From: Suparna Bhattacharya <suparna@in.ibm.com>
To: Andy Pfiffer <andyp@osdl.org>
Cc: "Eric W. Biederman" <ebiederm@xmission.com>,
        "Martin J. Bligh" <Martin.Bligh@us.ibm.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: Faster reboots (and a better way of taking crashdumps?)
Message-ID: <20020411194543.B1947@in.ibm.com>
Reply-To: suparna@in.ibm.com
In-Reply-To: <1759496962.1018114339@[10.10.2.3]> <m18z80nrxc.fsf@frodo.biederman.org> <3CB1A9A8.1155722E@in.ibm.com> <m1ofgum81l.fsf@frodo.biederman.org> <20020409205636.A1234@in.ibm.com> <m1y9fvlfyb.fsf@frodo.biederman.org> <1018461522.4453.212.camel@andyp>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Apr 10, 2002 at 10:58:42AM -0700, Andy Pfiffer wrote:
> On Wed, 2002-04-10 at 08:40, Eric W. Biederman wrote:
> 
> > Unless I missed something the Linux kernel won't work on smp though.
> > It is a matter of resetting the state of the apics, and ensuring you
> > are running on the first processor.  I don't believe bootimg did/does that.
> > 
> 
> The copy of bootimg that I have makes no effort to offline CPU's or
> reset the APICs.  If there is a newer version, I could not find it.

Not the old bootimg code that I had found, but the mclx crash dump
code based on bootimg includes these modifications. 

Something like this runs on all cpu's as part of the crash code,
where machine_restart calls bootimg directly if configured.

+/*
+ *  If we are not the panicking thread, we simply halt.  Otherwise,
+ *  we take care of calling the reboot code.
+ */
+#ifdef CONFIG_SMP
+	if (!boot_cpu) {
+		stop_this_cpu(NULL);
+		/* NOTREACHED */
+	}
+#endif
+
+	machine_restart(NULL)

And the following code added along the init path:

diff -urN linux-2.4.17-vanilla/init/main.c linux-2.4.17-mcore/init/main.c
--- linux-2.4.17-vanilla/init/main.c	Fri Dec 21 12:42:04 2001
+++ linux-2.4.17-mcore/init/main.c	Fri Jan 11 11:04:52 2002
@@ -580,6 +593,15 @@
 
 	kmem_cache_init();
 	sti();
+#if defined(CONFIG_BOOTIMG) && defined(CONFIG_X86_LOCAL_APIC)
+	/* If we don't make sure the APIC is enabled, AND the LVT0
+	 * register is programmed properly, we won't get timer interrupts
+	 */
+	setup_local_APIC();
+	
+	value = apic_read(APIC_LVT0);
+	apic_write_around(APIC_LVT0, value & ~APIC_LVT_MASKED);
+#endif
 	calibrate_delay();
 #ifdef CONFIG_BLK_DEV_INITRD
 	if (initrd_start && !initrd_below_start_ok &&



> 
> I have tried 3 different solutions for for Linux-reloading-linux
> (bootimg, two-kernel monte, and kexec), and none of them fully support
> the kinds of enterprise-class systems we (OSDL) care about:
> 
> 	1. multiprocessor x86 (p3, p4, +xeons) with APICs
> 	2. >4GB memory
> 	3. CPU hotplug
> 	4. device hotplug
> 	5. >= 2.5.x kernel
> 
> In fact, I have yet to find any variation of linux-loading-linux that
> works at all on the 2-way P4-Xeon under my desk or the 8-way P3-Xeon in
> the lab.  The only system I have ever seen Two Kernel Monte work on here
> is a Celeron-based machine in a nearby cube.
> 
> Why do we care about this?  Rebooting these kinds of sytsems can take
> several minutes, and in my sample of the systems in the lab, ~80% of the
> reboot time is spent slogging through the platform's firmware, ~20% of
> the time is spent between LILO and login:.  80% of several minutes is
> often greater than the allowable annual downtime for some enterprise
> systems.
> 
> What about LinxuBIOS?  While an attractive solution for many, it is a
> long, uphill battle to add support for chipset after chipset, and
> motherboard after motherboard.
> 
> The >4GB of memory problem is an interesting quirk -- if the
> linux-loading-linux implementation assumes that it can perform the final
> copy in 32-bit protected mode *without* paging enabled, it won't
> reliably work on >4GB systems.

Isn't the image copied into kernel pages/buffers within allowable ranges
first (when loading the image) ?

> 
> > In general yes.  There are some interesting side effects though.
> > Going through the pci bus and shutting off bus masters is a good
> > first approximation of what needs to happen.
> > 
> 
> The new device model from Pat (mochel@osdl.org) is probably the best way
> to go here; you'll be able to walk the driver tree and reliably turn off
> devices.

Yes, I had discussed this with him sometime back to understand if his
model would support what we need. Conditions are more stringent or 
less reliable in a crash scenario, but still this looks like the 
right direction.

> 
> For the CPU side of things, the CPU hotplug work looks promising as
> well.
> 
> Andy
> 
