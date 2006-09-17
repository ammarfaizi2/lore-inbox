Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751153AbWIQWBj@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751153AbWIQWBj (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 17 Sep 2006 18:01:39 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751254AbWIQWBj
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 17 Sep 2006 18:01:39 -0400
Received: from alnrmhc14.comcast.net ([206.18.177.54]:42958 "EHLO
	alnrmhc14.comcast.net") by vger.kernel.org with ESMTP
	id S1751153AbWIQWBi (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 17 Sep 2006 18:01:38 -0400
Message-ID: <450DC8A5.80703@elegant-software.com>
Date: Sun, 17 Sep 2006 18:13:57 -0400
From: Russell Leighton <russ@elegant-software.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.6) Gecko/20040113
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Linux Kernel list <linux-kernel@vger.kernel.org>
Subject: BUG: soft lockup detected on CPU + cifs_getattr
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


For the last few months we have had "hangs" where the machine
will respond to pings , but nothing else. After upgrading the kernel
we now get a useful message when it hangs, so I thought that
with the message and an example program perhaps someone can track this down.

The nature of the issue is with a program that execs many processes
quickly in succession on an SMP machine and these processes read the 
some of the same
files over a CIFS share. At random times the machine hangs under this load.
I created a shell script (below) that does a similar thing and can 
reliably cause the
machine to hang.

We are running:

    Linux prodeng2 2.6.17-1.2142_FC4smp #1 SMP Tue Jul 11 22:57:02 EDT
    2006 i686 i686 i386 GNU/Linux

we get the following error:

Sep 16 00:04:30 prodeng2 kernel: BUG: soft lockup detected on CPU#2!
Sep 16 00:04:30 prodeng2 kernel:  <c0447823> softlockup_tick+0x9f/0xb2  <c042b497> update_process_times+0x39/0x5c
Sep 16 00:04:30 prodeng2 kernel:  <c041737d> smp_apic_timer_interrupt+0x54/0x5a  <c0404800> apic_timer_interrupt+0x1c/0x24
Sep 16 00:04:30 prodeng2 kernel:  <c046eed9> generic_fillattr+0x71/0x9f  <f8ff18db> cifs_getattr+0x1e/0x27 [cifs]
Sep 16 00:04:30 prodeng2 kernel:  <f8ff18bd> cifs_getattr+0x0/0x27 [cifs]  <c046ef45> vfs_getattr+0x3e/0x97
Sep 16 00:04:30 prodeng2 kernel:  <c046f051> vfs_fstat+0x22/0x31  <c046f724> sys_fstat64+0xf/0x23
Sep 16 00:04:30 prodeng2 kernel:  <c0403d2f> syscall_call+0x7/0xb 
Sep 16 00:04:30 prodeng2 kernel: BUG: soft lockup detected on CPU#1!
Sep 16 00:04:30 prodeng2 kernel:  <c0447823> softlockup_tick+0x9f/0xb2  <c042b497> update_process_times+0x39/0x5c
Sep 16 00:04:30 prodeng2 kernel:  <c041737d> smp_apic_timer_interrupt+0x54/0x5a  <c0404800> apic_timer_interrupt+0x1c/0x24
Sep 16 00:04:30 prodeng2 kernel:  <c046eecd> generic_fillattr+0x65/0x9f  <f8ff18db> cifs_getattr+0x1e/0x27 [cifs]
Sep 16 00:04:30 prodeng2 kernel:  <f8ff18bd> cifs_getattr+0x0/0x27 [cifs]  <c046ef45> vfs_getattr+0x3e/0x97
Sep 16 00:04:30 prodeng2 kernel:  <c046f051> vfs_fstat+0x22/0x31  <c046f724> sys_fstat64+0xf/0x23
Sep 16 00:04:30 prodeng2 kernel:  <c0403d2f> syscall_call+0x7/0xb 

  

...after googling a little, the closest similar report I find is:

    http://blog.gmane.org/gmane.comp.emulators.xen.devel/day=20060916

To tickle this bug do:

   1. Create a CIFS  share, ideally on a  real Windows server since that
      is the current context of the issue I am reporting
   2. Run this shell script using a path to a file on the share:

file_on_cifs_mnt=$1

while true
do
# limited fork bomb...repeat until hang
c=1;
while [ $c -lt 10000 ]
do
 # cif mounted file will cause hang
 (cat $file_on_cifs_mnt > /dev/null ; ) &
 # local file won't hang me
 # (cat /etc/passwd > /dev/null ; ) &
 let c=c+1
done
wait
done

NOTE: sometimes it would hang immediately, sometimes after a time, 
sometimes I had to run 2 instances of the script concurrently to get the 
BUG.

If anyone has a fix OR a work around I would very much appreciate the help.

Thx.

Russ


