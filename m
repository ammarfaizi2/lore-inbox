Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263210AbTJKDnk (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 10 Oct 2003 23:43:40 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263214AbTJKDnk
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 10 Oct 2003 23:43:40 -0400
Received: from fmr04.intel.com ([143.183.121.6]:7561 "EHLO
	caduceus.sc.intel.com") by vger.kernel.org with ESMTP
	id S263210AbTJKDnj (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 10 Oct 2003 23:43:39 -0400
Subject: 2.6.0-test7 build failure: !CONFIG_PCI
From: Len Brown <len.brown@intel.com>
To: "Linux-Kernel (E-mail)" <linux-kernel@vger.kernel.org>
Cc: acpi-devel@lists.sourceforge.net
In-Reply-To: <BF1FE1855350A0479097B3A0D2A80EE001126CB1@hdsmsx402.hd.intel.com>
References: <BF1FE1855350A0479097B3A0D2A80EE001126CB1@hdsmsx402.hd.intel.com>
Content-Type: text/plain
Organization: 
Message-Id: <1065843784.4112.49.camel@dhcppc4>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.2.3 
Date: 10 Oct 2003 23:43:05 -0400
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Does anybody build X86 without CONFIG_PCI?

Build fails if CONFIG_BLK_DEV_CMD640 is set:

drivers/built-in.o(.init.text+0x59df): In function `ide_setup':
: undefined reference to `cmd640_vlb'
drivers/built-in.o(.init.text+0x5aef): In function `probe_for_hwifs':
: undefined reference to `ide_probe_for_cmd640x'
make: *** [.tmp_vmlinux1] Error 1

The problem is that these variables are defined in
drivers/ide/pci/cmd640.c, which is protected by CONFIG_PCI; but they're
used when CONFIG_BLK_DEV_CMD640, which doesn't require CONFIG_PCI.

---
More interesting (to me) is that it also fails if CONFIG_ACPI is set:

drivers/built-in.o(.init.text+0x825): In function `acpi_bus_init':
: undefined reference to `eisa_set_level_irq'

drivers/acpi/bus.c:

#ifdef CONFIG_X86
        /* Ensure the SCI is set to level-triggered, active-low */
        if (acpi_ioapic)
                mp_config_ioapic_for_sci(acpi_fadt.sci_int);
        else
                eisa_set_level_irq(acpi_fadt.sci_int);
#endif

Should we not be calling eisa_set_level_irq()?

thanks,
-Len


