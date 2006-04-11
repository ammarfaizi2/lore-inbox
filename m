Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751390AbWDKUmu@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751390AbWDKUmu (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 11 Apr 2006 16:42:50 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751391AbWDKUmu
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 11 Apr 2006 16:42:50 -0400
Received: from smtp-102-tuesday.nerim.net ([62.4.16.102]:59408 "EHLO
	kraid.nerim.net") by vger.kernel.org with ESMTP id S1751390AbWDKUmt
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 11 Apr 2006 16:42:49 -0400
Date: Tue, 11 Apr 2006 22:42:50 +0200
From: Jean Delvare <khali@linux-fr.org>
To: Rudolf Marek <r.marek@sh.cvut.cz>, Jordan Crouse <jordan.crouse@amd.com>
Cc: info-linux@ldcmail.amd.com, BGardner@Wabtec.com,
       linux-kernel@vger.kernel.org, lm-sensors@lm-sensors.org
Subject: Re: scx200_acb: Use PCI I/O resource when appropriate
Message-Id: <20060411224250.9f2b2ead.khali@linux-fr.org>
In-Reply-To: <443BD961.3050807@sh.cvut.cz>
References: <20060331230309.GE17261@cosmic.amd.com>
	<LYRIS-4270-45297-2006.04.11-06.08.18--jordan.crouse#amd.com@whitestar.amd.com>
	<20060411161942.GB13334@cosmic.amd.com>
	<443BD961.3050807@sh.cvut.cz>
X-Mailer: Sylpheed version 2.2.4 (GTK+ 2.6.10; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Rudolf, Jordan,

> Well we had the problem with i2c-viapro and vi686a. Best solution was
> to fail from the probe function - like this:
> 
>          /* Always return failure here.  This is to allow other drivers to bind
>           * to this pci device.  We don't really want to have control over the
>           * pci device, we only wanted to read as few register values from it.
>           */
>          return -ENODEV;
> 
> release_region:
>          release_region(vt596_smba, 8);
>          return error;
> }

True, but we were lucky. You can only do that if you don't need to
access the PCI configuration space during run-time (after the
initialization step) in either driver "sharing" the PCI device. The
i2c-viapro driver qualified, but for example we couldn't do that for
the i2c-i801 driver (block transactions in I2C mode require PCI
configuration register access.)

So depending on the exact hardware context, Jordan may or may not be
able to use the same trick. The other (cleaner) solution is to have an
additional module which registers the PCI device and exports some kind
of interface for the other modules to access the parts they need - but
this requires extra code and makes things much more complex too.

-- 
Jean Delvare
