Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262147AbVFRQGk@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262147AbVFRQGk (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 18 Jun 2005 12:06:40 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262144AbVFRQGj
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 18 Jun 2005 12:06:39 -0400
Received: from ylpvm01-ext.prodigy.net ([207.115.57.32]:48262 "EHLO
	ylpvm01.prodigy.net") by vger.kernel.org with ESMTP id S262147AbVFRQGX
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 18 Jun 2005 12:06:23 -0400
From: David Brownell <david-b@pacbell.net>
To: jamey.hicks@hp.com
Subject: Re: recursive call to platform_device_register deadlocks
Date: Sat, 18 Jun 2005 09:06:13 -0700
User-Agent: KMail/1.7.1
Cc: Linux Kernel list <linux-kernel@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200506180906.13522.david-b@pacbell.net>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


> We could restructure the toplevel driver so that it does not call 
> platform_device inside its probe function.  An alternative would be to 
> add a pointer to a vector of subdevices to platform_device and have it 
> register the subdevices after it has probed the toplevel device.  Do you 
> have any recommendations?

Other busses have taken the former approach... the toplevel bit
being more like a bridge/hub than anything else, and the children
appearing later through some dynamic scan/hotplug.  That vector
could be used to implement such a "scan", triggered sometime after
the bridge/hub driver returns from probe(), avoiding both that
driver core deadlock and recursion during probe().

I think the SPI stack will have similar issues.  There it'll be
typical that configurations be static board-specific ones ... not
so dissimilar from configurations involving board-specific ASICs.
An SOC may have several SPI controllers, with their own chipselects,
and different boards will have different chips (like serial flash,
sensors, DAC/ADC, etc) on each chipselect.  Unlike busses designed
for hotplug, those chips won't always self-identify; a dynamic
scan won't generally behave.

Some model that makes it easy to declare static sections of the
device tree, and which is easily applied to other bus types, would
be a good thing.  Like maybe that "alternative" you sketched.

- Dave

