Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262044AbUCXV6q (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 24 Mar 2004 16:58:46 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262078AbUCXV6q
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 24 Mar 2004 16:58:46 -0500
Received: from e34.co.us.ibm.com ([32.97.110.132]:32416 "EHLO
	e34.co.us.ibm.com") by vger.kernel.org with ESMTP id S262044AbUCXV6l
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 24 Mar 2004 16:58:41 -0500
Date: Wed, 24 Mar 2004 15:58:32 -0600
From: linas@austin.ibm.com
To: linux-kernel@vger.kernel.org
Cc: linux-hotplug-devel@lists.sourceforge.net
Subject: Enhanced PCI Error Recovery
Message-ID: <20040324155832.A64292@forte.austin.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Hi,

I'm trying to implement some enhanced PCI error recovery features
for some of the PCI chipsets on IBM pSeries (powerpc64) boxes.
I'm lead to beleive that other chipsets (in particular PCI Express
chipsets) might have similar features, and thus I'd like to find 
out who else is working on something like this & could share in 
the discussion/design/implementation.

The IBM pSeries boxes have something called "EEH" (Enhanced Error 
Handling) that deals with the kinds of errors that the older PCI
spec explicitly ignored (except to check-stop the cpu, which would
be a bad thing to do on a big server).  EEH handled errors that
couldn't otherwise be "reported", such as parity errors on posted 
writes, or io adapters that assert SERR (system error) back to 
the host bridge.  It handled these errors by (synchronously) 
cutting off all i/o to the adapter (writes are dropped on the 
floor, reads return all foxes).  It provides a way of 'recovering' 
from these, in a rather blunt fashion: for all practical purposes, 
its equivalent to toggling the power for that PCI slot, and 
restarting the device driver.

I've been told that PCI Express provides roughly similar function
(although that's far from obvious) and that there are people working
on implementing it for the linux kernel.   I'm reading the PCI Express 
spec; it talks about "fatal errors": these are handled by interrupting 
the cpu, and putting the error status in various registers.   The spec 
does not seem to talk about how the software can recover from 
the "unrecoverable" errors, nor does it seem to mention what happens
if a device driver continues to try to access a device after an
unrecoverable error occurred. 

I was hoping to write the pSeries code so that it mostly sat in
the arch/ppc64 directory... but if there are really other efforts
then maybe we should talk about sharing code/design.

(My goal is to reset the device, be it a scsi card or an ethernet card,
re-init the device driver, and go on, ideally without letting the 
block device or sockets layer up above to ever find out there was 
any problem.  So that e.g. an unrecoverable error under your root
partition doesn't have to end in a kernel panic).

Due to the high traffic on LKML, and some superficial similarity
between this and pci-hotplug, I recommend continuing discussion on 

linux-hotplug-devel@lists.sourceforge.net
http://linux-hotplug.sourceforge.net

--linas
