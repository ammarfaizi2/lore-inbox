Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S266333AbRGBBFE>; Sun, 1 Jul 2001 21:05:04 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S266332AbRGBBEp>; Sun, 1 Jul 2001 21:04:45 -0400
Received: from [32.97.182.101] ([32.97.182.101]:52395 "EHLO e1.ny.us.ibm.com")
	by vger.kernel.org with ESMTP id <S266331AbRGBBEh>;
	Sun, 1 Jul 2001 21:04:37 -0400
Importance: Normal
Subject: bug in __tcp_inherit_port ?
To: alan@redhat.com, mingo@redhat.com
Cc: linux-kernel@vger.kernel.org
X-Mailer: Lotus Notes Release 5.0.3 (Intl) 21 March 2000
Message-ID: <OF9402B4AA.69A14578-ON85256A7D.00020781@pok.ibm.com>
From: "Bulent Abali" <abali@us.ibm.com>
Date: Sun, 1 Jul 2001 21:00:44 -0400
X-MIMETrack: Serialize by Router on D01ML233/01/M/IBM(Release 5.0.8 |June 18, 2001) at
 07/01/2001 09:04:10 PM
MIME-Version: 1.0
Content-type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


I get an occasional panic in __tcp_inherit_port(sk,child).  I believe the
reason is tb=sk->prev is NULL.

sk->prev is set to NULL in only few places including __tcp_put_port(sk).
Perhaps there is a serialization problem between __tcp_inherit_port and
__tcp_put_port ???   One possibility is that sk->num != child->num.
Therefore spin_locks in the two routines do not serialize.

This code is out of my league so I couldn't debug any further.  Ingo, this
is the same problem that I posted to linux-kernel couple weeks ago for
tcp_v4_syn_recv_sock.

Problem occurs when running TUX-B6, 2.4.5-ac4 with SPECweb99, dual PIII,
and one acenic adapter.   It is difficult to trigger but did occur few
times so far.   In the following are the oops and objdump
/bulent.

=========

/* Caller must disable local BH processing. */
static __inline__ void __tcp_inherit_port(struct sock *sk, struct sock
*child)
{
     struct tcp_bind_hashbucket *head =
&tcp_bhash[tcp_bhashfn(child->num)];
     struct tcp_bind_bucket *tb;

     spin_lock(&head->lock);
     tb = (struct tcp_bind_bucket *)sk->prev;   <** line 149
     if ((child->bind_next = tb->owners) != NULL) <** panic here
          tb->owners->bind_pprev = &child->bind_next;
     tb->owners = child;
     child->bind_pprev = &tb->owners;
     child->prev = (struct sock *) tb;
     spin_unlock(&head->lock);
}


__inline__ void __tcp_put_port(struct sock *sk)
{
     struct tcp_bind_hashbucket *head = &tcp_bhash[tcp_bhashfn(sk->num)];
     struct tcp_bind_bucket *tb;

     spin_lock(&head->lock);
     tb = (struct tcp_bind_bucket *) sk->prev;
     if (sk->bind_next)
          sk->bind_next->bind_pprev = sk->bind_pprev;
     *(sk->bind_pprev) = sk->bind_next;
     sk->prev = NULL;
     sk->num = 0;
     if (tb->owners == NULL) {
          if (tb->next)
               tb->next->pprev = tb->pprev;
          *(tb->pprev) = tb->next;
          kmem_cache_free(tcp_bucket_cachep, tb);
     }
     spin_unlock(&head->lock);
}


====
oops output

NULL pointer dereference at virtual address 00000008
 printing eip:
c0247a34
*pde = 00000000
Oops: 0000
CPU:    0
EIP:    0010:[<c0247a34>]
EFLAGS: 00010246
eax: 00000000   ebx: f74224c0   ecx: 00000000   edx: f74224c0
esi: f7500000   edi: f71e6cf0   ebp: f74225b4   esp: c0313c00
ds: 0018   es: 0018   ss: 0018
Process swapper (pid: 0, stackpage=c0313000)
Stack: f2a55ec4 f2d6bf64 459d1162 f74224c0 c024aff9 f74224c0 f2a55ec4
f2d6bf64
       00000000 459d1163 459d1162 459d1163 00000000 00001000 f74225b4
f740f58c
       f7760c00 c022a3c5 f740f58c c0231e76 e11d2a9c f7760cd8 f740083c
00000000
Call Trace: [<c024aff9>] [<c022a3c5>] [<c0231e76>] [<c01bff2c>]
[<f8805514>]
   [<c02ac6b0>] [<f8805000>] [<c0231e76>] [<c022a3c5>] [<c0231e76>]
[<c0224962>]
   [<c0231e76>] [<c0220f5c>] [<c02210a8>] [<c02321e4>] [<c02444ff>]
[<c0220f5c>]
   [<c02210a8>] [<c023d85c>] [<c023db31>] [<c0220f5c>] [<c02210a8>]
[<c0247b1c>]
   [<c0247e4b>] [<c024833f>] [<c022f5b8>] [<c022f955>] [<c01bf55a>]
[<c02251bb>]
   [<c0224eb2>] [<c0108d7e>] [<c0120e5b>] [<c0109189>] [<c0105220>]
[<c0105220>]
   [<c0107544>] [<c0105220>] [<c0105220>] [<c010524d>] [<c01052d2>]
[<c0105000>]
   [<c01001cf>]

Code: 8b 41 08 89 43 18 85 c0 74 09 8b 51 08 8d 43 18 89 42 1c 89
 <0>Kernel panic: Aiee, killing interrupt handler!
In interrupt handler - not syncing

====
ksymoops output

Code;  c0247a34 <tcp_v4_syn_recv_sock+284/330>
00000000 <_EIP>:
Code;  c0247a34 <tcp_v4_syn_recv_sock+284/330>
   0:   8b 41 08                  mov    0x8(%ecx),%eax  //panics in
child->bind_next=tb->owners
Code;  c0247a37 <tcp_v4_syn_recv_sock+287/330>
   3:   89 43 18                  mov    %eax,0x18(%ebx)
Code;  c0247a3a <tcp_v4_syn_recv_sock+28a/330>
   6:   85 c0                     test   %eax,%eax
Code;  c0247a3c <tcp_v4_syn_recv_sock+28c/330>
   8:   74 09                     je     13 <_EIP+0x13> c0247a47
<tcp_v4_syn_recv_sock+297/330>
Code;  c0247a3e <tcp_v4_syn_recv_sock+28e/330>
   a:   8b 51 08                  mov    0x8(%ecx),%edx
Code;  c0247a41 <tcp_v4_syn_recv_sock+291/330>
   d:   8d 43 18                  lea    0x18(%ebx),%eax
Code;  c0247a44 <tcp_v4_syn_recv_sock+294/330>
  10:   89 42 1c                  mov    %eax,0x1c(%edx)
Code;  c0247a47 <tcp_v4_syn_recv_sock+297/330>
  13:   89 00                     mov    %eax,(%eax)


====
objdump -S

/usr/src/linux-2.4.5-ac4/include/asm/spinlock.h:104
c0247a21:       f0 fe 0e                 lock decb (%esi)
c0247a24:       0f 88 85 79 03 00        js     c027f3af
<stext_lock+0x5c6f>
/usr/src/linux-2.4.5-ac4/net/ipv4/tcp_ipv4.c:149
c0247a2a:       8b 54 24 14              mov    0x14(%esp,1),%edx
c0247a2e:       8b 8a a4 00 00 00        mov    0xa4(%edx),%ecx   //tb =
sk->prev
/usr/src/linux-2.4.5-ac4/net/ipv4/tcp_ipv4.c:150
c0247a34:       8b 41 08                 mov    0x8(%ecx),%eax //
child->bind_next=tb->owners
c0247a37:       89 43 18                 mov    %eax,0x18(%ebx)
c0247a3a:       85 c0                    test   %eax,%eax
c0247a3c:       74 09                    je     c0247a47
<tcp_v4_syn_recv_sock+0x297>
/usr/src/linux-2.4.5-ac4/net/ipv4/tcp_ipv4.c:151
c0247a3e:       8b 51 08                 mov    0x8(%ecx),%edx
c0247a41:       8d 43 18                 lea    0x18(%ebx),%eax
c0247a44:       89 42 1c                 mov    %eax,0x1c(%edx)
/usr/src/linux-2.4.5-ac4/net/ipv4/tcp_ipv4.c:152
c0247a47:       89 59 08                 mov    %ebx,0x8(%ecx)
/usr/src/linux-2.4.5-ac4/net/ipv4/tcp_ipv4.c:153
c0247a4a:       8d 41 08                 lea    0x8(%ecx),%eax
c0247a4d:       89 43 1c                 mov    %eax,0x1c(%ebx)


