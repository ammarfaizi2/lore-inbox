Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id <S132716AbQKWIRE>; Thu, 23 Nov 2000 03:17:04 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
        id <S132717AbQKWIQy>; Thu, 23 Nov 2000 03:16:54 -0500
Received: from ja.ssi.bg ([193.68.177.189]:13828 "EHLO u.domain.uli")
        by vger.kernel.org with ESMTP id <S132716AbQKWIQk>;
        Thu, 23 Nov 2000 03:16:40 -0500
Date: Thu, 23 Nov 2000 09:46:33 +0000 (GMT)
From: Julian Anastasov <ja@ssi.bg>
To: linux-kernel <linux-kernel@vger.kernel.org>
Subject: Oops in remove_shared_vm_struct
Message-ID: <Pine.LNX.4.30.0011230928170.678-100000@u>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


	Hello,

	The kernel is 2.2.18pre22 SMP + reiserfs 3.5.27. The activity
is on the reiserfs partition. The oops is at the end of the message.

There are no ksymoops texts but after analyzing the oops, the problem
is here, in inline remove_shared_vm_struct():

EIP:    0010:[<8011f5dc>]

0x8011f5cf <exit_mmap+123>:     testl  %eax,%eax
0x8011f5d1 <exit_mmap+125>:     je     0x8011f5fa <exit_mmap+166>
0x8011f5d3 <exit_mmap+127>:     testb  $0x8,0x15(%ebx)
0x8011f5d7 <exit_mmap+131>:     je     0x8011f5e5 <exit_mmap+145>
0x8011f5d9 <exit_mmap+133>:     movl   0x8(%eax),%eax
EIP:
0x8011f5dc <exit_mmap+136>:     movl   0x8(%eax),%eax
0x8011f5df <exit_mmap+139>:     incl   0x94(%eax)
0x8011f5e5 <exit_mmap+145>:     movl   0x20(%ebx),%edx
0x8011f5e8 <exit_mmap+148>:     testl  %edx,%edx
0x8011f5ea <exit_mmap+150>:     je     0x8011f5f2 <exit_mmap+158>


The source code: file->f_dentry->d_inode->i_writecount++;

It seems file->f_dentry is 0?

The Call Trace is:
Call Trace: [<8011519b>] [<8011a152>] [<8011a326>] [<80109404>]

0x80115195 <mmput+25>:  pushl  %ebx
0x80115196 <mmput+26>:  call   0x8011f554 <exit_mmap>
0x8011519b <mmput+31>:  pushl  %ebx

0x8011a14c <do_exit+260>:       pushl  %ebx
0x8011a14d <do_exit+261>:       call   0x8011517c <mmput>
0x8011a152 <do_exit+266>:       addl   $0x4,%esp

0x8011a318 <sys_exit>:  movzbl 0x4(%esp,1),%eax
0x8011a31d <sys_exit+5>:        shll   $0x8,%eax
0x8011a320 <sys_exit+8>:        pushl  %eax
0x8011a321 <sys_exit+9>:        call   0x8011a048 <do_exit>
0x8011a326 <sys_exit+14>:       movl   %esi,%esi

0x801093f7 <system_call+39>:    testb  $0x20,0x4(%ebx)
0x801093fb <system_call+43>:    jne    0x80109460 <tracesys>
0x801093fd <system_call+45>:    call   *0x802774e4(,%eax,4)
0x80109404 <system_call+52>:    movl   %eax,0x18(%esp,1)



The oops:

Unable to handle kernel NULL pointer dereference at virtual address 8
current->tss.cr3 = 00101000, %cr3 = 00101000
*pde = 00000000
Oops: 0000
CPU:    0
EIP:    0010:[<8011f5dc>]
EFLAGS: 00010202
eax: 00000000   ebx: 83dda740   ecx: 83dda680   edx: 83dda7fc
esi: 2aab5000   edi: 90c770c0   ebp: 00001000   esp: 83cabf7c
ds: 0018   es: 0018   ss: 0018
Process sleep (pid: 10579, process nr: 42, stackpage=83cab000)
Stack: 00000000 7ffffe3c 83dda680 8011519b 90c770c0 90c770c0 90c770c0 8011a152
       90c770c0 83caa000 2ab4f6b0 00000000 7ffffe3c 00000000 83caa000 8011a326
       00000000 80109404 00000000 2ab4b2e8 2ab4f6cc 2ab4f6b0 00000000 7ffffe3c
Call Trace: [<8011519b>] [<8011a152>] [<8011a326>] [<80109404>]
Code: 8b 40 08 ff 80 94 00 00 00 8b 53 20 85 d2 74 06 8b 43 24 89


Regards

--
Julian Anastasov <ja@ssi.bg>

-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
