Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S135903AbRDTNFv>; Fri, 20 Apr 2001 09:05:51 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S135904AbRDTNFl>; Fri, 20 Apr 2001 09:05:41 -0400
Received: from ivanova.coker.com.au ([203.36.46.209]:4113 "HELO
	ivanova.coker.com.au") by vger.kernel.org with SMTP
	id <S135903AbRDTNFa>; Fri, 20 Apr 2001 09:05:30 -0400
Content-Type: Multipart/Mixed;
  charset="iso-8859-1";
  boundary="------------Boundary-00=_IMD30BI5QHPQFF8ZK2NJ"
From: Russell Coker <russell@coker.com.au>
Reply-To: Russell Coker <russell@coker.com.au>
To: tytso@mit.edu
Subject: Rocketport device driver for 2.4.3
Date: Fri, 20 Apr 2001 15:03:54 +0200
X-Mailer: KMail [version 1.2]
Cc: linux-kernel@vger.kernel.org
MIME-Version: 1.0
Message-Id: <01042015035403.16958@lyta>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--------------Boundary-00=_IMD30BI5QHPQFF8ZK2NJ
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable

I am working on a VA Linux server machine model 2240 which came with a=20
RocketPort serial device.

The first issue is that it doesn't have support for devfs.  I have attach=
ed a=20
patch to fix this that I believe to be good (I've done the same thing for=
=20
Stallion and Lucent WinModem drivers - it's not overly challenging).

The next problem is that accessing a port number that is greater than the=
=20
maximum that the RockerPort PCI card supports (apparently 32 ports for my=
=20
card) gives a kernel oops.  I have attached the output of ksymoops to thi=
s=20
message.
The command that triggered this Oops was:
setserial /dev/ttr/99


diff -ru old-linux/drivers/char/rocket.c patched-linux/drivers/char/rocke=
t.c
--- old-linux/drivers/char/rocket.c=09Sat Mar 31 09:50:44 2001
+++ patched-linux/drivers/char/rocket.c=09Fri Apr 20 12:38:51 2001
@@ -94,7 +94,15 @@
 #undef ROCKET_DEBUG_WAIT_UNTIL_SENT
 #undef ROCKET_DEBUG_RECEIVE
 #undef ROCKET_DEBUG_HANGUP
-=09
+
+#ifdef CONFIG_DEVFS_FS
+#define TTR_DEVICE "ttr/%d"
+#define DEVICE_NAME TTR_DEVICE
+#else
+#define TTR_DEVICE "ttyR%d"
+#define DEVICE_NAME "ttyR"
+#endif
+
=20
 /*   CAUTION!!!!!  The TIME_STAT Function relies on the Pentium 64 bit
  *    register.  For various reasons related to 1.2.13, the test for thi=
s
@@ -449,7 +457,7 @@
 =09if (IntMask & DELTA_CD) {=09/* CD change  */
 #if (defined(ROCKET_DEBUG_OPEN) || defined(ROCKET_DEBUG_INTR) || \
      defined(ROCKET_DEBUG_HANGUP))
-=09=09printk("ttyR%d CD now %s...", info->line,
+=09=09printk(TTR_DEVICE " CD now %s...", info->line,
 =09=09       (ChanStatus & CD_ACT) ? "on" : "off");
 #endif
 =09=09if (!(ChanStatus & CD_ACT) &&
@@ -836,7 +844,7 @@
 =09retval =3D 0;
 =09add_wait_queue(&info->open_wait, &wait);
 #ifdef ROCKET_DEBUG_OPEN
-=09printk("block_til_ready before block: ttyR%d, count =3D %d\n",
+=09printk("block_til_ready before block: " TTR_DEVICE ", count =3D %d\n"=
,
 =09       info->line, info->count);
 #endif
 =09save_flags(flags); cli();
@@ -871,7 +879,7 @@
 =09=09=09break;
 =09=09}
 #ifdef ROCKET_DEBUG_OPEN
-=09=09printk("block_til_ready blocking: ttyR%d, count =3D %d, flags=3D0x=
%0x\n",
+=09=09printk("block_til_ready blocking: " TTR_DEVICE ", count =3D %d,=20
flags=3D0x%0x\n",
 =09=09       info->line, info->count, info->flags);
 #endif
 =09=09schedule();
@@ -884,7 +892,7 @@
 =09restore_flags(flags);
 =09info->blocked_open--;
 #ifdef ROCKET_DEBUG_OPEN
-=09printk("block_til_ready after blocking: ttyR%d, count =3D %d\n",
+=09printk("block_til_ready after blocking: " TTR_DEVICE ", count =3D %d\=
n",
 =09       info->line, info->count);
 #endif
 =09if (retval)
@@ -964,7 +972,7 @@
 #endif
 =09}
 #ifdef ROCKET_DEBUG_OPEN
-=09printk("rp_open ttyR%d, count=3D%d\n", info->line, info->count);
+=09printk("rp_open " TTR_DEVICE ", count=3D%d\n", info->line, info->coun=
t);
 #endif
 =09/*
 =09 * Info->count is now 1; so it's safe to sleep now.
@@ -1050,7 +1058,7 @@
 =09=09return;
=20
 #ifdef ROCKET_DEBUG_OPEN
-=09printk("rp_close ttyR%d, count =3D %d\n", info->line, info->count);
+=09printk("rp_close " TTR_DEVICE ", count =3D %d\n", info->line, info->c=
ount);
 #endif
 =09
 =09save_flags(flags); cli();
@@ -1072,7 +1080,7 @@
 =09=09info->count =3D 1;
 =09}
 =09if (--info->count < 0) {
-=09=09printk("rp_close: bad serial port count for ttyR%d: %d\n",
+=09=09printk("rp_close: bad serial port count for " TTR_DEVICE ": %d\n",
 =09=09       info->line, info->count);
 =09=09info->count =3D 0;
 =09}
@@ -1166,7 +1174,7 @@
 =09restore_flags(flags);
 =09
 #ifdef ROCKET_DEBUG_OPEN
-=09printk("rp_close ttyR%d complete shutdown\n", info->line);
+=09printk("rp_close " TTR_DEVICE " complete shutdown\n", info->line);
 #endif
 =09
 }
@@ -1646,7 +1654,7 @@
 =09=09return;
=20
 #if (defined(ROCKET_DEBUG_OPEN) || defined(ROCKET_DEBUG_HANGUP))
-=09printk("rp_hangup of ttyR%d...", info->line);
+=09printk("rp_hangup of " TTR_DEVICE "...", info->line);
 #endif
 =09/*
 =09 * If the port is in the process of being closed, just force
@@ -2193,7 +2201,7 @@
 =09 */
 =09memset(&rocket_driver, 0, sizeof(struct tty_driver));
 =09rocket_driver.magic =3D TTY_DRIVER_MAGIC;
-=09rocket_driver.name =3D "ttyR";
+=09rocket_driver.name =3D DEVICE_NAME;
 =09rocket_driver.major =3D TTY_ROCKET_MAJOR;
 =09rocket_driver.minor_start =3D 0;
 =09rocket_driver.num =3D MAX_RP_PORTS;
@@ -2235,7 +2243,11 @@
 =09 * the minor number and the subtype code.
 =09 */
 =09callout_driver =3D rocket_driver;
+#ifdef CONFIG_DEVFS_FS
+=09callout_driver.name =3D "cur/%d";
+#else
 =09callout_driver.name =3D "cur";
+#endif
 =09callout_driver.major =3D CUA_ROCKET_MAJOR;
 =09callout_driver.minor_start =3D 0;
 =09callout_driver.subtype =3D SERIAL_TYPE_CALLOUT;


--=20
http://www.coker.com.au/bonnie++/     Bonnie++ hard drive benchmark
http://www.coker.com.au/postal/       Postal SMTP/POP benchmark
http://www.coker.com.au/projects.html Projects I am working on
http://www.coker.com.au/~russell/     My home page

--------------Boundary-00=_IMD30BI5QHPQFF8ZK2NJ
Content-Type: text/plain;
  charset="iso-8859-1";
  name="rocket.oops"
Content-Transfer-Encoding: base64
Content-Description: rocket.oops
Content-Disposition: attachment; filename="rocket.oops"

VW5hYmxlIHRvIGhhbmRsZSBrZXJuZWwgTlVMTCBwb2ludGVyIGRlcmVmZXJlbmNlIGF0IHZpcnR1
YWwgYWRkcmVzcyAwMDAwMDAwYgpjODg2OGUxYwoqcGRlID0gMDAwMDAwMDAKT29wczogMDAwMApD
UFU6ICAgIDAKRUlQOiAgICAwMDEwOls8Yzg4NjhlMWM+XQpVc2luZyBkZWZhdWx0cyBmcm9tIGtz
eW1vb3BzIC10IGVsZjMyLWkzODYgLWEgaTM4NgpFRkxBR1M6IDAwMDEwMjg2CmVheDogMDAwMDAx
OGMgICBlYng6IGM3MGIwMDAwICAgZWN4OiAwMDAwMDAwMCAgIGVkeDogYzg4NmM4MDAKZXNpOiAw
MDAwMDA2MyAgIGVkaTogYzcwMzk3NDQgICBlYnA6IGM3MDQwMDAwICAgZXNwOiBjNzE1NWViMApk
czogMDAxOCAgIGVzOiAwMDE4ICAgc3M6IDAwMTgKUHJvY2VzcyBzZXRzZXJpYWwgKHBpZDogMjgz
LCBzdGFja3BhZ2U9YzcxNTUwMDApClN0YWNrOiAwMDAwMDAwMCAwMDAwMDAwMCBjNzAzOTc0NCBj
NzA2YjYwMCAwMDAwMDAwMCBjMDE2ZDczYiBjNzA0MDAwMCBjNzE4M2FhMCAKICAgICAgIGM3MDM5
NzQwIGZmZmZmZmVkIGM3MDM5NzQ0IGM3MDZiNjAwIGM3ZmQ4OWQwIDA4MDI4MDA5IGM3MDQwMDAw
IGM3MGE0MGMwIAogICAgICAgMDAwMDAwMDAgYzAxNDUzYzkgYzcwYTQwYzAgYzAyNThjMTggYzcw
NmNhZTAgMDAwMDAwMDAgYzAxM2RiNTkgYzcwYTQwYzAgCkNhbGwgVHJhY2U6IFs8YzAxNmQ3M2I+
XSBbPGMwMTQ1M2M5Pl0gWzxjMDEzZGI1OT5dIFs8YzAxM2NmZDc+XSBbPGMwMTVhNDYwPl0gWzxj
MDEzMWYzMT5dIFs8YzAxMzFlNmE+XSAKICAgICAgIFs8YzAxMzIxODQ+XSBbPGMwMTA2ZjRiPl0g
CkNvZGU6IGY2IDQxIDBiIDQwIDc0IDFlIDg5IGM4IDA1IDYwIDAxIDAwIDAwIGU4IGNlIGFkIDhh
IGY3IDMxIGQyIAoKPj5FSVA7IGM4ODY4ZTFjIDxbcm9ja2V0XXJwX29wZW4rOTAvM2Q0PiAgIDw9
PT09PQpUcmFjZTsgYzAxNmQ3M2IgPHR0eV9vcGVuKzFkYi8zNGM+ClRyYWNlOyBjMDE0NTNjOSA8
ZHB1dCsxOS8xNjQ+ClRyYWNlOyBjMDEzZGI1OSA8cGF0aF93YWxrKzdkZC84YTQ+ClRyYWNlOyBj
MDEzY2ZkNyA8cGVybWlzc2lvbis4Yi85ND4KVHJhY2U7IGMwMTVhNDYwIDxkZXZmc19vcGVuK2Y0
LzFmND4KVHJhY2U7IGMwMTMxZjMxIDxkZW50cnlfb3BlbitiZC8xNGM+ClRyYWNlOyBjMDEzMWU2
YSA8ZmlscF9vcGVuKzUyLzVjPgpUcmFjZTsgYzAxMzIxODQgPHN5c19vcGVuKzNjL2YwPgpUcmFj
ZTsgYzAxMDZmNGIgPHN5c3RlbV9jYWxsKzMzLzM4PgpDb2RlOyAgYzg4NjhlMWMgPFtyb2NrZXRd
cnBfb3Blbis5MC8zZDQ+CjAwMDAwMDAwIDxfRUlQPjoKQ29kZTsgIGM4ODY4ZTFjIDxbcm9ja2V0
XXJwX29wZW4rOTAvM2Q0PiAgIDw9PT09PQogICAwOiAgIGY2IDQxIDBiIDQwICAgICAgICAgICAg
ICAgdGVzdGIgICQweDQwLDB4YiglZWN4KSAgIDw9PT09PQpDb2RlOyAgYzg4NjhlMjAgPFtyb2Nr
ZXRdcnBfb3Blbis5NC8zZDQ+CiAgIDQ6ICAgNzQgMWUgICAgICAgICAgICAgICAgICAgICBqZSAg
ICAgMjQgPF9FSVArMHgyND4gYzg4NjhlNDAgPFtyb2NrZXRdcnBfb3BlbitiNC8zZDQ+CkNvZGU7
ICBjODg2OGUyMiA8W3JvY2tldF1ycF9vcGVuKzk2LzNkND4KICAgNjogICA4OSBjOCAgICAgICAg
ICAgICAgICAgICAgIG1vdiAgICAlZWN4LCVlYXgKQ29kZTsgIGM4ODY4ZTI0IDxbcm9ja2V0XXJw
X29wZW4rOTgvM2Q0PgogICA4OiAgIDA1IDYwIDAxIDAwIDAwICAgICAgICAgICAgYWRkICAgICQw
eDE2MCwlZWF4CkNvZGU7ICBjODg2OGUyOSA8W3JvY2tldF1ycF9vcGVuKzlkLzNkND4KICAgZDog
ICBlOCBjZSBhZCA4YSBmNyAgICAgICAgICAgIGNhbGwgICBmNzhhYWRlMCA8X0VJUCsweGY3OGFh
ZGUwPiBjMDExM2JmYyA8aW50ZXJydXB0aWJsZV9zbGVlcF9vbiswLzZjPgpDb2RlOyAgYzg4Njhl
MmUgPFtyb2NrZXRdcnBfb3BlbithMi8zZDQ+CiAgMTI6ICAgMzEgZDIgICAgICAgICAgICAgICAg
ICAgICB4b3IgICAgJWVkeCwlZWR4CgoKMiB3YXJuaW5ncyBpc3N1ZWQuICBSZXN1bHRzIG1heSBu
b3QgYmUgcmVsaWFibGUuCg==

--------------Boundary-00=_IMD30BI5QHPQFF8ZK2NJ--
