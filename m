Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263436AbTJ0SCn (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 27 Oct 2003 13:02:43 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263439AbTJ0SCm
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 27 Oct 2003 13:02:42 -0500
Received: from SteeleMR-loadb-NAT-49.caltech.edu ([131.215.49.69]:3713 "EHLO
	water-ox.its.caltech.edu") by vger.kernel.org with ESMTP
	id S263436AbTJ0SCl (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 27 Oct 2003 13:02:41 -0500
Date: Mon, 27 Oct 2003 10:02:37 -0800 (PST)
From: "Noah J. Misch" <noah@caltech.edu>
X-X-Sender: noah@blinky
To: Alex Williamson <alex.williamson@hp.com>
Cc: linux-kernel <linux-kernel@vger.kernel.org>,
       acpi-devel@lists.sourceforge.net, shaohua.li@intel.com,
       len.brown@intel.com, jon@nanocrew.net
Subject: Re: [BUG] test9 ACPI bad: scheduling while atomic!
In-Reply-To: <1067273229.7497.30.camel@patsy.fc.hp.com>
Message-ID: <Pine.GSO.4.58.0310270929010.14546@blinky>
References: <Pine.GSO.4.58.0310262327040.19469@clyde> <1067273229.7497.30.camel@patsy.fc.hp.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 27 Oct 2003, Alex Williamson wrote:

> > This was obvious on my system because it has no ECDT table, and as such
> > acpi_ec_gpe_query was _always_ running in interrupt context, whereas with an
> > ECDT it would only do so for a brief time during boot, and the problem would be
> > much more subtle.  That's probably why nobody noticed this in earlier tests.
> >
>
>   I don't have an ECDT either.  Is it possible that the setting of
> ec_device_init = 1 is simply misplaced?

It is misplaced.  If revision 1.26 of ec.c were otherwise sound, I would place
ec_device_init = 1 right before the call to acpi_install_gpe_handler in
acpi_ec_start.  Anywhere outside that if and between where _add removes the
handlers and _start installs them would work.  This would fix your crash, but
it's not the right fix.

> I can see why we wouldn't want to call acpi_os_queue_for_execution() early in
> bootup, but there ought to be a fixed point after which it's ok, regardless of
> whether the system has the ECDT table.

I don't think early calls to schedule_work (via acpi_os_queue_for_execution) are
a problem.  The call to init_workqueues is just before do_initcalls in
do_basic_setup, so it happens earlier than all this stuff.

The more general problem is that acpi_ec_gpe_query cannot run in an interrupt
handler as written.  It used to always run from a queue.  We can either fix it
so it can run from an interrupt handler or change it back to never doing so.  I
favor the latter, especially because I don't see how the recent change fixed the
problem T40 users were experiencing.

> Would it be sufficient to set ec_device_init to 1 at the beginning of
> acpi_ec_add(), with no dependency on the ECDT table?

That particular placement looks racy.  I would do it after removing the
handlers, as explained above.

Thanks,
Noah

