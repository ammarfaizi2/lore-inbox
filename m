Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S280556AbRKFUmZ>; Tue, 6 Nov 2001 15:42:25 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S280554AbRKFUmF>; Tue, 6 Nov 2001 15:42:05 -0500
Received: from postfix2-1.free.fr ([213.228.0.9]:35972 "HELO
	postfix2-1.free.fr") by vger.kernel.org with SMTP
	id <S275743AbRKFUlu> convert rfc822-to-8bit; Tue, 6 Nov 2001 15:41:50 -0500
Date: Tue, 6 Nov 2001 18:56:44 +0100 (CET)
From: =?ISO-8859-1?Q?G=E9rard_Roudier?= <groudier@free.fr>
X-X-Sender: <groudier@gerard>
To: Berkan Eskikaya <berkan@runtime-collective.com>
Cc: <linux-kernel@vger.kernel.org>
Subject: Re: sym53c8xx problem
In-Reply-To: <20011106024430.A7893@cogs.susx.ac.uk>
Message-ID: <20011106181733.C1653-100000@gerard>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=ISO-8859-1
Content-Transfer-Encoding: 8BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


On Tue, 6 Nov 2001, Berkan Eskikaya wrote:

> Hi,
>
> Hardware and driver details are at the end; first, the problem:
>
> I've been getting messages like these in the kernel logs on one of our
> colocated servers:
>
> sym53c875E-0-<0,*>: FAST-20 WIDE SCSI 40.0 MB/s (50 ns, offset 16)
> sym53c875E-0:0: ERROR (81:0) (8-0-0) (10/9d) @ (script 38:f31c0004).
> sym53c875E-0: script cmd = e21c0004
> sym53c875E-0: regdump: da 00 00 9d 47 10 00 07 04 08 80 00 80 00 0f 02
>                        63 00 00 00 02 ff ff ff.
                         ^^^^^^^^^^^

This IO register value (DSA = Data Struture Address) has been loaded with
some corrupted value . It should look like a valid 32 bit aligned bus
physical address pointing to main memory (assumed little-endian byte
order).

This happens from SCSI SCRIPTS at this place:

	SCR_LOAD_ABS (dsa, 4),
		PADDRH (startpos),   <--- Corrupted value loaded into DSA
	SCR_LOAD_REL (temp, 4),      <--- Instruction that faulted
		4,
}/*-------------------------< GETJOB_BEGIN >------------------*/,{
	SCR_STORE_ABS (temp, 4),
		PADDRH (startpos),

The corrupted value (from startpos) is taken from a SCRIPTS (scripth) area
that stays in main memory. This memory location gets corrupted by the 32
bit value 0x00000063 (rotated from the dump, since little-endian is
assumed).

> sym53c875E-0-<0,*>: FAST-20 WIDE SCSI 40.0 MB/s (50 ns, offset 16)
> scsi : aborting command due to timeout : pid 7737, scsi0, channel 0, id 0, lun 0 Read (10) 00 00 00 3c 80 00 00 80 00
> sym53c8xx_abort: pid=7737 serial_number=7752 serial_number_at_timeout=7752
> SCSI host 0 abort (pid 7737) timed out - resetting
> SCSI bus is being reset for host 0 channel 0.
> sym53c8xx_reset: pid=7737 reset_flags=2 serial_number=7752 serial_number_at_timeout=7752
>
>
> I thought this might be due to a bad card / cable so yesterday the ISP
> replaced the SCSI card and cable with another pair. This morning I've
> got these in the logs:
>
>
> sym53c875E-0: interrupted SCRIPT address not found.
                ^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^

This just above driver complaint has never been seen since day one I care
about the ncr/sym53c8xx drivers. It only can happen if some SCRIPTS area
has been corrupted.

What part did screw up this memory and more generally memory allocated by
the driver ? this is obviously the question. As main memory is shared by
all the kernel code, there are numerous candidates (driver included,
obviously).

Since this does not look like a known problem, I cannot actually help you
a lot. Anyway, I would recommend you to first update your kernel to a
supported version. Final kernel 2.2.20 is what you likely need, it seems.

Once done, if the problem does not go away, I would recommend you to
update the driver to a more recent version. Choices are:

1) sym53c8xx-1.7.3c
2) sym-2.1.16b

Choice #2 works great and is the latest available version. It is a major
version now 2 of sym53c8xx that was version 1. It is not yet widely used
but haven't any glitch be reported (yet) by people using it.

ftp://ftp.tux.org/pub/roudier/drivers/linux/experimental/sym-2.1.16b-for-linx-2.2.20.patch.gz


> sym53c875E-0-<0,*>: FAST-20 WIDE SCSI 40.0 MB/s (50 ns, offset 16)
> sym53c875E-0: interrupted SCRIPT address not found.
> sym53c875E-0-<0,*>: FAST-20 WIDE SCSI 40.0 MB/s (50 ns, offset 16)
> sym53c875E-0:0: ERROR (81:0) (8-0-0) (10/9d) @ (script 38:f31c0004).
> sym53c875E-0: script cmd = e21c0004
> sym53c875E-0: regdump: da 00 00 9d 47 10 00 0f 00 08 80 00 80 00 07 02 63 00 00 00 02 ff ff ff.
> sym53c875E-0-<0,*>: FAST-20 WIDE SCSI 40.0 MB/s (50 ns, offset 16)
> sym53c875E-0: interrupted SCRIPT address not found.
> sym53c875E-0-<0,*>: FAST-20 WIDE SCSI 40.0 MB/s (50 ns, offset 16)
>

Looks exactly same problem.

> I'd really appreciate if somebody could shed some light on this and
> recommend a solution. This has already caused a filesystem corruption
> and a forced reboot.
>
> I'm not on the list, so please Cc to berkan@runtime-collective.com
> if you reply.

Will do.

Regards,
  Gérard.

> Cheers,
>
> Berkan
>
>
> Kernel: Linux 2.2.20pre11 for Intel x86
>
> SCSI hardware and driver:
>
> [relevant bits from boot messages]
>
> sym53c8xx: at PCI bus 0, device 11, function 0
> sym53c8xx: setting PCI_COMMAND_PARITY...(fix-up)
> sym53c8xx: 53c875E detected with Tekram NVRAM
> sym53c875E-0: rev 0x26 on pci bus 0 device 11 function 0 irq 10
> sym53c875E-0: Tekram format NVRAM, ID 7, Fast-20, Parity Checking
> scsi0 : sym53c8xx-1.7.1-20000726
> scsi : 1 host.
>   Vendor: IBM       Model: DDYS-T09170N      Rev: S80D
>   Type:   Direct-Access                      ANSI SCSI revision: 03
> Detected scsi disk sda at scsi0, channel 0, id 0, lun 0
> scsi : detected 1 SCSI disk total.
> sym53c875E-0-<0,*>: FAST-20 WIDE SCSI 40.0 MB/s (50 ns, offset 16)
> SCSI device sda: hdwr sector= 512 bytes. Sectors= 17916240 [8748 MB] [8.7 GB]
>
> [from lspci -v]
>
> 00:0b.0 SCSI storage controller: Symbios Logic Inc. (formerly NCR) 53c875 (rev 26)
>         Subsystem: Symbios Logic Inc. (formerly NCR): Unknown device 1000
>         Flags: bus master, medium devsel, latency 32, IRQ 10
>         I/O ports at b800
>         Memory at da800000 (32-bit, non-prefetchable)
>         Memory at da000000 (32-bit, non-prefetchable)
>         Capabilities: [40] Power Management version 1
>
>
> -
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/


