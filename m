Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S315414AbSFTScS>; Thu, 20 Jun 2002 14:32:18 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S315417AbSFTScR>; Thu, 20 Jun 2002 14:32:17 -0400
Received: from etpmod.phys.tue.nl ([131.155.111.35]:61993 "EHLO
	etpmod.phys.tue.nl") by vger.kernel.org with ESMTP
	id <S315414AbSFTScI>; Thu, 20 Jun 2002 14:32:08 -0400
Date: Thu, 20 Jun 2002 20:32:09 +0200
From: Kurt Garloff <garloff@suse.de>
To: Linus Torvalds <torvalds@transmeta.com>
Cc: Linux kernel list <linux-kernel@vger.kernel.org>,
       Linux SCSI list <linux-scsi@vger.kernel.org>
Subject: Re: [PATCH] /proc/scsi/map
Message-ID: <20020620183209.GF28800@gum01m.etpnet.phys.tue.nl>
Mail-Followup-To: Kurt Garloff <garloff@suse.de>,
	Linus Torvalds <torvalds@transmeta.com>,
	Linux kernel list <linux-kernel@vger.kernel.org>,
	Linux SCSI list <linux-scsi@vger.kernel.org>
References: <20020620112543.GD26376@gum01m.etpnet.phys.tue.nl> <Pine.LNX.4.44.0206200816380.8012-100000@home.transmeta.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="kr14OxHsRwZHHqxS"
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.44.0206200816380.8012-100000@home.transmeta.com>
User-Agent: Mutt/1.4i
X-Operating-System: Linux 2.4.16-schedJ2 i686
X-PGP-Info: on http://www.garloff.de/kurt/mykeys.pgp
X-PGP-Key: 1024D/1C98774E, 1024R/CEFC9215
Organization: TU/e(NL), SuSE(DE)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--kr14OxHsRwZHHqxS
Content-Type: multipart/mixed; boundary="K1SnTjlYS/YgcDEx"
Content-Disposition: inline


--K1SnTjlYS/YgcDEx
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi Linus,

On Thu, Jun 20, 2002 at 08:34:40AM -0700, Linus Torvalds wrote:
> On Thu, 20 Jun 2002, Kurt Garloff wrote:
> > Look at /proc/scsi/scsi: The information is useful for the reader who w=
ants
> > to know what devices he has and were found by the SCSI subsystem.
>=20
> I would rephrase that as "the information is only useful to find devices
> found by the SCSI midlayer".

But finding is limited to get a list of manufacturer/model names and their
current CBTU location. You can't make up a device node from that. Only with
a lot of code you arrive at semi-reliable information.

> And my point is that you don't make it any better. Your patch perpetuates
> this lopsided world-view that people should care. THAT is the fundamental
> part that I don't like, because it drags us down for the future.

Actually, with the important exception of IDE disks, most devices are SCSI
in some way, meaning that they understand the SCSI command set. ATAPI
devices are, USB-storage is, IEEE1394 devices are ... so it is not as
restricted as it may seem.
So our consolidated driver structure will IMHO look like this
=20
    0        1              2            3

  disk -->  IDE-disk --> IDE mid(?)--> IDE-low
       \-> SCSI-disk --> SCSI-mid  --> SCSI-low
                     |             \-> FC-low
                     \-> USB-mid   --> USB-low
		     \-> FW-mid    --> FW-low
		     \-> pport-mid --> pport-low
		      ....

  cdrom -> SCSI-cd   --> SCSI-mid  --> SCSI-low
                     \-> IDE-mid   --> IDE-low
		      ....
=20
  =20
The drivers at column 0 would implement the interface to userspace vie the
device nodes. column 1 would generate the commands. column 2 would more or
less be some helper/transport layer whereas 3 would talk to the hardware.
And probably there will be some generalized "linux" command set being used
between 0 and 1, which would further down the chain be converted to the real
low-level commands. (We actually already have such a thing for block devs.)
So at level 1 there would be a more general "linux cmd set to XXX cmd set
converter".

Now, userspace should really not care what sort of device is hiding behind a
"disk" device, except that we=20
(1) want to be able to identify and find back a device
   (a) by a path to it                  and/or
   (b) by a unique hardware identifier  and/or
   (c) by its content (a label on it)
(2) may want to be able to send low-level (SCSI mostly) commands for
    configuration  to inquire speical information, or to do things where no
    kernel driver support exists, such as scanning or writing CDs.
    For SCSI-like devices, we always want to use sg for this, IMHO,
    as open() on a sg device is without side-effects and works reliably.

For the above, we only have partial solutions, currently.
(1a) The /driverfs path is exposing how a device is connected
     (Similar to the CBTU tuple, but more general and more reliable.)
     Unfortunately, this is 2.5 only.
(1b) We would need to get some WWN or serial number from the device.
     Unfortunately, not all devices have such a thing; currently
     we need userspace tools (see (2)) to collect such info or
     rely on the low-level driver
(1c) UUID and LVM make use of this, but that's a disk-only thing.
(2)  We currently have no relation between e.g. a disk and a sg device, so
     we lost. We can try to collect this info in userspace programs, but
     it's tedious, error prone and not reliable at this moment.

I hope we will have good solutions for all of these in future.

The reason why we want at least (1a) and one of (1b)/(1c) is that we can
have a device connected to a computer more than once (multipathing).

Some devices offer more than one interface; if a kernel-driver for writing
CDs would exist, we would have both a writer and cdrom driver attached to i=
t.
The fact that it's the same piece of hardware also would need to be reflect=
ed
in some way.=20

For now, lots of devices hook into the the SCSI subsystem, and what I'm
trying to get is a solution for (2) which also enable userspace solutions
for (1b).

[...]
> I will bet you that there are more IDE CD-RW's out there than there are
> SCSI devices. The fact that people use ide-scsi to write to them is a
> hopefully very temporary situation, and the command interface is going
> to move to a higher layer.

They use SCSI commands, so you will want to offer an interface for
applications to send SCSI commands, unless you want somebody to write a
kernel driver to support CD writing.
This would in my "SCSI-centric world-view" also be a SCSI interface, though
maybe not based on nowadays SCSI mid-layer code.

> At which point your SCSI-centric world-view now became a total failure, as
> it no longer shows up most of the devices that can write CD's or DVD's any
> more.
>=20
> Sure, it will still continue to show "what devices were found by the SCSI
> midlayer". But user applications will have to scan other stuff, and find
> the IDE-specific stuff, and then whatever else is out there.
>=20
> See the problem?

I imagine that we will continue to allow userspace to send raw commands to
devices, as we won't be able nor willing to support every device type fully
by kernel drivers.
These raw commands will be SCSI commands for most devices.
I imagined, that we register all those devices within some subsystem
which would be a revised, generalized and probably thinner SCSI subsystem.

> If, on the other hand, you try to take the bull by the horns and realize
> that the notion of "searching for devices" has nothing to do with SCSI at
> _all_, you may find yourself with more work on your hands, but on the
> other hand, wouldn't it be just so _nice_ to be able to do
>=20
> 	find /devices -name cd-rw
>=20
> to find all cd-rw's in the system?

Which makes we wonder whether we'll present devices by their attachment path
or by their type or both ....
But yes, it would be nice.

> Does it work that way now? Absolutely not.=20
> But most of the infrastructure is actually there today. Wouldn't it
> be _nice_ if after the CD-writing app has found all cd-rw's, it just opens
> them, and the kernel will automatically open the right device (whether it
> is a scsi-generic one or a IDE one)?

See, I would both call SCSI devices. Just because you use a 40/80 pin IDE
cable and a somewhat different low-level protocol, it still understands
SCSI commands.

[...]
> > And completely useless for any program that wants to find a scanner,
> > CD-Writer, ... as there is no connection to the high-level drivers atta=
ched
> > to them.
>=20
> I'm not disputing that.
>=20
> However, I _am_ disputing that this should be done in some SCSI-centric
> way that works for SCSI but nothing else.

I would have imagined driver unification as making all devices that
understand SCSI commands to hook into some generalized and cleaned SCSI
subsystem.
Obviously your vision (or only naming?) is different.
How does it look like in your plans?

> When I want to find a CD-ROM, I don't want to worry about whether it is
> IDE or SCSI. I would
>=20
> > But I still think the SCSI subsystem should report which SCSI (low-leve=
l)
> > device is mapped to what high-level driver.
> > Would you accept a patch that adds a line like
> >
> > Host: scsi3 Channel: 00 Id: 12 Lun: 00
> >   Vendor: IBM      Model: DPSS-336950N     Rev: S84D
> >   Type:   Direct-Access                    ANSI SCSI revision: 03
> >   Attached drivers: sg12(c:15:0c) sdf(b:08:50)
> >   ^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^
> > to /proc/scsi/scsi ?
>=20
> That would be less offensive to me if only because it doesn't introduce a
> _new_ interface that is SCSI-only, it only extends on an old one. It makes
> no _technical_ difference, but I'd rather extend an old broken interface
> than introduce a totally new broken interface.

Please consider applying the attached patch which adds this line.

[...]
> > The CBTU tuple uniquely addresses a SCSI device in a running system.
>=20
> Yes, but that's not enough. Other people are still asking for physical
> location, so let's try to fix two things with _one_ generic interface that
> is at least agnostic to how a device is connected to the kernel..

That would be the /dev/disks/0 ... N, /dev/cd/0 ... M, ... interface, if I
get you correctly. Instead of 0 ... N one might hope to have unique IDs.

But we would still need to find some way to allow extra information, like
the path there, sending low-level commands, ... as we'll never be able
(nor wanting) to push all into the kernel behind the "disk" interface, I
think ...

Regards,
--=20
Kurt Garloff  <garloff@suse.de>                          Eindhoven, NL
GPG key: See mail header, key servers         Linux kernel development
SuSE Linux AG, Nuernberg, DE                            SCSI, Security

--K1SnTjlYS/YgcDEx
Content-Type: text/plain; charset=us-ascii
Content-Disposition: attachment; filename="scsi-map-8.diff"
Content-Transfer-Encoding: quoted-printable

diff -uNr linux-2.5.23-dj2/drivers/scsi/hosts.h linux-2.5.23-dj2-scsirephl/=
drivers/scsi/hosts.h
--- linux-2.5.23-dj2/drivers/scsi/hosts.h	Thu Jun 20 01:44:47 2002
+++ linux-2.5.23-dj2-scsirephl/drivers/scsi/hosts.h	Thu Jun 20 18:54:10 2002
@@ -486,6 +486,7 @@
     void (*detach)(Scsi_Device *);
     int (*init_command)(Scsi_Cmnd *);     /* Used by new queueing code.=20
                                            Selects command for blkdevs */
+    int (*find_kdev)(Scsi_Device *, char*, kdev_t*);  /* find back dev. */
 };
=20
 void  scsi_initialize_queue(Scsi_Device * SDpnt, struct Scsi_Host * SHpnt);
diff -uNr linux-2.5.23-dj2/drivers/scsi/osst.c linux-2.5.23-dj2-scsirephl/d=
rivers/scsi/osst.c
--- linux-2.5.23-dj2/drivers/scsi/osst.c	Wed Jun 19 04:11:54 2002
+++ linux-2.5.23-dj2-scsirephl/drivers/scsi/osst.c	Thu Jun 20 18:54:26 2002
@@ -155,6 +155,7 @@
 static int osst_attach(Scsi_Device *);
 static int osst_detect(Scsi_Device *);
 static void osst_detach(Scsi_Device *);
+static int osst_find_kdev(Scsi_Device *, char*, kdev_t*);
=20
 struct Scsi_Device_Template osst_template =3D
 {
@@ -166,7 +167,8 @@
        detect:		osst_detect,
        init:		osst_init,
        attach:		osst_attach,
-       detach:		osst_detach
+       detach:		osst_detach,
+       find_kdev:	osst_find_kdev,
 };
=20
 static int osst_int_ioctl(OS_Scsi_Tape *STp, Scsi_Request ** aSRpnt, unsig=
ned int cmd_in,unsigned long arg);
@@ -5417,6 +5419,24 @@
 	return 0;
 }
=20
+static int osst_find_kdev(Scsi_Device *sdp, char* nm, kdev_t *dev)
+{
+	int i;
+	OS_Scsi_Tape *ostp;
+=09
+	if (sdp && sdp->type =3D=3D TYPE_TAPE && osst_supports(sdp)) {
+		for (ostp =3D os_scsi_tapes[i =3D 0]; i < osst_template.dev_max;
+		     ostp =3D os_scsi_tapes[++i]) {
+			if (ostp && ostp->device =3D=3D sdp) {
+				sprintf (nm, "osst%i", i);
+				*dev =3D mk_kdev(OSST_MAJOR, i);
+				return 0;
+			}
+		}
+	}
+	return 1;
+}
+
 static int osst_attach(Scsi_Device * SDp)
 {
 	OS_Scsi_Tape * tpnt;
diff -uNr linux-2.5.23-dj2/drivers/scsi/scsi_proc.c linux-2.5.23-dj2-scsire=
phl/drivers/scsi/scsi_proc.c
--- linux-2.5.23-dj2/drivers/scsi/scsi_proc.c	Wed Jun 19 04:11:47 2002
+++ linux-2.5.23-dj2-scsirephl/drivers/scsi/scsi_proc.c	Thu Jun 20 18:52:55=
 2002
@@ -260,6 +260,10 @@
=20
 	int x, y =3D *size;
 	extern const char *const scsi_device_types[MAX_SCSI_DEVICE_CODE];
+	char nm[16];
+	kdev_t kdev;
+	int att =3D scd->attached;
+	struct Scsi_Device_Template *sd_t =3D scsi_devicelist;
=20
 	y =3D sprintf(buffer + len,
 	     "Host: scsi%d Channel: %02d Id: %02d Lun: %02d\n  Vendor: ",
@@ -295,7 +299,24 @@
 		y +=3D sprintf(buffer + len + y, " CCS\n");
 	else
 		y +=3D sprintf(buffer + len + y, "\n");
+=09
+	/* Report high level devices attached */
+	y +=3D sprintf (buffer + len + y, "  Attached drivers:");
=20
+	while (att && sd_t) {
+		if (sd_t->find_kdev) {
+			if (!(sd_t->find_kdev(scd, nm, &kdev))) {
+				y +=3D sprintf(buffer + len + y,
+					     " %s(%c:%02x:%02x)",
+					     nm, (sd_t->blk? 'b': 'c'),
+					     MAJOR(kdev), MINOR(kdev));
+				--att;
+			}
+		}
+		sd_t =3D sd_t->next;
+	}
+
+	y +=3D sprintf(buffer + len + y, "\n");
 	*size =3D y;
 	return;
 }
diff -uNr linux-2.5.23-dj2/drivers/scsi/sd.c linux-2.5.23-dj2-scsirephl/dri=
vers/scsi/sd.c
--- linux-2.5.23-dj2/drivers/scsi/sd.c	Thu Jun 20 01:44:48 2002
+++ linux-2.5.23-dj2-scsirephl/drivers/scsi/sd.c	Thu Jun 20 18:54:43 2002
@@ -103,6 +103,7 @@
 static int sd_detect(Scsi_Device *);
 static void sd_detach(Scsi_Device *);
 static int sd_init_command(Scsi_Cmnd *);
+static int sd_find_kdev(Scsi_Device*, char*, kdev_t*);
=20
 static struct Scsi_Device_Template sd_template =3D {
 	module:THIS_MODULE,
@@ -122,6 +123,7 @@
 	attach:sd_attach,
 	detach:sd_detach,
 	init_command:sd_init_command,
+	find_kdev:sd_find_kdev,
 };
=20
 static void sd_rw_intr(Scsi_Cmnd * SCpnt);
@@ -285,6 +287,24 @@
 	}
 }
=20
+static int sd_find_kdev(Scsi_Device *sdp, char* nm, kdev_t *dev)
+{
+	Scsi_Disk *sdkp;
+	int dsk_nr;
+
+	if (sdp && (sdp->type =3D=3D TYPE_DISK || sdp->type =3D=3D TYPE_MOD)) {
+		for (dsk_nr =3D 0; dsk_nr < sd_template.dev_max; ++dsk_nr) {
+			sdkp =3D sd_dsk_arr[dsk_nr];
+			if (sdkp->device =3D=3D sdp) {
+				sd_dskname(dsk_nr, nm);
+				*dev =3D MKDEV_SD(dsk_nr);
+				return 0;
+			}
+		}
+	}
+	return 1;
+}
+
 /**
  *	sd_find_queue - yields queue associated with device
  *	@dev: kernel device descriptor (kdev_t)
diff -uNr linux-2.5.23-dj2/drivers/scsi/sg.c linux-2.5.23-dj2-scsirephl/dri=
vers/scsi/sg.c
--- linux-2.5.23-dj2/drivers/scsi/sg.c	Wed Jun 19 04:11:54 2002
+++ linux-2.5.23-dj2-scsirephl/drivers/scsi/sg.c	Thu Jun 20 18:54:51 2002
@@ -111,6 +111,7 @@
 static void sg_finish(void);
 static int sg_detect(Scsi_Device *);
 static void sg_detach(Scsi_Device *);
+static int sg_find_kdev(Scsi_Device *, char*, kdev_t*);
=20
 static Scsi_Request * dummy_cmdp;	/* only used for sizeof */
=20
@@ -120,6 +121,7 @@
 static struct Scsi_Device_Template sg_template =3D
 {
       module:THIS_MODULE,
+      name:"generic",
       tag:"sg",
       scsi_type:0xff,
       major:SCSI_GENERIC_MAJOR,
@@ -127,7 +129,8 @@
       init:sg_init,
       finish:sg_finish,
       attach:sg_attach,
-      detach:sg_detach
+      detach:sg_detach,
+      find_kdev:sg_find_kdev
 };
=20
=20
@@ -2632,6 +2635,37 @@
 }
=20
 #ifdef CONFIG_PROC_FS
+static int sg_find_kdev(Scsi_Device* sdp, char *nm, kdev_t *dev)
+{
+    unsigned long iflags;
+    int err =3D 1;=20
+
+    if (sdp && sg_dev_arr) {
+	int k;
+	read_lock_irqsave(&sg_dev_arr_lock, iflags);
+	for (k =3D 0; k < sg_template.dev_max; ++k) {
+	    if (sg_dev_arr[k] && sg_dev_arr[k]->device =3D=3D sdp) {
+		sprintf (nm, "sg%i", k);
+	        *dev =3D sg_dev_arr[k]->i_rdev;
+		err =3D 0;
+		break;
+	    }
+	}
+	read_unlock_irqrestore(&sg_dev_arr_lock, iflags);
+    }
+    return err;
+}
+#else
+/* Not needed without procfs support */
+static int sg_find_kdev(Scsi_Device* sdp, char *nm, kdev_t *dev)
+{
+    *nm =3D 0;
+    *kdev =3D NODEV;
+    return 1;
+}
+#endif
+
+#ifdef CONFIG_PROC_FS
=20
 static struct proc_dir_entry * sg_proc_sgp =3D NULL;
=20
diff -uNr linux-2.5.23-dj2/drivers/scsi/sr.c linux-2.5.23-dj2-scsirephl/dri=
vers/scsi/sr.c
--- linux-2.5.23-dj2/drivers/scsi/sr.c	Wed Jun 19 04:11:50 2002
+++ linux-2.5.23-dj2-scsirephl/drivers/scsi/sr.c	Thu Jun 20 18:54:59 2002
@@ -71,6 +71,8 @@
=20
 static int sr_init_command(Scsi_Cmnd *);
=20
+static int sr_find_kdev(Scsi_Device*, char*, kdev_t*);
+
 static struct Scsi_Device_Template sr_template =3D
 {
 	module:THIS_MODULE,
@@ -84,7 +86,8 @@
 	finish:sr_finish,
 	attach:sr_attach,
 	detach:sr_detach,
-	init_command:sr_init_command
+	init_command:sr_init_command,
+	find_kdev:sr_find_kdev,
 };
=20
 Scsi_CD *scsi_CDs;
@@ -471,6 +474,23 @@
 	return 0;
 }
=20
+static int sr_find_kdev(Scsi_Device *sdp, char* nm, kdev_t *dev)
+{
+	Scsi_CD *srp;
+	int i;
+=09
+	if (sdp && (sdp->type =3D=3D TYPE_ROM || sdp->type =3D=3D TYPE_WORM)) {
+		for (srp =3D scsi_CDs, i =3D 0; i < sr_template.dev_max;
+		     ++i, ++srp) {
+			if (srp->device =3D=3D sdp) {
+				sprintf(nm, "sr%i", i);
+				*dev =3D mk_kdev(SCSI_CDROM_MAJOR,i);
+				return 0;
+			}
+		}
+	}
+	return 1;
+}
=20
 void get_sectorsize(int i)
 {
diff -uNr linux-2.5.23-dj2/drivers/scsi/st.c linux-2.5.23-dj2-scsirephl/dri=
vers/scsi/st.c
--- linux-2.5.23-dj2/drivers/scsi/st.c	Wed Jun 19 04:11:56 2002
+++ linux-2.5.23-dj2-scsirephl/drivers/scsi/st.c	Thu Jun 20 18:56:18 2002
@@ -148,6 +148,7 @@
 static int st_attach(Scsi_Device *);
 static int st_detect(Scsi_Device *);
 static void st_detach(Scsi_Device *);
+static int st_find_kdev(Scsi_Device*, char*, kdev_t*);
=20
 static struct Scsi_Device_Template st_template =3D {
 	module:		THIS_MODULE,
@@ -157,7 +158,8 @@
 	major:		SCSI_TAPE_MAJOR,=20
 	detect:		st_detect,=20
 	attach:		st_attach,=20
-	detach:		st_detach
+	detach:		st_detach,
+	find_kdev:	st_find_kdev
 };
=20
 static int st_compression(Scsi_Tape *, int);
@@ -3760,6 +3762,24 @@
 	return;
 }
=20
+static int st_find_kdev(Scsi_Device * sdp, char* nm, kdev_t *dev)
+{
+	int i;
+	Scsi_Tape *stp;
+
+	if (sdp && sdp->type =3D=3D TYPE_TAPE && !st_incompatible(sdp)) {
+		for (stp =3D scsi_tapes[0], i =3D 0; i < st_template.dev_max;
+		     stp =3D scsi_tapes[++i]) {
+			if (stp && stp->device =3D=3D sdp) {
+				sprintf(nm, "st%i", i);
+				*dev =3D mk_kdev(SCSI_TAPE_MAJOR, i);
+				return 0;
+			}
+		}
+	}
+	return 1;
+}
+
 static int __init init_st(void)
 {
 	validate_options();

--K1SnTjlYS/YgcDEx--

--kr14OxHsRwZHHqxS
Content-Type: application/pgp-signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.0.7 (GNU/Linux)

iD8DBQE9Eh+oxmLh6hyYd04RAlCCAKCMnWDpOBX3HCVACri/68S7Wi8fxACg1t2f
19ltasRP2WLwFe/57ulktpQ=
=gVAF
-----END PGP SIGNATURE-----

--kr14OxHsRwZHHqxS--
