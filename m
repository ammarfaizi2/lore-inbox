Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262425AbSJ0PZm>; Sun, 27 Oct 2002 10:25:42 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262430AbSJ0PZm>; Sun, 27 Oct 2002 10:25:42 -0500
Received: from smtpout.mac.com ([204.179.120.87]:36321 "EHLO smtpout.mac.com")
	by vger.kernel.org with ESMTP id <S262425AbSJ0PZW>;
	Sun, 27 Oct 2002 10:25:22 -0500
Message-ID: <3DBC075B.AF32C23@mac.com>
Date: Sun, 27 Oct 2002 16:33:47 +0100
From: Peter Waechtler <pwaechtler@mac.com>
X-Mailer: Mozilla 4.8 [de] (X11; U; Linux 2.4.18-4GB-SMP i686)
X-Accept-Language: de, en
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org, jakub@redhat.com, torvalds@transmeta.com
Subject: [PATCH] unified SysV and Posix mqueues as FS
Content-Type: multipart/mixed;
 boundary="------------2C6609BA5B63E7B5E7A740EB"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Dies ist eine mehrteilige Nachricht im MIME-Format.
--------------2C6609BA5B63E7B5E7A740EB
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit

I applied the patch from Jakub against 2.5.44
There are still open issues but it's important to get this in before
feature freeze.

While you can implement Posix mqueues in userland (Irix is doing this
with fcntl(fd,F_SETLKW,) and shmem) a kernel implementation has some advantages:

a) no hassle with locks in case an app crashes
b) guaranteed notification with signals (you can have two apps with
	different uid that can acces the queue but aren't allowed to
	send signals)
c) surprisingly, seems a little faster - did not test with NPT


Open issues are:

- notification not tested
- still linear search in queues
- I would really enhance the sys_ipc for handling posix mqueue as well
	(yes, perhaps it's more ugly - but it fits naturally, you can't
	specify a priority with a read() - ending up with ioctl())
- funny "locking" in ipc/util.c 
- check the ipc ids
--------------2C6609BA5B63E7B5E7A740EB
Content-Type: text/plain; charset=iso-8859-1;
 name="posix-mqueue.txt"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline;
 filename="posix-mqueue.txt"

diff -Nur -X dontdiff vanilla-2.5.44/Documentation/ioctl-number.txt linux=
-2.5.44/Documentation/ioctl-number.txt
--- vanilla-2.5.44/Documentation/ioctl-number.txt	2002-04-20 18:22:08.000=
000000 +0200
+++ linux-2.5.44/Documentation/ioctl-number.txt	2002-10-27 15:33:23.00000=
0000 +0100
@@ -186,6 +186,7 @@
 0xB0	all	RATIO devices		in development:
 					<mailto:vgo@ratio.de>
 0xB1	00-1F	PPPoX			<mailto:mostrows@styx.uwaterloo.ca>
+0xB2	00-1F	linux/mqueue.h
 0xCB	00-1F	CBM serial IEC bus	in development:
 					<mailto:michael.klein@puffin.lb.shuttle.de>
 =

diff -Nur -X dontdiff vanilla-2.5.44/include/linux/mqueue.h linux-2.5.44/=
include/linux/mqueue.h
--- vanilla-2.5.44/include/linux/mqueue.h	1970-01-01 01:00:00.000000000 +=
0100
+++ linux-2.5.44/include/linux/mqueue.h	2002-10-23 14:48:31.000000000 +02=
00
@@ -0,0 +1,37 @@
+#ifndef _LINUX_MQUEUE_H
+#define _LINUX_MQUEUE_H
+
+#include <linux/types.h>
+#include <linux/ioctl.h>
+#include <asm/siginfo.h>
+
+struct mq_attr {
+	long	mq_flags;       /* O_NONBLOCK or 0 */
+	long	mq_maxmsg;      /* Maximum number of messages in the queue */
+	long	mq_msgsize;     /* Maximum size of one message in bytes */
+	long	mq_curmsgs;     /* Current number of messages in the queue */
+	long	__pad[2];
+};
+
+struct mq_open {
+	char            *mq_name;       /* pathname */
+	int             mq_oflag;       /* flags */
+	mode_t          mq_mode;        /* mode */
+	struct mq_attr  mq_attr;        /* attributes */
+};
+
+struct mq_sndrcv {
+	size_t          mq_len;         /* message length */
+	long            mq_type;        /* message type */
+	char            *mq_buf;        /* message buffer */
+};
+
+#define MQ_OPEN                _IOW(0xB2, 0, struct mq_open)
+#define MQ_GETATTR     _IOR(0xB2, 1, struct mq_attr)
+#define MQ_SEND                _IOW(0xB2, 2, struct mq_sndrcv)
+#define MQ_RECEIVE     _IOWR(0xB2, 3, struct mq_sndrcv)
+#define MQ_NOTIFY      _IOW(0xB2, 4, struct sigevent)
+
+#define MQ_DEFAULT_TYPE        0x7FFFFFFE
+
+#endif /* _LINUX_MQUEUE_H */
diff -Nur -X dontdiff vanilla-2.5.44/include/linux/msg.h linux-2.5.44/inc=
lude/linux/msg.h
--- vanilla-2.5.44/include/linux/msg.h	2002-08-10 00:09:02.000000000 +020=
0
+++ linux-2.5.44/include/linux/msg.h	2002-10-25 20:06:47.000000000 +0200
@@ -2,6 +2,7 @@
 #define _LINUX_MSG_H
 =

 #include <linux/ipc.h>
+#include <linux/signal.h>
 =

 /* ipcs ctl commands */
 #define MSG_STAT 11
@@ -49,7 +50,7 @@
 	unsigned short  msgseg; =

 };
 =

-#define MSGMNI    16   /* <=3D IPCMNI */     /* max # of msg queue ident=
ifiers */
+#define MSGMNI   128   /* <=3D IPCMNI */     /* max # of msg queue ident=
ifiers */
 #define MSGMAX  8192   /* <=3D INT_MAX */   /* max size of message (byte=
s) */
 #define MSGMNB 16384   /* <=3D INT_MAX */   /* default max size of a mes=
sage queue */
 =

@@ -63,33 +64,88 @@
 =

 #ifdef __KERNEL__
 =

+#define SEARCH_ANY		1
+#define SEARCH_EQUAL		2
+#define SEARCH_NOTEQUAL		3
+#define SEARCH_LESSEQUAL	4
+
+#define DATALEN_MSG	(PAGE_SIZE-sizeof(struct msg_msg))
+#define DATALEN_SEG	(PAGE_SIZE-sizeof(struct msg_msgseg))
+
+/* used  by sys_msgctl(,IPC_SET,) */
+struct msq_setbuf {
+	unsigned long	qbytes;
+	uid_t		uid;
+	gid_t		gid;
+	mode_t		mode;
+};
+
+/* one msg_receiver structure for each sleeping receiver */
+struct msg_receiver {
+	struct list_head r_list;
+	struct task_struct *r_tsk;
+
+	int r_mode;
+	long r_msgtype;
+	long r_maxsize;
+
+	struct msg_msg* volatile r_msg;
+};
+
+/* one msg_sender for each sleeping sender */
+struct msg_sender {
+	struct list_head list;
+	struct task_struct *tsk;
+};
+
+struct msg_msgseg {
+	struct msg_msgseg *next;
+	/* the next part of the message follows immediately */
+};
+
 /* one msg_msg structure for each message */
 struct msg_msg {
 	struct list_head m_list; =

 	long  m_type;          =

 	int m_ts;           /* message text size */
-	struct msg_msgseg* next;
+	struct msg_msgseg *next;
 	/* the actual message follows immediately */
 };
 =

-#define DATALEN_MSG	(PAGE_SIZE-sizeof(struct msg_msg))
-#define DATALEN_SEG	(PAGE_SIZE-sizeof(struct msg_msgseg))
+struct mq_link {
+	struct list_head link;
+	struct task_struct *tsk;
+	struct mq_attr *attr;
+};
 =

 /* one msq_queue structure for each present queue on the system */
 struct msg_queue {
 	struct kern_ipc_perm q_perm;
-	time_t q_stime;			/* last msgsnd time */
-	time_t q_rtime;			/* last msgrcv time */
-	time_t q_ctime;			/* last change time */
-	unsigned long q_cbytes;		/* current number of bytes on queue */
-	unsigned long q_qnum;		/* number of messages in queue */
-	unsigned long q_qbytes;		/* max number of bytes on queue */
-	pid_t q_lspid;			/* pid of last msgsnd */
-	pid_t q_lrpid;			/* last receive pid */
+#define q_flags q_perm.mode
+	time_t q_stime;         /* last msgsnd time */
+	time_t q_rtime;         /* last msgrcv time */
+	time_t q_ctime;         /* last change time */
+	unsigned long q_cbytes;     /* current number of bytes on queue */
+	unsigned long q_qnum;       /* number of messages in queue */
+	unsigned long q_qbytes;     /* max number of bytes on queue */
+
+	unsigned int q_msgsize;     /* max number of bytes for one message */
+	unsigned int q_maxmsg;      /* max number of outstanding messages */
+
+	pid_t q_lspid;          /* pid of last msgsnd */
+	pid_t q_lrpid;          /* last receive pid */
+
+	int q_signo;            /* signal to be sent if empty queue with no wai=
ting
+			                receivers should be sent */
+	pid_t q_pid;            /* to which pid */
+	sigval_t q_sigval;      /* which value to pass */
+	int id;
 =

 	struct list_head q_messages;
 	struct list_head q_receivers;
 	struct list_head q_senders;
+	unsigned int q_namelen;
+	unsigned char q_name[0];
 };
 =

 asmlinkage long sys_msgget (key_t key, int msgflg);
diff -Nur -X dontdiff vanilla-2.5.44/ipc/msg.c linux-2.5.44/ipc/msg.c
--- vanilla-2.5.44/ipc/msg.c	2002-10-13 23:03:57.000000000 +0200
+++ linux-2.5.44/ipc/msg.c	2002-10-27 15:42:12.000000000 +0100
@@ -13,15 +13,23 @@
  * mostly rewritten, threaded and wake-one semantics added
  * MSGMAX limit removed, sysctl's added
  * (c) 1999 Manfred Spraul <manfreds@colorfullife.com>
+ *
+ * make it a filesystem (based on Christoph Rohland's work on shmfs),
+ * (c) 2000 Jakub Jelinek <jakub@redhat.com>
+ * adapted and cleaned up for 2.5.44 by Peter W=E4chtler <pwaechtler@mac=
=2Ecom>
  */
 =

 #include <linux/config.h>
 #include <linux/slab.h>
-#include <linux/msg.h>
 #include <linux/spinlock.h>
 #include <linux/init.h>
+#include <linux/fs.h>
 #include <linux/proc_fs.h>
 #include <linux/list.h>
+#include <linux/signal.h>
+#include <linux/mqueue.h>
+#include <linux/msg.h>
+#include <linux/namei.h>
 #include <linux/security.h>
 #include <asm/uaccess.h>
 #include "util.h"
@@ -30,34 +38,87 @@
 int msg_ctlmax =3D MSGMAX;
 int msg_ctlmnb =3D MSGMNB;
 int msg_ctlmni =3D MSGMNI;
+static int msg_mode;
+
+#define MSG_FS_MAGIC	822419456
+
+#define MSG_NAME_LEN NAME_MAX
+#define MSG_FMT ".IPC_%08x"
+#define MSG_FMT_LEN 13
+
+#define MSG_UNLK	0010000 /* filename is unlinked */
+#define MSG_SYSV	0020000 /* It is a SYSV message queue */
+
+static struct super_block * msg_sb;
+
+static struct super_block *msg_read_super(struct file_system_type *,int =
, char *, void *);
+static void msg_put_super(struct super_block *);
+static int msg_remount_fs(struct super_block *, int *, char *);
+static void msg_fill_inode(struct inode *);
+static int msg_statfs(struct super_block *, struct statfs *);
+static int msg_create(struct inode *,struct dentry *,int);
+static struct dentry *msg_lookup(struct inode *,struct dentry *);
+static int msg_unlink(struct inode *,struct dentry *);
+static int msg_setattr(struct dentry *dent, struct iattr *attr);
+static void msg_delete(struct inode *);
+static int msg_readdir(struct file *, void *, filldir_t);
+static int msg_remove_name(int id);
+static int msg_ioctl(struct inode *, struct file *, unsigned int, unsign=
ed long);
+static int msg_root_ioctl(struct inode *, struct file *, unsigned int, u=
nsigned long);
+static ssize_t msg_read(struct file *, char *, size_t, loff_t *);
+static ssize_t msg_write(struct file *, const char *, size_t, loff_t *);=

+/* FIXME: Support poll on mq
+static unsigned int msg_poll(struct file *, poll_table *);
+ */
+static ssize_t msg_send (struct inode *, struct file *, const char *, si=
ze_t, long);
+static ssize_t msg_receive (struct inode *, struct file *, char *, size_=
t, long *);
+static int msg_flush (struct file *);
+static int msg_release (struct inode *, struct file *);
 =

-/* one msg_receiver structure for each sleeping receiver */
-struct msg_receiver {
-	struct list_head r_list;
-	struct task_struct* r_tsk;
-
-	int r_mode;
-	long r_msgtype;
-	long r_maxsize;
+static void freeque (int id);
+static int newque (key_t key, const char *name, int namelen, struct mq_a=
ttr *attr, int msgflg);
 =

-	struct msg_msg* volatile r_msg;
+static struct file_system_type msg_fs_type =3D {
+	.name		=3D "msgfs",
+	.get_sb		=3D msg_read_super,
+	.kill_sb	=3D kill_litter_super,
 };
 =

-/* one msg_sender for each sleeping sender */
-struct msg_sender {
-	struct list_head list;
-	struct task_struct* tsk;
+static struct super_operations msg_sops =3D {
+	.read_inode=3D	msg_fill_inode,
+	.delete_inode=3D	msg_delete,
+	.put_super=3D	msg_put_super,
+	.statfs=3D		msg_statfs,
+	.remount_fs=3D	msg_remount_fs,
 };
 =

-struct msg_msgseg {
-	struct msg_msgseg* next;
-	/* the next part of the message follows immediately */
+static struct file_operations msg_root_operations =3D {
+	.readdir=3D	msg_readdir,
+	.ioctl=3D		msg_root_ioctl,
 };
 =

-#define SEARCH_ANY		1
-#define SEARCH_EQUAL		2
-#define SEARCH_NOTEQUAL		3
-#define SEARCH_LESSEQUAL	4
+static struct inode_operations msg_root_inode_operations =3D {
+	.create=3D		msg_create,
+	.lookup=3D		msg_lookup,
+	.unlink=3D		msg_unlink,
+};
+
+static struct file_operations msg_file_operations =3D {
+	.read=3D		msg_read,
+	.write=3D		msg_write,
+	.ioctl=3D		msg_ioctl,
+/* FIXME: Support poll on mq *
+	poll=3D		msg_poll,
+ */
+	.flush=3D		msg_flush,
+	.release=3D	msg_release,
+};
+
+static struct inode_operations msg_inode_operations =3D {
+	.setattr=3D	msg_setattr,
+};
+
+static LIST_HEAD(mq_open_links);
 =

 static atomic_t msg_bytes =3D ATOMIC_INIT(0);
 static atomic_t msg_hdrs =3D ATOMIC_INIT(0);
@@ -67,33 +128,529 @@
 #define msg_lock(id)	((struct msg_queue*)ipc_lock(&msg_ids,id))
 #define msg_unlock(id)	ipc_unlock(&msg_ids,id)
 #define msg_rmid(id)	((struct msg_queue*)ipc_rmid(&msg_ids,id))
-#define msg_checkid(msq, msgid)	\
-	ipc_checkid(&msg_ids,&msq->q_perm,msgid)
-#define msg_buildid(id, seq) \
-	ipc_buildid(&msg_ids, id, seq)
+#define msg_get(id)   ((struct msg_queue*)ipc_get(&msg_ids,id))
+#define msg_buildid(id, seq) 	ipc_buildid(&msg_ids, id, seq)
 =

-static void freeque (int id);
-static int newque (key_t key, int msgflg);
 #ifdef CONFIG_PROC_FS
 static int sysvipc_msg_read_proc(char *buffer, char **start, off_t offse=
t, int length, int *eof, void *data);
 #endif
 =

 void __init msg_init (void)
 {
+	struct vfsmount *res;
 	ipc_init_ids(&msg_ids,msg_ctlmni);
-
+	register_filesystem (&msg_fs_type);
+	res =3D kern_mount(&msg_fs_type);
+	if (IS_ERR(res)) {
+		unregister_filesystem(&msg_fs_type);
+		return;
+	}
 #ifdef CONFIG_PROC_FS
 	create_proc_read_entry("sysvipc/msg", 0, 0, sysvipc_msg_read_proc, NULL=
);
 #endif
 }
 =

-static int newque (key_t key, int msgflg)
+static int msg_parse_options(char *options)
+{
+  int blocks =3D msg_ctlmnb * msg_ctlmni;
+  int inodes =3D msg_ctlmni;
+  umode_t mode =3D msg_mode;
+  char *this_char, *value;
+
+  this_char =3D NULL;
+  if ( options )
+      this_char =3D strsep(&options,",");
+  for ( ; this_char; this_char =3D strsep(&options,",")) {
+      if ((value =3D strchr(this_char,'=3D')) !=3D NULL)
+          *value++ =3D 0;
+      if (!strcmp(this_char,"nr_blocks")) {
+          if (!value || !*value)
+              return 1;
+          blocks =3D simple_strtoul(value,&value,0);
+          if (*value)
+              return 1;
+      }
+      else if (!strcmp(this_char,"nr_inodes")) {
+          if (!value || !*value)
+              return 1;
+          inodes =3D simple_strtoul(value,&value,0);
+          if (*value)
+              return 1;
+      }
+      else if (!strcmp(this_char,"mode")) {
+          if (!value || !*value)
+              return 1;
+          mode =3D simple_strtoul(value,&value,8);
+          if (*value)
+              return 1;
+      }
+      else
+          return 1;
+  }
+/* FIXME *
+  msg_ctlmni =3D inodes;
+  msg_ctlmnb =3D inodes ? blocks / inodes : 0;
+ */
+  msg_mode   =3D mode;
+
+  return 0;
+}
+
+static int
+msg_fill_super (struct super_block *sb, void *data, int silent)
+{
+  struct inode * root_inode;
+
+/* FIXME *
+  msg_ctlmnb =3D MSGMNB;
+  msg_ctlmni =3D MSGMNI;
+ */
+  msg_mode   =3D S_IRWXUGO | S_ISVTX;
+  if (msg_parse_options (data)) {
+      printk(KERN_ERR "msg fs invalid option\n");
+      return -EINVAL;
+  }
+
+  sb->s_blocksize =3D PAGE_SIZE;
+  sb->s_blocksize_bits =3D PAGE_SHIFT;
+  sb->s_magic =3D MSG_FS_MAGIC;
+  sb->s_op =3D &msg_sops;
+  root_inode =3D iget (sb, SEQ_MULTIPLIER);
+  if (!root_inode)
+      return -ENOMEM;
+  root_inode->i_op =3D &msg_root_inode_operations;
+  root_inode->i_sb =3D sb;
+  root_inode->i_nlink =3D 2;
+  root_inode->i_mode =3D S_IFDIR | msg_mode;
+  sb->s_root =3D d_alloc_root(root_inode);
+  if (!sb->s_root)
+      goto out_no_root;
+  msg_sb =3D sb;
+  return 0;
+
+out_no_root:
+  printk(KERN_ERR "msg_fill_super: get root inode failed\n");
+  iput(root_inode);
+  return -ENOMEM;
+}
+
+static struct super_block *msg_read_super(struct file_system_type *fs_ty=
pe,
+	       int flags, char *dev_name, void *data)
+{
+  return get_sb_single (fs_type, flags, data, msg_fill_super);
+}
+
+static int msg_remount_fs (struct super_block *sb, int *flags, char *dat=
a)
+{
+  if (msg_parse_options (data))
+      return -EINVAL;
+  return 0;
+}
+
+static inline int msg_checkid(struct msg_queue *msq, int id)
+{
+  if (!(msq->q_flags & MSG_SYSV))
+      return -EINVAL;
+  if (ipc_checkid(&msg_ids,&msq->q_perm,id))
+      return -EIDRM;
+  return 0;
+}
+
+static void msg_put_super(struct super_block *sb)
+{
+  int i;
+  struct msg_queue *msq;
+
+  down(&msg_ids.sem);
+  for(i =3D 0; i <=3D msg_ids.max_id; i++) {
+      if (!(msq =3D msg_lock (i)))
+          continue;
+      freeque(i);
+  }
+  dput (sb->s_root);
+  up(&msg_ids.sem);
+}
+
+static int msg_statfs(struct super_block *sb, struct statfs *buf)
+{
+  buf->f_type =3D MSG_FS_MAGIC;
+  buf->f_bsize =3D PAGE_SIZE;
+  buf->f_blocks =3D (msg_ctlmnb * msg_ctlmni) >> PAGE_SHIFT;
+  buf->f_bavail =3D buf->f_bfree =3D buf->f_blocks - (atomic_read(&msg_b=
ytes) >> PAGE_SHIFT);
+  buf->f_files =3D msg_ctlmni;
+  buf->f_ffree =3D msg_ctlmni - atomic_read(&msg_hdrs);
+  buf->f_namelen =3D MSG_NAME_LEN;
+  return 0;
+}
+
+static void msg_fill_inode(struct inode * inode)
+{
+  int id;
+  struct msg_queue *msq;
+  id =3D inode->i_ino;
+  inode->i_op =3D NULL;
+  inode->i_mode =3D 0;
+
+  if (id < SEQ_MULTIPLIER) {
+      if (!(msq =3D msg_lock (id)))
+          return;
+      inode->i_mode =3D (msq->q_flags & S_IRWXUGO) | S_IFIFO;
+      inode->i_uid  =3D msq->q_perm.uid;
+      inode->i_gid  =3D msq->q_perm.gid;
+      inode->i_size =3D msq->q_cbytes;
+      inode->i_mtime =3D msq->q_stime;
+      inode->i_atime =3D msq->q_stime > msq->q_rtime ? msq->q_stime : ms=
q->q_rtime;
+      inode->i_ctime =3D msq->q_ctime;
+      msg_unlock (id);
+      inode->i_op  =3D &msg_inode_operations;
+      inode->i_fop =3D &msg_file_operations;
+      return;
+  }
+  inode->i_mtime =3D inode->i_atime =3D inode->i_ctime =3D CURRENT_TIME;=

+  inode->i_op    =3D &msg_root_inode_operations;
+  inode->i_fop   =3D &msg_root_operations;
+  inode->i_sb    =3D msg_sb;
+  inode->i_nlink =3D 2;
+  inode->i_mode  =3D S_IFDIR | msg_mode;
+  inode->i_uid   =3D inode->i_gid =3D 0;
+}
+
+static int msg_create (struct inode *dir, struct dentry *dent, int mode)=

+{
+  int id, err;
+  struct inode *inode;
+  struct mq_attr attr, *p;
+  struct list_head *tmp;
+
+  attr.mq_maxmsg =3D 32;
+  attr.mq_msgsize =3D 64;
+  p =3D &attr;
+
+  down(&msg_ids.sem);
+  list_for_each(tmp, &mq_open_links) {
+      struct mq_link *l =3D list_entry(tmp, struct mq_link, link);
+      if (l->tsk =3D=3D current) {
+          p =3D l->attr;
+          break;
+      }
+  }
+  err =3D id =3D newque (IPC_PRIVATE, dent->d_name.name, dent->d_name.le=
n, p, mode);
+  if (err < 0)
+      goto out;
+
+  inode =3D iget (msg_sb, id % SEQ_MULTIPLIER);
+  if (!inode){
+  	err =3D -ENOMEM;
+  	goto out;
+  }
+  err =3D 0;
+  down (&inode->i_sem);
+  inode->i_mode =3D (mode & S_IRWXUGO) | S_IFIFO;
+  inode->i_op   =3D &msg_inode_operations;
+  d_instantiate(dent, inode);
+  up (&inode->i_sem);
+
+out:
+  up(&msg_ids.sem);
+  return err;
+}
+
+static int msg_readdir (struct file *filp, void *dirent, filldir_t filld=
ir)
+{
+  struct inode * inode =3D filp->f_dentry->d_inode;
+  struct msg_queue *msq;
+  off_t nr;
+
+  nr =3D filp->f_pos;
+
+  switch(nr)
+  {
+  case 0:
+      if (filldir(dirent, ".", 1, nr, inode->i_ino, DT_DIR) < 0)
+          return 0;
+      filp->f_pos =3D ++nr;
+      /* fall through */
+  case 1:
+      if (filldir(dirent, "..", 2, nr, inode->i_ino, DT_DIR) < 0)
+          return 0;
+      filp->f_pos =3D ++nr;
+      /* fall through */
+  default:
+      down(&msg_ids.sem);
+      for (; nr-2 <=3D msg_ids.max_id; nr++) {
+          if (!(msq =3D msg_get (nr-2)))
+              continue;
+          if (msq->q_flags & MSG_UNLK)
+              continue;
+          if (filldir(dirent, msq->q_name, msq->q_namelen, nr, nr, DT_FI=
FO) < 0)
+              break;;
+      }
+      filp->f_pos =3D nr;
+      up(&msg_ids.sem);
+      break;
+  }
+
+  UPDATE_ATIME(inode);
+  return 0;
+}
+
+static struct dentry *msg_lookup (struct inode *dir, struct dentry *dent=
)
+{
+  int i, err =3D 0;
+  struct msg_queue* msq;
+  struct inode *inode =3D NULL;
+
+  if (dent->d_name.len > MSG_NAME_LEN)
+      return ERR_PTR(-ENAMETOOLONG);
+
+  down(&msg_ids.sem);
+  for(i =3D 0; i <=3D msg_ids.max_id; i++) {
+      if (!(msq =3D msg_lock(i)))
+          continue;
+      if (!(msq->q_flags & MSG_UNLK) &&
+          dent->d_name.len =3D=3D msq->q_namelen &&
+          strncmp(dent->d_name.name, msq->q_name, msq->q_namelen) =3D=3D=
 0)
+          goto found;
+      msg_unlock(i);
+  }
+
+  /*
+   * prevent the reserved names as negative dentries.
+   * This also prevents object creation through the filesystem
+   */
+  if (dent->d_name.len =3D=3D MSG_FMT_LEN &&
+      memcmp (MSG_FMT, dent->d_name.name, MSG_FMT_LEN - 8) =3D=3D 0)
+      err =3D -EINVAL;  /* EINVAL to give IPC_RMID the right error */
+
+  goto out;
+
+found:
+  msg_unlock(i);
+  inode =3D iget(dir->i_sb, i);
+
+  if (!inode)
+      err =3D -EACCES;
+out:
+  if (err =3D=3D 0)
+      d_add (dent, inode);
+  up (&msg_ids.sem);
+  return ERR_PTR(err);
+}
+
+static inline int msg_do_unlink (struct inode *dir, struct dentry *dent,=
 int sysv)
+{
+  struct inode * inode =3D dent->d_inode;
+  struct msg_queue *msq;
+
+  down (&msg_ids.sem);
+  if (!(msq =3D msg_lock (inode->i_ino)))
+      BUG();
+  if (sysv) {
+      int ret =3D 0;
+
+      if (!(msq->q_flags & MSG_SYSV))
+          ret =3D -EINVAL;
+      else if (current->euid !=3D msq->q_perm.cuid &&
+           current->euid !=3D msq->q_perm.uid && !capable(CAP_SYS_ADMIN)=
)
+          ret =3D -EPERM;
+      if (ret) {
+          msg_unlock (inode->i_ino);
+          up (&msg_ids.sem);
+          return ret;
+      }
+  }
+  msq->q_flags |=3D MSG_UNLK;
+  msq->q_perm.key =3D IPC_PRIVATE; /* Do not find it any more */
+  msg_unlock (inode->i_ino);
+  up (&msg_ids.sem);
+  inode->i_nlink -=3D 1;
+  /*
+   * If it's a reserved name we have to drop the dentry instead
+   * of creating a negative dentry
+   */
+  if (dent->d_name.len =3D=3D MSG_FMT_LEN &&
+      memcmp (MSG_FMT, dent->d_name.name, MSG_FMT_LEN - 8) =3D=3D 0)
+      d_drop (dent);
+  return 0;
+}
+
+static int msg_unlink (struct inode *dir, struct dentry *dent)
+{
+  return msg_do_unlink (dir, dent, 0);
+}
+static int msg_setattr (struct dentry *dentry, struct iattr *attr)
+{
+  int error;
+  struct inode *inode =3D dentry->d_inode;
+  struct msg_queue *msq;
+
+  error =3D inode_change_ok(inode, attr);
+  if (error)
+      return error;
+  if (attr->ia_valid & ATTR_SIZE)
+      return -EINVAL;
+
+  if (attr->ia_valid & (ATTR_MODE | ATTR_UID | ATTR_GID)) {
+      if (!(msq =3D msg_lock(inode->i_ino)))
+          BUG();
+      if (attr->ia_valid & ATTR_MODE)
+          msq->q_flags =3D (msq->q_flags & ~S_IRWXUGO)
+              | (S_IRWXUGO & attr->ia_mode);
+      if (attr->ia_valid & ATTR_UID)
+          msq->q_perm.uid =3D attr->ia_uid;
+      if (attr->ia_valid & ATTR_GID)
+          msq->q_perm.gid =3D attr->ia_gid;
+      msq->q_ctime =3D attr->ia_ctime;
+      msg_unlock (inode->i_ino);
+  }
+
+  inode_setattr(inode, attr);
+  return error;
+}
+
+static int msg_root_ioctl (struct inode * inode, struct file * filp, uns=
igned int cmd, unsigned long arg)
+{
+  struct mq_open o;
+  struct mq_link link;
+  int ret;
+
+  if (cmd !=3D MQ_OPEN)
+      return -EINVAL;
+  ret =3D -EFAULT;
+  if (copy_from_user(&o, (struct mq_open *)arg, sizeof(struct mq_open)))=

+      goto out;
+  ret =3D -EINVAL;
+  if ((unsigned long)o.mq_attr.mq_msgsize > msg_ctlmnb ||
+      (unsigned long)o.mq_attr.mq_maxmsg > msg_ctlmnb ||
+      o.mq_attr.mq_msgsize * o.mq_attr.mq_maxmsg > msg_ctlmnb)
+      goto out;
+  link.attr =3D &o.mq_attr;
+  link.tsk =3D current;
+  down(&msg_ids.sem);
+  list_add(&link.link, &mq_open_links);
+  up(&msg_ids.sem);
+  /* FIXME: Shouldn't we check here whether mq_name is really a file wit=
hin the msg filesystem?
+     Otherwise people tracing the open(2) syscall might miss this place.=
=2E. */
+  ret =3D sys_open(o.mq_name, o.mq_oflag, o.mq_mode);
+  down(&msg_ids.sem);
+  list_del(&link.link);
+  up(&msg_ids.sem);
+out:
+  return ret;
+}
+
+static int msg_ioctl (struct inode * inode, struct file * filp, unsigned=
 int cmd, unsigned long arg)
+{
+  int ret =3D -EINVAL;
+  struct msg_queue *msq;
+  struct mq_sndrcv sr;
+
+  switch (cmd) {
+  case MQ_GETATTR: {
+      struct mq_attr attr;
+      memset(&attr, 0, sizeof(attr));
+      msq =3D msg_lock (inode->i_ino);
+      if (msq =3D=3D NULL)
+          BUG();
+      attr.mq_maxmsg =3D msq->q_maxmsg;
+      attr.mq_msgsize =3D msq->q_msgsize;
+      attr.mq_curmsgs =3D msq->q_qnum;
+      attr.mq_flags =3D filp->f_flags & O_NONBLOCK;
+      msg_unlock (inode->i_ino);
+      ret =3D copy_to_user((struct mq_attr *)arg, &attr, sizeof(attr)) ?=
 -EFAULT : 0;
+      break;
+      }
+  case MQ_SEND:
+      ret =3D -EBADF;
+      if (!(filp->f_mode & FMODE_WRITE))
+          break;
+      ret =3D -EFAULT;
+      if (copy_from_user(&sr, (struct mq_sndrcv *)arg, sizeof(sr)))
+          break;
+      ret =3D -EINVAL;
+      if (sr.mq_type <=3D 0)
+          break;
+      ret =3D msg_send (inode, filp, sr.mq_buf, sr.mq_len, sr.mq_type);
+      break;
+  case MQ_RECEIVE:
+      ret =3D -EBADF;
+      if (!(filp->f_mode & FMODE_READ))
+          break;
+      ret =3D -EFAULT;
+      if (copy_from_user(&sr, (struct mq_sndrcv *)arg, sizeof(sr)))
+          break;
+      ret =3D msg_receive (inode, filp, sr.mq_buf, sr.mq_len, &sr.mq_typ=
e);
+      if (!ret && put_user (sr.mq_type, &((struct mq_sndrcv *)arg)->mq_t=
ype))
+          ret =3D -EFAULT;
+      break;
+  case MQ_NOTIFY: {
+      struct sigevent sev;
+      struct msg_queue *msg;
+      ret =3D -EFAULT;
+      if (copy_from_user(&sev, (struct sigevent *)arg, sizeof(sev)))
+          break;
+      ret =3D -EINVAL;
+      if (sev.sigev_notify !=3D SIGEV_SIGNAL && sev.sigev_notify !=3D SI=
GEV_NONE)
+          break;
+      if (sev.sigev_signo <=3D 0 || sev.sigev_signo > _NSIG)
+          break;
+      msg =3D msg_lock(inode->i_ino);
+      if (!msg) BUG();
+      ret =3D 0;
+      if (msg->q_signo)
+          ret =3D -EBUSY;
+      else if (sev.sigev_notify =3D=3D SIGEV_SIGNAL) {
+          msg->q_signo =3D sev.sigev_signo;
+          msg->q_sigval =3D sev.sigev_value;
+      } else
+          msg->q_signo =3D 0;
+      msg_unlock(inode->i_ino);
+      }
+  default:
+      break;
+  }
+  return ret;
+}
+
+static ssize_t msg_write(struct file * file, =

+	const char * buf, size_t count, loff_t *ppos)
+{
+  int ret =3D msg_send(file->f_dentry->d_inode, file, buf, count, MQ_DEF=
AULT_TYPE);
+  return ret ?: count;
+}
+
+static ssize_t msg_read(struct file * file, =

+	char * buf, size_t count, loff_t *ppos)
+{
+  return msg_receive(file->f_dentry->d_inode, file, buf, count, NULL);
+}
+
+static int msg_release (struct inode *ino, struct file *filp)
+{
+  struct msg_queue *msq =3D msg_lock(ino->i_ino);
+  if (!msq) BUG();
+  if (msq->q_signo && msq->q_pid =3D=3D current->pid)
+      msq->q_signo =3D 0;
+  msg_unlock(ino->i_ino);
+  return 0;
+}
+
+static int msg_flush (struct file *filp)
+{
+  return msg_release(filp->f_dentry->d_inode, filp);
+}
+
+static int newque (key_t key, const char *name, int namelen, =

+	struct mq_attr *attr, int msgflg)
 {
 	int id;
 	int retval;
 	struct msg_queue *msq;
 =

-	msq  =3D (struct msg_queue *) kmalloc (sizeof (*msq), GFP_KERNEL);
+	if (namelen > MSG_NAME_LEN)
+		return -ENAMETOOLONG;
+	msq =3D (struct msg_queue *) kmalloc (sizeof (*msq) + namelen, GFP_KERN=
EL);
+
 	if (!msq) =

 		return -ENOMEM;
 =

@@ -113,18 +670,94 @@
 		kfree(msq);
 		return -ENOSPC;
 	}
+	msq->q_flags =3D (msgflg & S_IRWXUGO);
+	msq->q_perm.key =3D key;
 =

 	msq->q_stime =3D msq->q_rtime =3D 0;
 	msq->q_ctime =3D CURRENT_TIME;
 	msq->q_cbytes =3D msq->q_qnum =3D 0;
 	msq->q_qbytes =3D msg_ctlmnb;
 	msq->q_lspid =3D msq->q_lrpid =3D 0;
+	msq->q_signo =3D 0;
+
 	INIT_LIST_HEAD(&msq->q_messages);
 	INIT_LIST_HEAD(&msq->q_receivers);
 	INIT_LIST_HEAD(&msq->q_senders);
+	msq->id =3D msg_buildid(id, msq->q_perm.seq);
+	if (name) {
+	  msq->q_maxmsg =3D attr->mq_maxmsg;
+	  msq->q_msgsize =3D attr->mq_msgsize;
+	  msq->q_qbytes =3D msq->q_maxmsg * msq->q_msgsize;
+	  msq->q_namelen =3D namelen;
+	  memcpy(msq->q_name, name, namelen);
+	} else {
+	  msq->q_qbytes =3D msg_ctlmnb;
+	  msq->q_maxmsg =3D msg_ctlmnb;
+	  msq->q_msgsize =3D msg_ctlmax;
+	  msq->q_flags |=3D MSG_SYSV;
+	  msq->q_namelen =3D sprintf(msq->q_name, MSG_FMT, msq->id);
+	}
 	msg_unlock(id);
 =

-	return msg_buildid(id,msq->q_perm.seq);
+	return msq->id;
+}
+
+/* FIXME: maybe we need lock_kernel() here */
+static void msg_delete (struct inode *ino)
+{
+  int msgid =3D ino->i_ino;
+  struct msg_queue *msq;
+
+  down(&msg_ids.sem);
+  msq =3D msg_lock(msgid);
+  if(msq=3D=3DNULL)
+      BUG();
+  freeque(msgid);
+  up(&msg_ids.sem);
+  clear_inode(ino);
+}
+
+static int msg_remove_name(int msqid)
+{
+  struct dentry *dir;
+  struct dentry *dentry;
+  struct msg_queue *msq;
+  int error, id;
+  char name[MSG_FMT_LEN+1];
+
+  down(&msg_ids.sem);
+  msq =3D msg_lock(msqid);
+  if (msq =3D=3D NULL)
+      return -EINVAL;
+  id =3D msq->id;
+  if (msg_checkid (msq, msqid)) {
+      msg_unlock(msqid);
+      return -EIDRM;
+  }
+  msg_unlock(msqid);
+  up(&msg_ids.sem);
+  sprintf (name, MSG_FMT, id);
+  dir=3Dmsg_sb->s_root;
+  down(&dir->d_inode->i_sem);
+  dentry =3D lookup_one_len(name, dir, strlen(name) );
+  error =3D PTR_ERR(dentry);
+  if (!IS_ERR(dentry)) {
+      /*
+       * We have to do our own unlink to prevent the vfs
+       * permission check. We'll do the SYSV IPC style check
+       * inside of msg_do_unlink when we hold msg lock and
+       * msg_ids semaphore.
+       */
+      struct inode *inode =3D dir->d_inode;
+      down(&inode->i_sem);
+      error =3D msg_do_unlink(inode, dentry, 1);
+      if (!error)
+          d_delete(dentry);
+      up(&inode->i_sem);
+      dput(dentry);
+  }
+  up(&dir->d_inode->i_sem);
+  return error;
 }
 =

 static void free_msg(struct msg_msg* msg)
@@ -139,7 +772,7 @@
 	}
 }
 =

-static struct msg_msg* load_msg(void* src, int len)
+static struct msg_msg* load_msg(const char * src, int len)
 {
 	struct msg_msg* msg;
 	struct msg_msgseg** pseg;
@@ -191,9 +824,9 @@
 	return ERR_PTR(err);
 }
 =

-static int store_msg(void* dest, struct msg_msg* msg, int len)
+static int store_msg(void* dest, struct msg_msg* msg, size_t len)
 {
-	int alen;
+	size_t alen;
 	struct msg_msgseg *seg;
 =

 	alen =3D len;
@@ -213,7 +846,7 @@
 			return -1;
 		len -=3D alen;
 		dest =3D ((char*)dest)+alen;
-		seg=3Dseg->next;
+		seg =3D seg->next;
 	}
 	return 0;
 }
@@ -272,7 +905,7 @@
 	expunge_all(msq,-EIDRM);
 	ss_wakeup(&msq->q_senders,1);
 	msg_unlock(id);
-		=

+
 	tmp =3D msq->q_messages.next;
 	while(tmp !=3D &msq->q_messages) {
 		struct msg_msg* msg =3D list_entry(tmp,struct msg_msg,m_list);
@@ -292,12 +925,12 @@
 	=

 	down(&msg_ids.sem);
 	if (key =3D=3D IPC_PRIVATE) =

-		ret =3D newque(key, msgflg);
+		ret =3D newque(key, NULL, MSG_FMT_LEN + 1, NULL, msgflg);
 	else if ((id =3D ipc_findkey(&msg_ids, key)) =3D=3D -1) { /* key not us=
ed */
 		if (!(msgflg & IPC_CREAT))
 			ret =3D -ENOENT;
 		else
-			ret =3D newque(key, msgflg);
+			ret =3D newque(key, NULL, MSG_FMT_LEN + 1, NULL, msgflg);
 	} else if (msgflg & IPC_CREAT && msgflg & IPC_EXCL) {
 		ret =3D -EEXIST;
 	} else {
@@ -358,13 +991,6 @@
 	}
 }
 =

-struct msq_setbuf {
-	unsigned long	qbytes;
-	uid_t		uid;
-	gid_t		gid;
-	mode_t		mode;
-};
-
 static inline unsigned long copy_msqid_from_user(struct msq_setbuf *out,=
 void *buf, int version)
 {
 	switch(version) {
@@ -468,10 +1094,13 @@
 			return -EINVAL;
 =

 		if(cmd =3D=3D MSG_STAT) {
+			err =3D -EINVAL;
+			if (!(msq->q_flags & MSG_SYSV))
+				goto out_unlock;
 			success_return =3D msg_buildid(msqid, msq->q_perm.seq);
 		} else {
-			err =3D -EIDRM;
-			if (msg_checkid(msq,msqid))
+			err =3D msg_checkid(msq,msqid);
+			if (err)
 				goto out_unlock;
 			success_return =3D 0;
 		}
@@ -480,6 +1109,7 @@
 			goto out_unlock;
 =

 		kernel_to_ipc64_perm(&msq->q_perm, &tbuf.msg_perm);
+		tbuf.msg_perm.mode &=3D S_IRWXUGO;
 		tbuf.msg_stime  =3D msq->q_stime;
 		tbuf.msg_rtime  =3D msq->q_rtime;
 		tbuf.msg_ctime  =3D msq->q_ctime;
@@ -500,7 +1130,7 @@
 			return -EFAULT;
 		break;
 	case IPC_RMID:
-		break;
+		return msg_remove_name(msqid);
 	default:
 		return  -EINVAL;
 	}
@@ -521,12 +1151,11 @@
 	    /* We _could_ check for CAP_CHOWN above, but we don't */
 		goto out_unlock_up;
 =

-	switch (cmd) {
-	case IPC_SET:
-	{
+	if (cmd =3D=3D IPC_SET) {
 		if (setbuf.qbytes > msg_ctlmnb && !capable(CAP_SYS_RESOURCE))
 			goto out_unlock_up;
 		msq->q_qbytes =3D setbuf.qbytes;
+		msq->q_maxmsg =3D setbuf.qbytes;
 =

 		ipcp->uid =3D setbuf.uid;
 		ipcp->gid =3D setbuf.gid;
@@ -542,11 +1171,6 @@
 		 */
 		ss_wakeup(&msq->q_senders,0);
 		msg_unlock(msqid);
-		break;
-	}
-	case IPC_RMID:
-		freeque (msqid); =

-		break;
 	}
 	err =3D 0;
 out_up:
@@ -608,6 +1232,105 @@
 	return 0;
 }
 =

+static int msg_do_send (struct msg_queue **msqp, int msqid,
+			struct msg_msg *msg, size_t msgsz, int nowait)
+{
+	struct msg_queue *msq =3D *msqp;
+
+	if(msgsz + msq->q_cbytes > msq->q_qbytes ||
+	   1 + msq->q_qnum > msq->q_maxmsg) {
+		struct msg_sender s;
+
+		if(nowait)
+			return -EAGAIN;
+
+		ss_add(msq, &s);
+		msg_unlock(msqid);
+		schedule();
+		current->state =3D TASK_RUNNING;
+
+		*msqp =3D msq =3D msg_lock(msqid);
+		if(msq=3D=3DNULL)
+			return -EIDRM;
+		ss_del(&s);
+		=

+		if (signal_pending(current))
+			return -EINTR;
+		return -EBUSY;
+	}
+
+	if(!pipelined_send(msq,msg)) {
+		/* noone is waiting for this message, enqueue it */
+		list_add_tail(&msg->m_list,&msq->q_messages);
+		msq->q_cbytes +=3D msgsz;
+		msq->q_qnum++;
+		atomic_add(msgsz,&msg_bytes);
+		atomic_inc(&msg_hdrs);
+		if (msq->q_qnum =3D=3D 1 && msq->q_signo) {
+			struct task_struct *p;
+			siginfo_t si;
+			read_lock(&tasklist_lock);
+			p =3D find_task_by_pid(msq->q_pid);
+			if (p) {
+				si.si_signo =3D msq->q_signo;
+				si.si_errno =3D 0;
+				si.si_code =3D SI_MESGQ;
+				si.si_pid =3D current->pid;
+				si.si_uid =3D current->euid;
+				si.si_value =3D msq->q_sigval;
+				if (!send_sig_info(msq->q_signo, &si, p))
+					send_sig(msq->q_signo, p, 1);
+			}
+			read_unlock(&tasklist_lock);
+			msq->q_signo =3D 0;
+		}
+	}
+
+	msq->q_lspid =3D current->pid;
+	msq->q_stime =3D CURRENT_TIME;
+	return 0;
+}
+
+static ssize_t msg_send (struct inode *ino, struct file *filp, const cha=
r *mtext, size_t msgsz, long mtype)
+{
+	struct msg_queue *msq;
+	struct msg_msg *msg;
+	int err =3D 0;
+	=

+	if (mtype < 1)
+		return -EINVAL;
+	msq =3D msg_lock(ino->i_ino);
+	if (!msq) BUG();
+	if (msgsz > msq->q_msgsize)
+		err =3D -EMSGSIZE;
+	msg_unlock(ino->i_ino);
+	if (err) return err;
+
+	msg =3D load_msg(mtext, msgsz);
+	if(IS_ERR(msg))
+		return PTR_ERR(msg);
+
+	msg->m_type =3D mtype;
+	msg->m_ts =3D msgsz;
+
+	msq =3D msg_lock(ino->i_ino);
+	if (!msq) BUG();
+
+	do {
+		err =3D -EACCES;
+		if (msq->q_flags & MSG_SYSV && ipcperms(&msq->q_perm, S_IWUGO))
+			break;
+
+		err =3D msg_do_send(&msq, ino->i_ino, msg, msgsz, filp->f_flags & O_NO=
NBLOCK);
+
+	} while (err =3D=3D -EBUSY);
+
+	msg_unlock(ino->i_ino);
+	if (msg && err)
+		free_msg(msg);
+	return err;
+}
+
 asmlinkage long sys_msgsnd (int msqid, struct msgbuf *msgp, size_t msgsz=
, int msgflg)
 {
 	struct msg_queue *msq;
@@ -633,60 +1356,23 @@
 	err=3D-EINVAL;
 	if(msq=3D=3DNULL)
 		goto out_free;
-retry:
-	err=3D -EIDRM;
-	if (msg_checkid(msq,msqid))
-		goto out_unlock_free;
-
-	err=3D-EACCES;
-	if (ipcperms(&msq->q_perm, S_IWUGO)) =

-		goto out_unlock_free;
-
-	if(msgsz + msq->q_cbytes > msq->q_qbytes ||
-		1 + msq->q_qnum > msq->q_qbytes) {
-		struct msg_sender s;
-
-		if(msgflg&IPC_NOWAIT) {
-			err=3D-EAGAIN;
-			goto out_unlock_free;
-		}
-		ss_add(msq, &s);
-		msg_unlock(msqid);
-		schedule();
-		current->state=3D TASK_RUNNING;
+	do {
+	  err=3D -EIDRM;
+	  if (msg_checkid(msq,msqid))
+    	  break;
 =

-		msq =3D msg_lock(msqid);
-		err =3D -EIDRM;
-		if(msq=3D=3DNULL)
-			goto out_free;
-		ss_del(&s);
-		=

-		if (signal_pending(current)) {
-			err=3D-EINTR;
-			goto out_unlock_free;
-		}
-		goto retry;
-	}
+	  err=3D-EACCES;
+	  if (ipcperms(&msq->q_perm, S_IWUGO))
+    	  break;
 =

-	msq->q_lspid =3D current->pid;
-	msq->q_stime =3D CURRENT_TIME;
+	  err =3D msg_do_send(&msq, msqid, msg, msgsz, msgflg & IPC_NOWAIT);
 =

-	if(!pipelined_send(msq,msg)) {
-		/* noone is waiting for this message, enqueue it */
-		list_add_tail(&msg->m_list,&msq->q_messages);
-		msq->q_cbytes +=3D msgsz;
-		msq->q_qnum++;
-		atomic_add(msgsz,&msg_bytes);
-		atomic_inc(&msg_hdrs);
-	}
-	=

-	err =3D 0;
-	msg =3D NULL;
+	} while (err =3D=3D -EBUSY);
 =

-out_unlock_free:
-	msg_unlock(msqid);
+	if (msq)
+	  msg_unlock(msqid);
 out_free:
-	if(msg!=3DNULL)
+	if (msg && err)
 		free_msg(msg);
 	return err;
 }
@@ -710,127 +1396,169 @@
 	return SEARCH_EQUAL;
 }
 =

+static struct msg_msg *
+msg_do_receive (struct msg_queue *msq, int *msqidp, size_t msgsz,
+      long msgtyp, int mode, int msgflg)
+{
+  struct msg_receiver msr_d;
+  struct list_head *tmp;
+  struct msg_msg *msg, *found_msg;
+  int msqid =3D *msqidp;
+
+  for (;;) {
+      if (msq->q_flags & MSG_SYSV && ipcperms (&msq->q_perm, S_IRUGO))
+          return ERR_PTR(-EACCES);
+
+      tmp =3D msq->q_messages.next;
+      found_msg =3D NULL;
+      while (tmp !=3D &msq->q_messages) {
+          msg =3D list_entry(tmp,struct msg_msg,m_list);
+          if(testmsg(msg, msgtyp, mode)) {
+              found_msg =3D msg;
+              if(mode =3D=3D SEARCH_LESSEQUAL && msg->m_type !=3D 1)
+                  msgtyp =3D msg->m_type - 1;
+              else
+                  break;
+          }
+          tmp =3D tmp->next;
+      }
+      if (found_msg) {
+          msg =3D found_msg;
+          if ((msgsz < msg->m_ts) && !(msgflg & MSG_NOERROR))
+              return ERR_PTR(-E2BIG);
+          list_del(&msg->m_list);
+          msq->q_qnum--;
+          msq->q_rtime =3D CURRENT_TIME;
+          msq->q_lrpid =3D current->pid;
+          msq->q_cbytes -=3D msg->m_ts;
+          atomic_sub(msg->m_ts,&msg_bytes);
+          atomic_dec(&msg_hdrs);
+          ss_wakeup(&msq->q_senders,0);
+          msg_unlock(msqid);
+          return msg;
+      } else {
+          struct msg_queue *t;
+          /* no message waiting. Prepare for pipelined
+           * receive.
+           */
+          if (msgflg & IPC_NOWAIT)
+              return ERR_PTR(-ENOMSG);
+          list_add_tail(&msr_d.r_list,&msq->q_receivers);
+          msr_d.r_tsk =3D current;
+          msr_d.r_msgtype =3D msgtyp;
+          msr_d.r_mode =3D mode;
+          if(msgflg & MSG_NOERROR)
+              msr_d.r_maxsize =3D INT_MAX;
+          else
+              msr_d.r_maxsize =3D msgsz;
+          msr_d.r_msg =3D ERR_PTR(-EAGAIN);
+          current->state =3D TASK_INTERRUPTIBLE;
+          msg_unlock(msqid);
+
+          schedule();
+          current->state =3D TASK_RUNNING;
+
+          msg =3D (struct msg_msg*) msr_d.r_msg;
+          if(!IS_ERR(msg))
+              return msg;
+
+          t =3D msg_lock(msqid);
+          if(t =3D=3D NULL)
+              *msqidp =3D msqid =3D -1;
+          msg =3D (struct msg_msg*)msr_d.r_msg;
+          if(!IS_ERR(msg)) {
+              /* our message arived while we waited for
+               * the spinlock. Process it.
+               */
+              if (msqid !=3D -1)
+                  msg_unlock(msqid);
+              return msg;
+          }
+          if(PTR_ERR(msg) =3D=3D -EAGAIN) {
+              if(msqid =3D=3D -1)
+                  BUG();
+              list_del(&msr_d.r_list);
+              if (signal_pending(current))
+                  return ERR_PTR(-EINTR);
+              else
+                  continue;
+          }
+          return msg;
+      }
+  }
+}
+
+static int msg_receive (struct inode *ino, struct file *filp, char *mtex=
t,
+          size_t msgsz, long *msgtypp)
+{
+  struct msg_queue *msq;
+  struct msg_msg *msg;
+  long msgtyp;
+  int err, mode, msqid =3D ino->i_ino;
+
+  if (msgtypp)
+      msgtyp =3D *msgtypp;
+  else
+      msgtyp =3D -MQ_DEFAULT_TYPE;
+  mode =3D convert_mode(&msgtyp, 0);
+  msq =3D msg_lock(msqid);
+  if (!msq) BUG();
+  if (msgtypp && msgsz < msq->q_msgsize) {
+      msg_unlock(msqid);
+      return -EMSGSIZE;
+  }
+
+  msg =3D msg_do_receive (msq, &msqid, msgsz, msgtyp, mode,
+                (filp->f_flags & O_NONBLOCK) ? IPC_NOWAIT : 0);
+  if (!IS_ERR (msg)) {
+      msgsz =3D (msgsz > msg->m_ts) ? msg->m_ts : msgsz;
+      if (store_msg(mtext, msg, msgsz))
+          msgsz =3D -EFAULT;
+      else if (msgtypp)
+          *msgtypp =3D msg->m_type;
+      free_msg(msg);
+      return msgsz;
+  }
+  if (msqid !=3D -1)
+      msg_unlock(msqid);
+  err =3D PTR_ERR(msg);
+  switch (err) {
+  case -ENOMSG: err =3D -EAGAIN; break;
+  case -E2BIG: err =3D -EMSGSIZE; break;
+  }
+  return err;
+}
+
 asmlinkage long sys_msgrcv (int msqid, struct msgbuf *msgp, size_t msgsz=
,
 			    long msgtyp, int msgflg)
 {
 	struct msg_queue *msq;
-	struct msg_receiver msr_d;
-	struct list_head* tmp;
-	struct msg_msg* msg, *found_msg;
-	int err;
+	struct msg_msg *msg;
 	int mode;
 =

 	if (msqid < 0 || (long) msgsz < 0)
 		return -EINVAL;
-	mode =3D convert_mode(&msgtyp,msgflg);
+	mode =3D convert_mode(&msgtyp, msgflg);
 =

-	msq =3D msg_lock(msqid);
-	if(msq=3D=3DNULL)
+	msq =3D msg_lock (msqid);
+	if (msq=3D=3DNULL)
+		return -EINVAL;
+	if (!(msq->q_flags & MSG_SYSV)) {
+		msg_unlock (msqid);
 		return -EINVAL;
-retry:
-	err =3D -EIDRM;
-	if (msg_checkid(msq,msqid))
-		goto out_unlock;
-
-	err=3D-EACCES;
-	if (ipcperms (&msq->q_perm, S_IRUGO))
-		goto out_unlock;
-
-	tmp =3D msq->q_messages.next;
-	found_msg=3DNULL;
-	while (tmp !=3D &msq->q_messages) {
-		msg =3D list_entry(tmp,struct msg_msg,m_list);
-		if(testmsg(msg,msgtyp,mode)) {
-			found_msg =3D msg;
-			if(mode =3D=3D SEARCH_LESSEQUAL && msg->m_type !=3D 1) {
-				found_msg=3Dmsg;
-				msgtyp=3Dmsg->m_type-1;
-			} else {
-				found_msg=3Dmsg;
-				break;
-			}
-		}
-		tmp =3D tmp->next;
 	}
-	if(found_msg) {
-		msg=3Dfound_msg;
-		if ((msgsz < msg->m_ts) && !(msgflg & MSG_NOERROR)) {
-			err=3D-E2BIG;
-			goto out_unlock;
-		}
-		list_del(&msg->m_list);
-		msq->q_qnum--;
-		msq->q_rtime =3D CURRENT_TIME;
-		msq->q_lrpid =3D current->pid;
-		msq->q_cbytes -=3D msg->m_ts;
-		atomic_sub(msg->m_ts,&msg_bytes);
-		atomic_dec(&msg_hdrs);
-		ss_wakeup(&msq->q_senders,0);
-		msg_unlock(msqid);
-out_success:
+	msg =3D msg_do_receive (msq, &msqid, msgsz, msgtyp, mode, msgflg);
+	if (!IS_ERR (msg)) {
 		msgsz =3D (msgsz > msg->m_ts) ? msg->m_ts : msgsz;
-		if (put_user (msg->m_type, &msgp->mtype) ||
-		    store_msg(msgp->mtext, msg, msgsz)) {
-			    msgsz =3D -EFAULT;
-		}
-		free_msg(msg);
-		return msgsz;
-	} else
-	{
-		struct msg_queue *t;
-		/* no message waiting. Prepare for pipelined
-		 * receive.
-		 */
-		if (msgflg & IPC_NOWAIT) {
-			err=3D-ENOMSG;
-			goto out_unlock;
-		}
-		list_add_tail(&msr_d.r_list,&msq->q_receivers);
-		msr_d.r_tsk =3D current;
-		msr_d.r_msgtype =3D msgtyp;
-		msr_d.r_mode =3D mode;
-		if(msgflg & MSG_NOERROR)
-			msr_d.r_maxsize =3D INT_MAX;
-		 else
-		 	msr_d.r_maxsize =3D msgsz;
-		msr_d.r_msg =3D ERR_PTR(-EAGAIN);
-		current->state =3D TASK_INTERRUPTIBLE;
-		msg_unlock(msqid);
-
-		schedule();
-		current->state =3D TASK_RUNNING;
-
-		msg =3D (struct msg_msg*) msr_d.r_msg;
-		if(!IS_ERR(msg)) =

-			goto out_success;
-
-		t =3D msg_lock(msqid);
-		if(t=3D=3DNULL)
-			msqid=3D-1;
-		msg =3D (struct msg_msg*)msr_d.r_msg;
-		if(!IS_ERR(msg)) {
-			/* our message arived while we waited for
-			 * the spinlock. Process it.
-			 */
-			if(msqid!=3D-1)
-				msg_unlock(msqid);
-			goto out_success;
-		}
-		err =3D PTR_ERR(msg);
-		if(err =3D=3D -EAGAIN) {
-			if(msqid=3D=3D-1)
-				BUG();
-			list_del(&msr_d.r_list);
-			if (signal_pending(current))
-				err=3D-EINTR;
-			 else
-				goto retry;
-		}
-	}
-out_unlock:
-	if(msqid!=3D-1)
-		msg_unlock(msqid);
-	return err;
+    	if (put_user (msg->m_type, &msgp->mtype) ||
+    	  store_msg(msgp->mtext, msg, msgsz))
+    	  msgsz =3D -EFAULT;
+    	free_msg(msg);
+    	return msgsz;
+	}
+	if (msqid !=3D -1)
+    	msg_unlock(msqid);
+	return PTR_ERR(msg);
 }
 =

 #ifdef CONFIG_PROC_FS
@@ -841,16 +1569,16 @@
 	int i, len =3D 0;
 =

 	down(&msg_ids.sem);
-	len +=3D sprintf(buffer, "       key      msqid perms      cbytes      =
 qnum lspid lrpid   uid   gid  cuid  cgid      stime      rtime      ctim=
e\n");
+	len +=3D sprintf(buffer, "       key      msqid perms      cbytes      =
 qnum lspid lrpid   uid   gid  cuid  cgid      stime      rtime      ctim=
e 	name(POSIX)\n");
 =

 	for(i =3D 0; i <=3D msg_ids.max_id; i++) {
 		struct msg_queue * msq;
 		msq =3D msg_lock(i);
 		if(msq !=3D NULL) {
-			len +=3D sprintf(buffer + len, "%10d %10d  %4o  %10lu %10lu %5u %5u %=
5u %5u %5u %5u %10lu %10lu %10lu\n",
+			len +=3D sprintf(buffer + len, "%10d %10d  %4o  %10lu %10lu %5u %5u %=
5u %5u %5u %5u %10lu %10lu %10lu %.*s%s\n",
 				msq->q_perm.key,
 				msg_buildid(i,msq->q_perm.seq),
-				msq->q_perm.mode,
+				msq->q_flags & S_IRWXUGO,
 				msq->q_cbytes,
 				msq->q_qnum,
 				msq->q_lspid,
@@ -861,7 +1589,10 @@
 				msq->q_perm.cgid,
 				msq->q_stime,
 				msq->q_rtime,
-				msq->q_ctime);
+				msq->q_ctime,
+				msq->q_namelen,
+				msq->q_name,
+				msq->q_flags & MSG_UNLK ? " (deleted)" : "");
 			msg_unlock(i);
 =

 			pos +=3D len;

--------------2C6609BA5B63E7B5E7A740EB--

