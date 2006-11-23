Return-Path: <linux-kernel-owner+willy=40w.ods.org-S933875AbWKWUSr@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S933875AbWKWUSr (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 23 Nov 2006 15:18:47 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S933886AbWKWUSq
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 23 Nov 2006 15:18:46 -0500
Received: from master.altlinux.org ([62.118.250.235]:32009 "EHLO
	master.altlinux.org") by vger.kernel.org with ESMTP id S933875AbWKWUSp
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 23 Nov 2006 15:18:45 -0500
Date: Thu, 23 Nov 2006 23:18:25 +0300
From: Sergey Vlasov <vsu@altlinux.ru>
To: Mathieu Fluhr <mfluhr@nero.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: 'False' IO error when copying from cdrom drive
Message-Id: <20061123231825.342a3237.vsu@altlinux.ru>
In-Reply-To: <1164311305.3013.25.camel@de-c-l-110.nero-de.internal>
References: <1164311305.3013.25.camel@de-c-l-110.nero-de.internal>
X-Mailer: Sylpheed version 2.2.9 (GTK+ 2.10.2; x86_64-alt-linux-gnu)
Mime-Version: 1.0
Content-Type: multipart/signed; protocol="application/pgp-signature";
 micalg="PGP-SHA1";
 boundary="Signature=_Thu__23_Nov_2006_23_18_25_+0300_O847AOK=zleGnTTq"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

--Signature=_Thu__23_Nov_2006_23_18_25_+0300_O847AOK=zleGnTTq
Content-Type: text/plain; charset=US-ASCII
Content-Disposition: inline
Content-Transfer-Encoding: 7bit

On Thu, 23 Nov 2006 20:48:25 +0100 Mathieu Fluhr wrote:

> I explain: First take this really simple program:
> ----8<------------------------------------------------------------------
> #include <sys/types.h>
> #include <sys/stat.h>
> #include <fcntl.h>
>
>
> int main(int argc, char **argv)
> {
>   if(argc < 2)
>     return 0;
>
>   int iFD = open(argv[1], O_RDONLY | O_NONBLOCK);
>   if(iFD == -1)
>     perror("open");
>
>   while(1)
>     sleep(1);
>
>   return 0;
> }
> ----8<-----------------------------------------------------------------
[..]
> Ok. Now take a full DVD (I tested DVD+R, +RW and -R), with more than
> 4 300 000 000 bytes (very important :), and perform the following:
>
> 0. Open the tray of your recorder
> 1. Launch this small program above, passing the recorder device file as
>    argument and let it run in background.

At this time the following code in drivers/ide/ide-cd.c:cdrom_read_toc()
is executed:

	/* Try to get the total cdrom capacity and sector size. */
	stat = cdrom_read_capacity(drive, &toc->capacity, &sectors_per_frame,
				   sense);
	if (stat)
		toc->capacity = 0x1fffff;

	set_capacity(info->disk, toc->capacity * sectors_per_frame);

Obviously, with the tray open cdrom_read_capacity() won't succeed,
therefore toc->capacity will be set to 0x1fffff.

> 2. then put the disc in the device and mount it
> 3. try to copy to whole content on the hard drive
>
> -> You will get an error like the following:
>   > kernel: attempt to access beyond end of device
>   > kernel: hdb: rw=0, want=8388612, limit=8388604

0x1fffff * 2048/512 == 8388604

Your background program is keeping the device open, which prevents
revalidation of capacity and other media information on subsequent
device opens.

When HAL polls CD-ROM devices to detect newly inserted media, it does
not keep the device open forever - instead, it opens and closes the
device every time.  Your program should either do the same thing, or
just depend on HAL events.

--Signature=_Thu__23_Nov_2006_23_18_25_+0300_O847AOK=zleGnTTq
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.5 (GNU/Linux)

iD8DBQFFZgIUW82GfkQfsqIRAoAGAJ4r/K07ahHEYsrlIjvFWAXts0ouhwCgkfGY
CeY99Wa3hdLQfhjc5Uvd9EQ=
=z7Ps
-----END PGP SIGNATURE-----

--Signature=_Thu__23_Nov_2006_23_18_25_+0300_O847AOK=zleGnTTq--
