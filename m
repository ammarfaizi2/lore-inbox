Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261461AbVCMU7X@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261461AbVCMU7X (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 13 Mar 2005 15:59:23 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261460AbVCMU7X
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 13 Mar 2005 15:59:23 -0500
Received: from hendrix.ece.utexas.edu ([128.83.59.42]:42651 "EHLO
	hendrix.ece.utexas.edu") by vger.kernel.org with ESMTP
	id S261459AbVCMU6X (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 13 Mar 2005 15:58:23 -0500
Date: Sun, 13 Mar 2005 14:58:16 -0600 (CST)
From: "Hmamouche, Youssef" <youssef@ece.utexas.edu>
Reply-To: youssef@ece.utexas.edu
To: linux-kernel@vger.kernel.org
cc: arjanv@redhat.com, youssef@ece.utexas.edu
Subject: [OOPS] kHTTPd oops + patch
Message-ID: <Pine.LNX.4.61.0503131428470.26663@linux08.ece.utexas.edu>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII; format=flowed
X-MailScanner: Found to be clean
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


hi,

khttpd oopses after a browser request is sent to the admin port on 8080. The
decoded oops follows with a patch that fixes it:


ksymoops 2.4.9 on i686 2.4.28.  Options used
      -V (default)
      -k /proc/ksyms (default)
      -l /proc/modules (default)
      -o /lib/modules/2.4.28/ (default)
      -m /boot/linux-2.4.28-dec/System.map (specified)

Unable to handle kernel NULL pointer dereference at virtual address 
00000004
c0116a36
*pde = 00000000
Oops: 0002
CPU:    0
EIP:    0010:[<c0116a36>]    Not tainted
Using defaults from ksymoops -t elf32-i386 -a i386
EFLAGS: 00010086
eax: 00000000   ebx: d097a424   ecx: 00000000   edx: d097a41c
esi: 00000286   edi: c03b8dec   ebp: d01e2000   esp: d01e3f84
ds: 0018   es: 0018   ss: 0018
Process khttpd - 0 (pid: 1119, stackpage=d01e3000)
Stack: d097a400 00000000 c029dcbd d03b533c 00000000 c029f088 d097a400 
00000050
        00000002 00000000 00000000 c029cfac 00000000 d02ded54 00000000 
00000000
        d01e2000 00000000 00000000 00000001 d01e2000 d01e1fd8 d02ded70 
00000f00
Call Trace:    [<c029dcbd>] [<c029f088>] [<c029cfac>] [<c010565e>] 
[<c029cdb0>]
Code: 89 48 04 89 01 c7 43 04 00 00 00 00 c7 42 08 00 00 00 00 56


> > EIP; c0116a36 <remove_wait_queue+16/40>   <=====

> > ebx; d097a424 <_end+105bf278/18b86eb4>
> > edx; d097a41c <_end+105bf270/18b86eb4>
> > edi; c03b8dec <threadinfo+c/200>
> > ebp; d01e2000 <_end+fe26e54/18b86eb4>
> > esp; d01e3f84 <_end+fe28dd8/18b86eb4>

Trace; c029dcbd <CleanUpRequest+5d/70>
Trace; c029f088 <Userspace+68/a0>
Trace; c029cfac <MainDaemon+1fc/220>
Trace; c010565e <arch_kernel_thread+2e/40>
Trace; c029cdb0 <MainDaemon+0/220>

Code;  c0116a36 <remove_wait_queue+16/40>
00000000 <_EIP>:
Code;  c0116a36 <remove_wait_queue+16/40>   <=====
    0:   89 48 04                  mov    %ecx,0x4(%eax)   <=====
Code;  c0116a39 <remove_wait_queue+19/40>
    3:   89 01                     mov    %eax,(%ecx)
Code;  c0116a3b <remove_wait_queue+1b/40>
    5:   c7 43 04 00 00 00 00      movl   $0x0,0x4(%ebx)
Code;  c0116a42 <remove_wait_queue+22/40>
    c:   c7 42 08 00 00 00 00      movl   $0x0,0x8(%edx)
Code;  c0116a49 <remove_wait_queue+29/40>
   13:   56                        push   %esi


return value from sock_recvmsg in ReadRest() is unchecked. also the check 
for sock->sk==NULL is redundant and is done earlier anyway.


Thanks,
Youssef



Signed-off-by: Youssef Hmamouche <hyoussef@gmail.com>

--- /usr/src/linux-2.4.28-old/net/khttpd/misc.c 2001-02-09 11:29:44.000000000 -0800
+++ /usr/src/linux-2.4.28/net/khttpd/misc.c     2005-03-13 14:32:39.000000000 -0800
@@ -57,7 +57,7 @@
  before closing the socket.

  */
-static void ReadRest(struct socket *sock)
+static int ReadRest(struct socket *sock)
  {
         struct msghdr           msg;
         struct iovec            iov;
@@ -69,9 +69,6 @@
         EnterFunction("ReadRest");


-       if (sock->sk==NULL)
-               return;
-
         len = 1;

         while (len>0)
@@ -94,8 +91,12 @@
                 oldfs = get_fs(); set_fs(KERNEL_DS);
                 len = sock_recvmsg(sock,&msg,1024,MSG_DONTWAIT);
                 set_fs(oldfs);
+
+               if(len < 0)
+                       break;
         }
         LeaveFunction("ReadRest");
+       return len;
  }


@@ -107,12 +108,17 @@
  */
  void CleanUpRequest(struct http_request *Req)
  {
+       int len;
+
         EnterFunction("CleanUpRequest");
-
+
         /* Close the socket ....*/
         if ((Req->sock!=NULL)&&(Req->sock->sk!=NULL))
         {
-               ReadRest(Req->sock);
+               if((len=ReadRest(Req->sock))<0){
+                       printk(KERN_ERR "kHTTPd: error reading from socket\n");
+                       goto out;
+               }
                 remove_wait_queue(Req->sock->sk->sleep,&(Req->sleep));
                 sock_release(Req->sock);
         }
@@ -124,7 +130,7 @@
                 Req->filp = NULL;
         }

-
+  out:
         /* ... and release the memory for the structure. */
         kfree(Req);


