Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263179AbTJ0QrO (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 27 Oct 2003 11:47:14 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263305AbTJ0QrO
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 27 Oct 2003 11:47:14 -0500
Received: from atlrel9.hp.com ([156.153.255.214]:19938 "EHLO atlrel9.hp.com")
	by vger.kernel.org with ESMTP id S263179AbTJ0QrN (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 27 Oct 2003 11:47:13 -0500
Subject: Re: [BUG] test9 ACPI bad: scheduling while atomic!
From: Alex Williamson <alex.williamson@hp.com>
To: "Noah J. Misch" <noah@caltech.edu>
Cc: linux-kernel <linux-kernel@vger.kernel.org>,
       acpi-devel@lists.sourceforge.net, shaohua.li@intel.com,
       len.brown@intel.com, jon@nanocrew.net
In-Reply-To: <Pine.GSO.4.58.0310262327040.19469@clyde>
References: <Pine.GSO.4.58.0310262327040.19469@clyde>
Content-Type: text/plain
Message-Id: <1067273229.7497.30.camel@patsy.fc.hp.com>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.5 
Date: Mon, 27 Oct 2003 09:47:09 -0700
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 2003-10-27 at 01:22, Noah J. Misch wrote:

> This problem stems from the changes in revision 1.26 of drivers/acpi/ec.c.
> They come from a patch Shaohua Li submitted for kernel bug 1171 at
> bugme.osdl.org.  That patch can cause acpi_ec_gpe_query to run in interrupt
> context, whereas before it always ran from a workqueue.  It does non-interrupt
> like things, like sleeping and kmalloc'ing with GFP_KERNEL.
> 
> This was obvious on my system because it has no ECDT table, and as such
> acpi_ec_gpe_query was _always_ running in interrupt context, whereas with an
> ECDT it would only do so for a brief time during boot, and the problem would be
> much more subtle.  That's probably why nobody noticed this in earlier tests.
> 

  I don't have an ECDT either.  Is it possible that the setting of
ec_device_init = 1 is simply misplaced?  I can see why we wouldn't want
to call acpi_os_queue_for_execution() early in bootup, but there ought
to be a fixed point after which it's ok, regardless of whether the
system has the ECDT table.  Would it be sufficient to set ec_device_init
to 1 at the beginning of acpi_ec_add(), with no dependency on the ECDT
table?

	Alex

-- 
Alex Williamson                             HP Linux & Open Source Lab

