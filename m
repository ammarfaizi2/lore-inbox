Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S276397AbRJCPhD>; Wed, 3 Oct 2001 11:37:03 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S276400AbRJCPgy>; Wed, 3 Oct 2001 11:36:54 -0400
Received: from hermes.toad.net ([162.33.130.251]:51687 "EHLO hermes.toad.net")
	by vger.kernel.org with ESMTP id <S276397AbRJCPgq>;
	Wed, 3 Oct 2001 11:36:46 -0400
Subject: Stelian Pop <stelian.pop@fr.alcove.com>
To: linux-kernel@vger.kernel.org
Date: Wed, 3 Oct 2001 11:35:50 -0400 (EDT)
X-Mailer: ELM [version 2.4ME+ PL73 (25)]
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Type: text/plain; charset=US-ASCII
Message-Id: <20011003153550.0A0D85AC@thanatos.toad.net>
From: jdthood@home.dhs.org (Thomas Hood)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Stelian Pop wrote:
>> Well, the funny thing is, the same kernel doesn't boot on a Dell Inspiron 
>> laptop either, if PNP is enabled -- and the oops is the same. So it's not 
>> just Sony...
>
>Maybe we'll need to test against something like 'pnp_broken' 
>variable instead of is_sony_vaio_laptop in PnP drivers, and
>add the callbacks in dmi_scan to initialize pnp_broken...

Yes, the "pnp_bios_dont_use_current_config" flag in the driver
can be set based on additional criteria.

I notice that both the Vaio and the Inspiron have Phoenix BIOSes.
So perhaps there is a class of Phoenix BIOSes we should be testing
for.  For the time being, we will need to add Ion Badulescu's Inspiron
to the dmi_blacklist.  Ion, can you give us the exact product name,
exact BIOS vendor name, exact BIOS version and exact BIOS date?
Also, let us know all the results of your tests of various kernels.

It's interesting to note that my IBM ThinkPad BIOS has a bug that
is similar to the bug in your BIOS.  After Linux is run, on the
subsequent boot the "current" config is not initialized from the
"boot" config; instead, all devices are left disabled.  This does
not happen if Windows was the previous OS run, or if the BIOS
is initialized before the boot.  My sneaking suspicion is that this
behavior is a "feature" of the BIOS: when certain of its functions
are accessed it deduces that it is being used by a Plug-n-Play
operating system (tm) and so refrains from configuring devices other
than the vital ones.  My workaround for now is to use "setpnp" to
switch on all the configurable devices.  The "right" solution may
be to use the ESCD functions of the BIOS.  Or it may be to stop
doing whatever it is that suggests to the BIOS that Linux is a
PnP OS.

I started noticing the failing-to-enable-devices behavior back 
around 2.4.7.  What was changed in the PnP BIOS driver around that
time?   [ ... time passes while Thomas looks at old patches ...]
Erm, HELLO!  I see that in 2.4.6-ac2, someone "cleaned up" the driver
so that all the BIOS calls were made through this function
"call_pnp_bios".  Here's the function:

----------------------------------------------------------------
static inline u16 call_pnp_bios(u16 func, u16 arg1, u16 arg2, u16 arg3,
                                u16 arg4, u16 arg5, u16 arg6, u16 arg7)
{
        unsigned long flags;
        u16 status;
 [...]
        __asm__ __volatile__(
                "pushl %%ebp\n\t"
                "pushl %%edi\n\t"
                "pushl %%esi\n\t"
                "pushl %%ds\n\t"
                "pushl %%es\n\t"
                "pushl %%fs\n\t"
                "pushl %%gs\n\t"
                "pushfl\n\t"
                "movl %%esp, pnp_bios_fault_esp\n\t"
                "movl $1f, pnp_bios_fault_eip\n\t"
                "lcall %5,%6\n\t"
                "1:popfl\n\t"
                "popl %%gs\n\t"
                "popl %%fs\n\t"
                "popl %%es\n\t"
                "popl %%ds\n\t"
                "popl %%esi\n\t"
                "popl %%edi\n\t"
                "popl %%ebp\n\t"
                : "=a" (status)
                : "0" ((func) | (arg1 << 16)),
                  "b" ((arg2) | (arg3 << 16)),
                  "c" ((arg4) | (arg5 << 16)),
                  "d" ((arg6) | (arg7 << 16)),
                  "i" (PNP_CS32),
                  "i" (0)
                : "memory"
        );
 [...]
}
----------------------------------------------------------------

Given that the args are u16s and u16s are unsigned shorts, it looks to me
as if this is going to zero out all the odd-numbered args.  But if that's
what's happening then I'm amazed this driver works at all.  I see that
in some cases the odd-numbered args are zero anyway, but in others not.
Result #1:  The driver isn't getting a real value for the maximum node size.
            But a random value will sometimes not oops the kernel.
Result #2:  PnP BIOS is sometimes getting 0 as its DS selector
Result #3:  The get_dev_node config selector is always 0 (should be 1 or 2)
Result #4:  The set_dev_node handle is 0; but this is duplicated in the
            node info structure, so the function may still work.  However,
            the selector number of the node data is wrong

I'm off to patch this bug and see if it fixes my problem.
It may fix the Sony and Dell problems too.

-- 
Thomas Hood
(Don't reply to the From: address but to jdthood_AT_yahoo.co.uk)
