Return-Path: <linux-kernel-owner+willy=40w.ods.org-S965012AbVHOWPJ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965012AbVHOWPJ (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 15 Aug 2005 18:15:09 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965011AbVHOWPJ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 15 Aug 2005 18:15:09 -0400
Received: from atlrel7.hp.com ([156.153.255.213]:17586 "EHLO atlrel7.hp.com")
	by vger.kernel.org with ESMTP id S965010AbVHOWPH (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 15 Aug 2005 18:15:07 -0400
From: Bjorn Helgaas <bjorn.helgaas@hp.com>
To: Peter Martuccelli <peterm@redhat.com>
Subject: Re: [PATCH 2.6.12.4] ACPI oops during ipmi_si driver init
Date: Mon, 15 Aug 2005 16:13:10 -0600
User-Agent: KMail/1.8.1
Cc: len.brown@intel.com, akpm@osdl.com, linux-kernel@vger.kernel.org
References: <200508121944.j7CJiifE005958@redrum.boston.redhat.com>
In-Reply-To: <200508121944.j7CJiifE005958@redrum.boston.redhat.com>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200508151613.10389.bjorn.helgaas@hp.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Friday 12 August 2005 1:44 pm, Peter Martuccelli wrote:
> Stumbled into this problem working on the ipmi_si driver.  When the
> ipmi_si driver initialization fails the acpi_tb_get_table 
> call, after rsdt_info has been allocated, acpi_get_firmware_table()
> will oops trying to reference off rsdt_info->pointer in the cleanup
> code.

I don't know whether the ACPI patch is correct or desirable, but
I think the ipmi_si ACPI discovery is bogus (it was probably
written before the current ACPI and PNPACPI driver registration
interfaces were stable).

Currently, ipmi_si uses the static SPMI table to locate the
device.  But the static table should only be used if we need
the device very early, before the ACPI namespace is available.

I don't think we use the device early, so we should use
pnp_register_driver() to claim the appropriate PNP IDs.
Or we might have to use acpi_bus_register_driver() since
it looks like it uses ACPI-specific features like GPEs.
