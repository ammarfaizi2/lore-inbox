Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751807AbWCATQF@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751807AbWCATQF (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 1 Mar 2006 14:16:05 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750847AbWCATQF
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 1 Mar 2006 14:16:05 -0500
Received: from atlrel7.hp.com ([156.153.255.213]:29144 "EHLO atlrel7.hp.com")
	by vger.kernel.org with ESMTP id S1750758AbWCATQD (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 1 Mar 2006 14:16:03 -0500
From: Bjorn Helgaas <bjorn.helgaas@hp.com>
To: Sam Ravnborg <sam@ravnborg.org>
Subject: Re: Use of __init in asus_acpi.c + sony_acpi.c?
Date: Wed, 1 Mar 2006 12:15:59 -0700
User-Agent: KMail/1.8.3
Cc: len.brown@intel.com, LKML <linux-kernel@vger.kernel.org>,
       linux-acpi@vger.kernel.org,
       Karol Kozimor <sziwan@users.sourceforge.net>,
       Julien Lerouge <julien.lerouge@free.fr>,
       acpi4asus-user@lists.sourceforge.net, Stelian Pop <stelian@popies.net>
References: <20060226094206.GA9871@mars.ravnborg.org>
In-Reply-To: <20060226094206.GA9871@mars.ravnborg.org>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200603011215.59604.bjorn.helgaas@hp.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sunday 26 February 2006 02:42, Sam Ravnborg wrote:
> WARNING: drivers/acpi/asus_acpi.o - Section mismatch: reference to \
> .init.text:asus_hotk_add from .data between 'asus_hotk_driver' (at \
> offset 0xe0) and 'model_conf'
> WARNING: drivers/acpi/sony_acpi.o - Section mismatch: reference to \
> .init.text:sony_acpi_add from .data between 'sony_acpi_driver' (at \
> offset 0xe0) and 'sony_acpi_values'
> ...
> From browsing the code I cannot see when this happens.
> In asus_acpi.c and sony_acpi.c the .add and .remove methods are
> declared __init/__exit indicating that the add method is solely used
> during early init of the module.
> 
> Is it correct that acpi_bus_register_driver() is only called during the
> early init phase of a drivers and so we can discard the .add methods
> after first usage?

I think this is a bug in asus_acpi.c and sony_acpi.c.  They assume
that their devices can not be hot-plugged, so if they aren't found
at the time of acpi_bus_register_driver(), they can discard the
.add() methods.

It is true that these particular devices can't be hot-plugged, but
there's no way to tell that to acpi_bus_register_driver(), so we have
to assume .add() could be called as long as the driver remains
registered.

I'll cook up a patch for asus_acpi.c and sony_acpi.c.  Thanks for
finding this.

Bjorn
