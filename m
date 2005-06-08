Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261461AbVFHReo@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261461AbVFHReo (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 8 Jun 2005 13:34:44 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261456AbVFHRea
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 8 Jun 2005 13:34:30 -0400
Received: from umbar.esa.informatik.tu-darmstadt.de ([130.83.163.30]:9088 "EHLO
	umbar.esa.informatik.tu-darmstadt.de") by vger.kernel.org with ESMTP
	id S261398AbVFHReO (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 8 Jun 2005 13:34:14 -0400
Date: Wed, 8 Jun 2005 19:34:09 +0200
From: Andreas Koch <koch@esa.informatik.tu-darmstadt.de>
To: Ivan Kokshaysky <ink@jurassic.park.msu.ru>
Cc: Andreas Koch <koch@esa.informatik.tu-darmstadt.de>,
       Linus Torvalds <torvalds@osdl.org>, linux-pci@atrey.karlin.mff.cuni.cz,
       linux-kernel@vger.kernel.org, gregkh@suse.de
Subject: Re: PROBLEM: Devices behind PCI Express-to-PCI bridge not mapped
Message-ID: <20050608173409.GA32004@erebor.esa.informatik.tu-darmstadt.de>
References: <20050603232828.GA29860@erebor.esa.informatik.tu-darmstadt.de> <Pine.LNX.4.58.0506031706450.1876@ppc970.osdl.org> <20050604013311.GA30151@erebor.esa.informatik.tu-darmstadt.de> <Pine.LNX.4.58.0506031851220.1876@ppc970.osdl.org> <20050604022600.GA8221@erebor.esa.informatik.tu-darmstadt.de> <Pine.LNX.4.58.0506032149130.1876@ppc970.osdl.org> <20050604155742.GA14384@erebor.esa.informatik.tu-darmstadt.de> <20050605204645.A28422@jurassic.park.msu.ru> <20050606002739.GA943@erebor.esa.informatik.tu-darmstadt.de> <20050606184335.A30338@jurassic.park.msu.ru>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20050606184335.A30338@jurassic.park.msu.ru>
User-Agent: Mutt/1.5.8i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> I think the correct behaviour of pcibios_allocate_bus_resources()
> (arch/i386/pci/i386.c) should be as follows:
> if some bridge resource cannot be allocated for whatever reason,
> don't allow any child resource assignments in that range. Just
> clear the resource flags - this prevents building an inconsistent
> resource tree.
>
> pci_assign_unassigned_resources() should correctly configure bridge 1
> and all subordinate stuff then.

I just found the time to test your latest patch (sorry for the delay).
However, it doesn't seem to help.

First of all, I verified that your code is indeed being called. That
does occur.  Specifically, resources cannot be allocated for the
following bridges and regions:

  0000:00:01.0, region #10
  0000:00:1c.0, regions #7,8,9,10
  0000:00:1c.1, regions #7,8,9,10
  0000:00:1c.2, regions #7,8,9,10
  0000:02:00.0, regions #7,8,9,10
  0000:03:05.0, regions #7,8,9,10
  0000:00:1e.0, regions #7,8,9,10
  0000:06:09.0, regions #7,8,9,10
  0000:06:09.1, regions #7,8,9,10
  0000:06:09.3, regions #7,8,9,10

However, after pci_assign_unassigned_resources() has been called, the
MEM and PREFETCH regions of the bridge 0000:00:1e.0 (bridge 1) _remain_
invalid at 0x00000000.

The boot hangs (as before) when attempting to start the CardBus
controller in the dock.

If you need further info, please let me know.

Andreas
