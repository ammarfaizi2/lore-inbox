Return-Path: <linux-kernel-owner+w=401wt.eu-S1759754AbWLKDzw@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1759754AbWLKDzw (ORCPT <rfc822;w@1wt.eu>);
	Sun, 10 Dec 2006 22:55:52 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1762377AbWLKDzw
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 10 Dec 2006 22:55:52 -0500
Received: from gate.crashing.org ([63.228.1.57]:49277 "EHLO gate.crashing.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1759754AbWLKDzv (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 10 Dec 2006 22:55:51 -0500
Subject: Re: [PATCH 4/6] MTHCA driver (infiniband) use new pci interfaces
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Stephen Hemminger <shemminger@osdl.org>
Cc: Greg Kroah-Hartman <gregkh@suse.de>, linux-pci@atrey.karlin.mff.cuni.cz,
       linux-kernel@vger.kernel.org
In-Reply-To: <20061208182500.611327000@osdl.org>
References: <20061208182241.786324000@osdl.org>
	 <20061208182500.611327000@osdl.org>
Content-Type: text/plain
Date: Mon, 11 Dec 2006 14:55:39 +1100
Message-Id: <1165809339.7260.19.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Evolution 2.8.1 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 2006-12-08 at 10:22 -0800, Stephen Hemminger wrote:
> plain text document attachment (mthca-rbc.patch)
> Use new pci interfaces to set read request tuning values
> Untested because of lack of hardware.

I'm worried by this... At no point do you check the host bridge
capabilities, and thus will happily set the max read req size to some
value larger than the max the host bridge can cope...

I've been having exactly that problem on a number of setups, for
example, the sky2 cards tend to start with a value of 512 while the G5's
host bridge can't cope with more than 256 (iirc). The firmware fixes
that up properly on the G5 at least (but not on all machines), but if
you allow drivers to go tweak the value without a way to go check what
are the host bridge capabilities, you are toast.

Of course, on PCI-X, this is moot, there is no clear definition on how
to get to a host bridge config space (if any), but on PCI-E, we should
be more careful.

So for PCI-X, if we want tat, we need a pcibios hook for the platform
to validate the size requested. For PCI-E, we can use standard code to
look for the root complex (and bridges on the path to it) and get the
proper max value.

Ben.


