Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265483AbTIDSuR (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 4 Sep 2003 14:50:17 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265496AbTIDSuR
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 4 Sep 2003 14:50:17 -0400
Received: from fw.osdl.org ([65.172.181.6]:43241 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S265483AbTIDStu (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 4 Sep 2003 14:49:50 -0400
Date: Thu, 4 Sep 2003 11:49:22 -0700
From: Stephen Hemminger <shemminger@osdl.org>
To: "David S. Miller" <davem@redhat.com>
Cc: netdev@oss.sgi.com, linux-kernel@vger.kernel.org
Subject: [PATCH] convert /proc/net/unix to seq_file
Message-Id: <20030904114922.555841cd.shemminger@osdl.org>
Organization: Open Source Development Lab
X-Mailer: Sylpheed version 0.9.4claws (GTK+ 1.2.10; i686-pc-linux-gnu)
X-Face: &@E+xe?c%:&e4D{>f1O<&U>2qwRREG5!}7R4;D<"NO^UI2mJ[eEOA2*3>(`Th.yP,VDPo9$
 /`~cw![cmj~~jWe?AHY7D1S+\}5brN0k*NE?pPh_'_d>6;XGG[\KDRViCfumZT3@[
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Applies against 2.6.0-test4.


diff -Nru a/net/unix/af_unix.c b/net/unix/af_unix.c
--- a/net/unix/af_unix.c	Thu Sep  4 10:35:58 2003
+++ b/net/unix/af_unix.c	Thu Sep  4 10:35:58 2003
@@ -111,6 +111,7 @@
 #include <linux/tcp.h>
 #include <net/af_unix.h>
 #include <linux/proc_fs.h>
+#include <linux/seq_file.h>
 #include <net/scm.h>
 #include <linux/init.h>
 #include <linux/poll.h>
@@ -1805,25 +1806,52 @@
 
 
 #ifdef CONFIG_PROC_FS
-static int unix_read_proc(char *buffer, char **start, off_t offset,
-			  int length, int *eof, void *data)
+static struct sock *unix_seq_idx(int *iter, loff_t pos)
 {
-	off_t pos=0;
-	off_t begin=0;
-	int len=0;
-	int i;
+	loff_t off = 0;
 	struct sock *s;
-	
-	len+= sprintf(buffer,"Num       RefCount Protocol Flags    Type St "
-	    "Inode Path\n");
 
+	for (s = first_unix_socket(iter); s; s = next_unix_socket(iter, s)) {
+		if (off == pos) 
+			return s;
+		++off;
+	}
+	return NULL;
+}
+
+
+static void *unix_seq_start(struct seq_file *seq, loff_t *pos)
+{
 	read_lock(&unix_table_lock);
-	forall_unix_sockets (i,s)
-	{
+	return *pos ? unix_seq_idx(seq->private, *pos - 1) : ((void *) 1);
+}
+
+static void *unix_seq_next(struct seq_file *seq, void *v, loff_t *pos)
+{
+	++*pos;
+
+	if (v == (void *)1) 
+		return first_unix_socket(seq->private);
+	return next_unix_socket(seq->private, v);
+}
+
+static void unix_seq_stop(struct seq_file *seq, void *v)
+{
+	read_unlock(&unix_table_lock);
+}
+
+static int unix_seq_show(struct seq_file *seq, void *v)
+{
+	
+	if (v == (void *)1)
+		seq_puts(seq, "Num       RefCount Protocol Flags    Type St "
+			 "Inode Path\n");
+	else {
+		struct sock *s = v;
 		struct unix_sock *u = unix_sk(s);
 		unix_state_rlock(s);
 
-		len+=sprintf(buffer+len,"%p: %08X %08X %08X %04X %02X %5lu",
+		seq_printf(seq, "%p: %08X %08X %08X %04X %02X %5lu",
 			s,
 			atomic_read(&s->sk_refcnt),
 			0,
@@ -1835,39 +1863,61 @@
 			sock_i_ino(s));
 
 		if (u->addr) {
-			buffer[len++] = ' ';
-			memcpy(buffer+len, u->addr->name->sun_path,
-			       u->addr->len-sizeof(short));
-			if (!UNIX_ABSTRACT(s))
-				len--;
-			else
-				buffer[len] = '@';
-			len += u->addr->len - sizeof(short);
-		}
-		unix_state_runlock(s);
+			int i;
+			seq_putc(seq, ' ');
+			
+			for (i = 0; i < u->addr->len-sizeof(short); i++)
+				seq_putc(seq, u->addr->name->sun_path[i]);
 
-		buffer[len++]='\n';
-		
-		pos = begin + len;
-		if(pos<offset)
-		{
-			len=0;
-			begin=pos;
+			if (UNIX_ABSTRACT(s))
+				seq_putc(seq, '@');
 		}
-		if(pos>offset+length)
-			goto done;
+		unix_state_runlock(s);
+		seq_putc(seq, '\n');
 	}
-	*eof = 1;
-done:
-	read_unlock(&unix_table_lock);
-	*start=buffer+(offset-begin);
-	len-=(offset-begin);
-	if(len>length)
-		len=length;
-	if (len < 0)
-		len = 0;
-	return len;
+
+	return 0;
+}
+
+struct seq_operations unix_seq_ops = {
+	.start  = unix_seq_start,
+	.next   = unix_seq_next,
+	.stop   = unix_seq_stop,
+	.show   = unix_seq_show,
+};
+
+
+static int unix_seq_open(struct inode *inode, struct file *file)
+{
+	struct seq_file *seq;
+	int rc = -ENOMEM;
+	int *iter = kmalloc(sizeof(int), GFP_KERNEL);
+
+	if (!iter)
+		goto out;
+
+	rc = seq_open(file, &unix_seq_ops);
+	if (rc)
+		goto out_kfree;
+
+	seq	     = file->private_data;
+	seq->private = iter;
+	*iter = 0;
+out:
+	return rc;
+out_kfree:
+	kfree(iter);
+	goto out;
 }
+
+static struct file_operations unix_seq_fops = {
+	.owner		= THIS_MODULE,
+	.open		= unix_seq_open,
+	.read		= seq_read,
+	.llseek		= seq_lseek,
+	.release	= seq_release_private,
+};
+
 #endif
 
 struct proto_ops unix_stream_ops = {
@@ -1947,7 +1997,7 @@
 
 	sock_register(&unix_family_ops);
 #ifdef CONFIG_PROC_FS
-	create_proc_read_entry("net/unix", 0, 0, unix_read_proc, NULL);
+	proc_net_fops_create("unix", 0, &unix_seq_fops);
 #endif
 	unix_sysctl_register();
 	return 0;
@@ -1957,7 +2007,7 @@
 {
 	sock_unregister(PF_UNIX);
 	unix_sysctl_unregister();
-	remove_proc_entry("net/unix", 0);
+	proc_net_remove("unix");
 	kmem_cache_destroy(unix_sk_cachep);
 }
 
