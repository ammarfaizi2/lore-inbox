Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129460AbRDBTTO>; Mon, 2 Apr 2001 15:19:14 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S131233AbRDBTTE>; Mon, 2 Apr 2001 15:19:04 -0400
Received: from hq.pm.waw.pl ([195.116.170.10]:8197 "EHLO hq.pm.waw.pl")
	by vger.kernel.org with ESMTP id <S129460AbRDBTSy>;
	Mon, 2 Apr 2001 15:18:54 -0400
To: Jeff Garzik <jgarzik@mandrakesoft.com>
Cc: Linux-Kernel <linux-kernel@vger.kernel.org>, netdev@oss.sgi.com
Subject: Re: RFC: configuring net interfaces
In-Reply-To: <Pine.LNX.3.96.1010401165413.28121X-100000@mandrakesoft.mandrakesoft.com>
Content-Type: text/plain; charset=US-ASCII
From: Krzysztof Halasa <khc@intrepid.pm.waw.pl>
Date: 02 Apr 2001 21:10:57 +0200
In-Reply-To: Jeff Garzik's message of "Sun, 1 Apr 2001 17:18:50 -0500 (CDT)"
Message-ID: <m31yrbce2m.fsf@intrepid.pm.waw.pl>
MIME-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Jeff Garzik <jgarzik@mandrakesoft.com> writes:

> First of all, you as the HDLC subsystem maintainer have a lot more
> control over what goes into include/linux/hdlc.h than
> include/linux/sockios.h.  New SIOCxxxx ioctls should not be added on a
> whim, but after examination of the issues involved.

Right. The same applies to config_xxx structures.
This is why we're talking about it here.

> Making a mistake
> and adding a bad/pointless SIOCxxxx ioctl means you are stuck with it
> for a long time.  The same applies to ioctls in hdlc.h of course -- but
> the key distinction is that you are 100% sure of the issues involved
> because changes are localized to your own domain.

I don't see the real difference. SIOCxxx is just a name+value pair,
everybody can monitor SIOCxxx changes etc.

> Further, each change to sockios.h affects a LOT of code, both in
> and outside the kernel.  Localizing your changes also localizes the
> effects of bad namespace and ioctl choices (and bugs, though in this
> case that would be rare).

We should then design it the right way :-)

> Finally, I have this (perhaps crazy) idea that we should move in the
> direction of removing ALL hardware-related ioctls from sockios.h, making
> SIOCxxxx the domain of generic network device ioctls.

What are these "generic network device ioctls"? Is add-an-IP-address
a generic enough? Not all devices use IP.
Is set-interface-speed a generic command? Most devices have something
like "speed", clock rate or something like this.

The question is: where would you like to move these ioctls to?

> Comments welcome.  IMHO domain-specific ioctls are a better direction
> than the current make-sockios.h-huge-with-new-ioctls approach.

I think we should separate two things there:
- the place (files) where SIOCxxx values are defined
- the way we use ioctl call.

The first question is less important (files are just files, both
sockios.h and protocol header files are acceptable I think). We just
have to make sure ioctls are unique across the kernel - current
sockios.h does the job, but we can, for example, use a prefix like
#define HDLC_PREFIX 0xHD7C0000 and then
#define SIOC_add-HDLC-something HDLC_PREFIX | 0x0001
(It looks more complicated and thus we should avoid it I think).


The second question looks more important, as it influences the actual
code being used.
I just believe something like:
struct ifreq {
        name;
        union {
                struct ifru_addr;
                struct ifru_ipv6_something;
                ...
                struct hdlc_physical;
                struct eth_physical;
                struct fr_protocol;
                ...
        }ifru;
}

and calling ioctl with:
        ifreq.name = "qwe0";
        ifreq.ifru.fr_protocol.t391 = 20;
        ifreq.ifru.fr_protocol.n293 = 5;
        ioctl(s, SIOC_SET_FR_PROTO_PARAMETERS, &ifreq);


is technically much better than:

struct ifreq {
        name;
        void *data;
}

you have to call it with:
        proto = malloc();
        ifreq.name = "qwe0";
        ifreq.data = proto;
        (int*)proto = SIOC_SET_FR_PROTO_PARAMETERS;
        (fr_protocol)(((int*)proto) + 1).fr_protocol.t391 = 20;
        (fr_protocol)(((int*)proto) + 1).fr_protocol.n393 = 5;
        ioctl(s, SIOC_FR_PROTO, &ifreq);

and it ends in the protocol driver:
do_ioctl(dev, *ifreq, int cmd)
{
        verify_area(..., ifreq.data, sizeof(int));
        if (*(int*)ifreq.data == SIOC_SET_FR_PROTO_PARAMETERS) {
                verify_area(ifreq.data + sizeof(int), sizeof(fr_protocol));
                etc.

Your comments?

In short and general: I think the quality (and thus simplicity) of the
actual code is more important than creating mechanisms designed to fight
future possible binary incompatibility issues, especially issues with
helper utils like ifconfig which can be easily rebuild from source.

Of course, we have to design good code and this is why we're all here.
-- 
Krzysztof Halasa
Network Administrator
