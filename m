Return-Path: <linux-kernel-owner+willy=40w.ods.org-S266386AbUGUBHI@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266386AbUGUBHI (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 20 Jul 2004 21:07:08 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266419AbUGUBHI
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 20 Jul 2004 21:07:08 -0400
Received: from rproxy.gmail.com ([64.233.170.195]:53203 "HELO mproxy.gmail.com")
	by vger.kernel.org with SMTP id S266386AbUGUBHD (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 20 Jul 2004 21:07:03 -0400
Message-ID: <170fa0d2040720180741cfa783@mail.gmail.com>
Date: Tue, 20 Jul 2004 19:07:02 -0600
From: Mike Snitzer <snitzer@gmail.com>
To: fastboot@osdl.org, linux-kernel@vger.kernel.org, netdev@oss.sgi.com
Subject: Re: [Fastboot] [ANNOUNCE] [PATCH] 2.6.8-rc1-kexec1 (ppc & x86)
Cc: "Eric W. Biederman" <ebiederm@xmission.com>
In-Reply-To: <m1y8le3cto.fsf@ebiederm.dsl.xmission.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
References: <20040719181115.86378.qmail@web52302.mail.yahoo.com> <m1y8le3cto.fsf@ebiederm.dsl.xmission.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 20 Jul 2004 09:42:11 -0600, Eric W. Biederman <ebiederm@xmission.com> wrote:
...
> I will take a look at this as soon as I finish the x86-64 port.
> Basically I am down to restructuring the generic code so it
> does not use init_mm to identity map the reboot_code_buffer,
> but instead does something architecture specific.
> 
> Removing the dependence on init_mm is going to be painful
> since it touches the generic code.  But I really don't see
> a choice at this point.
> 
> Once everything works after that change, I think kexec should
> be much closer to kernel inclusion.

As kexec approaches kernel inclusion one thing to be mindful of is
that, prior to kexec'ing, loaded drivers must let go of their PCI
resources in order for the newly kexec'd kernel's device drivers to
work.  Device drivers that don't properly let go of their resources
will likely be left in a funky state.  I've been bitten by this issue
with the e1000 (<= 5.2.52-k4) driver.  With an "Ethernet controller:
Intel Corp. 82546EB Gigabit Ethernet Controller", device id# 1010, I
get:

Intel(R) PRO/1000 Network Driver - version 5.2.30.1-k1
Copyright (c) 1999-2004 Intel Corporation.
PCI: Enabling device 04:05.0 (0000 -> 0003)
Uhhuh. NMI received for unknown reason 31.
Dazed and confused, but trying to continue
Do you have a strange power saving mode enabled?
The EEPROM Checksum Is Not Valid
PCI: Enabling device 04:05.1 (0000 -> 0003)
The EEPROM Checksum Is Not Valid

The 5.2.52-k4 has toned down, yet basically the same, errors.  This
message results when kexec'ing from a 2.6.7 kernel with the e1000
builtin; once I made the e1000 a module and unloaded it prior to
kexec'ing all was fine.

Looking at the e1000 source it is clear that removing the e1000 module
triggers e1000_remove() via module_exit()'s pci_unregister_driver(). 
Once the e1000 let go of the PCI resources the kexec'd kernel's e1000
driver was happy.  Kexec looks to call all loaded modules' shutdown()
routine.  The e1000 doesn't have shutdown(); but it does have a
remove().

In preparation for kexec to be viable for 2.6 inclusion it would
appear that some effort will need to go in to making sure all drivers
in the kernel actually let go of their resources.  Should there be an
audit to verify all device drivers have a shutdown()?

Another option is to call each module's remove() iff the module
doesn't have shutdown().  This would require changing
drivers/base/power/shutdown.c device_shutdown() to include ... else if
(dev->driver && dev->driver->remove) ... As a side-effect it would
make drivers like the e1000 safe for use with kexec.

thoughts?
Mike
