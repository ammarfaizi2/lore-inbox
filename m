Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263723AbTKRRKE (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 18 Nov 2003 12:10:04 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263733AbTKRRKE
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 18 Nov 2003 12:10:04 -0500
Received: from e4.ny.us.ibm.com ([32.97.182.104]:2726 "EHLO e4.ny.us.ibm.com")
	by vger.kernel.org with ESMTP id S263723AbTKRRJx (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 18 Nov 2003 12:09:53 -0500
Date: Tue, 18 Nov 2003 09:35:04 -0800
From: "Martin J. Bligh" <mbligh@aracnet.com>
To: linux-kernel <linux-kernel@vger.kernel.org>
cc: nathanl@austin.ibm.com
Subject: [Bug 1552] New: oops in proc_kill_inodes when file rapidly added and removed
Message-ID: <148140000.1069176904@flay>
X-Mailer: Mulberry/2.1.2 (Linux/x86)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

http://bugme.osdl.org/show_bug.cgi?id=1552

           Summary: oops in proc_kill_inodes when file rapidly added and
                    removed
    Kernel Version: 2.6.0-test9
            Status: NEW
          Severity: high
             Owner: bugme-janitors@lists.osdl.org
         Submitter: nathanl@austin.ibm.com
                CC: engebret@us.ibm.com


Rapidly adding and removing a file in /proc can result in an oops in
proc_kill_inodes, because the dentry in the following loop is sometimes NULL:

	list_for_each(p, &sb->s_files) {
		struct file * filp = list_entry(p, struct file, f_list);
		struct dentry * dentry = filp->f_dentry;
		struct inode * inode;
		struct file_operations *fops;

		if (dentry->d_op != &proc_dentry_operations)
			continue;
		inode = dentry->d_inode;
		if (PDE(inode) != de)
			continue;
		fops = filp->f_op;
		filp->f_op = NULL;
		fops_put(fops);
	}

I have a simple testcase module which I will attach that can be used to
reproduce the problem.  The module creates a /proc/stress directory and a
/proc/stress/ctl writable file.  When "add" is written to /proc/stress/ctl,
another file, /proc/stress/data, is created.  When "remove" is written to
/proc/stress/ctl, /proc/stress/data is removed.

The procedure for producing the oops:
1. Load the procstress.ko module.
2. Execute a loop in a shell:
   while true ; do
   echo add > /proc/stress/ctl
   echo remove > /proc/stress/ctl
   done
3. In another shell, execute another loop:
   while true ; do
   cat /proc/cpuinfo &>/dev/null
   done

Eventually, an oops similar to the following should occur (taken from a ppc64
system):
Oops: Kernel access of bad area, sig: 11 [#1]
NIP: C0000000000E6050 XER: 0000000000000000 LR: C0000000000E667C
REGS: c0000000fe807880 TRAP: 0300    Not tainted
MSR: 8000000000009032 EE: 1 PR: 0 FP: 0 ME: 1 IR/DR: 11
DAR: 0000000000000068, DSISR: 0000000040000000
TASK = c0000000fef2d840[680] 'bash'  CPU: 1
GPR00: C0000000004E7900 C0000000FE807B00 C00000000061F000 C0000000FEF0B180 
GPR04: C0000000FEF0B20B 0000000000000004 D00000000026149B 0000000000000000 
GPR08: 0000000000000000 C0000000FECFACA0 C0000000FE6C6280 0000000000000000 
GPR12: D000000000261338 C000000000550000 0000000000000000 0000000000000000 
GPR16: 0000000000000000 0000000000000000 0000000000000000 0000000000000000 
GPR20: 0000000000000001 C000000000550EC0 B000000000009032 C0000000FE807EA0 
GPR24: 0000000000000000 0000000000000001 0000000000000000 0000000040015000 
GPR28: C0000000FEF0B180 C0000000FFFC24F8 C00000000051A098 C0000000FE9E5C80 
NIP [c0000000000e6050] .proc_kill_inodes+0xb0/0x1b0
Call Trace:
[c0000000000e667c] .remove_proc_entry+0x11c/0x180
[d000000000261200] .write_procstress_ctl+0xdc/0x148 [procstress]
[c00000000009fdb0] .vfs_write+0x10c/0x170
[c00000000009ff04] .sys_write+0x50/0xa0
[c0000000000117bc] .ret_from_syscall_1+0x0/0xa4

I have verified that the problem occurs on i386, too.

I realize that this is not a "real world" test of procfs, but there is some
ppc64 work in progress that can be made to exercise the system in the same way,
with the same results.  I wrote the procstress module in order to isolate the
problem.

