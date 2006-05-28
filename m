Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750814AbWE1Rbf@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750814AbWE1Rbf (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 28 May 2006 13:31:35 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750816AbWE1Rbf
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 28 May 2006 13:31:35 -0400
Received: from pentafluge.infradead.org ([213.146.154.40]:42441 "EHLO
	pentafluge.infradead.org") by vger.kernel.org with ESMTP
	id S1750814AbWE1Rbe (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 28 May 2006 13:31:34 -0400
Subject: Re: Stradis driver conflicts with all other SAA7146 drivers
From: Mauro Carvalho Chehab <mchehab@infradead.org>
To: Nathan Laredo <laredo@gnu.org>
Cc: Jiri Slaby <jirislaby@gmail.com>, Christer Weinigel <christer@weinigel.se>,
       linux-kernel@vger.kernel.org, video4linux-list@redhat.com,
       v4l-dvb maintainer list <v4l-dvb-maintainer@linuxtv.org>
In-Reply-To: <d6e463920605280901n41840baeuc30283a51e35204e@mail.gmail.com>
References: <m3wtc6ib0v.fsf@zoo.weinigel.se> <44799D24.7050301@gmail.com>
	 <1148825088.1170.45.camel@praia>
	 <d6e463920605280901n41840baeuc30283a51e35204e@mail.gmail.com>
Content-Type: text/plain; charset=ISO-8859-1
Date: Sun, 28 May 2006 14:31:22 -0300
Message-Id: <1148837483.1170.65.camel@praia>
Mime-Version: 1.0
X-Mailer: Evolution 2.6.1-2mdk 
Content-Transfer-Encoding: 8bit
X-SRS-Rewrite: SMTP reverse-path rewritten from <mchehab@infradead.org> by pentafluge.infradead.org
	See http://www.infradead.org/rpr.html
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Em Dom, 2006-05-28 às 09:01 -0700, Nathan Laredo escreveu:
> I agree that the real fix is to unify the stradis driver so that it
> uses the existing saa7146 driver (and extending the saa7146 driver if
> it doesn't have all the support necessary yet).   Keep in mind that at
> the time the driver was written, there was no other saa7146-based card
> on the market (mid 1999).
> Until the pci change there was never a single complaint.
It seems that both drivers were developed independently, and both went
to kernel in the past. Only some time after Jiri we realized that PCI
IDs were conflicting.
> 
> Unfortunately it was ill timed to happen when I was busiest at work,
> and even now I'm on my way to New Zealand for a month where I'll be
> out of touc as well, so the "right" fix is not likely to happen soon.
So, we need a quick fix. Maybe the better for now is to do a quick
workaround to 2.6.17, backported also to 2.6.16. We can work for a
definitive solution to 2.6.18 or 2.6.19.
> 
> I didn't even know that other saa7146 cards had been developed until
> the bug reports about the conflicts started pouring in.  I don't run
> bleeding edge kernels anymore due to work having a rhel3 requirement
> because the lame cad tool vendors are so far behind the curve.
There are some new boards from a very well known vendor in Europe
(Hauppauge) that uses also saa7146.

Currently, there are some drivers probing for saa7146 PCI IDs:
probing all PCI IDs:
	dpc7146.c, hexium_orion.c, mxb.c, stradis.c
probing specific IDs:
	hexium_gemini.c

I can imagine some possible solutions for this right now:

1) to include an insmod flag to allow PCI generic detection for each
driver. So, the default behavior would be the one at the previous
kernels;

2) We may create one saa7146_driver that probes the required PCI IDs and
then load the corresponding driver of the above listed. For those boards
whose don't have its own ID, an insmod parameter (or an autodetection
procedure) may specify if it is a dpc7146, hexium_orion, mxb or stradis
board.

(2) would be an interim solution until we integrate all stuff into just
one driver.

> - Nathan Laredo
> laredo@gnu.org
> 
> On 5/28/06, Mauro Carvalho Chehab <mchehab@infradead.org> wrote:
> > Em Dom, 2006-05-28 às 14:52 +0159, Jiri Slaby escreveu:
> > > -----BEGIN PGP SIGNED MESSAGE-----
> > > Hash: SHA1
> > >
> >
> > > > For anyone submitting a new SAA7146 driver to the kernel in the
> > > > future, please be aware that your card isn't the only one that uses
> > > > that chip, so always add a subvendor/subdevice to your drivers.
> > The better is to use the existent driver instead of creating newer
> > ones.
> > > The only difference is in order of searching for devices. Stradis now gets
> > > control before your "real" driver. Kick stradis from your config or blacklist
> > > it.
> > This sucks. Distros should compile all drivers to support as much
> > hardware as possible. For now, it is better to implement Christer
> > suggestions.
> > > Or, why you ever load module, you don't want to use?
> > There's no safe way to make a driver to get control after the others, if
> > both are modules, so the option is to use the saa7146 driver instead of
> > stradis.
> > > There is no change in searching devices, it didn't check for subvendors before
> > > not even now. If Nathan knows, there are some subvendor/subdevices ids, which we
> > > should compare to, then yes, we can change the behaviour, otherwise, I am
> > > afraid, we can't. It's vendors' problem, that they don't use this pci registers
> > > (and it's evil) -- i think, that stradis cards have that two zeroed.
> > This is, in fact, a trouble on several video capture boards. A real
> > merge work should be done by migrating stradis to use the generic
> > support for SAA7146. Then, having just one board, those conflicts won't
> > happen.
> > >
> > > regards,
> > > - --
> > > Jiri Slaby         www.fi.muni.cz/~xslaby
> >
> > Cheers,
> > Mauro.
> >
> >
Cheers, 
Mauro.

