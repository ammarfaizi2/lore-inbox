Return-Path: <linux-kernel-owner+willy=40w.ods.org-S266835AbUHCUys@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266835AbUHCUys (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 3 Aug 2004 16:54:48 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266839AbUHCUys
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 3 Aug 2004 16:54:48 -0400
Received: from postfix3-1.free.fr ([213.228.0.44]:31924 "EHLO
	postfix3-1.free.fr") by vger.kernel.org with ESMTP id S266835AbUHCUye
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 3 Aug 2004 16:54:34 -0400
Message-ID: <410FFB88.10800@free.fr>
Date: Tue, 03 Aug 2004 22:54:32 +0200
From: Eric Valette <eric.valette@free.fr>
Reply-To: eric.valette@free.fr
Organization: HOME
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.7) Gecko/20040618
X-Accept-Language: en
MIME-Version: 1.0
To: greg@kroah.com, phil@netroedge.com
Cc: Andrew Morton <akpm@osdl.org>, linux-kernel@vger.kernel.org
Subject: Small fix to make i2c-viapro.c work on ASUS A7V with ACPI enabled
Content-Type: multipart/mixed;
 boundary="------------050905010709020105050809"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is a multi-part message in MIME format.
--------------050905010709020105050809
Content-Type: text/plain; charset=ISO-8859-15; format=flowed
Content-Transfer-Encoding: quoted-printable

Today, due to the heat, I tried to make lm-sensors work on my ASUS A7V=20
KT133 motherboard in order to check the temperature (One fan already=20
died without damaging the processor...).

Hi,

At least I suceeded to make lm-sensors work on ASUS A7V but encountered=20
the following problem : i2c-viapro.c tries to request an ioports region=20
(in my case 0xe800 see <=3D=3D=3D=3D) that has already been allocated by =
the=20
acpi motherboard.c code and fails whith an error if this region has=20
already been allocated.

I first tried to use the "force_addr" methods in i2c-viapro.c using a=20
free ioport location but then lm-sensors works but code breakes ACPI=20
support (fails to shutdown at least) as it reprogram the bus chip base=20
address without ACPI code being notified.

With the following patch targeted toward 2.6.8-rc2-mm2, both things=20
works together like a charm. I have no idea if patch is correct but at=20
least I think the analysis is. Let me know if you think there is a=20
better fix.

(prompt)sensors
as99127f-i2c-2-2d
Adapter: SMBus Via Pro adapter at e800  <=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
VCore:     +1.81 V  (min =3D  +1.74 V, max =3D  +1.94 V)
+3.3V:     +3.52 V  (min =3D  +3.20 V, max =3D  +3.54 V)
+5V:       +5.05 V  (min =3D  +4.73 V, max =3D  +5.24 V)
+12V:     +12.34 V  (min =3D +10.82 V, max =3D +13.19 V)
-12V:     -12.33 V  (min =3D -13.22 V, max =3D -10.74 V)
-5V:       -5.15 V  (min =3D  -5.25 V, max =3D  -4.74 V)
fan1:        0 RPM  (min =3D    0 RPM, div =3D 2)
fan2:     6958 RPM  (min =3D 2836 RPM, div =3D 2)                     (be=
ep)
fan3:        0 RPM  (min =3D    0 RPM, div =3D 2)
M/B Temp:    +47=B0C  (high =3D  +105=B0C, hyst =3D    +0=B0C)
CPU Temp:  +67.0=B0C  (high =3D   +95=B0C, hyst =3D   +80=B0C)          (=
beep)
temp3:     -31.5=B0C  (high =3D  +122=B0C, hyst =3D  +121=B0C)
vid:      +1.850 V
alarms:
beep_enable:
           Sound alarm enabled

(prompt) cat /proc/ioports
0000-001f : dma1
0020-0021 : pic1
0040-005f : timer
0060-006f : keyboard
0070-0077 : rtc
0080-008f : dma page reg
00a0-00a1 : pic2
00c0-00df : dma2
00f0-00ff : fpu
01f0-01f7 : ide0
02f8-02ff : serial
0378-037a : parport0
03f6-03f6 : ide0
03f8-03ff : serial
0cf8-0cff : PCI conf1
7800-783f : 0000:00:11.0
   7800-7807 : ide2
   7808-780f : ide3
   7810-783f : PDC20265
8000-8003 : 0000:00:11.0
8400-8407 : 0000:00:11.0
8800-8803 : 0000:00:11.0
   8802-8802 : ide2
9000-9007 : 0000:00:11.0
   9000-9007 : ide2
9400-94ff : 0000:00:0d.0
9800-98ff : 0000:00:0b.0
a000-a007 : 0000:00:0a.1
a400-a41f : 0000:00:0a.0
   a400-a41f : EMU10K1
d000-d01f : 0000:00:04.3
   d000-d01f : uhci_hcd
d400-d41f : 0000:00:04.2
   d400-d41f : uhci_hcd
d800-d80f : 0000:00:04.1
   d800-d807 : ide0
   d808-d80f : ide1
e200-e27f : 0000:00:04.4
e400-e4ff : 0000:00:04.4
   e400-e47f : motherboard
e800-e80f : 0000:00:04.4	<=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
   e800-e80f : motherboard

--=20
    __
   /  `                   	Eric Valette
  /--   __  o _.          	6 rue Paul Le Flem
(___, / (_(_(__         	35740 Pace

Tel: +33 (0)2 99 85 26 76	Fax: +33 (0)2 99 85 26 76
E-mail: eric.valette@free.fr




--------------050905010709020105050809
Content-Type: text/x-patch;
 name="a7v-i2c.patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="a7v-i2c.patch"

--- drivers/i2c/busses/i2c-viapro.c~	2004-08-03 22:28:22.000000000 +0200
+++ drivers/i2c/busses/i2c-viapro.c	2004-08-03 22:24:41.000000000 +0200
@@ -333,9 +333,15 @@
 
  found:
 	if (!request_region(vt596_smba, 8, "viapro-smbus")) {
+#ifndef CONFIG_ACPI_BUS
+	  /*
+	   * The VT82C586A is also managed by the ACPI motherboard.c
+	   * that also request this IO ports region (in fact a little bit more)
+	   */
 		dev_err(&pdev->dev, "SMBus region 0x%x already in use!\n",
 		        vt596_smba);
 		return -ENODEV;
+#endif
 	}
 
 	pci_read_config_byte(pdev, SMBHSTCFG, &temp);

--------------050905010709020105050809--
