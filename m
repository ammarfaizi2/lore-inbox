Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S132557AbRDCTml>; Tue, 3 Apr 2001 15:42:41 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S132582AbRDCTmb>; Tue, 3 Apr 2001 15:42:31 -0400
Received: from hq.pm.waw.pl ([195.116.170.10]:24338 "EHLO hq.pm.waw.pl")
	by vger.kernel.org with ESMTP id <S132557AbRDCTmU>;
	Tue, 3 Apr 2001 15:42:20 -0400
To: <linux-kernel@vger.kernel.org>
Cc: Francois Romieu <romieu@cogenit.fr>
Subject: Re: RFC: configuring net interfaces
In-Reply-To: <Pine.LNX.3.96.1010401165413.28121X-100000@mandrakesoft.mandrakesoft.com>
	<m31yrbce2m.fsf@intrepid.pm.waw.pl>
	<20010403102734.A27344@se1.cogenit.fr>
Content-Type: text/plain; charset=US-ASCII
From: Krzysztof Halasa <khc@intrepid.pm.waw.pl>
In-Reply-To: Francois Romieu's message of "Tue, 3 Apr 2001 10:27:34 +0200"
Date: 03 Apr 2001 15:07:01 +0200
Message-ID: <m3g0fq9loq.fsf@intrepid.pm.waw.pl>
MIME-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Francois Romieu <romieu@cogenit.fr> writes:

> > I think we should separate two things there:
> > - the place (files) where SIOCxxx values are defined
> > - the way we use ioctl call.
> 
> (1) and (2) may be related: 
> no sub-ioctl (2) + scattered files (1) = *ouch*

Sure.

> Variant:
> 	struct sub_req sub;
> 
> 	sub.fr_protocol.t391 = 20;
> 	sub.fr_protocol.n293 = 5;
> 	sub.sub_ioctl = SIOC_SET_FR_PROTO_PARAMETERS;
> 	ifreq.name = "qwe0";
> 	ifreq.data = &sub;
> 	ioctl(s, SIOC_FR_PROTO, &ifreq);

Yes, it's a little nicer than my second variant. But it's still more
complicated than the first one and I'm not sure if doing that is worth it

> struc sub_req {
> 	int sub_ioctl;

... as we lose 4 bytes here (currently the union of structs in ifreq
is limited to 16 bytes)

> 	union {
> 		struct fr_protocol fr_prot;
> 		...
> 		struct xx_protocol xx_prot;
> 	}
> }

What might be actually better than my first variant, is a variable-length
data:

struct ifreq {
        char name[16];
        union {
                ...
                struct {
                        int sub_command;
                        int data_length;
                        void *data;
                }
        }ifru;
}

... while "data" would be fr_protocol, eth_physical etc.

It's (of course) more complicated, but there is a gain:
- we can have different size requests (from 0 bytes to, say, 100KB)
- we split SIOC namespace into domains
- the core ioctl handler can still "verify" data area for the underlying
  driver
-- 
Krzysztof Halasa
Network Administrator
