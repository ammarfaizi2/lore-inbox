Return-Path: <linux-kernel-owner+w=401wt.eu-S932715AbXAJECk@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932715AbXAJECk (ORCPT <rfc822;w@1wt.eu>);
	Tue, 9 Jan 2007 23:02:40 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932719AbXAJECk
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 9 Jan 2007 23:02:40 -0500
Received: from emerald.lightlink.com ([205.232.34.14]:1108 "EHLO
	emerald.lightlink.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932715AbXAJECj (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 9 Jan 2007 23:02:39 -0500
Date: Tue, 9 Jan 2007 22:58:20 -0500
From: "Mark M. Hoffman" <mhoffman@lightlink.com>
To: Jean Delvare <khali@linux-fr.org>
Cc: Adrian Bunk <bunk@stusta.de>, greg@kroah.com,
       linux-pci@atrey.karlin.mff.cuni.cz, linux-kernel@vger.kernel.org
Subject: Re: [-mm patch] drivers/pci/quirks.c: cleanup
Message-ID: <20070110035820.GB27550@jupiter.solarsys.private>
References: <20061219041315.GE6993@stusta.de> <20070105095233.4ce72e7e.khali@linux-fr.org> <20070107154441.GB22558@jupiter.solarsys.private> <20070108121055.d25c8ffa.khali@linux-fr.org> <20070109030226.GA2408@jupiter.solarsys.private> <20070109141721.b823187c.khali@linux-fr.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20070109141721.b823187c.khali@linux-fr.org>
User-Agent: Mutt/1.4.2.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Jean:

> On Mon, 8 Jan 2007 22:02:26 -0500, Mark M. Hoffman wrote:
> > 3) I've just confirmed that this quirk is still broken on recent FC6 kernels.
> > Perhaps they should have picked my patch out of their bugzilla, but they didn't.

* Jean Delvare <khali@linux-fr.org> [2007-01-09 14:17:21 +0100]:
> I am worried about the Intel/Asus SMBus quirk then, which affects many
> more users than the SiS SMBus one, and would suffer from a reordering as
> well.

Intel/Asus users on FC[456] would surely have screamed if that was true.  But I
was curious so I looked deeper.  There is a fundamental difference between the
Intel SMBus quirks and the SiS SMBus quirk...

Intel:
1) The first quirk keys off the host bridge, setting a flag.  
2) The second quirk keys off the LPC, enabling the SMBus if the flag was set.

SiS:
1) The first quirk keys off the *old* LPC ID... this causes the ID to change.[1]
2) The second quirk keys off the *new* LPC ID; this one enables the SMBus.

In the SiS case, both quirks key off the *same* *device*, but with potentially
different IDs.  The quirk list ordering matters there because the list is
scanned only once per device.

For the Intel case, the only ordering that matters is that the host bridge
device is added [pci_device_add()] before the LPC; AFAICT, that is reliable,
perhaps even by definition.

So I don't think you have to worry about the Intel SMBus quirks.

[1] That's right, the first quirk actually changes the PCI device ID of the
LPC.  Unless it actually *is* older hardware... in which case the quirk just
tickles a reserved bit that is ignored.  Thank you SiS, that's just beautiful.

Regards,

-- 
Mark M. Hoffman
mhoffman@lightlink.com

