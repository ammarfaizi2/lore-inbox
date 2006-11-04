Return-Path: <linux-kernel-owner+willy=40w.ods.org-S965668AbWKDU2o@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965668AbWKDU2o (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 4 Nov 2006 15:28:44 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965667AbWKDU2n
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 4 Nov 2006 15:28:43 -0500
Received: from cacti2.profiwh.com ([85.93.165.64]:51136 "EHLO
	cacti.profiwh.com") by vger.kernel.org with ESMTP id S965665AbWKDU2h
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 4 Nov 2006 15:28:37 -0500
Message-id: <273231164851715510@wsc.cz>
Subject: [PATCH 3/8] Char: istallion, eliminate typedefs
From: Jiri Slaby <jirislaby@gmail.com>
To: Andrew Morton <akpm@osdl.org>
Cc: <linux-kernel@vger.kernel.org>
Date: Sat,  4 Nov 2006 21:28:45 +0100 (CET)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

istallion, eliminate typedefs

Use only struct <name> instead of defining a new type <name_t>.

Signed-off-by: Jiri Slaby <jirislaby@gmail.com>

---
commit f138b6b285ea78dab9e9dbbc968b834d661727db
tree b9be4a88e6abafa3651f5c38d387a73b1a2db90f
parent a8e60398f4e946fd569d70a7c1e140e8f5024fa2
author Jiri Slaby <jirislaby@gmail.com> Sat, 04 Nov 2006 19:44:47 +0059
committer Jiri Slaby <jirislaby@gmail.com> Sat, 04 Nov 2006 19:44:47 +0059

 drivers/char/istallion.c  |  414 ++++++++++++++++++++++-----------------------
 include/linux/istallion.h |   12 +
 2 files changed, 212 insertions(+), 214 deletions(-)

diff --git a/drivers/char/istallion.c b/drivers/char/istallion.c
index 7cd1f56..24fae16 100644
--- a/drivers/char/istallion.c
+++ b/drivers/char/istallion.c
@@ -101,14 +101,14 @@ #define	BRD_BRUMBY	BRD_BRUMBY4
  *	interrupt is required.
  */
 
-typedef struct {
+struct stlconf {
 	int		brdtype;
 	int		ioaddr1;
 	int		ioaddr2;
 	unsigned long	memaddr;
 	int		irq;
 	int		irqtype;
-} stlconf_t;
+};
 
 static int	stli_nrbrds;
 
@@ -185,13 +185,13 @@ static struct ktermios		stli_deftermios 
  */
 static comstats_t	stli_comstats;
 static combrd_t		stli_brdstats;
-static asystats_t	stli_cdkstats;
-static stlibrd_t	stli_dummybrd;
-static stliport_t	stli_dummyport;
+static struct asystats	stli_cdkstats;
+static struct stlibrd	stli_dummybrd;
+static struct stliport	stli_dummyport;
 
 /*****************************************************************************/
 
-static stlibrd_t	*stli_brds[STL_MAXBRDS];
+static struct stlibrd	*stli_brds[STL_MAXBRDS];
 
 static int		stli_shared;
 
@@ -284,12 +284,10 @@ static char	**stli_brdsp[] = {
  *	parse any module arguments.
  */
 
-typedef struct stlibrdtype {
+static struct stlibrdtype {
 	char	*name;
 	int	type;
-} stlibrdtype_t;
-
-static stlibrdtype_t	stli_brdstr[] = {
+} stli_brdstr[] = {
 	{ "stallion", BRD_STALLION },
 	{ "1", BRD_STALLION },
 	{ "brumby", BRD_BRUMBY },
@@ -594,7 +592,7 @@ #define	MINOR2PORT(min)		((min) & 0x3f)
  *	Prototype all functions in this driver!
  */
 
-static int	stli_parsebrd(stlconf_t *confp, char **argp);
+static int	stli_parsebrd(struct stlconf *confp, char **argp);
 static int	stli_init(void);
 static int	stli_open(struct tty_struct *tty, struct file *filp);
 static void	stli_close(struct tty_struct *tty, struct file *filp);
@@ -614,82 +612,82 @@ static void	stli_breakctl(struct tty_str
 static void	stli_waituntilsent(struct tty_struct *tty, int timeout);
 static void	stli_sendxchar(struct tty_struct *tty, char ch);
 static void	stli_hangup(struct tty_struct *tty);
-static int	stli_portinfo(stlibrd_t *brdp, stliport_t *portp, int portnr, char *pos);
+static int	stli_portinfo(struct stlibrd *brdp, struct stliport *portp, int portnr, char *pos);
 
-static int	stli_brdinit(stlibrd_t *brdp);
-static int	stli_startbrd(stlibrd_t *brdp);
+static int	stli_brdinit(struct stlibrd *brdp);
+static int	stli_startbrd(struct stlibrd *brdp);
 static ssize_t	stli_memread(struct file *fp, char __user *buf, size_t count, loff_t *offp);
 static ssize_t	stli_memwrite(struct file *fp, const char __user *buf, size_t count, loff_t *offp);
 static int	stli_memioctl(struct inode *ip, struct file *fp, unsigned int cmd, unsigned long arg);
-static void	stli_brdpoll(stlibrd_t *brdp, cdkhdr_t __iomem *hdrp);
+static void	stli_brdpoll(struct stlibrd *brdp, cdkhdr_t __iomem *hdrp);
 static void	stli_poll(unsigned long arg);
-static int	stli_hostcmd(stlibrd_t *brdp, stliport_t *portp);
-static int	stli_initopen(stlibrd_t *brdp, stliport_t *portp);
-static int	stli_rawopen(stlibrd_t *brdp, stliport_t *portp, unsigned long arg, int wait);
-static int	stli_rawclose(stlibrd_t *brdp, stliport_t *portp, unsigned long arg, int wait);
-static int	stli_waitcarrier(stlibrd_t *brdp, stliport_t *portp, struct file *filp);
+static int	stli_hostcmd(struct stlibrd *brdp, struct stliport *portp);
+static int	stli_initopen(struct stlibrd *brdp, struct stliport *portp);
+static int	stli_rawopen(struct stlibrd *brdp, struct stliport *portp, unsigned long arg, int wait);
+static int	stli_rawclose(struct stlibrd *brdp, struct stliport *portp, unsigned long arg, int wait);
+static int	stli_waitcarrier(struct stlibrd *brdp, struct stliport *portp, struct file *filp);
 static void	stli_dohangup(void *arg);
-static int	stli_setport(stliport_t *portp);
-static int	stli_cmdwait(stlibrd_t *brdp, stliport_t *portp, unsigned long cmd, void *arg, int size, int copyback);
-static void	stli_sendcmd(stlibrd_t *brdp, stliport_t *portp, unsigned long cmd, void *arg, int size, int copyback);
-static void	__stli_sendcmd(stlibrd_t *brdp, stliport_t *portp, unsigned long cmd, void *arg, int size, int copyback);
-static void	stli_dodelaycmd(stliport_t *portp, cdkctrl_t __iomem *cp);
-static void	stli_mkasyport(stliport_t *portp, asyport_t *pp, struct ktermios *tiosp);
+static int	stli_setport(struct stliport *portp);
+static int	stli_cmdwait(struct stlibrd *brdp, struct stliport *portp, unsigned long cmd, void *arg, int size, int copyback);
+static void	stli_sendcmd(struct stlibrd *brdp, struct stliport *portp, unsigned long cmd, void *arg, int size, int copyback);
+static void	__stli_sendcmd(struct stlibrd *brdp, struct stliport *portp, unsigned long cmd, void *arg, int size, int copyback);
+static void	stli_dodelaycmd(struct stliport *portp, cdkctrl_t __iomem *cp);
+static void	stli_mkasyport(struct stliport *portp, asyport_t *pp, struct ktermios *tiosp);
 static void	stli_mkasysigs(asysigs_t *sp, int dtr, int rts);
 static long	stli_mktiocm(unsigned long sigvalue);
-static void	stli_read(stlibrd_t *brdp, stliport_t *portp);
-static int	stli_getserial(stliport_t *portp, struct serial_struct __user *sp);
-static int	stli_setserial(stliport_t *portp, struct serial_struct __user *sp);
+static void	stli_read(struct stlibrd *brdp, struct stliport *portp);
+static int	stli_getserial(struct stliport *portp, struct serial_struct __user *sp);
+static int	stli_setserial(struct stliport *portp, struct serial_struct __user *sp);
 static int	stli_getbrdstats(combrd_t __user *bp);
-static int	stli_getportstats(stliport_t *portp, comstats_t __user *cp);
-static int	stli_portcmdstats(stliport_t *portp);
-static int	stli_clrportstats(stliport_t *portp, comstats_t __user *cp);
-static int	stli_getportstruct(stliport_t __user *arg);
-static int	stli_getbrdstruct(stlibrd_t __user *arg);
-static stlibrd_t *stli_allocbrd(void);
-
-static void	stli_ecpinit(stlibrd_t *brdp);
-static void	stli_ecpenable(stlibrd_t *brdp);
-static void	stli_ecpdisable(stlibrd_t *brdp);
-static void __iomem *stli_ecpgetmemptr(stlibrd_t *brdp, unsigned long offset, int line);
-static void	stli_ecpreset(stlibrd_t *brdp);
-static void	stli_ecpintr(stlibrd_t *brdp);
-static void	stli_ecpeiinit(stlibrd_t *brdp);
-static void	stli_ecpeienable(stlibrd_t *brdp);
-static void	stli_ecpeidisable(stlibrd_t *brdp);
-static void __iomem *stli_ecpeigetmemptr(stlibrd_t *brdp, unsigned long offset, int line);
-static void	stli_ecpeireset(stlibrd_t *brdp);
-static void	stli_ecpmcenable(stlibrd_t *brdp);
-static void	stli_ecpmcdisable(stlibrd_t *brdp);
-static void __iomem *stli_ecpmcgetmemptr(stlibrd_t *brdp, unsigned long offset, int line);
-static void	stli_ecpmcreset(stlibrd_t *brdp);
-static void	stli_ecppciinit(stlibrd_t *brdp);
-static void __iomem *stli_ecppcigetmemptr(stlibrd_t *brdp, unsigned long offset, int line);
-static void	stli_ecppcireset(stlibrd_t *brdp);
-
-static void	stli_onbinit(stlibrd_t *brdp);
-static void	stli_onbenable(stlibrd_t *brdp);
-static void	stli_onbdisable(stlibrd_t *brdp);
-static void __iomem *stli_onbgetmemptr(stlibrd_t *brdp, unsigned long offset, int line);
-static void	stli_onbreset(stlibrd_t *brdp);
-static void	stli_onbeinit(stlibrd_t *brdp);
-static void	stli_onbeenable(stlibrd_t *brdp);
-static void	stli_onbedisable(stlibrd_t *brdp);
-static void __iomem *stli_onbegetmemptr(stlibrd_t *brdp, unsigned long offset, int line);
-static void	stli_onbereset(stlibrd_t *brdp);
-static void	stli_bbyinit(stlibrd_t *brdp);
-static void __iomem *stli_bbygetmemptr(stlibrd_t *brdp, unsigned long offset, int line);
-static void	stli_bbyreset(stlibrd_t *brdp);
-static void	stli_stalinit(stlibrd_t *brdp);
-static void __iomem *stli_stalgetmemptr(stlibrd_t *brdp, unsigned long offset, int line);
-static void	stli_stalreset(stlibrd_t *brdp);
-
-static stliport_t *stli_getport(int brdnr, int panelnr, int portnr);
-
-static int	stli_initecp(stlibrd_t *brdp);
-static int	stli_initonb(stlibrd_t *brdp);
-static int	stli_eisamemprobe(stlibrd_t *brdp);
-static int	stli_initports(stlibrd_t *brdp);
+static int	stli_getportstats(struct stliport *portp, comstats_t __user *cp);
+static int	stli_portcmdstats(struct stliport *portp);
+static int	stli_clrportstats(struct stliport *portp, comstats_t __user *cp);
+static int	stli_getportstruct(struct stliport __user *arg);
+static int	stli_getbrdstruct(struct stlibrd __user *arg);
+static struct stlibrd *stli_allocbrd(void);
+
+static void	stli_ecpinit(struct stlibrd *brdp);
+static void	stli_ecpenable(struct stlibrd *brdp);
+static void	stli_ecpdisable(struct stlibrd *brdp);
+static void __iomem *stli_ecpgetmemptr(struct stlibrd *brdp, unsigned long offset, int line);
+static void	stli_ecpreset(struct stlibrd *brdp);
+static void	stli_ecpintr(struct stlibrd *brdp);
+static void	stli_ecpeiinit(struct stlibrd *brdp);
+static void	stli_ecpeienable(struct stlibrd *brdp);
+static void	stli_ecpeidisable(struct stlibrd *brdp);
+static void __iomem *stli_ecpeigetmemptr(struct stlibrd *brdp, unsigned long offset, int line);
+static void	stli_ecpeireset(struct stlibrd *brdp);
+static void	stli_ecpmcenable(struct stlibrd *brdp);
+static void	stli_ecpmcdisable(struct stlibrd *brdp);
+static void __iomem *stli_ecpmcgetmemptr(struct stlibrd *brdp, unsigned long offset, int line);
+static void	stli_ecpmcreset(struct stlibrd *brdp);
+static void	stli_ecppciinit(struct stlibrd *brdp);
+static void __iomem *stli_ecppcigetmemptr(struct stlibrd *brdp, unsigned long offset, int line);
+static void	stli_ecppcireset(struct stlibrd *brdp);
+
+static void	stli_onbinit(struct stlibrd *brdp);
+static void	stli_onbenable(struct stlibrd *brdp);
+static void	stli_onbdisable(struct stlibrd *brdp);
+static void __iomem *stli_onbgetmemptr(struct stlibrd *brdp, unsigned long offset, int line);
+static void	stli_onbreset(struct stlibrd *brdp);
+static void	stli_onbeinit(struct stlibrd *brdp);
+static void	stli_onbeenable(struct stlibrd *brdp);
+static void	stli_onbedisable(struct stlibrd *brdp);
+static void __iomem *stli_onbegetmemptr(struct stlibrd *brdp, unsigned long offset, int line);
+static void	stli_onbereset(struct stlibrd *brdp);
+static void	stli_bbyinit(struct stlibrd *brdp);
+static void __iomem *stli_bbygetmemptr(struct stlibrd *brdp, unsigned long offset, int line);
+static void	stli_bbyreset(struct stlibrd *brdp);
+static void	stli_stalinit(struct stlibrd *brdp);
+static void __iomem *stli_stalgetmemptr(struct stlibrd *brdp, unsigned long offset, int line);
+static void	stli_stalreset(struct stlibrd *brdp);
+
+static struct stliport *stli_getport(int brdnr, int panelnr, int portnr);
+
+static int	stli_initecp(struct stlibrd *brdp);
+static int	stli_initonb(struct stlibrd *brdp);
+static int	stli_eisamemprobe(struct stlibrd *brdp);
+static int	stli_initports(struct stlibrd *brdp);
 
 /*****************************************************************************/
 
@@ -727,9 +725,9 @@ #define	STLI_TIMEOUT	(jiffies + 1)
 
 static struct class *istallion_class;
 
-static void stli_cleanup_ports(stlibrd_t *brdp)
+static void stli_cleanup_ports(struct stlibrd *brdp)
 {
-	stliport_t *portp;
+	struct stliport *portp;
 	unsigned int j;
 
 	for (j = 0; j < STL_MAXPORTS; j++) {
@@ -756,7 +754,7 @@ static int __init istallion_module_init(
 
 static void __exit istallion_module_exit(void)
 {
-	stlibrd_t	*brdp;
+	struct stlibrd	*brdp;
 	int		i;
 
 	printk(KERN_INFO "Unloading %s: version %s\n", stli_drvtitle,
@@ -811,7 +809,7 @@ module_exit(istallion_module_exit);
  *	Parse the supplied argument string, into the board conf struct.
  */
 
-static int stli_parsebrd(stlconf_t *confp, char **argp)
+static int stli_parsebrd(struct stlconf *confp, char **argp)
 {
 	char *sp;
 	int i;
@@ -843,8 +841,8 @@ static int stli_parsebrd(stlconf_t *conf
 
 static int stli_open(struct tty_struct *tty, struct file *filp)
 {
-	stlibrd_t *brdp;
-	stliport_t *portp;
+	struct stlibrd *brdp;
+	struct stliport *portp;
 	unsigned int minordev;
 	int brdnr, portnr, rc;
 
@@ -938,8 +936,8 @@ static int stli_open(struct tty_struct *
 
 static void stli_close(struct tty_struct *tty, struct file *filp)
 {
-	stlibrd_t *brdp;
-	stliport_t *portp;
+	struct stlibrd *brdp;
+	struct stliport *portp;
 	unsigned long flags;
 
 	portp = tty->driver_data;
@@ -1016,7 +1014,7 @@ static void stli_close(struct tty_struct
  *	this still all happens pretty quickly.
  */
 
-static int stli_initopen(stlibrd_t *brdp, stliport_t *portp)
+static int stli_initopen(struct stlibrd *brdp, struct stliport *portp)
 {
 	struct tty_struct *tty;
 	asynotify_t nt;
@@ -1064,7 +1062,7 @@ static int stli_initopen(stlibrd_t *brdp
  *	to overlap.
  */
 
-static int stli_rawopen(stlibrd_t *brdp, stliport_t *portp, unsigned long arg, int wait)
+static int stli_rawopen(struct stlibrd *brdp, struct stliport *portp, unsigned long arg, int wait)
 {
 	cdkhdr_t __iomem *hdrp;
 	cdkctrl_t __iomem *cp;
@@ -1135,7 +1133,7 @@ static int stli_rawopen(stlibrd_t *brdp,
  *	wait is true then must have user context (to sleep).
  */
 
-static int stli_rawclose(stlibrd_t *brdp, stliport_t *portp, unsigned long arg, int wait)
+static int stli_rawclose(struct stlibrd *brdp, struct stliport *portp, unsigned long arg, int wait)
 {
 	cdkhdr_t __iomem *hdrp;
 	cdkctrl_t __iomem *cp;
@@ -1199,7 +1197,7 @@ static int stli_rawclose(stlibrd_t *brdp
  *	to complete (as opposed to initiating the command then returning).
  */
 
-static int stli_cmdwait(stlibrd_t *brdp, stliport_t *portp, unsigned long cmd, void *arg, int size, int copyback)
+static int stli_cmdwait(struct stlibrd *brdp, struct stliport *portp, unsigned long cmd, void *arg, int size, int copyback)
 {
 	wait_event_interruptible(portp->raw_wait,
 			!test_bit(ST_CMDING, &portp->state));
@@ -1225,9 +1223,9 @@ static int stli_cmdwait(stlibrd_t *brdp,
  *	waiting for the command to complete - so must have user context.
  */
 
-static int stli_setport(stliport_t *portp)
+static int stli_setport(struct stliport *portp)
 {
-	stlibrd_t *brdp;
+	struct stlibrd *brdp;
 	asyport_t aport;
 
 	if (portp == NULL)
@@ -1251,7 +1249,7 @@ static int stli_setport(stliport_t *port
  *	maybe because if we are clocal then we don't need to wait...
  */
 
-static int stli_waitcarrier(stlibrd_t *brdp, stliport_t *portp, struct file *filp)
+static int stli_waitcarrier(struct stlibrd *brdp, struct stliport *portp, struct file *filp)
 {
 	unsigned long flags;
 	int rc, doclocal;
@@ -1316,8 +1314,8 @@ static int stli_write(struct tty_struct 
 	unsigned char __iomem *bits;
 	unsigned char __iomem *shbuf;
 	unsigned char *chbuf;
-	stliport_t *portp;
-	stlibrd_t *brdp;
+	struct stliport *portp;
+	struct stlibrd *brdp;
 	unsigned int len, stlen, head, tail, size;
 	unsigned long flags;
 
@@ -1423,8 +1421,8 @@ static void stli_flushchars(struct tty_s
 	unsigned char __iomem *bits;
 	cdkasy_t __iomem *ap;
 	struct tty_struct *cooktty;
-	stliport_t *portp;
-	stlibrd_t *brdp;
+	struct stliport *portp;
+	struct stlibrd *brdp;
 	unsigned int len, stlen, head, tail, size, count, cooksize;
 	unsigned char *buf;
 	unsigned char __iomem *shbuf;
@@ -1511,8 +1509,8 @@ static void stli_flushchars(struct tty_s
 static int stli_writeroom(struct tty_struct *tty)
 {
 	cdkasyrq_t __iomem *rp;
-	stliport_t *portp;
-	stlibrd_t *brdp;
+	struct stliport *portp;
+	struct stlibrd *brdp;
 	unsigned int head, tail, len;
 	unsigned long flags;
 
@@ -1564,8 +1562,8 @@ static int stli_writeroom(struct tty_str
 static int stli_charsinbuffer(struct tty_struct *tty)
 {
 	cdkasyrq_t __iomem *rp;
-	stliport_t *portp;
-	stlibrd_t *brdp;
+	struct stliport *portp;
+	struct stlibrd *brdp;
 	unsigned int head, tail, len;
 	unsigned long flags;
 
@@ -1602,10 +1600,10 @@ static int stli_charsinbuffer(struct tty
  *	Generate the serial struct info.
  */
 
-static int stli_getserial(stliport_t *portp, struct serial_struct __user *sp)
+static int stli_getserial(struct stliport *portp, struct serial_struct __user *sp)
 {
 	struct serial_struct sio;
-	stlibrd_t *brdp;
+	struct stlibrd *brdp;
 
 	memset(&sio, 0, sizeof(struct serial_struct));
 	sio.type = PORT_UNKNOWN;
@@ -1635,7 +1633,7 @@ static int stli_getserial(stliport_t *po
  *	just quietly ignore any requests to change irq, etc.
  */
 
-static int stli_setserial(stliport_t *portp, struct serial_struct __user *sp)
+static int stli_setserial(struct stliport *portp, struct serial_struct __user *sp)
 {
 	struct serial_struct sio;
 	int rc;
@@ -1666,8 +1664,8 @@ static int stli_setserial(stliport_t *po
 
 static int stli_tiocmget(struct tty_struct *tty, struct file *file)
 {
-	stliport_t *portp = tty->driver_data;
-	stlibrd_t *brdp;
+	struct stliport *portp = tty->driver_data;
+	struct stlibrd *brdp;
 	int rc;
 
 	if (portp == NULL)
@@ -1690,8 +1688,8 @@ static int stli_tiocmget(struct tty_stru
 static int stli_tiocmset(struct tty_struct *tty, struct file *file,
 			 unsigned int set, unsigned int clear)
 {
-	stliport_t *portp = tty->driver_data;
-	stlibrd_t *brdp;
+	struct stliport *portp = tty->driver_data;
+	struct stlibrd *brdp;
 	int rts = -1, dtr = -1;
 
 	if (portp == NULL)
@@ -1721,8 +1719,8 @@ static int stli_tiocmset(struct tty_stru
 
 static int stli_ioctl(struct tty_struct *tty, struct file *file, unsigned int cmd, unsigned long arg)
 {
-	stliport_t *portp;
-	stlibrd_t *brdp;
+	struct stliport *portp;
+	struct stlibrd *brdp;
 	unsigned int ival;
 	int rc;
 	void __user *argp = (void __user *)arg;
@@ -1798,8 +1796,8 @@ static int stli_ioctl(struct tty_struct 
 
 static void stli_settermios(struct tty_struct *tty, struct ktermios *old)
 {
-	stliport_t *portp;
-	stlibrd_t *brdp;
+	struct stliport *portp;
+	struct stlibrd *brdp;
 	struct ktermios *tiosp;
 	asyport_t aport;
 
@@ -1844,7 +1842,7 @@ static void stli_settermios(struct tty_s
 
 static void stli_throttle(struct tty_struct *tty)
 {
-	stliport_t	*portp = tty->driver_data;
+	struct stliport	*portp = tty->driver_data;
 	if (portp == NULL)
 		return;
 	set_bit(ST_RXSTOP, &portp->state);
@@ -1860,7 +1858,7 @@ static void stli_throttle(struct tty_str
 
 static void stli_unthrottle(struct tty_struct *tty)
 {
-	stliport_t	*portp = tty->driver_data;
+	struct stliport	*portp = tty->driver_data;
 	if (portp == NULL)
 		return;
 	clear_bit(ST_RXSTOP, &portp->state);
@@ -1899,7 +1897,7 @@ static void stli_start(struct tty_struct
 
 static void stli_dohangup(void *arg)
 {
-	stliport_t *portp = (stliport_t *) arg;
+	struct stliport *portp = (struct stliport *) arg;
 	if (portp->tty != NULL) {
 		tty_hangup(portp->tty);
 	}
@@ -1916,8 +1914,8 @@ static void stli_dohangup(void *arg)
 
 static void stli_hangup(struct tty_struct *tty)
 {
-	stliport_t *portp;
-	stlibrd_t *brdp;
+	struct stliport *portp;
+	struct stlibrd *brdp;
 	unsigned long flags;
 
 	portp = tty->driver_data;
@@ -1969,8 +1967,8 @@ static void stli_hangup(struct tty_struc
 
 static void stli_flushbuffer(struct tty_struct *tty)
 {
-	stliport_t *portp;
-	stlibrd_t *brdp;
+	struct stliport *portp;
+	struct stlibrd *brdp;
 	unsigned long ftype, flags;
 
 	portp = tty->driver_data;
@@ -2006,8 +2004,8 @@ static void stli_flushbuffer(struct tty_
 
 static void stli_breakctl(struct tty_struct *tty, int state)
 {
-	stlibrd_t	*brdp;
-	stliport_t	*portp;
+	struct stlibrd	*brdp;
+	struct stliport	*portp;
 	long		arg;
 
 	portp = tty->driver_data;
@@ -2027,7 +2025,7 @@ static void stli_breakctl(struct tty_str
 
 static void stli_waituntilsent(struct tty_struct *tty, int timeout)
 {
-	stliport_t *portp;
+	struct stliport *portp;
 	unsigned long tend;
 
 	if (tty == NULL)
@@ -2053,8 +2051,8 @@ static void stli_waituntilsent(struct tt
 
 static void stli_sendxchar(struct tty_struct *tty, char ch)
 {
-	stlibrd_t	*brdp;
-	stliport_t	*portp;
+	struct stlibrd	*brdp;
+	struct stliport	*portp;
 	asyctrl_t	actrl;
 
 	portp = tty->driver_data;
@@ -2088,7 +2086,7 @@ #define	MAXLINE		80
  *	short then padded with spaces).
  */
 
-static int stli_portinfo(stlibrd_t *brdp, stliport_t *portp, int portnr, char *pos)
+static int stli_portinfo(struct stlibrd *brdp, struct stliport *portp, int portnr, char *pos)
 {
 	char *sp, *uart;
 	int rc, cnt;
@@ -2151,8 +2149,8 @@ static int stli_portinfo(stlibrd_t *brdp
 
 static int stli_readproc(char *page, char **start, off_t off, int count, int *eof, void *data)
 {
-	stlibrd_t *brdp;
-	stliport_t *portp;
+	struct stlibrd *brdp;
+	struct stliport *portp;
 	int brdnr, portnr, totalport;
 	int curoff, maxoff;
 	char *pos;
@@ -2223,7 +2221,7 @@ stli_readdone:
  *	entry point)
  */
 
-static void __stli_sendcmd(stlibrd_t *brdp, stliport_t *portp, unsigned long cmd, void *arg, int size, int copyback)
+static void __stli_sendcmd(struct stlibrd *brdp, struct stliport *portp, unsigned long cmd, void *arg, int size, int copyback)
 {
 	cdkhdr_t __iomem *hdrp;
 	cdkctrl_t __iomem *cp;
@@ -2259,7 +2257,7 @@ static void __stli_sendcmd(stlibrd_t *br
 	spin_unlock_irqrestore(&brd_lock, flags);
 }
 
-static void stli_sendcmd(stlibrd_t *brdp, stliport_t *portp, unsigned long cmd, void *arg, int size, int copyback)
+static void stli_sendcmd(struct stlibrd *brdp, struct stliport *portp, unsigned long cmd, void *arg, int size, int copyback)
 {
 	unsigned long		flags;
 
@@ -2278,7 +2276,7 @@ static void stli_sendcmd(stlibrd_t *brdp
  *	more chars to unload.
  */
 
-static void stli_read(stlibrd_t *brdp, stliport_t *portp)
+static void stli_read(struct stlibrd *brdp, struct stliport *portp)
 {
 	cdkasyrq_t __iomem *rp;
 	char __iomem *shbuf;
@@ -2340,7 +2338,7 @@ static void stli_read(stlibrd_t *brdp, s
  *	difficult to deal with them here.
  */
 
-static void stli_dodelaycmd(stliport_t *portp, cdkctrl_t __iomem *cp)
+static void stli_dodelaycmd(struct stliport *portp, cdkctrl_t __iomem *cp)
 {
 	int cmd;
 
@@ -2388,7 +2386,7 @@ static void stli_dodelaycmd(stliport_t *
  *	then port is still busy, otherwise no longer busy.
  */
 
-static int stli_hostcmd(stlibrd_t *brdp, stliport_t *portp)
+static int stli_hostcmd(struct stlibrd *brdp, struct stliport *portp)
 {
 	cdkasy_t __iomem *ap;
 	cdkctrl_t __iomem *cp;
@@ -2535,9 +2533,9 @@ static int stli_hostcmd(stlibrd_t *brdp,
  *	at the cdk header structure.
  */
 
-static void stli_brdpoll(stlibrd_t *brdp, cdkhdr_t __iomem *hdrp)
+static void stli_brdpoll(struct stlibrd *brdp, cdkhdr_t __iomem *hdrp)
 {
-	stliport_t *portp;
+	struct stliport *portp;
 	unsigned char hostbits[(STL_MAXCHANS / 8) + 1];
 	unsigned char slavebits[(STL_MAXCHANS / 8) + 1];
 	unsigned char __iomem *slavep;
@@ -2604,7 +2602,7 @@ static void stli_brdpoll(stlibrd_t *brdp
 static void stli_poll(unsigned long arg)
 {
 	cdkhdr_t __iomem *hdrp;
-	stlibrd_t *brdp;
+	struct stlibrd *brdp;
 	int brdnr;
 
 	stli_timerlist.expires = STLI_TIMEOUT;
@@ -2637,7 +2635,7 @@ static void stli_poll(unsigned long arg)
  *	the slave.
  */
 
-static void stli_mkasyport(stliport_t *portp, asyport_t *pp, struct ktermios *tiosp)
+static void stli_mkasyport(struct stliport *portp, asyport_t *pp, struct ktermios *tiosp)
 {
 	memset(pp, 0, sizeof(asyport_t));
 
@@ -2786,13 +2784,13 @@ static long stli_mktiocm(unsigned long s
  *	we need to do here is set up the appropriate per port data structures.
  */
 
-static int stli_initports(stlibrd_t *brdp)
+static int stli_initports(struct stlibrd *brdp)
 {
-	stliport_t	*portp;
+	struct stliport	*portp;
 	int		i, panelnr, panelport;
 
 	for (i = 0, panelnr = 0, panelport = 0; (i < brdp->nrports); i++) {
-		portp = kzalloc(sizeof(stliport_t), GFP_KERNEL);
+		portp = kzalloc(sizeof(struct stliport), GFP_KERNEL);
 		if (!portp) {
 			printk("STALLION: failed to allocate port structure\n");
 			continue;
@@ -2826,7 +2824,7 @@ static int stli_initports(stlibrd_t *brd
  *	All the following routines are board specific hardware operations.
  */
 
-static void stli_ecpinit(stlibrd_t *brdp)
+static void stli_ecpinit(struct stlibrd *brdp)
 {
 	unsigned long	memconf;
 
@@ -2841,21 +2839,21 @@ static void stli_ecpinit(stlibrd_t *brdp
 
 /*****************************************************************************/
 
-static void stli_ecpenable(stlibrd_t *brdp)
+static void stli_ecpenable(struct stlibrd *brdp)
 {	
 	outb(ECP_ATENABLE, (brdp->iobase + ECP_ATCONFR));
 }
 
 /*****************************************************************************/
 
-static void stli_ecpdisable(stlibrd_t *brdp)
+static void stli_ecpdisable(struct stlibrd *brdp)
 {	
 	outb(ECP_ATDISABLE, (brdp->iobase + ECP_ATCONFR));
 }
 
 /*****************************************************************************/
 
-static void __iomem *stli_ecpgetmemptr(stlibrd_t *brdp, unsigned long offset, int line)
+static void __iomem *stli_ecpgetmemptr(struct stlibrd *brdp, unsigned long offset, int line)
 {	
 	void __iomem *ptr;
 	unsigned char val;
@@ -2876,7 +2874,7 @@ static void __iomem *stli_ecpgetmemptr(s
 
 /*****************************************************************************/
 
-static void stli_ecpreset(stlibrd_t *brdp)
+static void stli_ecpreset(struct stlibrd *brdp)
 {	
 	outb(ECP_ATSTOP, (brdp->iobase + ECP_ATCONFR));
 	udelay(10);
@@ -2886,7 +2884,7 @@ static void stli_ecpreset(stlibrd_t *brd
 
 /*****************************************************************************/
 
-static void stli_ecpintr(stlibrd_t *brdp)
+static void stli_ecpintr(struct stlibrd *brdp)
 {	
 	outb(0x1, brdp->iobase);
 }
@@ -2897,7 +2895,7 @@ static void stli_ecpintr(stlibrd_t *brdp
  *	The following set of functions act on ECP EISA boards.
  */
 
-static void stli_ecpeiinit(stlibrd_t *brdp)
+static void stli_ecpeiinit(struct stlibrd *brdp)
 {
 	unsigned long	memconf;
 
@@ -2915,21 +2913,21 @@ static void stli_ecpeiinit(stlibrd_t *br
 
 /*****************************************************************************/
 
-static void stli_ecpeienable(stlibrd_t *brdp)
+static void stli_ecpeienable(struct stlibrd *brdp)
 {	
 	outb(ECP_EIENABLE, (brdp->iobase + ECP_EICONFR));
 }
 
 /*****************************************************************************/
 
-static void stli_ecpeidisable(stlibrd_t *brdp)
+static void stli_ecpeidisable(struct stlibrd *brdp)
 {	
 	outb(ECP_EIDISABLE, (brdp->iobase + ECP_EICONFR));
 }
 
 /*****************************************************************************/
 
-static void __iomem *stli_ecpeigetmemptr(stlibrd_t *brdp, unsigned long offset, int line)
+static void __iomem *stli_ecpeigetmemptr(struct stlibrd *brdp, unsigned long offset, int line)
 {	
 	void __iomem *ptr;
 	unsigned char	val;
@@ -2953,7 +2951,7 @@ static void __iomem *stli_ecpeigetmemptr
 
 /*****************************************************************************/
 
-static void stli_ecpeireset(stlibrd_t *brdp)
+static void stli_ecpeireset(struct stlibrd *brdp)
 {	
 	outb(ECP_EISTOP, (brdp->iobase + ECP_EICONFR));
 	udelay(10);
@@ -2967,21 +2965,21 @@ static void stli_ecpeireset(stlibrd_t *b
  *	The following set of functions act on ECP MCA boards.
  */
 
-static void stli_ecpmcenable(stlibrd_t *brdp)
+static void stli_ecpmcenable(struct stlibrd *brdp)
 {	
 	outb(ECP_MCENABLE, (brdp->iobase + ECP_MCCONFR));
 }
 
 /*****************************************************************************/
 
-static void stli_ecpmcdisable(stlibrd_t *brdp)
+static void stli_ecpmcdisable(struct stlibrd *brdp)
 {	
 	outb(ECP_MCDISABLE, (brdp->iobase + ECP_MCCONFR));
 }
 
 /*****************************************************************************/
 
-static void __iomem *stli_ecpmcgetmemptr(stlibrd_t *brdp, unsigned long offset, int line)
+static void __iomem *stli_ecpmcgetmemptr(struct stlibrd *brdp, unsigned long offset, int line)
 {	
 	void __iomem *ptr;
 	unsigned char val;
@@ -3002,7 +3000,7 @@ static void __iomem *stli_ecpmcgetmemptr
 
 /*****************************************************************************/
 
-static void stli_ecpmcreset(stlibrd_t *brdp)
+static void stli_ecpmcreset(struct stlibrd *brdp)
 {	
 	outb(ECP_MCSTOP, (brdp->iobase + ECP_MCCONFR));
 	udelay(10);
@@ -3016,7 +3014,7 @@ static void stli_ecpmcreset(stlibrd_t *b
  *	The following set of functions act on ECP PCI boards.
  */
 
-static void stli_ecppciinit(stlibrd_t *brdp)
+static void stli_ecppciinit(struct stlibrd *brdp)
 {
 	outb(ECP_PCISTOP, (brdp->iobase + ECP_PCICONFR));
 	udelay(10);
@@ -3026,7 +3024,7 @@ static void stli_ecppciinit(stlibrd_t *b
 
 /*****************************************************************************/
 
-static void __iomem *stli_ecppcigetmemptr(stlibrd_t *brdp, unsigned long offset, int line)
+static void __iomem *stli_ecppcigetmemptr(struct stlibrd *brdp, unsigned long offset, int line)
 {	
 	void __iomem *ptr;
 	unsigned char	val;
@@ -3047,7 +3045,7 @@ static void __iomem *stli_ecppcigetmempt
 
 /*****************************************************************************/
 
-static void stli_ecppcireset(stlibrd_t *brdp)
+static void stli_ecppcireset(struct stlibrd *brdp)
 {	
 	outb(ECP_PCISTOP, (brdp->iobase + ECP_PCICONFR));
 	udelay(10);
@@ -3061,7 +3059,7 @@ static void stli_ecppcireset(stlibrd_t *
  *	The following routines act on ONboards.
  */
 
-static void stli_onbinit(stlibrd_t *brdp)
+static void stli_onbinit(struct stlibrd *brdp)
 {
 	unsigned long	memconf;
 
@@ -3078,21 +3076,21 @@ static void stli_onbinit(stlibrd_t *brdp
 
 /*****************************************************************************/
 
-static void stli_onbenable(stlibrd_t *brdp)
+static void stli_onbenable(struct stlibrd *brdp)
 {	
 	outb((brdp->enabval | ONB_ATENABLE), (brdp->iobase + ONB_ATCONFR));
 }
 
 /*****************************************************************************/
 
-static void stli_onbdisable(stlibrd_t *brdp)
+static void stli_onbdisable(struct stlibrd *brdp)
 {	
 	outb((brdp->enabval | ONB_ATDISABLE), (brdp->iobase + ONB_ATCONFR));
 }
 
 /*****************************************************************************/
 
-static void __iomem *stli_onbgetmemptr(stlibrd_t *brdp, unsigned long offset, int line)
+static void __iomem *stli_onbgetmemptr(struct stlibrd *brdp, unsigned long offset, int line)
 {	
 	void __iomem *ptr;
 
@@ -3109,7 +3107,7 @@ static void __iomem *stli_onbgetmemptr(s
 
 /*****************************************************************************/
 
-static void stli_onbreset(stlibrd_t *brdp)
+static void stli_onbreset(struct stlibrd *brdp)
 {	
 	outb(ONB_ATSTOP, (brdp->iobase + ONB_ATCONFR));
 	udelay(10);
@@ -3123,7 +3121,7 @@ static void stli_onbreset(stlibrd_t *brd
  *	The following routines act on ONboard EISA.
  */
 
-static void stli_onbeinit(stlibrd_t *brdp)
+static void stli_onbeinit(struct stlibrd *brdp)
 {
 	unsigned long	memconf;
 
@@ -3143,21 +3141,21 @@ static void stli_onbeinit(stlibrd_t *brd
 
 /*****************************************************************************/
 
-static void stli_onbeenable(stlibrd_t *brdp)
+static void stli_onbeenable(struct stlibrd *brdp)
 {	
 	outb(ONB_EIENABLE, (brdp->iobase + ONB_EICONFR));
 }
 
 /*****************************************************************************/
 
-static void stli_onbedisable(stlibrd_t *brdp)
+static void stli_onbedisable(struct stlibrd *brdp)
 {	
 	outb(ONB_EIDISABLE, (brdp->iobase + ONB_EICONFR));
 }
 
 /*****************************************************************************/
 
-static void __iomem *stli_onbegetmemptr(stlibrd_t *brdp, unsigned long offset, int line)
+static void __iomem *stli_onbegetmemptr(struct stlibrd *brdp, unsigned long offset, int line)
 {	
 	void __iomem *ptr;
 	unsigned char val;
@@ -3181,7 +3179,7 @@ static void __iomem *stli_onbegetmemptr(
 
 /*****************************************************************************/
 
-static void stli_onbereset(stlibrd_t *brdp)
+static void stli_onbereset(struct stlibrd *brdp)
 {	
 	outb(ONB_EISTOP, (brdp->iobase + ONB_EICONFR));
 	udelay(10);
@@ -3195,7 +3193,7 @@ static void stli_onbereset(stlibrd_t *br
  *	The following routines act on Brumby boards.
  */
 
-static void stli_bbyinit(stlibrd_t *brdp)
+static void stli_bbyinit(struct stlibrd *brdp)
 {
 	outb(BBY_ATSTOP, (brdp->iobase + BBY_ATCONFR));
 	udelay(10);
@@ -3207,7 +3205,7 @@ static void stli_bbyinit(stlibrd_t *brdp
 
 /*****************************************************************************/
 
-static void __iomem *stli_bbygetmemptr(stlibrd_t *brdp, unsigned long offset, int line)
+static void __iomem *stli_bbygetmemptr(struct stlibrd *brdp, unsigned long offset, int line)
 {	
 	void __iomem *ptr;
 	unsigned char val;
@@ -3222,7 +3220,7 @@ static void __iomem *stli_bbygetmemptr(s
 
 /*****************************************************************************/
 
-static void stli_bbyreset(stlibrd_t *brdp)
+static void stli_bbyreset(struct stlibrd *brdp)
 {	
 	outb(BBY_ATSTOP, (brdp->iobase + BBY_ATCONFR));
 	udelay(10);
@@ -3236,7 +3234,7 @@ static void stli_bbyreset(stlibrd_t *brd
  *	The following routines act on original old Stallion boards.
  */
 
-static void stli_stalinit(stlibrd_t *brdp)
+static void stli_stalinit(struct stlibrd *brdp)
 {
 	outb(0x1, brdp->iobase);
 	mdelay(1000);
@@ -3244,7 +3242,7 @@ static void stli_stalinit(stlibrd_t *brd
 
 /*****************************************************************************/
 
-static void __iomem *stli_stalgetmemptr(stlibrd_t *brdp, unsigned long offset, int line)
+static void __iomem *stli_stalgetmemptr(struct stlibrd *brdp, unsigned long offset, int line)
 {	
 	BUG_ON(offset > brdp->memsize);
 	return brdp->membase + (offset % STAL_PAGESIZE);
@@ -3252,7 +3250,7 @@ static void __iomem *stli_stalgetmemptr(
 
 /*****************************************************************************/
 
-static void stli_stalreset(stlibrd_t *brdp)
+static void stli_stalreset(struct stlibrd *brdp)
 {	
 	u32 __iomem *vecp;
 
@@ -3269,7 +3267,7 @@ static void stli_stalreset(stlibrd_t *br
  *	board types.
  */
 
-static int stli_initecp(stlibrd_t *brdp)
+static int stli_initecp(struct stlibrd *brdp)
 {
 	cdkecpsig_t sig;
 	cdkecpsig_t __iomem *sigsp;
@@ -3415,7 +3413,7 @@ static int stli_initecp(stlibrd_t *brdp)
  *	This handles only these board types.
  */
 
-static int stli_initonb(stlibrd_t *brdp)
+static int stli_initonb(struct stlibrd *brdp)
 {
 	cdkonbsig_t sig;
 	cdkonbsig_t __iomem *sigsp;
@@ -3566,13 +3564,13 @@ static int stli_initonb(stlibrd_t *brdp)
  *	read in the memory map, and get the show on the road...
  */
 
-static int stli_startbrd(stlibrd_t *brdp)
+static int stli_startbrd(struct stlibrd *brdp)
 {
 	cdkhdr_t __iomem *hdrp;
 	cdkmem_t __iomem *memp;
 	cdkasy_t __iomem *ap;
 	unsigned long flags;
-	stliport_t *portp;
+	struct stliport *portp;
 	int portnr, nrdevs, i, rc = 0;
 	u32 memoff;
 
@@ -3673,7 +3671,7 @@ stli_donestartup:
  *	Probe and initialize the specified board.
  */
 
-static int __devinit stli_brdinit(stlibrd_t *brdp)
+static int __devinit stli_brdinit(struct stlibrd *brdp)
 {
 	stli_brds[brdp->brdnr] = brdp;
 
@@ -3720,7 +3718,7 @@ static int __devinit stli_brdinit(stlibr
  *	might be. This is a bit if hack, but it is the best we can do.
  */
 
-static int stli_eisamemprobe(stlibrd_t *brdp)
+static int stli_eisamemprobe(struct stlibrd *brdp)
 {
 	cdkecpsig_t	ecpsig, __iomem *ecpsigp;
 	cdkonbsig_t	onbsig, __iomem *onbsigp;
@@ -3835,7 +3833,7 @@ static int stli_getbrdnr(void)
 
 static int stli_findeisabrds(void)
 {
-	stlibrd_t *brdp;
+	struct stlibrd *brdp;
 	unsigned int iobase, eid;
 	int i;
 
@@ -3912,7 +3910,7 @@ static int stli_findeisabrds(void)
 static int __devinit stli_pciprobe(struct pci_dev *pdev,
 		const struct pci_device_id *ent)
 {
-	stlibrd_t *brdp;
+	struct stlibrd *brdp;
 	int retval = -EIO;
 
 	retval = pci_enable_device(pdev);
@@ -3951,7 +3949,7 @@ err:
 
 static void stli_pciremove(struct pci_dev *pdev)
 {
-	stlibrd_t *brdp = pci_get_drvdata(pdev);
+	struct stlibrd *brdp = pci_get_drvdata(pdev);
 
 	stli_cleanup_ports(brdp);
 
@@ -3975,14 +3973,14 @@ static struct pci_driver stli_pcidriver 
  *	Allocate a new board structure. Fill out the basic info in it.
  */
 
-static stlibrd_t *stli_allocbrd(void)
+static struct stlibrd *stli_allocbrd(void)
 {
-	stlibrd_t *brdp;
+	struct stlibrd *brdp;
 
-	brdp = kzalloc(sizeof(stlibrd_t), GFP_KERNEL);
+	brdp = kzalloc(sizeof(struct stlibrd), GFP_KERNEL);
 	if (!brdp) {
 		printk(KERN_ERR "STALLION: failed to allocate memory "
-				"(size=%Zd)\n", sizeof(stlibrd_t));
+				"(size=%Zd)\n", sizeof(struct stlibrd));
 		return NULL;
 	}
 	brdp->magic = STLI_BOARDMAGIC;
@@ -3998,8 +3996,8 @@ static stlibrd_t *stli_allocbrd(void)
 
 static int stli_initbrds(void)
 {
-	stlibrd_t *brdp, *nxtbrdp;
-	stlconf_t conf;
+	struct stlibrd *brdp, *nxtbrdp;
+	struct stlconf conf;
 	int i, j, retval;
 
 	for (stli_nrbrds = 0; stli_nrbrds < ARRAY_SIZE(stli_brdsp);
@@ -4075,7 +4073,7 @@ static ssize_t stli_memread(struct file 
 {
 	unsigned long flags;
 	void __iomem *memptr;
-	stlibrd_t *brdp;
+	struct stlibrd *brdp;
 	int brdnr, size, n;
 	void *p;
 	loff_t off = *offp;
@@ -4138,7 +4136,7 @@ static ssize_t stli_memwrite(struct file
 {
 	unsigned long flags;
 	void __iomem *memptr;
-	stlibrd_t *brdp;
+	struct stlibrd *brdp;
 	char __user *chbuf;
 	int brdnr, size, n;
 	void *p;
@@ -4199,7 +4197,7 @@ out:
 
 static int stli_getbrdstats(combrd_t __user *bp)
 {
-	stlibrd_t *brdp;
+	struct stlibrd *brdp;
 	int i;
 
 	if (copy_from_user(&stli_brdstats, bp, sizeof(combrd_t)))
@@ -4236,9 +4234,9 @@ static int stli_getbrdstats(combrd_t __u
  *	Resolve the referenced port number into a port struct pointer.
  */
 
-static stliport_t *stli_getport(int brdnr, int panelnr, int portnr)
+static struct stliport *stli_getport(int brdnr, int panelnr, int portnr)
 {
-	stlibrd_t *brdp;
+	struct stlibrd *brdp;
 	int i;
 
 	if (brdnr < 0 || brdnr >= STL_MAXBRDS)
@@ -4261,10 +4259,10 @@ static stliport_t *stli_getport(int brdn
  *	what port to get stats for (used through board control device).
  */
 
-static int stli_portcmdstats(stliport_t *portp)
+static int stli_portcmdstats(struct stliport *portp)
 {
 	unsigned long	flags;
-	stlibrd_t	*brdp;
+	struct stlibrd	*brdp;
 	int		rc;
 
 	memset(&stli_comstats, 0, sizeof(comstats_t));
@@ -4335,9 +4333,9 @@ static int stli_portcmdstats(stliport_t 
  *	what port to get stats for (used through board control device).
  */
 
-static int stli_getportstats(stliport_t *portp, comstats_t __user *cp)
+static int stli_getportstats(struct stliport *portp, comstats_t __user *cp)
 {
-	stlibrd_t *brdp;
+	struct stlibrd *brdp;
 	int rc;
 
 	if (!portp) {
@@ -4366,9 +4364,9 @@ static int stli_getportstats(stliport_t 
  *	Clear the port stats structure. We also return it zeroed out...
  */
 
-static int stli_clrportstats(stliport_t *portp, comstats_t __user *cp)
+static int stli_clrportstats(struct stliport *portp, comstats_t __user *cp)
 {
-	stlibrd_t *brdp;
+	struct stlibrd *brdp;
 	int rc;
 
 	if (!portp) {
@@ -4405,17 +4403,17 @@ static int stli_clrportstats(stliport_t 
  *	Return the entire driver ports structure to a user app.
  */
 
-static int stli_getportstruct(stliport_t __user *arg)
+static int stli_getportstruct(struct stliport __user *arg)
 {
-	stliport_t *portp;
+	struct stliport *portp;
 
-	if (copy_from_user(&stli_dummyport, arg, sizeof(stliport_t)))
+	if (copy_from_user(&stli_dummyport, arg, sizeof(struct stliport)))
 		return -EFAULT;
 	portp = stli_getport(stli_dummyport.brdnr, stli_dummyport.panelnr,
 		 stli_dummyport.portnr);
 	if (!portp)
 		return -ENODEV;
-	if (copy_to_user(arg, portp, sizeof(stliport_t)))
+	if (copy_to_user(arg, portp, sizeof(struct stliport)))
 		return -EFAULT;
 	return 0;
 }
@@ -4426,18 +4424,18 @@ static int stli_getportstruct(stliport_t
  *	Return the entire driver board structure to a user app.
  */
 
-static int stli_getbrdstruct(stlibrd_t __user *arg)
+static int stli_getbrdstruct(struct stlibrd __user *arg)
 {
-	stlibrd_t *brdp;
+	struct stlibrd *brdp;
 
-	if (copy_from_user(&stli_dummybrd, arg, sizeof(stlibrd_t)))
+	if (copy_from_user(&stli_dummybrd, arg, sizeof(struct stlibrd)))
 		return -EFAULT;
 	if ((stli_dummybrd.brdnr < 0) || (stli_dummybrd.brdnr >= STL_MAXBRDS))
 		return -ENODEV;
 	brdp = stli_brds[stli_dummybrd.brdnr];
 	if (!brdp)
 		return -ENODEV;
-	if (copy_to_user(arg, brdp, sizeof(stlibrd_t)))
+	if (copy_to_user(arg, brdp, sizeof(struct stlibrd)))
 		return -EFAULT;
 	return 0;
 }
@@ -4452,7 +4450,7 @@ static int stli_getbrdstruct(stlibrd_t _
 
 static int stli_memioctl(struct inode *ip, struct file *fp, unsigned int cmd, unsigned long arg)
 {
-	stlibrd_t *brdp;
+	struct stlibrd *brdp;
 	int brdnr, rc, done;
 	void __user *argp = (void __user *)arg;
 
diff --git a/include/linux/istallion.h b/include/linux/istallion.h
index b55e2a0..af2c32d 100644
--- a/include/linux/istallion.h
+++ b/include/linux/istallion.h
@@ -49,7 +49,7 @@ #define	STL_MAXDEVS		(STL_MAXBRDS * STL_
  *	communication with the slave board will always be on a per port
  *	basis.
  */
-typedef struct {
+struct stliport {
 	unsigned long		magic;
 	int			portnr;
 	int			panelnr;
@@ -72,7 +72,7 @@ typedef struct {
 	wait_queue_head_t	close_wait;
 	wait_queue_head_t	raw_wait;
 	struct work_struct	tqhangup;
-	asysigs_t		asig;
+	struct asysigs		asig;
 	unsigned long		addr;
 	unsigned long		rxoffset;
 	unsigned long		txoffset;
@@ -83,13 +83,13 @@ typedef struct {
 	unsigned char		reqbit;
 	unsigned char		portidx;
 	unsigned char		portbit;
-} stliport_t;
+};
 
 /*
  *	Use a structure of function pointers to do board level operations.
  *	These include, enable/disable, paging shared memory, interrupting, etc.
  */
-typedef struct stlibrd {
+struct stlibrd {
 	unsigned long	magic;
 	int		brdnr;
 	int		brdtype;
@@ -116,8 +116,8 @@ typedef struct stlibrd {
 	void		__iomem *(*getmemptr)(struct stlibrd *brdp, unsigned long offset, int line);
 	void		(*intr)(struct stlibrd *brdp);
 	void		(*reset)(struct stlibrd *brdp);
-	stliport_t	*ports[STL_MAXPORTS];
-} stlibrd_t;
+	struct stliport	*ports[STL_MAXPORTS];
+};
 
 
 /*
