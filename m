Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S266537AbSLDNFs>; Wed, 4 Dec 2002 08:05:48 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S266540AbSLDNFr>; Wed, 4 Dec 2002 08:05:47 -0500
Received: from [211.167.76.68] ([211.167.76.68]:15012 "HELO soulinfo")
	by vger.kernel.org with SMTP id <S266537AbSLDNFk>;
	Wed, 4 Dec 2002 08:05:40 -0500
Date: Wed, 4 Dec 2002 21:09:41 +0800
From: hugang <hugang@soulinfo.com>
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
Cc: linux-kernel@vger.kernel.org, andrea@suse.de, jamagallon@able.es,
       marcelo@hera.kernel.org
Subject: Re: [patch]back ports ICH3M support into 2.4.20
Message-Id: <20021204210941.47b4db08.hugang@soulinfo.com>
In-Reply-To: <1038765805.30381.3.camel@irongate.swansea.linux.org.uk>
References: <20021201130427.37a915bf.hugang@soulinfo.com>
	<1038765805.30381.3.camel@irongate.swansea.linux.org.uk>
X-Mailer: Sylpheed version 0.8.5claws126 (GTK+ 1.2.10; )
Mime-Version: 1.0
=?ISO-8859-1?Q?=CA=D5=BC=FE=C8=CB=A3=BA: ?= Alan Cox <alan@lxorguk.ukuu.org.uk>
=?ISO-8859-1?Q?=B3=AD=CB=CD=A3=BA: ?= linux-kernel@vger.kernel.org
=?ISO-8859-1?Q?=B3=AD=CB=CD=A3=BA: ?= andrea@suse.de
=?ISO-8859-1?Q?=B3=AD=CB=CD=A3=BA: ?= jamagallon@able.es
=?ISO-8859-1?Q?=B3=AD=CB=CD=A3=BA: ?= marcelo@hera.kernel.org
Content-Type: multipart/signed; protocol="application/pgp-signature";
 micalg="pgp-sha1"; boundary="=.5SR(B5YP.Hkuko"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

--=.5SR(B5YP.Hkuko
Content-Type: multipart/mixed;
 boundary="Multipart_Wed__4_Dec_2002_21:09:41_+0800_08391700"


--Multipart_Wed__4_Dec_2002_21:09:41_+0800_08391700
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On 01 Dec 2002 18:03:25 +0000
Alan Cox <alan@lxorguk.ukuu.org.uk> wrote:

> On Sun, 2002-12-01 at 05:04, hugang wrote:
> > hello 
> >   Here is a back port patch for Intel ICH3M IDE 
> 
> 2.4.20 already has the correct version of the fixes for partially
> configured IDE devices. The code you are posting is old and in several
> places wrong, hence it was removed.
> 
> 2.4.20 will try and do a full pci device setup, then fall back to just
> configuring BAR4.
> 
> Alan
> 
Here is an new patch for it. But I'm not true that , Place the fixup function in pci_init_piix is good way. But it works.
Here is it.
Index: 2.4/drivers/ide/piix.c
diff -u 2.4/drivers/ide/piix.c:1.1.1.4 2.4/drivers/ide/piix.c:1.1.1.4.8.3
--- 2.4/drivers/ide/piix.c:1.1.1.4	Fri Nov 29 13:57:34 2002
+++ 2.4/drivers/ide/piix.c	Wed Dec  4 21:05:27 2002
@@ -480,6 +480,30 @@
 }
 #endif /* defined(CONFIG_BLK_DEV_IDEDMA) && (CONFIG_PIIX_TUNING) */
 
+inline void ide_register_xp_fix(struct pci_dev *dev)
+{
+	int i;
+	unsigned short cmd;
+	unsigned long flags;
+	unsigned long base_address[4] = { 0x1f0, 0x3f4, 0x170, 0x374 };
+  
+	printk(KERN_INFO "PIIX: fixup IDE controller\n");
+	local_irq_save(flags);
+	pci_read_config_word(dev, PCI_COMMAND, &cmd);
+	write_config_word(dev, PCI_COMMAND, cmd & ~PCI_COMMAND_IO);
+
+	for (i=0; i<4; i++) {
+		dev->resource[i].start = base_address[i];
+		dev->resource[i].flags |= PCI_BASE_ADDRESS_SPACE_IO;
+		pci_write_config_dword(dev,
+				       (PCI_BASE_ADDRESS_0 + (i * 4)),
+				       dev->resource[i].start);
+	}
+
+	pci_write_config_word(dev, PCI_COMMAND, cmd);
+	local_irq_restore(flags);
+}
+
 unsigned int __init pci_init_piix (struct pci_dev *dev, const char *name)
 {
 #if defined(DISPLAY_PIIX_TIMINGS) && defined(CONFIG_PROC_FS)
@@ -489,6 +513,9 @@
 		piix_display_info = &piix_get_info;
 	}
 #endif /* DISPLAY_PIIX_TIMINGS && CONFIG_PROC_FS */
+	if (dev->resource[0].start != 0x01f1)
+		ide_register_xp_fix(dev);
+
 	return 0;
 }
 


-- 
		- Hu Gang

--Multipart_Wed__4_Dec_2002_21:09:41_+0800_08391700
Content-Type: application/octet-stream;
 name="tune.gz"
Content-Disposition: attachment;
 filename="tune.gz"
Content-Transfer-Encoding: base64

H4sICNf97T0AA3R1bmUAhVRrT+JAFP3c/oq7mpCW8mihLgrLBqRgGqUQu8+4ZtLtTHGytWWnBdm4
7m/fO0WNVYyQdMp9nnPnHtyEsk0XWg27SQVfM5E1OWXNJeebRqhSHkVQX73i7loN+bXfcDcOG221
Xq+/EaZMBAcvXUPrCKx296DTbWNl02yphmG8kqt8ZRQcFgJgqNU1D7qtzjZnMIC6fWjW3oMhj7YJ
g4EKdyrsswRZQbMKlEU8YVQbzbyJe0KOz06JM/5CXGfsTIc6VCrw4Jq77jfy6bPneic6VJsqqAZP
YkyGdcopIB4i2IJnORNksyQR32hZLlZhDsuQE8rWUMWHrhq3qqHwJAfew5dVkvEFAoDsKhU5hNe0
ZI3TZAFRHCyyl+afQcZIQKlgWXZhX0IfbsHcWJFZw6Md2fKwOttfHRvusAIgaGUpsPsv7XR87hHX
m8xgT1LrAiJeLQGZQ5gmuUjjmIkfyZ4uO8dpGMSEi98kC9ZMKxAVDslNsIASzIn4gtykgmrIswbz
kUtGs+l06Dk1qCCxIv5G8Jy9EYyxUIF/T2zEnclszI9SARrvmz3gH2x8GIYOcqAKlql/xFGkKxGy
C37ZyPIAB9ovj4lf9nYGF4Tgb78Acjz0x2ToOOdj3yf+fDgaY/8iT7ItMaCPFKRbUWD70V6UMcFA
3FAFW9fLsbuBF8O6Kyi/aPr62J7dFVbNU/HkumRBeNwiuYSE8IRvV1S+ECkp2LW4NbkVGW7oVSCg
mgTXTFdx8rCPOnoQkeP687Ph93upuFOUil9o6JnK5uezEZn4+r1Aj6RAD6x27ajQJ44ZQRDKs2Uc
/EFYUYrXWCmMC5YXhh6GlXS8q7XsXO4odYvii0ArT918WJd3fVSLaUWWLu9ol6alhuUqgiJYvhIJ
mL3iL0X9DzgJX5lFBQAA

--Multipart_Wed__4_Dec_2002_21:09:41_+0800_08391700--

--=.5SR(B5YP.Hkuko
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.0.6 (GNU/Linux)

iEYEARECAAYFAj3t/pgACgkQpsLEGIbIYQ5XpQCdFoCvkexPK9FJybbfqribkmKZ
tZMAn2GzU3c2snF7ornX1nmyhq4CCCPt
=PPf0
-----END PGP SIGNATURE-----

--=.5SR(B5YP.Hkuko--
