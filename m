Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S271910AbRIMRJC>; Thu, 13 Sep 2001 13:09:02 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S271900AbRIMRIx>; Thu, 13 Sep 2001 13:08:53 -0400
Received: from e31.co.us.ibm.com ([32.97.110.129]:19388 "EHLO
	e31.bld.us.ibm.com") by vger.kernel.org with ESMTP
	id <S271906AbRIMRIo>; Thu, 13 Sep 2001 13:08:44 -0400
Message-ID: <3BA111FC.E5D4E9AD@us.ibm.com>
Date: Thu, 13 Sep 2001 10:07:24 -1000
From: Mingming cao <cmm@us.ibm.com>
Organization: Linux Technology Center
X-Mailer: Mozilla 4.76 [en] (X11; U; Linux 2.4.2-2 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: torvalds@transmeta.com, alan@lxorguk.ukuu.org.uk
CC: linux-kernel@vger.kernel.org, manfreds@colorfullife.com
Subject: [PATCH]Fix bug in msgrcv/shmat
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello, Linux & Alan,

This patch verifies the message queue ID and the shared memory segment
ID for msgrcv and shmat respectively. These IDs consist of a data
structure index value, and a generation number. As data structures are
re-used, the generation number makes it possible to avoid incorrect
data references. The generation numbers are checked via msg_checkid()
and shm_checkid(). The problem is that msgrcv and shmat do not currently
validate the ID. As a result of this, it is possible to reference and
modify the wrong message queue or shared memory segment with the use of
a stale ID.

This patch is against kernel 2.4.9.  I tested it and it runs well.
Please apply and CC your comments to me also, thanks.

-- 
Mingming Cao
IBM Linux Technology Center

diff -urN -X dontdiff linux/ipc/msg.c linux-tk/ipc/msg.c
--- linux/ipc/msg.c     Wed Aug 29 18:26:39 2001
+++ linux-tk/ipc/msg.c  Wed Aug 29 18:21:42 2001
@@ -742,6 +742,10 @@
        if(msq==NULL)
                return -EINVAL;
 retry:
+       err = -EIDRM;
+       if (msg_checkid(msq,msqid))
+               goto out_unlock;
+
        err=-EACCES;
        if (ipcperms (&msq->q_perm, S_IRUGO))
                goto out_unlock;
diff -urN -X dontdiff linux/ipc/shm.c linux-tk/ipc/shm.c
--- linux/ipc/shm.c     Wed Aug 29 18:26:33 2001
+++ linux-tk/ipc/shm.c  Wed Aug 29 18:26:15 2001
@@ -606,6 +606,11 @@
        shp = shm_lock(shmid);
        if(shp == NULL)
                return -EINVAL;
+       err = shm_checkid(shp,shmid);
+       if (err) {
+               shm_unlock(shmid);
+               return err;
+       }
        if (ipcperms(&shp->shm_perm, acc_mode)) {
                shm_unlock(shmid);
                return -EACCES;
