Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261510AbVCDFHR@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261510AbVCDFHR (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 4 Mar 2005 00:07:17 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261502AbVCDFFu
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 4 Mar 2005 00:05:50 -0500
Received: from 206.175.9.210.velocitynet.com.au ([210.9.175.206]:2970 "EHLO
	cunningham.myip.net.au") by vger.kernel.org with ESMTP
	id S262045AbVCDEr6 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 3 Mar 2005 23:47:58 -0500
Subject: Re: [linux-pm] [PATCH] Custom power states for non-ACPI systems
From: Nigel Cunningham <ncunningham@cyclades.com>
Reply-To: ncunningham@cyclades.com
To: David Brownell <david-b@pacbell.net>
Cc: Linux-pm mailing list <linux-pm@lists.osdl.org>, linux-pm@osdl.org,
       Todd Poynor <tpoynor@mvista.com>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       Pavel Machek <pavel@ucw.cz>
In-Reply-To: <200503031817.06993.david-b@pacbell.net>
References: <20050302020306.GA5724@slurryseal.ddns.mvista.com>
	 <20050302085619.GA1364@elf.ucw.cz> <200503031817.06993.david-b@pacbell.net>
Content-Type: text/plain
Message-Id: <1109911788.3772.228.camel@desktop.cunningham.myip.net.au>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.6-1mdk 
Date: Fri, 04 Mar 2005 15:49:48 +1100
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi.

On Fri, 2005-03-04 at 13:17, David Brownell wrote:
> On Wednesday 02 March 2005 12:56 am, Pavel Machek wrote:
> > 
> > If OMAP has "big sleep" and "deep sleep", why not simply map them to
> > "standby" and "suspend-to-ram"?
> 
> Or even "cpu idle".  Entering power saving modes shouldn't be such
> a Big Deal.  Some of the variable scheduling timeout work has been
> done specifically with the goal of letting the system use those low
> power modes more generally, without needing user(space) input to
> suggest that now would be a good time to conserve more milliWatts.
> 
> Of course, on systems that don't swap (or swsusp) there may be
> dozens of different low-power "standby" states.  I'm not sure it
> helps to try labeling them all through /sys/power/files.

It seems to make a lot of sense to me for us to make a split between
capability/implementation and policy, and move the policy stuff to
userspace. Here's the proposal I'm slowly fleshing out:

Two way communication between a userspace policy manager and kernel
drivers is implemented via DBus.

In this scheme, 'kernel drivers' doesn't just refer to the drivers for
hardware. It refers to anything remotely power management related,
including code to implement suspend-to-RAM, to disk or the like, ACPI
drivers or code to implement system power states.

The policy manager can enumerate devices and inter-relationships,
capabilities, settings and status information, set and query policies
and implementation results. The drivers can notify events. This
communication doesn't use complicated structures or type definitions.
Rather, all the nous regarding interpretation of the messages that are
sent is in the policy manager and the drivers. One driver might say it's
capable of states called "D0, D1 and D3", another (system) states called
"Deep Sleep" and "Big Sleep". Nothing but the driver itself and
userspace manager need to how to interpret & use these states.

Inter-relationships between drivers are _not_ included in this
information. The policy manager sets policy, the drivers deal with the
specifics of implementing it.

The userspace manager can in turn [en|dis]able capabilites and send a
list of run-time states that the driver can move between according to
its own logic (eg lack of active children) without notifying the
userspace manager. This would fit in with your power modes above, even
to the level of "cpu idle".

The DBus support would also provide a means by which the userspace
manager could be notified of events it might be interested in. Again, a
generic format could be used, with the format depending upon the driver.
These events might include 'no keypresses in the specified period' or
'I'm a new driver just loaded'.
 
Support for system states works in a similar manner. Capabilities and
configuration parameters for system states (suspend to ram, deep sleep
etc) could be registered in a similar manner to the device drivers
above, but the choice regarding entering them comes from the userspace
manager. The code implementing the state interacts with drivers using
the existing driver model which, by definition (it only deals with
system states), overrides the runtime policy settings previously
applied.

DBus events could also come from userspace, such as window manager
requesting hibernation or a userspace UPS driver notifying AC loss.

Drivers could also interact with each other to communicate status
changes (eg USB drivers notify parent HUB of their removal). This is, of
course, the more complicated bit. Since this is the implementation (and
not policy), however, userspace doesn't need to be involved. This
separation should simplify things. My USB hub driver knows what its
children are via the driver model. It doesn't need to receive a message
from userspace to tell it to sleep because it has nothing to do.

With an implementation along these lines, I think we'll have a good
basis for getting runtime power management and system states into a
usable state.

Regards,

Nigel
-- 
Nigel Cunningham
Software Engineer, Canberra, Australia
http://www.cyclades.com
Bus: +61 (2) 6291 9554; Hme: +61 (2) 6292 8028;  Mob: +61 (417) 100 574

Maintainer of Suspend2 Kernel Patches http://softwaresuspend.berlios.de


