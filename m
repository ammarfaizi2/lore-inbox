Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S263062AbTCTW67>; Thu, 20 Mar 2003 17:58:59 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S263151AbTCTW66>; Thu, 20 Mar 2003 17:58:58 -0500
Received: from mail.casabyte.com ([209.63.254.226]:57617 "EHLO
	mail.1casabyte.com") by vger.kernel.org with ESMTP
	id <S263062AbTCTW6c>; Thu, 20 Mar 2003 17:58:32 -0500
From: "Robert White" <rwhite@casabyte.com>
To: "Cigol C" <linuxppp@indiainfo.com>, <cfowler@outpostsentinel.com>
Cc: <EdV@macrolink.com>, <linux-serial@vger.kernel.org>,
       "'linux-kernel'" <linux-kernel@vger.kernel.org>
Subject: RE: RS485 communication
Date: Thu, 20 Mar 2003 15:09:02 -0800
Message-ID: <PEEPIDHAKMCGHDBJLHKGGEBJCEAA.rwhite@casabyte.com>
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
X-Priority: 3 (Normal)
X-MSMail-Priority: Normal
X-Mailer: Microsoft Outlook IMO, Build 9.0.2416 (9.0.2911.0)
In-Reply-To: <20030317054152.7512.qmail@indiainfo.com>
X-MimeOLE: Produced By Microsoft MimeOLE V5.50.4920.2300
Importance: Normal
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I don't know if I answered this already...

No.

There is no "SOCK_PACKET" defined for the RS485 (serial) driver.  The users
comment about using SOCK_PACKET was made with respect to an Ethernet chip
(and by extension driver).  You DON't HAVE a socket call interface until you
have gotten the IP up and running via PPP or some such.

To do IP over RS485 you need to use PPP (or something similar).

Any PPP daemon (instance) talks to exactly one other PPP daemon.  No
exceptions.  "Point to Point Protocol".

RS485 with only two participants is nearly indistinguishable from RS232 (as
far as an application space entity like pppd is concerned.)

If there are more than two participants on the RS485 bus then you need to
write something to run between the RS485 driver and the multiple pppd(s) to
make sure that the PPP daemons run in pairs and only see data intended for
one another.  (To the best of my knowledge) Nothing currently exists in the
commons that does this for you.  [I am sure someone has wrote this for some
purpose sometime, but I know of no source for it.]

No shortcuts.
No magic settings hiding somewhere in PPPd.

You have exactly two-point-two choices.

Choice 1:  Write a master/slaves arbiter and multiplexor.

Choice 1.1: find someone who already wrote one that exposes a nice bunch of
pty(s) to the application space.

Choice 2: Go buy hardware (c.f. an Ethernet card [or chip if you are
designing custom hardware])

Choice 2.1: put only two machines on any RS485 bus (e.g. buy one RS485 port
per peer).

That's it.  Sorry... 8-)

Rob.

-----Original Message-----
From: Cigol C [mailto:linuxppp@indiainfo.com]
Sent: Sunday, March 16, 2003 9:42 PM
To: cfowler@outpostsentinel.com; rwhite@casabyte.com
Cc: EdV@macrolink.com; 'Linux PPP'; linux-serial@vger.kernel.org;
'linux-kernel'
Subject: RE: RS485 communication



Thannks for the info. Can i acheive IP over RS485 if i use SOCK_PACKET. I
need some more info on this if u could provide that. If this option is set
in the socket call will i have an option the choose the hardware interface.

----- Original Message -----
From: Chris Fowler
Date: 15 Mar 2003 10:42:53 -0500
To: Robert White
Subject: RE: RS485 communication

> I think using SOCK_PACKET an an ethernet chip may be the best choice.
> You can use IP or you can use RWP (Rober White Protocol).
>
>
> On Sat, 2003-03-15 at 03:07, Robert White wrote:
> > Yes, that, but that is only part of it.
> >
> > The RS485 is a proper bus, so this custom program (or programs) will
have to
> > act as full bus arbiters and a kind of router. Each PPP daemon must
receive
> > ONLY the data that its peer daemon transmits. That means that each slave
> > must know to ignore the data not destined for it. Further, the master,
> > which would have multiple PPP instances running on it, will need to
decide
> > which of those instances get which of the receiving bytes.
> >
> > So just like an Ethernet transceiver puts a protocol frame around the
data
> > to get it to the destination, the transport program will have to put
> > envelopes around the data. THEN the master transport program will tell
each
> > slave when and how many of its envelopes it may send. The only way that
can
> > work (because there is no "ring" you can't pass a "token") is for the
master
> > to ask each slave in turn: "Got anything to send?"
> >
> > This usually devolves to a sequence of "#1, say your piece", "#2 say
your
> > piece" etc. That is a very bad performance model.
> >
> > So every frame of data will need to be arbitrarily wide, meaning a
length
> > code, and will need an in-multiplexor address.
> >
> > So the master, for instance, will say "slave 1, go". The slave 1 will
send
> > a packet (not necessarily a PPP packet, as the multiplexor will have
> > overhead data etc.)
> >
> > The master will look at the address and decide which local pty the data
is
> > for and send it there. (Think a simple byte pump here)
> >
> > When that pty has response data, and when the master says "slave 0 (e.g.
me)
> > go" it will frame a message that slave #1 will receive and put through
to
> > its local pty. Slave 1 also has the job of ignoring data for slaves 2
> > through N and the Master (Slave 0).
> >
> > In short, he has to write a distributed application that pumps data into
and
> > out of a broadcast medium, and makes sure that each participant gets
only
> > the data intended for itself. (This is what both the Ethernet hardware
> > layer, and the IP protocols do.)
> >
> > In communications you almost always put protocols inside of protocols to
> > some significant depth.
> >
> > For instance, when you play Unreal Tournament 2003:
> > Unreal Tournament's data is carried by UDP,
> > The UDP is carried by IP,
> > The IP is carried by the Ethernet hardware access layer (raw Ethernet),
> > Those packets may go to your cable modem which either wraps the Ethernet
> > hardware packets or decodes them and reencodes the IP into whatever it
> > does.
> >
> > >From there, if your cable modem is doing PPPoE there are even more
layers.
> >
> > This guy will only have to write a multiplexing layer, but it won't be
fun.
> >
> > Then again, the Ethernet people have done all that, which is why it is
> > cheaper and easier to just get the Ethernet hardware and use it.
> >
> > Rob.
> >
> > -----Original Message-----
> > From: Chris Fowler [mailto:cfowler@outpostsentinel.com]
> > Sent: Thursday, March 13, 2003 3:31 PM
> > To: Robert White
> > Cc: Ed Vance; 'Linux PPP'; linux-serial@vger.kernel.org; 'linux-kernel'
> > Subject: RE: RS485 communication
> >
> >
> > Are you saying that for him to to use PPPD that he will have to write a
> > program that will run on a master and tell all the slave nodes when they
> > can transmit their data. In this case it would be ppp data. Hopfully
> > in block sizes that are at least the size of the MTU ppp is running.
> >
> > Chris
> >
>
>
> -
> To unsubscribe from this list: send the line "unsubscribe linux-serial" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at http://vger.kernel.org/majordomo-info.html
--
______________________________________________
http://www.indiainfo.com
Now with POP3/SMTP access for only US$14.95/yr

Powered by Outblaze

