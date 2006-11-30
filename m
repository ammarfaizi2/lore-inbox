Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1031563AbWK3WYz@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1031563AbWK3WYz (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 30 Nov 2006 17:24:55 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1031564AbWK3WYz
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 30 Nov 2006 17:24:55 -0500
Received: from smtp101.sbc.mail.mud.yahoo.com ([68.142.198.200]:9351 "HELO
	smtp101.sbc.mail.mud.yahoo.com") by vger.kernel.org with SMTP
	id S1031563AbWK3WYy (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 30 Nov 2006 17:24:54 -0500
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
  s=s1024; d=pacbell.net;
  h=Received:X-YMail-OSG:From:To:Subject:Date:User-Agent:Cc:References:In-Reply-To:MIME-Version:Content-Type:Content-Transfer-Encoding:Content-Disposition:Message-Id;
  b=X4L9JM8IoUedzikYizAncs/Yyhi2l/QU8C19UnW4bkOQOaXd8WeQ9PPoRsPtByibk7MEkE/FSChxqqjeooZ55/TwVjmLWv2ho9Img9yGuIJCFDsK2iwM7nD3GwfQokTU7aqr7LlhUVCcx5a0wVQx9b//9L7L6Li8gqJQgJbW2g4=  ;
X-YMail-OSG: lcVdzKsVM1n6z8v_DWdt9lKTFGc6rTAhJiw.m6QTJX0WImRm9IOcN5.Gvu3uWeqOod2_gAsLjgHws1PMH3pE66bjraLONFGVRq3OrrT0q6nrRHL0uJoRVw--
From: David Brownell <david-b@pacbell.net>
To: "pHilipp Zabel" <philipp.zabel@gmail.com>
Subject: Re: [patch/rfc 2.6.19-rc5] arch-neutral GPIO calls
Date: Thu, 30 Nov 2006 14:24:49 -0800
User-Agent: KMail/1.7.1
Cc: "Bill Gatliff" <bgat@billgatliff.com>, "Paul Mundt" <lethal@linux-sh.org>,
       "Linux Kernel list" <linux-kernel@vger.kernel.org>,
       "Andrew Morton" <akpm@osdl.org>, "Andrew Victor" <andrew@sanpeople.com>,
       "Haavard Skinnemoen" <hskinnemoen@atmel.com>, jamey.hicks@hp.com,
       "Kevin Hilman" <khilman@mvista.com>, "Nicolas Pitre" <nico@cam.org>,
       "Russell King" <rmk@arm.linux.org.uk>,
       "Tony Lindgren" <tony@atomide.com>
References: <200611111541.34699.david-b@pacbell.net> <200611221640.55574.david-b@pacbell.net> <74d0deb30611292257n3f532abbyedef9b543b9d48ae@mail.gmail.com>
In-Reply-To: <74d0deb30611292257n3f532abbyedef9b543b9d48ae@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Message-Id: <200611301424.50916.david-b@pacbell.net>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wednesday 29 November 2006 10:57 pm, pHilipp Zabel wrote:
> >
> > Effectively, yes.  I counted quite a few implementations in the current
> > tree which can trivially (#defines) map to that API.
> 
> I tried to do that for pxa, the patch is attached.

At a quick glance, that looked correct.  However:

> +#define gpio_get_value(gpio)   (GPLR(gpio) & GPIO_bit(gpio))
> +#define gpio_set_value(gpio,value) \
> +       ((value)? (GPSR(gpio) = GPIO_bit(gpio)):(GPCR(gpio) = GPIO_bit(gpio)))

Given how much code those macros expand to, I'd consider making those calls
become inlines which check whether "gpio" is a constant or not.

  if gpio (and value to set?) is a constant
	then use that inline.
  ilse
	procedure call to out-of-line code

That's just in terms of avoiding object code bloat ... a pair of
instructions in-lined for a constant gpio will cost as much space
as the procedure call, but that logic hiding behind the GPLR(),
GPSR(), and GPCR() macros is another thing altogether.


> So what is the state of this discussion, now that 2.6.19 is here?

My understanding is that nobody objected to the GPIO calls, and several
folk see active goodness in having them.  Notably Haavard, wanting to
have a driver that works on both AVR32 and AT91 (different SOC arch,
same controller IP), you (different ARM platforms), Bill Gatliff (for
ISTR some code shared between ARM and PPC platforms), and a few others.

The pushback has been entirely related to pin muxing, and I think it's
accepted now that muxing is platform-specific and orthogonal ... doesn't
need to hold up a common API here.


> I just submitted an input driver for GPIO buttons to linux-input that
> we use in the handhelds.org kernel for sa1100, pxa and s3c2410 archs.
> It needs some ugly
> #ifdefs currently, but with common GPIO calls they all could go away.

Onless there are better suggestions, I think what I'll do is submit
a pair of patches:

 - The documentation, with <asm-arm/gpio.h>
 - OMAP-specific implementation

Then I'll send an FYI to the ARM list (since so many ARMs could use this!)
and ask Andrew to merge that, first to MM then into 2.6.20 before RC1.

Then I'll ask you to submit an updated PXA patch, plus preferably
sa1100 and s3c2410 versions, ditto.  (If you can get other folk to
help, more power to you!)

And Haavard to submit an AVR32 patch, and corresponding AT91 patch
(ISTR he promised both), ditto.

When those patches are in the MM tree I'd see no particular reason
to hold back on the upstream merge.  The folk on the CC list are
involved in maintaining platforms that would be affected, and there
have been no nay-sayers, so I believe nobody is objecting.

Once they're upstream, it's business as usual:  drivers can start
using these calls wherever they make sense, platforms can start to
support them, and so on.

- Dave

