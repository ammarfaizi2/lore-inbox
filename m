Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S131567AbRAMAG4>; Fri, 12 Jan 2001 19:06:56 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S135791AbRAMAGr>; Fri, 12 Jan 2001 19:06:47 -0500
Received: from colorfullife.com ([216.156.138.34]:12294 "EHLO colorfullife.com")
	by vger.kernel.org with ESMTP id <S131567AbRAMAGi>;
	Fri, 12 Jan 2001 19:06:38 -0500
Message-ID: <3A5F9C00.959DF2BB@colorfullife.com>
Date: Sat, 13 Jan 2001 01:06:24 +0100
From: Manfred Spraul <manfred@colorfullife.com>
X-Mailer: Mozilla 4.75 [en] (X11; U; Linux 2.2.16-22 i586)
X-Accept-Language: en
MIME-Version: 1.0
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
CC: Frank de Lange <frank@unternet.org>, dwmw2@infradead.org,
        linux-kernel@vger.kernel.org, mingo@elte.hu, torvalds@transmeta.com
Subject: Re: QUESTION: Network hangs with BP6 and 2.4.x kernels, hardware
In-Reply-To: <E14HDjY-0005Ei-00@the-village.bc.nu>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Alan Cox wrote:
> 
> > Could you disable both bandaids? I disabled them, no problems so far.
> > Now back to the disable_irq_nosync().
> 
> Ok so it looks like the disable_irq code is buggy. Unfortunately its not
> just used for these drivers they are just the heaviest users.
> 
> Given that we can see the IRQ is still set on the APIC can we fake an IRQ in
> that condition ?

Switch to edge triggered, wait , switch back to level triggered - I've
added that to my sysrq commands, and it clears the IRR bit in the IO
APIC. Sometimes 2 or 3 attempts are required.

I tried several changes to the ioapic code, but without success.

I found:
* the io_apic_sync() in __mask_IO_APIC_irq() is probably wrong, I'd say
it should be _after_ the io_apic_modify, but currently it is before the
io_apic_modify(). 2.2 uses the same code, that doesn't explain the
problem.

* this comment in
http://oss.sgi.com/www.linux.sgi.com/intel/visws/visws.2210.28jul99.patch

+/* XXX ouch... is this really our only choice for masking this
interrupt? */
+/* XXX not fully safe for 2 reasons:
+ *     1) should not touch an apic entry while (whole) apic is enabled
+ *     2) careful about storing to IRR bit (unless we know this intr is
idle)
+ */
+static void disable_cobalt_irq(unsigned int irq)       /* disable_irq()
*/
+{
+       int ent = is_co_apic(irq);
+       if (ent == -1) {
+               return; /* could actually be a panic */
+       }
+
+       /* Note: h/w nada like read-mod-write!  Vec saved in
IRQ_VECTOR() */
+       co_apic_write(CO_APIC_LO(ent), CO_APIC_MASK);
+       (void)co_apic_read(CO_APIC_LO(ent)); /* sync cpu to cobalt apic
*/
+}
+
It's possible that the comment is about an cobalt specific problem, the
IRR bit is - according the Intel documentation - read only.


--
	Manfred
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
