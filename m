Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S281455AbRKPQQT>; Fri, 16 Nov 2001 11:16:19 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S281456AbRKPQQK>; Fri, 16 Nov 2001 11:16:10 -0500
Received: from MAILGW01.bang-olufsen.dk ([193.89.221.116]:54802 "EHLO
	mailgw01.bang-olufsen.dk") by vger.kernel.org with ESMTP
	id <S281455AbRKPQP5>; Fri, 16 Nov 2001 11:15:57 -0500
To: "H . J . Lu" <hjl@lucon.org>
Cc: Andrew Morton <akpm@zip.com.au>, hogsberg@users.sourceforge.net,
        jamesg@filanet.com, linux-1394devel@lists.sourceforge.net,
        lkml <linux-kernel@vger.kernel.org>
Subject: Re: sbp2.c on SMP
In-Reply-To: <3BEF27D1.7793AE8E@zip.com.au> <3BEF27D1.7793AE8E@zip.com.au>
	<20011113191721.A9276@lucon.org> <3BF21B79.5F188A0D@zip.com.au>
	<20011115193234.A22081@lucon.org>
From: Kristian Hogsberg <hogsberg@users.sourceforge.net>
Date: 16 Nov 2001 17:15:47 +0100
Message-ID: <m3snbeofnw.fsf@dk20037170.bang-olufsen.dk>
User-Agent: Gnus/5.09 (Gnus v5.9.0) Emacs/21.1
MIME-Version: 1.0
X-MIMETrack: Itemize by SMTP Server on BeoSmtp/Bang & Olufsen/DK(Release 5.0.6a |January
 17, 2001) at 16-11-2001 17:15:50,
	Serialize by Router on dzln11/Bang & Olufsen/DK(Release 5.0.6 |December 14, 2000) at
 16-11-2001 17:15:49,
	Serialize complete at 16-11-2001 17:15:49
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

"H . J . Lu" <hjl@lucon.org> writes:

> On Tue, Nov 13, 2001 at 11:21:29PM -0800, Andrew Morton wrote:
> > "H . J . Lu" wrote:
> > > 
> > > Here is another patch. It fixes:
> > > 
> > > # modprobe ohci1394
> > > # rmmod ohci1394
> > > 
> > > H.J.
> > > --- linux-2.4.9-12.2mod/drivers/ieee1394/nodemgr.c.rmmod        Tue Nov 13 19:15:44 2001
> > > +++ linux-2.4.9-12.2mod/drivers/ieee1394/nodemgr.c      Tue Nov 13 19:11:38 2001
> > > @@ -570,7 +570,8 @@ static void nodemgr_remove_host(struct h
> > >         write_lock_irqsave(&node_lock, flags);
> > >         list_for_each(lh, &node_list) {
> > >                 ne = list_entry(lh, struct node_entry, list);
> > > -
> > > +               if (!ne)
> > > +                       break;
> > >                 /* Only checking this host */
> > >                 if (ne->host != host)
> > >                         continue;
> > > @@ -582,6 +583,8 @@ static void nodemgr_remove_host(struct h
> > >         spin_lock_irqsave (&host_info_lock, flags);
> > >         list_for_each(lh, &host_info_list) {
> > >                 struct host_info *myhi = list_entry(lh, struct host_info, list);
> > > +               if (!myhi)
> > > +                       break;
> > >                 if (myhi->host == host) {
> > >                         hi = myhi;
> > >                         break;
> > 
> > I don't think so.  Look at the definition of list_entry.
> > It's just a pointer offset.  So if `ne' is zero, then `lh'
> > must have been -16 or so.
> > 
> 
> I don't thik so. Zero `ne' means the `list' field which `lh' points
> to is NULL.

This is true, but only because the struct list_head is the first
element in struct node_entry.  If it wasn't, lh would have been -16 or
so, as Andrew says.

In any case, it's the wrong fix, because the error is elsewhere:
neither the host_info list or the node list should contain NULL
entries.  This is just curing the symptoms.  HJ, could you provide
some details on the crash?  Do you have the sbp2 module loaded when
you insmod/rmmod ohci1394, and if so, does it crash without sbp2
loaded?


> > There seems to be a problem with module reference counts:

[...]

This is a subtle issue... if you just want to prevent the ohci1394
driver from being unloaded while the sbp2 driver is loaded, it's a
matter of adding a hpsb_inc_host_usage call to sbp2_add_host and a
hpsb_dec_host_usage call to sbp2_remove_host.  However this goes
against the design of the 1394 subsystem, which is a bit like the scsi
subsystem: there's a middle layer which holds the hole thing together
and implements the core 1394 transaction logic and bus management,
then there's a low level layer where host controller drivers (ohci1394
and pcilynx) register and an upper layer where protocol level drivers
register (eg. sbp2, video1394, raw1394 and in the future ip1394).  The
design allows you to load and unload low level drivers independent of
each other and independent of whatever highlevel drivers currently
loaded, likewise for high level drivers.

Of course, you dont want to unload a low level driver when it's in
use, and for this you have the hpsb_inc_host_usage and
hpsb_dec_host_usage calls, which prevents unloading of the module
implementing the driver for the host given as argument.  This is used
by raw1394 when someone opens /dev/raw1394 and selects a host
controller to talk to.  So even if raw1394 is loaded, you can still
unload ohci1394 if nobody is using the card through raw1394.

So, if sbp2 unconditionally locks down any host controller it sees,
this flexibility is lost.  A better solution is to call
hpsb_inc_host_usage when sbp2 successfully logs into an sbp2 drive and
hpsb_dec_host_usage when a drive is disconnected.  It's still not
optimal, since now you cant unload a card driver if one of it's cards
has an sbp2 device attached that the sbp2 driver is logged into.  By
default, the sbp2 driver logs in to all devices on all buses if
possible and only logs out when you unload it, so to unload the
ohci1394 driver you must unplug all sbp2 devices from all ohci cards
or unload the sbp2 modules first.

Ideally, we want to hpsb_inc_host_usage for a host only when somebody
opens or mounts a device present on that hosts bus, but unfortunately
that event isn't passed down by the scsi subsystem, except that it
increases module usage count for sbp2.

Any ideas?  Is there another way to acomplish this or should we just
go with the simple solution, where we increase host usage when the
sbp2 driver detects and logs into a sbp2 device?

Kristian

