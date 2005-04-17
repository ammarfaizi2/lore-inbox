Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261377AbVDQRx5@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261377AbVDQRx5 (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 17 Apr 2005 13:53:57 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261380AbVDQRx5
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 17 Apr 2005 13:53:57 -0400
Received: from mail.murom.net ([213.177.124.17]:15009 "EHLO ns1.murom.ru")
	by vger.kernel.org with ESMTP id S261377AbVDQRxv (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 17 Apr 2005 13:53:51 -0400
Date: Sun, 17 Apr 2005 21:53:11 +0400
From: Sergey Vlasov <vsu@altlinux.ru>
To: TJ <systemloc@earthlink.net>
Cc: linux-kernel@vger.kernel.org
Subject: Re: via82xx driver: reporting dxs_support experience
Message-Id: <20050417215311.18063ce8.vsu@altlinux.ru>
In-Reply-To: <200504171253.24389.systemloc@earthlink.net>
References: <200504171253.24389.systemloc@earthlink.net>
X-Mailer: Sylpheed version 1.0.0 (GTK+ 1.2.10; i586-alt-linux-gnu)
Mime-Version: 1.0
Content-Type: multipart/signed; protocol="application/pgp-signature";
 micalg="pgp-sha1";
 boundary="Signature=_Sun__17_Apr_2005_21_53_11_+0400_pMfU2WaWuacz//GF"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

--Signature=_Sun__17_Apr_2005_21_53_11_+0400_pMfU2WaWuacz//GF
Content-Type: text/plain; charset=US-ASCII
Content-Disposition: inline
Content-Transfer-Encoding: 7bit

On Sun, 17 Apr 2005 12:53:24 -0400 TJ wrote:

> I was using the 2.6.7 kernel without APIC or ACPI support, and the via82xx
> driver worked perfectly, compiled as a module, without any options. I built a
> new 2.6.7 kernel on the same hardware with APIC and ACPI support in the
> kernel, as the board supports it, and the driver did not work correctly.

2.6.7 is pretty old; there were many bugfixes in both ACPI and sound
drivers since that time.

> When sound was played, a short, 1 second long bit of the sound to be
> played was looped. Possibly this is the clicking noise described by
> some people?

Does not look like it.  The most common cause of looping sound are
interrupt problems, and unfortunately ACPI (especially when coupled
with APIC support) often triggers them (sometimes because of bugs in
the kernel ACPI support, sometimes because a buggy BIOS supplies
broken data).

If interrupts are not working, usually this happens:

- The driver sets up a circular buffer which contains the first
  portion of sound samples to be played, and starts the playback
  hardware.

- The sound card reads the samples from the buffer; when it reaches
  some point in the buffer, it sends the interrupt signal, notifying
  the driver about it.

- Normally, when the driver handles the interrupt, it will place more
  sound data in the circular buffer (or, in the mmap mode, it will
  notify the application, which will write to the buffer directly).
  However, if interrupts are not working, the driver will never get
  such notification, and the same portion of sound samples will stay
  in the buffer forever.  The sound card does not know that the buffer
  was not updated and will play that piece of sound forever.

Another symptom of not working interrupts is that aplay just hangs
forever (aplay -vv should draw a histogram of played data).

> The driver works fine with this new kernel after adding the option
> "dxs_support=1".

This is very strange - the dxs_support option should not cause such
changes.  Usually the problem caused by a wrong dxs_support value is
that sound is basically there, but distorted.

Also, seems that dxs_support=1 should not work at all (at least in
theory).  dxs_support=4 seems to be more correct; latest code in ALSA
CVS supports dxs_support=5, which uses more capabilities of the
hardware (apparently the VIA VT8233/5/7 chips are able to perform
sample rate conversion from arbitrary rates to 48000 Hz with 4
independent channels).

> I hope this interaction with ACPI and APIC sheds some light on some
> of the troubles with this driver.

Most likely you have some trouble with ACPI (either with the buggy
implementation in 2.6.7, or with the buggy BIOS, or maybe both).

> I can provide more information if
> anyone wants it. Please CC me, I'm not on the list.
> 
> TJ
> 
> Motherboard: MSI K7T266 Pro2
> 
> 00:11.5 Class 0401: 1106:3059 (rev 10)

Hmm, seems to be some old chip revision:

#define VIA_REV_PRE_8233	0x10	/* not in market */

>         Subsystem: 4005:4710

Not in the known devices list of snd-via82xx (this list contains
working values of the dxs_support option for known boards).  But you
should report it to ALSA developers (e.g., in their bug tracking
system, https://bugtrack.alsa-project.org/alsa-bug/ ) - your message
to LKML will likely be lost.

>         Flags: medium devsel, IRQ 28
>         I/O ports at bc00 [size=256]
>         Capabilities: [c0] Power Management version 2

--Signature=_Sun__17_Apr_2005_21_53_11_+0400_pMfU2WaWuacz//GF
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.5 (GNU/Linux)

iD8DBQFCYqKMW82GfkQfsqIRAhX+AJ9vKoRsBf1hTeXWWQ5dJ2tGKQV3igCdGP+I
23pVXxouZue9B6QxyK77i6I=
=uzJa
-----END PGP SIGNATURE-----

--Signature=_Sun__17_Apr_2005_21_53_11_+0400_pMfU2WaWuacz//GF--
