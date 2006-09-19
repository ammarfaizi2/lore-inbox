Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751931AbWISSKF@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751931AbWISSKF (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 19 Sep 2006 14:10:05 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751932AbWISSKF
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 19 Sep 2006 14:10:05 -0400
Received: from bulimba.hst.terra.com.br ([200.176.10.194]:13507 "EHLO
	bulimba.hst.terra.com.br") by vger.kernel.org with ESMTP
	id S1751931AbWISSKD (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 19 Sep 2006 14:10:03 -0400
X-Terra-Karma: -2%
X-Terra-Hash: c2abc9e775f55c66fc73a40ddbf3f688
Subject: Processes stuck in D trying to acquire lock at vfs_rename_dir
From: =?ISO-8859-1?Q?Rud=E1?= Moura <ruda.moura@terra.com.br>
To: linux-kernel <linux-kernel@vger.kernel.org>
Cc: Alexander Viro <viro@parcelfarce.linux.theplanet.co.uk>
Content-Type: text/plain; charset=ISO-8859-1
Organization: Terra Networks
Date: Tue, 19 Sep 2006 15:09:59 -0300
Message-Id: <1158689399.32184.17.camel@localhost>
Mime-Version: 1.0
X-Mailer: Evolution 2.6.1 
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

We are huge mail provider with a pool of many mx, pop and imap machines
and we are facing a rather strange situation when we recently
upgraded one of our applications, and after a week running, several
processes hang in "D" (disk wait) state forever. That way, we cannot
strace, gdb, pstack them to know what they were doing or where they
were.

On the top of those machines are running RHEL version 4 with
kernel 2.6.9-42.ELsmp. Some are running (stock) kernel 2.6.17.11 
with KDB patch applied. The hardware is described as follow:

- Dell PowerEdge 6850, QUAD 3,2GHZ HT , 8GB RAM,
- 5 SCSI disks 146 GB 15k RPM.

We use NFS to keep mailboxes in maildir format. They are shared to many
machines and are provided by a NFS server storage.

In order to gain more understanding of the problem
we decide to enable mutex/futex debug (CONFIG_DEBUG_MUTEXES=y),
because the bug is hard to reproduce and happens in an occasional manner
 for a week or more.
 
The process locked was "ttrlmtp_tcp", they stuck in D while are trying
to rename() as the log message states:

lmtplog.6.gz:Sep 18 19:00:02 mangoro trrlmtpd_tcp[12499]:
1158616802.840213: TrrMailMdirMoveMBToIdPermMB: trying to rename
[/nfs/mail3d03/m/a/r/i/a/4/8/2/6/maria4826/Maildir] to
[/nfs/mail3d03/m/a/r/i/a/4/8/2/6/18538100#perm!terra.maria4826] ...

and this is what Mutex/Futex Debug gave to us:

Sep 18 19:00:02 mangoro kernel:
==========================================
Sep 18 19:00:02 mangoro kernel: [ BUG: lock recursion deadlock detected!
|
Sep 18 19:00:02 mangoro kernel:
------------------------------------------
Sep 18 19:00:15 mangoro kernel: 
Sep 18 19:00:15 mangoro kernel: trrlmtpd_tcp/12499 is trying to acquire
this lock:
Sep 18 19:00:15 mangoro kernel:  [ed260830] {inode_init_once}
Sep 18 19:00:15 mangoro kernel: .. held by:      trrlmtpd_tcp:12499
[d94cc560, 115]
Sep 18 19:00:15 mangoro kernel: ... acquired at:
lock_rename+0x36/0x94
Sep 18 19:00:15 mangoro kernel: ... trying at:
vfs_rename_dir+0x84/0x100
Sep 18 19:00:15 mangoro kernel: ------------------------------
Sep 18 19:00:15 mangoro kernel: | showing all locks held by: |
(trrlmtpd_tcp/12499 [d94cc560, 115]):
Sep 18 19:00:15 mangoro kernel: ------------------------------
Sep 18 19:00:15 mangoro kernel: 
Sep 18 19:00:15 mangoro kernel: #001:             [f6e839f4]
{alloc_super}
Sep 18 19:00:15 mangoro kernel: ... acquired at:
lock_rename+0x4f/0x94
Sep 18 19:00:15 mangoro kernel: 
Sep 18 19:00:15 mangoro kernel: #002:             [ed260b50]
{inode_init_once}
Sep 18 19:00:15 mangoro kernel: ... acquired at:
lock_rename+0x2b/0x94
Sep 18 19:00:15 mangoro kernel: 
Sep 18 19:00:15 mangoro kernel: #003:             [ed260830]
{inode_init_once}
Sep 18 19:00:15 mangoro kernel: ... acquired at:
lock_rename+0x36/0x94
Sep 18 19:00:15 mangoro kernel: 
Sep 18 19:00:15 mangoro kernel: 
Sep 18 19:00:15 mangoro kernel: trrlmtpd_tcp/12499's [current]
stackdump:
Sep 18 19:00:15 mangoro kernel: 
Sep 18 19:00:15 mangoro kernel:  <c0104205> show_trace+0xd/0xf
<c01042ce> dump_stack+0x15/0x17
Sep 18 19:00:15 mangoro kernel:  <c0131205> report_deadlock+0xea/0x102
<c0131364> check_deadlock+0x147/0x151
Sep 18 19:00:15 mangoro kernel:  <c0131908> debug_mutex_add_waiter
+0x80/0x93  <c02fcf02> __mutex_lock_slowpath+0x117/0x37a
Sep 18 19:00:15 mangoro kernel:  <c02fcddb> mutex_lock+0x24/0x27
<c0168888> vfs_rename_dir+0x84/0x100
Sep 18 19:00:15 mangoro kernel:  <c0168b2a> vfs_rename+0x135/0x273
<c0168d9f> do_rename+0x137/0x176
Sep 18 19:00:15 mangoro kernel:  <c0168e17> sys_renameat+0x39/0x54
<c0168e44> sys_rename+0x12/0x14
Sep 18 19:00:15 mangoro kernel:  <c01032ef> sysenter_past_esp+0x54/0x75 


Unfortunately we couldn't use KDB to debug this process because we had
to reboot the machine.
We are waiting for another process lock.

Any help in the subject will be very appreciate and we are ready to
provide more information about this problem if required.

Thanks in Advance.

-- 
Rudá Moura <ruda.moura@terra.com.br>

