Return-Path: <linux-kernel-owner+willy=40w.ods.org-S263648AbUDUT1N@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263648AbUDUT1N (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 21 Apr 2004 15:27:13 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263631AbUDUT1N
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 21 Apr 2004 15:27:13 -0400
Received: from 168.imtp.Ilyichevsk.Odessa.UA ([195.66.192.168]:60174 "HELO
	port.imtp.ilyichevsk.odessa.ua") by vger.kernel.org with SMTP
	id S263657AbUDUT0k (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 21 Apr 2004 15:26:40 -0400
From: Denis Vlasenko <vda@port.imtp.ilyichevsk.odessa.ua>
To: "David S. Miller" <davem@redhat.com>
Subject: Large inlines in include/linux/skbuff.h
Date: Wed, 21 Apr 2004 22:26:28 +0300
User-Agent: KMail/1.5.4
Cc: Jeff Garzik <jgarzik@pobox.com>, linux-kernel@vger.kernel.org
MIME-Version: 1.0
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200404212226.28350.vda@port.imtp.ilyichevsk.odessa.ua>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Let's skip stuff which is smaller than 100 bytes.

Size  Uses Wasted Name and definition
===== ==== ====== ================================================
   58   20    722 __skb_dequeue include/linux/skbuff.h
  122  119  12036 skb_dequeue   include/linux/skbuff.h
  103   10    747 __skb_queue_purge     include/linux/skbuff.h
  164   78  11088 skb_queue_purge       include/linux/skbuff.h
   46   26    650 __skb_queue_tail      include/linux/skbuff.h
  109  101   8900 skb_queue_tail        include/linux/skbuff.h
   47   11    270 __skb_queue_head      include/linux/skbuff.h
  110   44   3870 skb_queue_head        include/linux/skbuff.h
   51   16    465 __skb_unlink  include/linux/skbuff.h
  132    9    896 skb_unlink    include/linux/skbuff.h
   46    2     26 __skb_append  include/linux/skbuff.h
  114    5    376 skb_append    include/linux/skbuff.h

'Uses' was counted over .c files only, .h were excluded, so
no double count here.

As you can see here, non-locking functions are more or less sanely
sized (except __skb_queue_purge). When spin_lock/unlock code gets added,
we cross 100 byte mark.

What shall be done with this? I'll make patch to move locking functions
into net/core/skbuff.c unless there is some reason not to do it.

Just to make you feel what is 100+ bytes in assembly:
void inline_skb_dequeue_1() { skb_dequeqe(0); }
gets compiled into:

00003513 <inline_skb_dequeue_1>:
    3513:       55                      push   %ebp
    3514:       89 e5                   mov    %esp,%ebp
    3516:       53                      push   %ebx
    3517:       9c                      pushf
    3518:       5b                      pop    %ebx
    3519:       fa                      cli
    351a:       b9 00 e0 ff ff          mov    $0xffffe000,%ecx
    351f:       21 e1                   and    %esp,%ecx
    3521:       ff 41 14                incl   0x14(%ecx)
    3524:       f0 fe 0d 0c 00 00 00    lock decb 0xc
    352b:       78 02                   js     352f <inline_skb_dequeue_1+0x1c>
    352d:       eb 0d                   jmp    353c <inline_skb_dequeue_1+0x29>
    352f:       f3 90                   repz nop
    3531:       80 3d 0c 00 00 00 00    cmpb   $0x0,0xc
    3538:       7e f5                   jle    352f <inline_skb_dequeue_1+0x1c>
    353a:       eb e8                   jmp    3524 <inline_skb_dequeue_1+0x11>
    353c:       8b 15 00 00 00 00       mov    0x0,%edx
    3542:       85 d2                   test   %edx,%edx
    3544:       74 2b                   je     3571 <inline_skb_dequeue_1+0x5e>
    3546:       89 d0                   mov    %edx,%eax
    3548:       8b 12                   mov    (%edx),%edx
    354a:       89 15 00 00 00 00       mov    %edx,0x0
    3550:       ff 0d 08 00 00 00       decl   0x8
    3556:       c7 42 04 00 00 00 00    movl   $0x0,0x4(%edx)
    355d:       c7 00 00 00 00 00       movl   $0x0,(%eax)
    3563:       c7 40 04 00 00 00 00    movl   $0x0,0x4(%eax)
    356a:       c7 40 08 00 00 00 00    movl   $0x0,0x8(%eax)
    3571:       b0 01                   mov    $0x1,%al
    3573:       86 05 0c 00 00 00       xchg   %al,0xc
    3579:       53                      push   %ebx
    357a:       9d                      popf
    357b:       8b 41 08                mov    0x8(%ecx),%eax
    357e:       ff 49 14                decl   0x14(%ecx)
    3581:       a8 08                   test   $0x8,%al
    3583:       74 05                   je     358a <inline_skb_dequeue_1+0x77>
    3585:       e8 fc ff ff ff          call   3586 <inline_skb_dequeue_1+0x73>
    358a:       5b                      pop    %ebx
    358b:       c9                      leave
    358c:       c3                      ret
--
vda

