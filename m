Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S265010AbSKNQ7s>; Thu, 14 Nov 2002 11:59:48 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S265012AbSKNQ7s>; Thu, 14 Nov 2002 11:59:48 -0500
Received: from orion.netbank.com.br ([200.203.199.90]:49670 "EHLO
	orion.netbank.com.br") by vger.kernel.org with ESMTP
	id <S265010AbSKNQ73>; Thu, 14 Nov 2002 11:59:29 -0500
Date: Thu, 14 Nov 2002 14:45:42 -0200
From: Arnaldo Carvalho de Melo <acme@conectiva.com.br>
To: andrew.grover@intel.com
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       Linus Torvalds <torvalds@transmeta.com>, aris@cathedrallabs.org,
       acpi-devel@lists.sourceforge.net
Subject: [PATCH] drivers/acpi/ac.c: convert to seq_file
Message-ID: <20021114164542.GE13639@conectiva.com.br>
Mail-Followup-To: Arnaldo Carvalho de Melo <acme@conectiva.com.br>,
	andrew.grover@intel.com,
	Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
	Linus Torvalds <torvalds@transmeta.com>, aris@cathedrallabs.org,
	acpi-devel@lists.sourceforge.net
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.4i
X-Url: http://advogato.org/person/acme
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Andrew,

	Please consider pulling from:

bk://oops.kerneljanitors.org:acpi-2.5

	This is the first in a series of changesets converting
ACPI to seq_file, please lets us know if something is unacceptable.

	The work was done by Aristeu Rozanski.

- Arnaldo

You can import this changeset into BK by piping this whole message to:
'| bk receive [path to repository]' or apply the patch as usual.

===================================================================


ChangeSet@1.846, 2002-11-13 19:35:45-02:00, aris@cathedrallabs.org
  drivers/acpi/ac.c: convert to seq_file


 ac.c |   57 ++++++++++++++++++++++++++-------------------------------
 1 files changed, 26 insertions(+), 31 deletions(-)


diff -Nru a/drivers/acpi/ac.c b/drivers/acpi/ac.c
--- a/drivers/acpi/ac.c	Thu Nov 14 14:20:40 2002
+++ b/drivers/acpi/ac.c	Thu Nov 14 14:20:40 2002
@@ -29,6 +29,7 @@
 #include <linux/types.h>
 #include <linux/compatmac.h>
 #include <linux/proc_fs.h>
+#include <linux/seq_file.h>
 #include "acpi_bus.h"
 #include "acpi_drivers.h"
 
@@ -53,6 +54,7 @@
 
 int acpi_ac_add (struct acpi_device *device);
 int acpi_ac_remove (struct acpi_device *device, int type);
+static int acpi_ac_open_fs(struct inode *inode, struct file *file);
 
 static struct acpi_driver acpi_ac_driver = {
 	.name =		ACPI_AC_DRIVER_NAME,
@@ -69,6 +71,12 @@
 	unsigned long		state;
 };
 
+static struct file_operations acpi_ac_fops = {
+	.open		= acpi_ac_open_fs,
+	.read		= seq_read,
+	.llseek		= seq_lseek,
+	.release	= single_release,
+};
 
 /* --------------------------------------------------------------------------
                                AC Adapter Management
@@ -103,53 +111,40 @@
 
 struct proc_dir_entry		*acpi_ac_dir = NULL;
 
-static int
-acpi_ac_read_state (
-	char			*page,
-	char			**start,
-	off_t			off,
-	int 			count,
-	int 			*eof,
-	void			*data)
+int acpi_ac_seq_show(struct seq_file *seq, void *offset)
 {
-	struct acpi_ac		*ac = (struct acpi_ac *) data;
-	char			*p = page;
-	int			len = 0;
+	struct acpi_ac		*ac = (struct acpi_ac *) seq->private;
 
-	ACPI_FUNCTION_TRACE("acpi_ac_read_state");
+	ACPI_FUNCTION_TRACE("acpi_ac_seq_show");
 
-	if (!ac || (off != 0))
-		goto end;
+	if (!ac)
+		return 0;
 
 	if (acpi_ac_get_state(ac)) {
-		p += sprintf(p, "ERROR: Unable to read AC Adapter state\n");
-		goto end;
+		seq_puts(seq, "ERROR: Unable to read AC Adapter state\n");
+		return 0;
 	}
 
-	p += sprintf(p, "state:                   ");
+	seq_puts(seq, "state:                   ");
 	switch (ac->state) {
 	case ACPI_AC_STATUS_OFFLINE:
-		p += sprintf(p, "off-line\n");
+		seq_puts(seq, "off-line\n");
 		break;
 	case ACPI_AC_STATUS_ONLINE:
-		p += sprintf(p, "on-line\n");
+		seq_puts(seq, "on-line\n");
 		break;
 	default:
-		p += sprintf(p, "unknown\n");
+		seq_puts(seq, "unknown\n");
 		break;
 	}
 
-end:
-	len = (p - page);
-	if (len <= off+count) *eof = 1;
-	*start = page + off;
-	len -= off;
-	if (len>count) len = count;
-	if (len<0) len = 0;
-
-	return_VALUE(len);
+	return 0;
+}
+	
+static int acpi_ac_open_fs(struct inode *inode, struct file *file)
+{
+	return single_open(file, acpi_ac_seq_show, PDE(inode)->data);
 }
-
 
 static int
 acpi_ac_add_fs (
@@ -180,7 +175,7 @@
 			"Unable to create '%s' fs entry\n",
 			ACPI_AC_FILE_STATE));
 	else {
-		entry->read_proc = acpi_ac_read_state;
+		entry->proc_fops = &acpi_ac_fops;
 		entry->data = acpi_driver_data(device);
 	}
 

===================================================================


This BitKeeper patch contains the following changesets:
1.846
## Wrapped with gzip_uu ##


begin 664 bkpatch5049
M'XL(`%C-TST``[55;6_:2!#^[/T5<XET`@[,OGB-<8XHE.1ZJ*<&<<VWD]!B
M+\&*LTOMA5Q5^M^[:P--H-6]J#5HQ\P\\\SL[+/B'.Y*6<2>2!XE.H??=6EB
M+]%*)B;;"#_1C_Z\L(&IUC;07>I'V7WUIBN25=:A/D<V-!$F6<)&%F7L$9\=
M/.;#2L;>].;UW1_#*4*#`8R60MW+/Z6!P0`976Q$GI97PBQSK7Q3"%4^2E,5
MW1Z@6XHQM1].>@SS<$M"'/2V"4D)$0&1*:9!%`8H%9LL[<RO5B*9RSSWE<U\
MR4$(83ATZY:%M!^A:R!^%(2`:9>0+F%`^C'C<<`[F,88@RBR\BJQW<FT$'DN
MYJ6OBWOXA4`'HU?P??L?H032(G-3K(9K%S^)P9Z$=1E;#$KY?K;(<HG>``LQ
M[:')EWFBSG]\$,("HTL0]X6V!:YJHU6>*5GU?]3+*INYANK-,,(IHQ&E6T;[
MO;X=)TNCD(L^YA$)@^`;DSOFW-&Y$Z&$<19L6<09KY1R`G6*^2'-_FO6/6&?
M8A)Q@GM;:HE[E8P(/E81"_Y!132$#B,_1$??$$TUW%OH%$_5UXI@<CKG_Z&D
M,2-`T'FFDGR=2OC5#G#]=W=?V5]>HC'G%E$:8;($,F5@=T8SO9)JMB@;I2G6
MB;$A;0E:E6G#SNE(H.76Y@4:]PB$>Z9G`,=46*=6Y8%\H5<E#.`C\GQ7Q_,&
MQW7;-E1(D;J0Z]>].U^>EU(^[+W5CQJ:2U%*Y\[4O2VZ<[31IPMT37`($1H3
M)P'T?)..HUSJI_TN]Y.!EGUKPT9G*;3T8E%*T[0TA`-S-#U+X^U2=E2>UQ+V
M)D#CI1M:34?:N5S9TQ1&NF9(WZ:/:^,-1Y/Q[+>[MZ-WX]NWLW?3X>BF<7;<
MWEG3Y5$"U.91:HV7+:#QDTB:R/,*:=:%`EQA>(T)'<9S^:NUL8?H=G-V,YW>
M3F.X4V)NMV@EZ(8*PQ$,4[$RL@!W>/(OY<H=T=8M5^:8M4J*X?2INV:T2JW,
M24=VM!UWJ>N:%LQK,/\J6+W$1C4V^AIVK1Z4?E)[;$"A;[$<6X4^V]@GY'T'
MZ:./!\Z=^!Q!P\7:)TIKP^3ZIE%Q-3N7J3"B:I"[\5R3B%5[JHSG266*#TXZ
C^G!C?GY^@RZ^_,4G2YD\E.O'03"?)SSB`?H,4J``R#X(````
`
end
