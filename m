Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262258AbVF2CCB@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262258AbVF2CCB (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 28 Jun 2005 22:02:01 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262326AbVF2B61
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 28 Jun 2005 21:58:27 -0400
Received: from gate.crashing.org ([63.228.1.57]:41376 "EHLO gate.crashing.org")
	by vger.kernel.org with ESMTP id S262328AbVF2B4r (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 28 Jun 2005 21:56:47 -0400
Subject: Re: [PATCH 7/13]: PCI Err: Symbios SCSI  driver recovery
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Linas Vepstas <linas@austin.ibm.com>
Cc: linux-kernel@vger.kernel.org, long <tlnguyen@snoqualmie.dp.intel.com>,
       Hidetoshi Seto <seto.hidetoshi@jp.fujitsu.com>,
       Greg KH <greg@kroah.com>, ak@muc.de, Paul Mackerras <paulus@samba.org>,
       linuxppc64-dev <linuxppc64-dev@ozlabs.org>,
       linux-pci@atrey.karlin.mff.cuni.cz, johnrose@us.ibm.com
In-Reply-To: <20050628235919.GA6415@austin.ibm.com>
References: <20050628235919.GA6415@austin.ibm.com>
Content-Type: text/plain
Date: Wed, 29 Jun 2005 11:51:07 +1000
Message-Id: <1120009868.5133.232.camel@gaston>
Mime-Version: 1.0
X-Mailer: Evolution 2.2.2 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 2005-06-28 at 18:59 -0500, Linas Vepstas wrote:
> pci-err-7-symbios.patch
> 
> Adds PCI Error recoervy callbacks to the Symbios Sym53c8xx driver.
> Tested, seems to work well under i/o stress to one disk. Not
> stress tested under heavy i/o to multiple scsi devices.
> 
> Note the check of the pci error state flag inside an infinite
> loop inside the interrupt handler. Without this check, the 
> device can spin forever, locking up hard, long before the 
> asynchronous error event (and callbacks) are ever called. 

I don't understand the logic of that check. In general, I don't think
checking the error state is reliable at all. You may be in an interrupt
on the only CPU in the system, thus the error management code may have
no chance to update that error state field while you are looping... It
may work for us since we call the eeh stuff from the IO accessors but
will not in the generic case.

Normally, you should check for non-responding hardware by testing things
like reading all ff's or having a timeout in the loop. The bug is that
the driver has a potential infinite loop in the first place.

The only type of "synchronous" error checking that can be done is what
is proposed by Hidetoshi Seto. You could use his stuff here.

Ben.


