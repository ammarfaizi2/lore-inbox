Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263793AbUA3HhS (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 30 Jan 2004 02:37:18 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266243AbUA3HhS
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 30 Jan 2004 02:37:18 -0500
Received: from moutng.kundenserver.de ([212.227.126.171]:18430 "EHLO
	moutng.kundenserver.de") by vger.kernel.org with ESMTP
	id S263793AbUA3Hf4 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 30 Jan 2004 02:35:56 -0500
Date: Fri, 30 Jan 2004 08:35:40 +0100
From: "Juergen E. Fischer" <fischer@linux-buechse.de>
To: Rusty Russell <rusty@rustcorp.com.au>
Cc: david.ronis@mcgill.ca, linux-kernel@vger.kernel.org
Subject: Re: Problem with module-init-tools-3.0-pre3
Message-ID: <20040130073540.GA17435@linux-buechse.de>
Mail-Followup-To: Rusty Russell <rusty@rustcorp.com.au>,
	david.ronis@mcgill.ca, linux-kernel@vger.kernel.org
References: <16409.11897.539398.14955@ronispc.chem.mcgill.ca> <20040130040158.4785D2C002@lists.samba.org>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="4bRzO86E/ozDv8r1"
Content-Disposition: inline
In-Reply-To: <20040130040158.4785D2C002@lists.samba.org>
User-Agent: Mutt/1.5.5.1+cvs20040105i
X-Provags-ID: kundenserver.de abuse@kundenserver.de auth:8b0c050ff9179508392b54e1b921775e
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--4bRzO86E/ozDv8r1
Content-Type: multipart/mixed; boundary="C7zPtVaVf+AK4Oqc"
Content-Disposition: inline


--C7zPtVaVf+AK4Oqc
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi,

On Fri, Jan 30, 2004 at 14:29:59 +1100, Rusty Russell wrote:
> Looks like aha152x or sd is not cleaning up properly, and when
> reinserted, something screws up.

I guess that's without the pending patch.  If it's aha152x, the patch
might also do some good in that departement.


J=FCrgen

--=20
A: No.
Q: Should I include quotations after my reply?

--C7zPtVaVf+AK4Oqc
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: attachment; filename="aha152x-2.6.2-rc2-4.diff"
Content-Transfer-Encoding: quoted-printable

diff -uprd orig/linux-2.6.2-rc2/drivers/scsi/aha152x.c linux-2.6.2-rc2/driv=
ers/scsi/aha152x.c
--- orig/linux-2.6.2-rc2/drivers/scsi/aha152x.c	2004-01-24 11:54:43.0000000=
00 +0100
+++ linux-2.6.2-rc2/drivers/scsi/aha152x.c	2004-01-30 08:21:54.000000000 +0=
100
@@ -1,6 +1,6 @@
 /* aha152x.c -- Adaptec AHA-152x driver
  * Author: J=FCrgen E. Fischer, fischer@norbit.de
- * Copyright 1993-2000 J=FCrgen E. Fischer
+ * Copyright 1993-2004 J=FCrgen E. Fischer
  *
  * This program is free software; you can redistribute it and/or modify it
  * under the terms of the GNU General Public License as published by the
@@ -13,9 +13,17 @@
  * General Public License for more details.
  *
  *
- * $Id: aha152x.c,v 2.6 2003/10/30 20:52:47 fischer Exp $
+ * $Id: aha152x.c,v 2.7 2004/01/24 11:42:59 fischer Exp $
  *
  * $Log: aha152x.c,v $
+ * Revision 2.7  2004/01/24 11:42:59  fischer
+ * - gather code that is not used by PCMCIA at the end
+ * - move request_region for !PCMCIA case to detection
+ * - migration to new scsi host api (remove legacy code)
+ * - free host scribble before scsi_done
+ * - fix error handling
+ * - one isapnp device added to id_table
+ *
  * Revision 2.6  2003/10/30 20:52:47  fischer
  * - interfaces changes for kernel 2.6
  * - aha152x_probe_one introduced for pcmcia stub
@@ -344,7 +352,8 @@ MODULE_AUTHOR("J=FCrgen Fischer");
 MODULE_DESCRIPTION(AHA152X_REVID);
 MODULE_LICENSE("GPL");
=20
-#if defined(MODULE) && !defined(PCMCIA)
+#if !defined(PCMCIA)
+#if defined(MODULE)
 MODULE_PARM(io, "1-2i");
 MODULE_PARM_DESC(io,"base io address of controller");
 static int io[] =3D {0, 0};
@@ -398,21 +407,23 @@ MODULE_PARM(aha152x1, "1-9i");
 MODULE_PARM_DESC(aha152x1, "parameters for second controller");
 static int aha152x1[]  =3D {0, 11, 7, 1, 1, 1, DELAY_DEFAULT, 0, DEBUG_DEF=
AULT};
 #endif /* !defined(AHA152X_DEBUG) */
-#endif /* MODULE && !PCMCIA */
+#endif /* MODULE */
=20
 #ifdef __ISAPNP__
 static struct isapnp_device_id id_table[] __devinitdata =3D {
-	{ ISAPNP_DEVICE_SINGLE('A','D','P',0x1505, 'A','D','P',0x1505), },
+	{ ISAPNP_ANY_ID, ISAPNP_ANY_ID,
+		ISAPNP_VENDOR('A','D','P'), ISAPNP_FUNCTION(0x1505), 0 },
+	{ ISAPNP_ANY_ID, ISAPNP_ANY_ID,
+		ISAPNP_VENDOR('A','D','P'), ISAPNP_FUNCTION(0x1530), 0 },
 	{ ISAPNP_DEVICE_SINGLE_END, }
 };
 MODULE_DEVICE_TABLE(isapnp, id_table);
 #endif /* ISAPNP */
=20
-/* set by aha152x_setup according to the command line */
-static int setup_count;
-static int registered_count;
-static struct aha152x_setup setup[2];
-static struct Scsi_Host *aha152x_host[2];
+#endif /* !PCMCIA */
+
+static int registered_count=3D0;
+static struct Scsi_Host *aha152x_host[2] =3D {0, 0};
 static Scsi_Host_Template aha152x_driver_template;
=20
 /*
@@ -658,7 +669,6 @@ static irqreturn_t intr(int irq, void *d
 static void reset_ports(struct Scsi_Host *shpnt);
 static void aha152x_error(struct Scsi_Host *shpnt, char *msg);
 static void done(struct Scsi_Host *shpnt, int error);
-static int checksetup(struct aha152x_setup *setup);
=20
 /* diagnostics */
 static void disp_ports(struct Scsi_Host *shpnt);
@@ -666,66 +676,6 @@ static void show_command(Scsi_Cmnd * ptr
 static void show_queues(struct Scsi_Host *shpnt);
 static void disp_enintr(struct Scsi_Host *shpnt);
=20
-/* possible i/o addresses for the AIC-6260; default first */
-static unsigned short ports[] =3D { 0x340, 0x140 };
-
-#if !defined(SKIP_BIOSTEST)
-/* possible locations for the Adaptec BIOS; defaults first */
-static unsigned int addresses[] =3D
-{
-	0xdc000,		/* default first */
-	0xc8000,
-	0xcc000,
-	0xd0000,
-	0xd4000,
-	0xd8000,
-	0xe0000,
-	0xeb800,		/* VTech Platinum SMP */
-	0xf0000,
-};
-
-/* signatures for various AIC-6[23]60 based controllers.
-   The point in detecting signatures is to avoid useless and maybe
-   harmful probes on ports. I'm not sure that all listed boards pass
-   auto-configuration. For those which fail the BIOS signature is
-   obsolete, because user intervention to supply the configuration is
-   needed anyway.  May be an information whether or not the BIOS supports
-   extended translation could be also useful here. */
-static struct signature {
-	unsigned char *signature;
-	int sig_offset;
-	int sig_length;
-} signatures[] =3D
-{
-	{ "Adaptec AHA-1520 BIOS",	0x102e, 21 },
-		/* Adaptec 152x */
-	{ "Adaptec AHA-1520B",		0x000b, 17 },
-		/* Adaptec 152x rev B */
-	{ "Adaptec AHA-1520B",		0x0026, 17 },
-		/* Iomega Jaz Jet ISA (AIC6370Q) */
-	{ "Adaptec ASW-B626 BIOS",	0x1029, 21 },
-		/* on-board controller */
-	{ "Adaptec BIOS: ASW-B626",	0x000f, 22 },
-		/* on-board controller */
-	{ "Adaptec ASW-B626 S2",	0x2e6c, 19 },
-		/* on-board controller */
-	{ "Adaptec BIOS:AIC-6360",	0x000c, 21 },
-		/* on-board controller */
-	{ "ScsiPro SP-360 BIOS",	0x2873, 19 },
-		/* ScsiPro-Controller  */
-	{ "GA-400 LOCAL BUS SCSI BIOS", 0x102e, 26 },
-		/* Gigabyte Local-Bus-SCSI */
-	{ "Adaptec BIOS:AVA-282X",	0x000c, 21 },
-		/* Adaptec 282x */
-	{ "Adaptec IBM Dock II SCSI",	0x2edd, 24 },
-		/* IBM Thinkpad Dock II */
-	{ "Adaptec BIOS:AHA-1532P",	0x001c, 22 },
-		/* IBM Thinkpad Dock II SCSI */
-	{ "DTC3520A Host Adapter BIOS", 0x318a, 26 },
-		/* DTC 3520A ISA SCSI */
-};
-#endif
-
=20
 /*
  *  queue services:
@@ -799,141 +749,6 @@ static inline Scsi_Cmnd *remove_SC(Scsi_
 	return ptr;
 }
=20
-#if defined(PCMCIA) || !defined(MODULE)
-static void aha152x_setup(char *str, int *ints)
-{
-	if(setup_count>=3DARRAY_SIZE(setup)) {
-		printk(KERN_ERR "aha152x: you can only configure up to two controllers\n=
");
-		return;
-	}
-
-	setup[setup_count].conf        =3D str;
-	setup[setup_count].io_port     =3D ints[0] >=3D 1 ? ints[1] : 0x340;
-	setup[setup_count].irq         =3D ints[0] >=3D 2 ? ints[2] : 11;
-	setup[setup_count].scsiid      =3D ints[0] >=3D 3 ? ints[3] : 7;
-	setup[setup_count].reconnect   =3D ints[0] >=3D 4 ? ints[4] : 1;
-	setup[setup_count].parity      =3D ints[0] >=3D 5 ? ints[5] : 1;
-	setup[setup_count].synchronous =3D ints[0] >=3D 6 ? ints[6] : 1;
-	setup[setup_count].delay       =3D ints[0] >=3D 7 ? ints[7] : DELAY_DEFAU=
LT;
-	setup[setup_count].ext_trans   =3D ints[0] >=3D 8 ? ints[8] : 0;
-#if defined(AHA152X_DEBUG)
-	setup[setup_count].debug       =3D ints[0] >=3D 9 ? ints[9] : DEBUG_DEFAU=
LT;
-	if (ints[0] > 9) {
-		printk(KERN_NOTICE "aha152x: usage: aha152x=3D<IOBASE>[,<IRQ>[,<SCSI ID>"
-		       "[,<RECONNECT>[,<PARITY>[,<SYNCHRONOUS>[,<DELAY>[,<EXT_TRANS>[,<D=
EBUG>]]]]]]]]\n");
-#else
-	if (ints[0] > 8) {                                                /*}*/
-		printk(KERN_NOTICE "aha152x: usage: aha152x=3D<IOBASE>[,<IRQ>[,<SCSI ID>"
-		       "[,<RECONNECT>[,<PARITY>[,<SYNCHRONOUS>[,<DELAY>[,<EXT_TRANS>]]]]=
]]]\n");
-#endif
-	} else {
-		setup_count++;
-	}
-}
-#endif
-
-#if !defined(MODULE)
-static int __init do_setup(char *str)
-{
-
-#if defined(AHA152X_DEBUG)
-	int ints[11];
-#else
-	int ints[10];
-#endif
-	int count=3Dsetup_count;
-
-	get_options(str, ARRAY_SIZE(ints), ints);
-	aha152x_setup(str,ints);
-
-	return count<setup_count;
-}
-
-__setup("aha152x=3D", do_setup);
-#endif
-
-/*
- * Test, if port_base is valid.
- *
- */
-static int aha152x_porttest(int io_port)
-{
-	int i;
-
-	SETPORT(io_port + O_DMACNTRL1, 0);	/* reset stack pointer */
-	for (i =3D 0; i < 16; i++)
-		SETPORT(io_port + O_STACK, i);
-
-	SETPORT(io_port + O_DMACNTRL1, 0);	/* reset stack pointer */
-	for (i =3D 0; i < 16 && GETPORT(io_port + O_STACK) =3D=3D i; i++)
-		;
-
-	return (i =3D=3D 16);
-}
-
-static int tc1550_porttest(int io_port)
-{
-	int i;
-
-	SETPORT(io_port + O_TC_DMACNTRL1, 0);	/* reset stack pointer */
-	for (i =3D 0; i < 16; i++)
-		SETPORT(io_port + O_STACK, i);
-
-	SETPORT(io_port + O_TC_DMACNTRL1, 0);	/* reset stack pointer */
-	for (i =3D 0; i < 16 && GETPORT(io_port + O_TC_STACK) =3D=3D i; i++)
-		;
-
-	return (i =3D=3D 16);
-}
-
-static int checksetup(struct aha152x_setup *setup)
-{
-
-#if !defined(PCMCIA)
-	int i;
-	for (i =3D 0; i < ARRAY_SIZE(ports) && (setup->io_port !=3D ports[i]); i+=
+)
-		;
-
-	if (i =3D=3D ARRAY_SIZE(ports))
-		return 0;
-#endif
-	if (!request_region(setup->io_port, IO_RANGE, "aha152x"))
-		return 0;
-
-	if(aha152x_porttest(setup->io_port)) {
-		setup->tc1550=3D0;
-        } else if(tc1550_porttest(setup->io_port)) {
-		setup->tc1550=3D1;
-	} else {
-		release_region(setup->io_port, IO_RANGE);
-		return 0;
-	}
-
-	release_region(setup->io_port, IO_RANGE);
-
-
-	if ((setup->irq < IRQ_MIN) || (setup->irq > IRQ_MAX))
-		return 0;
-
-	if ((setup->scsiid < 0) || (setup->scsiid > 7))
-		return 0;
-
-	if ((setup->reconnect < 0) || (setup->reconnect > 1))
-		return 0;
-
-	if ((setup->parity < 0) || (setup->parity > 1))
-		return 0;
-
-	if ((setup->synchronous < 0) || (setup->synchronous > 1))
-		return 0;
-
-	if ((setup->ext_trans < 0) || (setup->ext_trans > 1))
-		return 0;
-
-
-	return 1;
-}
-
 static inline struct Scsi_Host *lookup_irq(int irqno)
 {
 	int i;
@@ -950,7 +765,6 @@ static irqreturn_t swintr(int irqno, voi
 	struct Scsi_Host *shpnt =3D lookup_irq(irqno);
=20
 	if (!shpnt) {
-		/* no point using HOSTNO here! */
         	printk(KERN_ERR "aha152x: catched software interrupt %d for unkno=
wn controller.\n", irqno);
 		return IRQ_NONE;
 	}
@@ -961,17 +775,19 @@ static irqreturn_t swintr(int irqno, voi
 	return IRQ_HANDLED;
 }
=20
-
 struct Scsi_Host *aha152x_probe_one(struct aha152x_setup *setup)
 {
 	struct Scsi_Host *shpnt;
=20
 	shpnt =3D scsi_host_alloc(&aha152x_driver_template, sizeof(struct aha152x=
_hostdata));
 	if (!shpnt) {
-		printk(KERN_ERR "aha152x: scsi_register failed\n");
+		printk(KERN_ERR "aha152x: scsi_host_alloc failed\n");
 		return NULL;
 	}
=20
+	/* need to have host registered before triggering any interrupt */
+	aha152x_host[registered_count] =3D shpnt;
+
 	memset(HOSTDATA(shpnt), 0, sizeof *HOSTDATA(shpnt));
=20
 	shpnt->io_port   =3D setup->io_port;
@@ -1034,24 +850,19 @@ struct Scsi_Host *aha152x_probe_one(stru
 	       DELAY,
 	       EXT_TRANS ? "enabled" : "disabled");
=20
-	if (!request_region(shpnt->io_port, IO_RANGE, "aha152x"))
-		goto out_unregister;
-
 	/* not expecting any interrupts */
 	SETPORT(SIMODE0, 0);
 	SETPORT(SIMODE1, 0);
=20
-	if (request_irq(shpnt->irq, swintr, SA_INTERRUPT|SA_SHIRQ, "aha152x", shp=
nt) < 0) {
-		printk(KERN_ERR "aha152x%d: driver needs an IRQ.\n", shpnt->host_no);
-		goto out_release_region;
+	if( request_irq(shpnt->irq, swintr, SA_INTERRUPT|SA_SHIRQ, "aha152x", shp=
nt) ) {
+		printk(KERN_ERR "aha152x%d: irq %d busy.\n", shpnt->host_no, shpnt->irq);
+		goto out_host_put;
 	}
=20
 	HOSTDATA(shpnt)->swint =3D 0;
=20
 	printk(KERN_INFO "aha152x%d: trying software interrupt, ", shpnt->host_no=
);
=20
-	/* need to have host registered before triggering any interrupt */
-	aha152x_host[registered_count] =3D shpnt;
 	mb();
 	SETPORT(DMACNTRL0, SWINT|INTEN);
 	mdelay(1000);
@@ -1066,9 +877,9 @@ struct Scsi_Host *aha152x_probe_one(stru
=20
 		SETPORT(DMACNTRL0, INTEN);
=20
-		printk(KERN_ERR "aha152x%d: IRQ %d possibly wrong.  "
+		printk(KERN_ERR "aha152x%d: irq %d possibly wrong.  "
 				"Please verify.\n", shpnt->host_no, shpnt->irq);
-		goto out_unregister_host;
+		goto out_host_put;
 	}
 	printk("ok.\n");
=20
@@ -1077,322 +888,50 @@ struct Scsi_Host *aha152x_probe_one(stru
 	SETPORT(SSTAT0, 0x7f);
 	SETPORT(SSTAT1, 0xef);
=20
-	if (request_irq(shpnt->irq, intr, SA_INTERRUPT|SA_SHIRQ, "aha152x", shpnt=
) < 0) {
-		printk(KERN_ERR "aha152x%d: failed to reassign interrupt.\n", shpnt->hos=
t_no);
-		goto out_unregister_host;
-	}
-
-	scsi_add_host(shpnt, 0);
-	scsi_scan_host(shpnt);
-	return shpnt;	/* the pcmcia stub needs the return value; */
-
-out_unregister_host:
-	aha152x_host[registered_count] =3D NULL;
-out_release_region:
-	release_region(shpnt->io_port, IO_RANGE);
-out_unregister:
-	scsi_host_put(shpnt);
-	return NULL;
-}
-
-static int __init aha152x_init(void)
-{
-	int i, j, ok;
-#if defined(AUTOCONF)
-	aha152x_config conf;
-#endif
-#ifdef __ISAPNP__
-	struct pnp_dev *dev=3D0, *pnpdev[2] =3D {0, 0};
-#endif
-
-	if (setup_count) {
-		printk(KERN_INFO "aha152x: processing commandline: ");
-
-		for (i =3D 0; i < setup_count; i++)
-			if (!checksetup(&setup[i])) {
-				printk(KERN_ERR "\naha152x: %s\n", setup[i].conf);
-				printk(KERN_ERR "aha152x: invalid line\n");
-			}
-		printk("ok\n");
-	}
-
-#if defined(SETUP0)
-	if (setup_count < ARRAY_SIZE(setup)) {
-		struct aha152x_setup override =3D SETUP0;
-
-		if (setup_count =3D=3D 0 || (override.io_port !=3D setup[0].io_port)) {
-			if (!checksetup(&override)) {
-				printk(KERN_ERR "\naha152x: invalid override SETUP0=3D{0x%x,%d,%d,%d,%=
d,%d,%d,%d}\n",
-				       override.io_port,
-				       override.irq,
-				       override.scsiid,
-				       override.reconnect,
-				       override.parity,
-				       override.synchronous,
-				       override.delay,
-				       override.ext_trans);
-			} else
-				setup[setup_count++] =3D override;
-		}
-	}
-#endif
-
-#if defined(SETUP1)
-	if (setup_count < ARRAY_SIZE(setup)) {
-		struct aha152x_setup override =3D SETUP1;
-
-		if (setup_count =3D=3D 0 || (override.io_port !=3D setup[0].io_port)) {
-			if (!checksetup(&override)) {
-				printk(KERN_ERR "\naha152x: invalid override SETUP1=3D{0x%x,%d,%d,%d,%=
d,%d,%d,%d}\n",
-				       override.io_port,
-				       override.irq,
-				       override.scsiid,
-				       override.reconnect,
-				       override.parity,
-				       override.synchronous,
-				       override.delay,
-				       override.ext_trans);
-			} else
-				setup[setup_count++] =3D override;
-		}
-	}
-#endif
-
-#if defined(MODULE) && !defined(PCMCIA)
-	if (setup_count<ARRAY_SIZE(setup) && (aha152x[0]!=3D0 || io[0]!=3D0 || ir=
q[0]!=3D0)) {
-		if(aha152x[0]!=3D0) {
-			setup[setup_count].conf        =3D "";
-			setup[setup_count].io_port     =3D aha152x[0];
-			setup[setup_count].irq         =3D aha152x[1];
-			setup[setup_count].scsiid      =3D aha152x[2];
-			setup[setup_count].reconnect   =3D aha152x[3];
-			setup[setup_count].parity      =3D aha152x[4];
-			setup[setup_count].synchronous =3D aha152x[5];
-			setup[setup_count].delay       =3D aha152x[6];
-			setup[setup_count].ext_trans   =3D aha152x[7];
-#if defined(AHA152X_DEBUG)
-			setup[setup_count].debug       =3D aha152x[8];
-#endif
-	  	} else if(io[0]!=3D0 || irq[0]!=3D0) {
-			if(io[0]!=3D0)  setup[setup_count].io_port =3D io[0];
-			if(irq[0]!=3D0) setup[setup_count].irq     =3D irq[0];
-
-	    		setup[setup_count].scsiid      =3D scsiid[0];
-	    		setup[setup_count].reconnect   =3D reconnect[0];
-	    		setup[setup_count].parity      =3D parity[0];
-	    		setup[setup_count].synchronous =3D sync[0];
-	    		setup[setup_count].delay       =3D delay[0];
-	    		setup[setup_count].ext_trans   =3D exttrans[0];
-#if defined(AHA152X_DEBUG)
-			setup[setup_count].debug       =3D debug[0];
-#endif
-		}
-
-          	if (checksetup(&setup[setup_count]))
-			setup_count++;
-		else
-			printk(KERN_ERR "aha152x: invalid module params io=3D0x%x, irq=3D%d,scs=
iid=3D%d,reconnect=3D%d,parity=3D%d,sync=3D%d,delay=3D%d,exttrans=3D%d\n",
-			       setup[setup_count].io_port,
-			       setup[setup_count].irq,
-			       setup[setup_count].scsiid,
-			       setup[setup_count].reconnect,
-			       setup[setup_count].parity,
-			       setup[setup_count].synchronous,
-			       setup[setup_count].delay,
-			       setup[setup_count].ext_trans);
-	}
-
-	if (setup_count<ARRAY_SIZE(setup) && (aha152x1[0]!=3D0 || io[1]!=3D0 || i=
rq[1]!=3D0)) {
-		if(aha152x1[0]!=3D0) {
-			setup[setup_count].conf        =3D "";
-			setup[setup_count].io_port     =3D aha152x1[0];
-			setup[setup_count].irq         =3D aha152x1[1];
-			setup[setup_count].scsiid      =3D aha152x1[2];
-			setup[setup_count].reconnect   =3D aha152x1[3];
-			setup[setup_count].parity      =3D aha152x1[4];
-			setup[setup_count].synchronous =3D aha152x1[5];
-			setup[setup_count].delay       =3D aha152x1[6];
-			setup[setup_count].ext_trans   =3D aha152x1[7];
-#if defined(AHA152X_DEBUG)
-			setup[setup_count].debug       =3D aha152x1[8];
-#endif
-	  	} else if(io[1]!=3D0 || irq[1]!=3D0) {
-			if(io[1]!=3D0)  setup[setup_count].io_port =3D io[1];
-			if(irq[1]!=3D0) setup[setup_count].irq     =3D irq[1];
-
-	    		setup[setup_count].scsiid      =3D scsiid[1];
-	    		setup[setup_count].reconnect   =3D reconnect[1];
-	    		setup[setup_count].parity      =3D parity[1];
-	    		setup[setup_count].synchronous =3D sync[1];
-	    		setup[setup_count].delay       =3D delay[1];
-	    		setup[setup_count].ext_trans   =3D exttrans[1];
-#if defined(AHA152X_DEBUG)
-			setup[setup_count].debug       =3D debug[1];
-#endif
-		}
-		if (checksetup(&setup[setup_count]))
-			setup_count++;
-		else
-			printk(KERN_ERR "aha152x: invalid module params io=3D0x%x, irq=3D%d,scs=
iid=3D%d,reconnect=3D%d,parity=3D%d,sync=3D%d,delay=3D%d,exttrans=3D%d\n",
-			       setup[setup_count].io_port,
-			       setup[setup_count].irq,
-			       setup[setup_count].scsiid,
-			       setup[setup_count].reconnect,
-			       setup[setup_count].parity,
-			       setup[setup_count].synchronous,
-			       setup[setup_count].delay,
-			       setup[setup_count].ext_trans);
+	if ( request_irq(shpnt->irq, intr, SA_INTERRUPT|SA_SHIRQ, "aha152x", shpn=
t) ) {
+		printk(KERN_ERR "aha152x%d: failed to reassign irq %d.\n", shpnt->host_n=
o, shpnt->irq);
+		goto out_host_put;
 	}
-#endif
=20
-#ifdef __ISAPNP__
-	while ( setup_count<ARRAY_SIZE(setup) && (dev=3Dpnp_find_dev(NULL, ISAPNP=
_VENDOR('A','D','P'), ISAPNP_FUNCTION(0x1505), dev)) ) {
-		if (pnp_device_attach(dev) < 0)
-			continue;
-		if (pnp_activate_dev(dev) < 0) {
-			pnp_device_detach(dev);
-			continue;
-		}
-		if (!pnp_port_valid(dev, 0)) {
-			pnp_device_detach(dev);
-			continue;
-		}
-		if (setup_count=3D=3D1 && pnp_port_start(dev, 0)=3D=3Dsetup[0].io_port) {
-			pnp_device_detach(dev);
-			continue;
-		}
-		setup[setup_count].io_port     =3D pnp_port_start(dev, 0);
-		setup[setup_count].irq         =3D pnp_irq(dev, 0);
-		setup[setup_count].scsiid      =3D 7;
-		setup[setup_count].reconnect   =3D 1;
-		setup[setup_count].parity      =3D 1;
-		setup[setup_count].synchronous =3D 1;
-		setup[setup_count].delay       =3D DELAY_DEFAULT;
-		setup[setup_count].ext_trans   =3D 0;
-#if defined(AHA152X_DEBUG)
-		setup[setup_count].debug       =3D DEBUG_DEFAULT;
-#endif
-		pnpdev[setup_count]            =3D dev;
-		printk (KERN_INFO
-			"aha152x: found ISAPnP AVA-1505A at io=3D0x%03x, irq=3D%d\n",
-			setup[setup_count].io_port, setup[setup_count].irq);
-		setup_count++;
+	if( scsi_add_host(shpnt, 0) ) {
+		free_irq(shpnt->irq, shpnt);
+		printk(KERN_ERR "aha152x%d: failed to add host.\n", shpnt->host_no);
+		goto out_host_put;
 	}
-#endif
=20
-#if defined(AUTOCONF)
-	if (setup_count<ARRAY_SIZE(setup)) {
-#if !defined(SKIP_BIOSTEST)
-		ok =3D 0;
-		for (i =3D 0; i < ARRAY_SIZE(addresses) && !ok; i++)
-			for (j =3D 0; j<ARRAY_SIZE(signatures) && !ok; j++)
-				ok =3D isa_check_signature(addresses[i] + signatures[j].sig_offset,
-								signatures[j].signature, signatures[j].sig_length);
-
-		if (!ok && setup_count =3D=3D 0)
-			return 0;
-
-		printk(KERN_INFO "aha152x: BIOS test: passed, ");
-#else
-		printk(KERN_INFO "aha152x: ");
-#endif				/* !SKIP_BIOSTEST */
-
-		ok =3D 0;
-		for (i =3D 0; i < ARRAY_SIZE(ports) && setup_count < 2; i++) {
-			if ((setup_count =3D=3D 1) && (setup[0].io_port =3D=3D ports[i]))
-				continue;
-
-			if (aha152x_porttest(ports[i])) {
-				ok++;
-				setup[setup_count].io_port =3D ports[i];
-				setup[setup_count].tc1550  =3D 0;
-
-				conf.cf_port =3D
-				    (GETPORT(ports[i] + O_PORTA) << 8) + GETPORT(ports[i] + O_PORTB);
-
-				setup[setup_count].irq =3D IRQ_MIN + conf.cf_irq;
-				setup[setup_count].scsiid =3D conf.cf_id;
-				setup[setup_count].reconnect =3D conf.cf_tardisc;
-				setup[setup_count].parity =3D !conf.cf_parity;
-				setup[setup_count].synchronous =3D conf.cf_syncneg;
-				setup[setup_count].delay =3D DELAY_DEFAULT;
-				setup[setup_count].ext_trans =3D 0;
-#if defined(AHA152X_DEBUG)
-				setup[setup_count].debug =3D DEBUG_DEFAULT;
-#endif
-				setup_count++;
-			} else if (tc1550_porttest(ports[i])) {
-				ok++;
-				setup[setup_count].io_port =3D ports[i];
-				setup[setup_count].tc1550  =3D 1;
-
-				conf.cf_port =3D
-				    (GETPORT(ports[i] + O_PORTA) << 8) + GETPORT(ports[i] + O_PORTB);
-
-				setup[setup_count].irq =3D IRQ_MIN + conf.cf_irq;
-				setup[setup_count].scsiid =3D conf.cf_id;
-				setup[setup_count].reconnect =3D conf.cf_tardisc;
-				setup[setup_count].parity =3D !conf.cf_parity;
-				setup[setup_count].synchronous =3D conf.cf_syncneg;
-				setup[setup_count].delay =3D DELAY_DEFAULT;
-				setup[setup_count].ext_trans =3D 0;
-#if defined(AHA152X_DEBUG)
-				setup[setup_count].debug =3D DEBUG_DEFAULT;
-#endif
-				setup_count++;
-			}
-		}
+	scsi_scan_host(shpnt);
=20
-		if (ok)
-			printk("auto configuration: ok, ");
-	}
-#endif
+	registered_count++;
=20
-	printk("detected %d controller(s)\n", setup_count);
+	return shpnt;
=20
-	for (i=3D0; i<setup_count; i++) {
-		aha152x_probe_one(&setup[i]);
-		if (aha152x_host[registered_count]) {
-#ifdef __ISAPNP__
-			if(pnpdev[i])
-				HOSTDATA(aha152x_host[registered_count])->pnpdev=3Dpnpdev[i];
-#endif
-			registered_count++;
-		}
-	}
+out_host_put:
+	aha152x_host[registered_count]=3D0;
+	scsi_host_put(shpnt);
=20
-	return registered_count>0;
+	return 0;
 }
=20
-static int aha152x_release(struct Scsi_Host *shpnt)
+void aha152x_release(struct Scsi_Host *shpnt)
 {
+	if(!shpnt)
+		return;
+
 	if (shpnt->irq)
 		free_irq(shpnt->irq, shpnt);
=20
+#if !defined(PCMCIA)
 	if (shpnt->io_port)
 		release_region(shpnt->io_port, IO_RANGE);
+#endif
=20
 #ifdef __ISAPNP__
 	if (HOSTDATA(shpnt)->pnpdev)
 		pnp_device_detach(HOSTDATA(shpnt)->pnpdev);
 #endif
=20
+	scsi_remove_host(shpnt);
 	scsi_host_put(shpnt);
-
-	return 0;
-}
-
-static void __exit aha152x_exit(void)
-{
-	int i;
-
-	for(i=3D0; i<ARRAY_SIZE(setup); i++) {
-		if(aha152x_host[i]) {
-			scsi_remove_host(aha152x_host[i]);
-			aha152x_release(aha152x_host[i]);
-			aha152x_host[i]=3D0;
-		}
-	}
 }
=20
=20
@@ -1446,8 +985,8 @@ static int aha152x_internal_queue(Scsi_C
=20
 #if defined(AHA152X_DEBUG)
 	if (HOSTDATA(shpnt)->debug & debug_queue) {
-		printk(INFO_LEAD "queue: cmd_len=3D%d pieces=3D%d size=3D%u cmnd=3D",
-		       CMDINFO(SCpnt), SCpnt->cmd_len, SCpnt->use_sg, SCpnt->request_buf=
flen);
+		printk(INFO_LEAD "queue: %p; cmd_len=3D%d pieces=3D%d size=3D%u cmnd=3D",
+		       CMDINFO(SCpnt), SCpnt, SCpnt->cmd_len, SCpnt->use_sg, SCpnt->requ=
est_bufflen);
 		print_command(SCpnt->cmnd);
 	}
 #endif
@@ -1466,7 +1005,7 @@ static int aha152x_internal_queue(Scsi_C
 			return FAILED;
 		}
 	} else {
-		SCpnt->host_scribble    =3D kmalloc(sizeof(struct aha152x_scdata), GFP_A=
TOMIC);
+		SCpnt->host_scribble =3D kmalloc(sizeof(struct aha152x_scdata), GFP_ATOM=
IC);
 		if(SCpnt->host_scribble=3D=3D0) {
 			printk(ERR_LEAD "allocation failed\n", CMDINFO(SCpnt));
 			return FAILED;
@@ -1561,11 +1100,6 @@ static int aha152x_abort(Scsi_Cmnd *SCpn
 	Scsi_Cmnd *ptr;
 	unsigned long flags;
=20
-	if(!shpnt) {
-		printk(ERR_LEAD "abort(%p): no host structure\n", CMDINFO(SCpnt), SCpnt);
-		return FAILED;
-	}
-
 #if defined(AHA152X_DEBUG)
 	if(HOSTDATA(shpnt)->debug & debug_eh) {
 		printk(DEBUG_LEAD "abort(%p)", CMDINFO(SCpnt), SCpnt);
@@ -1608,33 +1142,52 @@ static int aha152x_abort(Scsi_Cmnd *SCpn
 static void timer_expired(unsigned long p)
 {
 	Scsi_Cmnd	 *SCp   =3D (Scsi_Cmnd *)p;
-	struct semaphore *sem   =3D SCSEM(SCp);
-	struct Scsi_Host *shpnt =3D SCp->device->host;
+	struct semaphore *sem;
+	struct Scsi_Host *shpnt;
+	unsigned long flags;
=20
-	/* remove command from issue queue */
-	if(remove_SC(&ISSUE_SC, SCp)) {
-		printk(KERN_INFO "aha152x: ABORT timed out - removed from issue queue\n"=
);
-		kfree(SCp->host_scribble);
-		SCp->host_scribble=3D0;
-	} else {
-		printk(KERN_INFO "aha152x: ABORT timed out - not on issue queue\n");
+	if(SCp=3D=3D0) {
+		printk(KERN_ERR "timer_expired: command not set\n");
+		return;
 	}
=20
-	up(sem);
+	if(SCp->host_scribble=3D=3D0) {
+		printk(KERN_ERR "timer_expired: host_scribble not set\n");
+		return;
+	}
+
+	if(SCp->device=3D=3D0) {
+		printk(KERN_ERR "timer_expired: device not set\n");
+		return;
+	}
+	=09
+	shpnt =3D SCp->device->host;
+
+	if(shpnt=3D=3D0) {
+		printk(KERN_ERR "timer_expired: host not set\n");
+		return;
+	}
+
+ 	sem =3D SCSEM(SCp);
+
+	if(sem) {
+		up(sem);
+	} else {
+		printk(KERN_ERR "timer_expired: semaphore not set\n");
+	}
 }
=20
 /*
  * Reset a device
  *
- * FIXME: never seen this live. might lockup...
- *
  */
 static int aha152x_device_reset(Scsi_Cmnd * SCpnt)
 {
 	struct Scsi_Host *shpnt =3D SCpnt->device->host;
 	DECLARE_MUTEX_LOCKED(sem);
 	struct timer_list timer;
-	int ret;
+	int ret, issued, disconnected;
+	unsigned long flags;
=20
 #if defined(AHA152X_DEBUG)
 	if(HOSTDATA(shpnt)->debug & debug_eh) {
@@ -1648,13 +1201,18 @@ static int aha152x_device_reset(Scsi_Cmn
 		return FAILED;
 	}
=20
+	DO_LOCK(flags);
+	issued       =3D remove_SC(&ISSUE_SC, SCpnt)=3D=3D0;
+	disconnected =3D issued && remove_SC(&DISCONNECTED_SC, SCpnt);
+	DO_UNLOCK(flags);
+
 	SCpnt->cmd_len         =3D 0;
 	SCpnt->use_sg          =3D 0;
 	SCpnt->request_buffer  =3D 0;
 	SCpnt->request_bufflen =3D 0;
=20
 	init_timer(&timer);
-	timer.data     =3D (unsigned long) cmd;
+	timer.data     =3D (unsigned long) SCpnt;
 	timer.expires  =3D jiffies + 100*HZ;   /* 10s */
 	timer.function =3D (void (*)(unsigned long)) timer_expired;
=20
@@ -1662,18 +1220,36 @@ static int aha152x_device_reset(Scsi_Cmn
 	add_timer(&timer);
 	down(&sem);
 	del_timer(&timer);
-
+=09
 	SCpnt->cmd_len         =3D SCpnt->old_cmd_len;
 	SCpnt->use_sg          =3D SCpnt->old_use_sg;
   	SCpnt->request_buffer  =3D SCpnt->buffer;
        	SCpnt->request_bufflen =3D SCpnt->bufflen;
=20
+	DO_LOCK(flags);
+
 	if(SCpnt->SCp.phase & resetted) {
+		HOSTDATA(shpnt)->commands--;
+		if (!HOSTDATA(shpnt)->commands)
+			SETPORT(PORTA, 0);
+		kfree(SCpnt->host_scribble);
+		SCpnt->host_scribble=3D0;
+
 		ret =3D SUCCESS;
 	} else {
+		/* requeue */
+		if(!issued) {
+			append_SC(&ISSUE_SC, SCpnt);
+		} else if(disconnected) {
+			remove_SC(&ISSUE_SC, SCpnt);
+			append_SC(&DISCONNECTED_SC, SCpnt);
+		}
+=09
 		ret =3D FAILED;
 	}
=20
+	DO_UNLOCK(flags);
+
 	spin_lock_irq(shpnt->host_lock);
 	return ret;
 }
@@ -1681,13 +1257,17 @@ static int aha152x_device_reset(Scsi_Cmn
 static void free_hard_reset_SCs(struct Scsi_Host *shpnt, Scsi_Cmnd **SCs)
 {
 	Scsi_Cmnd *ptr;
-	unsigned long flags;
-
-	DO_LOCK(flags);
=20
 	ptr=3D*SCs;
 	while(ptr) {
-		Scsi_Cmnd *next =3D SCNEXT(ptr);
+		Scsi_Cmnd *next;
+
+		if(SCDATA(ptr)) {
+			next =3D SCNEXT(ptr);
+		} else {
+			printk(DEBUG_LEAD "queue corrupted at %p\n", CMDINFO(ptr), ptr);
+			next =3D 0;
+		}
=20
 		if (!ptr->device->soft_reset) {
 			DPRINTK(debug_eh, DEBUG_LEAD "disconnected command %p removed\n", CMDIN=
FO(ptr), ptr);
@@ -1699,8 +1279,6 @@ static void free_hard_reset_SCs(struct S
=20
 		ptr =3D next;
 	}
-
-	DO_UNLOCK(flags);
 }
=20
 /*
@@ -1712,6 +1290,8 @@ static int aha152x_bus_reset(Scsi_Cmnd *
 	struct Scsi_Host *shpnt =3D SCpnt->device->host;
 	unsigned long flags;
=20
+	DO_LOCK(flags);
+
 #if defined(AHA152X_DEBUG)
 	if(HOSTDATA(shpnt)->debug & debug_eh) {
 		printk(DEBUG_LEAD "aha152x_bus_reset(%p)", CMDINFO(SCpnt), SCpnt);
@@ -1729,12 +1309,12 @@ static int aha152x_bus_reset(Scsi_Cmnd *
 	SETPORT(SCSISEQ, 0);
 	mdelay(DELAY);
=20
-	DPRINTK(debug_eh, DEBUG_LEAD "bus reset returns\n", CMDINFO(SCpnt));
+	DPRINTK(debug_eh, DEBUG_LEAD "bus resetted\n", CMDINFO(SCpnt));
=20
-	DO_LOCK(flags);
 	setup_expected_interrupts(shpnt);
 	if(HOSTDATA(shpnt)->commands=3D=3D0)
 		SETPORT(PORTA, 0);
+
 	DO_UNLOCK(flags);
=20
 	return SUCCESS;
@@ -2000,6 +1580,7 @@ static void busfree_run(struct Scsi_Host
 #if defined(AHA152X_STAT)
 		action++;
 #endif
+
 		if(DONE_SC->SCp.phase & check_condition) {
 #if 0
 			if(HOSTDATA(shpnt)->debug & debug_eh) {
@@ -2029,47 +1610,57 @@ static void busfree_run(struct Scsi_Host
 #endif
=20
 			if(!(DONE_SC->SCp.Status & not_issued)) {
+				Scsi_Cmnd *ptr =3D DONE_SC;
+				DONE_SC=3D0;
 #if 0
-				DPRINTK(debug_eh, ERR_LEAD "requesting sense\n", CMDINFO(DONE_SC));
+				DPRINTK(debug_eh, ERR_LEAD "requesting sense\n", CMDINFO(ptr));
 #endif
=20
-				DONE_SC->cmnd[0]         =3D REQUEST_SENSE;
-				DONE_SC->cmnd[1]         =3D 0;
-				DONE_SC->cmnd[2]         =3D 0;
-				DONE_SC->cmnd[3]         =3D 0;
-				DONE_SC->cmnd[4]         =3D sizeof(DONE_SC->sense_buffer);
-				DONE_SC->cmnd[5]         =3D 0;
-				DONE_SC->cmd_len         =3D 6;
-				DONE_SC->use_sg          =3D 0;=20
-				DONE_SC->request_buffer  =3D DONE_SC->sense_buffer;
-				DONE_SC->request_bufflen =3D sizeof(DONE_SC->sense_buffer);
+				ptr->cmnd[0]         =3D REQUEST_SENSE;
+				ptr->cmnd[1]         =3D 0;
+				ptr->cmnd[2]         =3D 0;
+				ptr->cmnd[3]         =3D 0;
+				ptr->cmnd[4]         =3D sizeof(ptr->sense_buffer);
+				ptr->cmnd[5]         =3D 0;
+				ptr->cmd_len         =3D 6;
+				ptr->use_sg          =3D 0;=20
+				ptr->request_buffer  =3D ptr->sense_buffer;
+				ptr->request_bufflen =3D sizeof(ptr->sense_buffer);
 		=09
 				DO_UNLOCK(flags);
-				aha152x_internal_queue(DONE_SC, 0, check_condition, DONE_SC->scsi_done=
);
+				aha152x_internal_queue(ptr, 0, check_condition, ptr->scsi_done);
 				DO_LOCK(flags);
-
-				DONE_SC=3D0;
-			} else {
 #if 0
+			} else {
 				DPRINTK(debug_eh, ERR_LEAD "command not issued - CHECK CONDITION ignor=
ed\n", CMDINFO(DONE_SC));
 #endif
 			}
 		}
=20
 		if(DONE_SC && DONE_SC->scsi_done) {
+#if defined(AHA152X_DEBUG)
+			int hostno=3DDONE_SC->device->host->host_no;
+			int id=3DDONE_SC->device->id & 0xf;
+			int lun=3DDONE_SC->device->lun & 0x7;
+#endif
+			Scsi_Cmnd *ptr =3D DONE_SC;
+			DONE_SC=3D0;
+
 			/* turn led off, when no commands are in the driver */
 			HOSTDATA(shpnt)->commands--;
 			if (!HOSTDATA(shpnt)->commands)
 				SETPORT(PORTA, 0);	/* turn led off */
=20
+			if(ptr->scsi_done !=3D reset_done) {
+				kfree(ptr->host_scribble);
+				ptr->host_scribble=3D0;
+			}
+
 			DO_UNLOCK(flags);
-			DPRINTK(debug_done, DEBUG_LEAD "calling scsi_done(%p)\n", CMDINFO(DONE_=
SC), DONE_SC);
-                	DONE_SC->scsi_done(DONE_SC);
-			DPRINTK(debug_done, DEBUG_LEAD "scsi_done(%p) returned\n", CMDINFO(DONE=
_SC), DONE_SC);
+			DPRINTK(debug_done, DEBUG_LEAD "calling scsi_done(%p)\n", hostno, id, l=
un, ptr);
+                	ptr->scsi_done(ptr);
+			DPRINTK(debug_done, DEBUG_LEAD "scsi_done(%p) returned\n", hostno, id, =
lun, ptr);
 			DO_LOCK(flags);
-
-			kfree(DONE_SC->host_scribble);
-			DONE_SC->host_scribble=3D0;
 		}
=20
 		DONE_SC=3D0;
@@ -2936,11 +2527,11 @@ static void rsti_run(struct Scsi_Host *s
 		if (!ptr->device->soft_reset) {
 			remove_SC(&DISCONNECTED_SC, ptr);
=20
-			ptr->result =3D  DID_RESET << 16;
-			ptr->scsi_done(ptr);
-
 			kfree(ptr->host_scribble);
 			ptr->host_scribble=3D0;
+
+			ptr->result =3D  DID_RESET << 16;
+			ptr->scsi_done(ptr);
 		}
=20
 		ptr =3D next;
@@ -3382,7 +2973,11 @@ static void show_command(Scsi_Cmnd *ptr)
 		printk("aborted|");
 	if (ptr->SCp.phase & resetted)
 		printk("resetted|");
-	printk("; next=3D0x%p\n", SCNEXT(ptr));
+	if( SCDATA(ptr) ) {
+		printk("; next=3D0x%p\n", SCNEXT(ptr));
+	} else {
+		printk("; next=3D(host scribble NULL)\n");
+	}
 }
=20
 /*
@@ -3406,7 +3001,7 @@ static void show_queues(struct Scsi_Host
 		printk(KERN_DEBUG "none\n");
=20
 	printk(KERN_DEBUG "disconnected_SC:\n");
-	for (ptr =3D DISCONNECTED_SC; ptr; ptr =3D SCNEXT(ptr))
+	for (ptr =3D DISCONNECTED_SC; ptr; ptr =3D SCDATA(ptr) ? SCNEXT(ptr) : 0)
 		show_command(ptr);
=20
 	disp_ports(shpnt);
@@ -3914,7 +3509,494 @@ static Scsi_Host_Template aha152x_driver
 	.use_clustering			=3D DISABLE_CLUSTERING,
 };
=20
-#ifndef PCMCIA
+#if !defined(PCMCIA)
+static int setup_count;
+static struct aha152x_setup setup[2];
+
+/* possible i/o addresses for the AIC-6260; default first */
+static unsigned short ports[] =3D { 0x340, 0x140 };
+
+#if !defined(SKIP_BIOSTEST)
+/* possible locations for the Adaptec BIOS; defaults first */
+static unsigned int addresses[] =3D
+{
+	0xdc000,		/* default first */
+	0xc8000,
+	0xcc000,
+	0xd0000,
+	0xd4000,
+	0xd8000,
+	0xe0000,
+	0xeb800,		/* VTech Platinum SMP */
+	0xf0000,
+};
+
+/* signatures for various AIC-6[23]60 based controllers.
+   The point in detecting signatures is to avoid useless and maybe
+   harmful probes on ports. I'm not sure that all listed boards pass
+   auto-configuration. For those which fail the BIOS signature is
+   obsolete, because user intervention to supply the configuration is
+   needed anyway.  May be an information whether or not the BIOS supports
+   extended translation could be also useful here. */
+static struct signature {
+	unsigned char *signature;
+	int sig_offset;
+	int sig_length;
+} signatures[] =3D
+{
+	{ "Adaptec AHA-1520 BIOS",	0x102e, 21 },
+		/* Adaptec 152x */
+	{ "Adaptec AHA-1520B",		0x000b, 17 },
+		/* Adaptec 152x rev B */
+	{ "Adaptec AHA-1520B",		0x0026, 17 },
+		/* Iomega Jaz Jet ISA (AIC6370Q) */
+	{ "Adaptec ASW-B626 BIOS",	0x1029, 21 },
+		/* on-board controller */
+	{ "Adaptec BIOS: ASW-B626",	0x000f, 22 },
+		/* on-board controller */
+	{ "Adaptec ASW-B626 S2",	0x2e6c, 19 },
+		/* on-board controller */
+	{ "Adaptec BIOS:AIC-6360",	0x000c, 21 },
+		/* on-board controller */
+	{ "ScsiPro SP-360 BIOS",	0x2873, 19 },
+		/* ScsiPro-Controller  */
+	{ "GA-400 LOCAL BUS SCSI BIOS", 0x102e, 26 },
+		/* Gigabyte Local-Bus-SCSI */
+	{ "Adaptec BIOS:AVA-282X",	0x000c, 21 },
+		/* Adaptec 282x */
+	{ "Adaptec IBM Dock II SCSI",   0x2edd, 24 },
+		/* IBM Thinkpad Dock II */
+	{ "Adaptec BIOS:AHA-1532P",     0x001c, 22 },
+		/* IBM Thinkpad Dock II SCSI */
+	{ "DTC3520A Host Adapter BIOS", 0x318a, 26 },
+		/* DTC 3520A ISA SCSI */
+};
+#endif /* !SKIP_BIOSTEST */
+
+/*
+ * Test, if port_base is valid.
+ *
+ */
+static int aha152x_porttest(int io_port)
+{
+	int i;
+
+	SETPORT(io_port + O_DMACNTRL1, 0);	/* reset stack pointer */
+	for (i =3D 0; i < 16; i++)
+		SETPORT(io_port + O_STACK, i);
+
+	SETPORT(io_port + O_DMACNTRL1, 0);	/* reset stack pointer */
+	for (i =3D 0; i < 16 && GETPORT(io_port + O_STACK) =3D=3D i; i++)
+		;
+
+	return (i =3D=3D 16);
+}
+
+static int tc1550_porttest(int io_port)
+{
+	int i;
+
+	SETPORT(io_port + O_TC_DMACNTRL1, 0);	/* reset stack pointer */
+	for (i =3D 0; i < 16; i++)
+		SETPORT(io_port + O_STACK, i);
+
+	SETPORT(io_port + O_TC_DMACNTRL1, 0);	/* reset stack pointer */
+	for (i =3D 0; i < 16 && GETPORT(io_port + O_TC_STACK) =3D=3D i; i++)
+		;
+
+	return (i =3D=3D 16);
+}
+
+
+static int checksetup(struct aha152x_setup *setup)
+{
+	int i;
+	for (i =3D 0; i < ARRAY_SIZE(ports) && (setup->io_port !=3D ports[i]); i+=
+)
+		;
+
+	if (i =3D=3D ARRAY_SIZE(ports))
+		return 0;
+
+	if ( request_region(setup->io_port, IO_RANGE, "aha152x")=3D=3D0 ) {
+		printk(KERN_ERR "aha152x: io port 0x%x busy.\n", setup->io_port);
+		return 0;
+	}
+
+	if( aha152x_porttest(setup->io_port) ) {
+		setup->tc1550=3D0;
+	} else if( tc1550_porttest(setup->io_port) ) {
+		setup->tc1550=3D1;
+	} else {
+		release_region(setup->io_port, IO_RANGE);
+		return 0;
+	}
+
+	release_region(setup->io_port, IO_RANGE);
+
+	if ((setup->irq < IRQ_MIN) || (setup->irq > IRQ_MAX))
+		return 0;
+
+	if ((setup->scsiid < 0) || (setup->scsiid > 7))
+		return 0;
+
+	if ((setup->reconnect < 0) || (setup->reconnect > 1))
+		return 0;
+
+	if ((setup->parity < 0) || (setup->parity > 1))
+		return 0;
+
+	if ((setup->synchronous < 0) || (setup->synchronous > 1))
+		return 0;
+
+	if ((setup->ext_trans < 0) || (setup->ext_trans > 1))
+		return 0;
+
+
+	return 1;
+}
+
+
+static int __init aha152x_init(void)
+{
+	int i, j, ok;
+#if defined(AUTOCONF)
+	aha152x_config conf;
+#endif
+#ifdef __ISAPNP__
+	struct pnp_dev *dev=3D0, *pnpdev[2] =3D {0, 0};
+#endif
+
+	if ( setup_count ) {
+		printk(KERN_INFO "aha152x: processing commandline: ");
+
+		for (i =3D 0; i<setup_count; i++) {
+			if (!checksetup(&setup[i])) {
+				printk(KERN_ERR "\naha152x: %s\n", setup[i].conf);
+				printk(KERN_ERR "aha152x: invalid line\n");
+			}
+		}
+		printk("ok\n");
+	}
+
+#if defined(SETUP0)
+	if (setup_count < ARRAY_SIZE(setup)) {
+		struct aha152x_setup override =3D SETUP0;
+
+		if (setup_count =3D=3D 0 || (override.io_port !=3D setup[0].io_port)) {
+			if (!checksetup(&override)) {
+				printk(KERN_ERR "\naha152x: invalid override SETUP0=3D{0x%x,%d,%d,%d,%=
d,%d,%d,%d}\n",
+				       override.io_port,
+				       override.irq,
+				       override.scsiid,
+				       override.reconnect,
+				       override.parity,
+				       override.synchronous,
+				       override.delay,
+				       override.ext_trans);
+			} else
+				setup[setup_count++] =3D override;
+		}
+	}
+#endif
+
+#if defined(SETUP1)
+	if (setup_count < ARRAY_SIZE(setup)) {
+		struct aha152x_setup override =3D SETUP1;
+
+		if (setup_count =3D=3D 0 || (override.io_port !=3D setup[0].io_port)) {
+			if (!checksetup(&override)) {
+				printk(KERN_ERR "\naha152x: invalid override SETUP1=3D{0x%x,%d,%d,%d,%=
d,%d,%d,%d}\n",
+				       override.io_port,
+				       override.irq,
+				       override.scsiid,
+				       override.reconnect,
+				       override.parity,
+				       override.synchronous,
+				       override.delay,
+				       override.ext_trans);
+			} else
+				setup[setup_count++] =3D override;
+		}
+	}
+#endif
+
+#if defined(MODULE)
+	if (setup_count<ARRAY_SIZE(setup) && (aha152x[0]!=3D0 || io[0]!=3D0 || ir=
q[0]!=3D0)) {
+		if(aha152x[0]!=3D0) {
+			setup[setup_count].conf        =3D "";
+			setup[setup_count].io_port     =3D aha152x[0];
+			setup[setup_count].irq         =3D aha152x[1];
+			setup[setup_count].scsiid      =3D aha152x[2];
+			setup[setup_count].reconnect   =3D aha152x[3];
+			setup[setup_count].parity      =3D aha152x[4];
+			setup[setup_count].synchronous =3D aha152x[5];
+			setup[setup_count].delay       =3D aha152x[6];
+			setup[setup_count].ext_trans   =3D aha152x[7];
+#if defined(AHA152X_DEBUG)
+			setup[setup_count].debug       =3D aha152x[8];
+#endif
+	  	} else if(io[0]!=3D0 || irq[0]!=3D0) {
+			if(io[0]!=3D0)  setup[setup_count].io_port =3D io[0];
+			if(irq[0]!=3D0) setup[setup_count].irq     =3D irq[0];
+
+	    		setup[setup_count].scsiid      =3D scsiid[0];
+	    		setup[setup_count].reconnect   =3D reconnect[0];
+	    		setup[setup_count].parity      =3D parity[0];
+	    		setup[setup_count].synchronous =3D sync[0];
+	    		setup[setup_count].delay       =3D delay[0];
+	    		setup[setup_count].ext_trans   =3D exttrans[0];
+#if defined(AHA152X_DEBUG)
+			setup[setup_count].debug       =3D debug[0];
+#endif
+		}
+
+          	if (checksetup(&setup[setup_count]))
+			setup_count++;
+		else
+			printk(KERN_ERR "aha152x: invalid module params io=3D0x%x, irq=3D%d,scs=
iid=3D%d,reconnect=3D%d,parity=3D%d,sync=3D%d,delay=3D%d,exttrans=3D%d\n",
+			       setup[setup_count].io_port,
+			       setup[setup_count].irq,
+			       setup[setup_count].scsiid,
+			       setup[setup_count].reconnect,
+			       setup[setup_count].parity,
+			       setup[setup_count].synchronous,
+			       setup[setup_count].delay,
+			       setup[setup_count].ext_trans);
+	}
+
+	if (setup_count<ARRAY_SIZE(setup) && (aha152x1[0]!=3D0 || io[1]!=3D0 || i=
rq[1]!=3D0)) {
+		if(aha152x1[0]!=3D0) {
+			setup[setup_count].conf        =3D "";
+			setup[setup_count].io_port     =3D aha152x1[0];
+			setup[setup_count].irq         =3D aha152x1[1];
+			setup[setup_count].scsiid      =3D aha152x1[2];
+			setup[setup_count].reconnect   =3D aha152x1[3];
+			setup[setup_count].parity      =3D aha152x1[4];
+			setup[setup_count].synchronous =3D aha152x1[5];
+			setup[setup_count].delay       =3D aha152x1[6];
+			setup[setup_count].ext_trans   =3D aha152x1[7];
+#if defined(AHA152X_DEBUG)
+			setup[setup_count].debug       =3D aha152x1[8];
+#endif
+	  	} else if(io[1]!=3D0 || irq[1]!=3D0) {
+			if(io[1]!=3D0)  setup[setup_count].io_port =3D io[1];
+			if(irq[1]!=3D0) setup[setup_count].irq     =3D irq[1];
+
+	    		setup[setup_count].scsiid      =3D scsiid[1];
+	    		setup[setup_count].reconnect   =3D reconnect[1];
+	    		setup[setup_count].parity      =3D parity[1];
+	    		setup[setup_count].synchronous =3D sync[1];
+	    		setup[setup_count].delay       =3D delay[1];
+	    		setup[setup_count].ext_trans   =3D exttrans[1];
+#if defined(AHA152X_DEBUG)
+			setup[setup_count].debug       =3D debug[1];
+#endif
+		}
+		if (checksetup(&setup[setup_count]))
+			setup_count++;
+		else
+			printk(KERN_ERR "aha152x: invalid module params io=3D0x%x, irq=3D%d,scs=
iid=3D%d,reconnect=3D%d,parity=3D%d,sync=3D%d,delay=3D%d,exttrans=3D%d\n",
+			       setup[setup_count].io_port,
+			       setup[setup_count].irq,
+			       setup[setup_count].scsiid,
+			       setup[setup_count].reconnect,
+			       setup[setup_count].parity,
+			       setup[setup_count].synchronous,
+			       setup[setup_count].delay,
+			       setup[setup_count].ext_trans);
+	}
+#endif
+
+#ifdef __ISAPNP__
+	for(i=3D0; setup_count<ARRAY_SIZE(setup) && id_table[i].vendor; i++) {
+		while ( setup_count<ARRAY_SIZE(setup) &&
+			(dev=3Dpnp_find_dev(NULL, id_table[i].vendor, id_table[i].function, dev=
)) ) {
+			if (pnp_device_attach(dev) < 0)
+				continue;
+
+			if (pnp_activate_dev(dev) < 0) {
+				pnp_device_detach(dev);
+				continue;
+			}
+
+			if (!pnp_port_valid(dev, 0)) {
+				pnp_device_detach(dev);
+				continue;
+			}
+
+			if (setup_count=3D=3D1 && pnp_port_start(dev, 0)=3D=3Dsetup[0].io_port)=
 {
+				pnp_device_detach(dev);
+				continue;
+			}
+
+			setup[setup_count].io_port     =3D pnp_port_start(dev, 0);
+			setup[setup_count].irq         =3D pnp_irq(dev, 0);
+			setup[setup_count].scsiid      =3D 7;
+			setup[setup_count].reconnect   =3D 1;
+			setup[setup_count].parity      =3D 1;
+			setup[setup_count].synchronous =3D 1;
+			setup[setup_count].delay       =3D DELAY_DEFAULT;
+			setup[setup_count].ext_trans   =3D 0;
+#if defined(AHA152X_DEBUG)
+			setup[setup_count].debug       =3D DEBUG_DEFAULT;
+#endif
+#if defined(__ISAPNP__)
+			pnpdev[setup_count]            =3D dev;
+#endif
+			printk (KERN_INFO
+				"aha152x: found ISAPnP adapter at io=3D0x%03x, irq=3D%d\n",
+				setup[setup_count].io_port, setup[setup_count].irq);
+			setup_count++;
+		}
+	}
+#endif
+
+#if defined(AUTOCONF)
+	if (setup_count<ARRAY_SIZE(setup)) {
+#if !defined(SKIP_BIOSTEST)
+		ok =3D 0;
+		for (i =3D 0; i < ARRAY_SIZE(addresses) && !ok; i++)
+			for (j =3D 0; j<ARRAY_SIZE(signatures) && !ok; j++)
+				ok =3D isa_check_signature(addresses[i] + signatures[j].sig_offset,
+								signatures[j].signature, signatures[j].sig_length);
+		if (!ok && setup_count =3D=3D 0)
+			return 0;
+
+		printk(KERN_INFO "aha152x: BIOS test: passed, ");
+#else
+		printk(KERN_INFO "aha152x: ");
+#endif				/* !SKIP_BIOSTEST */
+
+		ok =3D 0;
+		for (i =3D 0; i < ARRAY_SIZE(ports) && setup_count < 2; i++) {
+			if ((setup_count =3D=3D 1) && (setup[0].io_port =3D=3D ports[i]))
+				continue;
+
+			if ( request_region(ports[i], IO_RANGE, "aha152x")=3D=3D0 ) {
+				printk(KERN_ERR "aha152x: io port 0x%x busy.\n", ports[i]);
+				continue;
+			}
+
+			if (aha152x_porttest(ports[i])) {
+				setup[setup_count].tc1550  =3D 0;
+
+				conf.cf_port =3D
+				    (GETPORT(ports[i] + O_PORTA) << 8) + GETPORT(ports[i] + O_PORTB);
+			} else if (tc1550_porttest(ports[i])) {
+				setup[setup_count].tc1550  =3D 1;
+
+				conf.cf_port =3D
+				    (GETPORT(ports[i] + O_TC_PORTA) << 8) + GETPORT(ports[i] + O_TC_PO=
RTB);
+			} else {
+				release_region(ports[i], IO_RANGE);
+				continue;
+			}
+
+			release_region(ports[i], IO_RANGE);
+
+			ok++;
+			setup[setup_count].io_port =3D ports[i];
+			setup[setup_count].irq =3D IRQ_MIN + conf.cf_irq;
+			setup[setup_count].scsiid =3D conf.cf_id;
+			setup[setup_count].reconnect =3D conf.cf_tardisc;
+			setup[setup_count].parity =3D !conf.cf_parity;
+			setup[setup_count].synchronous =3D conf.cf_syncneg;
+			setup[setup_count].delay =3D DELAY_DEFAULT;
+			setup[setup_count].ext_trans =3D 0;
+#if defined(AHA152X_DEBUG)
+			setup[setup_count].debug =3D DEBUG_DEFAULT;
+#endif
+			setup_count++;
+
+		}
+
+		if (ok)
+			printk("auto configuration: ok, ");
+	}
+#endif
+
+	printk("%d controller(s) configured\n", setup_count);
+
+	for (i=3D0; i<setup_count; i++) {
+		if ( request_region(setup[i].io_port, IO_RANGE, "aha152x") ) {
+			struct Scsi_Host *shpnt =3D aha152x_probe_one(&setup[i]);
+
+			if( !shpnt ) {
+				release_region(setup[i].io_port, IO_RANGE);
+#if defined(__ISAPNP__)
+			} else if( pnpdev[i] ) {
+				HOSTDATA(shpnt)->pnpdev=3Dpnpdev[i];
+				pnpdev[i]=3D0;
+#endif
+			}
+		} else {
+			printk(KERN_ERR "aha152x: io port 0x%x busy.\n", setup[i].io_port);
+		}
+
+#if defined(__ISAPNP__)
+		if( pnpdev[i] )
+			pnp_device_detach(pnpdev[i]);
+#endif
+	}
+
+	return registered_count>0;
+}
+
+static void __exit aha152x_exit(void)
+{
+	int i;
+
+	for(i=3D0; i<ARRAY_SIZE(setup); i++) {
+		aha152x_release(aha152x_host[i]);
+		aha152x_host[i]=3D0;
+	}
+}
+
 module_init(aha152x_init);
 module_exit(aha152x_exit);
+
+#if !defined(MODULE)
+static int __init aha152x_setup(char *str)
+{
+#if defined(AHA152X_DEBUG)
+	int ints[11];
+#else
+	int ints[10];
+#endif
+	get_options(str, ARRAY_SIZE(ints), ints);
+
+	if(setup_count>=3DARRAY_SIZE(setup)) {
+		printk(KERN_ERR "aha152x: you can only configure up to two controllers\n=
");
+		return 1;
+	}
+
+	setup[setup_count].conf        =3D str;
+	setup[setup_count].io_port     =3D ints[0] >=3D 1 ? ints[1] : 0x340;
+	setup[setup_count].irq         =3D ints[0] >=3D 2 ? ints[2] : 11;
+	setup[setup_count].scsiid      =3D ints[0] >=3D 3 ? ints[3] : 7;
+	setup[setup_count].reconnect   =3D ints[0] >=3D 4 ? ints[4] : 1;
+	setup[setup_count].parity      =3D ints[0] >=3D 5 ? ints[5] : 1;
+	setup[setup_count].synchronous =3D ints[0] >=3D 6 ? ints[6] : 1;
+	setup[setup_count].delay       =3D ints[0] >=3D 7 ? ints[7] : DELAY_DEFAU=
LT;
+	setup[setup_count].ext_trans   =3D ints[0] >=3D 8 ? ints[8] : 0;
+#if defined(AHA152X_DEBUG)
+	setup[setup_count].debug       =3D ints[0] >=3D 9 ? ints[9] : DEBUG_DEFAU=
LT;
+	if (ints[0] > 9) {
+		printk(KERN_NOTICE "aha152x: usage: aha152x=3D<IOBASE>[,<IRQ>[,<SCSI ID>"
+		       "[,<RECONNECT>[,<PARITY>[,<SYNCHRONOUS>[,<DELAY>[,<EXT_TRANS>[,<D=
EBUG>]]]]]]]]\n");
+#else
+	if (ints[0] > 8) {                                                /*}*/
+		printk(KERN_NOTICE "aha152x: usage: aha152x=3D<IOBASE>[,<IRQ>[,<SCSI ID>"
+		       "[,<RECONNECT>[,<PARITY>[,<SYNCHRONOUS>[,<DELAY>[,<EXT_TRANS>]]]]=
]]]\n");
 #endif
+	} else {
+		setup_count++;
+		return 0;
+	}
+
+	return 1;
+}
+__setup("aha152x=3D", aha152x_setup);
+#endif
+
+#endif /* !PCMCIA */
diff -uprd orig/linux-2.6.2-rc2/drivers/scsi/aha152x.h linux-2.6.2-rc2/driv=
ers/scsi/aha152x.h
--- orig/linux-2.6.2-rc2/drivers/scsi/aha152x.h	2003-12-18 03:59:05.0000000=
00 +0100
+++ linux-2.6.2-rc2/drivers/scsi/aha152x.h	2004-01-24 12:45:17.000000000 +0=
100
@@ -2,14 +2,14 @@
 #define _AHA152X_H
=20
 /*
- * $Id: aha152x.h,v 2.5 2002/04/14 11:24:12 fischer Exp $
+ * $Id: aha152x.h,v 2.7 2004/01/24 11:39:03 fischer Exp $
  */
=20
 /* number of queueable commands
    (unless we support more than 1 cmd_per_lun this should do) */
 #define AHA152X_MAXQUEUE 7
=20
-#define AHA152X_REVID "Adaptec 152x SCSI driver; $Revision: 2.5 $"
+#define AHA152X_REVID "Adaptec 152x SCSI driver; $Revision: 2.7 $"
=20
 /* port addresses */
 #define SCSISEQ      (HOSTIOPORT0+0x00)    /* SCSI sequence control */
@@ -331,6 +331,7 @@ struct aha152x_setup {
 };
=20
 struct Scsi_Host *aha152x_probe_one(struct aha152x_setup *);
-int aha152x_host_reset(struct scsi_cmnd *);
+void aha152x_release(struct Scsi_Host *);
+int aha152x_host_reset(Scsi_Cmnd *);
=20
 #endif /* _AHA152X_H */
diff -uprd orig/linux-2.6.2-rc2/drivers/scsi/pcmcia/aha152x_stub.c linux-2.=
6.2-rc2/drivers/scsi/pcmcia/aha152x_stub.c
--- orig/linux-2.6.2-rc2/drivers/scsi/pcmcia/aha152x_stub.c	2004-01-24 11:5=
4:43.000000000 +0100
+++ linux-2.6.2-rc2/drivers/scsi/pcmcia/aha152x_stub.c	2004-01-24 12:06:31.=
000000000 +0100
@@ -78,7 +78,7 @@ static int irq_list[4] =3D { -1 };
 static int host_id =3D 7;
 static int reconnect =3D 1;
 static int parity =3D 1;
-static int synchronous =3D 0;
+static int synchronous =3D 1;
 static int reset_delay =3D 100;
 static int ext_trans =3D 0;
=20
@@ -244,9 +244,6 @@ static void aha152x_config_cs(dev_link_t
     CS_CHECK(RequestIRQ, pcmcia_request_irq(handle, &link->irq));
     CS_CHECK(RequestConfiguration, pcmcia_request_configuration(handle, &l=
ink->conf));
    =20
-    /* A bad hack... */
-    release_region(link->io.BasePort1, link->io.NumPorts1);
-
     /* Set configuration options for the aha152x driver */
     memset(&s, 0, sizeof(s));
     s.conf        =3D "PCMCIA setup";
@@ -266,9 +263,6 @@ static void aha152x_config_cs(dev_link_t
 	goto cs_failed;
     }
=20
-    scsi_add_host(host, NULL); /* XXX handle failure */
-    scsi_scan_host(host);
-
     sprintf(info->node.dev_name, "scsi%d", host->host_no);
     link->dev =3D &info->node;
     info->host =3D host;
@@ -286,7 +280,7 @@ static void aha152x_release_cs(dev_link_
 {
 	scsi_info_t *info =3D link->priv;
=20
-	scsi_remove_host(info->host);
+	aha152x_release(info->host);
 	link->dev =3D NULL;
    =20
 	pcmcia_release_configuration(link->handle);
@@ -294,7 +288,6 @@ static void aha152x_release_cs(dev_link_
 	pcmcia_release_irq(link->handle, &link->irq);
    =20
 	link->state &=3D ~DEV_CONFIG;
-	scsi_unregister(info->host);
 }
=20
 static int aha152x_event(event_t event, int priority,

--C7zPtVaVf+AK4Oqc--

--4bRzO86E/ozDv8r1
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.4 (GNU/Linux)

iD8DBQFAGglMc/GhTF5ESHURAr+CAKDH1I36BlDI5hyPOuuxzmjIi2nC6wCdGYYp
6rytIamUh9dwLCSTid58MVA=
=PTIn
-----END PGP SIGNATURE-----

--4bRzO86E/ozDv8r1--
