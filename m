Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751221AbVIOUhA@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751221AbVIOUhA (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 15 Sep 2005 16:37:00 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751225AbVIOUhA
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 15 Sep 2005 16:37:00 -0400
Received: from turing-police.cirt.vt.edu ([128.173.54.129]:16264 "EHLO
	turing-police.cirt.vt.edu") by vger.kernel.org with ESMTP
	id S1751221AbVIOUg7 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 15 Sep 2005 16:36:59 -0400
Message-Id: <200509152036.j8FKapjw025768@turing-police.cc.vt.edu>
X-Mailer: exmh version 2.7.2 01/07/2005 with nmh-1.1-RC3
To: Nix <nix@esperi.org.uk>
Cc: David Lang <david.lang@digitalinsight.com>,
       Lee Revell <rlrevell@joe-job.com>, Hua Zhong <hzhong@gmail.com>,
       marekw1977@yahoo.com.au, linux-kernel@vger.kernel.org
Subject: Re: Automatic Configuration of a Kernel 
In-Reply-To: Your message of "Thu, 15 Sep 2005 15:58:38 BST."
             <87zmqextr5.fsf@amaterasu.srvr.nix> 
From: Valdis.Kletnieks@vt.edu
References: <20050914223836.53814.qmail@web51011.mail.yahoo.com> <6bffcb0e05091415533d563c5a@mail.gmail.com> <4328B710.5080503@in.tum.de> <200509151009.59981.marekw1977@yahoo.com.au> <924c288305091417375fea4ec2@mail.gmail.com> <Pine.LNX.4.62.0509141900280.8469@qynat.qvtvafvgr.pbz> <1126753444.13893.123.camel@mindpipe> <Pine.LNX.4.62.0509150313500.9384@qynat.qvtvafvgr.pbz>
            <87zmqextr5.fsf@amaterasu.srvr.nix>
Mime-Version: 1.0
Content-Type: multipart/signed; boundary="==_Exmh_1126816611_3148P";
	 micalg=pgp-sha1; protocol="application/pgp-signature"
Content-Transfer-Encoding: 7bit
Date: Thu, 15 Sep 2005 16:36:51 -0400
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

--==_Exmh_1126816611_3148P
Content-Type: text/plain; charset=us-ascii

On Thu, 15 Sep 2005 15:58:38 BST, Nix said:
> On 15 Sep 2005, David Lang yowled:
> > 5. once kmem and mem can be made read-only there is a security
> > advantage in not having kernel modules available (yes the machine can
> > be rebooted into a new kernel, but that's easier to detect then a
> > module getting loaded)
> 
> Here, have a small patch (against 2.6.12.x, but easily forward-portable)
> that eliminates that advantage:

Two comments:

1) This patch is pointless without other kernel magic to guarantee that
even root can't open /dev/kmem - either SELinux and/or the 'devmem.patch'
that's in current Fedora kernels.  There's well-known ways to do the equivalent of
an insmod even if the kernel is built with 'CONFIG_MODULES=n'.

2) Guess it's time to re-post my sysctl patch to provide a general-purpose
one-shot... (Diffed against 2.6.11-mm4, but applies cleanly to 2.6.13-mm1 as well).

--- cut here for patch

Quite often, we see re-inventions of "allow a sysctl until/unless a given
flag is set to zero/one".  The following code implements a general-purpose
one-shot facility to assist in building such "lockdown/jail" modes.

Usage: In a sysctl definition, we use something like:

int security_enable = 1;
int security_myflag = 0;

	{
	.ctl_name	= ,
	.procname	= "myflag",
	.data           = &security_myflag,
	.maxlen         = sizeof(security_myflag),
	.mode           = 0644,
	.proc_handler   = &proc_dointvec_gated,
	.extra1         = &security_enable,
	},
	{
	.ctl_name	= ,
	.procname	= "security_lock",
	.data		= &security_enable,
	.maxlen		= sizeof(security_enable),
	.mode		= 0644,
	.proc_handler	= &proc_dointvec_gated,
	.extra1		= &security_enable,
	}

Writes to myflag are allowed until a 0 is written to security_lock, at
which point both myflag and security_lock go read-only...

Signed-off-by:  <valdis.kletnieks@vt.edu>

--- linux-2.6.11-mm4/include/linux/sysctl.h.sysctl	2005-03-17 02:16:12.000000000 -0500
+++ linux-2.6.11-mm4/include/linux/sysctl.h	2005-03-17 02:17:02.000000000 -0500
@@ -798,6 +798,8 @@ extern int proc_dointvec(ctl_table *, in
 			 void __user *, size_t *, loff_t *);
 extern int proc_dointvec_bset(ctl_table *, int, struct file *,
 			      void __user *, size_t *, loff_t *);
+extern int proc_dointvec_gated(ctl_table *, int, struct file *,
+			void __user *, size_t *, loff_t *);
 extern int proc_dointvec_minmax(ctl_table *, int, struct file *,
 				void __user *, size_t *, loff_t *);
 extern int proc_dointvec_jiffies(ctl_table *, int, struct file *,
--- linux-2.6.11-mm4/kernel/sysctl.c.sysctl	2005-03-17 02:16:14.000000000 -0500
+++ linux-2.6.11-mm4/kernel/sysctl.c	2005-03-17 02:17:02.000000000 -0500
@@ -16,6 +16,7 @@
  *  Wendling.
  * The list_for_each() macro wasn't appropriate for the sysctl loop.
  *  Removed it and replaced it with older style, 03/23/00, Bill Wendling
+ * Added proc_dointvec_gated, 06/14/04, Valdis Kletnieks
  */
 
 #include <linux/config.h>
@@ -1693,6 +1694,37 @@ static int do_proc_dointvec_minmax_conv(
 }
 
 /**
+ * proc_dointvec_gated - read a vector of integers only if a specified flag
+ *		word is non-zero
+ * @table: the sysctl table
+ * @write: %TRUE if this is a write to the sysctl file
+ * @filp: the file structure
+ * @buffer: the user buffer
+ * @lenp: the size of the user buffer
+ *
+ * Reads/writes up to table->maxlen/sizeof(unsigned int) integer
+ * values from/to the user buffer, treated as an ASCII string.
+ *
+ * This is identical to proc_dointvec, except that we additionally
+ * check that the location pointed to by table->extra1 is non-zero
+ * (useful for creating a 'lockdown' sysctl that allows setting of
+ * the variable only until some specified condition is fulfilled).
+ *
+ * Returns 0 on success.
+ */
+int proc_dointvec_gated(ctl_table *table, int write, struct file *filp,
+		  void __user *buffer, size_t *lenp, loff_t *ppos)
+{
+	int *flag = (int *) (table->extra1);
+	if (write && flag && !(*flag)) {
+		return -EPERM;
+	}
+	return do_proc_dointvec(table, write, filp, buffer, lenp, ppos,
+				do_proc_dointvec_conv, NULL);
+}
+
+
+/**
  * proc_dointvec_minmax - read a vector of integers with min/max values
  * @table: the sysctl table
  * @write: %TRUE if this is a write to the sysctl file


--==_Exmh_1126816611_3148P
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.2 (GNU/Linux)
Comment: Exmh version 2.5 07/13/2001

iD8DBQFDKdtjcC3lWbTT17ARAh5YAKDjkuZHGOynGPiJbD1qXXdXtAwIjwCg48B+
6KlvkLT0kkF1y6zHyJWqz7A=
=dunm
-----END PGP SIGNATURE-----

--==_Exmh_1126816611_3148P--
