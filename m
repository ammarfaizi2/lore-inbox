Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261289AbUKSIWl@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261289AbUKSIWl (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 19 Nov 2004 03:22:41 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261298AbUKSIWl
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 19 Nov 2004 03:22:41 -0500
Received: from siaag1ab.compuserve.com ([149.174.40.4]:62939 "EHLO
	siaag1ab.compuserve.com") by vger.kernel.org with ESMTP
	id S261289AbUKSIWi (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 19 Nov 2004 03:22:38 -0500
Date: Fri, 19 Nov 2004 03:19:34 -0500
From: Chuck Ebbert <76306.1226@compuserve.com>
Subject: Re: X86_64: Many Lost ticks
To: Andi Kleen <ak@suse.de>
Cc: "kernel-stuff@comcast.net" <kernel-stuff@comcast.net>,
       Alan Cox <alan@lxorguk.ukuu.org.uk>,
       linux-kernel <linux-kernel@vger.kernel.org>,
       Zwane Mwaikambo <zwane@linuxpower.ca>
Message-ID: <200411190322_MC3-1-8EFA-5B2@compuserve.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Type: text/plain;
	 charset=us-ascii
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 18 Nov 2004 at 19:50:32 +0100, Andi Kleen wrote:

> On Thu, Nov 18, 2004 at 05:10:17PM +0000, Alan Cox wrote:
>
> > Ok ACPI timer override probably goes back into the broken bucket and out
> > of -ac in -ac11 then.
>
> The timer override should be fine (I have confirmation from Nvidia
> about this). The only thing that you can take out if you're conservative
> is the change to not disable the IOAPIC by default when Nvidia 
> is detected (in check_ioapic()) 


I did that long ago; the below patch is dated Oct 28 on my fileserver.

Alan could save himself some work if we shared patches... I already
backported even more of the networking stuff to 2.6.9 than he did.

# ioapic_on_nvidia_boards.patch
#
#       Originally suggested by Zwane Mwaikumbo
#
#       Ignore all ACPI timer overrides on all Nvidia boards.  The fallback doesn't
#       work and no Nvidia boards needs a timer override.  But some buggy BIOS have
#       it anyways.
#
#       Thanks to Andy Currid for confirming this.
#
#       Original patch enabled the IO-APIC.
#       Enable of IO-APIC removed by Chuck Ebbert <76306.1226@compuserve.com>
#
#       Signed-off-by: Andi Kleen <ak@suse.de>
#       Signed-off-by: Andrew Morton <akpm@osdl.org>
#       Signed-off-by: Chuck Ebbert <76306.1226@compuserve.com>
#
--- 2.6.9/arch/x86_64/kernel/io_apic.c
+++ 2.6.9.1/arch/x86_64/kernel/io_apic.c
@@ -271,6 +271,14 @@ void __init check_ioapic(void) 
                                               num,slot,vendor); 
                                        skip_ioapic_setup = 1;
 #endif
+#ifdef CONFIG_ACPI
+                                       /* All timer overrides on Nvidia
+                                          seem to be wrong. Skip them. */
+                                       printk(KERN_INFO 
+            "Nvidia board detected. Ignoring ACPI timer override.\n");
+                                       acpi_skip_timer_override = 1;
+                                       /* RED-PEN skip them on mptables too? */
+#endif
                                        return;
                                } 
 
--- 2.6.9/include/asm-x86_64/acpi.h
+++ 2.6.9.1/include/asm-x86_64/acpi.h
@@ -166,6 +166,8 @@ extern int acpi_pci_disabled;
 
 extern u8 x86_acpiid_to_apicid[];
 
+extern int acpi_skip_timer_override;
+
 #endif /*__KERNEL__*/
 
 #endif /*_ASM_ACPI_H*/

--Chuck Ebbert  19-Nov-04  03:19:18
