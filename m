Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261510AbSJIIpA>; Wed, 9 Oct 2002 04:45:00 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261512AbSJIIpA>; Wed, 9 Oct 2002 04:45:00 -0400
Received: from n1x6.imsa.edu ([143.195.1.6]:43715 "EHLO mail.imsa.edu")
	by vger.kernel.org with ESMTP id <S261510AbSJIIo6>;
	Wed, 9 Oct 2002 04:44:58 -0400
Date: Wed, 9 Oct 2002 03:50:41 -0500
From: Maciej Babinski <maciej@imsa.edu>
To: linux-kernel@vger.kernel.org
Subject: uinput oops in 2.5.41
Message-ID: <20021009035041.A6226@imsa.edu>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I get a NULL pointer dereference by running "cat" on /dev/misc/uinput
I'm a newbie, but I think the patch at the bottom fixes it.


ksymoops 2.4.6 on i586 2.5.41.  Options used
     -v /usr/src/linux/vmlinux (specified)
     -k /proc/ksyms (default)
     -l /proc/modules (default)
     -o /lib/modules/2.5.41/ (default)
     -m /usr/src/linux/System.map (default)

Unable to handle kernel NULL pointer dereference at virtual address 00000004
c0112986
*pde = 00000000
Oops: 0002
CPU:    0
EIP:    0060:[<c0112986>]    Not tainted
Using defaults from ksymoops -t elf32-i386 -a i386
EFLAGS: 00010046
eax: c521e008   ebx: 00000000   ecx: c3919f5c   edx: c3919f50
esi: 00000246   edi: c3918000   ebp: c3b76b40   esp: c3919f20
ds: 0068   es: 0068   ss: 0068
Stack: c521e000 00000000 c69305cd c521e008 00000000 c3cfd380 c01118c0 00000000 
       00000000 00000000 00000000 00000000 00000000 c3cfd380 c01118c0 00000000 
       00000000 00000000 c3919f7c bffff864 c3b76b40 0804e758 00000400 c3b76b60 
Call Trace: [<c69305cd>]  [<c01118c0>]  [<c01118c0>]  [<c0137f09>]  [<c013803a>]  [<c0107357>] 
Code: 89 4b 04 89 41 04 56 9d 5b 5e c3 90 8d b4 26 00 00 00 00 8d 


>>EIP; c0112986 <add_wait_queue+16/30>   <=====

>>eax; c521e008 <_end+4f5f81c/6543814>
>>ecx; c3919f5c <_end+365b770/6543814>
>>edx; c3919f50 <_end+365b764/6543814>
>>edi; c3918000 <_end+3659814/6543814>
>>ebp; c3b76b40 <_end+38b8354/6543814>
>>esp; c3919f20 <_end+365b734/6543814>

Trace; c69305cd <[uinput]uinput_read+fd/170>
Trace; c01118c0 <default_wake_function+0/40>
Trace; c01118c0 <default_wake_function+0/40>
Trace; c0137f09 <vfs_read+99/d0>
Trace; c013803a <sys_read+2a/40>
Trace; c0107357 <syscall_call+7/b>

Code;  c0112986 <add_wait_queue+16/30>
00000000 <_EIP>:
Code;  c0112986 <add_wait_queue+16/30>   <=====
   0:   89 4b 04                  mov    %ecx,0x4(%ebx)   <=====
Code;  c0112989 <add_wait_queue+19/30>
   3:   89 41 04                  mov    %eax,0x4(%ecx)
Code;  c011298c <add_wait_queue+1c/30>
   6:   56                        push   %esi
Code;  c011298d <add_wait_queue+1d/30>
   7:   9d                        popf   
Code;  c011298e <add_wait_queue+1e/30>
   8:   5b                        pop    %ebx
Code;  c011298f <add_wait_queue+1f/30>
   9:   5e                        pop    %esi
Code;  c0112990 <add_wait_queue+20/30>
   a:   c3                        ret    
Code;  c0112991 <add_wait_queue+21/30>
   b:   90                        nop    
Code;  c0112992 <add_wait_queue+22/30>
   c:   8d b4 26 00 00 00 00      lea    0x0(%esi,1),%esi
Code;  c0112999 <add_wait_queue+29/30>
  13:   8d 00                     lea    (%eax),%eax



--- linux-2.5.41/drivers/input/misc/uinput.c	Mon Oct  7 13:24:50 2002
+++ linux-2.5.41.new/drivers/input/misc/uinput.c	Wed Oct  9 03:47:15 2002
@@ -224,15 +224,14 @@
 
 	udev = (struct uinput_device *)file->private_data;
 
+	if (!(udev->state & UIST_CREATED))
+		return -ENODEV;
+
 	if (udev->head == udev->tail) {
 		add_wait_queue(&udev->waitq, &waitq);
 		current->state = TASK_INTERRUPTIBLE;
 
 		while (udev->head == udev->tail) {
-			if (!(udev->state & UIST_CREATED)) {
-				retval = -ENODEV;
-				break;
-			}
 			if (file->f_flags & O_NONBLOCK) {
 				retval = -EAGAIN;
 				break;

