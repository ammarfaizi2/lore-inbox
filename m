Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129404AbQKPWJW>; Thu, 16 Nov 2000 17:09:22 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129851AbQKPWJL>; Thu, 16 Nov 2000 17:09:11 -0500
Received: from stat8.steeleye.com ([63.113.59.41]:39695 "EHLO
	fenric.sc.steeleye.com") by vger.kernel.org with ESMTP
	id <S129404AbQKPWJD>; Thu, 16 Nov 2000 17:09:03 -0500
Message-ID: <3A145268.7D6CF3FF@SteelEye.com>
Date: Thu, 16 Nov 2000 16:32:24 -0500
From: Paul Clements <Paul.Clements@SteelEye.com>
X-Mailer: Mozilla 4.7 [en] (X11; I; Linux 2.2.13 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org
Subject: kernel panic on 2.2.14 in sg driver
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


I am seeing a kernel panic on 2.2.14. It looks like 2.2.16 also has the
same problem.

Details:

I have been able to reproduce a kernel panic several times with kdb
compiled in and some added printk debug messages and I have now
pinpointed the problem. The panic occurs when the following call is made
in scsi_ioctl_send_command() ("scsi_ioctl.c", line 329):

  if(SDpnt->scsi_request_fn)
        (*SDpnt->scsi_request_fn)();

I have verified that scsi_request_fn is a function pointer that points
to the do_sd_request() function ("sd.c", line 530). By adding a debug
printk() right before this call I can see that this function pointer
contains: 0x8489ab80. This is the address where the panic occurs,
labelled "?unknown?" in the stack trace below. After a panic, when I
list the instructions at that address, the code that is there is the
middle of a switch statement in the sg_ioctl() function. The function
pointer is pointing to a bogus address.

The problem appears to be due to the following: 

do_sd_request() is in the sd_mod.o module
sg_ioctl() is in sg.o
scsi_ioctl_send_command() is in scsi_mod.o 

Now sg.o and sd_mod.o have a dependency on scsi_mod.o, but sg.o and
sd_mod.o are independent of each other. I can cause the kernel to panic
by simply unloading sd_mod.o and then performing an ioctl
(SCSI_IOCTL_SEND_COMMAND) on an open sg device. 

Since sg does not depend on sd_mod, the kernel loads sg.o when the sg
device is opened, but does not know to load sd_mod.o. The call to
"scsi_request_fn" then of course causes a panic. This problem is
compounded by the fact that most modern Linux distributions (I'm running
Caldera eServer 2.3 on this box), have an /etc/crontab entry that does:
"/sbin/rmmod -a" every five minutes, so sd_mod gets autocleaned
frequently.

So I guess I have a couple questions:

Does anyone know if the SCSI drivers have been redesigned to avoid this
type of problem in the 2.4 kernel?

Does anyone have a solution or workaround to this problem? As a
workaround, I guess I could avoid the autoclean problem by doing "insmod
sd_mod" in some startup script.

Are there other instances of this type of problem elsewhere in the
kernel? 

If you need/want any more information about this, just let me know...

Thanks,
Paul



kernel stack trace:
------------------
?unknown? (?pointer?, arg, filp, -25, 1)
sg_ioctl (filp->f_dentry->d_inode, filp, SCSI_IOCTL_SEND_COMMAND, arg)
sys_ioctl (fd, SCSI_IOCTL_SEND_COMMAND, arg)
system_call
 
where `fd' is an open file descriptor for the scsi device
 
and `filp' is a "struct file *" corresponding to the open file
descriptor for the scsi device
 
and `arg' is the "Scsi_Ioctl_Command *" (struct scsi_ioctl_command *)
sent in from the original ioctl call, in this case containing the
following:
 
 inlen = 0
 outlen = 0
 command = { 0 (TEST UNIT READY), 6, 0, 70, 98, 0 }
 data = {empty}
-
To unsubscribe from this list: send the line "unsubscribe linux-scsi" in
the body of a message to majordomo@vger.kernel.org
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
