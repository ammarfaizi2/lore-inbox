Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262953AbUKTNqQ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262953AbUKTNqQ (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 20 Nov 2004 08:46:16 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262936AbUKTNqQ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 20 Nov 2004 08:46:16 -0500
Received: from clock-tower.bc.nu ([81.2.110.250]:17283 "EHLO
	localhost.localdomain") by vger.kernel.org with ESMTP
	id S262928AbUKTNpz (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 20 Nov 2004 08:45:55 -0500
Subject: Re: [PATCH 1/2] pci: Block config access during BIST
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Cc: brking@us.ibm.com, Greg KH <greg@kroah.com>,
       Paul Mackerras <paulus@samba.org>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
In-Reply-To: <1100934567.3669.12.camel@gaston>
References: <200411192023.iAJKNNSt004374@d03av02.boulder.ibm.com>
	 <1100917635.9398.12.camel@localhost.localdomain>
	 <1100934567.3669.12.camel@gaston>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Message-Id: <1100954543.11822.8.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.6 (1.4.6-2) 
Date: Sat, 20 Nov 2004 12:42:24 +0000
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sad, 2004-11-20 at 07:09, Benjamin Herrenschmidt wrote:
> Unfortunately, Alan, the cases where it matters aren't a driver with bad
> locking or some something that can be fixed at the driver level. There
> are already 2 uses of the above:

That doesn't mean it is the right implementation. Most devices don't
need
this check so might as well have a fast path. You can at least reduce
the cost by setting a flag on devices that potentially have this problem
(or a PCI_ANY PCI_ANY quirk for platforms with it globally)

>  - The device he's working on, which sometimes need to trigger a BIST
> (built-in self test). During this operation, the device stops responding
> on the PCI bus, which can be sort-of fatal if anything (userland playing
> with /sys/bus/pci/* for example) touches the config space.

That will be fun given some laptop SMM touches config space.

> I would add: Config space accesses are slow anyways. They are even
> horribly slow. They are worse than IO accesses. I _VERY_MUCH_ doubt that
> a test of a variable member of pci_dev like the above would have any
> noticeable impact here.

Some of the Intel CPU's are very bad at lock handling so it is an issue.
Also most PCI config accesses nowdays go to onboard devices whose
behaviour may well be quite different to PCI anyway. PCI has become a
device management API.

I dislike the "Hey it sucks, lets make it suck more" approach when it
seems easy to do the job well.

Alan

