Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S132733AbRDUQG6>; Sat, 21 Apr 2001 12:06:58 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S132732AbRDUQGt>; Sat, 21 Apr 2001 12:06:49 -0400
Received: from ns.suse.de ([213.95.15.193]:12296 "HELO Cantor.suse.de")
	by vger.kernel.org with SMTP id <S132733AbRDUQGi>;
	Sat, 21 Apr 2001 12:06:38 -0400
Date: Sat, 21 Apr 2001 18:04:35 +0200
From: Karsten Keil <kkeil@suse.de>
To: linux-kernel@vger.kernel.org
Subject: Re: APIC-Errors+Crashes on GA 586DX, 2.2.17/2.4.3
Message-ID: <20010421180435.A22420@pingi.muc.suse.de>
Mail-Followup-To: linux-kernel@vger.kernel.org
In-Reply-To: <3AE1860A.390E301@violin.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.3.12i
In-Reply-To: <3AE1860A.390E301@violin.dyndns.org>; from dusty@violin.dyndns.org on Sat, Apr 21, 2001 at 03:07:22PM +0200
Organization: SuSE Muenchen GmbH
X-Operating-System: Linux 2.2.18-SMP i586
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Apr 21, 2001 at 03:07:22PM +0200, Hermann Himmelbauer wrote:
> Hi,
> I am using for my Internet-Gateway a dual Pentium MMX 200Mhz with a
> Gigabyte 586DX Motherboard (with the Intel 430HX Chipset). The last year
> I used Linux-2.2.16,2.2.17 with it and had several hangs of the network
> and ISDN subsystem.
> 
> The network dies like this (when copying huge amount of data):
> Feb  3 11:58:03 violin kernel: eth0: Interrupt posted but not delivered
> -- IRQ blocked by another device?
> Feb  3 11:58:03 violin kernel:   Flags; bus-master 1, full 0; dirty 16
> current 16.
> Feb  3 11:58:03 violin kernel:   Transmit list 00000000 vs. c13dfa00.
> Feb  3 11:58:03 violin kernel:   0: @c13dfa00  length 8000006e status
> 0001006e
> ...
> 
> and the isdn subsystem like this:
> Jan 27 00:41:15 violin kernel: isdn_tx_timeout dev ippp0 dialstate 0
> Jan 27 00:41:28 violin kernel: ippp0: dialing 2 194040...
> Jan 27 00:41:28 violin kernel: isdn: HiSax,ch0 cause: E001B
> 
> Although there is no direct hint to an APIC problem, I read in several
> newsgroup articles that these two errors refer to APIC errors.

For the ISDN one:
E001B - EURO ISDN cause Out of order mean, that here is no answer from
the exchange while trying to establish a D-channel L2 connection.
This may be have various reasons: broken cable, wrong addresses, no
IRQs. The no IRQ may (but don't must) related to APIC errors.

I have here the same board with 2*233 MMX and don't see this kind of ISDN
error on recent 2.2 kernels, but got also lot of APIC errors with the
2.3/2.4, because the APIC errors are only reported in 2.3/4.

> They system is still usable after such an error, only that eth0/isdn is 
> not accessible, even if I reload the modules. The only solution
> is a reboot.
> 
> Well - some days ago I tried to switch to 2.4.3, hoping that these
> errors will be gone then. The first thing that I noticed was that I got
> thousands of lines like this:
>
> Apr 22 16:19:31 violin kernel: APIC error on CPU0: 04(00)

No the kernel cannot change this, since it is a hardware problem.
The GA586DX is known that it produce lot of checksum errors on the APIC
bus, in 2.4 these are reported in 2.2 they are simple ignored, but also
here. These errors itself are not a problem since the APIC bus detect
it and recover, but if here are double errors in a way that the checksum
is OK, the APIC may run in trouble.
 
> Errors!) the isdn subsystem died:
> Apr 18 16:32:12 violin kernel: isdn_tx_timeout dev ippp0 dialstate 0
> Apr 18 16:32:12 violin kernel: ippp0: all channels busy - requeuing!

Yes that is also a hint that the IRQ of the card is blocked.

> Following the advice of Donald Becker he gave in some newsgroup I
> restarted the
> kernel with the "noapic" parameter. The strange thing is that the APIC
> errors are still there, at least there are a lot less than before,
> moreover the system seems slower but at least more stable. BTW, why are
> there still APIC errors although there are no interrupts assigned to
> CPU1 (as seen in /proc/interrupts).
> 

Yes, no APIC means all IRQ are handled by one CPU only, so communication
errors about IRQ events on the APIC bus don't care.

> I next tried to find out what triggers these APIC errors:
> 
> Without "noapic" kernel parameter:
> The Errors are triggered by a certain amount of interrupts, whatever
> device produces interrupts. 
> 
> With "noapic":
> It seems as if those errors are mostly triggered by NFS. When I copy the
> same
> amount of data with FTP, there are a lot less Errors. (E.g. for 500MB
> there
> are 40 with NFS and only 2 with FTP). 

I don't know all kinds of events the APIC bus is used for, it is not only
for the IRQs.

> What I wonder is why linux outputs a line like this (with noapic):
> <4>Intel MultiProcessor Specification v1.1
> <4>    Virtual Wire compatibility mode.
> 
> although the board seems to be capable of MPS 1.4 (as there is a Bios
> option "MPS 1.4 for single Processor).
> 

One or 2 years ago I was playing with these options, it seemed that setting
it to 1.1 reduce the error count a little bit, but this maybe a
misinterpretation.

-- 
Karsten Keil
SuSE Labs
ISDN development
