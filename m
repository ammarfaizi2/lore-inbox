Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264944AbTLFDqx (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 5 Dec 2003 22:46:53 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264945AbTLFDqx
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 5 Dec 2003 22:46:53 -0500
Received: from ns3.mountaincable.net ([24.215.0.13]:27544 "EHLO
	ns3.mountaincable.net") by vger.kernel.org with ESMTP
	id S264944AbTLFDqw (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 5 Dec 2003 22:46:52 -0500
Subject: shmem_file_setup creating SYSV00000000 files in (ext3) root
	filesystem
From: desrt <desrt@desrt.ca>
To: linux-kernel@vger.kernel.org
Content-Type: text/plain
Message-Id: <1070682344.17941.6.camel@peloton.desrt.ca>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.5 
Date: Fri, 05 Dec 2003 22:45:44 -0500
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

kernel version is 2.4.23.

the problem is caused by the fact that the checks that shmem_file_setup
does to determine the location of the mountpoint of tmpfs fail to take
into account the effect of pivot_root.

that is: if i mount a tmpfs as /, then mount a ext3 filesystem and
pivot_root into it with put_old as, say, /var/tmp, then shmem_file_setup
will still think that the tmpfs is mounted at / (and as a result creates
shared memory files on the root filesystem instead of on /var/tmp as it
ought to)

i'm not actually sure what the code in mm/shmem.c:shmem_file_setup()
does, but i assume the problem is this line:
	        root = shm_mnt->mnt_root;

and somehow as a result, this happens:
peloton:/proc# grep deleted */maps
17923/maps:4201a000-4207a000 rw-s 00000000 00:04 21233690  
/SYSV00000000 (deleted)
17923/maps:424dd000-4253d000 rw-s 00000000 00:04 21266460  
/SYSV00000000 (deleted)
17926/maps:4201a000-4207a000 rw-s 00000000 00:04 21233690  
/SYSV00000000 (deleted)
17926/maps:424dd000-4253d000 rw-s 00000000 00:04 21266460  
/SYSV00000000 (deleted)
17927/maps:4201a000-4207a000 rw-s 00000000 00:04 21233690  
/SYSV00000000 (deleted)
[many many many lines follow]

if you have any advice or can confirm to me that this is actually a bug
in the kernel, please reply.  i'm not on the list.

thanks,
ryan.

