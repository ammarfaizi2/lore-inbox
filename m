Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S263376AbTC2CNt>; Fri, 28 Mar 2003 21:13:49 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S263377AbTC2CNt>; Fri, 28 Mar 2003 21:13:49 -0500
Received: from parcelfarce.linux.theplanet.co.uk ([195.92.249.252]:52356 "EHLO
	www.linux.org.uk") by vger.kernel.org with ESMTP id <S263376AbTC2CNq>;
	Fri, 28 Mar 2003 21:13:46 -0500
Message-ID: <3E85040F.4080506@pobox.com>
Date: Fri, 28 Mar 2003 21:25:19 -0500
From: Jeff Garzik <jgarzik@pobox.com>
Organization: none
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.2.1) Gecko/20021213 Debian/1.2.1-2.bunk
X-Accept-Language: en
MIME-Version: 1.0
To: Marcelo Tosatti <marcelo@conectiva.com.br>
CC: lkml <linux-kernel@vger.kernel.org>, Alan Cox <alan@lxorguk.ukuu.org.uk>,
       Andrew Morton <akpm@digeo.com>
Subject: [BK/GNU] misc merges
Content-Type: multipart/mixed;
 boundary="------------040804020004030405010304"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is a multi-part message in MIME format.
--------------040804020004030405010304
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit

Marcelo,

Two small, misc patches.  The first helps battle stack overflow 
situations, and the second backports an akpm patch which greatly helps 
in remote debugging.

Both patches have been backported from 2.5, and tested in 2.4 also.
Please apply.

	Jeff


--------------040804020004030405010304
Content-Type: text/plain;
 name="misc-2.4.txt"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="misc-2.4.txt"

Linus, please do a

	bk pull bk://kernel.bkbits.net/jgarzik/misc-2.4

This will update the following files:

 Documentation/sysrq.txt |    4 ++++
 drivers/char/random.c   |    6 ++----
 fs/proc/proc_misc.c     |   28 ++++++++++++++++++++++++++++
 3 files changed, 34 insertions(+), 4 deletions(-)

through these ChangeSets:

<willy@debian.org> (03/03/28 1.1058)
   Reduce random.c stack usage

<akpm@digeo.com> (03/03/28 1.1057)
   /proc/sysrq-trigger: trigger sysrq functions via
   
   This makes sysrq facilities available to remote users.
   
   Writing a 'C' to /proc/sysrq-trigger receives the same treatment as typing
   sysrq-C on the local keyboard.


--------------040804020004030405010304
Content-Type: text/plain;
 name="patch1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="patch1"

diff -Nru a/Documentation/sysrq.txt b/Documentation/sysrq.txt
--- a/Documentation/sysrq.txt	Fri Mar 28 21:15:18 2003
+++ b/Documentation/sysrq.txt	Fri Mar 28 21:15:18 2003
@@ -36,6 +36,10 @@
 On other - If you know of the key combos for other architectures, please
            let me know so I can add them to this section.
 
+On all -  write a character to /proc/sysrq-trigger.  eg:
+
+		echo t > /proc/sysrq-trigger
+
 *  What are the 'command' keys?
 ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
 'r'     - Turns off keyboard raw mode and sets it to XLATE.
diff -Nru a/fs/proc/proc_misc.c b/fs/proc/proc_misc.c
--- a/fs/proc/proc_misc.c	Fri Mar 28 21:15:18 2003
+++ b/fs/proc/proc_misc.c	Fri Mar 28 21:15:18 2003
@@ -36,6 +36,7 @@
 #include <linux/init.h>
 #include <linux/smp_lock.h>
 #include <linux/seq_file.h>
+#include <linux/sysrq.h>
 
 #include <asm/uaccess.h>
 #include <asm/pgtable.h>
@@ -532,6 +533,28 @@
 	write:		write_profile,
 };
 
+#ifdef CONFIG_MAGIC_SYSRQ
+/*
+ * writing 'C' to /proc/sysrq-trigger is like sysrq-C
+ */
+static ssize_t write_sysrq_trigger(struct file *file, const char *buf,
+				     size_t count, loff_t *ppos)
+{
+	if (count) {
+		char c;
+
+		if (get_user(c, buf))
+			return -EFAULT;
+		handle_sysrq(c, NULL, NULL, NULL);
+	}
+	return count;
+}
+
+static struct file_operations proc_sysrq_trigger_operations = {
+	.write		= write_sysrq_trigger,
+};
+#endif
+
 struct proc_dir_entry *proc_root_kcore;
 
 static void create_seq_entry(char *name, mode_t mode, struct file_operations *f)
@@ -608,6 +631,11 @@
 			entry->size = (1+prof_len) * sizeof(unsigned int);
 		}
 	}
+#ifdef CONFIG_MAGIC_SYSRQ
+	entry = create_proc_entry("sysrq-trigger", S_IWUSR, NULL);
+	if (entry)
+		entry->proc_fops = &proc_sysrq_trigger_operations;
+#endif
 #ifdef CONFIG_PPC32
 	{
 		extern struct file_operations ppc_htab_operations;

--------------040804020004030405010304
Content-Type: text/plain;
 name="patch2"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="patch2"

diff -Nru a/drivers/char/random.c b/drivers/char/random.c
--- a/drivers/char/random.c	Fri Mar 28 21:15:26 2003
+++ b/drivers/char/random.c	Fri Mar 28 21:15:26 2003
@@ -1235,10 +1235,8 @@
  * at which point we do a "catastrophic reseeding".
  */
 static inline void xfer_secondary_pool(struct entropy_store *r,
-				       size_t nbytes)
+				       size_t nbytes, __u32 *tmp)
 {
-	__u32	tmp[TMP_BUF_SIZE];
-
 	if (r->entropy_count < nbytes * 8 &&
 	    r->entropy_count < r->poolinfo.POOLBITS) {
 		int nwords = min_t(int,
@@ -1291,7 +1289,7 @@
 		r->entropy_count = r->poolinfo.POOLBITS;
 
 	if (flags & EXTRACT_ENTROPY_SECONDARY)
-		xfer_secondary_pool(r, nbytes);
+		xfer_secondary_pool(r, nbytes, tmp);
 
 	DEBUG_ENT("%s has %d bits, want %d bits\n",
 		  r == sec_random_state ? "secondary" :

--------------040804020004030405010304--

