Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261495AbVFFPCK@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261495AbVFFPCK (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 6 Jun 2005 11:02:10 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261494AbVFFPCK
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 6 Jun 2005 11:02:10 -0400
Received: from hobbit.corpit.ru ([81.13.94.6]:2397 "EHLO hobbit.corpit.ru")
	by vger.kernel.org with ESMTP id S261495AbVFFPBr (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 6 Jun 2005 11:01:47 -0400
Message-ID: <42A46551.9010707@tls.msk.ru>
Date: Mon, 06 Jun 2005 19:01:37 +0400
From: Michael Tokarev <mjt@tls.msk.ru>
User-Agent: Debian Thunderbird 1.0.2 (X11/20050331)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: matthieu castet <castet.matthieu@free.fr>
CC: linux-kernel@vger.kernel.org
Subject: Re: PNP parallel&serial ports: module reload fails (2.6.11)?
References: <20050602222400.GA8083@mut38-1-82-67-62-65.fbx.proxad.net> <429FA1F3.9000001@tls.msk.ru> <42A2D37A.5050408@free.fr>
In-Reply-To: <42A2D37A.5050408@free.fr>
X-Enigmail-Version: 0.91.0.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

matthieu castet wrote:
> Michael Tokarev wrote:
> 
>> castet.matthieu@free.fr wrote:
>>
>>> And pnpacpi have some problem to activate resource with some strange
>>> acpi implementation...
>>
>>
>> I haven't seen any probs with acpi or bios or other things on
>> those boxen yet -- pretty good ones.  It's HP ProLiant ML150
>> machine (not G2).  There are other HP machines out here which
>> also shows the same problem - eg HP ProLiant ML310 G1.
>>
> hpml310.dsl acpi dsdt is strange :

[ it's in http://www.corpit.ru/mjt/hpml310.dsdt - apache ships it
  as Content-Type: text/plain, for some reason.  I grabbed iasl
  and converted that stuff into .dsls, available at:
  http://www.corpit.ru/mjt/hpml310.dsl and
  http://www.corpit.ru/mjt/hpml150.dsl ]

Well, the problem is, I don't know *at all* how ACPI stuff works.
So if you're saying the DSDT (whatever it is) is strange, I have
only two choices: to believe you or not.. ;)

>             Name (CRES, ResourceTemplate ()
>             {
>                 IRQNoFlags () {7}
>                 DMA (Compatibility, NotBusMaster, Transfer8) {3}
>                 IO (Decode16, 0x0378, 0x0378, 0x08, 0x08)
>                 IO (Decode16, 0x0678, 0x0678, 0x00, 0x06)
>             })
> 
> [...]
> Name (_PRS, ResourceTemplate ()
>             {
>                 StartDependentFn (0x00, 0x00)
>                 {
>                     IO (Decode16, 0x0378, 0x0378, 0x00, 0x08)
>                 }
>                 StartDependentFn (0x00, 0x00)
>                 {
>                     IO (Decode16, 0x03BC, 0x03BC, 0x00, 0x03)
>                 }
>                 StartDependentFn (0x00, 0x00)
>                 {
>                     IO (Decode16, 0x0278, 0x0278, 0x00, 0x08)
>                 }
>                 EndDependentFn ()
>             })
> 
> So in the list of possible resource (_PRS) there only info about one
> ioport not about the others resource. I wonder if it is really valid ?

I dunno, really.  Maybe dmidecode output will help somehow?  It's at
http://www.corpit.ru/mjt/hpml310.dmi for HP Proliant 310 G1 machine,
and http://www.corpit.ru/mjt/hpml150.dmi for ProLiant 150 G1.

All the 310 machines we have are in several remote offices, it will be
a while before I will be able to get some info about them requiring
console access.  Ditto for alot of HPML 150 ones too, but we have one
of them here at office, and I can perform experiments on this box.

The machine (ML 150) has one parallel and one serial port.  2nd serial
port - there's a place on the mobo for the 2nd serial port connector,
but it isn't ironed.

In other message, you wrote:

> In your bios, which mode is your parport ?
>
> Could you try LPPR mode (or something like that ?)

Are you referring to ECP, EPP, Bi-Di etc modes?
(note there's serial port too, which has exactly the same prob
with (re)loading the driver).

> Have you try the patches ?

Yes, tried the patches you sent last friday - from
http://bugme.osdl.org/attachment.cgi?id=4504&action=view
and from your message in this thread with MSGID = 429FF17C.9080902@free.fr
(this last patch depends on the first).  Makes no (visible) difference
on HP ML 150 box, the same stuff is shown in dmesg, and on reload neither
parallel nor serial ports works.

I'll try some more experiments later today (hopefully) when my co-workers
(who are using this box right now so I can't freely reboot it as I wish)
will go home... ;)

BTW, looks like 8250_pnp module is also somewhat strange.  When loading
8250 alone, it detects (at least some) standard serial ports just fine,
and when loading 8250_pnp, the same port is being "re-detected" again.
But when unloading 8250_pnp, even when 8250 module is still loaded,
that only port is disabled.  Looks somewhat.. assimetric to me, without
counting issue with re-enabling of a pnp device.

> thanks

Thank you for your time Matthieu.

Speaking of all this as a whole.  In addition to some "niceness" --
the whole issue is a bit ugly, but non-fatal, and it'd be nice to
fix it just because of that ugliness -- we're a bit (at least!)
dependant on that stuff to work, because on alot of different
machines, configuring at least parallel ports manually is kinda
difficult when it's possible to get it to work automatically.
I did ask you about how "stable" pnpacpi=off is, because it'd be
a solution for us too, -- to switch all machines to pnpacpi=off,
and expect it all to work.  But since there are quite a few modern
machines too here, wich might not work with pnpacpi=off, ... ;)
And speaking of why it is a problem with *reloading* the module --
sometimes, probably due to some other bugs/problems, parallel or
(more often) serial ports got "stuck", and reloading module helps
with that.  Again, addon (PCI) serial cards (finally, with a
patch wich went into 2.6.12-tobe, NetMos Tech. PCI 9835 Multi-I/O
Controllers are now supported without setserial hack... ;)

/mjt
