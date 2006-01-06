Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1752547AbWAFUf6@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752547AbWAFUf6 (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 6 Jan 2006 15:35:58 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752554AbWAFUf6
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 6 Jan 2006 15:35:58 -0500
Received: from pasmtp.tele.dk ([193.162.159.95]:13066 "EHLO pasmtp.tele.dk")
	by vger.kernel.org with ESMTP id S1752547AbWAFUf5 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 6 Jan 2006 15:35:57 -0500
Date: Fri, 6 Jan 2006 21:35:44 +0100
From: Sam Ravnborg <sam@ravnborg.org>
To: Stephen Hemminger <shemminger@osdl.org>
Cc: Rusty Russell <rusty@rustycorp.com.au>, linux-kernel@vger.kernel.org
Subject: [PATCH) Re: command line parsing broken in 2.6.15-git?
Message-ID: <20060106203544.GB16372@mars.ravnborg.org>
References: <20060105163922.7806343b@dxpl.pdx.osdl.net> <5a4c581d0601051720w73132c89j218864dd4e313427@mail.gmail.com> <20060106113445.57ddaf7f@dxpl.pdx.osdl.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20060106113445.57ddaf7f@dxpl.pdx.osdl.net>
User-Agent: Mutt/1.5.11
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jan 06, 2006 at 11:34:45AM -0800, Stephen Hemminger wrote:
> On Fri, 6 Jan 2006 02:20:34 +0100
> Alessandro Suardi <alessandro.suardi@gmail.com> wrote:
> 
> > On 1/6/06, Stephen Hemminger <shemminger@osdl.org> wrote:
> > > The command line parsing or psmouse driver is broken now, this
> > > makes my mouse go wacky on a KVM. It worked up until the latest
> > > git updates (post 2.6.15)
> > >
> > > Dmesg output:
> > >
> > > Kernel command line: root=/dev/md2 vga=0x31a ro selinux=0 psmouse.proto=bare
> > > Unknown boot option `psmouse.proto=bare': ignoring
> > 
> > Similar issue here... my DVD drive disappeared in 2.6.15-git1 because
> >
> 
> Look at /sys/module directory. All the modules that gets compiled in is now being
> quoted. Looks like some macro screw up!
> 
> # ls /sys/module
> "8250"   ext3            iptable_nat  jbd        "psmouse"           skge
> ac       fan             ip_tables    lockd      raid0               sunrpc
> aic7xxx  "i8042"         ipt_limit    "md_mod"   raid1               "tcp_bic"
> battery  "ide_cd"        ipt_LOG      mii        reiserfs            thermal
> button   ip_conntrack    ipt_pkttype  nfnetlink  scsi_mod
> dm_mod   ip_nat          ipt_REJECT   nfs        scsi_transport_spi
> "drm"    iptable_filter  ipt_state    nfs_acl    sd_mod
> e100     iptable_mangle  ipv6         processor

This is my bad.
When I introduced the patch that made KBUILD_MODNAME quoted I only
un-stringnifyed the importent users, or I thought so.
But moduleparam.h was missing.

Attched patch fixes this.

	Sam


kbuild: un-stringnify KBUILD_MODNAME

Now when kbuild passes KBUILD_MODNAME with "" do not __stringify it when
used. Remove __stringnify for all users.
This also fixes the output of:

$ ls -l /sys/module/
drwxr-xr-x 4 root root 0 2006-01-05 14:24 pcmcia
drwxr-xr-x 4 root root 0 2006-01-05 14:24 pcmcia_core
drwxr-xr-x 3 root root 0 2006-01-05 14:24 "processor"
drwxr-xr-x 3 root root 0 2006-01-05 14:24 "psmouse"

The quoting of the module names will be gone again.
Thanks to GregKH + Kay Sievers for reproting this.

Signed-off-by: Sam Ravnborg <sam@ravnborg.org>

---
commit 367cb704212cd0c9273ba2b1e62523139210563b
tree cda6402ea19e2b706ad8ac9a186f1e391ab3c6ea
parent 20ede2741551d4a1d24313292beb0da915a55911
author Sam Ravnborg <sam@mars.ravnborg.org> Fri, 06 Jan 2006 21:17:50 +0100
committer Sam Ravnborg <sam@mars.ravnborg.org> Fri, 06 Jan 2006 21:17:50 +0100

 drivers/media/dvb/cinergyT2/cinergyT2.c |    2 +-
 drivers/media/dvb/ttpci/budget.h        |    2 +-
 drivers/media/video/tda9840.c           |    2 +-
 drivers/media/video/tea6415c.c          |    2 +-
 drivers/media/video/tea6420.c           |    2 +-
 include/linux/moduleparam.h             |    2 +-
 include/media/saa7146.h                 |    6 +++---
 net/ipv4/netfilter/ip_nat_ftp.c         |    2 +-
 net/ipv4/netfilter/ip_nat_irc.c         |    2 +-
 security/capability.c                   |    6 ++----
 10 files changed, 13 insertions(+), 15 deletions(-)

diff --git a/drivers/media/dvb/cinergyT2/cinergyT2.c b/drivers/media/dvb/cinergyT2/cinergyT2.c
index b996fb5..1d69bf0 100644
--- a/drivers/media/dvb/cinergyT2/cinergyT2.c
+++ b/drivers/media/dvb/cinergyT2/cinergyT2.c
@@ -60,7 +60,7 @@ MODULE_PARM_DESC(debug, "Turn on/off deb
 #define dprintk(level, args...)						\
 do {									\
 	if ((debug & level)) {						\
-		printk("%s: %s(): ", __stringify(KBUILD_MODNAME),	\
+		printk("%s: %s(): ", KBUILD_MODNAME,			\
 		       __FUNCTION__);					\
 		printk(args); }						\
 } while (0)
diff --git a/drivers/media/dvb/ttpci/budget.h b/drivers/media/dvb/ttpci/budget.h
index fdaa331..c8d48cf 100644
--- a/drivers/media/dvb/ttpci/budget.h
+++ b/drivers/media/dvb/ttpci/budget.h
@@ -19,7 +19,7 @@ extern int budget_debug;
 #endif
 
 #define dprintk(level,args...) \
-	    do { if ((budget_debug & level)) { printk("%s: %s(): ",__stringify(KBUILD_MODNAME), __FUNCTION__); printk(args); } } while (0)
+	    do { if ((budget_debug & level)) { printk("%s: %s(): ", KBUILD_MODNAME, __FUNCTION__); printk(args); } } while (0)
 
 struct budget_info {
 	char *name;
diff --git a/drivers/media/video/tda9840.c b/drivers/media/video/tda9840.c
index 1794686..0cb5c7e 100644
--- a/drivers/media/video/tda9840.c
+++ b/drivers/media/video/tda9840.c
@@ -34,7 +34,7 @@ static int debug = 0;		/* insmod paramet
 module_param(debug, int, 0644);
 MODULE_PARM_DESC(debug, "Turn on/off device debugging (default:off).");
 #define dprintk(args...) \
-            do { if (debug) { printk("%s: %s()[%d]: ",__stringify(KBUILD_MODNAME), __FUNCTION__, __LINE__); printk(args); } } while (0)
+            do { if (debug) { printk("%s: %s()[%d]: ", KBUILD_MODNAME, __FUNCTION__, __LINE__); printk(args); } } while (0)
 
 #define	SWITCH		0x00
 #define	LEVEL_ADJUST	0x02
diff --git a/drivers/media/video/tea6415c.c b/drivers/media/video/tea6415c.c
index ee36883..09149da 100644
--- a/drivers/media/video/tea6415c.c
+++ b/drivers/media/video/tea6415c.c
@@ -36,7 +36,7 @@ static int debug = 0;		/* insmod paramet
 module_param(debug, int, 0644);
 MODULE_PARM_DESC(debug, "Turn on/off device debugging (default:off).");
 #define dprintk(args...) \
-            do { if (debug) { printk("%s: %s()[%d]: ",__stringify(KBUILD_MODNAME), __FUNCTION__, __LINE__); printk(args); } } while (0)
+            do { if (debug) { printk("%s: %s()[%d]: ", KBUILD_MODNAME, __FUNCTION__, __LINE__); printk(args); } } while (0)
 
 #define TEA6415C_NUM_INPUTS	8
 #define TEA6415C_NUM_OUTPUTS	6
diff --git a/drivers/media/video/tea6420.c b/drivers/media/video/tea6420.c
index 17975c1..e908f91 100644
--- a/drivers/media/video/tea6420.c
+++ b/drivers/media/video/tea6420.c
@@ -36,7 +36,7 @@ static int debug = 0;		/* insmod paramet
 module_param(debug, int, 0644);
 MODULE_PARM_DESC(debug, "Turn on/off device debugging (default:off).");
 #define dprintk(args...) \
-            do { if (debug) { printk("%s: %s()[%d]: ",__stringify(KBUILD_MODNAME), __FUNCTION__, __LINE__); printk(args); } } while (0)
+            do { if (debug) { printk("%s: %s()[%d]: ", KBUILD_MODNAME, __FUNCTION__, __LINE__); printk(args); } } while (0)
 
 /* addresses to scan, found only at 0x4c and/or 0x4d (7-Bit) */
 static unsigned short normal_i2c[] = { I2C_TEA6420_1, I2C_TEA6420_2, I2C_CLIENT_END };
diff --git a/include/linux/moduleparam.h b/include/linux/moduleparam.h
index 368ec8e..b5c98c4 100644
--- a/include/linux/moduleparam.h
+++ b/include/linux/moduleparam.h
@@ -10,7 +10,7 @@
 #ifdef MODULE
 #define MODULE_PARAM_PREFIX /* empty */
 #else
-#define MODULE_PARAM_PREFIX __stringify(KBUILD_MODNAME) "."
+#define MODULE_PARAM_PREFIX KBUILD_MODNAME "."
 #endif
 
 #ifdef MODULE
diff --git a/include/media/saa7146.h b/include/media/saa7146.h
index e5be2b9..2bc634f 100644
--- a/include/media/saa7146.h
+++ b/include/media/saa7146.h
@@ -21,14 +21,14 @@
 
 extern unsigned int saa7146_debug;
 
-//#define DEBUG_PROLOG printk("(0x%08x)(0x%08x) %s: %s(): ",(dev==0?-1:(dev->mem==0?-1:saa7146_read(dev,RPS_ADDR0))),(dev==0?-1:(dev->mem==0?-1:saa7146_read(dev,IER))),__stringify(KBUILD_MODNAME),__FUNCTION__)
+//#define DEBUG_PROLOG printk("(0x%08x)(0x%08x) %s: %s(): ",(dev==0?-1:(dev->mem==0?-1:saa7146_read(dev,RPS_ADDR0))),(dev==0?-1:(dev->mem==0?-1:saa7146_read(dev,IER))),KBUILD_MODNAME,__FUNCTION__)
 
 #ifndef DEBUG_VARIABLE
 	#define DEBUG_VARIABLE saa7146_debug
 #endif
 
-#define DEBUG_PROLOG printk("%s: %s(): ",__stringify(KBUILD_MODNAME),__FUNCTION__)
-#define INFO(x) { printk("%s: ",__stringify(KBUILD_MODNAME)); printk x; }
+#define DEBUG_PROLOG printk("%s: %s(): ",KBUILD_MODNAME,__FUNCTION__)
+#define INFO(x) { printk("%s: ",KBUILD_MODNAME); printk x; }
 
 #define ERR(x) { DEBUG_PROLOG; printk x; }
 
diff --git a/net/ipv4/netfilter/ip_nat_ftp.c b/net/ipv4/netfilter/ip_nat_ftp.c
index d83757a..b8daab3 100644
--- a/net/ipv4/netfilter/ip_nat_ftp.c
+++ b/net/ipv4/netfilter/ip_nat_ftp.c
@@ -171,7 +171,7 @@ static int __init init(void)
 /* Prior to 2.6.11, we had a ports param.  No longer, but don't break users. */
 static int warn_set(const char *val, struct kernel_param *kp)
 {
-	printk(KERN_INFO __stringify(KBUILD_MODNAME)
+	printk(KERN_INFO KBUILD_MODNAME
 	       ": kernel >= 2.6.10 only uses 'ports' for conntrack modules\n");
 	return 0;
 }
diff --git a/net/ipv4/netfilter/ip_nat_irc.c b/net/ipv4/netfilter/ip_nat_irc.c
index de31942..461c833 100644
--- a/net/ipv4/netfilter/ip_nat_irc.c
+++ b/net/ipv4/netfilter/ip_nat_irc.c
@@ -113,7 +113,7 @@ static int __init init(void)
 /* Prior to 2.6.11, we had a ports param.  No longer, but don't break users. */
 static int warn_set(const char *val, struct kernel_param *kp)
 {
-	printk(KERN_INFO __stringify(KBUILD_MODNAME)
+	printk(KERN_INFO KBUILD_MODNAME
 	       ": kernel >= 2.6.10 only uses 'ports' for conntrack modules\n");
 	return 0;
 }
diff --git a/security/capability.c b/security/capability.c
index ec18d60..f9b35cc 100644
--- a/security/capability.c
+++ b/security/capability.c
@@ -49,8 +49,6 @@ static struct security_operations capabi
 	.vm_enough_memory =             cap_vm_enough_memory,
 };
 
-#define MY_NAME __stringify(KBUILD_MODNAME)
-
 /* flag to keep track of how we were registered */
 static int secondary;
 
@@ -67,7 +65,7 @@ static int __init capability_init (void)
 	/* register ourselves with the security framework */
 	if (register_security (&capability_ops)) {
 		/* try registering with primary module */
-		if (mod_reg_security (MY_NAME, &capability_ops)) {
+		if (mod_reg_security (KBUILD_MODNAME, &capability_ops)) {
 			printk (KERN_INFO "Failure registering capabilities "
 				"with primary security module.\n");
 			return -EINVAL;
@@ -85,7 +83,7 @@ static void __exit capability_exit (void
 		return;
 	/* remove ourselves from the security framework */
 	if (secondary) {
-		if (mod_unreg_security (MY_NAME, &capability_ops))
+		if (mod_unreg_security (KBUILD_MODNAME, &capability_ops))
 			printk (KERN_INFO "Failure unregistering capabilities "
 				"with primary module.\n");
 		return;
