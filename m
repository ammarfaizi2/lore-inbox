Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262750AbUAHA4j (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 7 Jan 2004 19:56:39 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262731AbUAHA4j
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 7 Jan 2004 19:56:39 -0500
Received: from stat1.steeleye.com ([65.114.3.130]:39619 "EHLO
	hancock.sc.steeleye.com") by vger.kernel.org with ESMTP
	id S262705AbUAHA4g (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 7 Jan 2004 19:56:36 -0500
Subject: Re: Patch for reset in ini9100u [Initio 9100U(W)]
From: James Bottomley <James.Bottomley@steeleye.com>
To: Jonathan McDowell <noodles@earth.li>
Cc: SCSI Mailing List <linux-scsi@vger.kernel.org>,
       Linux Kernel <linux-kernel@vger.kernel.org>
In-Reply-To: <20040106231426.GR1845@earth.li>
References: <20040106231426.GR1845@earth.li>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
X-Mailer: Ximian Evolution 1.0.8 (1.0.8-9) 
Date: 07 Jan 2004 18:56:04 -0600
Message-Id: <1073523364.1883.12.camel@mulgrave>
Mime-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 2004-01-06 at 17:14, Jonathan McDowell wrote:
> I have an IWill 2935UW SCSI controller which uses the ini9100u driver.
> This has been working fine under 2.4 but I've recently built up a box of
> spare bits including the controller and installed 2.6 on it. The driver
> is marked broken in 2.6, apparently because of a lack of reset/abort
> functionality as it compiles and runs ok. So I've taken a stab at
> getting reset support back. Patch is below and it's received minimal
> testing - it boots, removes the callback trace and error message and
> doesn't seem to cause problems (the only disk in the machine is on this
> card).

I think it's a good beginning.  However, there are some things that
could be done to improve it.

> +int i91u_bus_reset(Scsi_Cmnd * SCpnt)
> +{
> +	HCS *pHCB;
> +
> +	pHCB = (HCS *) SCpnt->device->host->base;
> +	tul_reset_scsi_bus(pHCB);

This won't quite do beacuse tul_reset_scsi_bus() has some really nasty
properties

Under the old error handler, the reset routine was responsible for
resetting the bus, waiting the timeout (which tul_reset_scsi_bus() does
with a busy wait) and flushing the queue.

In the new scheme, the eh thread takes care of all of this (including a
nice thread based wait).

I think this may all work correctly if you change this call to:

tul_reset_scsi(pHCB, 0);

instead.  That should simply reset the bus and not busy wait at all,
which is really what the error handler is expecting.

James


