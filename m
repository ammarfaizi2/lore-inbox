Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129076AbQKQOIm>; Fri, 17 Nov 2000 09:08:42 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129111AbQKQOIc>; Fri, 17 Nov 2000 09:08:32 -0500
Received: from harpo.it.uu.se ([130.238.12.34]:18170 "EHLO harpo.it.uu.se")
	by vger.kernel.org with ESMTP id <S129076AbQKQOI0>;
	Fri, 17 Nov 2000 09:08:26 -0500
From: Mikael Pettersson <mikpe@csd.uu.se>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-ID: <14869.13514.762275.173328@harpo.it.uu.se>
Date: Fri, 17 Nov 2000 14:38:18 +0100 (MET)
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
Cc: tigran@veritas.com (Tigran Aivazian), Andi Kleen <ak@suse.de>,
        ledzep37@home.com (Jordan),
        linux-kernel@vger.kernel.org (Linux Kernel)
Subject: Re: Error in x86 CPU capabilities starting with test5/6
In-Reply-To: <E13wkLK-0000bP-00@the-village.bc.nu>
In-Reply-To: <Pine.LNX.4.21.0011171154250.8176-100000@saturn.homenet>
	<E13wkLK-0000bP-00@the-village.bc.nu>
X-Mailer: VM 6.61 under Emacs 19.34.1
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hmm, my CPUID vs /proc/cpuinfo comment seemed somewhat controversial.

Tigran Aivazian wrote:
 > Arguably, it is always better to parse /proc/cpuinfo instead of executing
 > CPUID directly (think PCI -- drivers should _NOT_ get their irq/io/etc
 > values from config space directly but only what the kernel puts on a plate
 > for them in the struct pci_dev).

In priciple I would agree, but CPUID is a lot easier to use than to open and
parse /proc/cpuinfo, specially when the format of the latter changes...

 > So, one could imagine the kernel which emulates in software some of the
 > processor features and then CPUID would lie but /proc/cpuinfo would tell
 > the truth.

In this case, I'd REALLY like to know whether the feature is emulated or not.
Imagine a kernel emulating MMX instructions, with a 10x performance loss.
My MPEG viewer has builtin support for MMX and non-MMX capable processors,
with the non-MMX version 2x slower. On a non-MMX processor, we'll still
be a lot better off using the non-MMX rendering libs.

In other cases it may not matter, only the user can tell.

Andi Kleen wrote:
 > The program would be broken if it executed CPUID itself, because it has no way to guarantee
 > that the CPUID is executed on all CPUs the scheduler may later move the task too.
 > ...
 > -Andi (proud owner of an AMP system with one CPU implementing FXSR and one not,
 > which causes lots of interesting problems) 

Yes, this is a problem. There are two alternatives:
- hpa's cpuid driver lets you execute cpuid on a specific processor
  (but it's an optional driver, so you can't count on it)
- Something like Solaris' processor_bind() which lets a user-space application
  "bind" itself to a given processor. AFAIK, Linux doesn't have this :-(

Alan Cox wrote:
 > It is not safe to use cpuid to check the availability of RDTSC in Linux because
 > the CPU itself does not know if the TSC is buggy (Some MediaGX, some WinChip,..)

User-space can also check vendor/family/mode/stepping values and choose not to
trust certain announced feature flags. No big deal.

 > or if the TSC on an SMP box is constant across all processors.

A recurring theme: asymmetric MP boxen :-(
Yeah, you and Andi are right, asymmetric MP boxen require kernel support.
I didn't consider that case...

/Mikael
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
