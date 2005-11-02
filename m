Return-Path: <linux-kernel-owner+willy=40w.ods.org-S965207AbVKBUGY@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965207AbVKBUGY (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 2 Nov 2005 15:06:24 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965211AbVKBUGY
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 2 Nov 2005 15:06:24 -0500
Received: from mailgw2.fnal.gov ([131.225.111.12]:4561 "EHLO mailgw2.fnal.gov")
	by vger.kernel.org with ESMTP id S965207AbVKBUGX (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 2 Nov 2005 15:06:23 -0500
Date: Wed, 02 Nov 2005 14:06:22 -0600 (CST)
From: Steven Timm <timm@fnal.gov>
Subject: rpc-srv/tcp: nfsd: sent only -107 bytes (fwd)
To: linux-kernel@vger.kernel.org
Message-id: <Pine.LNX.4.62.0511021405430.20925@snowball.fnal.gov>
MIME-version: 1.0
Content-type: TEXT/PLAIN; charset=US-ASCII; format=flowed
Content-transfer-encoding: 7BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



I am seeing repeated errors of rpc-srv/tcp: nfsd: sent only -107 bytes
in the /var/log/messages of my machine.  Full configuration
info is below.  Only suggestion I have seen thus far
increase the number of nfsd that are running.  we have done
this, raising from 8 to 64, the problem persists.  Are there
any other suggestions that could help this problem?

Thanks

Steve Timm

--------------------------------------------------------------------
Node "fnpcsrv1" is new NFS server,
root@fnpcsrv1 lsi_home]# uname -a
Linux fnpcsrv1.fnal.gov 2.4.21-32.0.1.EL.XFSsmp #1 SMP Wed Jun 8 18:35:19 CEST 
2005 i686 i686 i386 GNU/Linux
this is 4-way Dell Poweredge 6850, 16 GB RAM, running in 32-bit mode,
hyperthreading on.
All NFS-exported file systems are XFS file systems and have quotas.
Currently running 64 NFS daemons.
Disk hardware includes Dell Megaraid controller and LSI e2400 RAID controller.

Kernel 2.4.21-32.0.1.EL.XFSsmp is the kernel recompiled from same
.src.rpm as Red Hat Enterprise Linux 3 update 5, with XFS patches applied.

Two NFS clients running 2.4.21-37.ELsmp, namely fnpcg, fngp-osg.
These are grid nodes, heavy consumers of NFS.

150-some worker node NFS clients  running 2.4.21-27.0.2.ELsmp kernel.
(From Red Hat Enterprise Linux 3 update 4).
All linux-to-linux NFS access is version 3 over TCP.


Problem #1: "Failed to mount xxxxxxx"
Seen in /var/log/messages of normal worker nodes and grid nodes.
All home and staging areas are mounted on worker nodes via the
automounter.  We see on average 10-12 failures a day over a sample
of 150 worker nodes.  Each failure can cause a job to fail.
No corresponding error message on the server when this happens.
These happen more when server is at high load.

Problem #2:
Sep 13 04:40:24 fngp-osg kernel: RPC:      tcp_data_ready socket info not 
found!
Sep 13 04:40:26 fngp-osg kernel: nfs_safe_remove: 
335e33085de705df938049bc260619
/lock busy, d_count=2
These 2 messages are seen only on the client nodes that are running
2.4.21-32.0.1 kernel.  Sometimes they occur together, more usually
the nfs_safe_remove occurs alone.

If we investigate the file "lock" that is trying to be removed we find the 
following:

ls of the directory it is in, on the client, does not show the file.
"ls lock" does show the file
"rm lock" claims the file does not exist.
A portion of the strace of the process in question.

link("/home/cdf/.globus/.gass_cache/global/md5/76/f3/51/365016f6aebcebeb671288a2ff/data", 
"/home/cdf/.globus/.gass_cache/global/md5/76/f3/51/365016f6aebcebeb671288a2ff/lock") 
= -1 EEXIST (File exists)
stat64("/home/cdf/.globus/.gass_cache/global/md5/76/f3/51/365016f6aebcebeb671288a2ff/lock", 
{st_mode=S_IFREG|0755, st_size=458, ...}) = 0
time(NULL)                              = 1130864802
unlink("/home/cdf/.globus/.gass_cache/global/md5/76/f3/51/365016f6aebcebeb671288a2ff/lock") 
= -1 ENOENT (No such file or directory)


On the server the file does not show up at all.

A umount and remount of the system on the client clears the problem
but that's not an operation that can always be done.  The undeletable
file causes a large number of client processes to get very confused
and get caught in a tight loop of  statting, unlinking, and linking the
same file over and over again.  Only recourse is to kill the processes
in question.

2a) we see some stale NFS file handles on these systems as well, also causing 
hung processes.

3)  /var/log/messages on the server node.
Sep 20 05:03:31 fnpcsrv1 kernel: rpc-srv/tcp: nfsd: sent only -107 bytes of 
132- shutting down socket
Sep 20 05:03:32 fnpcsrv1 kernel: rpc-srv/tcp: nfsd: sent only -107 bytes of 
140- shutting down socket


We believe these are associated with the two nodes running
the 2.4.21-37 kernel because when we shut them down, these errors stop.
NFS mailing list archives suggested to increase the number of NFSD,
we have increased to 64, these errors continue.  NFS mailing list
says root cause is that the nfsd tries to do a sendto and gets a
ENOTCONN error from the client.

------------------------------------------------------------------
Things we have done so far:

a) Increased TCP buffering on the server and the two busiest clients with the 
following tunes:


# increase Linux TCP buffer limits
net.core.rmem_max = 8388608
net.core.wmem_max = 8388608

# increase Linux autotuning TCP buffer limits
net.ipv4.tcp_rmem = 32768 87380 8388608
net.ipv4.tcp_wmem = 16384 65536 8388608
net.ipv4.tcp_mem = 8388608 8388608 8388608

b) Upgraded the two most busy clients to kernel 2.4.21-37.

To date:


1) The "Failed to mount" errors have continued when the nfs server is at high 
load.

2) There have been no repeats of the tcp_data_ready sequence
There have been some instances of the nfs_safe_remove error, but only one such 
error for any one given file, and it seems like the file does eventually get 
removed on the retry.
Some processes still hang, as described above.

2a) No stale nfs file handles as yet, but we keep looking.

3) rpc-srv/tcp messages continue at previous rate.

---------------------------------------------------------------

Contents of /etc/exports



[root@fnpcsrv1 nfs]# cat /etc/exports
/export/lsi_home 
131.225.167.0/255.255.254.0(rw,insecure,insecure_locks,no_subtree_check,sync)
/export/lsi_stage 
131.225.167.0/255.255.254.0(rw,insecure,insecure_locks,no_subtree_check,sync)
/export/products 
131.225.167.0/255.255.254.0(rw,insecure,insecure_locks,no_subtree_check,sync)
/export/stage 
131.225.167.0/255.255.254.0(rw,insecure,insecure_locks,no_subtree_check,sync

Sample entry from /var/lib/nfs/xtab

/export/lsi_stage 
fnpc131.fnal.gov(rw,sync,wdelay,hide,nocrossmnt,insecure,root_squash,no_all_squash,no_subtree_check,insecure_locks,acl,mapping=identity,anonuid=-2,anongid=-2)

Mount options on client:

/home           /etc/auto.home 
-rw,bg,hard,tcp,timeo=15,retrans=8,intr,rsize=8192,wsize=8192 0 0

-------------------------------------------------------------------
All default nfs and nfsd proc entries.


[root@fnpcsrv1 nfs]# cat nfs3_acl_max_entries
1024
[root@fnpcsrv1 nfs]# cat nlm_grace_period
0
[root@fnpcsrv1 nfs]# cat nlm_tcpport
0
[root@fnpcsrv1 nfs]# cat nlm_timeout
10
[root@fnpcsrv1 nfs]# cat nlm_udpport
0
[root@fnpcsrv1 nfs]# pwd
/proc/sys/fs/nfs
[root@fnpcsrv1 nfs]#  [root@fnpcsrv1 nfsd]# cat nfsd3_acl_max_entries
1024
[root@fnpcsrv1 nfsd]# pwd
/proc/sys/fs/nfsd
[root@fnpcsrv1 nfsd]#

-----------------------------
Things we are in the process of doing, that can be done live without reboot.

1) Change /etc/sysctl.conf again Add:
net.core.wmem_default = 524288
net.core.rmem_default = 524288
net.ipv4.tcp_window_scaling = 1
can do this live by changing /etc/sysctl.conf
sysctl -p

2) Load 2.4.21-37.EL.XFS kernel, ready for reboot if it comes before downtime. 
First on test fnpt124, then ready on fnpcsrv1.

3) Change mount options on a few clients, fngp-osg and fnpcg first,
    then a few workers.
    Hold a couple nodes to try auto.master changes.

Question--what mount options to change to on clients
    Suggestion was remove bg, add noac add grpid, add rsize=32768, wsize=32768 
4) change /etc/exports to async from sync?


Things we'll do at next reboot.

1) add command tag queueing to qla2300 driver on fnpcsrv1
     options qla2300 ql2xmaxqdepth 256
2) add nfs/nfsd options to modules.conf
  a) to all NFS clients, add
 	options nfs nfs3_acl_max_entries=256
  b) to NFS servers also add
 	options nfsd nfsd3_acl_max_entries=256
3) reboot server into new kernel

5) add same sysctl.conf options to NFS clients
6) add good client mount options to NFS clients.




-- 
------------------------------------------------------------------
Steven C. Timm, Ph.D  (630) 840-8525  timm@fnal.gov 
http://home.fnal.gov/~timm/
Fermilab Computing Div/Core Support Services Dept./Scientific Computing Section
Assistant Group Leader, Farms and Clustered Systems Group
Lead of Computing Farms Team
