Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262018AbVAYR0X@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262018AbVAYR0X (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 25 Jan 2005 12:26:23 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262028AbVAYR0X
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 25 Jan 2005 12:26:23 -0500
Received: from gateway-1237.mvista.com ([12.44.186.158]:41456 "EHLO
	av.mvista.com") by vger.kernel.org with ESMTP id S262018AbVAYR0I
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 25 Jan 2005 12:26:08 -0500
From: Nick Pollitt <npollitt@mvista.com>
Organization: MontaVista
To: Marcelo Tosatti <marcelo.tosatti@cyclades.com>
Subject: Re: Configure mangles hex values
Date: Tue, 25 Jan 2005 09:25:57 -0800
User-Agent: KMail/1.7.2
Cc: kaos@sgi.com, Kernel Mailing List <linux-kernel@vger.kernel.org>
References: <200501241416.36422.npollitt@mvista.com> <200501241441.56586.npollitt@mvista.com> <20050125092021.GA19359@logos.cnet>
In-Reply-To: <20050125092021.GA19359@logos.cnet>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200501250925.57693.npollitt@mvista.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello.  I'm thinking that the 0x was stripped for purely cosmetic reasons 
rather than anything functional.  I had originally thought that the readln 
function might need the formatting, but taking a closer look at it now I 
don't see any need.

Nick

On Tuesday 25 January 2005 1:20 am, Marcelo Tosatti wrote:
> Hi Nick,
>
> Curiosity: What was the reason for stripping the leading 0x?
>
> On Mon, Jan 24, 2005 at 02:41:56PM -0800, Nick Pollitt wrote:
> > Sorry about previous message.
> >
> > The hex function in scripts/Configure strips the leading 0x from hex
> > values. The 0x needs to be there in autoconf.h, and stripping it out
> > causes the following problematic scenario:
> >
> > If I start with a hex value in my config file like this:
> > CONFIG_LOWMEM_SIZE=0x40000000
> > and then run make oldconfig, it strips out the '0x' so I end up with
> > this: CONFIG_LOWMEM_SIZE=40000000
> > Then if I run make xconfig, it doesn't think this is a valid hex value,
> > so it replaces my value with the default:
> > CONFIG_LOWMEM_SIZE=0x20000000
> >
> > The following patch removes the lines that strip out 0x, and inserts the
> > 0x if appropriate.
> >
> > --- scripts/Configure.orig 2005-01-24 13:31:55.000000000 -0800
> > +++ scripts/Configure 2005-01-24 13:34:20.000000000 -0800
> > @@ -378,15 +378,18 @@
> >  function hex () {
> >   old=$(eval echo "\${$2}")
> >   def=${old:-$3}
> > - def=${def#*[x,X]}
> >   while :; do
> >     readln "$1 ($2) [$def] " "$def" "$old"
> > -   ans=${ans#*[x,X]}
> > -   if expr "$ans" : '[0-9a-fA-F][0-9a-fA-F]*$' > /dev/null; then
> > -     define_hex "$2" "0x$ans"
> > +   if expr "$ans" : '0x[0-9a-fA-F][0-9a-fA-F]*$' > /dev/null; then
> > +     define_hex "$2" "$ans"
> >       break
> >     else
> > -     help "$2"
> > +     if expr "$ans" : '[0-9a-fA-F][0-9a-fA-F]*$' > /dev/null; then
> > +       define_hex "$2" "0x$ans"
> > +       break
> > +     else
> > +       help "$2"
> > +     fi
> >     fi
> >   done
> >  }
