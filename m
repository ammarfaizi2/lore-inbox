Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S268933AbRHCLYO>; Fri, 3 Aug 2001 07:24:14 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S268940AbRHCLYF>; Fri, 3 Aug 2001 07:24:05 -0400
Received: from host213-1-130-210.btinternet.com ([213.1.130.210]:5104 "EHLO
	firewall0.node0.idium.eu.org") by vger.kernel.org with ESMTP
	id <S268933AbRHCLX6>; Fri, 3 Aug 2001 07:23:58 -0400
Message-ID: <021001c11c0c$4711aad0$0100007f@node0.idium.eu.org>
From: "David Flynn" <Dave@keston.u-net.com>
To: "Donald Becker" <becker@scyld.com>, "Alan Cox" <alan@lxorguk.ukuu.org.uk>
Cc: <tulip@scyld.com>,
        "linux kernel mailinglist" <linux-kernel@vger.kernel.org>
In-Reply-To: <Pine.LNX.4.10.10108030028530.850-100000@vaio.greennet>
Subject: Re: [tulip] Re: Tulip Driver, or is it the PCI subsystem ?
Date: Fri, 3 Aug 2001 12:05:36 +0100
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
X-Priority: 3
X-MSMail-Priority: Normal
X-Mailer: Microsoft Outlook Express 5.50.4133.2400
X-MimeOLE: Produced By Microsoft MimeOLE V5.50.4133.2400
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


From: "Donald Becker" <becker@scyld.com>

here is some news, ive got the detection seeming to work, in that the
devices on the other side of the bridge are reverse sorted (to counter the
bios problem)

> On Fri, 3 Aug 2001, Alan Cox wrote:
>
> > > now, all that i want to know, is What on earth has been changed to
> > > COMPLETELY retard what i saw as a usefull card and driver, for my (and
other
> > > people), the card is useless, and even worse, so is the damn server
its
> > > connected to.
> >
> > Well the obvious thing is the pci scanning and hot plug interface means
that
> > PCI ordering is now a more generic issue. I suspect what you'd need to
do
> > is to implement a version of
> >
> > pcibios_sort()

ok, its taken me a while, ive never played with the kernel before, so it
took a while to realize what was going on

could someone just check my reasoning on this ?

previously in the kernel, a list of pci devices has been enumerated and
created as pci_devices, this is unsorted

we then come to pcibios_sort() where it inturn removes devices from the list
and populates a list called sorted_devices

this sorted list is then spliced with pci_devices which should be empty.

now the bios only scans the other side of a pci bridge in the wrong order,
so the hack i thought of, which will probabally get me killed once any one
sees it! when the test to find which device to remove, if we are on the
other side of a PCI bridge with more than one device, the first device
detected by the bios has idx = 1, and is added to the end of the list, note:
this should be the last device, not the last. now the next device on the
bridge would have idx=2, so it needs to be added before the last device and
in order to preserve the ordering, each device needs to be added idx -1
places before the first device detected on the bridge.

so we end up with this patch

@@ -606,6 +606,9 @@
        struct pci_dev *dev, *d;
        int idx, found;
        unsigned char bus, devfn;
+#ifdef pci_reverse
+       struct list_head *foo;
+#endif

        DBG("PCI: Sorting device list...\n");
        while (!list_empty(&pci_devices)) {
@@ -616,6 +619,21 @@
                        idx++;
                        for (ln=pci_devices.next; ln != &pci_devices;
ln=ln->next) {
                                d = pci_dev_g(ln);
+#ifdef pci_reverse
+                               if(idx > 1) {
+                                       if (d->bus->number == bus &&
d->devfn == devfn) {
+                                               struct list_head *foo;
+                                               list_del(&d->global_list);
+                                               for(foo = &sorted_devices,
found = idx; found > 1; found--)
+                                                       foo = foo->prev;
+
list_add_tail(&d->global_list, foo);
+                                               found = 0;
+                                               if (d == dev)
+                                                       found = 1;
+                                               break;
+                                       }
+                               }
+#endif
                                if (d->bus->number == bus && d->devfn ==
devfn) {
                                        list_del(&d->global_list);
                                        list_add_tail(&d->global_list,
&sorted_devices);

>
> This doesn't really address the problem.
>

it sorts out the probing problem very nicley, the driver now gets all the
MAC addresses right, this is both your driver and the kernel one

this is the output from the kernel driver with my patch

Aug  3 11:04:29 firewall0 kernel: eth0: Digital DC21040 Tulip rev 36 at
0xf800, 00:00:92:92:39:58, IRQ 3.
Aug  3 11:04:29 firewall0 kernel: eth1: Digital DC21040 Tulip rev 36 at
0xf880, EEPROM not present, 00:00:92:92:39:59, IRQ 3.
Aug  3 11:04:29 firewall0 kernel: eth2: Digital DC21040 Tulip rev 36 at
0xfc00, EEPROM not present, 00:00:92:92:39:5A, IRQ 3.
Aug  3 11:04:29 firewall0 kernel: eth3: Digital DC21040 Tulip rev 36 at
0xfc80, EEPROM not present, 00:00:92:92:39:5B, IRQ 3.
Aug  3 11:06:40 firewall0 kernel: NETDEV WATCHDOG: eth3: transmit timed out
Aug  3 11:07:12 firewall0 last message repeated 2 times

what would cause the transmit timeout ?

note, that the timeout does not happen if i use eth0, is it an irq thing ?

as this is what proc/pci says

  Bus  1, device   4, function  0:
    Ethernet controller: Digital Equipment Corporation DECchip 21040 [Tulip]
(rev 36).
      IRQ 3.
      Master Capable.  Latency=66.
      I/O at 0xf800 [0xf87f].
      Non-prefetchable 32 bit memory at 0xff9ff000 [0xff9ff07f].
  Bus  1, device   5, function  0:
    Ethernet controller: Digital Equipment Corporation DECchip 21040 [Tulip]
(#2) (rev 36).
      IRQ 9.
      Master Capable.  Latency=66.
      I/O at 0xf880 [0xf8ff].
      Non-prefetchable 32 bit memory at 0xff9ff400 [0xff9ff47f].
  Bus  1, device   6, function  0:
    Ethernet controller: Digital Equipment Corporation DECchip 21040 [Tulip]
(#3) (rev 36).
      IRQ 10.
      Master Capable.  Latency=66.
      I/O at 0xfc00 [0xfc7f].
      Non-prefetchable 32 bit memory at 0xff9ff800 [0xff9ff87f].
  Bus  1, device   7, function  0:
    Ethernet controller: Digital Equipment Corporation DECchip 21040 [Tulip]
(#4) (rev 36).
      IRQ 11.
      Master Capable.  Latency=66.
      I/O at 0xfc80 [0xfcff].
      Non-prefetchable 32 bit memory at 0xff9ffc00 [0xff9ffc7f].

so why do we change the irq's ???
also note, an attempt to bring up two interfaces causes the system to hang


however, i am at a loss with your driver, as it hangs when one tries to
bring up an interface (the kernel driver doesnt do that) ....

question: the bios seems to assign 4 different IRQ's to the card, one for
each port, your driver instists on 'making' them all the same as the first
port, why ?


> The (Scyld) tulip driver now back-installs the EEPROM information to
> already detected interfaces that didn't have an EEPROM.
>
> The problem is the broken BIOS IRQ settings.
> The tulip driver has long had patch-up code, for x86 only, to work
> around this problem.
>
> The driver used to only forward-copy the EEPROM info, and used the same
> code to forward copy the IRQ setting.  If the probe order was backwards,
> the user set reverse_probe=1 because of the obviously bogus media
> table.  This fixed up the IRQ (which was never *obviously* broken.)
>
> Reviewing the code, I now understand the crux of your bug report.
> While the current driver will back-copy and forward-copy the EEPROM
> media information, the IRQ setting is only forward copied.
>
> See the references to "last_irq" in probe1().
>
> Here is a patch that might fix your problem.  The code around line 1106
> does the back-copy of the EEPROM media table.  Please try adding the
> lines with the "+"

the problem is, that this bit of code (i think) doesnt fix the problem with
the back copy of the media table, as when the driver is run, it always gets
the first three ports "wrong", ie the MAC addresses are bogus, only the last
port is correct.

how does the driver in theory do the back copy, and where does it work out
where there is a good EEPROM ?

>
> if (ee_data[19] > 1) {
> struct net_device *prev_dev;
> struct tulip_private *otp;
> /* This is a multiport board.  The probe order may be "backwards", so
>    we patch up already found devices. */
> last_ee_data = ee_data;
> for (prev_dev = tp->next_module; prev_dev; prev_dev = otp->next_module) {
> otp = (struct tulip_private *)prev_dev->priv;
> if (otp->eeprom[0] == 0xff  &&  otp->mtable == 0) {
> +#if defined(__i386__) /* Patch up x86 BIOS bug. */
> + prev_dev->irq = dev->irq;
> +#endif
> parse_eeprom(prev_dev);
> start_link(prev_dev);
> } else
> break;
> }
> controller_index = 0;
> }


Thanks everyone,

Dave
>
>
> Donald Becker becker@scyld.com
> Scyld Computing Corporation http://www.scyld.com
> 410 Severn Ave. Suite 210 Second Generation Beowulf Clusters
> Annapolis MD 21403 410-990-9993
>
>
>

