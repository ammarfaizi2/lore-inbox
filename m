Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751284AbVK1Vmv@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751284AbVK1Vmv (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 28 Nov 2005 16:42:51 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751311AbVK1Vmv
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 28 Nov 2005 16:42:51 -0500
Received: from web50110.mail.yahoo.com ([206.190.38.38]:41837 "HELO
	web50110.mail.yahoo.com") by vger.kernel.org with SMTP
	id S1751284AbVK1Vmu (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 28 Nov 2005 16:42:50 -0500
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
  s=s1024; d=yahoo.com;
  h=Message-ID:Received:Date:From:Subject:To:Cc:In-Reply-To:MIME-Version:Content-Type:Content-Transfer-Encoding;
  b=J+sD2hfXruyxB+6pPxZI0Q2WrWPPXIuHC5iLnFJJmWQlaQRvLYhHFQoAdxj+vmVXo8zxZDjIniSGPvQUI8ySD3q0hUxDcrGPzlwjOWX8TUr6qKeoDqJtb42yDKJIPh70SwTGexzt/epLSej0Wi+aR7zdhfsnhljXb0K24ql8C/o=  ;
Message-ID: <20051128214249.34008.qmail@web50110.mail.yahoo.com>
Date: Mon, 28 Nov 2005 13:42:49 -0800 (PST)
From: Doug Thompson <norsk5@yahoo.com>
Subject: Re: [RFC] EDAC a new sysfs 'subsystem' under /sys/devices
To: Greg KH <greg@kroah.com>
Cc: linux-kernel@vger.kernel.org, Alan Cox <alan@lxorguk.ukuu.org.uk>
In-Reply-To: <20051128205612.GG17740@kroah.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

--- Greg KH <greg@kroah.com> wrote:

> On Tue, Nov 22, 2005 at 03:57:44PM -0800, Doug
> Thompson wrote:

> > I have mounted edac to: /sys/devices/edac because
> the
> > /sys/device/system subsystem is not exported
> 
> Yes, that would be trivial to do :)

I have changed to using /sys/devices/system for the
edac_subsystem.  I had to remove the 'static' for the
declaration of system_subsystem in drivers/base/sys.c,
and linked to it instead of the 'devices_subsys'
variable.

> 
> > I now have:
> > 
> > /sys/devices/system/edac/mc/mc0/csrow0 kobjects
working
>
> Please put it under /sys/devices/system.

With the mod:

/sys/devices/system/edac

subsystem is working and I can add:

mc/mc0/csrows0/...

to it.

> Also, see the patch on lkml from Pat Mochel which
> might make your deep
> sysfs trees much easier to create and use.
> 
> > Another RFC is:
> > 
> > Should EDAC really have a "new" subsystem in the
> > kernel?  (I believe it fits bets, but am looking
> for
> > alternatives)
> 
> Why not just a system device?

One reason is the naming convention used:

creating an 'edac' class followed by adding a edac
device creates the following name:

/sys/devices/system/edac/edac0/...
/sys/devices/system/edac/edac1/...

whereas I desire:

/system/devices/system/edac/mc/mc0/...

I would just register a class 'edac' and then all else
would be custom (or utilize the patch you have
mentioned)

Another reason is that EDAC is not necessarily just
for memory ECC checking only.  The EDAC module
currently has 1) ECC checking and 2) PCI parity
checking (not driver notification) on bus devices. For
the future, other EDAC types of devices can be added.

If I add an EDAC kobject 'subsystem' in the base, then
future EDAC type devices can be added and be decoupled
from the memory ECC EDAC module.

(This poses the question: if the current EDAC 
module's name is too generic just for the memory
reporter maybe it should should be edac_mem instead or
some such)

If the EDAC module "creates" the EDAC device under
/sys/devices/system, then that module will "own" that
name and future devices will need to be added to that
module. There currently is no "core" edac sysfs
subystem to provide the abstraction.

I guess the issue becomes:  Is the EDAC module JUST
for memory ECC and PCI parity reporting, in utilizing
sysfs? 

Should other future EDAC devices then also be added to
the EDAC module in order to utilize the sysfs
/sys/devices/system/edac device?

Or should they be modular in their own right and plug
into a sysfs EDAC subsystem?

I might be wrong, or need redirection, but I see this
as a clean model by using an abstraction of EDAC type
devices in sysfs.


> 
> > It requires a new drivers/base/edac.c (and .h file
> +
> > plumbing).

> No, you should not be adding stuff to drivers/base.

I understand. I did look at other options, but I saw
more coupling in the others. If there were a
de-coupled EDAC sysfs 'core or base class' (ie EDAC
subsystem), then the memory ECC reporter could plug in
cleanly. The PCI Parity report could plug in. Other
future, EDAC reporters could plug in as well.


> 
> > The only problem I ran into was that I needed
> further
> > subdirectories under 'mc/mc0', and I had to resort
> to
> > using kobject_register() since the subsystem
> didn't
> > have methods for such creation. Yet that code now
> > works nicely.
> 
> See the patch from Pat for how to do this easier. 
> But even without that
> patch, creating new kobjects is one way to do it.

Ok, I will take a look at the patch to see its options
are. I look forward to feedback.

> 
> thanks,
> 
> greg k-h
> 

my thanks

doug t


"If you think Education is expensive, just try Ignorance"

"Don't tell people HOW to do things, tell them WHAT you
want and they will surprise you with their ingenuity."
                   Gen George Patton

