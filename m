Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261805AbTDHVXj (for <rfc822;willy@w.ods.org>); Tue, 8 Apr 2003 17:23:39 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261866AbTDHVXj (for <rfc822;linux-kernel-outgoing>); Tue, 8 Apr 2003 17:23:39 -0400
Received: from natsmtp01.webmailer.de ([192.67.198.81]:32694 "EHLO
	post.webmailer.de") by vger.kernel.org with ESMTP id S261805AbTDHVXd (for <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 8 Apr 2003 17:23:33 -0400
Date: Tue, 8 Apr 2003 23:34:03 +0200
From: Dominik Brodowski <linux@brodo.de>
To: Jeff Garzik <jgarzik@pobox.com>
Cc: linux-kernel@vger.kernel.org, rmk@arm.linux.org.uk
Subject: Re: [PATCHES 2.5.67] PCMCIA hotplugging, in-kernel-matching and depmod support
Message-ID: <20030408213403.GA5250@brodo.de>
References: <20030408205623.GA5253@brodo.de> <20030408212059.GA5358@gtf.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20030408212059.GA5358@gtf.org>
User-Agent: Mutt/1.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Apr 08, 2003 at 05:20:59PM -0400, Jeff Garzik wrote:
> On Tue, Apr 08, 2003 at 10:56:23PM +0200, Dominik Brodowski wrote:
> > ... and the deprecation of "cardmgr" and "cardctl"
> > 
> > Dear kernel developers and testers,
> > 
> > Updated and re-diffed revisions of my pcmcia-related patches are 
> > available at http://www.brodo.de/pcmcia/
> > 
> > These patches update the PCMCIA subsystem (16-bit) to use the driver
> > model matching and hotplug utilities. The "cardmgr" will not be 
> > needed any longer - in fact, it won't even work any longer.
> > 
> > They are based on kernel 2.5.67
> 
> Will we see pcmcia id lists making their way into low-level drivers?
> 
> That was a big stumbling block when I last looked at the "big picture"
> for pcmcia -- in-kernel drivers still required probe assistance from
> userspace via the /etc/pcmcia/* bindings.

In the drivers I converted (~20 or so...) this is done already. You can 
find them at http://www.brodo.de/pcmcia/ , for example the network drivers
(all of them should be converted) at
http://www.brodo.de/pcmcia/pcmcia-2.5.67-drivers_network .

For example, a part of pcnet_cs.c looks like this now:

static struct pcmcia_device_id pcnet_ids[] = {
	{ PCMCIA_DEVICE_VERS1("2412LAN", 0x67f236ab) },
	{ PCMCIA_DEVICE_VERS12("ACCTON", "EN2212", 0xdfc6b5b2, 0xcb112a11) },
	...
	{ PCMCIA_MFC_DEVICE_MANF_CARD(0, 0x0105, 0xea15) },
	{ },
};
MODULE_DEVICE_TABLE(pcmcia, pcnet_ids);

As strings can't be passed to userspace in file2alias.c, I've chosen the
crc32 value of the string as the matching identifier for the userspace
hotplug script. In-kernel matching uses the full string then. And _MFC_
stands for multi-function-card , function 0 of the card in the example above
will be bound to this driver. Oh, and I didn't do this parsing by hand --
wrote an ugly /etc/pcmcia/config --> pcmcia_device_id_table parser (which
works) and I'm willing to convert any entries still left over.

	Dominik
