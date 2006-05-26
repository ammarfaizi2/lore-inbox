Return-Path: <linux-kernel-owner+willy=40w.ods.org-S965215AbWEZAni@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965215AbWEZAni (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 25 May 2006 20:43:38 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965222AbWEZAni
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 25 May 2006 20:43:38 -0400
Received: from [203.144.27.9] ([203.144.27.9]:9734 "EHLO surfers.oz.agile.tv")
	by vger.kernel.org with ESMTP id S965215AbWEZAnh (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 25 May 2006 20:43:37 -0400
Message-ID: <44764F35.9050002@agile.tv>
Date: Fri, 26 May 2006 10:43:33 +1000
From: Tony Griffiths <tonyg@agile.tv>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.7.12) Gecko/20060202 Fedora/1.7.12-1.5.2
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org
Subject: PROBLEM: /proc (procfs) task exit race condition causes a kernel
 crash
Content-Type: multipart/mixed;
 boundary="------------030308050702010900090809"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is a multi-part message in MIME format.
--------------030308050702010900090809
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit

Summary:

A condition exists that crashes the kernel when one or more tasks are 
exiting while at the same time another task is reading their /proc 
entries.  The crash is caused by either a bad VA (NULL, LIST_POISON1, or 
LIST_POISON2) in prune_dcache() or a BUG_ON() sanity check in 
include/linux/list.h!

Detailed Description:

If there is a great deal of modification activity in /proc caused by 
task creation [fork()] and task exiting, and at the same time other 
task(s) are reading /proc/<pid>/... files, the dentry_unused list 
becomes corrupted and the kernel crashes, usually in function 
prune_dcache() in module fs/dcache.c!  A simple program that forks 
itself run in a continuous loop combined with a 'find /proc ... cat {} 
\;' to read the /proc task entries is all that is needed to induce the 
condition.  A couple of sample crash outputs look like-

(a)  BUG_ON() --
 ------------[ cut here ]------------
kernel BUG at include/linux/list.h:167!
invalid opcode: 0000 [#1]
SMP
last sysfs file: /class/vc/vcs1/dev
Modules linked in: parport_pc lp parport autofs4 i2c_dev i2c_core 
microcode binfmt_misc video thermal sony_acpi processor fan button 
battery ac ehci_hcd usbcore ide_cd cdrom sg ext3 jbd dm_mod mptspi 
scsi_transport_spi mptscsih mptbase sd_mod scsi_mod
CPU:    1
EIP:    0060:[<c017ec60>]    Not tainted VLI
EFLAGS: 00010203   (2.6.16-mm2 #1)
EIP is at prune_dcache+0x3c6/0x3d3
eax: 00000010   ebx: f7326b08   ecx: f7326b10   edx: c017e280
esi: f7326ae0   edi: f7e81e5c   ebp: 00000001   esp: f7e81e4c
ds: 007b   es: 007b   ss: 0068
Process init (pid: 1, threadinfo=f7e80000 task=c352eaa0)
Stack: <0>c0401c00 f7e81e5c f7e81ead c017ef28 f7e81e5c f7e81e5c f7326df8 
f620c000
       f7326df8 f7e81ea8 c017efe6 00000006 f7ec0e00 f620c000 c019c71a 
f7326df8
       f7e81e98 c036a63a 000077a4 089c21d9 00000005 f7e81ea8 c0117643 
32363033
Call Trace:
 <c017ef28> select_parent+0x17/0xbc   <c017efe6> 
shrink_dcache_parent+0x19/0x2c
 <c019c71a> proc_flush_task+0x5f/0x1f5   <c0117643> sched_exit+0xb1/0xc8
 <c0120552> release_task+0x84/0x101   <c01028c3> handle_signal+0x108/0x143
 <c0122094> wait_task_zombie+0x2de/0x3cf   <c0102984> do_signal+0x86/0x11c
 <c012291d> do_wait+0x36f/0x40f   <c0119153> default_wake_function+0x0/0x12
 <c01f08ec> copy_to_user+0x3c/0x50   <c0119153> 
default_wake_function+0x0/0x12
 <c0122a8c> sys_wait4+0x3f/0x43   <c0122ab7> sys_waitpid+0x27/0x2b
 <c0102b5f> syscall_call+0x7/0xb
Code: 31 ff ff ff 0f 0b a7 00 9f 69 35 c0 e9 8c fd ff ff 0f 0b a8 00 9f 
69 35 c0 e9 8b fd ff ff 0f 0b a8 00 9f 69 35 c0 e9 9e fe ff ff <0f> 0b 
a7 00 9f 69 35 c0 e9 85 fe ff ff 55 b8 00 1c 40 c0 57 56

(b)  LIST_POISON1/LIST_POISON2 --
# Unable to handle kernel paging request at virtual address 00100104
 printing eip:
c0179d12
*pde = 3780b001
Oops: 0002 [#1]
SMP
Modules linked in: parport_pc lp parport autofs4 i2c_dev i2c_core 
microcode binfmt_misc video thermal processor fan button battery ac 
ehci_hcd usbcore ide_cd cdrom sg ext3 jbd dm_mod mptspi mptscsih mptbase 
sd_mod scsi_mod
CPU:    7
EIP:    0060:[<c0179d12>]    Not tainted VLI
EFLAGS: 00010202   (2.6.16.18 #1)
EIP is at prune_dcache+0x231/0x327
eax: 00100100   ebx: f553d55c   ecx: f553d564   edx: 00200200
esi: f553d534   edi: f7e81e94   ebp: 00000002   esp: f7e81e84
ds: 007b   es: 007b   ss: 0068
Process init (pid: 1, threadinfo=f7e80000 task=c352ea90)
Stack: <0>c03f2c00 f7e81e94 f65fcac0 c017a03d f7e81e94 f7e81e94 f576a954 
f59c2a90
       f576a954 00000000 c017a0fa 0000000a f7ecf000 f576a954 c0196c8a 
f576a954
       f59c2a90 c01212b2 f576a954 c0102993 f59c2a90 00000000 00003b88 
00000000
Call Trace:
 [<c017a03d>] select_parent+0x17/0xbb
 [<c017a0fa>] shrink_dcache_parent+0x19/0x2c
 [<c0196c8a>] proc_pid_flush+0x14/0x26
 [<c01212b2>] release_task+0xa3/0x12e
 [<c0102993>] handle_signal+0x108/0x143
 [<c0122dac>] wait_task_zombie+0x2de/0x3c9
 [<c0102a5e>] do_signal+0x90/0x127
 [<c01235c9>] do_wait+0x34d/0x3de
 [<c011a913>] default_wake_function+0x0/0x12
 [<c01e9b5e>] copy_to_user+0x3c/0x50
 [<c011a913>] default_wake_function+0x0/0x12
 [<c0123722>] sys_wait4+0x3f/0x43
 [<c012374d>] sys_waitpid+0x27/0x2b
 [<c0102c2d>] syscall_call+0x7/0xb
Code: fe ff ff 8b 4e 50 e9 bd fe ff ff 8d 7c 24 10 89 7c 24 10 89 7c 24 
14 8b 46 04 a8 10 0f 84 a8 00 00 00 8d 4e 30 8b 46 30 8b 51 04 <89> 50 
04 89 02 c7 41 04 00 02 20 00 c7 46 30 00 01 10 00 83 2d
 <0>Kernel panic - not syncing: Attempted to kill init!

All kernels from 2.6.15 -> 2.6.17 with any of the applicable patch-sets 
(-git or -mm) are affected!!!  Also RedHat FC<n> kernels.

Environment:

The environment is any SMP hardware with the kernel build with or 
without PREEMPT enabled.  Any P4 hyperthreaded chip, or Xeon 
multi-processor system [DELL 1425 & 1850 dual-Xeon and also dual-core 
dual-Xeon in my case] will exhibit the crash.

The attached forkalot.c program combined with the simple shell scripts 
do the job.  Running the forkalot shell script while at the same time 
running any of the proc-*.sh in a 'while true; do ... ; done' loop 
crashes by systems within a couple of minutes.


--------------030308050702010900090809
Content-Type: text/x-csrc;
 name="forkalot.c"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="forkalot.c"

// Program:  forkalot.c
//
// Compile:  cc forkalot.c -o forkalot
// Run:      ./forkalot [100] [1]
//
// Args:     arg1 = # of copies of program to run simultaneously [100]
//           arg2 = Sleep time before exiting [1]

#include <stdio.h>
#include <stdlib.h>
#include <errno.h>
#include <unistd.h>
#include <fcntl.h>

#define CHILDREN    100
#define SLEEP_FOR   1

int main(int argc, char *argv[])
{
	int	count, this_long;
	int	pid;

	if (argc > 1)
		count = atoi(argv[1]);
	else
		count = CHILDREN;
	if (argc > 2)
		this_long = atoi(argv[2]);
        else
                this_long = SLEEP_FOR;

	/* fork count-1 children */
	while (count-- > 1) {
		pid = fork();
		if (pid == 0) {
			/* child */
			break;
		} else if (pid < 0) {
			perror("fork");
			exit(1);
		}
	}

        /* Sleepy... sleepy... */
	sleep(this_long);

        /* All done... return success! */
	return 0;
}

--------------030308050702010900090809
Content-Type: application/x-shellscript;
 name="forkalot-test.sh"
Content-Transfer-Encoding: base64
Content-Disposition: inline;
 filename="forkalot-test.sh"

IyEvYmluL3NoCiMgTm90ZTogQXNzdW1lcyBwcm9ncmFtIGlzIGluIC90bXAKaWYgWyAhIC1m
IC90bXAvZm9ya2Fsb3QgXQp0aGVuCiAgICBlY2hvICJDYW5ub3QgZmluZCB0aGUgJ2Zvcmth
bG90JyBiaW5hcnkhIgogICAgZXhpdCAxCmZpCgp3aGlsZSB0cnVlOyBkbwogICAgL3RtcC9m
b3JrYWxvdCAyMDAgMQogICAga2lsbGFsbCAtcSBmb3JrYWxvdAogICAgZWNobyAtbiAiLiIK
ZG9uZQoK
--------------030308050702010900090809
Content-Type: application/x-shellscript;
 name="proc-cmdline.sh"
Content-Transfer-Encoding: base64
Content-Disposition: inline;
 filename="proc-cmdline.sh"

IyEvYmluL2Jhc2gKZmluZCAvcHJvYyAtdHlwZSBmIC1uYW1lIGNtZGxpbmUgLWV4ZWMgY2F0
IHt9ID4gL2Rldi9udWxsIDI+JjEgXDsK
--------------030308050702010900090809
Content-Type: application/x-shellscript;
 name="proc-status.sh"
Content-Transfer-Encoding: base64
Content-Disposition: inline;
 filename="proc-status.sh"

IyEvYmluL2Jhc2gKZmluZCAvcHJvYyAtdHlwZSBmIC1uYW1lIHN0YXRcKiAtZXhlYyBjYXQg
e30gPiAvZGV2L251bGwgMj4mMSBcOwo=
--------------030308050702010900090809
Content-Type: application/x-shellscript;
 name="proc-torture.sh"
Content-Transfer-Encoding: base64
Content-Disposition: inline;
 filename="proc-torture.sh"

IyEvYmluL2Jhc2gKCndoaWxlIHRydWUKZG8KICAgIGRhdGUKICAgIGZpbmQgL3Byb2MgLW1v
dW50IC1uYW1lIGNtZGxpbmUgLWV4ZWMgY2F0IHt9ID4gL2Rldi9udWxsIDI+JjEgXDsKICAg
IGZpbmQgL3Byb2MgLW1vdW50IC1uYW1lIHN0YXRcKiAtZXhlYyBjYXQge30gPiAvZGV2L251
bGwgMj4mMSBcOwpkb25lCg==
--------------030308050702010900090809--
