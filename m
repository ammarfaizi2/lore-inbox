Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S315088AbSD2LHH>; Mon, 29 Apr 2002 07:07:07 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S315091AbSD2LHG>; Mon, 29 Apr 2002 07:07:06 -0400
Received: from ns1.alcove-solutions.com ([212.155.209.139]:40577 "EHLO
	smtp-out.fr.alcove.com") by vger.kernel.org with ESMTP
	id <S315088AbSD2LHF>; Mon, 29 Apr 2002 07:07:05 -0400
Date: Mon, 29 Apr 2002 13:06:49 +0200
From: Stelian Pop <stelian.pop@fr.alcove.com>
To: Dave Jones <davej@suse.de>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: [BKPATCH 2.5.11] sonypi driver update
Message-ID: <20020429110649.GI2740@come.alcove-fr>
Reply-To: Stelian Pop <stelian.pop@fr.alcove.com>
Mail-Followup-To: Stelian Pop <stelian.pop@fr.alcove.com>,
	Dave Jones <davej@suse.de>,
	Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.3.25i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

This patch updates the sonypi driver to the latest 2.4 version, thus:
	* fixing an array memory leak
	* fixing the order and the syntax for the parameters 
	  on the kernel command line
	* allowing multiple processes to open the sonypi device.

Dave, please apply this to your tree and feed it to Linus on the
next patch feeding session :-)

Thanks,

Stelian.

You can import this changeset into BK by piping this whole message to
'| bk receive [path to repository]' or apply the patch as usual.

===================================================================


ChangeSet@1.548, 2002-04-29 12:55:41+02:00, stelian@popies.net
  Forward port of the sonypi driver from 2.4:
    * fix order and syntax for driver parameters on the kernel command line
    * allow multiple processes to open the sonypi device


 Documentation/sonypi.txt |    4 ++--
 drivers/char/sonypi.c    |   15 ++++++++-------
 drivers/char/sonypi.h    |    2 +-
 3 files changed, 11 insertions(+), 10 deletions(-)


diff -Nru a/Documentation/sonypi.txt b/Documentation/sonypi.txt
--- a/Documentation/sonypi.txt	Mon Apr 29 12:56:13 2002
+++ b/Documentation/sonypi.txt	Mon Apr 29 12:56:13 2002
@@ -36,14 +36,14 @@
 driver and the ACPI BIOS, because Sony doesn't agree to release any programming
 specs for its laptops. If someone convinces them to do so, drop me a note.
 
-Module options:
+Driver options:
 ---------------
 
 Several options can be passed to the sonypi driver, either by adding them
 to /etc/modules.conf file, when the driver is compiled as a module or by
 adding the following to the kernel command line (in your bootloader):
 
-	sonypi=minor[[[[[,camera],fnkeyinit],verbose],compat],nojogdial]
+	sonypi=minor[,verbose[,fnkeyinit[,camera[,compat[,nojogdial]]]]]
 
 where:
 
diff -Nru a/drivers/char/sonypi.c b/drivers/char/sonypi.c
--- a/drivers/char/sonypi.c	Mon Apr 29 12:56:13 2002
+++ b/drivers/char/sonypi.c	Mon Apr 29 12:56:13 2002
@@ -485,12 +485,10 @@
 
 static int sonypi_misc_open(struct inode * inode, struct file * file) {
 	down(&sonypi_device.lock);
-	if (sonypi_device.open_count)
-		goto out;
+	/* Flush input queue on first open */
+	if (!sonypi_device.open_count)
+		sonypi_initq();
 	sonypi_device.open_count++;
-	/* Flush input queue */
-	sonypi_initq();
-out:
 	up(&sonypi_device.lock);
 	return 0;
 }
@@ -718,9 +716,12 @@
 	       SONYPI_DRIVER_MAJORVERSION,
 	       SONYPI_DRIVER_MINORVERSION);
 	printk(KERN_INFO "sonypi: detected %s model, "
-	       "camera = %s, compat = %s, nojogdial = %s\n",
+	       "verbose = %s, fnkeyinit = %s, camera = %s, "
+	       "compat = %s, nojogdial = %s\n",
 	       (sonypi_device.model == SONYPI_DEVICE_MODEL_TYPE1) ?
 			"type1" : "type2",
+	       verbose ? "on" : "off",
+	       fnkeyinit ? "on" : "off",
 	       camera ? "on" : "off",
 	       compat ? "on" : "off",
 	       nojogdial ? "on" : "off");
@@ -779,7 +780,7 @@
 
 #ifndef MODULE
 static int __init sonypi_setup(char *str)  {
-	int ints[6];
+	int ints[7];
 
 	str = get_options(str, ARRAY_SIZE(ints), ints);
 	if (ints[0] <= 0) 
diff -Nru a/drivers/char/sonypi.h b/drivers/char/sonypi.h
--- a/drivers/char/sonypi.h	Mon Apr 29 12:56:13 2002
+++ b/drivers/char/sonypi.h	Mon Apr 29 12:56:13 2002
@@ -35,7 +35,7 @@
 #ifdef __KERNEL__
 
 #define SONYPI_DRIVER_MAJORVERSION	 1
-#define SONYPI_DRIVER_MINORVERSION	11
+#define SONYPI_DRIVER_MINORVERSION	13
 
 #include <linux/types.h>
 #include <linux/pci.h>

===================================================================


This BitKeeper patch contains the following changesets:
+
## Wrapped with gzip_uu ##


begin 664 bkpatch3499
M'XL(`,TFS3P``^U7;6_;-A#^+/Z*6X(!;>H7DJ)>"V_=ZG8+MB6!@PX8LB)@
M)*I2(Y.J2.4%T(\?)3EQFR9.FFW?(ANB19[O'MX]S]'>AG=:U+&CC2@++M$V
M_*JTB9U*5870$RF,G5HH9:>FN5J*J2EDH9KIJ:BE**=E(9N+,9UXR)H=<)/D
M<"9J'3MDXE[/F,M*Q,[BS2_O?O]I@=!L!J]S+C^(0V%@-D-&U6>\3/4K;O)2
MR8FIN=1+8?@D4<OVVK2E&%/[\DC@8L]OB8]9T"8D)80S(E),6>BSM;<.[69?
MC$:8>I3@EOH1CM`<R,1C(6`ZQ6Q*(R`T]KR8D1>8QAC#*D>OUKF!%RZ,,?H9
M_ML]O$8)O%7U.:]3J%1M0&5@<@%:R<NJ@+0N;)(AJ]42Z(3%UAI@![+B`E2=
MVA4N4]"7TO`+R%1]95_QFEM(MCR@9.]O*")8B,ON*[:88N6+EZ4ZAV53FJ(J
M!52U2H360MN-@JJ$_`*.."L2@7X#&GJ1CP[6U47C;[P0PARC'RQ4RYO;<SE7
M2;,4=F^F4'(Z0)B8B\]2&Q'LDI9A+V!MDC!&0G)"4Q)QQJ-;:GB/1TL28HOD
MD=;W6,`V@QLRK:=)SNLK3_E7R$@8!:WK)Y'UE]$@R'R2!K<AV^#N"A9M&?.#
M\-MA)5_#"IC?NA[.PB`(&69AF'C^0V$E-V%1XOE1+_:[\MMI_W\K-$KYF?CX
M2C=:3%)Q?XTQ\3P:=C7VP[X1?-D&6!![F]H`A3%]:@-#&QATL@_C^KQ_6UD?
MW$F"1[2(N6M+@G;[^WS8DZHZMSI&<^9W:_W=&:+,EH54]='(VITH+8Y&F3P5
ME_84,T>CQ&:BYG942\O$HY%4']6'M.#E^^[JV7LKV>^A[K_0VPW>;I;:BK2$
M^:Y_!VGI!M*&,`Z>2+LZN_IV=8.TMV;_,8RUM05J:1E&X")GN@-ORT;G4,BJ
M,?"I$8WHMI45M38#Q)TI<HH,GGTW1#T><$ZZM>-$-=(\1\Z*W\<=E3\]>_[2
MAHF(]3\/*.E$T`T4.3!<6RO^PPR^UR.X%L'J>5#"ZF%K_:U!&:OY:WGTSW_+
MK5$7Q?TLRE60'V%+R2V([9!EUNQJ?1WVIL4\"&F/NA^<0AJ;'J./@O<O[]1A
M_@@=/O`X?H`.\YLZ[$[BQ^B0P)@\Z7#0X?!KY@$ZS!]U<H3]R='=MU.16:QP
MN+_WU\'N\7RQ^^>;Q?$?NWO["_OA<'=_SR'N^E]-DHOD5#?+&3^A2<8$0_\`
(_PU::#H-````
`
end
-- 
Stelian Pop <stelian.pop@fr.alcove.com>
Alcove - http://www.alcove.com
