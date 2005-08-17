Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750810AbVHQVLU@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750810AbVHQVLU (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 17 Aug 2005 17:11:20 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751258AbVHQVLU
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 17 Aug 2005 17:11:20 -0400
Received: from atlrel7.hp.com ([156.153.255.213]:13997 "EHLO atlrel7.hp.com")
	by vger.kernel.org with ESMTP id S1750810AbVHQVLT (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 17 Aug 2005 17:11:19 -0400
From: Bjorn Helgaas <bjorn.helgaas@hp.com>
To: Corey Minyard <cminyard@mvista.com>
Subject: Re: [PATCH 2.6.12.4] ACPI oops during ipmi_si driver init
Date: Wed, 17 Aug 2005 15:09:17 -0600
User-Agent: KMail/1.8.1
Cc: Peter Martuccelli <peterm@redhat.com>, len.brown@intel.com, akpm@osdl.com,
       linux-kernel@vger.kernel.org, minyard@mvista.com
References: <200508121944.j7CJiifE005958@redrum.boston.redhat.com> <1124225401.7130.797.camel@redrum.boston.redhat.com> <43039E57.2020607@mvista.com>
In-Reply-To: <43039E57.2020607@mvista.com>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200508171509.17627.bjorn.helgaas@hp.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wednesday 17 August 2005 2:30 pm, Corey Minyard wrote:
> Basically, the IPMI system interface needs information from a specific 
> IPMI table to know how to configure itself.  Those tables can reference 
> GPEs, so the driver can use those (though AFAIK it has never been tested).

The information in the SPMI table *should* also be in the ACPI
namespace.  In general, drivers should claim devices based on the
namespace, not based on tables like SPMI.  The tables are mainly
there for the times when you need a device before the ACPI namespace
is available.

drivers/serial/8250_pnp.c is a basic example of claiming PNP
devices.  In particular, see serial_pnp_probe(), which gets
called for every device with a PNP ID found in pnp_dev_table[].

drivers/serial/8250_acpi.c is an example of claiming a device
directly from the ACPI namespace.  It claims everything with
PNP ID "PNP0501".

If you need to handle GPEs, you probably would need the
8250_acpi.c style, since I don't think PNP can deal with
those.  You would use acpi_register_driver(), and pass it
an acpi_driver struct containing '.ids = "IPI0001"'.  The
add() function you supply will get called for every active
IPI0001 device in the namespace.  Use acpi_walk_resources()
on its _CRS to extract the I/O port or MMIO address of the
controller and its interrupt information.  If the _CRS
contains no interrupt information, look for a _GPE method.
