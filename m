Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262257AbUDOKi4 (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 15 Apr 2004 06:38:56 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262142AbUDOKiz
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 15 Apr 2004 06:38:55 -0400
Received: from parcelfarce.linux.theplanet.co.uk ([195.92.249.252]:39576 "EHLO
	www.linux.org.uk") by vger.kernel.org with ESMTP id S261865AbUDOKiv
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 15 Apr 2004 06:38:51 -0400
Date: Thu, 15 Apr 2004 11:38:49 +0100
From: viro@parcelfarce.linux.theplanet.co.uk
To: Maneesh Soni <maneesh@in.ibm.com>, LKML <linux-kernel@vger.kernel.org>,
       Greg KH <greg@kroah.com>
Subject: Re: [RFC] fix sysfs symlinks
Message-ID: <20040415103849.GA24997@parcelfarce.linux.theplanet.co.uk>
References: <20040413124037.GA21637@in.ibm.com> <20040413133615.GZ31500@parcelfarce.linux.theplanet.co.uk> <20040414064015.GA4505@in.ibm.com> <20040414070227.GA31500@parcelfarce.linux.theplanet.co.uk> <20040415091752.A24815@flint.arm.linux.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20040415091752.A24815@flint.arm.linux.org.uk>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Apr 15, 2004 at 09:17:52AM +0100, Russell King wrote:
> > Erm...  If rmmod _ever_ waits for refcount on kobject to reach zero, it's
> > already broken.  Do you have any examples of such behaviour?
> 
> Every single module which unregisters a struct device_driver.

Ehh...  So we have a pile of deadlocks (root-only, but still...) and
a lovely user-exploitable DoS.  Consider the following:

	open an AF_UNIX socket pair.
	go through sysfs directories of all drivers, opening all of them
	put obtained descriptors into SCM_RIGHTS packet and send it
	close all these descriptors
	sleep

Voila - later rmmod attempts will hang (not just say "busy") and no, fuser
won't catch your process.  And IIRC, serialization in module.c will lead
to nasty consequences for any subsequent attempts of module insertion.

Do we really need to embed those structures?  E.g. pci_driver (the main source
of those guys, AFAICS) could very well make ->driver dynamically allocated
at pci_register_driver() and have it freed by its ->release().  With no
waiting of any kind.  The only places that would require changes would be
drivers/pci/pci-driver.c and definition of to_pci_driver() - nobody else
ever touches ->driver.

OTOH, eisa looks worse and the rest of them could be even uglier ;-/
Sigh...
