Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S286343AbSBCBqC>; Sat, 2 Feb 2002 20:46:02 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S284305AbSBCBpx>; Sat, 2 Feb 2002 20:45:53 -0500
Received: from hq.pm.waw.pl ([195.116.170.10]:59100 "EHLO hq.pm.waw.pl")
	by vger.kernel.org with ESMTP id <S285352AbSBCBph>;
	Sat, 2 Feb 2002 20:45:37 -0500
To: <linux-kernel@vger.kernel.org>
Cc: Jeff Garzik <garzik@havoc.gtf.org>
Subject: Re: SIOCDEVICE ?
In-Reply-To: <200201311304.FAA00344@adam.yggdrasil.com>
	<20020131181241.A3524@fafner.intra.cogenit.fr>
	<m3665iqhqn.fsf@defiant.pm.waw.pl>
	<20020202154424.A5845@fafner.intra.cogenit.fr>
	<20020202154348.A26147@havoc.gtf.org>
From: Krzysztof Halasa <khc@pm.waw.pl>
Date: 03 Feb 2002 02:44:14 +0100
In-Reply-To: <20020202154348.A26147@havoc.gtf.org>
Message-ID: <m3it9fmj9t.fsf@defiant.pm.waw.pl>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Jeff Garzik <garzik@havoc.gtf.org> writes:

> The correction would perhaps define a real command as needed...

What about details? You want one ioctl = one command again? I'm confused.

> > SIOCDEVICE, yes. That's my attempt to create an ioctl interface for
> > controlling devices. It's defined by the hdlc patch, discussed about
> > a year (?) ago here. Yes, I think I should post a note here.
> 
> This too seems way too generic for including in the kernel.
> 
> 
> What data is passed through the following structure?
> 
> Untyped data has the same problems as I listed for SIOCDEVPRIVATE:
> 
> > struct if_settings
> > {
> >       unsigned int type;      /* Type of physical device or protocol */
> >       unsigned int data_length; /* device/protocol data length */
> >       void * data;            /* pointer to data, ignored if length = 0 */
> > };

It depends on the value of "type", enumerated in include/linux/if.h.
For example, IF_IFACE_V35 uses sync_serial_settings struct, while
IF_PROTO_CISCO uses cisco_proto. The structures are defined in
linux/include/hdlc.h (those related to HDLC protos and sync serial
interfaces of course).

The "data_length" is here for protection - as we have to use structs
of different sizes with different protos etc.


You may think of this as of a union of structs. I don't like real union
as its size would be the size of largest struct (large crypto key
comes to mind).

> It adds undiscussed networking changed which I very much doubt DaveM
> would approve of, and I do not approve of:  SIOCDEVICE is far too
> generic for inclusion, and it adds a structure for passing untyped
> data which is very definitely non-portable.

I don't see any non-portable things here (what is it exactly?).

I don't say this is ideal, the requirement of middle ifreq structure
(required by netdev ioctls) isn't the most elegant.

About discussions: last discussion I remember ended with:

	struct 
	{
		u16 media_group;
		union
		{
			struct hdlc_physical ...
			struct hdlc_bitstream
			struct hdlc_protocol
			struct fr_protocol
			struct eth_physical
			struct atm_physical
			struct dsl_physical
			struct dsl_bitstream
			struct tr_physical
			struct wireless_physical
			struct wireless_80211
			struct wireless_auth
		} config;
	}
(see a thread with message dated 7 Dec 2000 by Alan Cox
(Message-ID <E1441je-0002T3-00@the-village.bc.nu>). I think there was
no serious objections, and the SIOCDEVICE is just that, with the union
replaced by individual structs (to save memory and permit future extensions
without breaking binary compatibility), and the whole thing moved to ifreq
to avoid 3rd level of indirection.


>From my point of view, the following ifreq would be better (sort of):

struct ifreq 
{
        char ifrn_name[IFNAMSIZ];    /* if name, e.g. "en0" */
        unsigned int type;           /* or media_group */
        variable_size_struct defined_by_type;/* not a pointer but real struct*/
};

i.e. something like sockaddr structures. I don't even hope anyone would
accept it.
-- 
Krzysztof Halasa
Network Administrator
