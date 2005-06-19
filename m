Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262233AbVFSOrU@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262233AbVFSOrU (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 19 Jun 2005 10:47:20 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262238AbVFSOrU
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 19 Jun 2005 10:47:20 -0400
Received: from ylpvm15-ext.prodigy.net ([207.115.57.46]:20613 "EHLO
	ylpvm15.prodigy.net") by vger.kernel.org with ESMTP id S262233AbVFSOrO
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 19 Jun 2005 10:47:14 -0400
X-ORBL: [69.107.32.110]
From: David Brownell <david-b@pacbell.net>
To: linux-hotplug-devel@lists.sourceforge.net
Subject: Re: Input sysbsystema and hotplug
Date: Sun, 19 Jun 2005 07:46:49 -0700
User-Agent: KMail/1.7.1
Cc: Hannes Reinecke <hare@suse.de>, Dmitry Torokhov <dtor_core@ameritech.net>,
       Kay Sievers <kay.sievers@vrfy.org>, Greg KH <gregkh@suse.de>,
       Vojtech Pavlik <vojtech@suse.cz>, LKML <linux-kernel@vger.kernel.org>,
       Andrew Morton <akpm@osdl.org>
References: <200506131607.51736.dtor_core@ameritech.net> <200506140242.08982.dtor_core@ameritech.net> <42AE8BA4.5020702@suse.de>
In-Reply-To: <42AE8BA4.5020702@suse.de>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200506190746.49865.david-b@pacbell.net>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tuesday 14 June 2005 12:47 am, Hannes Reinecke wrote:
> 
> Because there are _two_ events with the name 'input'.
> Both run under the same name but carry different information.
> One is required to load the module and the other is required to create
> the device node.
> 
> That's what I call an abomination.

Or at least messy, though it's been true forever that all the
event classes have included multiple events.   USB hotplug has
aided both "interface" and "device" driver match policies since
before 2.4.0, for example.  I guess "input" has seemed simpler,
partially because it started later and slimmer.


Maybe starting with the next kernel or so, distros should be
starting to avoid these issues by converting to slim versions
of the /sbin/hotplug script, handling the two steps separately.

First the driver loading ... for USB, PCI/Cardbus, and PCMCIA
this usually suffices:

    if [ "$ACTION" = "add" -a -n "$MODALIAS" -a ! -L $DEVPATH/driver ]
    then
        modprobe -q $MODALIAS
    fi

Then (otherwise?) the device node creation

    if [ -n "$DEVPATH" ]
    then
        /sbin/udevsend $1
    fi

And don't have any /etc/hotplug or /etc/hotplug.d scripts.
(There'd still need to be an /etc/init.d/coldplug to make
up for hotplug events that preceded viable userspace.)

One problem with that is that not all subsystems yet support
the new $MODALIAS (and /sys/devices/.../modalias) stuff, and
of course "input" is one subsystem that doesn't.

That support shifts the "what module to load" logic from
hotplug scripts (slow and no-longer-appropriate) over to
module-init-tools (3.2 and newer for the PCMCIA support).

- Dave

