Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750717AbWF1SLN@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750717AbWF1SLN (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 28 Jun 2006 14:11:13 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750728AbWF1SLN
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 28 Jun 2006 14:11:13 -0400
Received: from mx1.redhat.com ([66.187.233.31]:53379 "EHLO mx1.redhat.com")
	by vger.kernel.org with ESMTP id S1750717AbWF1SLM (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 28 Jun 2006 14:11:12 -0400
Date: Wed, 28 Jun 2006 14:10:59 -0400
From: Dave Jones <davej@redhat.com>
To: Greg KH <gregkh@suse.de>
Cc: Rafa? Bilski <rafalbilski@interia.pl>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] (Longhaul 1/5) PCI: Protect bus master DMA from Longhaul by rw semaphores
Message-ID: <20060628181059.GE23396@redhat.com>
Mail-Followup-To: Dave Jones <davej@redhat.com>, Greg KH <gregkh@suse.de>,
	Rafa? Bilski <rafalbilski@interia.pl>, linux-kernel@vger.kernel.org
References: <44A28AA2.6060306@interia.pl> <20060628173448.GA2371@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20060628173448.GA2371@suse.de>
User-Agent: Mutt/1.4.2.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jun 28, 2006 at 10:34:48AM -0700, Greg KH wrote:
 > On Wed, Jun 28, 2006 at 03:56:50PM +0200, Rafa? Bilski wrote:
 > > 	This patch will allow Longhaul cpufreq driver to change frequency
 > > without breaking BMDMA. In order to work properly it needs:
 > > - adding rw_semaphore to pci_device and bus structures - this is
 > > patch below,
 > > - Longhaul should find host bridge and lock write on bus before
 > > frequency change,
 > 
 > Eeek!  You mean the longhaul driver can change the frequency of the PCI
 > bus?  Oh, that's a recipe for disaster...

It *can* scale the FSB on some CPUs, but the Linux driver doesn't do that
as there a lot of systems that it just doesn't work on.  (Probably any
that have FSB+PCI speed tied together).  So we just scale the multiplier
and the voltage (Though currently in the driver, voltage scaling is missing,
so we never save any power, and just run at the maximum voltage the whole time).

The situation is : It needs there to be no bus mastering occuring at the time
of a CPU speed transition. Though I'm unable to find the part that mentions
this in the specs I have right now.

The really bizarre thing is that all this was working once.  Circa 2.5.late/2.6.reallyearly
I had reliable scaling of both voltage and speed on a C3.  Over time the
driver just seemed to fall apart. Perhaps we just got lucky before, and some
change occured that results changed behaviour of pci bus mastering for
some devices.

 > No, this is not acceptable.  What exactly do you want to do here?  Make
 > sure the PCI drivers are not doing DMA when the longhaul driver wants to
 > change the pci bus speed?
 > 
 > How often will this bus change happen?
 >
 > Does it really save battery?

99% of C3s aren't in battery powered devices, but it can save a considerable
amount of power (~75% on some of the earlier chips iirc).

Thankfully their newer cpu's aren't affected by this brain damage,
but there's a _lot_ of the older CPUs out there (all those EPIA boards etc).

		Dave

-- 
http://www.codemonkey.org.uk
