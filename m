Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S132620AbRC1Xzh>; Wed, 28 Mar 2001 18:55:37 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S132627AbRC1Xz3>; Wed, 28 Mar 2001 18:55:29 -0500
Received: from [209.81.55.6] ([209.81.55.6]:26119 "EHLO cyclades.com")
	by vger.kernel.org with ESMTP id <S132620AbRC1XzR>;
	Wed, 28 Mar 2001 18:55:17 -0500
Date: Wed, 28 Mar 2001 16:24:19 -0500 (EST)
From: Ivan Passos <lists@cyclades.com>
To: Linux Kernel List <linux-kernel@vger.kernel.org>
cc: Daniela Magri <daniela@cyclades.com>
Subject: Re: RFC: configuring net interfaces
In-Reply-To: <m3itkuq6xt.fsf@intrepid.pm.waw.pl>
Message-ID: <Pine.LNX.4.30.0103281558140.15795-100000@intra.cyclades.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


On 28 Mar 2001, Krzysztof Halasa wrote:
>
> What about a patch like this:
> That would move interface configuration out of private ioctl range,
> making it universal for all types of interfaces (now, we have different
> configuration mechanisms even between different HDLC cards).

Yes! This would be great.

> +struct hdlc_physical		/* 10 bytes */
> +{
> +	unsigned int interface;
> +	unsigned int clock_rate;
> +	unsigned short clock_type;
> +};

I guess 'interface' means media type (e.g. V.35, RS-232, X.21, etc.).
Maybe it would be more intuitive to call it 'media'. What do you think?

Also, for synchronous cards that have built-in DSU/CSU's (such as the
Cylades-PC300/TE), it's also necessary to configure T1/E1 parameters
(e.g. line code, frame mode, active channels, etc.). Should we make these
parameters also available here or keep them in the driver realm?? I think
we should have them here too, but maybe you see some problem with this
that I don't. Please advice.

> +struct hdlc_protocol		/* 4 bytes */
> +{
> +	unsigned int proto;
> +};

What are the possible protocols to be set here?? I imagine PPP, Cisco
HDLC, Raw HDLC, Frame Relay, X.25, and ... ?? Is that it??

> +struct fr_protocol		/* 12 bytes */
> +{
> +	unsigned short lmi_type;
> +	unsigned short t391;
> +	unsigned short t392;
> +	unsigned short n391;
> +	unsigned short n392;
> +	unsigned short n393;
> +};

So we would have hdlc_protocol->proto set to PROTO_FR, and then the
details about Frame Relay would be set in this separate structure. Is that
what you have in mind??

> --- linux-2.4.orig/include/linux/sockios.h	Sun Nov 12 04:02:40 2000
> +++ linux-2.4/include/linux/sockios.h	Wed Mar 28 16:35:23 2001
> @@ -76,6 +76,12 @@
>  #define SIOCSIFDIVERT	0x8945		/* Set frame diversion options */
>
>  #define SIOCETHTOOL	0x8946		/* Ethtool interface		*/
> +#define SIOCSHDLC_PHY	0x8947		/* set physical HDLC iface	*/
> +#define SIOCGHDLC_PHY	0x8948		/* get physical HDLC iface	*/
> +#define SIOCSHDLC_PROTO 0x8949		/* set HDLC protocol		*/
> +#define SIOCGHDLC_PROTO 0x894A		/* get HDLC protocol		*/
> +#define SIOCSFR_PROTO	0x894B		/* set Frame-Relay protocol	*/
> +#define SIOCGFR_PROTO	0x894C		/* get Frame-Relay protocol	*/

Maybe it's a better idea to have just two ioctl's here (GET and SET), and
have "subioctl's" inside the structure passed to the HDLC layer (and
defined by the HDLC layer). This would allow changes in the HDLC layer
without having to change sockios.h (you'd still have to change HDLC's
code and definitions, but this would be more self-contained). Again, this
may be better, or maybe not. What do you think?

Regards,
Ivan

