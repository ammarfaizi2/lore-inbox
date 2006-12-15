Return-Path: <linux-kernel-owner+w=401wt.eu-S1750849AbWLOGAz@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750849AbWLOGAz (ORCPT <rfc822;w@1wt.eu>);
	Fri, 15 Dec 2006 01:00:55 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750857AbWLOGAz
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 15 Dec 2006 01:00:55 -0500
Received: from wx-out-0506.google.com ([66.249.82.236]:34350 "EHLO
	wx-out-0506.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750856AbWLOGAy (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 15 Dec 2006 01:00:54 -0500
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:mime-version:content-type:content-transfer-encoding:content-disposition;
        b=fR13uoivKJEulZ7N+c7iQoPqdrv2ySFZkyfoqF2FyU7AAAkdQWy3NDKf4Ger5z4WD+a7hJU3gr6j3Yl2oU32UxL5TQw+9Ql8FIf5V8LQZtNBQUC9bKXMuMeLKzY6rXsXuGlw1nv5ZM3gOMnoFIwk5uONU77n361HFE6fTtR9DcI=
Message-ID: <ad7541e70612142200v7709a254xe5e702e2f5e3695f@mail.gmail.com>
Date: Fri, 15 Dec 2006 11:30:51 +0530
From: "kiran kumar" <cnvkiran@gmail.com>
To: linux-kernel@vger.kernel.org
Subject: crash in 'wake_up_interruptible()' on SMP
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Can some one explain why I see the below crash on Intel Xeon SMP box.
The kernel version is 2.6.11. This is what I'm trying to do in the
driver.

1.Submit a request to a device in 'unlocked_ioctl()' and issue
'wait_event_interruptible_timeout()' for 10 jiffies. There can be many
such outstanding requests issued by different processes and all these
are placed in a queue.
2.The 'wake_up_interruptible()' is issued either from tasklet or a
poll-thread which polls on the status of the request.
3. The request queue is protected using  'spin_lock_bh/spin_unlock_bh'
to be softIRQ safe. I'm stating this to point that
'spin_lock_irqsave/spin_lock_irqrestore' is issued only within waitQ.

If i either not use 'unlocked_ioctl()' i.e. use ioctl() (or)comment
out 'wake_up_interruptible()' call I don't see the crash. Is
wake_up_interruptible SMP safe???

Regards,
kiran

/---------------------------------------------------------------------------------------------------------/
[root@localhost ~]# ------------[ cut here ]------------
kernel BUG at include/asm/spinlock.h:112!
invalid operand: 0000 [#1]
SMP
Modules linked in: pkp_drv(U) md5 ipv6 parport_pc lp parport autofs4
rfcomm l2cap bluetooth sunrpc dm_mod video button battery ac uhci_hcd
hw_random i2c_i801 i2c_core shpchp e1000 e100 mii floppy sata_sil
libata scsi_mod ext3 jbd
CPU:    0
EIP:    0060:[<c03087b0>]    Tainted: P      VLI
EFLAGS: 00210002   (2.6.11-1.1369_FC4smp)
EIP is at _spin_unlock_irqrestore+0x26/0x30
eax: 00000001   ebx: cfefb810   ecx: cfefb810   edx: 00200292
esi: 00000000   edi: e0af0f20   ebp: 00000000   esp: c8ae2e10
ds: 007b   es: 007b   ss: 0068
Process swamp (pid: 5920, threadinfo=c8ae2000 task=c79d4a80)
Stack: badc0ded e0c8e1af 00000000 e0af0268 e0a86ef8 e0c87f46 00000802 00000000
       00200286 e0a86ef8 00200286 e0c9c580 00000000 e0c87dd1 cfec1810 d028a810
       00000000 bf9fc228 e0c8dab4 00000001 c8ae2000 3f37331a bf9fc228 e0c9c580
/----------------------------------------------------------------------------------------------------------------------------------/
