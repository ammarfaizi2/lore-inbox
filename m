Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S130532AbRDCI2u>; Tue, 3 Apr 2001 04:28:50 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S131587AbRDCI2k>; Tue, 3 Apr 2001 04:28:40 -0400
Received: from se1.cogenit.fr ([195.68.53.173]:6151 "EHLO se1.cogenit.fr")
	by vger.kernel.org with ESMTP id <S130532AbRDCI2b>;
	Tue, 3 Apr 2001 04:28:31 -0400
Date: Tue, 3 Apr 2001 10:27:34 +0200
From: Francois Romieu <romieu@cogenit.fr>
To: Linux-Kernel <linux-kernel@vger.kernel.org>
Cc: netdev@oss.sgi.com
Subject: Re: RFC: configuring net interfaces
Message-ID: <20010403102734.A27344@se1.cogenit.fr>
In-Reply-To: <Pine.LNX.3.96.1010401165413.28121X-100000@mandrakesoft.mandrakesoft.com> <m31yrbce2m.fsf@intrepid.pm.waw.pl>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
User-Agent: Mutt/1.2.5i
In-Reply-To: <m31yrbce2m.fsf@intrepid.pm.waw.pl>; from khc@intrepid.pm.waw.pl on Mon, Apr 02, 2001 at 09:10:57PM +0200
X-Organisation: Marie's fan club
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Krzysztof Halasa <khc@intrepid.pm.waw.pl> écrit :
[...]
> > Comments welcome.  IMHO domain-specific ioctls are a better direction
> > than the current make-sockios.h-huge-with-new-ioctls approach.
> 
> I think we should separate two things there:
> - the place (files) where SIOCxxx values are defined
> - the way we use ioctl call.

(1) and (2) may be related: 
no sub-ioctl (2) + scattered files (1) = *ouch*

[...]
> you have to call it with:
>         proto = malloc();
>         ifreq.name = "qwe0";
>         ifreq.data = proto;
>         (int*)proto = SIOC_SET_FR_PROTO_PARAMETERS;
>         (fr_protocol)(((int*)proto) + 1).fr_protocol.t391 = 20;
>         (fr_protocol)(((int*)proto) + 1).fr_protocol.n393 = 5;
>         ioctl(s, SIOC_FR_PROTO, &ifreq);

Variant:
	struct sub_req sub;

	sub.fr_protocol.t391 = 20;
	sub.fr_protocol.n293 = 5;
	sub.sub_ioctl = SIOC_SET_FR_PROTO_PARAMETERS;
	ifreq.name = "qwe0";
	ifreq.data = &sub;
	ioctl(s, SIOC_FR_PROTO, &ifreq);

At least it avoids digging at a special position in a structure 
to know the expected operation and the underlying structure.

struc sub_req {
	int sub_ioctl;
	union {
		struct fr_protocol fr_prot;
		...
		struct xx_protocol xx_prot;
	}
}

struct if_req {
	int name;

	struct sub_req sub;
}

It could avoid a flat name-space. Opinion anyone ?

-- 
Ueimor
