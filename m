Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262337AbRENLW1>; Mon, 14 May 2001 07:22:27 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262338AbRENLWS>; Mon, 14 May 2001 07:22:18 -0400
Received: from [195.56.211.151] ([195.56.211.151]:65154 "EHLO lima")
	by vger.kernel.org with ESMTP id <S262337AbRENLWM>;
	Mon, 14 May 2001 07:22:12 -0400
Message-ID: <3AFFBF14.7D7BAB01@sch.bme.hu>
Date: Mon, 14 May 2001 13:18:44 +0200
From: Marcell GAL <cell@sch.bme.hu>
X-Mailer: Mozilla 4.76 [en] (X11; U; Linux 2.4.4 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org, Paul Mackerras <paulus@samba.org>,
        Michal Ostrowski <mostrows@styx.uwaterloo.ca>
Subject: Scheduling in interrupt BUG.
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Guys,

Once upon a time on my
x86 UP box, UP kernel 2.4.4, (64M ram, 260M swap)
http://home.sch.bme.hu/~cell/.config
I hit a reproducable "Scheduling in interrupt" BUG.
Also reproduced with 128M ram and low memory pressure
(first I suspected it is related to swapping)
Running lots of pppd version 2.4.0 (pppoe) sessions almost at the same
time. 
(before the crash the pppoe sessions work fine)
It crashed after 89 sessions, 473 another time.. (depending
on the phase of Jupiter moons I guess .. I still have to verify this),
usually much before memory is exhausted (30k mem/pppd process).
To do this you have to patch ppp_generic.c
http://x-dsl.hu/~cell/ppp_generic_hash/, because
otherwise we hit 'NULL ptr in all_ppp_units list'
BUG much _more likely_ than this 'sched.c line 709 thingy'..

EIP: c010faa4 <schedule+388/394>   <===== sched.c schedule(), line 709:
which is ~ printk("Scheduling in interrupt");BUG();

Trace:

0xc01ddac5 <__lock_sock+53>:    movl   $0x0,0x1c(%esp,1)
0xc01ddacd <__lock_sock+61>:    mov    %ebx,0x20(%esp,1)
0xc01ddad1 <__lock_sock+65>:    movl   $0x0,0x24(%esp,1)
0xc01ddad9 <__lock_sock+73>:    movl   $0x0,0x28(%esp,1)
0xc01ddae1 <__lock_sock+81>:    lea    0x1c(%esp,1),%esi
0xc01ddae5 <__lock_sock+85>:    lea    0x34(%edi),%eax
0xc01ddae8 <__lock_sock+88>:    mov    %esi,%edx
0xc01ddaea <__lock_sock+90>:    call   0xc0110598
<add_wait_queue_exclusive>
0xc01ddaef <__lock_sock+95>:    nop    
0xc01ddaf0 <__lock_sock+96>:    movl   $0x2,(%ebx)
0xc01ddaf6 <__lock_sock+102>:   decl   0xc02f75ec
0xc01ddafc <__lock_sock+108>:   call   0xc010f71c <schedule> 
*****************
0xc01ddb01 <__lock_sock+113>:   incl   0xc02f75ec
0xc01ddb07 <__lock_sock+119>:   cmpl   $0x0,0x30(%edi)
0xc01ddb0b <__lock_sock+123>:   jne    0xc01ddaf0 <__lock_sock+96>

-----
0xc01a315c <pppoe_backlog_rcv>: push   %esi
0xc01a315d <pppoe_backlog_rcv+1>:       push   %ebx
0xc01a315e <pppoe_backlog_rcv+2>:       mov    0xc(%esp,1),%ebx
0xc01a3162 <pppoe_backlog_rcv+6>:       incl   0xc02f75ec
0xc01a3168 <pppoe_backlog_rcv+12>:      cmpl   $0x0,0x30(%ebx)
0xc01a316c <pppoe_backlog_rcv+16>:
    je     0xc01a3177 <pppoe_backlog_rcv+27>
0xc01a316e <pppoe_backlog_rcv+18>:      push   %ebx
0xc01a316f <pppoe_backlog_rcv+19>:      call   0xc01dda90
<__lock_sock>   ************
0xc01a3174 <pppoe_backlog_rcv+24>:      add    $0x4,%esp
0xc01a3177 <pppoe_backlog_rcv+27>:      movl   $0x1,0x30(%ebx)
0xc01a317e <pppoe_backlog_rcv+34>:      decl   0xc02f75ec
0xc01a3184 <pppoe_backlog_rcv+40>:      mov    0x10(%esp,1),%eax
--------
0xc01ddb2c <__release_sock>:    push   %esi
0xc01ddb2d <__release_sock+1>:  push   %ebx
0xc01ddb2e <__release_sock+2>:  mov    0xc(%esp,1),%esi
0xc01ddb32 <__release_sock+6>:  mov    0xb8(%esi),%eax
0xc01ddb38 <__release_sock+12>: movl   $0x0,0xbc(%esi)
0xc01ddb42 <__release_sock+22>: movl   $0x0,0xb8(%esi)
0xc01ddb4c <__release_sock+32>: lea    0x0(%esi,1),%esi
0xc01ddb50 <__release_sock+36>: mov    (%eax),%ebx
0xc01ddb52 <__release_sock+38>: movl   $0x0,(%eax)
0xc01ddb58 <__release_sock+44>: push   %eax
0xc01ddb59 <__release_sock+45>: push   %esi
0xc01ddb5a <__release_sock+46>: mov    0x31c(%esi),%eax
0xc01ddb60 <__release_sock+52>: call   *%eax		********************
0xc01ddb62 <__release_sock+54>: mov    %ebx,%eax
0xc01ddb64 <__release_sock+56>: add    $0x8,%esp
0xc01ddb67 <__release_sock+59>: test   %eax,%eax


int pppoe_backlog_rcv(struct sock *sk, struct sk_buff *skb)
{
        lock_sock(sk);
        pppoe_rcv_core(sk, skb);
        release_sock(sk);
        return 0;
}


What else should I check? How can we fix it?
PPPoE is more and more frequently used nowadays because of ADSL
services. I think this can effect its stability (guess which direction
;-)
even with one session (though probably not that bad as with many
sessions).
 
Have a nice week:
	Cell

-- 
Alice? WTFIA?
