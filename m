Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S132389AbQKSOAh>; Sun, 19 Nov 2000 09:00:37 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S132406AbQKSOA1>; Sun, 19 Nov 2000 09:00:27 -0500
Received: from devserv.devel.redhat.com ([207.175.42.156]:14090 "EHLO
	devserv.devel.redhat.com") by vger.kernel.org with ESMTP
	id <S132389AbQKSOAS>; Sun, 19 Nov 2000 09:00:18 -0500
Date: Sun, 19 Nov 2000 08:30:14 -0500
From: Jakub Jelinek <jakub@redhat.com>
To: GOTO Masanori <gotom@debian.or.jp>
Cc: linux-kernel@vger.kernel.org
Subject: POSIX message queue passing (was Re: State of Posix compliance in v2.2/v2.4 kernel?)
Message-ID: <20001119083014.A1514@devserv.devel.redhat.com>
Reply-To: Jakub Jelinek <jakub@redhat.com>
In-Reply-To: <88256996.00577D9E.00@hqoutbound.ops.3com.com> <3A101009.5F05DA18@mandrakesoft.com> <20001113111319.E1514@devserv.devel.redhat.com> <14871.43600.833808.90123Q@fe.dis.titech.ac.jp>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="4ZLFUWh1odzi/v6L"
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <14871.43600.833808.90123Q@fe.dis.titech.ac.jp>; from gotom@debian.or.jp on Sun, Nov 19, 2000 at 07:24:16PM +0900
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--4ZLFUWh1odzi/v6L
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Sun, Nov 19, 2000 at 07:24:16PM +0900, GOTO Masanori wrote:
> At Mon, 13 Nov 2000 11:13:19 -0500,
> Jakub Jelinek <jakub@redhat.com> wrote:
> > ago were done in the kernel, POSIX message queue passing is not doable in
> > userland without kernel help either (I have a message queue filesystem
> > kernel patch for this, but it is a 2.5 thing).
> 
> Interesting. Is yours ready for?
> (I'm also working with it. I agree it's for 2.5)

Below is my preliminary version from Sep, 16th if you're interested.
I haven't had time for it since then, so it most probably will not apply
cleanly to current kernel.
Things still to do:
- clean it up
- implement poll on message queues
- handle __SI_RT in architectural copy_siginfo_to_user routines
- test much more than I have done so far
- fix mq_notify - see below
- avoid doing linear searches - see below

Message queues are presented as a new filesystem, mounted usually on
/dev/msg. The objects in that filesystems are fifos with special MQ
semantics.
One can use normal open/read/write on fifos in /dev/msg, which
means mq_open with mq_attr NULL, mq_receive which does not tell the priority
and mq_send with default priority.
Then there are a few ioctls which allow to open with special queue
attributes, send with priority and receive so that you get priority back,
etc.
Things I'm not sure about is mq_notify, because it states the signal should
be sent to the process (ie. I'd think it is tgid, not pid in 2.4.0-test8,
but then I don't know which close/exit should cause the notification
registration to be freed).
Also, I wonder how many pending messages typical message queues have
pending, if not too many, then the current linear search is fine, otherwise
I should put the messages into some heap which would allow O(1) mq_receive.
If you find any races/problems, please let me know.

I've coded mqueue.h public glibc userland header and mqueue.c which has
hacks on top and then basically what could end up in glibc's mq_*.c (after
shm_open.c code for locating mount points is copied in).

	Jakub

--4ZLFUWh1odzi/v6L
Content-Type: text/plain; charset=us-ascii
Content-Disposition: attachment; filename="2.4.0-test8.patch"

--- linux/Documentation/ioctl-number.txt.jj	Thu Jun 22 13:42:24 2000
+++ linux/Documentation/ioctl-number.txt	Fri Sep  8 13:16:42 2000
@@ -183,5 +183,6 @@ Code	Seq#	Include File		Comments
 0xB0	all	RATIO devices		in development:
 					<mailto:vgo@ratio.de>
 0xB1	00-1F	PPPoX			<mailto:mostrows@styx.uwaterloo.ca>
+0xB2	00-1F	linux/mqueue.h
 0xCB	00-1F	CBM serial IEC bus	in development:
 					<mailto:michael.klein@puffin.lb.shuttle.de>
--- linux/include/asm-alpha/siginfo.h.jj	Sat May 27 02:49:37 2000
+++ linux/include/asm-alpha/siginfo.h	Mon Sep 11 13:30:50 2000
@@ -104,7 +104,7 @@ typedef struct siginfo {
 #define SI_KERNEL	0x80		/* sent by the kernel from somewhere */
 #define SI_QUEUE	-1		/* sent by sigqueue */
 #define SI_TIMER __SI_CODE(__SI_TIMER,-2) /* sent by timer expiration */
-#define SI_MESGQ	-3		/* sent by real time mesq state change */
+#define SI_MESGQ __SI_CODE(__SI_RT,-3)	/* sent by real time mesq state change */
 #define SI_ASYNCIO	-4		/* sent by AIO completion */
 #define SI_SIGIO	-5		/* sent by queued SIGIO */
 
--- linux/include/asm-arm/siginfo.h.jj	Sat May 27 02:49:37 2000
+++ linux/include/asm-arm/siginfo.h	Mon Sep 11 13:31:02 2000
@@ -104,7 +104,7 @@ typedef struct siginfo {
 #define SI_KERNEL	0x80		/* sent by the kernel from somewhere */
 #define SI_QUEUE	-1		/* sent by sigqueue */
 #define SI_TIMER __SI_CODE(__SI_TIMER,-2) /* sent by timer expiration */
-#define SI_MESGQ	-3		/* sent by real time mesq state change */
+#define SI_MESGQ __SI_CODE(__SI_RT,-3)	/* sent by real time mesq state change */
 #define SI_ASYNCIO	-4		/* sent by AIO completion */
 #define SI_SIGIO	-5		/* sent by queued SIGIO */
 
--- linux/include/asm-i386/siginfo.h.jj	Thu Sep  7 10:38:08 2000
+++ linux/include/asm-i386/siginfo.h	Mon Sep 11 13:31:15 2000
@@ -104,7 +104,7 @@ typedef struct siginfo {
 #define SI_KERNEL	0x80		/* sent by the kernel from somewhere */
 #define SI_QUEUE	-1		/* sent by sigqueue */
 #define SI_TIMER __SI_CODE(__SI_TIMER,-2) /* sent by timer expiration */
-#define SI_MESGQ	-3		/* sent by real time mesq state change */
+#define SI_MESGQ __SI_CODE(__SI_RT,-3)	/* sent by real time mesq state change */
 #define SI_ASYNCIO	-4		/* sent by AIO completion */
 #define SI_SIGIO	-5		/* sent by queued SIGIO */
 
--- linux/include/asm-ia64/siginfo.h.jj	Tue Aug 15 10:09:41 2000
+++ linux/include/asm-ia64/siginfo.h	Mon Sep 11 13:31:23 2000
@@ -113,7 +113,7 @@ typedef struct siginfo {
 #define SI_KERNEL	0x80		/* sent by the kernel from somewhere */
 #define SI_QUEUE	-1		/* sent by sigqueue */
 #define SI_TIMER __SI_CODE(__SI_TIMER,-2) /* sent by timer expiration */
-#define SI_MESGQ	-3		/* sent by real time mesq state change */
+#define SI_MESGQ __SI_CODE(__SI_RT,-3)	/* sent by real time mesq state change */
 #define SI_ASYNCIO	-4		/* sent by AIO completion */
 #define SI_SIGIO	-5		/* sent by queued SIGIO */
 
--- linux/include/asm-m68k/siginfo.h.jj	Sat May 27 02:49:37 2000
+++ linux/include/asm-m68k/siginfo.h	Mon Sep 11 13:31:31 2000
@@ -104,7 +104,7 @@ typedef struct siginfo {
 #define SI_KERNEL	0x80		/* sent by the kernel from somewhere */
 #define SI_QUEUE	-1		/* sent by sigqueue */
 #define SI_TIMER __SI_CODE(__SI_TIMER,-2) /* sent by timer expiration */
-#define SI_MESGQ	-3		/* sent by real time mesq state change */
+#define SI_MESGQ __SI_CODE(__SI_RT,-3)	/* sent by real time mesq state change */
 #define SI_ASYNCIO	-4		/* sent by AIO completion */
 #define SI_SIGIO	-5		/* sent by queued SIGIO */
 
--- linux/include/asm-mips/siginfo.h.jj	Sat May 27 02:49:37 2000
+++ linux/include/asm-mips/siginfo.h	Mon Sep 11 13:31:49 2000
@@ -125,7 +125,7 @@ typedef struct siginfo {
 #define SI_QUEUE	-1	/* sent by sigqueue */
 #define SI_ASYNCIO	-2	/* sent by AIO completion */
 #define SI_TIMER __SI_CODE(__SI_TIMER,-3) /* sent by timer expiration */
-#define SI_MESGQ	-4	/* sent by real time mesq state change */
+#define SI_MESGQ __SI_CODE(__SI_RT,-4)	/* sent by real time mesq state change */
 #define SI_SIGIO	-5	/* sent by queued SIGIO */
 
 #define SI_FROMUSER(siptr)	((siptr)->si_code <= 0)
--- linux/include/asm-mips64/siginfo.h.jj	Sat May 27 02:49:37 2000
+++ linux/include/asm-mips64/siginfo.h	Mon Sep 11 13:31:59 2000
@@ -125,7 +125,7 @@ typedef struct siginfo {
 #define SI_QUEUE	-1	/* sent by sigqueue */
 #define SI_ASYNCIO	-2	/* sent by AIO completion */
 #define SI_TIMER __SI_CODE(__SI_TIMER,-3) /* sent by timer expiration */
-#define SI_MESGQ	-4	/* sent by real time mesq state change */
+#define SI_MESGQ __SI_CODE(__SI_RT,-4)	/* sent by real time mesq state change */
 #define SI_SIGIO	-5	/* sent by queued SIGIO */
 
 #define SI_FROMUSER(siptr)	((siptr)->si_code <= 0)
--- linux/include/asm-ppc/siginfo.h.jj	Sat May 27 02:49:37 2000
+++ linux/include/asm-ppc/siginfo.h	Mon Sep 11 13:32:07 2000
@@ -104,7 +104,7 @@ typedef struct siginfo {
 #define SI_KERNEL	0x80		/* sent by the kernel from somewhere */
 #define SI_QUEUE	-1		/* sent by sigqueue */
 #define SI_TIMER __SI_CODE(__SI_TIMER,-2) /* sent by timer expiration */
-#define SI_MESGQ	-3		/* sent by real time mesq state change */
+#define SI_MESGQ __SI_CODE(__SI_RT,-3)	/* sent by real time mesq state change */
 #define SI_ASYNCIO	-4		/* sent by AIO completion */
 #define SI_SIGIO	-5		/* sent by queued SIGIO */
 
--- linux/include/asm-sh/siginfo.h.jj	Sat May 27 02:49:37 2000
+++ linux/include/asm-sh/siginfo.h	Mon Sep 11 13:32:41 2000
@@ -104,7 +104,7 @@ typedef struct siginfo {
 #define SI_KERNEL	0x80		/* sent by the kernel from somewhere */
 #define SI_QUEUE	-1		/* sent by sigqueue */
 #define SI_TIMER __SI_CODE(__SI_TIMER,-2) /* sent by timer expiration */
-#define SI_MESGQ	-3		/* sent by real time mesq state change */
+#define SI_MESGQ __SI_CODE(__SI_RT,-3)	/* sent by real time mesq state change */
 #define SI_ASYNCIO	-4		/* sent by AIO completion */
 #define SI_SIGIO	-5		/* sent by queued SIGIO */
 
--- linux/include/asm-sparc/siginfo.h.jj	Sat May 27 02:49:37 2000
+++ linux/include/asm-sparc/siginfo.h	Mon Sep 11 13:32:49 2000
@@ -109,7 +109,7 @@ typedef struct siginfo {
 #define SI_KERNEL	0x80		/* sent by the kernel from somewhere */
 #define SI_QUEUE	-1		/* sent by sigqueue */
 #define SI_TIMER __SI_CODE(__SI_TIMER,-2) /* sent by timer expiration */
-#define SI_MESGQ	-3		/* sent by real time mesq state change */
+#define SI_MESGQ __SI_CODE(__SI_RT,-3)	/* sent by real time mesq state change */
 #define SI_ASYNCIO	-4		/* sent by AIO completion */
 #define SI_SIGIO	-5		/* sent by queued SIGIO */
 
--- linux/include/asm-sparc64/siginfo.h.jj	Sat May 27 02:49:37 2000
+++ linux/include/asm-sparc64/siginfo.h	Mon Sep 11 13:32:56 2000
@@ -169,7 +169,7 @@ typedef struct siginfo32 {
 #define SI_KERNEL	0x80		/* sent by the kernel from somewhere */
 #define SI_QUEUE	-1		/* sent by sigqueue */
 #define SI_TIMER __SI_CODE(__SI_TIMER,-2) /* sent by timer expiration */
-#define SI_MESGQ	-3		/* sent by real time mesq state change */
+#define SI_MESGQ __SI_CODE(__SI_RT,-3)	/* sent by real time mesq state change */
 #define SI_ASYNCIO	-4		/* sent by AIO completion */
 #define SI_SIGIO	-5		/* sent by queued SIGIO */
 
--- linux/include/linux/mqueue.h.jj	Fri Sep  8 10:21:42 2000
+++ linux/include/linux/mqueue.h	Mon Sep 11 10:01:06 2000
@@ -0,0 +1,37 @@
+#ifndef _LINUX_MQUEUE_H
+#define _LINUX_MQUEUE_H
+
+#include <linux/types.h>
+#include <linux/ioctl.h>
+#include <asm/siginfo.h>
+
+struct mq_attr {
+	long		mq_flags;	/* O_NONBLOCK or 0 */
+	long		mq_maxmsg;	/* Maximum number of messages in the queue */
+	long		mq_msgsize;	/* Maximum size of one message in bytes */
+	long		mq_curmsgs;	/* Current number of messages in the queue */
+	long		__pad[2];
+};
+
+struct mq_open {
+	char		*mq_name;	/* pathname */
+	int		mq_oflag;	/* flags */
+	mode_t		mq_mode;	/* mode */
+	struct mq_attr	mq_attr;	/* attributes */
+};
+
+struct mq_sndrcv {
+	size_t		mq_len;		/* message length */
+	long		mq_type;	/* message type */
+	char		*mq_buf;	/* message buffer */
+};
+
+#define MQ_OPEN		_IOW(0xB2, 0, struct mq_open)
+#define MQ_GETATTR	_IOR(0xB2, 1, struct mq_attr)
+#define MQ_SEND		_IOW(0xB2, 2, struct mq_sndrcv)
+#define MQ_RECEIVE	_IOWR(0xB2, 3, struct mq_sndrcv)
+#define MQ_NOTIFY	_IOW(0xB2, 4, struct sigevent)
+
+#define MQ_DEFAULT_TYPE	0x7FFFFFFE
+
+#endif /* _LINUX_MQUEUE_H */
--- linux/ipc/msg.c.jj	Thu Jan 13 01:06:46 2000
+++ linux/ipc/msg.c	Mon Sep 11 19:13:47 2000
@@ -13,6 +13,9 @@
  * mostly rewritten, threaded and wake-one semantics added
  * MSGMAX limit removed, sysctl's added
  * (c) 1999 Manfred Spraul <manfreds@colorfullife.com>
+ *
+ * make it a filesystem (based on Christoph Rohland's work on shmfs),
+ * (c) 2000 Jakub Jelinek <jakub@redhat.com>
  */
 
 #include <linux/config.h>
@@ -22,6 +25,11 @@
 #include <linux/init.h>
 #include <linux/proc_fs.h>
 #include <linux/list.h>
+#include <linux/module.h>
+#include <linux/mqueue.h>
+#include <linux/poll.h>
+#include <linux/signal.h>
+#include <linux/smp_lock.h>
 #include <asm/uaccess.h>
 #include "util.h"
 
@@ -29,6 +37,78 @@
 int msg_ctlmax = MSGMAX;
 int msg_ctlmnb = MSGMNB;
 int msg_ctlmni = MSGMNI;
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
+static struct super_block *msg_read_super(struct super_block *,void *, int);
+static void msg_put_super(struct super_block *);
+static int msg_remount_fs(struct super_block *, int *, char *);
+static void msg_read_inode(struct inode *);
+static int msg_statfs(struct super_block *, struct statfs *);
+static int msg_create(struct inode *,struct dentry *,int);
+static struct dentry *msg_lookup(struct inode *,struct dentry *);
+static int msg_unlink(struct inode *,struct dentry *);
+static int msg_setattr(struct dentry *dent, struct iattr *attr);
+static void msg_delete(struct inode *);
+static int msg_readdir(struct file *, void *, filldir_t);
+static int msg_remove_name(int id);
+static int msg_ioctl(struct inode *, struct file *, unsigned int, unsigned long);
+static int msg_root_ioctl(struct inode *, struct file *, unsigned int, unsigned long);
+static ssize_t msg_read(struct file *, char *, size_t, loff_t *);
+static ssize_t msg_write(struct file *, const char *, size_t, loff_t *);
+/* FIXME: Support poll on mq
+static unsigned int msg_poll(struct file *, poll_table *);
+ */
+static ssize_t msg_send (struct inode *, struct file *, const char *, size_t, long);
+static ssize_t msg_receive (struct inode *, struct file *, char *, size_t, long *);
+static int msg_flush (struct file *);
+static int msg_release (struct inode *, struct file *);
+
+static DECLARE_FSTYPE(msg_fs_type, "msg", msg_read_super, FS_SINGLE);
+
+static struct super_operations msg_sops = {
+	read_inode:	msg_read_inode,
+	delete_inode:	msg_delete,
+	put_super:	msg_put_super,
+	statfs:		msg_statfs,
+	remount_fs:	msg_remount_fs,
+};
+
+static struct file_operations msg_root_operations = {
+	readdir:	msg_readdir,
+	ioctl:		msg_root_ioctl,
+};
+
+static struct inode_operations msg_root_inode_operations = {
+	create:		msg_create,
+	lookup:		msg_lookup,
+	unlink:		msg_unlink,
+};
+
+static struct file_operations msg_file_operations = {
+	read:		msg_read,
+	write:		msg_write,
+	ioctl:		msg_ioctl,
+/* FIXME: Support poll on mq *
+	poll:		msg_poll,
+ */
+	flush:		msg_flush,
+	release:	msg_release,
+};
+
+static struct inode_operations msg_inode_operations = {
+	setattr:	msg_setattr,
+};
 
 /* one msg_receiver structure for each sleeping receiver */
 struct msg_receiver {
@@ -55,7 +135,7 @@ struct msg_msgseg {
 /* one msg_msg structure for each message */
 struct msg_msg {
 	struct list_head m_list; 
-	long  m_type;          
+	long  m_type;
 	int m_ts;           /* message text size */
 	struct msg_msgseg* next;
 	/* the actual message follows immediately */
@@ -67,19 +147,36 @@ struct msg_msg {
 /* one msq_queue structure for each present queue on the system */
 struct msg_queue {
 	struct kern_ipc_perm q_perm;
+#define q_flags q_perm.mode
 	time_t q_stime;			/* last msgsnd time */
 	time_t q_rtime;			/* last msgrcv time */
 	time_t q_ctime;			/* last change time */
 	unsigned long q_cbytes;		/* current number of bytes on queue */
 	unsigned long q_qnum;		/* number of messages in queue */
 	unsigned long q_qbytes;		/* max number of bytes on queue */
+	unsigned int q_msgsize;		/* max number of bytes for one message */
+	unsigned int q_maxmsg;		/* max number of outstanding messages */
 	pid_t q_lspid;			/* pid of last msgsnd */
 	pid_t q_lrpid;			/* last receive pid */
+	int q_signo;			/* signal to be sent if empty queue with no waiting
+					   receivers should be sent */
+	pid_t q_pid;			/* to which pid */
+	sigval_t q_sigval;		/* which value to pass */
+	int id;
 
 	struct list_head q_messages;
 	struct list_head q_receivers;
 	struct list_head q_senders;
+	unsigned int q_namelen;
+	unsigned char q_name[0];
+};
+
+struct mq_link {
+	struct list_head link;
+	struct task_struct *tsk;
+	struct mq_attr *attr;
 };
+static LIST_HEAD(mq_open_links);
 
 #define SEARCH_ANY		1
 #define SEARCH_EQUAL		2
@@ -94,32 +191,529 @@ static struct ipc_ids msg_ids;
 #define msg_lock(id)	((struct msg_queue*)ipc_lock(&msg_ids,id))
 #define msg_unlock(id)	ipc_unlock(&msg_ids,id)
 #define msg_rmid(id)	((struct msg_queue*)ipc_rmid(&msg_ids,id))
-#define msg_checkid(msq, msgid)	\
-	ipc_checkid(&msg_ids,&msq->q_perm,msgid)
+#define msg_get(id)	((struct msg_queue*)ipc_get(&msg_ids,id))
 #define msg_buildid(id, seq) \
 	ipc_buildid(&msg_ids, id, seq)
 
 static void freeque (int id);
-static int newque (key_t key, int msgflg);
+static int newque (key_t key, const char *name, int namelen, struct mq_attr *attr, int msgflg);
 #ifdef CONFIG_PROC_FS
 static int sysvipc_msg_read_proc(char *buffer, char **start, off_t offset, int length, int *eof, void *data);
 #endif
 
 void __init msg_init (void)
 {
+	struct vfsmount *res;
 	ipc_init_ids(&msg_ids,msg_ctlmni);
 
+	register_filesystem (&msg_fs_type);
+	res = kern_mount(&msg_fs_type);
+	if (IS_ERR(res)) {
+		unregister_filesystem(&msg_fs_type);
+		return;
+	}
 #ifdef CONFIG_PROC_FS
 	create_proc_read_entry("sysvipc/msg", 0, 0, sysvipc_msg_read_proc, NULL);
 #endif
 }
 
-static int newque (key_t key, int msgflg)
+static int msg_parse_options(char *options)
+{
+	int blocks = msg_ctlmnb * msg_ctlmni;
+	int inodes = msg_ctlmni;
+	umode_t mode = msg_mode;
+	char *this_char, *value;
+
+	this_char = NULL;
+	if ( options )
+		this_char = strtok(options,",");
+	for ( ; this_char; this_char = strtok(NULL,",")) {
+		if ((value = strchr(this_char,'=')) != NULL)
+			*value++ = 0;
+		if (!strcmp(this_char,"nr_blocks")) {
+			if (!value || !*value)
+				return 1;
+			blocks = simple_strtoul(value,&value,0);
+			if (*value)
+				return 1;
+		}
+		else if (!strcmp(this_char,"nr_inodes")) {
+			if (!value || !*value)
+				return 1;
+			inodes = simple_strtoul(value,&value,0);
+			if (*value)
+				return 1;
+		}
+		else if (!strcmp(this_char,"mode")) {
+			if (!value || !*value)
+				return 1;
+			mode = simple_strtoul(value,&value,8);
+			if (*value)
+				return 1;
+		}
+		else
+			return 1;
+	}
+/* FIXME *
+	msg_ctlmni = inodes;
+	msg_ctlmnb = inodes ? blocks / inodes : 0;
+ */
+	msg_mode   = mode;
+
+	return 0;
+}
+
+static struct super_block *msg_read_super(struct super_block *s,void *data, 
+					  int silent)
+{
+	struct inode * root_inode;
+
+/* FIXME *
+	msg_ctlmnb = MSGMNB;
+	msg_ctlmni = MSGMNI;
+ */
+	msg_mode   = S_IRWXUGO | S_ISVTX;
+	if (msg_parse_options (data)) {
+		printk(KERN_ERR "msg fs invalid option\n");
+		goto out_unlock;
+	}
+
+	s->s_blocksize = PAGE_SIZE;
+	s->s_blocksize_bits = PAGE_SHIFT;
+	s->s_magic = MSG_FS_MAGIC;
+	s->s_op = &msg_sops;
+	root_inode = iget (s, SEQ_MULTIPLIER);
+	if (!root_inode)
+		goto out_no_root;
+	root_inode->i_op = &msg_root_inode_operations;
+	root_inode->i_sb = s;
+	root_inode->i_nlink = 2;
+	root_inode->i_mode = S_IFDIR | msg_mode;
+	s->s_root = d_alloc_root(root_inode);
+	if (!s->s_root)
+		goto out_no_root;
+	msg_sb = s;
+	return s;
+
+out_no_root:
+	printk(KERN_ERR "msg_read_super: get root inode failed\n");
+	iput(root_inode);
+out_unlock:
+	return NULL;
+}
+
+static int msg_remount_fs (struct super_block *sb, int *flags, char *data)
+{
+	if (msg_parse_options (data))
+		return -EINVAL;
+	return 0;
+}
+
+static inline int msg_checkid(struct msg_queue *msq, int id)
+{
+	if (!(msq->q_flags & MSG_SYSV))
+		return -EINVAL;
+	if (ipc_checkid(&msg_ids,&msq->q_perm,id))
+		return -EIDRM;
+	return 0;
+}
+
+static void msg_put_super(struct super_block *sb)
+{
+	int i;
+	struct msg_queue *msq;
+
+	down(&msg_ids.sem);
+	for(i = 0; i <= msg_ids.max_id; i++) {
+		if (!(msq = msg_lock (i)))
+			continue;
+		freeque(i);
+	}
+	dput (sb->s_root);
+	up(&msg_ids.sem);
+}
+
+static int msg_statfs(struct super_block *sb, struct statfs *buf)
+{
+	buf->f_type = MSG_FS_MAGIC;
+	buf->f_bsize = PAGE_SIZE;
+	buf->f_blocks = (msg_ctlmnb * msg_ctlmni) >> PAGE_SHIFT;
+	buf->f_bavail = buf->f_bfree = buf->f_blocks - (atomic_read(&msg_bytes) >> PAGE_SHIFT);
+	buf->f_files = msg_ctlmni;
+	buf->f_ffree = msg_ctlmni - atomic_read(&msg_hdrs);
+	buf->f_namelen = MSG_NAME_LEN;
+	return 0;
+}
+
+static void msg_read_inode(struct inode * inode)
 {
 	int id;
 	struct msg_queue *msq;
 
-	msq  = (struct msg_queue *) kmalloc (sizeof (*msq), GFP_KERNEL);
+	id = inode->i_ino;
+	inode->i_op = NULL;
+	inode->i_mode = 0;
+	
+	if (id < SEQ_MULTIPLIER) {
+		if (!(msq = msg_lock (id)))
+			return;
+		inode->i_mode = (msq->q_flags & S_IRWXUGO) | S_IFIFO;
+		inode->i_uid  = msq->q_perm.uid;
+		inode->i_gid  = msq->q_perm.gid;
+		inode->i_size = msq->q_cbytes;
+		inode->i_mtime = msq->q_stime;
+		inode->i_atime = msq->q_stime > msq->q_rtime ? msq->q_stime : msq->q_rtime;
+		inode->i_ctime = msq->q_ctime;
+		msg_unlock (id);
+		inode->i_op  = &msg_inode_operations;
+		inode->i_fop = &msg_file_operations;
+		return;
+	}
+	inode->i_mtime = inode->i_atime = inode->i_ctime = CURRENT_TIME;
+	inode->i_op    = &msg_root_inode_operations;
+	inode->i_fop   = &msg_root_operations;
+	inode->i_sb    = msg_sb;
+	inode->i_nlink = 2;
+	inode->i_mode  = S_IFDIR | msg_mode;
+	inode->i_uid   = inode->i_gid = 0;
+}
+
+static int msg_create (struct inode *dir, struct dentry *dent, int mode)
+{
+	int id, err;
+	struct inode *inode;
+	struct mq_attr attr, *p;
+	struct list_head *tmp;
+
+	attr.mq_maxmsg = 32;
+	attr.mq_msgsize = 64;
+	p = &attr;
+
+	down(&msg_ids.sem);
+	list_for_each(tmp, &mq_open_links) {
+		struct mq_link *l = list_entry(tmp, struct mq_link, link);
+		if (l->tsk == current) {
+			p = l->attr;
+			break;
+		}
+	}
+	err = id = newque (IPC_PRIVATE, dent->d_name.name, dent->d_name.len, p, mode);
+	if (err < 0)
+		goto out;
+
+	err = -ENOMEM;
+	inode = iget (msg_sb, id % SEQ_MULTIPLIER);
+	if (!inode)
+		goto out;
+
+	err = 0;
+	down (&inode->i_sem);
+	inode->i_mode = (mode & S_IRWXUGO) | S_IFIFO;
+	inode->i_op   = &msg_inode_operations;
+	d_instantiate(dent, inode);
+	up (&inode->i_sem);
+
+out:
+	up(&msg_ids.sem);
+	return err;
+}
+
+static int msg_readdir (struct file *filp, void *dirent, filldir_t filldir)
+{
+	struct inode * inode = filp->f_dentry->d_inode;
+	struct msg_queue *msq;
+	off_t nr;
+
+	nr = filp->f_pos;
+
+	switch(nr)
+	{
+	case 0:
+		if (filldir(dirent, ".", 1, nr, inode->i_ino, DT_DIR) < 0)
+			return 0;
+		filp->f_pos = ++nr;
+		/* fall through */
+	case 1:
+		if (filldir(dirent, "..", 2, nr, inode->i_ino, DT_DIR) < 0)
+			return 0;
+		filp->f_pos = ++nr;
+		/* fall through */
+	default:
+		down(&msg_ids.sem);
+		for (; nr-2 <= msg_ids.max_id; nr++) {
+			if (!(msq = msg_get (nr-2))) 
+				continue;
+			if (msq->q_flags & MSG_UNLK)
+				continue;
+			if (filldir(dirent, msq->q_name, msq->q_namelen, nr, nr, DT_FIFO) < 0)
+				break;;
+		}
+		filp->f_pos = nr;
+		up(&msg_ids.sem);
+		break;
+	}
+
+	UPDATE_ATIME(inode);
+	return 0;
+}
+
+static struct dentry *msg_lookup (struct inode *dir, struct dentry *dent)
+{
+	int i, err = 0;
+	struct msg_queue* msq;
+	struct inode *inode = NULL;
+
+	if (dent->d_name.len > MSG_NAME_LEN)
+		return ERR_PTR(-ENAMETOOLONG);
+
+	down(&msg_ids.sem);
+	for(i = 0; i <= msg_ids.max_id; i++) {
+		if (!(msq = msg_lock(i)))
+			continue;
+		if (!(msq->q_flags & MSG_UNLK) &&
+		    dent->d_name.len == msq->q_namelen &&
+		    strncmp(dent->d_name.name, msq->q_name, msq->q_namelen) == 0)
+			goto found;
+		msg_unlock(i);
+	}
+
+	/*
+	 * prevent the reserved names as negative dentries. 
+	 * This also prevents object creation through the filesystem
+	 */
+	if (dent->d_name.len == MSG_FMT_LEN &&
+	    memcmp (MSG_FMT, dent->d_name.name, MSG_FMT_LEN - 8) == 0)
+		err = -EINVAL;	/* EINVAL to give IPC_RMID the right error */
+
+	goto out;
+
+found:
+	msg_unlock(i);
+	inode = iget(dir->i_sb, i);
+
+	if (!inode)
+		err = -EACCES;
+out:
+	if (err == 0)
+		d_add (dent, inode);
+	up (&msg_ids.sem);
+	return ERR_PTR(err);
+}
+
+extern inline int msg_do_unlink (struct inode *dir, struct dentry *dent, int sysv)
+{
+	struct inode * inode = dent->d_inode;
+	struct msg_queue *msq;
+
+	down (&msg_ids.sem);
+	if (!(msq = msg_lock (inode->i_ino)))
+		BUG();
+	if (sysv) {
+		int ret = 0;
+
+		if (!(msq->q_flags & MSG_SYSV))
+			ret = -EINVAL;
+		else if (current->euid != msq->q_perm.cuid &&
+			 current->euid != msq->q_perm.uid && !capable(CAP_SYS_ADMIN))
+			ret = -EPERM;
+		if (ret) {
+			msg_unlock (inode->i_ino);
+			up (&msg_ids.sem);
+			return ret;
+		}
+	}
+	msq->q_flags |= MSG_UNLK;
+	msq->q_perm.key = IPC_PRIVATE; /* Do not find it any more */
+	msg_unlock (inode->i_ino);
+	up (&msg_ids.sem);
+	inode->i_nlink -= 1;
+	/*
+	 * If it's a reserved name we have to drop the dentry instead
+	 * of creating a negative dentry
+	 */
+	if (dent->d_name.len == MSG_FMT_LEN &&
+	    memcmp (MSG_FMT, dent->d_name.name, MSG_FMT_LEN - 8) == 0)
+		d_drop (dent);
+	return 0;
+}
+
+static int msg_unlink (struct inode *dir, struct dentry *dent)
+{
+	return msg_do_unlink (dir, dent, 0);
+}
+
+static int msg_setattr (struct dentry *dentry, struct iattr *attr)
+{
+	int error;
+	struct inode *inode = dentry->d_inode;
+	struct msg_queue *msq;
+
+	error = inode_change_ok(inode, attr);
+	if (error)
+		return error;
+	if (attr->ia_valid & ATTR_SIZE)
+		return -EINVAL;
+
+	if (attr->ia_valid & (ATTR_MODE | ATTR_UID | ATTR_GID)) {
+		if (!(msq = msg_lock(inode->i_ino)))
+			BUG();
+		if (attr->ia_valid & ATTR_MODE)
+			msq->q_flags = (msq->q_flags & ~S_IRWXUGO)
+				| (S_IRWXUGO & attr->ia_mode);
+		if (attr->ia_valid & ATTR_UID)
+			msq->q_perm.uid = attr->ia_uid;
+		if (attr->ia_valid & ATTR_GID)
+			msq->q_perm.gid = attr->ia_gid;
+		msq->q_ctime = attr->ia_ctime;
+		msg_unlock (inode->i_ino);
+	}
+
+	inode_setattr(inode, attr);
+	return error;
+}
+
+static int msg_root_ioctl (struct inode * inode, struct file * filp, unsigned int cmd, unsigned long arg)
+{
+	struct mq_open o;
+	struct mq_link link;
+	int ret;
+
+	if (cmd != MQ_OPEN)
+		return -EINVAL;
+	unlock_kernel();
+	ret = -EFAULT;
+	if (copy_from_user(&o, (struct mq_open *)arg, sizeof(struct mq_open)))
+		goto out;
+	ret = -EINVAL;
+	if ((unsigned long)o.mq_attr.mq_msgsize > msg_ctlmnb ||
+	    (unsigned long)o.mq_attr.mq_maxmsg > msg_ctlmnb ||
+	    o.mq_attr.mq_msgsize * o.mq_attr.mq_maxmsg > msg_ctlmnb)
+		goto out;
+	link.attr = &o.mq_attr;
+	link.tsk = current;
+	down(&msg_ids.sem);
+	list_add(&link.link, &mq_open_links);
+	up(&msg_ids.sem);
+	/* FIXME: Shouldn't we check here whether mq_name is really a file within the msg filesystem?
+	   Otherwise people tracing the open(2) syscall might miss this place... */
+	ret = sys_open(o.mq_name, o.mq_oflag, o.mq_mode);
+	down(&msg_ids.sem);
+	list_del(&link.link);
+	up(&msg_ids.sem);
+out:
+	lock_kernel();
+	return ret;
+}
+
+static int msg_ioctl (struct inode * inode, struct file * filp, unsigned int cmd, unsigned long arg)
+{
+	int ret = -EINVAL;
+	struct msg_queue *msq;
+	struct mq_sndrcv sr;
+
+	unlock_kernel();
+	switch (cmd) {
+	case MQ_GETATTR: {
+		struct mq_attr attr;
+		memset(&attr, 0, sizeof(attr));
+		msq = msg_lock (inode->i_ino);
+		if (msq == NULL)
+			BUG();
+		attr.mq_maxmsg = msq->q_maxmsg;
+		attr.mq_msgsize = msq->q_msgsize;
+		attr.mq_curmsgs = msq->q_qnum;
+		attr.mq_flags = filp->f_flags & O_NONBLOCK;
+		msg_unlock (inode->i_ino);
+		ret = copy_to_user((struct mq_attr *)arg, &attr, sizeof(attr)) ? -EFAULT : 0;
+		break;
+		}
+	case MQ_SEND:
+		ret = -EBADF;
+		if (!(filp->f_mode & FMODE_WRITE))
+			break;
+		ret = -EFAULT;
+		if (copy_from_user(&sr, (struct mq_sndrcv *)arg, sizeof(sr)))
+			break;
+		ret = -EINVAL;
+		if (sr.mq_type <= 0)
+			break;
+		ret = msg_send (inode, filp, sr.mq_buf, sr.mq_len, sr.mq_type);
+		break;
+	case MQ_RECEIVE:
+		ret = -EBADF;
+		if (!(filp->f_mode & FMODE_READ))
+			break;
+		ret = -EFAULT;
+		if (copy_from_user(&sr, (struct mq_sndrcv *)arg, sizeof(sr)))
+			break;
+		ret = msg_receive (inode, filp, sr.mq_buf, sr.mq_len, &sr.mq_type);
+		if (!ret && put_user (sr.mq_type, &((struct mq_sndrcv *)arg)->mq_type))
+			ret = -EFAULT;
+		break;
+	case MQ_NOTIFY: {
+		struct sigevent sev;
+		struct msg_queue *msg;
+		ret = -EFAULT;
+		if (copy_from_user(&sev, (struct sigevent *)arg, sizeof(sev)))
+			break;
+		ret = -EINVAL;
+		if (sev.sigev_notify != SIGEV_SIGNAL && sev.sigev_notify != SIGEV_NONE)
+			break;
+		if (sev.sigev_signo <= 0 || sev.sigev_signo > _NSIG)
+			break;
+		msg = msg_lock(inode->i_ino);
+		if (!msg) BUG();
+		ret = 0;
+		if (msg->q_signo)
+			ret = -EBUSY;
+		else if (sev.sigev_notify == SIGEV_SIGNAL) {
+			msg->q_signo = sev.sigev_signo;
+			msg->q_sigval = sev.sigev_value;
+		} else
+			msg->q_signo = 0;
+		msg_unlock(inode->i_ino);
+		}
+	default:
+		break;
+	}
+	lock_kernel();
+	return ret;
+}
+
+static ssize_t msg_write(struct file * file, const char * buf, size_t count, loff_t *ppos)
+{
+	int ret = msg_send(file->f_dentry->d_inode, file, buf, count, MQ_DEFAULT_TYPE);
+	return ret ?: count;
+}
+
+static ssize_t msg_read(struct file * file, char * buf, size_t count, loff_t *ppos)
+{
+	return msg_receive(file->f_dentry->d_inode, file, buf, count, NULL);
+}
+
+static int msg_release (struct inode *ino, struct file *filp)
+{
+	struct msg_queue *msq = msg_lock(ino->i_ino);
+	if (!msq) BUG();
+	if (msq->q_signo && msq->q_pid == current->pid)
+		msq->q_signo = 0;
+	msg_unlock(ino->i_ino);
+	return 0;
+}
+
+static int msg_flush (struct file *filp)
+{
+	return msg_release(filp->f_dentry->d_inode, filp);
+}
+
+static int newque (key_t key, const char *name, int namelen, struct mq_attr *attr, int msgflg)
+{
+	int id, bid;
+	struct msg_queue *msq;
+
+	if (namelen > MSG_NAME_LEN)
+		return -ENAMETOOLONG;
+	msq = (struct msg_queue *) kmalloc (sizeof (*msq) + namelen, GFP_KERNEL);
 	if (!msq) 
 		return -ENOMEM;
 	id = ipc_addid(&msg_ids, &msq->q_perm, msg_ctlmni);
@@ -127,20 +721,92 @@ static int newque (key_t key, int msgflg
 		kfree(msq);
 		return -ENOSPC;
 	}
-	msq->q_perm.mode = (msgflg & S_IRWXUGO);
+	msq->q_flags = (msgflg & S_IRWXUGO);
 	msq->q_perm.key = key;
 
 	msq->q_stime = msq->q_rtime = 0;
 	msq->q_ctime = CURRENT_TIME;
 	msq->q_cbytes = msq->q_qnum = 0;
-	msq->q_qbytes = msg_ctlmnb;
 	msq->q_lspid = msq->q_lrpid = 0;
+	msq->q_signo = 0;
 	INIT_LIST_HEAD(&msq->q_messages);
 	INIT_LIST_HEAD(&msq->q_receivers);
 	INIT_LIST_HEAD(&msq->q_senders);
+	msq->id = bid = msg_buildid(id, msq->q_perm.seq);
+
+	if (name) {
+		msq->q_maxmsg = attr->mq_maxmsg;
+		msq->q_msgsize = attr->mq_msgsize;
+		msq->q_qbytes = msq->q_maxmsg * msq->q_msgsize;
+		msq->q_namelen = namelen;
+		memcpy(msq->q_name, name, namelen);
+	} else {
+		msq->q_qbytes = msg_ctlmnb;
+		msq->q_maxmsg = msg_ctlmnb;
+		msq->q_msgsize = msg_ctlmax;
+		msq->q_flags |= MSG_SYSV;
+		msq->q_namelen = sprintf(msq->q_name, MSG_FMT, bid);
+	}
 	msg_unlock(id);
 
-	return msg_buildid(id,msq->q_perm.seq);
+	return bid;
+}
+
+/* FIXME: maybe we need lock_kernel() here */
+static void msg_delete (struct inode *ino)
+{
+	int msgid = ino->i_ino;
+	struct msg_queue *msq;
+
+	down(&msg_ids.sem);
+	msq = msg_lock(msgid);
+	if(msq==NULL)
+		BUG();
+	freeque(msgid);
+	up(&msg_ids.sem);
+	clear_inode(ino);
+}
+
+static int msg_remove_name(int msqid)
+{
+	struct dentry *dir;
+	struct dentry *dentry;
+	struct msg_queue *msq;
+	int error, id;
+	char name[MSG_FMT_LEN+1];
+
+	down(&msg_ids.sem);
+	msq = msg_lock(msqid);
+	if (msq == NULL)
+		return -EINVAL;
+	id = msq->id;
+	if (msg_checkid (msq, msqid)) {
+		msg_unlock(msqid);
+		return -EIDRM;
+	}
+	msg_unlock(msqid);
+	up(&msg_ids.sem);
+	sprintf (name, MSG_FMT, id);
+	dir = lock_parent(msg_sb->s_root);
+	dentry = lookup_one(name, dir);
+	error = PTR_ERR(dentry);
+	if (!IS_ERR(dentry)) {
+		/*
+		 * We have to do our own unlink to prevent the vfs
+		 * permission check. We'll do the SYSV IPC style check
+		 * inside of msg_do_unlink when we hold msg lock and
+		 * msg_ids semaphore.
+		 */
+		struct inode *inode = dir->d_inode;
+		down(&inode->i_zombie);
+		error = msg_do_unlink(inode, dentry, 1);
+		if (!error)
+			d_delete(dentry);
+		up(&inode->i_zombie);
+		dput(dentry);
+	}
+	unlock_dir(dir);
+	return error;
 }
 
 static void free_msg(struct msg_msg* msg)
@@ -155,7 +821,7 @@ static void free_msg(struct msg_msg* msg
 	}
 }
 
-static struct msg_msg* load_msg(void* src, int len)
+static struct msg_msg* load_msg(const char * src, int len)
 {
 	struct msg_msg* msg;
 	struct msg_msgseg** pseg;
@@ -207,9 +873,9 @@ out_err:
 	return ERR_PTR(err);
 }
 
-static int store_msg(void* dest, struct msg_msg* msg, int len)
+static int store_msg(void* dest, struct msg_msg* msg, size_t len)
 {
-	int alen;
+	size_t alen;
 	struct msg_msgseg *seg;
 
 	alen = len;
@@ -229,7 +895,7 @@ static int store_msg(void* dest, struct 
 			return -1;
 		len -= alen;
 		dest = ((char*)dest)+alen;
-		seg=seg->next;
+		seg = seg->next;
 	}
 	return 0;
 }
@@ -288,7 +954,7 @@ static void freeque (int id)
 	expunge_all(msq,-EIDRM);
 	ss_wakeup(&msq->q_senders,1);
 	msg_unlock(id);
-		
+
 	tmp = msq->q_messages.next;
 	while(tmp != &msq->q_messages) {
 		struct msg_msg* msg = list_entry(tmp,struct msg_msg,m_list);
@@ -307,12 +973,12 @@ asmlinkage long sys_msgget (key_t key, i
 	
 	down(&msg_ids.sem);
 	if (key == IPC_PRIVATE) 
-		ret = newque(key, msgflg);
+		ret = newque(key, NULL, MSG_FMT_LEN + 1, NULL, msgflg);
 	else if ((id = ipc_findkey(&msg_ids, key)) == -1) { /* key not used */
 		if (!(msgflg & IPC_CREAT))
 			ret = -ENOENT;
 		else
-			ret = newque(key, msgflg);
+			ret = newque(key, NULL, MSG_FMT_LEN + 1, NULL, msgflg);
 	} else if (msgflg & IPC_CREAT && msgflg & IPC_EXCL) {
 		ret = -EEXIST;
 	} else {
@@ -483,10 +1149,13 @@ asmlinkage long sys_msgctl (int msqid, i
 			return -EINVAL;
 
 		if(cmd == MSG_STAT) {
+			err = -EINVAL;
+			if (!(msq->q_flags & MSG_SYSV))
+				goto out_unlock;
 			success_return = msg_buildid(msqid, msq->q_perm.seq);
 		} else {
-			err = -EIDRM;
-			if (msg_checkid(msq,msqid))
+			err = msg_checkid(msq,msqid);
+			if (err)
 				goto out_unlock;
 			success_return = 0;
 		}
@@ -495,6 +1164,7 @@ asmlinkage long sys_msgctl (int msqid, i
 			goto out_unlock;
 
 		kernel_to_ipc64_perm(&msq->q_perm, &tbuf.msg_perm);
+		tbuf.msg_perm.mode &= S_IRWXUGO;
 		tbuf.msg_stime  = msq->q_stime;
 		tbuf.msg_rtime  = msq->q_rtime;
 		tbuf.msg_ctime  = msq->q_ctime;
@@ -515,7 +1185,7 @@ asmlinkage long sys_msgctl (int msqid, i
 			return -EFAULT;
 		break;
 	case IPC_RMID:
-		break;
+		return msg_remove_name(msqid);
 	default:
 		return  -EINVAL;
 	}
@@ -536,12 +1206,11 @@ asmlinkage long sys_msgctl (int msqid, i
 	    /* We _could_ check for CAP_CHOWN above, but we don't */
 		goto out_unlock_up;
 
-	switch (cmd) {
-	case IPC_SET:
-	{
+	if (cmd == IPC_SET) {
 		if (setbuf.qbytes > msg_ctlmnb && !capable(CAP_SYS_RESOURCE))
 			goto out_unlock_up;
 		msq->q_qbytes = setbuf.qbytes;
+		msq->q_maxmsg = setbuf.qbytes;
 
 		ipcp->uid = setbuf.uid;
 		ipcp->gid = setbuf.gid;
@@ -557,11 +1226,6 @@ asmlinkage long sys_msgctl (int msqid, i
 		 */
 		ss_wakeup(&msq->q_senders,0);
 		msg_unlock(msqid);
-		break;
-	}
-	case IPC_RMID:
-		freeque (msqid); 
-		break;
 	}
 	err = 0;
 out_up:
@@ -623,6 +1287,105 @@ int inline pipelined_send(struct msg_que
 	return 0;
 }
 
+static int msg_do_send (struct msg_queue **msqp, int msqid,
+			struct msg_msg *msg, size_t msgsz, int nowait)
+{
+	struct msg_queue *msq = *msqp;
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
+		current->state = TASK_RUNNING;
+
+		*msqp = msq = msg_lock(msqid);
+		if(msq==NULL)
+			return -EIDRM;
+		ss_del(&s);
+		
+		if (signal_pending(current))
+			return -EINTR;
+		return -EBUSY;
+	}
+
+	if(!pipelined_send(msq,msg)) {
+		/* noone is waiting for this message, enqueue it */
+		list_add_tail(&msg->m_list,&msq->q_messages);
+		msq->q_cbytes += msgsz;
+		msq->q_qnum++;
+		atomic_add(msgsz,&msg_bytes);
+		atomic_inc(&msg_hdrs);
+		if (msq->q_qnum == 1 && msq->q_signo) {
+			struct task_struct *p;
+			siginfo_t si;
+			read_lock(&tasklist_lock);
+			p = find_task_by_pid(msq->q_pid);
+			if (p) {
+				si.si_signo = msq->q_signo;
+				si.si_errno = 0;
+				si.si_code = SI_MESGQ;
+				si.si_pid = current->pid;
+				si.si_uid = current->euid;
+				si.si_value = msq->q_sigval;
+				if (!send_sig_info(msq->q_signo, &si, p))
+					send_sig(msq->q_signo, p, 1);
+			}
+			read_unlock(&tasklist_lock);
+			msq->q_signo = 0;
+		}
+	}
+
+	msq->q_lspid = current->pid;
+	msq->q_stime = CURRENT_TIME;
+	return 0;
+}
+
+static ssize_t msg_send (struct inode *ino, struct file *filp, const char *mtext, size_t msgsz, long mtype)
+{
+	struct msg_queue *msq;
+	struct msg_msg *msg;
+	int err = 0;
+	
+	if (mtype < 1)
+		return -EINVAL;
+	msq = msg_lock(ino->i_ino);
+	if (!msq) BUG();
+	if (msgsz > msq->q_msgsize)
+		err = -EMSGSIZE;
+	msg_unlock(ino->i_ino);
+	if (err) return err;
+
+	msg = load_msg(mtext, msgsz);
+	if(IS_ERR(msg))
+		return PTR_ERR(msg);
+
+	msg->m_type = mtype;
+	msg->m_ts = msgsz;
+
+	msq = msg_lock(ino->i_ino);
+	if (!msq) BUG();
+
+	do {
+		err = -EACCES;
+		if (msq->q_flags & MSG_SYSV && ipcperms(&msq->q_perm, S_IWUGO))
+			break;
+
+		err = msg_do_send(&msq, ino->i_ino, msg, msgsz, filp->f_flags & O_NONBLOCK);
+
+	} while (err == -EBUSY);
+
+	msg_unlock(ino->i_ino);
+	if (msg && err)
+		free_msg(msg);
+	return err;
+}
+
 asmlinkage long sys_msgsnd (int msqid, struct msgbuf *msgp, size_t msgsz, int msgflg)
 {
 	struct msg_queue *msq;
@@ -648,59 +1411,23 @@ asmlinkage long sys_msgsnd (int msqid, s
 	err=-EINVAL;
 	if(msq==NULL)
 		goto out_free;
-retry:
-	err= -EIDRM;
-	if (msg_checkid(msq,msqid))
-		goto out_unlock_free;
-
-	err=-EACCES;
-	if (ipcperms(&msq->q_perm, S_IWUGO)) 
-		goto out_unlock_free;
+	do {
+		err= -EIDRM;
+		if (msg_checkid(msq,msqid))
+			break;
 
-	if(msgsz + msq->q_cbytes > msq->q_qbytes ||
-		1 + msq->q_qnum > msq->q_qbytes) {
-		struct msg_sender s;
+		err=-EACCES;
+		if (ipcperms(&msq->q_perm, S_IWUGO)) 
+			break;
 
-		if(msgflg&IPC_NOWAIT) {
-			err=-EAGAIN;
-			goto out_unlock_free;
-		}
-		ss_add(msq, &s);
-		msg_unlock(msqid);
-		schedule();
-		current->state= TASK_RUNNING;
+		err = msg_do_send(&msq, msqid, msg, msgsz, msgflg & IPC_NOWAIT);
 
-		msq = msg_lock(msqid);
-		err = -EIDRM;
-		if(msq==NULL)
-			goto out_free;
-		ss_del(&s);
-		
-		if (signal_pending(current)) {
-			err=-EINTR;
-			goto out_unlock_free;
-		}
-		goto retry;
-	}
+	} while (err == -EBUSY);
 
-	if(!pipelined_send(msq,msg)) {
-		/* noone is waiting for this message, enqueue it */
-		list_add_tail(&msg->m_list,&msq->q_messages);
-		msq->q_cbytes += msgsz;
-		msq->q_qnum++;
-		atomic_add(msgsz,&msg_bytes);
-		atomic_inc(&msg_hdrs);
-	}
-	
-	err = 0;
-	msg = NULL;
-	msq->q_lspid = current->pid;
-	msq->q_stime = CURRENT_TIME;
-
-out_unlock_free:
-	msg_unlock(msqid);
+	if (msq)
+		msg_unlock(msqid);
 out_free:
-	if(msg!=NULL)
+	if (msg && err)
 		free_msg(msg);
 	return err;
 }
@@ -724,123 +1451,170 @@ int inline convert_mode(long* msgtyp, in
 	return SEARCH_EQUAL;
 }
 
+static struct msg_msg *
+msg_do_receive (struct msg_queue *msq, int *msqidp, size_t msgsz,
+		long msgtyp, int mode, int msgflg)
+{
+	struct msg_receiver msr_d;
+	struct list_head *tmp;
+	struct msg_msg *msg, *found_msg;
+	int msqid = *msqidp;
+
+	for (;;) {
+		if (msq->q_flags & MSG_SYSV && ipcperms (&msq->q_perm, S_IRUGO))
+			return ERR_PTR(-EACCES);
+
+		tmp = msq->q_messages.next;
+		found_msg = NULL;
+		while (tmp != &msq->q_messages) {
+			msg = list_entry(tmp,struct msg_msg,m_list);
+			if(testmsg(msg, msgtyp, mode)) {
+				found_msg = msg;
+				if(mode == SEARCH_LESSEQUAL && msg->m_type != 1)
+					msgtyp = msg->m_type - 1;
+				else
+					break;
+			}
+			tmp = tmp->next;
+		}
+		if (found_msg) {
+			msg = found_msg;
+			if ((msgsz < msg->m_ts) && !(msgflg & MSG_NOERROR))
+				return ERR_PTR(-E2BIG);
+			list_del(&msg->m_list);
+			msq->q_qnum--;
+			msq->q_rtime = CURRENT_TIME;
+			msq->q_lrpid = current->pid;
+			msq->q_cbytes -= msg->m_ts;
+			atomic_sub(msg->m_ts,&msg_bytes);
+			atomic_dec(&msg_hdrs);
+			ss_wakeup(&msq->q_senders,0);
+			msg_unlock(msqid);
+			return msg;
+		} else {
+			struct msg_queue *t;
+			/* no message waiting. Prepare for pipelined
+			 * receive.
+			 */
+			if (msgflg & IPC_NOWAIT)
+				return ERR_PTR(-ENOMSG);
+			list_add_tail(&msr_d.r_list,&msq->q_receivers);
+			msr_d.r_tsk = current;
+			msr_d.r_msgtype = msgtyp;
+			msr_d.r_mode = mode;
+			if(msgflg & MSG_NOERROR)
+				msr_d.r_maxsize = INT_MAX;
+			else
+				msr_d.r_maxsize = msgsz;
+			msr_d.r_msg = ERR_PTR(-EAGAIN);
+			current->state = TASK_INTERRUPTIBLE;
+			msg_unlock(msqid);
+
+			schedule();
+			current->state = TASK_RUNNING;
+
+			msg = (struct msg_msg*) msr_d.r_msg;
+			if(!IS_ERR(msg))
+				return msg;
+
+			t = msg_lock(msqid);
+			if(t == NULL)
+				*msqidp = msqid = -1;
+			msg = (struct msg_msg*)msr_d.r_msg;
+			if(!IS_ERR(msg)) {
+				/* our message arived while we waited for
+				 * the spinlock. Process it.
+				 */
+				if (msqid != -1)
+					msg_unlock(msqid);
+				return msg;
+			}
+			if(PTR_ERR(msg) == -EAGAIN) {
+				if(msqid == -1)
+					BUG();
+				list_del(&msr_d.r_list);
+				if (signal_pending(current))
+					return ERR_PTR(-EINTR);
+				else
+					continue;
+			}
+			return msg;
+		}
+	}
+}
+
+static int msg_receive (struct inode *ino, struct file *filp, char *mtext,
+			size_t msgsz, long *msgtypp)
+{
+	struct msg_queue *msq;
+	struct msg_msg *msg;
+	long msgtyp;
+	int err, mode, msqid = ino->i_ino;
+
+	if (msgtypp)
+		msgtyp = *msgtypp;
+	else
+		msgtyp = -MQ_DEFAULT_TYPE;
+	mode = convert_mode(&msgtyp, 0);
+	msq = msg_lock(msqid);
+	if (!msq) BUG();
+	if (msgtypp && msgsz < msq->q_msgsize) {
+		msg_unlock(msqid);
+		return -EMSGSIZE;
+	}
+
+	msg = msg_do_receive (msq, &msqid, msgsz, msgtyp, mode,
+			      (filp->f_flags & O_NONBLOCK) ? IPC_NOWAIT : 0);
+	if (!IS_ERR (msg)) {
+		msgsz = (msgsz > msg->m_ts) ? msg->m_ts : msgsz;
+		if (store_msg(mtext, msg, msgsz))
+			msgsz = -EFAULT;
+		else if (msgtypp)
+			*msgtypp = msg->m_type;
+		free_msg(msg);
+		return msgsz;
+	}
+	if (msqid != -1)
+		msg_unlock(msqid);
+	err = PTR_ERR(msg);
+	switch (err) {
+	case -ENOMSG: err = -EAGAIN; break;
+	case -E2BIG: err = -EMSGSIZE; break;
+	}
+	return err;
+}
+
 asmlinkage long sys_msgrcv (int msqid, struct msgbuf *msgp, size_t msgsz,
 			    long msgtyp, int msgflg)
 {
 	struct msg_queue *msq;
-	struct msg_receiver msr_d;
-	struct list_head* tmp;
-	struct msg_msg* msg, *found_msg;
-	int err;
+	struct msg_msg *msg;
 	int mode;
 
 	if (msqid < 0 || (long) msgsz < 0)
 		return -EINVAL;
-	mode = convert_mode(&msgtyp,msgflg);
+	mode = convert_mode(&msgtyp, msgflg);
 
-	msq = msg_lock(msqid);
-	if(msq==NULL)
+	msq = msg_lock (msqid);
+	if (msq==NULL)
 		return -EINVAL;
-retry:
-	err=-EACCES;
-	if (ipcperms (&msq->q_perm, S_IRUGO))
-		goto out_unlock;
 
-	tmp = msq->q_messages.next;
-	found_msg=NULL;
-	while (tmp != &msq->q_messages) {
-		msg = list_entry(tmp,struct msg_msg,m_list);
-		if(testmsg(msg,msgtyp,mode)) {
-			found_msg = msg;
-			if(mode == SEARCH_LESSEQUAL && msg->m_type != 1) {
-				found_msg=msg;
-				msgtyp=msg->m_type-1;
-			} else {
-				found_msg=msg;
-				break;
-			}
-		}
-		tmp = tmp->next;
+	if (!(msq->q_flags & MSG_SYSV)) {
+		msg_unlock (msqid);
+		return -EINVAL;
 	}
-	if(found_msg) {
-		msg=found_msg;
-		if ((msgsz < msg->m_ts) && !(msgflg & MSG_NOERROR)) {
-			err=-E2BIG;
-			goto out_unlock;
-		}
-		list_del(&msg->m_list);
-		msq->q_qnum--;
-		msq->q_rtime = CURRENT_TIME;
-		msq->q_lrpid = current->pid;
-		msq->q_cbytes -= msg->m_ts;
-		atomic_sub(msg->m_ts,&msg_bytes);
-		atomic_dec(&msg_hdrs);
-		ss_wakeup(&msq->q_senders,0);
-		msg_unlock(msqid);
-out_success:
+	msg = msg_do_receive (msq, &msqid, msgsz, msgtyp, mode, msgflg);
+	if (!IS_ERR (msg)) {
 		msgsz = (msgsz > msg->m_ts) ? msg->m_ts : msgsz;
 		if (put_user (msg->m_type, &msgp->mtype) ||
-		    store_msg(msgp->mtext, msg, msgsz)) {
-			    msgsz = -EFAULT;
-		}
+		    store_msg(msgp->mtext, msg, msgsz))
+			msgsz = -EFAULT;
 		free_msg(msg);
 		return msgsz;
-	} else
-	{
-		struct msg_queue *t;
-		/* no message waiting. Prepare for pipelined
-		 * receive.
-		 */
-		if (msgflg & IPC_NOWAIT) {
-			err=-ENOMSG;
-			goto out_unlock;
-		}
-		list_add_tail(&msr_d.r_list,&msq->q_receivers);
-		msr_d.r_tsk = current;
-		msr_d.r_msgtype = msgtyp;
-		msr_d.r_mode = mode;
-		if(msgflg & MSG_NOERROR)
-			msr_d.r_maxsize = INT_MAX;
-		 else
-		 	msr_d.r_maxsize = msgsz;
-		msr_d.r_msg = ERR_PTR(-EAGAIN);
-		current->state = TASK_INTERRUPTIBLE;
-		msg_unlock(msqid);
-
-		schedule();
-		current->state = TASK_RUNNING;
-
-		msg = (struct msg_msg*) msr_d.r_msg;
-		if(!IS_ERR(msg)) 
-			goto out_success;
-
-		t = msg_lock(msqid);
-		if(t==NULL)
-			msqid=-1;
-		msg = (struct msg_msg*)msr_d.r_msg;
-		if(!IS_ERR(msg)) {
-			/* our message arived while we waited for
-			 * the spinlock. Process it.
-			 */
-			if(msqid!=-1)
-				msg_unlock(msqid);
-			goto out_success;
-		}
-		err = PTR_ERR(msg);
-		if(err == -EAGAIN) {
-			if(msqid==-1)
-				BUG();
-			list_del(&msr_d.r_list);
-			if (signal_pending(current))
-				err=-EINTR;
-			 else
-				goto retry;
-		}
 	}
-out_unlock:
-	if(msqid!=-1)
+	if (msqid != -1)
 		msg_unlock(msqid);
-	return err;
+	return PTR_ERR(msg);
 }
 
 #ifdef CONFIG_PROC_FS
@@ -857,10 +1631,10 @@ static int sysvipc_msg_read_proc(char *b
 		struct msg_queue * msq;
 		msq = msg_lock(i);
 		if(msq != NULL) {
-			len += sprintf(buffer + len, "%10d %10d  %4o  %10lu %10lu %5u %5u %5u %5u %5u %5u %10lu %10lu %10lu\n",
+			len += sprintf(buffer + len, "%10d %10d  %4o  %10lu %10lu %5u %5u %5u %5u %5u %5u %10lu %10lu %10lu %.*s%s\n",
 				msq->q_perm.key,
 				msg_buildid(i,msq->q_perm.seq),
-				msq->q_perm.mode,
+				msq->q_flags & S_IRWXUGO,
 				msq->q_cbytes,
 				msq->q_qnum,
 				msq->q_lspid,
@@ -871,7 +1645,10 @@ static int sysvipc_msg_read_proc(char *b
 				msq->q_perm.cgid,
 				msq->q_stime,
 				msq->q_rtime,
-				msq->q_ctime);
+				msq->q_ctime,
+				msq->q_namelen,
+				msq->q_name,
+				msq->q_flags & MSG_UNLK ? " (deleted)" : "");
 			msg_unlock(i);
 
 			pos += len;

--4ZLFUWh1odzi/v6L
Content-Type: text/plain; charset=us-ascii
Content-Disposition: attachment; filename="mqueue.h"

#ifndef _MQUEUE_H
#define _MQUEUE_H

#include <sys/types.h>
#include <signal.h>
#include <fcntl.h>

typedef int mqd_t;

struct mq_attr {
  long  mq_flags;	/* O_NONBLOCK or 0 */
  long  mq_maxmsg;	/* Maximum number of messages in the queue */
  long  mq_msgsize;	/* Maximum size of one message in bytes */
  long  mq_curmsgs;	/* Current number of messages in the queue */
  long  __pad[2];
};

#define MQ_PRIO_MAX	0x7FFFFFFE

int	mq_close (mqd_t);
int	mq_getattr (mqd_t, struct mq_attr *);
int	mq_notify (mqd_t, const struct sigevent *);
mqd_t	mq_open (const char *, int, ...);
ssize_t	mq_receive (mqd_t, char *, size_t, unsigned int *);
int	mq_send (mqd_t, const char *, size_t, unsigned int);
int	mq_setattr (mqd_t, const struct mq_attr *, struct mq_attr *);
int	mq_unlink (const char *);

#endif /* mqueue.h */

--4ZLFUWh1odzi/v6L
Content-Type: text/plain; charset=us-ascii
Content-Disposition: attachment; filename="mqueue.c"

#define _GNU_SOURCE
#include <sys/types.h>
#include <sys/ioctl.h>
#include <stdarg.h>
#include <signal.h>
#include <unistd.h>
#include <fcntl.h>
#include <string.h>
#include <errno.h>
#include <alloca.h>

struct mq_attr {
	long		mq_flags;	/* O_NONBLOCK or 0 */
	long		mq_maxmsg;	/* Maximum number of messages in the queue */
	long		mq_msgsize;	/* Maximum size of one message in bytes */
	long		mq_curmsgs;	/* Current number of messages in the queue */
	long		__pad[2];
};

struct mq_open {
	char		*mq_name;	/* pathname */
	int		mq_oflag;	/* flags */
	unsigned short	mq_mode;	/* mode */
	struct mq_attr	mq_attr;	/* attributes */
};

struct mq_sndrcv {
	size_t		mq_len;		/* message length */
	long		mq_type;	/* message type */
	char		*mq_buf;	/* message buffer */
};

#define MQ_OPEN		_IOW(0xB2, 0, struct mq_open)
#define MQ_GETATTR	_IOR(0xB2, 1, struct mq_attr)
#define MQ_SEND		_IOW(0xB2, 2, struct mq_sndrcv)
#define MQ_RECEIVE	_IOWR(0xB2, 3, struct mq_sndrcv)
#define MQ_NOTIFY	_IOW(0xB2, 4, struct sigevent)

#define MQ_PRIO_MAX	0x7FFFFFFE

typedef int mqd_t;

/* *********** */
#ifndef __set_errno
#define __set_errno(x) errno = x
#endif
#ifndef __memcpy
#define __memcpy(x,y,z) memcpy(x,y,z)
#endif
#ifndef __mempcpy
#define __mempcpy(x,y,z) mempcpy(x,y,z)
#endif
#ifndef __ioctl
#define __ioctl(x,y,z) ioctl(x,y,z)
#endif
#undef __libc_once
#define __libc_once(x,y) do { } while (0)
/* *********** */

/* Mount point of the shared memory filesystem.  */
static struct
{
  char *dir;
  size_t dirlen;
} mountpoint
= { "/dev/msg/", 9 };

mqd_t mq_open (const char *name, int oflag, ...)
{
  size_t namelen;
  char *fname, *p;
  int fd;
  mqd_t ret;
  mode_t mode = 0;
  struct mq_attr *attr = NULL;
  struct mq_open open_arg;

  /* Determine where the msgfs is mounted.  */
  __libc_once (once, where_is_msgfs);

  /* If we don't know the mount points there is nothing we can do.  Ever.  */
  if (mountpoint.dir == NULL)
    {
      __set_errno (ENOSYS);
      return -1;
    }
      
  /* Construct the filename.  */
  while (name[0] == '/')
    ++name;
                                          
  if (name[0] == '\0')
    {
      /* The name "/" is not supported.  */
      __set_errno (EINVAL);
      return -1;
    }
                                                                      
  namelen = strlen (name);
  fname = (char *) alloca (mountpoint.dirlen + namelen + 1);
  p = __mempcpy (fname, mountpoint.dir, mountpoint.dirlen);

  if (oflag & O_CREAT)
    {
      va_list ap;

      va_start (ap, oflag);
      /* Get the arguments.  */
      mode = va_arg (ap, mode_t);
      attr = va_arg (ap, struct mq_attr *);
      va_end (ap);

      if (attr != NULL)
	{
	  p[0] = '.';
	  p[1] = '\0';
	  fd = open (fname, O_RDONLY);

	  if (fd < 0)
	    {
	      __set_errno (ENOSYS);
	      return -1;
	    }

	  __memcpy (p, name, namelen + 1);
	  open_arg.mq_name = fname;
	  open_arg.mq_oflag = oflag;
	  open_arg.mq_mode = mode;
	  open_arg.mq_attr = *attr;

	  ret = __ioctl (fd, MQ_OPEN, &open_arg);
	  if (ret < 0 && errno == ENOTTY)
	    __set_errno (ENOSYS);

	  close (fd);
	  return ret;
	}
    }

  __memcpy (p, name, namelen + 1);
  return open (fname, oflag, mode);
}

int mq_close (mqd_t mqdes)
{
  return close (mqdes);
}

int mq_send (mqd_t mqdes, const char *buf, size_t len, unsigned int prio)
{
  struct mq_sndrcv send_req;

  if (prio > MQ_PRIO_MAX)
    {
      __set_errno (EINVAL);
      return -1;
    }

  send_req.mq_buf = (char *)buf;
  send_req.mq_len = len;
  send_req.mq_type = MQ_PRIO_MAX - prio;

  return __ioctl (mqdes, MQ_SEND, &send_req);
}

ssize_t mq_receive (mqd_t mqdes, char *buf, size_t len, unsigned int *prio)
{
  struct mq_sndrcv recv_req;
  ssize_t ret;

  recv_req.mq_buf = buf;
  recv_req.mq_len = len;
  recv_req.mq_type = -MQ_PRIO_MAX;

  ret = __ioctl (mqdes, MQ_RECEIVE, &recv_req);

  if (!ret && prio != NULL)
    *prio = MQ_PRIO_MAX - recv_req.mq_type;

  return ret;
}

int mq_unlink (const char *name)
{
  size_t namelen;
  char *fname;

  /* Determine where the msgfs is mounted.  */
  __libc_once (once, where_is_msgfs);

  if (mountpoint.dir == NULL)
    {
      /* We cannot find the shmfs.  If `name' is really a message
         queue object it must have been created by another process
         and we have no idea where that process found the mountpoint.  */
      __set_errno (ENOENT);
      return -1;
    }

  /* Construct the filename.  */
  while (name[0] == '/')
    ++name;

  if (name[0] == '\0')
    {
      /* The name "/" is not supported.  */
      __set_errno (ENOENT);
      return -1;
    }

  namelen = strlen (name);
  fname = (char *) alloca (mountpoint.dirlen + namelen + 1);
  __mempcpy (__mempcpy (fname, mountpoint.dir, mountpoint.dirlen),
             name, namelen + 1);

  /* And get the file descriptor.  */
  return unlink (fname);
}

int mq_getattr (mqd_t mqdes, const struct mq_attr *mqstat)
{
  return __ioctl (mqdes, MQ_GETATTR, mqstat);
}

int mq_setattr (mqd_t mqdes, const struct mq_attr *mqstat,
	        struct mq_attr *omqstat)
{
  int ret;

  if (omqstat != NULL)
    {
      ret = __ioctl (mqdes, MQ_GETATTR, omqstat);
      if (ret)
	return ret;
    }

  ret = fcntl (mqdes, F_GETFL);
  if (ret == -1)
    return ret;

  if ((ret ^ mqstat->mq_flags) & O_NONBLOCK)
    {
      ret = fcntl (mqdes, F_SETFL, (ret & ~O_NONBLOCK)
				   | (mqstat->mq_flags & O_NONBLOCK));
      if (ret == -1)
	return ret;
    }

  return 0;
}

int mq_notify (mqd_t mqdes, const struct sigevent *notification)
{
  struct sigevent null_notify, *n;

  n = (struct sigevent *)notification;
  if (notification == NULL)
    {
      null_notify.sigev_notify = SIGEV_NONE;
      n = &null_notify;
    }
  else if (notification->sigev_notify != SIGEV_NONE
	   && notification->sigev_notify != SIGEV_SIGNAL)
    {
      __set_errno (EINVAL);
      return -1;
    }

  return __ioctl (mqdes, MQ_NOTIFY, notification);
}

--4ZLFUWh1odzi/v6L--
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
