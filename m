Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S312938AbSFDOkR>; Tue, 4 Jun 2002 10:40:17 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S312973AbSFDOkQ>; Tue, 4 Jun 2002 10:40:16 -0400
Received: from vivi.uptime.at ([62.116.87.11]:15533 "EHLO vivi.uptime.at")
	by vger.kernel.org with ESMTP id <S312938AbSFDOkP>;
	Tue, 4 Jun 2002 10:40:15 -0400
Reply-To: <o.pitzeier@uptime.at>
From: "Oliver Pitzeier" <o.pitzeier@uptime.at>
To: <axp-kernel-list@redhat.com>,
        "'Ivan Kokshaysky'" <ink@jurassic.park.msu.ru>
Cc: <linux-kernel@vger.kernel.org>
Subject: RE: kernel 2.5.20 on alpha (RE: [patch] Re: kernel 2.5.18 on alpha)
Date: Tue, 4 Jun 2002 16:40:02 +0200
Organization: =?us-ascii?Q?UPtime_Systemlosungen?=
Message-ID: <000101c20bd5$b8f24560$010b10ac@sbp.uptime.at>
MIME-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: 7bit
X-Priority: 3 (Normal)
X-MSMail-Priority: Normal
X-Mailer: Microsoft Outlook, Build 10.0.3416
In-Reply-To: <000001c20bd1$0cad7580$010b10ac@sbp.uptime.at>
X-MimeOLE: Produced By Microsoft MimeOLE V6.00.2600.0000
Importance: Normal
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Can anybody tell me what's wrong within this line:

linux-2.5.20/include/linux/device.h:
[ ... ]
     73 static inline struct bus_type * get_bus(struct bus_type * bus)
     74 {
-->> 75         BUG_ON(!atomic_read(&bus->refcount));
     76         atomic_inc(&bus->refcount);
     77         return bus;
     78 }
[ ... ]

I guess BUG_ON always produces an error? But why is my kernel
jumping there and why is BUG_ON there?

This is new to me... I can't find get_bus in 2.5.18.

-Oliver

Oliver Pitzeier wrote:
> Ok. Kernel compiled, but at the startup I see this:
> [ ... ]
> Initializing RT netlink socket
> pci: passed tb register update test
> pci: passed sg loopback i/o read test
> pci: passed tbia test
> pci: passed pte write cache snoop test
> pci: failed valid tag invalid pte reload test (mcheck; workaround
> available)
> pci: passed pci machine check test
> Kernel bug at /usr/src/linux-2.5.20/include/linux/device.h:75
> swapper(1): Kernel Bug 1
> pc = [<fffffc00003dceac>]  ra = [<fffffc00003dbc14>]  ps = 0000    Not
> tainted
> v0 = 0000000000000000  t0 = 0000000000000000  t1 = 
> fffffc00005b3a48 t2 = fffffc00001e2888  t3 = fffffc00001e2878 
>  t4 = ffffffff00000000 t5 = 0000000000000001  t6 = 
> fffffc000ffe1c68  t7 = fffffc00008a8000 a0 = fffffc00001e2878 
>  a1 = 0000000000000000  a2 = 0000000000000000 a3 = 
> 0000000000000000  a4 = fffffffffffffffe  a5 = 
> 0000000000000002 t8 = fffffc00005a85b0  t9 = 0000000000008000 
>  t10= 0000000000008000 t11= 0000000000010000  pv = 
> fffffc00003dce80  at = 0000000000000000 gp = fffffc00005eece8 
>  sp = fffffc00008ab400 Trace:fffffc00003dbc14 
> fffffc00003100c8 fffffc0000310708 fffffc0000310bf8 
> fffffc000032ed58 fffffc000031008c fffffc00003100b0 fffffc00003106f0 
> Code: a44400c0  2fe00000  e4400018  a022000c  f4200004  
> 00000081 <0000004b> 00579a9d 
> Kernel panic: Attempted to kill init!
> 
> I check what is on line 75 in device.h!
> 
> Greetz,
>   Oliver
> 
> PS: Anybody want's the patches???
> 
> > -----Original Message-----
> > From: axp-kernel-list-admin@redhat.com
> > [mailto:axp-kernel-list-admin@redhat.com] On Behalf Of 
> Oliver Pitzeier
> > Sent: Tuesday, June 04, 2002 2:45 PM
> > To: 'Ivan Kokshaysky'
> > Cc: linux-kernel@vger.kernel.org; axp-kernel-list@redhat.com
> > Subject: RE: kernel 2.5.20 on alpha (RE: [patch] Re: kernel 
> > 2.5.18 on alpha)
> > 
> > 
> > Hi!
> > 
> > I already found a few more errors while trying to compile
> > 2.5.20. I send you the patch as soon as I have successfully 
> > compiled the kernel _without_ problems (hopefully today).
> > 
> > FYI. I do not compile very much options; The main options
> > I compile ('coz I need 'em and nothing more...):
> > SCSI:           QLogic ISP
> > Network:        DECchip Tulip (dc2114x) and Early DECchip
> >                 Tulip (dc2104x)
> > Character Dev.: Support for console on serial port
> > Filesystems:    EXT3 support, no ReiserFS
> > Network FS:     NFS (as module)
> > 
> > Greetz,
> >    Oliver
> > 
> > > Oliver Pitzeier wrote:
> > > [ ... ]
> > > 
> > > > If you want to know the error:
> > > 
> > > [ ... ]
> > > 
> > > > `copy_user_page' undeclared (first use in this function)
> > > > make[1]: *** [main.o] Error 1
> > > > make[1]: Leaving directory `/usr/src/linux-2.5.20/init'
> > > > make: *** [init] Error 2
> > > 
> > > I guess I found where the error comes from:
> > > 
> > > (from the 2.5.20 Changelog):
> > > > <davidm@napali.hpl.hp.com>
> > > > [PATCH] pass "page" pointer to 
> clear_user_page()/copy_user_page()
> > > > 
> > > > Hi Linus,
> > > > 
> > > > Are you willing to change the interfaces of 
> clear_user_page() and
> > > > copy_user_page() so that they can receive the relevant page
> > > pointer as
> > > > a separate argument?  I need this on ia64 to implement the
> > > lazy-cache
> > > > flushing scheme.
> > > >
> > > > I believe PPC would also benefit from this.
> > > >
> > > > --david
> > > 
> > > Now I believe, that Alpha also benefits from this. :o) The only 
> > > thing I have to do - I guess - is to change the defines for 
> > > copy_user_page() and clear_user_page. Adding the not used 
> parameter 
> > > >pg< should not make any problems.
> > > 
> > > Greetz,
> > >   Oliver


