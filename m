Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S280771AbRLDCvs>; Mon, 3 Dec 2001 21:51:48 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S284436AbRLCXt1>; Mon, 3 Dec 2001 18:49:27 -0500
Received: from mail.lightning.ch ([193.247.134.3]:26895 "HELO
	mail.lightning.ch") by vger.kernel.org with SMTP id <S284834AbRLCRVZ>;
	Mon, 3 Dec 2001 12:21:25 -0500
Message-ID: <3C0BB490.AE523828@lightning.ch>
Date: Mon, 03 Dec 2001 18:21:20 +0100
From: Jean-Christian de Rivaz <jcdr@lightning.ch>
X-Mailer: Mozilla 4.75 [en] (X11; U; Linux 2.2.12 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org
Subject: [RFC][PATCH]/dev/ipc/* to poll a message
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi all,

This patch show a possibiliy to add a device per IPC message queue in
order to use the poll() or select() call. The goal is to have a easy way
in an application to wait on a IPC message in it main loop. This is just
to try and to have some code to talk about. Follow the patch and samples
applications.

Future work can be:
	- debug :-)
	- Config.in to controle CONFIG_IPC_DEV.
	- removing device on ipcrm.
	- ioctl to control type and mode of message to wait.
	- read methode to replace msgrcv() ?
	- write methode to replace msgsnd() ?
	- speciale device (like /dev/ppp) to replace msgget() ?
	- ...

Any comment ?

=== kernel patch =====================================================

--- ipc/msg.c   2001/10/03 09:03:38     1.1.1.13
+++ ipc/msg.c   2001/12/03 15:57:37
@@ -15,6 +15,8 @@
  * (c) 1999 Manfred Spraul <manfreds@colorfullife.com>
  */
 
+#define CONFIG_IPC_DEV
+
 #include <linux/config.h>
 #include <linux/slab.h>
 #include <linux/msg.h>
@@ -24,6 +26,10 @@
 #include <linux/list.h>
 #include <asm/uaccess.h>
 #include "util.h"
+#ifdef CONFIG_IPC_DEV
+#include <linux/poll.h>
+#include <linux/devfs_fs_kernel.h>
+#endif
 
 /* sysctl: */
 int msg_ctlmax = MSGMAX;
@@ -79,6 +85,9 @@
        struct list_head q_messages;
        struct list_head q_receivers;
        struct list_head q_senders;
+#ifdef CONFIG_IPC_DEV
+       wait_queue_head_t ipc_dev_wait; /* For the poll methode */
+#endif
 };
 
 #define SEARCH_ANY             1
@@ -112,11 +121,51 @@
 #ifdef CONFIG_PROC_FS
        create_proc_read_entry("sysvipc/msg", 0, 0,
sysvipc_msg_read_proc, NULL);
 #endif
+#ifdef CONFIG_IPC_DEV
+       devfs_mk_dir(NULL, "ipc", NULL);
+#endif
+}
+
+#ifdef CONFIG_IPC_DEV
+static unsigned int ipc_dev_poll(struct file *file, poll_table *wait)
+{
+       int msqid=(int)file->private_data;
+       struct msg_queue *msq;
+       unsigned int ret = 0;
+
+       msq = msg_lock(msqid);
+       if(msq==NULL)
+               return -EINVAL;
+       ret = -EIDRM;
+       if (msg_checkid(msq,msqid))
+               goto out_unlock;
+       ret = -EACCES;
+       if (ipcperms (&msq->q_perm, S_IRUGO))
+               goto out_unlock;
+        
+       poll_wait(file, &msq->ipc_dev_wait, wait);
+
+       ret = 0;
+       if(msq->q_qnum)
+               ret = POLLIN | POLLRDNORM;
+
+out_unlock:
+       msg_unlock(msqid);
+       return ret;
 }
 
+static struct file_operations ipc_dev_fops = {
+       poll:    ipc_dev_poll,
+};
+#endif
+
 static int newque (key_t key, int msgflg)
 {
        int id;
+#ifdef CONFIG_IPC_DEV
+       int msgid;
+       char name[32];
+#endif
        struct msg_queue *msq;
 
        msq  = (struct msg_queue *) kmalloc (sizeof (*msq), GFP_KERNEL);
@@ -138,9 +187,21 @@
        INIT_LIST_HEAD(&msq->q_messages);
        INIT_LIST_HEAD(&msq->q_receivers);
        INIT_LIST_HEAD(&msq->q_senders);
+#ifdef CONFIG_IPC_DEV
+       init_waitqueue_head(&msq->ipc_dev_wait);
+#endif
        msg_unlock(id);
 
+#ifdef CONFIG_IPC_DEV
+       msgid = msg_buildid(id,msq->q_perm.seq);
+       sprintf(name, "ipc/%d", msgid);
+       devfs_register(NULL, name,
+                       DEVFS_FL_DEFAULT, 0, 0, S_IFREG | S_IRUSR,
+                       &ipc_dev_fops, (void*)msgid);
+       return msgid;
+#else
        return msg_buildid(id,msq->q_perm.seq);
+#endif
 }
 
 static void free_msg(struct msg_msg* msg)
@@ -686,6 +747,9 @@
        msq->q_lspid = current->pid;
        msq->q_stime = CURRENT_TIME;
 
+#ifdef CONFIG_IPC_DEV
+       wake_up_interruptible_sync(&msq->ipc_dev_wait);
+#endif
        if(!pipelined_send(msq,msg)) {
                /* noone is waiting for this message, enqueue it */
                list_add_tail(&msg->m_list,&msq->q_messages);

=== send.c ===========================================================

#include <assert.h>
#include <stdio.h>
#include <string.h>
#include <sys/msg.h>

#define KEY 1235
#define MSGSZ 200

typedef struct msgbuftoto {
  long mtype;
  char mtext[MSGSZ];
} msgtoto;

int main(int argc, char *argv[])
{
  int ret;
  int msqid;
  msgtoto toto;

  assert((msqid=msgget(KEY, 0664|IPC_CREAT))!=-1);
  printf("msqid=%d\n", msqid);
  toto.mtype=1;
  strncpy(toto.mtext, argv[1], MSGSZ);
  assert((ret=msgsnd(msqid, (struct msgbuf*)&toto, MSGSZ, 0))!=-1);

  return 0;
}

=== poll_receive.c =====================================================

#include <assert.h>
#include <fcntl.h>
#include <stdio.h>
#include <sys/msg.h>
#include <sys/poll.h>
#include <sys/types.h>
#include <sys/stat.h>

#define KEY 1235
#define MSGSZ 200

typedef struct msgbuftoto {
  long mtype;
  char mtext[MSGSZ];
} msgtoto;

int main(int argc, char *argv[])
{
  int ret;
  int msqid;
  char name[32];
  struct pollfd pfd;
  msgtoto toto;

  assert((msqid=msgget(KEY, 0664|IPC_CREAT))!=-1);
  sprintf(name, "/dev/ipc/%d", msqid);
  assert((pfd.fd=open(name, O_RDONLY))!=-1);
  pfd.events=POLLIN;
  printf("poll start...\n");
  assert(poll(&pfd, 1, -1)!=-1);
  printf("poll done!\n");
  assert((ret=msgrcv(msqid, (struct msgbuf*)&toto, MSGSZ, 0, 0))!=-1);
  assert(close(pfd.fd)!=-1);
  printf("%s\n", toto.mtext);

  return 0;
}

===================================================================
--
Jean-Christian de Rivaz 
mailto:jc@lightning.ch
