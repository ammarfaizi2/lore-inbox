Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267741AbTADAzo>; Fri, 3 Jan 2003 19:55:44 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267739AbTADAzo>; Fri, 3 Jan 2003 19:55:44 -0500
Received: from ziggy.one-eyed-alien.net ([64.169.228.100]:56336 "EHLO
	ziggy.one-eyed-alien.net") by vger.kernel.org with ESMTP
	id <S262452AbTADAzf>; Fri, 3 Jan 2003 19:55:35 -0500
Date: Fri, 3 Jan 2003 17:04:04 -0800
From: Matthew Dharm <mdharm-kernel@one-eyed-alien.net>
To: Andries.Brouwer@cwi.nl
Cc: linux-kernel@vger.kernel.org, linux-scsi@vger.kernel.org
Subject: Re: inquiry in scsi_scan.c
Message-ID: <20030103170404.D4315@one-eyed-alien.net>
Mail-Followup-To: Andries.Brouwer@cwi.nl, linux-kernel@vger.kernel.org,
	linux-scsi@vger.kernel.org
References: <UTC200301040021.h040LB128544.aeb@smtp.cwi.nl>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-md5;
	protocol="application/pgp-signature"; boundary="hxkXGo8AKqTJ+9QI"
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <UTC200301040021.h040LB128544.aeb@smtp.cwi.nl>; from Andries.Brouwer@cwi.nl on Sat, Jan 04, 2003 at 01:21:11AM +0100
Organization: One Eyed Alien Networks
X-Copyright: (C) 2003 Matthew Dharm, all rights reserved.
X-Message-Flag: Get a real e-mail client.  http://www.mutt.org/
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--hxkXGo8AKqTJ+9QI
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Actually, 5 isn't minimal... it's sub-minimal.  That's an error in the
INQUIRY data.  The minimum (by spec) is 36 bytes.

There should probably be a sanity check to never ask for INQUIRY less than
36 bytes.  I thought there used to be such a thing....

Matt

On Sat, Jan 04, 2003 at 01:21:11AM +0100, Andries.Brouwer@cwi.nl wrote:
> Got a new USB device and noticed some scsi silliness while playing with i=
t.
>=20
> A bug in scsi_scan.c is
>=20
>         sdev->inquiry =3D kmalloc(sdev->inquiry_len, GFP_ATOMIC);
>         memcpy(sdev->inquiry, inq_result, sdev->inquiry_len);
>         sdev->vendor =3D (char *) (sdev->inquiry + 8);
>         sdev->model =3D (char *) (sdev->inquiry + 16);
>         sdev->rev =3D (char *) (sdev->inquiry + 32);
>=20
> since it happens that inquiry_len is short (in my case it is 5)
> and the vendor/model/rev pointers are wild.
> Catting /proc/scsi/scsi now yields random garbage.
>=20
> I made a patch but hesitated between a small patch and a larger one.
> Why do we have this malloced inquiry field? As far as I can see
> nobody uses it. And the comment in scsi_add_lun() advises us
> not to save the inquiry, precisely what we did until recently.
> So, should this change from 2.5.11 be reverted?
>=20
> Andries
>=20
>=20
> [My present scsi_scan.c differes quite a lot from a stock one.
> Already fixed the scsi_check_id_size() some time ago.
> Below some diff fragments from today.]
>=20
> +/*
> + * Do an INQUIRY with given length (minimum 5, maximum 255).
> + * Note: many devices react badly when given an unexpected length.
> + */
> +static int
> +scsi_do_inquiry(Scsi_Request *sreq, char *buffer, int len) {
> +       Scsi_Device *sdev =3D sreq->sr_device;
> +       unsigned char cmd[6];
> +       int res;
> +
> +       SCSI_LOG_SCAN_BUS(3, printk(KERN_INFO "scsi scan: INQUIRY (len %d=
) "
> +                                   "to host %d channel %d id %d lun %d\n=
",
> +                                   len, sdev->host->host_no, sdev->chann=
el,
> +                                   sdev->id, sdev->lun));
> +
> +       memset(cmd, 0, 6);
> +       cmd[0] =3D INQUIRY;
> +       cmd[4] =3D len;
> +       sreq->sr_cmd_len =3D 0;
> +       sreq->sr_data_direction =3D SCSI_DATA_READ;
> +       memset(buffer, 0, len);
> +
> +       scsi_wait_req(sreq, (void *) cmd, (void *) buffer, len,
> +                     SCSI_TIMEOUT + 4 * HZ, 3);
> +
> +       res =3D sreq->sr_result;
> +       SCSI_LOG_SCAN_BUS(3, printk(res ? KERN_INFO "scsi scan: "
> +                                   "INQUIRY returned code 0x%x\n" :
> +                                   KERN_INFO "scsi scan: INQUIRY OK\n", =
res));
> +       return res;
> +}
>=20
> +/*
> + * The inquiry length is  inq_result[4] + 5  unless overridden.
> + */
> +static int
> +valid_inquiry_lth(int bflags, unsigned char *inq_result) {
> +       int len =3D ((bflags & BLIST_INQUIRY_36) ? 36 :
> +                  (bflags & BLIST_INQUIRY_58) ? 58 :
> +                  inq_result[4] + 5);
> +       if (len > 255)
> +               len =3D 36;       /* sanity */
> +       return len;
> +}
>=20
> Text in scsi_probe_lun(), including two reactions to comments:
>=20
> static void
> scsi_probe_lun(Scsi_Request *sreq, char *inq_result, int *bflags)
> {
>         Scsi_Device *sdev =3D sreq->sr_device;    /* a bit ugly */
>         unsigned char scsi_cmd[MAX_COMMAND_SIZE];
>         int res, possible_inq_resp_len;
>=20
>         /* first issue an inquiry with conservative alloc_length */
>         res =3D scsi_do_inquiry(sreq, inq_result, 36);
>=20
>         if (res) {
>                 if ((driver_byte(res) & DRIVER_SENSE) !=3D 0 &&
>                     (sreq->sr_sense_buffer[2] & 0xf) =3D=3D UNIT_ATTENTIO=
N &&
>                     sreq->sr_sense_buffer[12] =3D=3D 0x28 &&
>                     sreq->sr_sense_buffer[13] =3D=3D 0) {
>                         /* not-ready to ready transition - good */
>                         /* dpg: bogus? INQUIRY never returns UNIT_ATTENTI=
ON */
>                         /* aeb: seen with an USB CF card reader */
>                 } else
>                         /*
>                          * assume no peripheral if any other sort of error
>                          */
>                         return;
>         }
>=20
>         /*
>          * Get any flags for this device.
>          *
>          * Some devices return only 5 bytes for an INQUIRY, but the memset
>          * in scsi_do_inquiry makes sure that scsi_get_device_flags() gets
>          * well-defined arguments.
>          */
>         *bflags =3D scsi_get_device_flags(&inq_result[8], &inq_result[16]=
);
>=20
>         possible_inq_resp_len =3D valid_inquiry_lth(*bflags, inq_result);
>=20
>         if (possible_inq_resp_len > 36) {       /* do additional INQUIRY =
*/
>                 res =3D scsi_do_inquiry(sreq, inq_result, possible_inq_re=
sp_len);
>                 if (res)
>                         return;
>=20
>                 /*
>                  * The INQUIRY can change, this means the length can chan=
ge.
>                  */
>                 possible_inq_resp_len =3D valid_inquiry_lth(*bflags, inq_=
result);
>         }
>=20
>         sdev->inquiry_len =3D possible_inq_resp_len;
>=20
>         /*
>          * Abort if the response length is less than 36?
>          * No, some USB devices just produce the minimal 5-byte INQUIRY.
>          *
>          * ...
>          */
>=20
>=20
> -
> To unsubscribe from this list: send the line "unsubscribe linux-scsi" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html

--=20
Matthew Dharm                              Home: mdharm-usb@one-eyed-alien.=
net=20
Maintainer, Linux USB Mass Storage Driver

You were using cheat codes too.  You guys suck.
					-- Greg to General Studebaker
User Friendly, 12/16/1997

--hxkXGo8AKqTJ+9QI
Content-Type: application/pgp-signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.0.6 (GNU/Linux)
Comment: For info see http://www.gnupg.org

iD8DBQE+FjMEIjReC7bSPZARAiioAKDHMOsOIy4E5B18eLHMddViGjE8FgCffHhP
tOzyLrLXD8gc4gdrMj8y488=
=aNi4
-----END PGP SIGNATURE-----

--hxkXGo8AKqTJ+9QI--
