Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262344AbTKYLD3 (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 25 Nov 2003 06:03:29 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262356AbTKYLD3
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 25 Nov 2003 06:03:29 -0500
Received: from vcgwp1.bit-drive.ne.jp ([211.9.32.211]:12715 "HELO
	vcgwp1.bit-drive.ne.jp") by vger.kernel.org with SMTP
	id S262344AbTKYLD0 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 25 Nov 2003 06:03:26 -0500
From: Akinobu Mita <mita@miraclelinux.com>
To: linux-kernel@vger.kernel.org
Subject: [BUG 2.4] NFS unlocking operation accesses invalid file struct 
Date: Tue, 25 Nov 2003 20:00:32 +0900
User-Agent: KMail/1.5
MIME-Version: 1.0
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200311252000.32094.mita@miraclelinux.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

I'm investigating the reliabiblity of the NFS locking.
I noticed that possible NFS locking related crash in the following situation:

process A
process B
  -- A and B are sharing task's fd array.
     (clone()d with CLONE_FILES)

file F
  -- The file on NFS

file descriptor p (equivalent to file struct P)
file descriptor q (equivalent to file struct Q)

  -- p and q are individual file descriptors for the file F
     (not dup()-ed)

file lock L

  -- The file lock L has been locked via fcntl() for the file descriptor q by
     the process B (connects with file struct Q)


1. The process A closes the file descriptor p.

In filp_close(), the process A closes file struct P, it unlocks all the
file locks related to the i-node of the file F, which are held by the
processes sharing the same fd array process A refers to. (locks_remove_posix)

2. The process A unlocks the file lock L.

First of all, the process A removes the file lock L from the list of the
file locks related to the i-node of the file F. Then, it calls the `nfs_lock'
to do the unlocking operation for its file-system dependent operation.

3. While executing the `nfs_lock' with RPC procedure, the process A
  sleep on there for a while.

On the other side.
4. The process B closes the file descriptor q.

Because process A has already remove the entry of the file lock from the list,
process B cannot find the entry so it just exit without doing anything about
the list.
System treats the closing operation carried out by the process B is done,
while the process A is sleeping.
The process B invalidates the file struct Q because it is no longer needed.

But, the process A has not finished the operation of the unlocking 
for file lock L yet.

5. When the process A wakes up, it attempts to execute remaining unlocking
   works, and accesses the file struct Q.

Because the file struct Q is no longer valid, it is likely to cause NULL
pointer dereference.
Also, the file struct Q might be used by other files. in this case, the data
contradiction would happen.

Does anyone have a idea of how to fix it ?

Regards,
-- 
Akinobu Mita

