Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S131127AbQLUOxj>; Thu, 21 Dec 2000 09:53:39 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S131088AbQLUOx2>; Thu, 21 Dec 2000 09:53:28 -0500
Received: from Cantor.suse.de ([194.112.123.193]:55058 "HELO Cantor.suse.de")
	by vger.kernel.org with SMTP id <S130281AbQLUOxS>;
	Thu, 21 Dec 2000 09:53:18 -0500
Date: Thu, 21 Dec 2000 15:22:49 +0100
From: "Dr. Werner Fink" <werner@suse.de>
To: Linus Torvalds <torvalds@transmeta.com>
Cc: Kurt Garloff <garloff@suse.de>, Alan Cox <alan@lxorguk.ukuu.org.uk>,
        miquels@cistron.nl, Linux kernel list <linux-kernel@vger.kernel.org>
Subject: Re: TIOCGDEV ioctl
Message-ID: <20001221152249.A12011@boole.suse.de>
Mail-Followup-To: "Dr. Werner Fink" <werner@suse.de>,
	Linus Torvalds <torvalds@transmeta.com>,
	Kurt Garloff <garloff@suse.de>, Alan Cox <alan@lxorguk.ukuu.org.uk>,
	miquels@cistron.nl, Linux kernel list <linux-kernel@vger.kernel.org>
In-Reply-To: <20001216015537.G21372@garloff.suse.de> <Pine.LNX.4.10.10012151710040.1325-100000@penguin.transmeta.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="BXVAT5kNtrzKuDFl"
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <Pine.LNX.4.10.10012151710040.1325-100000@penguin.transmeta.com>; from torvalds@transmeta.com on Fri, Dec 15, 2000 at 05:11:07PM -0800
Organization: SuSE GmbH
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--BXVAT5kNtrzKuDFl
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Fri, Dec 15, 2000 at 05:11:07PM -0800, Linus Torvalds wrote:
> 
> 
> On Sat, 16 Dec 2000, Kurt Garloff wrote:
> > 
> > The kernel provides this information -- sort of:
> > It contains the TIOCTTYGSTRUCT syscall which returns a struct. Of course,
> > it changes between different kernel archs and revisions, so using it is
> > an ugly hack. Grab for TIOCTTYGSTRUCT_HACK in the bootlogd.c file of the
> > sysvinit sources. Shudder!
> 
> Please instead do the same thing /dev/tty does, namely a sane interface
> that shows it as a symlink in /proc (or even in /dev)

Not a symlink but this is what is needed: if fd 0 of the current task is a
tty then give the hash of the tty.  I'm using fd 0 because current->tty may
not be set for spawned tasks of init.

I've attached two patches, one for 2.4 and one for 2.2.  They're rather
simple, therefore one may use this for setting a link.


        Werner

BTW: I'm missing a real replacement for my sys_revoke() patch done at the
end of October.  Al Viro has wipe it out but never shows an alternative way
of implementing such a beast.

--BXVAT5kNtrzKuDFl
Content-Type: text/plain; charset=us-ascii
Content-Description: linux-2.4-real-tty.patch
Content-Disposition: attachment; filename="2.4real-tty.patch"

--- fs/proc/proc_tty.c
+++ fs/proc/proc_tty.c	Thu Dec 21 15:16:08 2000
@@ -9,6 +9,7 @@
 #include <linux/init.h>
 #include <linux/errno.h>
 #include <linux/sched.h>
+#include <linux/file.h>
 #include <linux/proc_fs.h>
 #include <linux/stat.h>
 #include <linux/tty.h>
@@ -22,6 +23,8 @@
 				 int count, int *eof, void *data);
 static int tty_ldiscs_read_proc(char *page, char **start, off_t off,
 				int count, int *eof, void *data);
+static int real_tty_read_proc(char *page, char **start, off_t off,
+				int count, int *eof, void *data);
 
 /*
  * The /proc/tty directory inodes...
@@ -128,7 +131,32 @@
 }
 
 /*
- * Thsi function is called by register_tty_driver() to handle
+ * This is the handler for /proc/tty/tty
+ */
+static int real_tty_read_proc(char *page, char **start, off_t off,
+				int count, int *eof, void *data)
+{
+	struct	file * zero = fcheck(0); /* of current task */
+	struct	tty_struct * tty = NULL;
+	unsigned int dev = 0;
+	int	len = 0;
+	off_t	begin = 0;
+
+	if (zero)
+		tty = (struct tty_struct *)zero->private_data;
+	if (tty && tty->magic == TTY_MAGIC)
+		dev = kdev_t_to_nr(tty->device);
+
+	len += sprintf(page+len, "%u\n", dev);
+
+	if (off >= len+begin)
+		return 0;
+	*start = page + (off-begin);
+	return ((count < begin+len-off) ? count : begin+len-off);
+}
+
+/*
+ * This function is called by register_tty_driver() to handle
  * registering the driver's /proc handler into /proc/tty/driver/<foo>
  */
 void proc_tty_register_driver(struct tty_driver *driver)
@@ -178,4 +206,5 @@
 
 	create_proc_read_entry("tty/ldiscs", 0, 0, tty_ldiscs_read_proc,NULL);
 	create_proc_read_entry("tty/drivers", 0, 0, tty_drivers_read_proc,NULL);
+	create_proc_read_entry("tty/tty", 0, 0, real_tty_read_proc,NULL);
 }

--BXVAT5kNtrzKuDFl
Content-Type: text/plain; charset=us-ascii
Content-Description: linux-2.2-real-tty.patch
Content-Disposition: attachment; filename="2.2real-tty.patch"

--- fs/proc/proc_tty.c
+++ fs/proc/proc_tty.c	Thu Dec 21 15:14:12 2000
@@ -9,6 +9,7 @@
 #include <linux/init.h>
 #include <linux/errno.h>
 #include <linux/sched.h>
+#include <linux/file.h>
 #include <linux/proc_fs.h>
 #include <linux/stat.h>
 #include <linux/tty.h>
@@ -22,6 +23,8 @@
 				 int count, int *eof, void *data);
 static int tty_ldiscs_read_proc(char *page, char **start, off_t off,
 				int count, int *eof, void *data);
+static int real_tty_read_proc(char *page, char **start, off_t off,
+				 int count, int *eof, void *data);
 
 /*
  * The /proc/tty directory inodes...
@@ -128,7 +131,32 @@
 }
 
 /*
- * Thsi function is called by register_tty_driver() to handle
+ * This is the handler for /proc/tty/tty
+ */
+static int real_tty_read_proc(char *page, char **start, off_t off,
+				 int count, int *eof, void *data)
+{
+	struct	file * zero = fcheck_task(current, 0);
+	struct	tty_struct * tty = NULL;
+	unsigned int dev = 0;
+	int	len = 0;
+	off_t	begin = 0;
+
+	if (zero)
+		tty = (struct tty_struct *)zero->private_data;
+	if (tty && tty->magic == TTY_MAGIC)
+		dev = kdev_t_to_nr(tty->device);
+
+	len += sprintf(page+len, "%u\n", dev);
+
+	if (off >= len+begin)
+		return 0;
+	*start = page + (off-begin);
+	return ((count < begin+len-off) ? count : begin+len-off);
+}
+
+/*
+ * This function is called by register_tty_driver() to handle
  * registering the driver's /proc handler into /proc/tty/driver/<foo>
  */
 void proc_tty_register_driver(struct tty_driver *driver)
@@ -185,5 +213,7 @@
 
 	ent = create_proc_entry("tty/drivers", 0, 0);
 	ent->read_proc = tty_drivers_read_proc;
-}
 
+	ent = create_proc_entry("tty/tty", 0, 0);
+	ent->read_proc = real_tty_read_proc;
+}

--BXVAT5kNtrzKuDFl--
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
