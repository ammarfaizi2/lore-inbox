Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263207AbUDMBOc (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 12 Apr 2004 21:14:32 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263214AbUDMBOb
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 12 Apr 2004 21:14:31 -0400
Received: from gizmo10bw.bigpond.com ([144.140.70.20]:36268 "HELO
	gizmo10bw.bigpond.com") by vger.kernel.org with SMTP
	id S263207AbUDMBOR (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 12 Apr 2004 21:14:17 -0400
From: Ross Dickson <ross@datscreative.com.au>
Reply-To: ross@datscreative.com.au
Organization: Dat's Creative Pty Ltd
To: christian.kroener@tu-harburg.de
Subject: Re: IO-APIC on nforce2   
Date: Tue, 13 Apr 2004 11:17:31 +1000
User-Agent: KMail/1.5.1
Cc: linux-kernel@vger.kernel.org, "Maciej W. Rozycki" <macro@ds2.pg.gda.pl>,
       Len Brown <len.brown@intel.com>
MIME-Version: 1.0
Content-Type: Multipart/Mixed;
  boundary="Boundary-00=_r+zeAud4mRYnMnX"
Message-Id: <200404131117.31306.ross@datscreative.com.au>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--Boundary-00=_r+zeAud4mRYnMnX
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

Christian Kr=F6ner wrote

> I got a problem using LOCAL APIC and IO-APIC on my uniprocessor nforce2 b=
oard.=20
> With recent kernels (latest -mm and 2.6.5-linus) the timer irq gets set t=
o=20
> XT-PIC, which results in having a constant hi-load of 15% (after booting)=
 to=20
> about 25% (after having the system run about 12 h). Earlier versions of -=
mm=20
> set the timer-irq to IO-APIC-level (or edge, i dont remember it well) and=
 i=20
> never had any constant hi-load with these versions. Since mainline kernel=
=20
> versions never ever set the timer irq to IO-APIC-{level,edge} i used to p=
atch=20
> them with the ross' nforce-patches, so that the timer-irq gets to be=20
> IO-APCI-edge, which worked even though the patch applied with offset. Any=
ways=20
> with the latest mm-kernels these patches dont work anymore. I could apply=
=20
> them with offset but it seems the code isn't used or something else is wr=
ong=20
> since the timer-irq stays XT-PIC, which results in the problems above. Co=
uld=20
> anyone point out, how to resolve this problem or tell me what I could do,=
 to=20
> get my timer-irq right? I'm sure willing to test patches...=20
> Thanks in advance, christian.=20
> -=20


Hi Christian

I don't know why the high load on xtpic except maybe heaps of spurious irq'=
s=20
under the hood.

I am working with 2.4.26-rc2 and have noticed a change with the the recent =
acpi?
update. The recent fix to stop unnecessary ioapic irq routing entries puts =
the=20
following if statement into io_apic.c, io_apic_set_pci_routing()

	/*
	 * IRQs < 16 are already in the irq_2_pin[] map
	 */
	if (irq >=3D 16)
		add_pin_to_irq(irq, ioapic, pin);

which prevents my io-apic patch from using that function to reprogram the
io-apic pin on irq0 from pin2 to pin0.=20

As a quick fix you could drop the "if (irq >=3D 16)".
I don't know what harm if any that would do other than create unwanted
irq mapping entries as in the past.

As a better solution to work with the new code I have created a function to
change the pin an irq comes into the io-apic on and also re-initialise the=
=20
io-apic to deal with the change.=20

Here is the function for 2.4.26-rc2.

/*
 * reroute irq to different pin clearing old and enabling new
 */
static void __init replace_IO_APIC_pin_at_irq(unsigned int irq,
						int oldapic, int oldpin,
						int newapic, int newpin)
{
	struct IO_APIC_route_entry entry;
	unsigned long flags;
	/*
	 * read oldapic entry
	 */
	spin_lock_irqsave(&ioapic_lock, flags);
	*(((int*)&entry) + 0) =3D io_apic_read(oldapic, 0x10 + 2 * oldpin);
	*(((int*)&entry) + 1) =3D io_apic_read(oldapic, 0x11 + 2 * oldpin);
	spin_unlock_irqrestore(&ioapic_lock, flags);
	/*
	 * Check delivery_mode to be sure we're not clearing an SMI pin
	 */
	if (entry.delivery_mode =3D=3D dest_SMI)
		return;
	/*
	 * clear oldpin on oldapic
	 */
	clear_IO_APIC_pin(oldapic, oldpin);
	/*
	 * reroute irq to newpin on newapic
	 */
	replace_pin_at_irq(irq, oldapic, oldpin, newapic, newpin);
	/*
	 * Enable newpin on newapic
	*/
	spin_lock_irqsave(&ioapic_lock, flags);
	io_apic_write(newapic, 0x10 + 2*newpin, *(((int *)&entry) + 0));
	io_apic_write(newapic, 0x11 + 2*newpin, *(((int *)&entry) + 1));
	spin_unlock_irqrestore(&ioapic_lock, flags);
}

I am now using this instead of the io_apic_set_pci_routing().
My modified check_timer() to work with it is as follows.

/*
 * This code may look a bit paranoid, but it's supposed to cooperate with
 * a wide range of boards and BIOS bugs.  Fortunately only the timer IRQ
 * is so screwy.  Thanks to Brian Perkins for testing/hacking this beast
 * fanatically on his truly buggy board.
 */
static inline void check_timer(void)
{
	extern int timer_ack;
	int pin1, pin2;
	int vector, i;

	/*
	 * get/set the timer IRQ vector:
	 */
	disable_8259A_irq(0);
	vector =3D assign_irq_vector(0);
	set_intr_gate(vector, interrupt[0]);

	/*
	 * Subtle, code in do_timer_interrupt() expects an AEOI
	 * mode for the 8259A whenever interrupts are routed
	 * through I/O APICs.  Also IRQ0 has to be enabled in
	 * the 8259A which implies the virtual wire has to be
	 * disabled in the local APIC.
	 */
	apic_write_around(APIC_LVT0, APIC_LVT_MASKED | APIC_DM_EXTINT);
	init_8259A(1);
	timer_ack =3D 1;
	enable_8259A_irq(0);

	pin1 =3D find_isa_irq_pin(0, mp_INT);
	pin2 =3D find_isa_irq_pin(0, mp_ExtINT);

	printk(KERN_INFO "..TIMER: vector=3D0x%02X pin1=3D%d pin2=3D%d\n", vector,=
 pin1, pin2);

	if (pin1 !=3D -1) {
		for(i=3D0;i<2;i++) {
			/*
			 * Ok, does IRQ0 through the IOAPIC work?
			 */
			unmask_IO_APIC_irq(0);
			if (timer_irq_works()) {
				if (nmi_watchdog =3D=3D NMI_IO_APIC) {
					disable_8259A_irq(0);
					setup_nmi();
					enable_8259A_irq(0);
					check_nmi_watchdog();
				}
				printk(KERN_INFO "..TIMER: works OK on IO-APIC irq0\n" );
				return;
			}
			mask_IO_APIC_irq(0);
			if(!i) { /* try INTIN0 if INTIN2 failed */
				printk(KERN_ERR "..MP-BIOS bug: 8254 timer not connected to IO-APIC INT=
IN%d\n",pin1);
				printk(KERN_INFO "..TIMER: Check if 8254 timer connected to IO-APIC INT=
IN0? ...\n");
				replace_IO_APIC_pin_at_irq(0, 0, pin1, 0, 0);
				timer_ack=3D0;
				disable_8259A_irq(0);
			} else { /* restore settings */
				clear_IO_APIC_pin(0, 0);
				printk(KERN_ERR "..TIMER: 8254 timer not connected to IO-APIC INTIN0\n"=
);
				timer_ack=3D1;
				enable_8259A_irq(0);
			}
		}
	}

	printk(KERN_INFO "...trying to set up timer (IRQ0) through the 8259A ... "=
);
	if (pin2 !=3D -1) {
		printk("\n..... (found pin %d) ...", pin2);
		/*
		 * legacy devices should be connected to IO APIC #0
		 */
		setup_ExtINT_IRQ0_pin(pin2, vector);
		if (timer_irq_works()) {
			printk("works.\n");
			if (pin1 !=3D -1)
				replace_pin_at_irq(0, 0, pin1, 0, pin2);
			else
				add_pin_to_irq(0, 0, pin2);
			if (nmi_watchdog =3D=3D NMI_IO_APIC) {
				setup_nmi();
				check_nmi_watchdog();
			}
			return;
		}
		/*
		 * Cleanup, just in case ...
		 */
		clear_IO_APIC_pin(0, pin2);
	}
	printk(" failed.\n");

	if (nmi_watchdog) {
		printk(KERN_WARNING "timer doesn't work through the IO-APIC - disabling N=
MI Watchdog!\n");
		nmi_watchdog =3D 0;
	}

	printk(KERN_INFO "...trying to set up timer as Virtual Wire IRQ...");

	disable_8259A_irq(0);
	irq_desc[0].handler =3D &lapic_irq_type;
	apic_write_around(APIC_LVT0, APIC_DM_FIXED | vector);	/* Fixed mode */
	enable_8259A_irq(0);

	if (timer_irq_works()) {
		printk(" works.\n");
		return;
	}
	apic_write_around(APIC_LVT0, APIC_LVT_MASKED | APIC_DM_FIXED | vector);
	printk(" failed.\n");

	printk(KERN_INFO "...trying to set up timer as ExtINT IRQ...");

	init_8259A(0);
	make_8259A_irq(0);
	apic_write_around(APIC_LVT0, APIC_DM_EXTINT);

	unlock_ExtINT_logic();

	if (timer_irq_works()) {
		printk(" works.\n");
		return;
	}
	printk(" failed :(.\n");
	panic("IO-APIC + timer doesn't work! pester mingo@redhat.com");
}

This version loops twice on the "pin1" attempt, firstly trying the bios ass=
igned
pin, then trying pin0 with no timer acks and the 8259 xtpic disabled.

I have not as yet downloaded 2.6.5xxx
=46rom memory this 2.4.26-rc2 code should be very similar to the (2.6.5-lin=
us)
but a bit different to the -mm series. For the -mm series I think you can d=
rop
the "timer_ack=3D" lines from my changes as it still has Maciej Rozycki's 8=
259=20
ack patch? The timer ack should already have been correctly set to off by i=
t's
checking if the apic is an integrated one.

Here are the changes as a diff on the io_apic.c in 2.4.26-rc2

=2D-- io_apic.c.orig	2004-04-08 15:56:53.000000000 +1000
+++ io_apic.c	2004-04-10 02:33:02.000000000 +1000
@@ -197,10 +197,48 @@ static void clear_IO_APIC (void)
 		for (pin =3D 0; pin < nr_ioapic_registers[apic]; pin++)
 			clear_IO_APIC_pin(apic, pin);
 }

 /*
+ * reroute irq to different pin clearing old and enabling new
+ */
+static void __init replace_IO_APIC_pin_at_irq(unsigned int irq,
+						int oldapic, int oldpin,
+						int newapic, int newpin)
+{
+	struct IO_APIC_route_entry entry;
+	unsigned long flags;
+	/*
+	 * read oldapic entry
+	 */
+	spin_lock_irqsave(&ioapic_lock, flags);
+	*(((int*)&entry) + 0) =3D io_apic_read(oldapic, 0x10 + 2 * oldpin);
+	*(((int*)&entry) + 1) =3D io_apic_read(oldapic, 0x11 + 2 * oldpin);
+	spin_unlock_irqrestore(&ioapic_lock, flags);
+	/*
+	 * Check delivery_mode to be sure we're not clearing an SMI pin
+	 */
+	if (entry.delivery_mode =3D=3D dest_SMI)
+		return;
+	/*
+	 * clear oldpin on oldapic
+	 */
+	clear_IO_APIC_pin(oldapic, oldpin);
+	/*
+	 * reroute irq to newpin on newapic
+	 */
+	replace_pin_at_irq(irq, oldapic, oldpin, newapic, newpin);
+	/*
+	 * Enable newpin on newapic
+	*/
+	spin_lock_irqsave(&ioapic_lock, flags);
+	io_apic_write(newapic, 0x10 + 2*newpin, *(((int *)&entry) + 0));
+	io_apic_write(newapic, 0x11 + 2*newpin, *(((int *)&entry) + 1));
+	spin_unlock_irqrestore(&ioapic_lock, flags);
+}
+
+/*
  * support for broken MP BIOSs, enables hand-redirection of PIRQ0-7 to
  * specific CPU-side IRQs.
  */

 #define MAX_PIRQS 8
@@ -1582,11 +1620,11 @@ static inline void unlock_ExtINT_logic(v
  */
 static inline void check_timer(void)
 {
 	extern int timer_ack;
 	int pin1, pin2;
=2D	int vector;
+	int vector, i;

 	/*
 	 * get/set the timer IRQ vector:
 	 */
 	disable_8259A_irq(0);
@@ -1609,25 +1647,39 @@ static inline void check_timer(void)
 	pin2 =3D find_isa_irq_pin(0, mp_ExtINT);

 	printk(KERN_INFO "..TIMER: vector=3D0x%02X pin1=3D%d pin2=3D%d\n", vector=
, pin1, pin2);

 	if (pin1 !=3D -1) {
=2D		/*
=2D		 * Ok, does IRQ0 through the IOAPIC work?
=2D		 */
=2D		unmask_IO_APIC_irq(0);
=2D		if (timer_irq_works()) {
=2D			if (nmi_watchdog =3D=3D NMI_IO_APIC) {
+		for(i=3D0;i<2;i++) {
+			/*
+			 * Ok, does IRQ0 through the IOAPIC work?
+			 */
+			unmask_IO_APIC_irq(0);
+			if (timer_irq_works()) {
+				if (nmi_watchdog =3D=3D NMI_IO_APIC) {
+					disable_8259A_irq(0);
+					setup_nmi();
+					enable_8259A_irq(0);
+					check_nmi_watchdog();
+				}
+				printk(KERN_INFO "..TIMER: works OK on IO-APIC irq0\n" );
+				return;
+			}
+			mask_IO_APIC_irq(0);
+			if(!i) { /* try INTIN0 if INTIN2 failed */
+				printk(KERN_ERR "..MP-BIOS bug: 8254 timer not connected to IO-APIC IN=
TIN%d\n",pin1);
+				printk(KERN_INFO "..TIMER: Check if 8254 timer connected to IO-APIC IN=
TIN0? ...\n");
+				replace_IO_APIC_pin_at_irq(0, 0, pin1, 0, 0);
+				timer_ack=3D0;
 				disable_8259A_irq(0);
=2D				setup_nmi();
+			} else { /* restore settings */
+				clear_IO_APIC_pin(0, 0);
+				printk(KERN_ERR "..TIMER: 8254 timer not connected to IO-APIC INTIN0\n=
");
+				timer_ack=3D1;
 				enable_8259A_irq(0);
=2D				check_nmi_watchdog();
 			}
=2D			return;
 		}
=2D		clear_IO_APIC_pin(0, pin1);
=2D		printk(KERN_ERR "..MP-BIOS bug: 8254 timer not connected to IO-APIC\n"=
);
 	}

 	printk(KERN_INFO "...trying to set up timer (IRQ0) through the 8259A ... =
");
 	if (pin2 !=3D -1) {
 		printk("\n..... (found pin %d) ...", pin2);

Also attached as tarball if whitespace problems,
Hope this helps, Please cc me on responses,
Ross Dickson


--Boundary-00=_r+zeAud4mRYnMnX
Content-Type: application/x-tgz;
  name="nforce2-ioapic-rd-2.4.26-rc2.patch.tgz"
Content-Transfer-Encoding: base64
Content-Disposition: attachment; filename="nforce2-ioapic-rd-2.4.26-rc2.patch.tgz"

H4sIADE+e0AAA+1XbW/bNhDOV/tXXDOkkyNLpuSXJE6NtisywCgSZ2kHFFgHQZFoh7BDeZScpCjy
33dHSrK92G67FhgG6EFgWeTxuRc+PDpynKiI+45IwrmIHBU7vttx/Z6jIt+dh1l0s/fdYB5jvU5n
jyGOeubp5e+MprzOHpq0e712u9v10L7baff2gH2/6y9jkWahAthTSZrutuNqp8H/E47jgEgC2nw3
chMlJjWfsY5Df8fgdfvdXr/bdlkBsHGnWN227eWycoXHgPn9drvP/CcrXr0Cxzs5ano0gM/OMeAQ
Fj8TEdwlIoZoxkMVDEfB68vhG7BorFGHWg0VCtZcSBgAOwX68gKkCoxiA8UnIs1wb/6g1z+1gW3r
hbU1xgAnLLJpkknjtA6P9Tq0Dus2HILiKllkHIT6C7IEYjEec8Vlpt1pGiEnkMxiCGUMXIbXMxqQ
/J6Wt+r2aiJBIKTIkHM+CyO+6j8IswBdWAuZionkMQh0gQPNul3ToHf0YsLMX3Dd2jw6Xc7jC2VT
tz+jSZqpRZRB4VCnFGAW6hPoz1O0KV3PEkxgPAsnKQ1THWq6EGFcRGAW6fEWsVMCsySaUgppeMet
5/ke0GDTcDWI7NCyLAzusPFcMzTABtbA7csVE5ATq0yTPZAmwEfvJtttHN5ODu8ph454IYuYFU+z
RG0Pu6jBmxseTSHmM3HH1afgNok5ieKaQ7pQHO75z/gpk2wpjFDCu/MhiaWslhiDpSN314kGA2RO
swDtG7SrimcLJVfda9Y8DUhksRsl81NVl2VYyX25oWvKNnoh2lxGJW0h1xWZkjLhH+TNpf5y7a16
O6OTwTd6+UYNFft8r0TGrdJnIZZD46IJuU5gXWxfoPC+SOE1/oWCHut23cZSAFYiXcznicqAute1
SqZcwvkl/DIcvUubpoHwFG6wmziKx0LxKBO012O4HF79xpwj3CzDM+eRGONhfHP5u5MKVBDOpy7N
tbB//RTzsZAczl9/CGjlOzg2rbZ77DcpT6/nM/qybLZCzmiFblV5amcP2fDiPaYzEZF1Z7g3mUd0
MoJM3HJV9OfP2Gn5AzZgqfuRngvCaIr9VXcrLKCnO65/Wnf0yB3mmii9QeUbNrNTzIZ0BKSjCc9a
KUe6G24oKevctq9NMMBaLFKqY3Dsd09ea8Uy3Aadfo+dNP0upd85arZPtqS/IZ8ahYp9BqsaB8hP
tPqQsSbczvNKNXSwczz72dR6e3Z1EQwvfh3Bvuu+H56fXfXzSAfs4YD5H3QNBgexrgI+P8r9Zpn3
sj6GlPoGjcGzAabRwPo6NSoLfmJdRii3OEHlkEiwOni2Jze6SsORvjbvEzV9aYxb9FjI2zCdlt2i
qBHOkCOzW5QhrUutRu5PT8pbEdzTL8A4mVDbujgfFjxkZuub2RIDdipe+KcCL10zaprBt4RrrFv6
uSVgu7YjYn05fl3IiM2qMXOoucU8QBqrHDJndaO1kc+q03LZo3nskIiOH0ZvqUsOR44uB9IzVAcU
LMvLoWDcURzrmcAk8RcN0IWPKh1eMMCq6G8+jEMxw2s/L/NaZGdXVxTY+aVD/QmuF5M+YL6d/Ojp
qy6REhWLBHiJFOFqZqNnkmwR9Y6kzdWKQa3Qb6dmL8F1XaRf1mPrTyo8nqw4TfS9WFI2JNSp/lG4
Zf+djdv/CHyWclPVvPkDGmV46adlKZ9eyKsBbCh0XoyvLjFbKcEyHy/PZ6NAne36BC0mZ0VekA9s
TCTfWeeHSMYkArXHbf3TRe3SLypcQv1/Mc8JLeogjbUWohMmgYDhzDunv+ycUMa8/1G6BLDGyULq
TgwHcYNW75fd97/+X6xChQoVKlSoUKFChQoVKlSoUKFChQoVKlSoUOFH4G92sUCQACgAAA==

--Boundary-00=_r+zeAud4mRYnMnX--

