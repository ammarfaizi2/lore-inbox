Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262411AbRENT1v>; Mon, 14 May 2001 15:27:51 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262409AbRENT1l>; Mon, 14 May 2001 15:27:41 -0400
Received: from panic.ohr.gatech.edu ([130.207.47.194]:2491 "HELO havoc.gtf.org")
	by vger.kernel.org with SMTP id <S262402AbRENT1i>;
	Mon, 14 May 2001 15:27:38 -0400
Message-ID: <3B0031A0.25C332D2@mandrakesoft.com>
Date: Mon, 14 May 2001 15:27:28 -0400
From: Jeff Garzik <jgarzik@mandrakesoft.com>
Organization: MandrakeSoft
X-Mailer: Mozilla 4.77 [en] (X11; U; Linux 2.4.5-pre1 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: kuznet@ms2.inr.ac.ru
Cc: andrewm@uow.edu.au, davem@redhat.COM, linux-kernel@vger.kernel.org
Subject: Re: NETDEV_CHANGE events when __LINK_STATE_NOCARRIER is modified
In-Reply-To: <200105141840.WAA16086@ms2.inr.ac.ru>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

kuznet@ms2.inr.ac.ru wrote:
> 
> Hello!
> 
> > Note that using dev->name during probe was always incorrect.  Think
> > about the error case:
> ...
> > So, using interface name in this manner was always buggy because it
> > conveys no useful information to the user.
> 
> I used to think about cases of success. 8)
> In any case the question follows: do we have some another generic
> unique human-readable identifier? Only if device is PCI?

Each bus should come up with its own way to uniquely identify devices...
such is required for SCSI and EthTool ioctls which request bus
information (as a text string) for a given device.  PCI is simply the
one example I know well... pci_dev->slot_name.

Note, however, I have come to think that "tulip0: ...", "tulip1: ...",
etc. is more user-friendly than "00:f0.1: ...".


> Actually, I am puzzled mostly with Andrew's note about "simplicity".
> Andrew's patch was evidently much __simpler__ than yours, at least,
> it required one liner for each device and surely was not a "2.5 material".

Are you talking about his 140k patch?

I think a key point of my patch is that drivers now follow the method of
other kernel drivers: perform all setup necessary, and then register the
device in a single operation.  After register_foo(dev), all members of
'dev' are assumed to be filled in and ready for use.  This is not the
case with init_etherdev() normal usage, nor using dev->init()...

Tangent - IMHO having register_netdev call dev->init is ugly and unusual
compared to other driver APIs in the kernel.  Your register function
should not call out to driver functions, it should just register a new,
already-set-up device in the subsystem and return.


> > I'm all for removing it...  I do not like removing it in a so-called
> > "stable" series, though.  alloc_etherdev() was enough to solve the race
> > and flush out buggy drivers using dev->name during probe.  Notice I did
> > not remove init_etherdev and fix it properly -- IMHO that is 2.5
> > material.
> 
> Nope, guy. Fixing fatal bug is always material of released kernel.

So you say a fatal bug remains in 2.4.5-pre1?  If so please elaborate...


> In any case the question remains: what is the sense of dev_probe_lock now?

I dunno.  Andrew?  I just looked at all users and it looks like it can
be removed.

	Jeff


-- 
Jeff Garzik      | Game called on account of naked chick
Building 1024    |
MandrakeSoft     |
