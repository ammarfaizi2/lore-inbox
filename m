Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750827AbWE1R6n@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750827AbWE1R6n (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 28 May 2006 13:58:43 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750835AbWE1R6n
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 28 May 2006 13:58:43 -0400
Received: from 2-1-3-15a.ens.sth.bostream.se ([82.182.31.214]:47796 "EHLO
	zoo.weinigel.se") by vger.kernel.org with ESMTP id S1750827AbWE1R6m convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 28 May 2006 13:58:42 -0400
To: Mauro Carvalho Chehab <mchehab@infradead.org>
Cc: Nathan Laredo <laredo@gnu.org>, Jiri Slaby <jirislaby@gmail.com>,
       Christer Weinigel <christer@weinigel.se>, linux-kernel@vger.kernel.org,
       video4linux-list@redhat.com,
       v4l-dvb maintainer list <v4l-dvb-maintainer@linuxtv.org>
Subject: Re: Stradis driver conflicts with all other SAA7146 drivers
References: <m3wtc6ib0v.fsf@zoo.weinigel.se> <44799D24.7050301@gmail.com>
	<1148825088.1170.45.camel@praia>
	<d6e463920605280901n41840baeuc30283a51e35204e@mail.gmail.com>
	<1148837483.1170.65.camel@praia>
From: Christer Weinigel <christer@weinigel.se>
Organization: Weinigel Ingenjorsbyra AB
Date: 28 May 2006 19:58:41 +0200
In-Reply-To: <1148837483.1170.65.camel@praia>
Message-ID: <m3k686hvzi.fsf@zoo.weinigel.se>
User-Agent: Gnus/5.09 (Gnus v5.9.0) Emacs/21.4
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: 8BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Mauro Carvalho Chehab <mchehab@infradead.org> writes:

> Em Dom, 2006-05-28 às 09:01 -0700, Nathan Laredo escreveu:
> > I agree that the real fix is to unify the stradis driver so that it
> > uses the existing saa7146 driver (and extending the saa7146 driver if
> > it doesn't have all the support necessary yet).   Keep in mind that at
> > the time the driver was written, there was no other saa7146-based card
> > on the market (mid 1999).
> > Until the pci change there was never a single complaint.
> It seems that both drivers were developed independently, and both went
> to kernel in the past. Only some time after Jiri we realized that PCI
> IDs were conflicting.
> > 
> > Unfortunately it was ill timed to happen when I was busiest at work,
> > and even now I'm on my way to New Zealand for a month where I'll be
> > out of touc as well, so the "right" fix is not likely to happen soon.
> So, we need a quick fix. Maybe the better for now is to do a quick
> workaround to 2.6.17, backported also to 2.6.16. We can work for a
> definitive solution to 2.6.18 or 2.6.19.
> > 
> > I didn't even know that other saa7146 cards had been developed until
> > the bug reports about the conflicts started pouring in.  I don't run
> > bleeding edge kernels anymore due to work having a rhel3 requirement
> > because the lame cad tool vendors are so far behind the curve.
> There are some new boards from a very well known vendor in Europe
> (Hauppauge) that uses also saa7146.
> 
> Currently, there are some drivers probing for saa7146 PCI IDs:
> probing all PCI IDs:
> 	dpc7146.c, hexium_orion.c, mxb.c, stradis.c
> probing specific IDs:
> 	hexium_gemini.c

dpc7146, hexium_orion and mxb don't match all PCI IDs, they only match
boards with zero as a board ID.  So they won't conflict with
non-broken boards that have valid subvendor IDs.  But they will
conflict with each other.

How may of these boards are broken and have zeroes in the
subvendor/subdevice fields?  Apparently some of the dpc7146f,
hexium_orion, mxb, and stradis boards are broken.  How many of the
boards supported by the generic saa7146 driver are broken the same
way?

Can't the stradis driver do the same thing as the other drivers and
explicitly match the broken zero subvendor id and the non-broken
subvendor IDs?

static struct pci_device_id pci_tbl[] = {
        {
         .vendor = PCI_VENDOR_ID_PHILIPS,
         .device = PCI_DEVICE_ID_PHILIPS_SAA7146,
         .subvendor = 0x0000,
         .subdevice = 0x0000,
         },
        {
         .vendor = PCI_VENDOR_ID_PHILIPS,
         .device = PCI_DEVICE_ID_PHILIPS_SAA7146,
         .subvendor = STRADIS_SUBVENDOR_ID,
         .subdevice = STRADIS_SUBDEVICE_ID,
         },
        { }
}

That would fix the problem for me and make it SEP. :-)

Can somebody with a SDM2xx stradis board mail me the output from
"lspci -vn" and I'll cobble together a patch that does this?

This still needs solving properly, but at least it makes it less of
a problem for people with non-broken hardware.

  /Christer

-- 
"Just how much can I get away with and still go to heaven?"

Freelance consultant specializing in device driver programming for Linux 
Christer Weinigel <christer@weinigel.se>  http://www.weinigel.se
