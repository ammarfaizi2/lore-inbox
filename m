Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262784AbVAFJED@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262784AbVAFJED (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 6 Jan 2005 04:04:03 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262786AbVAFJED
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 6 Jan 2005 04:04:03 -0500
Received: from mail.gmx.de ([213.165.64.20]:6857 "HELO mail.gmx.net")
	by vger.kernel.org with SMTP id S262784AbVAFJDt (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 6 Jan 2005 04:03:49 -0500
X-Authenticated: #4512188
Message-ID: <41DCFEF0.5050105@gmx.de>
Date: Thu, 06 Jan 2005 10:03:44 +0100
From: "Prakash K. Cheemplavam" <prakashkc@gmx.de>
User-Agent: Mozilla Thunderbird 1.0 (X11/20050103)
X-Accept-Language: de-DE, de, en-us, en
MIME-Version: 1.0
To: Martin Drab <drab@kepler.fjfi.cvut.cz>
CC: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: APIC/LAPIC hanging problems on nForce2 system.
References: <Pine.LNX.4.60.0501051604200.24191@kepler.fjfi.cvut.cz> <41DC1AD7.7000705@gmx.de> <Pine.LNX.4.60.0501051757300.25946@kepler.fjfi.cvut.cz> <41DC2113.8080604@gmx.de> <Pine.LNX.4.60.0501051821430.25946@kepler.fjfi.cvut.cz> <41DC2353.7010206@gmx.de> <Pine.LNX.4.60.0501060046450.26952@kepler.fjfi.cvut.cz>
In-Reply-To: <Pine.LNX.4.60.0501060046450.26952@kepler.fjfi.cvut.cz>
X-Enigmail-Version: 0.89.6.0
X-Enigmail-Supports: pgp-inline, pgp-mime
Content-Type: multipart/signed; micalg=pgp-sha1;
 protocol="application/pgp-signature";
 boundary="------------enig2A2E6EA59047272C31763E8E"
X-Y-GMX-Trusted: 0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is an OpenPGP/MIME signed message (RFC 2440 and 3156)
--------------enig2A2E6EA59047272C31763E8E
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit

Martin Drab schrieb:
> On Wed, 5 Jan 2005, Prakash K. Cheemplavam wrote:
>
> ...
> DEBUG: pci_fixup_nforce2() called.
> DEBUG:   nForce2 revision byte = 0xC1.
> DEBUG:   fixed value = 0x9F01FF01.
> DEBUG:   current value = 0x8F0FFF01.  <---------------
> ...
>
> So that means, that the device doesn't have the "C1 Halt Disconnect"
> enabled at that point, and, though, no fixup is done. However, if you take
> a closer look at the result of "lspci -xxx" (attached as "lspci-xxx.log"),
>
> 00:00.0 Host bridge: nVidia Corporation nForce2 AGP (different version?) (rev c1)
> ...
> 60: 08 00 01 20 20 00 88 80 10 00 00 00 01 ff 0f 9f <-------
> ...
>
> you'll notice, that all of a sudden that bit 28 of PCI.0x6c *is set!! That
> means, that sometimes later, after the pci_fixup_nforce2() is called,
> something, smewhere, somehow has to set the bit to 1. But this part in the
> arch/i386/pci/fixup.c prevents it.

You are not by chance using athcool or something to enable disconnect?

>
>         /*
>          * Apply fixup only if C1 Halt Disconnect is enabled
>          * (bit28) because it is not supported on some boards.
>          */
> 	    vvvvvvvvvvvvvvvvv
>         if ((val & (1 << 28)) && val != fixed_val) {
>                 printk(KERN_WARNING "PCI: nForce2 C1 Halt Disconnect fixup\n");
>                 pci_write_config_dword(dev, 0x6c, fixed_val);
>         }
>
> So my question is: Is the condition necessary? If there really are boards,
> that don't support this, then is would probably have to be a more
> sophisticated test, or the fixup would have to be called again later, when
> the flag is set. BTW.: Any clue on what could possibly set the flag?

Well, I also think it is quite stupid to only apply the fix if
disconnect is enabled at boot time and don't apply it if it is not. The
kernel dev responsible for it is rather pedantic: Fix only when needed,
ie don't apply anything in a foreseeing way (prevent what could break),
if change something in userspace, do it correctly. (not exact words of
course, but the conclusion of it.) Ie if you enable disconnect outside
of bios and kernel, you should also set the fix by hand...

Easy workaround: Enable disconnect in bios, if possible, then the kernel
will fix it for you...

I admit there is logic behind the dev's point of view, nevertheless it
is not a very near-to-life-and-make-it-simpler-for-the-user logic. There
is often a difference in point of view of kernel dev and average user...

Prakash

--------------enig2A2E6EA59047272C31763E8E
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.0 (GNU/Linux)

iD8DBQFB3P7zxU2n/+9+t5gRAhyCAKDEIka+8Z2akGEti1c0Fv2f4mBaGgCfctwk
Tc9xdRggPNADH3kr6SNdpUo=
=hdT4
-----END PGP SIGNATURE-----

--------------enig2A2E6EA59047272C31763E8E--
