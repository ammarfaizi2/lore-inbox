Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S269903AbTGKLJp (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 11 Jul 2003 07:09:45 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S269886AbTGKLJp
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 11 Jul 2003 07:09:45 -0400
Received: from ns.suse.de ([213.95.15.193]:16388 "EHLO Cantor.suse.de")
	by vger.kernel.org with ESMTP id S269905AbTGKLJi (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 11 Jul 2003 07:09:38 -0400
Date: Fri, 11 Jul 2003 13:24:19 +0200
From: Kurt Garloff <garloff@suse.de>
To: Linux kernel list <linux-kernel@vger.kernel.org>
Cc: suse-axp@suse.com
Subject: i2c-pyxis
Message-ID: <20030711112419.GH2633@nbkurt.garloff.de>
Mail-Followup-To: Kurt Garloff <garloff@suse.de>,
	Linux kernel list <linux-kernel@vger.kernel.org>, suse-axp@suse.com
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="yr/DzoowOgTDcSCF"
Content-Disposition: inline
User-Agent: Mutt/1.4.1i
X-Operating-System: Linux 2.4.21-0-KG i686
X-PGP-Info: on http://www.garloff.de/kurt/mykeys.pgp
X-PGP-Key: 1024D/1C98774E, 1024R/CEFC9215
Organization: SuSE(DE), TU/e(NL)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--yr/DzoowOgTDcSCF
Content-Type: multipart/mixed; boundary="3U8TY7m7wOx7RL1F"
Content-Disposition: inline


--3U8TY7m7wOx7RL1F
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi,

here's my try to get i2c supported on my PYXIS (21174) chipset.

It seems to work, but I can't see the memory which should be=20
visible on the i2c bus, so it probably does not.

I lack time to work on it, so maybe somebody wants to start from what=20
I have.

Regards,
--=20
Kurt Garloff                   <kurt@garloff.de>             [Koeln, DE]
Physics:Plasma modeling <garloff@plasimo.phys.tue.nl> [TU Eindhoven, NL]
Linux:SCSI, Security           <garloff@suse.de>    [SuSE Nuernberg, DE]

--3U8TY7m7wOx7RL1F
Content-Type: text/plain; charset=us-ascii
Content-Description: i2c-pyxis.c
Content-Disposition: attachment; filename="i2c-pyxis.c"
Content-Transfer-Encoding: quoted-printable

/*
    i2c-pyxis.c=20
    Copyright (c) 2003  Kurt Garloff <garloff@suse.de>

    Based on i2c-tsunami.c from Oleg Vdovikin <vdovikin@jscc.ru>
   =20
    Based on code written by Ralph Metzler <rjkm@thp.uni-koeln.de> and
    Simon Vogl

    This program is free software; you can redistribute it and/or modify
    it under the terms of the GNU General Public License as published by
    the Free Software Foundation; either version 2 of the License, or
    (at your option) any later version.

    This program is distributed in the hope that it will be useful,
    but WITHOUT ANY WARRANTY; without even the implied warranty of
    MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
    GNU General Public License for more details.

    You should have received a copy of the GNU General Public License
    along with this program; if not, write to the Free Software
    Foundation, Inc., 675 Mass Ave, Cambridge, MA 02139, USA.
*/

/* This interfaces to the I2C bus of the PYXIS 21174 chipsets=20
   to gain access to the on-board I2C devices.=20

   For more information refer to Compaq's Miata specification.
*/=20

#include <linux/version.h>
#include <linux/module.h>
#include <asm/io.h>
#include <asm/hwrpb.h>
#include <asm/core_cia.h>
#include <linux/i2c.h>
#include <linux/i2c-algo-bit.h>
#define LM_DATE "20020915"
#define LM_VERSION "2.6.5"
#include <linux/init.h>
//#include <linux/delay.h>

#ifdef MODULE_LICENSE
MODULE_LICENSE("GPL");
#endif

/* IIC register of PYXIS (PYXIS_IIC_CTRL):
     20.2  PYXIS IIC_CTRL REGISTER - 87.A000.02C0

     bit  name       description

      0   read_data  current state of read data pin
      1   read_clk   current state of clock pin
      2   data_en    enable data out
      3   data       data to be driven
      4   clk_en     enable clock out
      5   clk        clock to be driven
*/

#define PYX_DR	0x01	/* Data receive - RO */
#define PYX_CKR	0x02	/* Clock receive - RO */
#define PYX_DSE	0x04	/* Enable data output - WO */
#define PYX_DS	0x08	/* Data send - Must be a 1 to receive - WO */
#define PYX_CKE	0x10	/* Enable clock output - WO */
#define PYX_CKS	0x20	/* Clock send - WO */

#ifdef MODULE
static
#else
extern
#endif
int __init i2c_pyxis_init(void);
static int __init i2c_pyxis_cleanup(void);
static void i2c_pyxis_inc(struct i2c_adapter *adapter);
static void i2c_pyxis_dec(struct i2c_adapter *adapter);

#ifdef MODULE
extern int init_module(void);
extern int cleanup_module(void);
#endif	/* MODULE */

#define vuip volatile unsigned int *
extern inline void writempd(unsigned long value)
{
	*(vuip)PYXIS_IIC_CTRL =3D value;
	mb();
}

extern inline unsigned long readmpd(void)
{
	return *(vuip)PYXIS_IIC_CTRL;
}

static inline unsigned long pyxis_rcv_to_snd(unsigned long regs)
{
	return (regs & ~0x2bULL) | (regs & PYX_DR ? PYX_DS : 0)
				 | (regs & PYX_CKR? PYX_CKS: 0);
}


static void bit_pyxis_setscl(void *data, int val)
{
	/* read currently setted bits to modify them */
	unsigned long bits =3D readmpd();
	bits =3D pyxis_rcv_to_snd(bits); /* assume output =3D=3D input */
	bits |=3D PYX_CKE;

	if (val)
		bits |=3D  PYX_CKS;
	else
		bits &=3D ~PYX_CKS;

	writempd(bits);
	//bits &=3D ~PYX_CKE;
	//writempd(bits);
	//readmpd();
}

static void bit_pyxis_setsda(void *data, int val)
{
	/* read currently setted bits to modify them */
	unsigned long bits =3D readmpd();
	bits =3D pyxis_rcv_to_snd(bits); /* assume output =3D=3D input */
	bits |=3D PYX_DSE;
=20
	if (val)
		bits |=3D  PYX_DS;
	else
		bits &=3D ~PYX_DS;

	writempd(bits);
	//bits &=3D ~PYX_DSE;
	//writempd(bits);
	//readmpd();
}

static int bit_pyxis_getscl(void *data)
{
	//unsigned long bits =3D readmpd();
	//bits =3D pyxis_rcv_to_snd(bits); /* assume output =3D=3D input */
	//writempd (bits & ~PYX_CKE);
	return (0 !=3D (readmpd() & PYX_CKR));
}

static int bit_pyxis_getsda(void *data)
{
	//unsigned long bits =3D readmpd();
	//bits =3D pyxis_rcv_to_snd(bits); /* assume output =3D=3D input */
	//writempd (bits & ~PYX_DSE);
	return (0 !=3D (readmpd() & PYX_DR));
}

static struct i2c_algo_bit_data pyxis_i2c_bit_data =3D {
	NULL,
	bit_pyxis_setsda,
	bit_pyxis_setscl,
	bit_pyxis_getsda,
	bit_pyxis_getscl,
	10, 10, 50	/* delays/timeout */
};

static struct i2c_adapter pyxis_i2c_adapter =3D {
	"I2C PYXIS adapter",
	I2C_HW_B_PYXIS,
	NULL,
	&pyxis_i2c_bit_data,
	i2c_pyxis_inc,
	i2c_pyxis_dec,
	NULL,
	NULL,
};

void i2c_pyxis_inc(struct i2c_adapter *adapter)
{
	MOD_INC_USE_COUNT;
}

void i2c_pyxis_dec(struct i2c_adapter *adapter)
{
	MOD_DEC_USE_COUNT;
}

int __init i2c_pyxis_init(void)
{
	int res;
	printk("i2c-pyxis.o version %s (%s)\n", LM_VERSION, LM_DATE);

	if (hwrpb->sys_type !=3D ST_DEC_MIATA) {
		printk("i2c-pyxis.o: not PYXIS based system (%ld), module not inserted.\n=
", hwrpb->sys_type);
		return -ENXIO;
	} else {
		printk("i2c-pyxis.o: using PYXIS IIC CTRL at 0x%lx: %02lx.\n", PYXIS_IIC_=
CTRL,
			readmpd());
	}
=09
	if ((res =3D i2c_bit_add_bus(&pyxis_i2c_adapter))) {
		printk("i2c-pyxis.o: I2C adapter registration failed\n");
	} else {
		printk("i2c-pyxis.o: I2C bus initialized\n");
	}

	return res;
}

int __init i2c_pyxis_cleanup(void)
{
	int res;

	if ((res =3D i2c_bit_del_bus(&pyxis_i2c_adapter))) {
		printk("i2c-pyxis.o: i2c_bit_del_bus failed, module not removed\n");
		return res;
	}

	return 0;
}

EXPORT_NO_SYMBOLS;

#ifdef MODULE

MODULE_AUTHOR("Kurt Garloff <garloff@suse.de>");
MODULE_DESCRIPTION("PYXIS I2C/SMBus driver");

int init_module(void)
{
	return i2c_pyxis_init();
}

int cleanup_module(void)
{
	return i2c_pyxis_cleanup();
}

#endif				/* MODULE */

--3U8TY7m7wOx7RL1F--

--yr/DzoowOgTDcSCF
Content-Type: application/pgp-signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.2-rc1-SuSE (GNU/Linux)

iD8DBQE/Dp5ixmLh6hyYd04RAtPhAJ9Asai/8IoKL4HDdC7jcBgJ5KTSvQCfbiwg
7h65oktD1GX0mgxqxUe9DLE=
=ZzcE
-----END PGP SIGNATURE-----

--yr/DzoowOgTDcSCF--
