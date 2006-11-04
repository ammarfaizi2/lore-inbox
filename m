Return-Path: <linux-kernel-owner+willy=40w.ods.org-S965663AbWKDU20@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965663AbWKDU20 (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 4 Nov 2006 15:28:26 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965665AbWKDU20
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 4 Nov 2006 15:28:26 -0500
Received: from cacti2.profiwh.com ([85.93.165.64]:22198 "EHLO
	cacti.profiwh.com") by vger.kernel.org with ESMTP id S965663AbWKDU2Y
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 4 Nov 2006 15:28:24 -0500
Message-id: <3038713655976825797@wsc.cz>
Subject: [PATCH 2/8] Char: istallion, remove the mess
From: Jiri Slaby <jirislaby@gmail.com>
To: Andrew Morton <akpm@osdl.org>
Cc: <linux-kernel@vger.kernel.org>
Date: Sat,  4 Nov 2006 21:28:35 +0100 (CET)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

istallion, remove the mess

- remove unneeded license text
- remove functions, that are implemented in kernel -- call them (strtoul,
  min, tolower)
- do not cast NULL
- there is no static table, throw away code, which takes care of it --
  find module param cards in that place instead.

Signed-off-by: Jiri Slaby <jirislaby@gmail.com>

---
commit a8e60398f4e946fd569d70a7c1e140e8f5024fa2
tree 01cb500997834d00f4b2c35ee3b752a7a4baaac9
parent b90798585707a33d1835b752a18f1ca3b6a7da7b
author Jiri Slaby <jirislaby@gmail.com> Sat, 04 Nov 2006 18:34:18 +0059
committer Jiri Slaby <jirislaby@gmail.com> Sat, 04 Nov 2006 18:34:18 +0059

 drivers/char/istallion.c |  206 ++++++++--------------------------------------
 1 files changed, 36 insertions(+), 170 deletions(-)

diff --git a/drivers/char/istallion.c b/drivers/char/istallion.c
index 9e73d0d..7cd1f56 100644
--- a/drivers/char/istallion.c
+++ b/drivers/char/istallion.c
@@ -14,14 +14,6 @@
  *	the Free Software Foundation; either version 2 of the License, or
  *	(at your option) any later version.
  *
- *	This program is distributed in the hope that it will be useful,
- *	but WITHOUT ANY WARRANTY; without even the implied warranty of
- *	MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
- *	GNU General Public License for more details.
- *
- *	You should have received a copy of the GNU General Public License
- *	along with this program; if not, write to the Free Software
- *	Foundation, Inc., 675 Mass Ave, Cambridge, MA 02139, USA.
  */
 
 /*****************************************************************************/
@@ -41,6 +33,7 @@ #include <linux/init.h>
 #include <linux/device.h>
 #include <linux/wait.h>
 #include <linux/eisa.h>
+#include <linux/ctype.h>
 
 #include <asm/io.h>
 #include <asm/uaccess.h>
@@ -61,21 +54,10 @@ #define	BRD_STALLION	1
 #define	BRD_BRUMBY4	2
 #define	BRD_ONBOARD2	3
 #define	BRD_ONBOARD	4
-#define	BRD_BRUMBY8	5
-#define	BRD_BRUMBY16	6
 #define	BRD_ONBOARDE	7
-#define	BRD_ONBOARD32	9
-#define	BRD_ONBOARD2_32	10
-#define	BRD_ONBOARDRS	11
-#define	BRD_EASYIO	20
-#define	BRD_ECH		21
-#define	BRD_ECHMC	22
 #define	BRD_ECP		23
 #define BRD_ECPE	24
 #define	BRD_ECPMC	25
-#define	BRD_ECHPCI	26
-#define	BRD_ECH64PCI	27
-#define	BRD_EASYIOPCI	28
 #define	BRD_ECPPCI	29
 
 #define	BRD_BRUMBY	BRD_BRUMBY4
@@ -128,11 +110,7 @@ typedef struct {
 	int		irqtype;
 } stlconf_t;
 
-static stlconf_t	stli_brdconf[] = {
-	/*{ BRD_ECP, 0x2a0, 0, 0xcc000, 0, 0 },*/
-};
-
-static int	stli_nrbrds = ARRAY_SIZE(stli_brdconf);
+static int	stli_nrbrds;
 
 /* stli_lock must NOT be taken holding brd_lock */
 static spinlock_t stli_lock;	/* TTY logic lock */
@@ -257,18 +235,18 @@ static char	*stli_brdnames[] = {
 	"Brumby",
 	"Brumby",
 	"ONboard-EI",
-	(char *) NULL,
+	NULL,
 	"ONboard",
 	"ONboard-MC",
 	"ONboard-MC",
-	(char *) NULL,
-	(char *) NULL,
-	(char *) NULL,
-	(char *) NULL,
-	(char *) NULL,
-	(char *) NULL,
-	(char *) NULL,
-	(char *) NULL,
+	NULL,
+	NULL,
+	NULL,
+	NULL,
+	NULL,
+	NULL,
+	NULL,
+	NULL,
 	"EasyIO",
 	"EC8/32-AT",
 	"EC8/32-MC",
@@ -402,9 +380,6 @@ static int	stli_eisamempsize = ARRAY_SIZ
 /*
  *	Define the Stallion PCI vendor and device IDs.
  */
-#ifndef	PCI_VENDOR_ID_STALLION
-#define	PCI_VENDOR_ID_STALLION		0x124d
-#endif
 #ifndef PCI_DEVICE_ID_ECRA
 #define	PCI_DEVICE_ID_ECRA		0x0004
 #endif
@@ -616,17 +591,6 @@ #define	MINOR2PORT(min)		((min) & 0x3f)
 /*****************************************************************************/
 
 /*
- *	Define some handy local macros...
- */
-#undef MIN
-#define	MIN(a,b)	(((a) <= (b)) ? (a) : (b))
-
-#undef	TOLOWER
-#define	TOLOWER(x)	((((x) >= 'A') && ((x) <= 'Z')) ? ((x) + 0x20) : (x))
-
-/*****************************************************************************/
-
-/*
  *	Prototype all functions in this driver!
  */
 
@@ -844,69 +808,6 @@ module_exit(istallion_module_exit);
 /*****************************************************************************/
 
 /*
- *	Check for any arguments passed in on the module load command line.
- */
-
-static void stli_argbrds(void)
-{
-	stlconf_t conf;
-	stlibrd_t *brdp;
-	int i;
-
-	for (i = stli_nrbrds; i < ARRAY_SIZE(stli_brdsp); i++) {
-		memset(&conf, 0, sizeof(conf));
-		if (stli_parsebrd(&conf, stli_brdsp[i]) == 0)
-			continue;
-		if ((brdp = stli_allocbrd()) == NULL)
-			continue;
-		stli_nrbrds = i + 1;
-		brdp->brdnr = i;
-		brdp->brdtype = conf.brdtype;
-		brdp->iobase = conf.ioaddr1;
-		brdp->memaddr = conf.memaddr;
-		stli_brdinit(brdp);
-	}
-}
-
-/*****************************************************************************/
-
-/*
- *	Convert an ascii string number into an unsigned long.
- */
-
-static unsigned long stli_atol(char *str)
-{
-	unsigned long val;
-	int base, c;
-	char *sp;
-
-	val = 0;
-	sp = str;
-	if ((*sp == '0') && (*(sp+1) == 'x')) {
-		base = 16;
-		sp += 2;
-	} else if (*sp == '0') {
-		base = 8;
-		sp++;
-	} else {
-		base = 10;
-	}
-
-	for (; (*sp != 0); sp++) {
-		c = (*sp > '9') ? (TOLOWER(*sp) - 'a' + 10) : (*sp - '0');
-		if ((c < 0) || (c >= base)) {
-			printk("STALLION: invalid argument %s\n", str);
-			val = 0;
-			break;
-		}
-		val = (val * base) + c;
-	}
-	return(val);
-}
-
-/*****************************************************************************/
-
-/*
  *	Parse the supplied argument string, into the board conf struct.
  */
 
@@ -919,7 +820,7 @@ static int stli_parsebrd(stlconf_t *conf
 		return 0;
 
 	for (sp = argp[0], i = 0; ((*sp != 0) && (i < 25)); sp++, i++)
-		*sp = TOLOWER(*sp);
+		*sp = tolower(*sp);
 
 	for (i = 0; i < ARRAY_SIZE(stli_brdstr); i++) {
 		if (strcmp(stli_brdstr[i].name, argp[0]) == 0)
@@ -932,9 +833,9 @@ static int stli_parsebrd(stlconf_t *conf
 
 	confp->brdtype = stli_brdstr[i].type;
 	if (argp[1] != NULL && *argp[1] != 0)
-		confp->ioaddr1 = stli_atol(argp[1]);
+		confp->ioaddr1 = simple_strtoul(argp[1], NULL, 0);
 	if (argp[2] !=  NULL && *argp[2] != 0)
-		confp->memaddr = stli_atol(argp[2]);
+		confp->memaddr = simple_strtoul(argp[2], NULL, 0);
 	return(1);
 }
 
@@ -1451,12 +1352,12 @@ static int stli_write(struct tty_struct 
 		stlen = len;
 	}
 
-	len = MIN(len, count);
+	len = min(len, (unsigned int)count);
 	count = 0;
 	shbuf = (char __iomem *) EBRDGETMEMPTR(brdp, portp->txoffset);
 
 	while (len > 0) {
-		stlen = MIN(len, stlen);
+		stlen = min(len, stlen);
 		memcpy_toio(shbuf + head, chbuf, stlen);
 		chbuf += stlen;
 		len -= stlen;
@@ -1570,13 +1471,13 @@ static void stli_flushchars(struct tty_s
 		stlen = len;
 	}
 
-	len = MIN(len, cooksize);
+	len = min(len, cooksize);
 	count = 0;
 	shbuf = EBRDGETMEMPTR(brdp, portp->txoffset);
 	buf = stli_txcookbuf;
 
 	while (len > 0) {
-		stlen = MIN(len, stlen);
+		stlen = min(len, stlen);
 		memcpy_toio(shbuf + head, buf, stlen);
 		buf += stlen;
 		len -= stlen;
@@ -2412,7 +2313,7 @@ static void stli_read(stlibrd_t *brdp, s
 	while (len > 0) {
 		unsigned char *cptr;
 
-		stlen = MIN(len, stlen);
+		stlen = min(len, stlen);
 		tty_prepare_flip_string(tty, &cptr, stlen);
 		memcpy_fromio(cptr, shbuf + tail, stlen);
 		len -= stlen;
@@ -3394,7 +3295,6 @@ static int stli_initecp(stlibrd_t *brdp)
  */
 	switch (brdp->brdtype) {
 	case BRD_ECP:
-		brdp->membase = (void *) brdp->memaddr;
 		brdp->memsize = ECP_MEMSIZE;
 		brdp->pagesize = ECP_ATPAGESIZE;
 		brdp->init = stli_ecpinit;
@@ -3408,7 +3308,6 @@ static int stli_initecp(stlibrd_t *brdp)
 		break;
 
 	case BRD_ECPE:
-		brdp->membase = (void *) brdp->memaddr;
 		brdp->memsize = ECP_MEMSIZE;
 		brdp->pagesize = ECP_EIPAGESIZE;
 		brdp->init = stli_ecpeiinit;
@@ -3422,7 +3321,6 @@ static int stli_initecp(stlibrd_t *brdp)
 		break;
 
 	case BRD_ECPMC:
-		brdp->membase = (void *) brdp->memaddr;
 		brdp->memsize = ECP_MEMSIZE;
 		brdp->pagesize = ECP_MCPAGESIZE;
 		brdp->init = NULL;
@@ -3436,7 +3334,6 @@ static int stli_initecp(stlibrd_t *brdp)
 		break;
 
 	case BRD_ECPPCI:
-		brdp->membase = (void *) brdp->memaddr;
 		brdp->memsize = ECP_PCIMEMSIZE;
 		brdp->pagesize = ECP_PCIPAGESIZE;
 		brdp->init = stli_ecppciinit;
@@ -3543,10 +3440,7 @@ static int stli_initonb(stlibrd_t *brdp)
  */
 	switch (brdp->brdtype) {
 	case BRD_ONBOARD:
-	case BRD_ONBOARD32:
 	case BRD_ONBOARD2:
-	case BRD_ONBOARD2_32:
-	case BRD_ONBOARDRS:
 		brdp->memsize = ONB_MEMSIZE;
 		brdp->pagesize = ONB_ATPAGESIZE;
 		brdp->init = stli_onbinit;
@@ -3577,8 +3471,6 @@ static int stli_initonb(stlibrd_t *brdp)
 		break;
 
 	case BRD_BRUMBY4:
-	case BRD_BRUMBY8:
-	case BRD_BRUMBY16:
 		brdp->memsize = BBY_MEMSIZE;
 		brdp->pagesize = BBY_PAGESIZE;
 		brdp->init = stli_bbyinit;
@@ -3795,22 +3687,10 @@ static int __devinit stli_brdinit(stlibr
 	case BRD_ONBOARD:
 	case BRD_ONBOARDE:
 	case BRD_ONBOARD2:
-	case BRD_ONBOARD32:
-	case BRD_ONBOARD2_32:
-	case BRD_ONBOARDRS:
 	case BRD_BRUMBY4:
-	case BRD_BRUMBY8:
-	case BRD_BRUMBY16:
 	case BRD_STALLION:
 		stli_initonb(brdp);
 		break;
-	case BRD_EASYIO:
-	case BRD_ECH:
-	case BRD_ECHMC:
-	case BRD_ECHPCI:
-		printk(KERN_ERR "STALLION: %s board type not supported in "
-				"this driver\n", stli_brdnames[brdp->brdtype]);
-		return -ENODEV;
 	default:
 		printk(KERN_ERR "STALLION: board=%d is unknown board "
 				"type=%d\n", brdp->brdnr, brdp->brdtype);
@@ -4119,37 +3999,23 @@ static stlibrd_t *stli_allocbrd(void)
 static int stli_initbrds(void)
 {
 	stlibrd_t *brdp, *nxtbrdp;
-	stlconf_t *confp;
+	stlconf_t conf;
 	int i, j, retval;
 
-	if (stli_nrbrds > STL_MAXBRDS) {
-		printk(KERN_INFO "STALLION: too many boards in configuration "
-			"table, truncating to %d\n", STL_MAXBRDS);
-		stli_nrbrds = STL_MAXBRDS;
-	}
-
-/*
- *	Firstly scan the list of static boards configured. Allocate
- *	resources and initialize the boards as found. If this is a
- *	module then let the module args override static configuration.
- */
-	for (i = 0; (i < stli_nrbrds); i++) {
-		confp = &stli_brdconf[i];
-		stli_parsebrd(confp, stli_brdsp[i]);
+	for (stli_nrbrds = 0; stli_nrbrds < ARRAY_SIZE(stli_brdsp);
+			stli_nrbrds++) {
+		memset(&conf, 0, sizeof(conf));
+		if (stli_parsebrd(&conf, stli_brdsp[stli_nrbrds]) == 0)
+			continue;
 		if ((brdp = stli_allocbrd()) == NULL)
-			return -ENOMEM;
-		brdp->brdnr = i;
-		brdp->brdtype = confp->brdtype;
-		brdp->iobase = confp->ioaddr1;
-		brdp->memaddr = confp->memaddr;
+			continue;
+		brdp->brdnr = stli_nrbrds;
+		brdp->brdtype = conf.brdtype;
+		brdp->iobase = conf.ioaddr1;
+		brdp->memaddr = conf.memaddr;
 		stli_brdinit(brdp);
 	}
 
-/*
- *	Static configuration table done, so now use dynamic methods to
- *	see if any more boards should be configured.
- */
-	stli_argbrds();
 	if (STLI_EISAPROBE)
 		stli_findeisabrds();
 
@@ -4225,7 +4091,7 @@ static ssize_t stli_memread(struct file 
 	if (off >= brdp->memsize || off + count < off)
 		return 0;
 
-	size = MIN(count, (brdp->memsize - off));
+	size = min(count, (size_t)(brdp->memsize - off));
 
 	/*
 	 *	Copy the data a page at a time
@@ -4239,8 +4105,8 @@ static ssize_t stli_memread(struct file 
 		spin_lock_irqsave(&brd_lock, flags);
 		EBRDENABLE(brdp);
 		memptr = EBRDGETMEMPTR(brdp, off);
-		n = MIN(size, (brdp->pagesize - (((unsigned long) off) % brdp->pagesize)));
-		n = MIN(n, PAGE_SIZE);
+		n = min(size, (int)(brdp->pagesize - (((unsigned long) off) % brdp->pagesize)));
+		n = min(n, (int)PAGE_SIZE);
 		memcpy_fromio(p, memptr, n);
 		EBRDDISABLE(brdp);
 		spin_unlock_irqrestore(&brd_lock, flags);
@@ -4291,7 +4157,7 @@ static ssize_t stli_memwrite(struct file
 		return 0;
 
 	chbuf = (char __user *) buf;
-	size = MIN(count, (brdp->memsize - off));
+	size = min(count, (size_t)(brdp->memsize - off));
 
 	/*
 	 *	Copy the data a page at a time
@@ -4302,8 +4168,8 @@ static ssize_t stli_memwrite(struct file
 		return -ENOMEM;
 
 	while (size > 0) {
-		n = MIN(size, (brdp->pagesize - (((unsigned long) off) % brdp->pagesize)));
-		n = MIN(n, PAGE_SIZE);
+		n = min(size, (int)(brdp->pagesize - (((unsigned long) off) % brdp->pagesize)));
+		n = min(n, (int)PAGE_SIZE);
 		if (copy_from_user(p, chbuf, n)) {
 			if (count == 0)
 				count = -EFAULT;
