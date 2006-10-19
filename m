Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1945985AbWJSGkK@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1945985AbWJSGkK (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 19 Oct 2006 02:40:10 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1161345AbWJSGkK
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 19 Oct 2006 02:40:10 -0400
Received: from holoclan.de ([62.75.158.126]:2772 "EHLO mail.holoclan.de")
	by vger.kernel.org with ESMTP id S1161344AbWJSGkG (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 19 Oct 2006 02:40:06 -0400
Date: Thu, 19 Oct 2006 08:39:21 +0200
From: Martin Lorenz <martin@lorenz.eu.org>
To: Andrew Morton <akpm@osdl.org>
Cc: Jesse Brandeburg <jesse.brandeburg@gmail.com>,
       linux-kernel@vger.kernel.org,
       "Eric W. Biederman" <ebiederm@xmission.com>
Subject: Re: un/shared IRQ problem (was: Re: 2.6.18 - another DWARF2)
Message-ID: <20061019063921.GJ6189@gimli>
Mail-Followup-To: Andrew Morton <akpm@osdl.org>,
	Jesse Brandeburg <jesse.brandeburg@gmail.com>,
	linux-kernel@vger.kernel.org,
	"Eric W. Biederman" <ebiederm@xmission.com>
References: <20061017063710.GA27139@gimli> <4807377b0610171152tfea31c1v3f907dcaf0a58509@mail.gmail.com> <20061018063431.GE20238@gimli> <20061018232603.585d14c3.akpm@osdl.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20061018232603.585d14c3.akpm@osdl.org>
User-Agent: Mutt/1.5.13 (2006-08-11)
X-Spam-Score: -1.4 (-)
X-Spam-Report: Spam detection software, running on the system "www.holoclan.de", has
	identified this incoming email as possible spam.  The original message
	has been attached to this so you can view it (if it isn't spam) or label
	similar future email.  If you have any questions, see
	the administrator of that system for details.
	Content preview:  On Wed, Oct 18, 2006 at 11:26:03PM -0700, Andrew Morton
	wrote: > On Wed, 18 Oct 2006 08:34:31 +0200 > Martin Lorenz
	<martin@lorenz.eu.org> wrote: > > > On Tue, Oct 17, 2006 at 11:52:16AM
	-0700, Jesse Brandeburg wrote: > > > On 10/16/06, Martin Lorenz
	<martin@lorenz.eu.org> wrote: > > > >just got the following on resume: >
	> > > > > > >[87026.706000] [<c0251745>] e1000_open+0xcd/0x1a4 > > >
	>[87026.714000] DWARF2 unwinder stuck at syscall_call+0x7/0xb > > >
	>[87026.715000] Leftover inexact backtrace: > > > >[87026.715000] e1000:
	eth0: e1000_request_irq: Unable to allocate interrupt > > > >Error: -16
	> > > > > > I'm pretty sure this isn't an e1000 problem. you need to
	talk to > > > whoever is maintaining the IRQ subsystem for x86. E1000 is
	attempting > > > to register a shared interrupt and someone has already
	registered that > > > interrupt unshared. > > > > interestingly though
	it always involves e1000 when I see dumps like this. > > I already
	reported more of those :-) > > this one dosen't seem to do any harm to
	system stability. it occurs on every > > suspend/resume and I can
	circumvent it by disabling msi > > > > > > > > looks like several
	devices are sharing IRQ 201 (aka GSI 16) and ahci > > > or usb uhci_hcd
	is likely the problem, or the (acpi) power management > > > subsystem. >
	> > > > > Hope this helps get the right people involved. > > > > thank
	you > > Could we see the /proc/interrupts please, so we can find out
	where the > clash is happening? [...] 
	Content analysis details:   (-1.4 points, 5.0 required)
	pts rule name              description
	---- ---------------------- --------------------------------------------------
	-1.4 ALL_TRUSTED            Passed through trusted hosts only via SMTP
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Oct 18, 2006 at 11:26:03PM -0700, Andrew Morton wrote:
> On Wed, 18 Oct 2006 08:34:31 +0200
> Martin Lorenz <martin@lorenz.eu.org> wrote:
> 
> > On Tue, Oct 17, 2006 at 11:52:16AM -0700, Jesse Brandeburg wrote:
> > > On 10/16/06, Martin Lorenz <martin@lorenz.eu.org> wrote:
> > > >just got the following on resume:
> > > >
> > > >[87026.706000]  [<c0251745>] e1000_open+0xcd/0x1a4
> > > >[87026.714000] DWARF2 unwinder stuck at syscall_call+0x7/0xb
> > > >[87026.715000] Leftover inexact backtrace:
> > > >[87026.715000] e1000: eth0: e1000_request_irq: Unable to allocate interrupt
> > > >Error: -16
> > > 
> > > I'm pretty sure this isn't an e1000 problem.  you need to talk to
> > > whoever is maintaining the IRQ subsystem for x86.  E1000 is attempting
> > > to register a shared interrupt and someone has already registered that
> > > interrupt unshared.
> > 
> > interestingly though it always involves e1000 when I see dumps like this.
> > I already reported more of those :-)
> > this one dosen't seem to do any harm to system stability. it occurs on every
> > suspend/resume and I can circumvent it by disabling msi
> > 
> > > 
> > > looks like several devices are sharing IRQ 201 (aka GSI 16) and ahci
> > > or usb uhci_hcd is likely the problem, or the (acpi) power management
> > > subsystem.
> > > 
> > > Hope this helps get the right people involved.
> > 
> > thank you
> 
> Could we see the /proc/interrupts please, so we can find out where the
> clash is happening?


here you are

~# cat /proc/interrupts
           CPU0       CPU1
  0:   76521957    2009390    IO-APIC-edge  timer
  1:      39599          0    IO-APIC-edge  i8042
  8:        128          0    IO-APIC-edge  rtc
  9:     415044          0   IO-APIC-level  acpi
 12:     862451          0    IO-APIC-edge  i8042
 58:      68014     326850         PCI-MSI  libata
 66:     508910      17187   IO-APIC-level  sdhci:slot0, uhci_hcd:usb3
 74:    3156375          0   IO-APIC-level  uhci_hcd:usb2, ohci1394, HDA Intel
 82:     134828          0   IO-APIC-level  uhci_hcd:usb4, ehci_hcd:usb5
 90:      46548          0         PCI-MSI  eth0
201:     100133          0   IO-APIC-level  uhci_hcd:usb1, yenta, i915@pci:0000:00:02.0
NMI:          0          0
LOC:   78530935   78520308
ERR:          0
MIS:          0


gruss
  mlo
--
Dipl.-Ing. Martin Lorenz

            They that can give up essential liberty 
	    to obtain a little temporary safety 
	    deserve neither liberty nor safety.
                                   Benjamin Franklin

please encrypt your mail to me
GnuPG key-ID: F1AAD37D
get it here:
http://blackhole.pca.dfn.de:11371/pks/lookup?op=get&search=0xF1AAD37D

ICQ UIN: 33588107
