Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263617AbTEJA0e (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 9 May 2003 20:26:34 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263619AbTEJA0e
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 9 May 2003 20:26:34 -0400
Received: from fmr03.intel.com ([143.183.121.5]:45804 "EHLO
	hermes.sc.intel.com") by vger.kernel.org with ESMTP id S263617AbTEJA0b
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 9 May 2003 20:26:31 -0400
Message-ID: <A46BBDB345A7D5118EC90002A5072C780CCB00AD@orsmsx116.jf.intel.com>
From: "Perez-Gonzalez, Inaky" <inaky.perez-gonzalez@intel.com>
To: "'Chris Friesen'" <cfriesen@nortelnetworks.com>,
       "'William Lee Irwin III'" <wli@holomorphy.com>
Cc: "'Linux Kernel Mailing List'" <linux-kernel@vger.kernel.org>
Subject: RE: how to measure scheduler latency on powerpc?  realfeel doesn'
	t work due to /dev/rtc issues
Date: Fri, 9 May 2003 17:39:03 -0700 
MIME-Version: 1.0
X-Mailer: Internet Mail Service (5.5.2653.19)
Content-Type: multipart/mixed;
	boundary="----_=_NextPart_000_01C3168C.8E671A60"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This message is in MIME format. Since your mail reader does not understand
this format, some or all of this message may not be legible.

------_=_NextPart_000_01C3168C.8E671A60
Content-Type: text/plain;
	charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable


> From: Chris Friesen [mailto:cfriesen@nortelnetworks.com]
>=20
> William Lee Irwin III wrote:
>=20
> > I don't understand why you're obsessed with interrupts. Just run =
your
> > load and spray the scheduler latency stats out /proc/
>=20
> I'm obsessed with interrupts because it gives me a higher sampling =
rate.
>=20
> I could set up and itimer for a recurring 10ms timeout and see how =
much
extra I
> waited, but then I can only get 100 samples/sec.
>=20
> With /dev/rtc (on intel) you can get 20x more samples in the same =
amount
of time.

Okay, crazy idea here ...

You are talking about a bladed system, right? So probably you
have two network interfaces in there [it should work only with
one too].

What if you rip off the driver for the network interface and=20
create a new breed. Set an special link with a null Ethernet
cable and have one machine sending really short Ethernet frames
to the sampling machine.

Maybe if you can manage to get the Ethernet chip to interrupt
every time a new frame arrives, you can use that as a sampling
measure. I'd say the key would be to have the sending machine
be really precise about the sending ... I guess it can be worked
out.

I don't know how fast an interrupt rate you could get, OTOH=20
rough numbers ... let's say 100 MBit/s is 10 MByte/s, use
a really small frame [let's say a few bytes only, 32], add
the MACS {I don't remember the frame format, assuming 12 bytes
for source and destination MACs, plus 8 in overhead [again, I
made it up], 52 bytes ... let's round up to 64 bytes per frame.

So

10 MB/s / 64 B/frame =3D 163840 frames/s

I don't know how really possible is this or my calculations
are screwed up, but it might be worth a try ...

I did a quick test; from one of my computers, m1, I did:

m1:~ $ while true; do cat BIGFILE; done | ssh m2 cat > /dev/null

while on m2, I did:

m2:~ $ grep eth0 /proc/interrupts; sleep 2m; grep eth0 /proc/interrupts
 18:      77457      68483   IO-APIC-level  eth0
 18:     397390     412559   IO-APIC-level  eth0
m2:~ $=20

total    319933  +  344076   =3D 664009
in 120 seconds ... 664009 / 120 =3D 5533 Hz ~ 2500 Hz per CPU.

not bad, wouldn't this work?

[this is with a 1500 MTU through a hub ... or a switch, I
don't really know ...]

I=F1aky P=E9rez-Gonz=E1lez -- Not speaking for Intel -- all opinions =
are my own
(and my fault)


------_=_NextPart_000_01C3168C.8E671A60
Content-Type: text/plain;
	name="t.txt"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: attachment;
	filename="t.txt"

 18:      77457      68483   IO-APIC-level  eth0=0A=
 18:     397390     412559   IO-APIC-level  eth0=0A=
=0A=
total    319933  +  344076   =3D 664009=0A=
in 120 seconds ... 664009 / 120 =3D 5533 Hz ~ 2500 Hz per CPU.=0A=
=0A=

------_=_NextPart_000_01C3168C.8E671A60--
