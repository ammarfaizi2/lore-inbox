Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264389AbTDPOfG (for <rfc822;willy@w.ods.org>); Wed, 16 Apr 2003 10:35:06 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264412AbTDPOfF 
	(for <rfc822;linux-kernel-outgoing>);
	Wed, 16 Apr 2003 10:35:05 -0400
Received: from dp.samba.org ([66.70.73.150]:40672 "EHLO lists.samba.org")
	by vger.kernel.org with ESMTP id S264389AbTDPOfE 
	(for <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 16 Apr 2003 10:35:04 -0400
Date: Thu, 17 Apr 2003 00:46:31 +1000
From: David Gibson <david@gibson.dropbear.id.au>
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
Cc: ranty@debian.org, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: firmware separation filesystem (fwfs)
Message-ID: <20030416144631.GB899@zax>
Mail-Followup-To: David Gibson <david@gibson.dropbear.id.au>,
	Alan Cox <alan@lxorguk.ukuu.org.uk>, ranty@debian.org,
	Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
References: <20030416005710.GB29682@ranty.ddts.net> <1050492681.28586.39.camel@dhcp22.swansea.linux.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1050492681.28586.39.camel@dhcp22.swansea.linux.org.uk>
User-Agent: Mutt/1.5.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Apr 16, 2003 at 12:31:21PM +0100, Alan Cox wrote:
> How is this better than simply having your hotplug helper load
> the firmware from disk ? Its nice code but you have to ask the
> question "why". I don't want the firmware wasting ram, I don't
> need the firmware fs wasting ram. I may need to load the right
> firmware from a choice of 16 odd types (usb_serial has some
> examples there).

The obvious case is where it's impossible, or at least difficult/messy
for userspace to directly access the device to upload the firmware.
The latter is the case for the orinoco devices: the same firmwares can
be used by USB, PCMCIA and PCI devices - these all have somewhat
different register configurationss and different upload methods.
Having an upload program that handles all these cases (not to mention
endian and IO vs. memory mapped registers) seems silly when the driver
already knows how to talk to the devices properly (actually we don't
do firmware upload yet, but one day).  

The driver could provide a chardev interface to upload the firmware
through, but that's a lot more work - and there are issues of mapping
the right chardev to the right network device instance, coping with
the device in half-alive mode (i.e. initialized enough that firmware
can be uploaded, but not ready to use because there's no firmware yet)
etc.

I believe the idea is that hotplug (or other scripts) would copy the
appropriate firmware into the relevant path in fwfs, so you don't need
RAM for every firmware variant - just the one you're using.  And if
we're really worried about memory it shouldn't be hard for the driver
to arrange to unlink the firmware image once it's done with it (at the
cost of not being able to reload the firmware on a reset/reinitialize,
which might be sensible or necessary for some devices).

My personal feeling is that this would probably make more sense as a
type of sysfs node, rather than a separate filesystem, but the basic
concept seems sound.

-- 
David Gibson			| For every complex problem there is a
david@gibson.dropbear.id.au	| solution which is simple, neat and
				| wrong.
http://www.ozlabs.org/people/dgibson
