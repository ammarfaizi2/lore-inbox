Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S291393AbSBMGFt>; Wed, 13 Feb 2002 01:05:49 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S291397AbSBMGFl>; Wed, 13 Feb 2002 01:05:41 -0500
Received: from web12305.mail.yahoo.com ([216.136.173.103]:50696 "HELO
	web12305.mail.yahoo.com") by vger.kernel.org with SMTP
	id <S291393AbSBMGFa>; Wed, 13 Feb 2002 01:05:30 -0500
Message-ID: <20020213060529.91301.qmail@web12305.mail.yahoo.com>
Date: Tue, 12 Feb 2002 22:05:29 -0800 (PST)
From: Raghu Angadi <raghuangadi@yahoo.com>
Subject: memory corruption in tcp bind hash buckets on SMP? 
To: linux-kernel@vger.kernel.org
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

We are seeing kernel crashes which seem to be caused because of some
of the members in tcp_bind_bucket object get corrupt. These crashes
seem to happen unpredictabily with network activity (need not always
be heavy laod).

Kernel: 2.4.7-10 SMP (RedHat 7.2) on Dual PIIIs. We kind of have to
work with Redhat kernels. Also I searched the list and did not find
any relevant info to think this bug was observed or fixed in later
kernels. Any insights or suggestions as how to fix it are most welcome.
We have seen crashes at two places:

oops 1 (added below) happens here:
---------
  net/ipv4/tcp_minisocks.c:__tcp_tw_hashdance():

        bhead = &tcp_bhash[tcp_bhashfn(sk->num)];
        spin_lock(&bhead->lock);
        tw->tb = (struct tcp_bind_bucket *)sk->prev;
        BUG_TRAP(sk->prev!=NULL);
        if ((tw->bind_next = tw->tb->owners) != NULL)
===>         tw->tb->owners->bind_pprev = &tw->bind_next; 
	   	     ^^^^^^ (owners is NULL _after_ the above if() succedes)
        tw->tb->owners = (struct sock*)tw;
        tw->bind_pprev = &tw->tb->owners;
        spin_unlock(&bhead->lock);

oops 2 (added below) happens here:
----------

  net/ipv4/tcp_ipv4.c:tcp_v4_get_port():

      if (tb != NULL && tb->owners != NULL) {
         if (tb->fastreuse != 0 && sk->reuse != 0 && sk->state != TCP_LISTEN)
{
                goto success;
         } else {
               struct sock *sk2 = tb->owners;
               int sk_reuse = sk->reuse;

               for( ; sk2 != NULL; sk2 = sk2->bind_next) {
                       if (sk != sk2 &&
======>                    sk->bound_dev_if == sk2->bound_dev_if) {
					       ^^^ sk2 is 0x1	
                               if (!sk_reuse   ||
                                   !sk2->reuse ||
                                   sk2->state == TCP_LISTEN) {

OOPS 1:
-------
pde = 00000000
Oops: 0002
CPU:    1
EIP:    0010:[<c01f77db>]
EFLAGS: 00010282
eax: f01edc38  ebx: f01edc20  ecx: f6ebf0d8  edx: 00000000
esi: e8b86a40  edi: f7271ce0  ebp: f6ebf0dc  esp: c5339d1c
ds: 0018  es: 0018  ss: 0018
Process Swapper (pid: 0, stackpage = c5339000)

Stack: f01edc20 e8b86b78 e8b86a40 00000066 c01f7967 e8b86a40 f01edc20
00000000
       e8b86b78 00000000 00000102 00000001 c01eb938 e8b86a40 00000001
9caca04c
       e2fe1ed7 e8b86b78 e8b86a40 ed86f042 c01eef9d e8b86a40 00000005
00001770
       
Call Trace: [<c01f7967>] [<c01eb938>] [<c01eef9d>] [<c01c9c84>] [<c01f5a01>] 
  [<c01f584b>] [<c01f5e3d>] [<c01ddfd0>] [<c01dd9db>] [<c01de1a4>]
[<c01ddfd0>] 
  [<c01d3363>] [<c01ddfd0>] [<c01d339a>] [<c01dde16>] [<c01ddfd0>]
[<c01cd0eb>] 
  [<c011efbb>] [<c0108c1d>] [<c0105410>] [<c0105410>] [<c02285d8>]
[<c0105410>] 
  [<c0105410>] [<c010543d>] [<c01054c2>] [<c011ad76>] [<c011aeeb>] 

Code: 89 42 1c 8b 43 4c 89 58 08 8b 43 4c 83 c0 08 89 43 1c c6 07
  <0> Kernel panic: Aiee, Killing interrupt handler!
In interrupt handler - not syncing

>>EIP; c01f77db <__tcp_tw_hashdance+eb/110> <=====
Trace; c01f7967 <tcp_time_wait+167/270>
Trace; c01eb938 <tcp_ack+138/310>
Trace; c01eef9d <tcp_rcv_state_process+72d/a00>
Trace; c01c9c84 <skb_checksum+54/320>
Trace; c01f5a01 <tcp_v4_do_rcv+131/180>
Trace; c01f584b <tcp_v4_checksum_init+6b/f0>
Trace; c01f5e3d <tcp_v4_rcv+3ed/660>
Trace; c01ddfd0 <ip_rcv_finish+0/220>
Trace; c01dd9db <ip_local_deliver+12b/1c0>
Trace; c01de1a4 <ip_rcv_finish+1d4/220>
Trace; c01ddfd0 <ip_rcv_finish+0/220>
Trace; c01d3363 <nf_hook_slow+d3/180>
Trace; c01ddfd0 <ip_rcv_finish+0/220>
Trace; c01d339a <nf_hook_slow+10a/180>
Trace; c01dde16 <ip_rcv+3a6/3f0>
Trace; c01ddfd0 <ip_rcv_finish+0/220>
Trace; c01cd0eb <net_rx_action+1eb/300>
Trace; c011efbb <do_softirq+7b/e0>
Trace; c0108c1d <do_IRQ+dd/f0>
Trace; c0105410 <default_idle+0/40>
Trace; c0105410 <default_idle+0/40>
Trace; c02285d8 <call_do_IRQ+5/d>
Trace; c0105410 <default_idle+0/40>
Trace; c0105410 <default_idle+0/40>
Trace; c010543d <default_idle+2d/40>
Trace; c01054c2 <cpu_idle+52/70>
Trace; c011ad76 <__call_console_drivers+46/60>
Trace; c011aeeb <call_console_drivers+eb/100>
Code;  c01f77db <__tcp_tw_hashdance+eb/110>
00000000 <_EIP>:
Code;  c01f77db <__tcp_tw_hashdance+eb/110> <=====
   0:   89 42 1c                  mov    %eax,0x1c(%edx)   <=====
Code;  c01f77de <__tcp_tw_hashdance+ee/110>
3:   8b 43 4c                  mov    0x4c(%ebx),%eax
Code;  c01f77e1 <__tcp_tw_hashdance+f1/110>
6:   89 58 08                  mov    %ebx,0x8(%eax)
Code;  c01f77e4 <__tcp_tw_hashdance+f4/110>
9:   8b 43 4c                  mov    0x4c(%ebx),%eax
Code;  c01f77e7 <__tcp_tw_hashdance+f7/110>
c:   83 c0 08                  add    $0x8,%eax
Code;  c01f77ea <__tcp_tw_hashdance+fa/110>
f:   89 43 1c                  mov    %eax,0x1c(%ebx)
Code;  c01f77ed <__tcp_tw_hashdance+fd/110>
12:   c6 07 00                  movb   $0x0,(%edi)

  <0> Kernel panic: Aiee, Killing interrupt handler!

11 warnings and 5 errors issued.  Results may not be reliable.


OOPS 2:
-------
ts-lnx16 login: Unable to handle Kernel Null pointer dereference at virtual
address 0000000d
*pde = 00000000
Oops: 0
CPU: 0
EIP: 0010: [<c01f343d>]
Using defaults from ksymoops -t elf32-i386 -a i386
EFLAGS: 00010292
eax: 00000004 ebx: cff945c0 ecx: db635580 edx: 00000001
esi: 00001f90 edi: 00000001 ebp: db635580 esp: d12afeb4
ds: 0018 es: 0018 ss: 0018
Process traffic_manager (pid: 25128, stackpage=d12af000)
Stack: 00000000 c18cfc80 db635580 d12ae000 00000000 00001f90 c01ffc9d
db635580
       00001f90 ffffffea d0c41a64 d12aff00 00000010 bfffe550 c01c617f
d0c41a64
       d12aaf00 00000010 00000000 901f0002 00000000 00000000 00000000
00000000
Call trace:
[<c01ffc9d>][<c01c617f>][<c01ff2f0>][<c01ffaaa>][<c01c5f63>][<c0150905>][<c01c66f5>][<c01c6715>][<c01c6c6c>][<c014c0cd>][<c010716d>]
Code: 8b 42 0c 8b 4c 24 1c 39 41 0c 75 e7 85 ff 74 0e 80 7a 26 00

>>EIP; c01f343d <tcp_v4_get_port+14d/290>   <=====
Trace; c01ffc9d <inet_bind+17d/290>
Trace; c01c617f <sys_bind+4f/70>
Trace; c01ff2f0 <inet_sock_destruct+0/180>
Trace; c01ffaaa <inet_create+23a/260>
Trace; c01c5f63 <sock_create+f3/120>
Trace; c0150905 <dput+35/180>
Trace; c01c66f5 <sys_setsockopt+45/70>
Trace; c01c6715 <sys_setsockopt+65/70>
Trace; c01c6c6c <sys_socketcall+7c/200>
Trace; c014c0cd <sys_fcntl64+8d/a0>
Trace; c010716d <system_call+35/38>
Code;  c01f343d <tcp_v4_get_port+14d/290>
00000000 <_EIP>:
Code;  c01f343d <tcp_v4_get_port+14d/290>   <=====
   0:   8b 42 0c                  mov    0xc(%edx),%eax   <=====
Code;  c01f3440 <tcp_v4_get_port+150/290>
   3:   8b 4c 24 1c               mov    0x1c(%esp,1),%ecx
Code;  c01f3444 <tcp_v4_get_port+154/290>
   7:   39 41 0c                  cmp    %eax,0xc(%ecx)
Code;  c01f3447 <tcp_v4_get_port+157/290>
   a:   75 e7                     jne    fffffff3 <_EIP+0xfffffff3> c01f3430
<tcp_v4_get_port+140/290>
Code;  c01f3449 <tcp_v4_get_port+159/290>
   c:   85 ff                     test   %edi,%edi
Code;  c01f344b <tcp_v4_get_port+15b/290>
   e:   74 0e                     je     1e <_EIP+0x1e> c01f345b
<tcp_v4_get_port+16b/290>
Code;  c01f344d <tcp_v4_get_port+15d/290>
  10:   80 7a 26 00               cmpb   $0x0,0x26(%edx)

 <0>Kernel Panic: Aiee, killing interrupt handler!

Thanks,
Raghu

__________________________________________________
Do You Yahoo!?
Send FREE Valentine eCards with Yahoo! Greetings!
http://greetings.yahoo.com
