Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261344AbTJVXg2 (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 22 Oct 2003 19:36:28 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261345AbTJVXg2
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 22 Oct 2003 19:36:28 -0400
Received: from e6.ny.us.ibm.com ([32.97.182.106]:33989 "EHLO e6.ny.us.ibm.com")
	by vger.kernel.org with ESMTP id S261344AbTJVXgU (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 22 Oct 2003 19:36:20 -0400
Date: Wed, 22 Oct 2003 16:36:24 -0700
From: "Martin J. Bligh" <mbligh@aracnet.com>
To: linux-kernel <linux-kernel@vger.kernel.org>
cc: bwindle-kbt@fint.org
Subject: [Bug 1405] New: Memory leak in VFS?
Message-ID: <12650000.1066865784@flay>
X-Mailer: Mulberry/2.1.2 (Linux/x86)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

http://bugme.osdl.org/show_bug.cgi?id=1405

           Summary: Memory leak in VFS?
    Kernel Version: 2.6.0-test8-bk1
            Status: NEW
          Severity: normal
             Owner: akpm@digeo.com
         Submitter: bwindle-kbt@fint.org


Distribution: Debian Testing
Hardware Environment: SMP, Preempt, i386, SCSI
Software Environment: 
Linux dual266 2.6.0-test8-bk1 #6 SMP Tue Oct 21 11:34:44 EDT 2003 i686 GNU/Linux

Gnu C                  3.3.2
Gnu make               3.80
util-linux             2.12
mount                  2.12
module-init-tools      implemented
e2fsprogs              1.35-WIP
nfs-utils              1.0.5
Linux C Library        2.3.2
Dynamic linker (ldd)   2.3.2
Procps                 3.1.12
Net-tools              1.60
Console-tools          0.2.3
Sh-utils               5.0

Problem Description:
There appears to be a memory leak in the VFS code.  Nikita Danilov
<Nikita@Namesys.COM> posted to the LKML, and I am able to reproduce the
situation. Running fsstress (file system stress tools from XFS ported by Andi
Kleen <ak@suse.de>) on an ext3 filesystem as 

./fsstress -d . -f sync=0 -n 1000000000 -p 111 -v

The kernel begins to use lots of memory in ext3_inode_cache and dentry_cache.
Nikita was able to do this on ext2, and reiser, and I can reproduce it on ext3.
The memory will not release under VM pressure, but does appear to release some
of it if you erase the files created by the fsstress tool. With basically
nothing running, /proc/meminfo is reporting over 50megs Active. The kernel will
not release this memory, despite userspace trying to alloc memory (the alloc'ing
process will instead be killed).  The filesystem is mounted with the default
options (ordered data mode)

There was a change to fs/dcache.c in 2.6.0-test6 that may be responsible.

Steps to reproduce:
run ./fsstress -d . -f sync=0 -n 1000000000 -p 111 -v for a while (an hour or so).

