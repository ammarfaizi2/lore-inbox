Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932181AbWHKQGc@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932181AbWHKQGc (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 11 Aug 2006 12:06:32 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932177AbWHKQGb
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 11 Aug 2006 12:06:31 -0400
Received: from atlrel8.hp.com ([156.153.255.206]:10677 "EHLO atlrel8.hp.com")
	by vger.kernel.org with ESMTP id S932176AbWHKQGa (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 11 Aug 2006 12:06:30 -0400
From: Bjorn Helgaas <bjorn.helgaas@hp.com>
To: Len Brown <lenb@kernel.org>
Subject: Re: IRQ Mis-matches in 2.6.17.7
Date: Fri, 11 Aug 2006 10:05:58 -0600
User-Agent: KMail/1.9.1
Cc: Matthew Johnson <matt@matthew.ath.cx>, linux-kernel@vger.kernel.org,
       linux-acpi@vger.kernel.org
References: <Pine.LNX.4.63.0608110945510.15208@illythia.matthew.ath.cx> <200608111144.36751.len.brown@intel.com>
In-Reply-To: <200608111144.36751.len.brown@intel.com>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="utf-8"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200608111005.59434.bjorn.helgaas@hp.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Friday 11 August 2006 09:44, Len Brown wrote:
> On Friday 11 August 2006 04:53, Matthew Johnson wrote:
> 
> ACPI: PCI Interrupt Link [LNKC] enabled at IRQ 4
> PCI: setting IRQ 4 as level-triggered
> ACPI: PCI Interrupt 0000:00:0f.0[A] -> Link [LNKC] -> GSI 4 (level, low) -> IRQ 4
> 3c59x: Donald Becker and others. www.scyld.com/network/vortex.html
> 0000:00:0f.0: 3Com PCI 3c905B Cyclone 100baseTx at e0802000.
> 
> setup_irq: irq handler mismatch
>  <c0135b3e> setup_irq+0x10d/0x11a  <e2024b74> irq_handler+0x0/0x4e0 [lirc_serial]
>  <c0135bba> request_irq+0x6f/0x8b  <e202410a> set_use_inc+0xab/0x1b9 [lirc_serial]
>  <e201f467> irctl_open+0x155/0x1e8 [lirc_dev]  <c015678b> chrdev_open+0x15e/0x17a
>  <c015662d> chrdev_open+0x0/0x17a  <c014e9d7> __dentry_open+0xe0/0x1cf
>  <c014eb2a> nameidata_to_filp+0x19/0x28  <c014eb64> do_filp_open+0x2b/0x31
>  <c014ec4a> do_sys_open+0x3c/0xae  <c014ece9> sys_open+0x16/0x18
>  <c0102a5f> syscall_call+0x7/0xb 
> lirc_serial: IRQ 4 busy

Is this problem new with 2.6.17.7?  On the face of it, it looks
like every kernel should have this problem if you have other
devices on IRQ 4.

Other devices (ehci_hcd:usb1  eth0  ohci1394) are already using
IRQ 4.  lirc_serial doesn't request a shared IRQ unless you use
the "share_irq" module parameter.  A request for exclusive use
of IRQ 4 will fail if it's already in use.  So I suspect that if
you use the "share_irq" parameter, it will work.

I recently fixed a similar bug in the 8250_pnp driver:
  http://kernel.org/git/?p=linux/kernel/git/torvalds/linux-2.6.git;a=commitdiff;h=cb6358eb69d9854f65f2979c0ce9280eee041828

It would be nice if lirc_serial used PNP to discover its resources.
Then we should be able to handle this automatically, without any
module parameters.

Bjorn
