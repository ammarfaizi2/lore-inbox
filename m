Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S279307AbRKAQrC>; Thu, 1 Nov 2001 11:47:02 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S279305AbRKAQqw>; Thu, 1 Nov 2001 11:46:52 -0500
Received: from postfix2-2.free.fr ([213.228.0.140]:10206 "HELO
	postfix2-2.free.fr") by vger.kernel.org with SMTP
	id <S279303AbRKAQqj> convert rfc822-to-8bit; Thu, 1 Nov 2001 11:46:39 -0500
Date: Thu, 1 Nov 2001 15:01:37 +0100 (CET)
From: =?ISO-8859-1?Q?G=E9rard_Roudier?= <groudier@free.fr>
X-X-Sender: <groudier@gerard>
To: Stephan von Krawczynski <skraw@ithnet.com>
Cc: <linux-kernel@vger.kernel.org>
Subject: Re: The good, the bad & the ugly (or VM, block devices, and SCSI
 :-)
In-Reply-To: <20011101151033.1253900c.skraw@ithnet.com>
Message-ID: <20011101142507.S1471-100000@gerard>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=ISO-8859-1
Content-Transfer-Encoding: 8BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Thu, 1 Nov 2001, Stephan von Krawczynski wrote:

> On Wed, 31 Oct 2001 18:29:25 +0100 (CET) Gérard Roudier <groudier@free.fr>
> wrote:
>
> > > A29160:                                     symbios:
> > >
> > > cd read without nfs-load:                   cd read without nfs-load
> > > 2998,9 kB                                   3619,3 kB
> > > 3168,2 kB                                   3611,1 kB
> > > 2968,4 kB                                   3620,2 kB
> > >
> > > cd read with nfs load:                      cd read with nfs load
> > > 1926,2 kB                                   3408,1 kB
> > > 2123,4 kB                                   3395,2 kB
> > > 2539,4 kB                                   3605,1 kB
> > > 2631,9 kB                                   3605,8 kB
> > >
> > > [...]
> > > My personal opinion: Justin has work to do.
> >
> > Agreed here. Justin should write a clean SCSI access method for Linux for
> > free as he did for FreeBSD. :-)
>
> Just to make that clear: its not that I am in the position of _expecting_
> anything. I only want to give a clear hint what (according to my limited
> knowledge) the problem might be, and who could possibly solve it.

That was clear. As clear it is that my reply here was kind of joke. :)

> > Just considering the CD read thoughtput differences, we cannot get any
> > useful information that applies to software driver differences from your
> > report. Given the very low throughput it involves (about 3 MB/s) compared
> > to the capabilities of the controllers (160 MB/s), the results should be
> > explainable by something related to difference in configuration or to some
> > hardware or kernel weirdness.
>
> Well, what more can you expect from me, than the simple truth that the config
> is the _same_ for both tests and the only thing I am doing is exchange the
> scsi-controller (and therefore the used kernel-driver within the compiled
> bzImage).

I can beleive that.

> It is pretty clear that U160 cannot be reached by the CD-drive, because it is
> located on the scsi-2 connector (50 pin internal). It is a TEAC CD-532S which
> has (to my knowledge) not even wide-scsi but 8 bit data transfer). It is
> specified as being 30x, so should have a max throughput of 4500 kB/s (150 kB/s
> x 30). The values (at least symbios) are obviously not that far off, taking
> into account that 30x means "somewhere on the disk we reach 30x" and not
> "through the whole disk we have 30x".
> The only difference I can confirm is in TCQ-depth being configured to 8 on
> adaptec and 4 (!) on tekram. I reduced the tcq-depth on adaptec from 256 to 8,
> because
> a) 256 doesn't work out anyway. I got switched back to 128 during workload
> according to the driver
> b) even 128 makes "feelable" latency during heavy I/O and concurrent
> shell-typing stuff.
> c) choose therefore 8, because the _old_ aic7xxx driver used 8, too, and was in
> my opinion better in terms of latency _and_ throughput (but didn't compile any
> more in some 2.4.x kernel, that's why I _had_ to switch over)

The TCQ-depth shouldn't matter as long as only the CD drive is accessed
given that such devices are unlikely to support tagged commands.
Nevertheless, you should check your boot log messages and also compare the
thoughput negotiation between controller and devices.

> some additional infos:
> Motherboard Asus CUV4X-D, 2 x P-III 1 GHz, 1 GB RAM
>
> /proc/scsi/scsi:
>
> Attached devices:
> Host: scsi0 Channel: 00 Id: 08 Lun: 00
>   Vendor: IBM      Model: DDYS-T36950N     Rev: S96H
>   Type:   Direct-Access                    ANSI SCSI revision: 03
> Host: scsi1 Channel: 00 Id: 02 Lun: 00
>   Vendor: BNCHMARK Model: DLT1             Rev: 391B
>   Type:   Sequential-Access                ANSI SCSI revision: 02
> Host: scsi1 Channel: 00 Id: 03 Lun: 00
>   Vendor: TEAC     Model: CD-ROM CD-532S   Rev: 1.0A
>   Type:   CD-ROM                           ANSI SCSI revision: 02
> Host: scsi1 Channel: 00 Id: 05 Lun: 00
>   Vendor: TEAC     Model: CD-R58S          Rev: 1.0P
>   Type:   CD-ROM                           ANSI SCSI revision: 02
> Host: scsi1 Channel: 00 Id: 06 Lun: 00
>   Vendor: HP       Model: C1537A           Rev: L005
>   Type:   Sequential-Access                ANSI SCSI revision: 02
>
> /proc/interrupts (tekram):
>            CPU0       CPU1
>   0:      77797      76618    IO-APIC-edge  timer
>   1:       3127       2991    IO-APIC-edge  keyboard
>   2:          0          0          XT-PIC  cascade
>   5:         74         83   IO-APIC-level  HiSax
>   8:          1          1    IO-APIC-edge  rtc
>   9:       4651       4171   IO-APIC-level  EMU10K1, eth0
>  10:      16563      16459   IO-APIC-level  sym53c8xx, sym53c8xx, eth2
>  11:      62677      62214   IO-APIC-level  eth1, nvidia
>  12:       8842       8772    IO-APIC-edge  PS/2 Mouse
>  14:        143         29    IO-APIC-edge  ide0
> NMI:          0          0
> LOC:     154305     154182
> ERR:          0
> MIS:          0
>
> /proc/interrupts (adaptec):
>            CPU0       CPU1
>   0:       5967       5266    IO-APIC-edge  timer
>   1:        209        192    IO-APIC-edge  keyboard
>   2:          0          0          XT-PIC  cascade
>   5:          9          6   IO-APIC-level  HiSax
>   8:          1          1    IO-APIC-edge  rtc
>   9:        183        175   IO-APIC-level  EMU10K1, eth0
>  10:       2309       2172   IO-APIC-level  aic7xxx, eth2
>  11:       3532       3468   IO-APIC-level  eth1, nvidia
>  12:        920       1103    IO-APIC-edge  PS/2 Mouse
>  14:        124         48    IO-APIC-edge  ide0
> NMI:          0          0
> LOC:      11124      10979
> ERR:          0
> MIS:          0

Indeed, the configs look very similar.

> And yes: eth2 is exactly the device where the nfs-load is coming from. This is
> unintentional, it just worked out this way, but equal for both contestants.
> And no: unfortunately I cannot manage to come to a config where the scsi-IRQ is
> singular, I tried hard today, but the network is in fact a 4-port tulip card
> which makes a pci-bridge and the irqs behind the bridge tend to do whatever
> they like. In fact I moved the irq for the scsi-controllers via bios, but guess
> what: eth2 followed wherever I went.

PCI defines 4 interrupt lines per slot and also defines some rules for
interrupt lines wiring behind bridges. OTOH, the routing glue to the
interrupt controller may well not allow all possible combinations. What
happens could just be that the routing glue just hardwires the both
interrupt lines here, and only moving a PCI board to another slot can
allow to use different IRQs for the 2 devices.

> Keep in mind, even with no network traffic adaptec performs bad.
> Ah and another thing, I tried _several_ adaptec controllers (even a 29160N),
> all the same results.
>
> > I cannot believe a single second that the
> > difference is due to the software drivers.
>
> I can. I did a whole lot of such tests during my former job for a company
> producing scsi-controllers.

Interesting, if you can elaborate...

> > Thanks, anyway, for your report.
>
> Well, as already said, take it as a hint that your part of the story performs
> pretty well.
> ;-)

The sym53c8xx driver beeing faster than the aic7xxx with CD devices using
Ultra160 controllers is an amuzing result. :)
I still cannot beleive that it is due to a aic7xxx driver fault. If I had
such a controller, I would for sure check that, but I haven't any.

Regards,
  Gérard.

