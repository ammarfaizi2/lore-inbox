Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751602AbWITPLU@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751602AbWITPLU (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 20 Sep 2006 11:11:20 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751603AbWITPLU
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 20 Sep 2006 11:11:20 -0400
Received: from buraja.hst.terra.com.br ([200.176.10.198]:48563 "EHLO
	buraja.hst.terra.com.br") by vger.kernel.org with ESMTP
	id S1751602AbWITPLT (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 20 Sep 2006 11:11:19 -0400
X-Terra-Karma: -2%
X-Terra-Hash: 50f637daf62d76f8353fe8479d3c7cb9
Message-ID: <001801c6dcc7$02085160$2201a8c0@soto>
From: "Fernando Soto" <f.soto@terra.com.br>
To: <linux-kernel@vger.kernel.org>
Cc: <viro@zeniv.linux.org.uk>
References: <001301c6dcc3$a3c94d50$2201a8c0@soto>
Subject: Re: Processes stuck in D trying to acquire lock at vfs_rename_dir
Date: Wed, 20 Sep 2006 12:11:11 -0300
MIME-Version: 1.0
Content-Type: text/plain;
	format=flowed;
	charset="iso-8859-1";
	reply-type=response
Content-Transfer-Encoding: 8bit
X-Priority: 3
X-MSMail-Priority: Normal
X-Mailer: Microsoft Outlook Express 6.00.2900.2869
X-MimeOLE: Produced By Microsoft MimeOLE V6.00.2900.2962
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

I was able to reproduce the deadlock reported by Ruda.
It is a race condition between two processes renaming directories on a NFS 
volume.
Assuming the following directory structure:
    "/nfs/a/b/c", where "/nfs" is mounted on a NFS volume...
Process 1 tries to rename "/nfs/a/b/c" to "/nfs/a/d"
at the same time that process 2 (in the second server) is trying to rename
"/nfs/a/b" to "/nfs/a/d".
Process 1 may hang.
The code below reproduces the problem.

Regards,
Fernando Soto

-------------- start cut here -------------
/**********************************
renamedir

This program can be used to reproduce the deadlock in
vfs_rename_dir, kernel 2.6.17

Instructions:
1. Mount a NFS volume from two servers (e.g. /nfs)
2. Create a directory (e.g. testdir) in this volume
3. In the first server, run 'renamedir -p /nfs/testdir'
4. In the second server, run 'renamedir -p /nfs/testdir -c'

Wait for a while. The process in the first server
        should cause a deadlock in the VFS and stuck in
        D state.

Fernando Soto - f.soto () terra ! com ! br - 20/Sep/2006
Terra Networks Brasil S/A
*********************************/
#include <stdio.h>
#include <sys/stat.h>
#include <sys/types.h>
#include <unistd.h>
#include <stdlib.h>
#include <errno.h>

void usage(void)
{
        fprintf(stderr,"renamedir -p <path> [-c]\n");
        exit(1);
}

int main(int argc, char *argv[])
{
        int test_case = 0;
        char source[FILENAME_MAX];
        char target[FILENAME_MAX];
        const char *p1 = NULL;
        int i;

        // read options
        while ((i = getopt(argc, argv, "p:c")) != -1) {
                switch (i) {
                        case 'c':
                                test_case = 1;
                                break;
                        case 'p':
                                p1 = optarg;
                                break;
                }
        }
        if (!p1) {
                usage();
        }

        // create test environment
        snprintf(target,sizeof(target),"%s/b",p1);
        if (mkdir(target,0755) == -1 && errno != EEXIST) {
                fprintf(stderr,"Could not create dir %s: 
%s\n",target,strerror(errno));
                exit(1);
        }
        snprintf(target,sizeof(target),"%s/b/e",p1);
        if (mkdir(target,0755) == -1 && errno != EEXIST) {
                fprintf(stderr,"Could not create dir %s: 
%s\n",target,strerror(errno));
                exit(1);
        }
        snprintf(target,sizeof(target),"%s/b/c",p1);
        if (mkdir(target,0755) == -1 && errno != EEXIST) {
                fprintf(stderr,"Could not create dir %s: 
%s\n",target,strerror(errno));
                exit(1);
        }
        snprintf(target,sizeof(target),"%s/b/c/f",p1);
        if (mkdir(target,0755) == -1 && errno != EEXIST) {
                fprintf(stderr,"Could not create dir %s: 
%s\n",target,strerror(errno));
                exit(1);
        }

        // prepare test cases
        if (test_case) {
                snprintf(source,sizeof(target),"%s/b",p1);
                snprintf(target,sizeof(target),"%s/d",p1);
        } else {
                snprintf(source,sizeof(target),"%s/b/c",p1);
                snprintf(target,sizeof(target),"%s/d",p1);
        }

        // test loop
        while (1) {
                rename(source,target);
                rename(target,source);
        }
}
-------------- end cut here -------------


> List:       linux-kernel
> Subject:    Processes stuck in D trying to acquire lock at vfs_rename_dir
> From:       Rudá Moura <ruda.moura () terra ! com ! br>
> Date:       2006-09-19 18:09:59
> Message-ID: 1158689399.32184.17.camel () localhost
> [Download message RAW]
>
> We are huge mail provider with a pool of many mx, pop and imap machines
> and we are facing a rather strange situation when we recently
> upgraded one of our applications, and after a week running, several
> processes hang in "D" (disk wait) state forever. That way, we cannot
> strace, gdb, pstack them to know what they were doing or where they
> were.
>
> On the top of those machines are running RHEL version 4 with
> kernel 2.6.9-42.ELsmp. Some are running (stock) kernel 2.6.17.11
> with KDB patch applied. The hardware is described as follow:
>
> - Dell PowerEdge 6850, QUAD 3,2GHZ HT , 8GB RAM,
> - 5 SCSI disks 146 GB 15k RPM.
>
> We use NFS to keep mailboxes in maildir format. They are shared to many
> machines and are provided by a NFS server storage.
>
> In order to gain more understanding of the problem
> we decide to enable mutex/futex debug (CONFIG_DEBUG_MUTEXES=y),
> because the bug is hard to reproduce and happens in an occasional manner
> for a week or more.
>
> The process locked was "ttrlmtp_tcp", they stuck in D while are trying
> to rename() as the log message states:
>
> lmtplog.6.gz:Sep 18 19:00:02 mangoro trrlmtpd_tcp[12499]:
> 1158616802.840213: TrrMailMdirMoveMBToIdPermMB: trying to rename
> [/nfs/mail3d03/m/a/r/i/a/4/8/2/6/maria4826/Maildir] to
> [/nfs/mail3d03/m/a/r/i/a/4/8/2/6/18538100#perm!terra.maria4826] ...
>
> and this is what Mutex/Futex Debug gave to us:
>
> Sep 18 19:00:02 mangoro kernel:
> ==========================================
> Sep 18 19:00:02 mangoro kernel: [ BUG: lock recursion deadlock detected!
> |
> Sep 18 19:00:02 mangoro kernel:
> ------------------------------------------
> Sep 18 19:00:15 mangoro kernel:
> Sep 18 19:00:15 mangoro kernel: trrlmtpd_tcp/12499 is trying to acquire
> this lock:
> Sep 18 19:00:15 mangoro kernel:  [ed260830] {inode_init_once}
> Sep 18 19:00:15 mangoro kernel: .. held by:      trrlmtpd_tcp:12499
> [d94cc560, 115]
> Sep 18 19:00:15 mangoro kernel: ... acquired at:
> lock_rename+0x36/0x94
> Sep 18 19:00:15 mangoro kernel: ... trying at:
> vfs_rename_dir+0x84/0x100
> Sep 18 19:00:15 mangoro kernel: ------------------------------
> Sep 18 19:00:15 mangoro kernel: | showing all locks held by: |
> (trrlmtpd_tcp/12499 [d94cc560, 115]):
> Sep 18 19:00:15 mangoro kernel: ------------------------------
> Sep 18 19:00:15 mangoro kernel:
> Sep 18 19:00:15 mangoro kernel: #001:             [f6e839f4]
> {alloc_super}
> Sep 18 19:00:15 mangoro kernel: ... acquired at:
> lock_rename+0x4f/0x94
> Sep 18 19:00:15 mangoro kernel:
> Sep 18 19:00:15 mangoro kernel: #002:             [ed260b50]
> {inode_init_once}
> Sep 18 19:00:15 mangoro kernel: ... acquired at:
> lock_rename+0x2b/0x94
> Sep 18 19:00:15 mangoro kernel:
> Sep 18 19:00:15 mangoro kernel: #003:             [ed260830]
> {inode_init_once}
> Sep 18 19:00:15 mangoro kernel: ... acquired at:
> lock_rename+0x36/0x94
> Sep 18 19:00:15 mangoro kernel:
> Sep 18 19:00:15 mangoro kernel:
> Sep 18 19:00:15 mangoro kernel: trrlmtpd_tcp/12499's [current]
> stackdump:
> Sep 18 19:00:15 mangoro kernel:
> Sep 18 19:00:15 mangoro kernel:  <c0104205> show_trace+0xd/0xf
> <c01042ce> dump_stack+0x15/0x17
> Sep 18 19:00:15 mangoro kernel:  <c0131205> report_deadlock+0xea/0x102
> <c0131364> check_deadlock+0x147/0x151
> Sep 18 19:00:15 mangoro kernel:  <c0131908> debug_mutex_add_waiter
> +0x80/0x93  <c02fcf02> __mutex_lock_slowpath+0x117/0x37a
> Sep 18 19:00:15 mangoro kernel:  <c02fcddb> mutex_lock+0x24/0x27
> <c0168888> vfs_rename_dir+0x84/0x100
> Sep 18 19:00:15 mangoro kernel:  <c0168b2a> vfs_rename+0x135/0x273
> <c0168d9f> do_rename+0x137/0x176
> Sep 18 19:00:15 mangoro kernel:  <c0168e17> sys_renameat+0x39/0x54
> <c0168e44> sys_rename+0x12/0x14
> Sep 18 19:00:15 mangoro kernel:  <c01032ef> sysenter_past_esp+0x54/0x75
>
>
> Unfortunately we couldn't use KDB to debug this process because we had
> to reboot the machine.
> We are waiting for another process lock.
>
> Any help in the subject will be very appreciate and we are ready to
> provide more information about this problem if required.
>
> Thanks in Advance.
>
> -- 
> Rudá Moura <ruda.moura@terra.com.br> 

