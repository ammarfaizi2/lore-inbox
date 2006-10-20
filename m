Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751628AbWJTDVv@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751628AbWJTDVv (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 19 Oct 2006 23:21:51 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751626AbWJTDVv
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 19 Oct 2006 23:21:51 -0400
Received: from mail4.hitachi.co.jp ([133.145.228.5]:19665 "EHLO
	mail4.hitachi.co.jp") by vger.kernel.org with ESMTP
	id S1751629AbWJTDVu (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 19 Oct 2006 23:21:50 -0400
Message-Type: Multiple Part
MIME-Version: 1.0
Message-ID: <XNM1$9$0$4$$3$3$7$A$9002710U453840ab@hitachi.com>
Content-Type: text/plain; charset="us-ascii"
To: "Greg KH" <greg@kroah.com>
From: <eiichiro.oiwa.nm@hitachi.com>
Cc: "David Miller" <davem@davemloft.net>, <alan@redhat.com>,
       <jesse.barnes@intel.com>, <linux-kernel@vger.kernel.org>
Date: Fri, 20 Oct 2006 12:21:24 +0900
References: <20061019092256.GC5980@devserv.devel.redhat.com> 
    <20061019.022541.85409562.davem@davemloft.net> 
    <XNM1$9$0$4$$3$3$7$A$9002707U4537582f@hitachi.com> 
    <20061019.153228.39159105.davem@davemloft.net> 
    <20061020024157.GA6722@kroah.com>
Importance: normal
Subject: Re: pci_fixup_video change blows up on sparc64
X400-Content-Identifier: X453840AB00000M
X400-MTS-Identifier: [/C=JP/ADMD=HITNET/PRMD=HITACHI/;gmml16061020122115AW4]
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

From: Greg KH <greg@kroah.com>
>On Thu, Oct 19, 2006 at 03:32:28PM -0700, David Miller wrote:
>> From: <eiichiro.oiwa.nm@hitachi.com>
>> Date: Thu, 19 Oct 2006 19:49:26 +0900
>> 
>> > The "0xc0000" is a physical address. The BAR (PCI base address) is also
>> > a physcail address. There are no difference.
>> 
>> Your assertion that the BAR is a physical address is very platform
>> specific.  It may be a "physical address in PCI bus space", but
>> that has no relation to the first argument passed to ioremap()
>> which is defined in a completely different way.
>> 
>> On many platforms, the BAR of PCI devices are translated into an
>> appropriate "ioremap() cookie" in the struct pci_dev resource[] array
>> entries, so that they can be used properly as the first argument to
>> ioremap().  Only address cookies properly setup by the platform may be
>> legally passed into ioremap() as the first argument.  No such setups
>> are being made on this raw 0xc0000 address.
>> 
>> So, as you can see, I/O port and I/O memory space work differently on
>> different platforms and this abstraction of the first argument to
>> ioremap() is how we provide support for such differences.
>> 
>> If you try to access 0xc0000 via ioremap() on sparc64, it is going to
>> try and access that area non-cacheable which, since 0xc0000 is
>> physical RAM, will result in a BUS ERROR and a crash.
>> 
>> This physical location might be the area for the video ROM on x86,
>> x86_64, and perhaps even IA64, but it certainly is not used this way
>> on sparc64 systems.
>> 
>> I really would like to see this regression fixed, or at the very
>> least this code protected by X86, X86_64, IA64 conditionals.
>
>I agree.  Eiichiro, care to send me an patch to fix this somehow?  Or do
>you want me to just revert it?
>
>thanks,
>
>greg k-h
>

Ok, I sent an patch to fix on only x86, x86_64 and IA64 for 2.6.18.
Do you need an patch aganist 2.6.19-git?

thanks,
Eiichiro

