Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750813AbWDPWnJ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750813AbWDPWnJ (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 16 Apr 2006 18:43:09 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750811AbWDPWnI
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 16 Apr 2006 18:43:08 -0400
Received: from xenotime.net ([66.160.160.81]:22459 "HELO xenotime.net")
	by vger.kernel.org with SMTP id S1750813AbWDPWnH (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 16 Apr 2006 18:43:07 -0400
Date: Sun, 16 Apr 2006 15:45:32 -0700
From: "Randy.Dunlap" <rdunlap@xenotime.net>
To: Sam Ravnborg <sam@ravnborg.org>
Cc: linux-kernel@vger.kernel.org
Subject: Re: some remaining section mismatches
Message-Id: <20060416154532.d61699d9.rdunlap@xenotime.net>
In-Reply-To: <20060415233627.GA6728@mars.ravnborg.org>
References: <20060415145231.cbe2e8db.rdunlap@xenotime.net>
	<20060415233627.GA6728@mars.ravnborg.org>
Organization: YPO4
X-Mailer: Sylpheed version 2.2.4 (GTK+ 2.8.3; x86_64-unknown-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 16 Apr 2006 01:36:27 +0200 Sam Ravnborg wrote:

> On Sat, Apr 15, 2006 at 02:52:31PM -0700, Randy.Dunlap wrote:
> > 
> > 1.  I don't understand this one.  Can you look at it?
> > 
> > WARNING: drivers/video/macmodes.o - Section mismatch: reference to .init.text:mac_find_mode from __ksymtab between '__ksymtab_mac_find_mode' (at offset 0x0) and '__ksymtab_mac_map_monitor_sense'
> 
> mac_find_mode is EXPORT_SYMBOL() and marked __init
> This does not look correct to me. How do we know that it is valid to use
> this exported symbol?
> Fix: do not mark mac_find_mode() as __init?

IIRC, I saw 2 instances of exported __init code, which seems odd
and dangerous to me, but I don't know of any rules against it...


> > 2.  This is requires either a whitelist addition or a change to the
> > struct name in the driver:
> > 
> > WARNING: drivers/scsi/megaraid/megaraid_mbox.o - Section mismatch: reference to .init.text:megaraid_probe_one from .data between 'megaraid_pci_driver_g' (at offset 0x2e0) and 'megaraid_mbox_version'
> 
> As indicated a rename would do the trick.
> s/megaraid_pci_driver_g/megaraid_pci_driver/g
> The _g syntax does not look common and for this case we will not soften
> up the pattern to look for "driver" anywhere in the variable.
> 
> > 3.  drivers/char/tpm_infineon.c:
> > 
> > WARNING: drivers/char/tpm/tpm_infineon.o - Section mismatch: reference to .init.text:tpm_inf_pnp_probe from .data between 'tpm_inf_pnp' (at offset 0x18) and 'tpm_inf'
> > WARNING: drivers/char/tpm/tpm_infineon.o - Section mismatch: reference to .exit.text:tpm_inf_pnp_remove from .data between 'tpm_inf_pnp' (at offset 0x20) and 'tpm_inf'
> > 
> > I don't see a problem here, the driver just isn't using the whitelisted
> > struct name(s).
> Agree.
> s/\<tpm_inf_pnp\>/tpm_inf_driver/g
> 
> > 4.  drivers/rtc/: rtc-sysfs.c and rtc-test.c:
> > 
> > WARNING: drivers/rtc/rtc-sysfs.o - Section mismatch: reference to .init.text:rtc_sysfs_add_device from .data between 'rtc_sysfs_interface' (at offset 0x18) and 'rtc_attr_group'
> > 
> > This could be OK, hopefully someone can say yes/no.
> Look sane. The naming *_interface looks generic - so maybe we should
> whitelist it too?

I think so.

> > WARNING: drivers/rtc/rtc-test.o - Section mismatch: reference to .exit.text:test_remove from .data between 'test_drv' (at offset 0x8) and 'dev_attr_irq'
> > 
> > Looks OK, struct name is just not in the whitelist.
> > Changing the struct name removes the warning.
> grepping shows up that naming *_drv is quite common.
> So the better fix would probarly be to whitelist it too?

Likely.  and I see probe_one in the symbol whitelist but not
init_one, and we have lots of probe functions that end with
"init_one".  Maybe something to remember in case we need it.

---
~Randy
