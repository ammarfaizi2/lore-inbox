Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129947AbQKFR3f>; Mon, 6 Nov 2000 12:29:35 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129944AbQKFR30>; Mon, 6 Nov 2000 12:29:26 -0500
Received: from 177-ZARA-X54.libre.retevision.es ([62.82.247.177]:60432 "EHLO
	head.redvip.net") by vger.kernel.org with ESMTP id <S129945AbQKFR3P>;
	Mon, 6 Nov 2000 12:29:15 -0500
Message-ID: <3A069762.CBF6272B@zaralinux.com>
Date: Mon, 06 Nov 2000 12:34:58 +0100
From: Jorge Nerin <comandante@zaralinux.com>
X-Mailer: Mozilla 4.76 [en] (X11; U; Linux 2.4.0-test10-ne2k i586)
X-Accept-Language: es-ES, es, en
MIME-Version: 1.0
To: Andrew Morton <andrewm@uow.edu.au>
CC: Paul Gortmaker <p_gortmaker@yahoo.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux SMP Mailing List <linux-smp@vger.kernel.org>
Subject: Re: [patch] NE2000
In-Reply-To: <E13pz9c-0006Jh-00@the-village.bc.nu> <39FD5433.587FF7C6@zaralinux.com> <39FFE612.2688A5AD@yahoo.com> <3A02F9AA.AFB2DB1B@zaralinux.com> <3A039E77.5DD87DF0@uow.edu.au>
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Andrew Morton wrote:
> 
> Jorge Nerin wrote:
> >
> > ...
> > So I think that it could be a little window near sock_wait_for_wmem that
> > could be SMP insecure wich is affecting me.
> >
> > The code of sock_wait_for_wmem in 2.4.0-test10 is this:
> >
> > static long sock_wait_for_wmem(struct sock * sk, long timeo)
> > {
> >         DECLARE_WAITQUEUE(wait, current);
> >
> >         clear_bit(SOCK_ASYNC_NOSPACE, &sk->socket->flags);
> >         add_wait_queue(sk->sleep, &wait);
> >         for (;;) {
> >                 if (signal_pending(current))
> >                         break;
> >                 set_bit(SOCK_NOSPACE, &sk->socket->flags);
> >                 set_current_state(TASK_INTERRUPTIBLE);
> >                 if (atomic_read(&sk->wmem_alloc) < sk->sndbuf)
> >                         break;
> >                 if (sk->shutdown & SEND_SHUTDOWN)
> >                         break;
> >                 if (sk->err)
> >                         break;
> >                 timeo = schedule_timeout(timeo);
> >         }
> >         __set_current_state(TASK_RUNNING);
> >         remove_wait_queue(sk->sleep, &wait);
> >         return timeo;
> > }
> >
> > Does someone see something SMP insecure? Perhaps I'm totally wrong, this
> > could also be somewhere in the interrupt handling, don't know.
> 
> No, that code is correct, provided (current->state == TASK_RUNNING)
> on entry.  If it isn't, there's a race window which can cause
> lost wakeups.   As a check you could add:
> 
>         if ((current->state & (TASK_INTERRUPTIBLE|TASK_UNINTERRUPTIBLE)) == 0)
>                 BUG();
> 
> to the start of this function.

OK, added, the function now looks like this:

static long sock_wait_for_wmem(struct sock * sk, long timeo)
{
        DECLARE_WAITQUEUE(wait, current);

        if ((current->state & (TASK_INTERRUPTIBLE|TASK_UNINTERRUPTIBLE))
== 0)
                BUG();

        clear_bit(SOCK_ASYNC_NOSPACE, &sk->socket->flags);
        add_wait_queue(sk->sleep, &wait);
        for (;;) {
                if (signal_pending(current))
                        break;
                set_bit(SOCK_NOSPACE, &sk->socket->flags);
                set_current_state(TASK_INTERRUPTIBLE);
                if (atomic_read(&sk->wmem_alloc) < sk->sndbuf)
                        break;
                if (sk->shutdown & SEND_SHUTDOWN)
                        break;
                if (sk->err)
                        break;
                timeo = schedule_timeout(timeo);
        }
        __set_current_state(TASK_RUNNING);
        remove_wait_queue(sk->sleep, &wait);
        return timeo;
}

I have to put it _after_ DECLARE_WAITQUEUE in order to compile, if I put
it before it says me that wait is undeclared :-?

Well recompile, reboot, and got caugth by BUG(), after some tests.

[root@quartz ~]# ping -f -s 15000 pp_head
PING pp_head.pp.redvip.net (192.168.1.20) from 192.168.1.3 :
15000(15028) bytes of data.
..............invalid operand: 0000
CPU:    0
EIP:    0010:[<c0195b30>]
EFLAGS: 00010296
eax: 0000001a   ebx: c2604000   ecx: c021e2e8   edx: c0266440
esi: c26eeba0   edi: c26eeba0   ebp: 7fffffff   esp: c2605c88
ds: 0018   es: 0018   ss: 0018
Process ping (pid: 2202, stackpage=c2605000)
Stack: c02047a5 c02049eb 000002d2 7fffffff c26eeba0 c2604000 00000000
c26c4024
       01234567 c2604000 00000000 00000000 01234567 c2604000 00000000
00000000
       c0195c99 c26eeba0 7fffffff c26c4024 c264d0c0 c26c4010 000005dc
00000000
Call Trace: [<c02047a5>] [<c02049eb>] [<c0195c99>] [<c01aa692>]
[<c01aaa1e>] [<c01c0180>] [<c01c04de>]
       [<c01c0180>] [<c01c6f48>] [<c01c6f86>] [<c0192fad>] [<c01c6f48>]
[<c01941b8>] [<c0193ee6>] [<c0165c9a>]
       [<c016e602>] [<c01945fc>] [<c0109477>]
Code: 0f 0b 83 c4 0c 8b 87 50 03 00 00 f0 0f ba 70 04 00 8d 4c 24
Violación de segmento
[root@quartz ~]#


Nov  6 12:00:07 quartz kernel: kernel BUG at sock.c:722!
Nov  6 12:00:07 quartz kernel: invalid operand: 0000
Nov  6 12:00:07 quartz kernel: CPU:    0
Nov  6 12:00:07 quartz kernel: EIP:    0010:[sock_wait_for_wmem+104/244]
Nov  6 12:00:07 quartz kernel: EFLAGS: 00010296
Nov  6 12:00:07 quartz kernel: eax: 0000001a   ebx: c2604000   ecx:
c021e2e8   edx: c0266440
Nov  6 12:00:07 quartz kernel: esi: c26eeba0   edi: c26eeba0   ebp:
7fffffff   esp: c2605c88
Nov  6 12:00:07 quartz kernel: ds: 0018   es: 0018   ss: 0018
Nov  6 12:00:07 quartz kernel: Process ping (pid: 2202,
stackpage=c2605000)
Nov  6 12:00:07 quartz kernel: Stack: c02047a5 c02049eb 000002d2
7fffffff c26eeba0 c2604000 00000000 c26c4024
Nov  6 12:00:07 quartz kernel:        01234567 c2604000 00000000
00000000 01234567 c2604000 00000000 00000000
Nov  6 12:00:07 quartz kernel:        c0195c99 c26eeba0 7fffffff
c26c4024 c264d0c0 c26c4010 000005dc 00000000
Nov  6 12:00:07 quartz kernel: Call Trace: [vga_con+2501/10176]
[vga_con+3083/10176] [sock_alloc_send_skb+221/300]
[ip_build_xmit_slow+378/1208] [ip_build_xmit+78/816] [raw_getfrag+0/36]
[raw_sendmsg+642/752]
Nov  6 12:00:07 quartz kernel:        [raw_getfrag+0/36]
[inet_sendmsg+0/68] [inet_sendmsg+62/68] [sock_sendmsg+129/164]
[inet_sendmsg+0/68] [sys_sendmsg+380/464] [sys_recvfrom+238/256]
[set_cursor+110/132]
Nov  6 12:00:07 quartz kernel:        [write_chan+462/488]
[sys_socketcall+460/484] [system_call+55/64]
Nov  6 12:00:07 quartz kernel: Code: 0f 0b 83 c4 0c 8b 87 50 03 00 00 f0
0f ba 70 04 00 8d 4c 24

Nov  6 12:06:11 quartz kernel: kernel BUG at sock.c:722!
Nov  6 12:06:11 quartz kernel: invalid operand: 0000
Nov  6 12:06:11 quartz kernel: CPU:    1
Nov  6 12:06:11 quartz kernel: EIP:    0010:[sock_wait_for_wmem+104/244]
Nov  6 12:06:11 quartz kernel: EFLAGS: 00010296
Nov  6 12:06:11 quartz kernel: eax: 0000001a   ebx: c1f54000   ecx:
c021e2e8   edx: c0266440
Nov  6 12:06:11 quartz kernel: esi: c3cd6100   edi: c3cd6100   ebp:
7fffffff   esp: c1f55c88
Nov  6 12:06:11 quartz kernel: ds: 0018   es: 0018   ss: 0018
Nov  6 12:06:11 quartz kernel: Process ping (pid: 2993,
stackpage=c1f55000)
Nov  6 12:06:11 quartz kernel: Stack: c02047a5 c02049eb 000002d2
7fffffff c3cd6100 c1f54000 00000000 c2648824
Nov  6 12:06:11 quartz kernel:        01234567 c1f54000 00000000
00000000 01234567 c1f54000 00000000 00000000
Nov  6 12:06:11 quartz kernel:        c0195c99 c3cd6100 7fffffff
c2648824 c260c2c0 c2648810 000005dc 00000000
Nov  6 12:06:11 quartz kernel: Call Trace: [vga_con+2501/10176]
[vga_con+3083/10176] [sock_alloc_send_skb+221/300]
[ip_build_xmit_slow+378/1208] [ip_build_xmit+78/816] [raw_getfrag+0/36]
[raw_sendmsg+642/752]
Nov  6 12:06:11 quartz kernel:        [raw_getfrag+0/36]
[inet_sendmsg+0/68] [inet_sendmsg+62/68] [sock_sendmsg+129/164]
[inet_sendmsg+0/68] [sys_sendmsg+380/464] [sys_recvfrom+238/256]
[set_cursor+110/132]
Nov  6 12:06:11 quartz kernel:        [write_chan+462/488]
[sys_socketcall+460/484] [system_call+55/64]
Nov  6 12:06:11 quartz kernel: Code: 0f 0b 83 c4 0c 8b 87 50 03 00 00 f0
0f ba 70 04 00 8d 4c 24
Nov  6 12:06:11 quartz kernel: NET: 6 messages suppressed.
Nov  6 12:06:11 quartz kernel: NAT: 0 dropping untracked packet c26984a0
1 192.168.1.20 -> 192.168.1.3
Nov  6 12:06:11 quartz kernel: NAT: 0 dropping untracked packet c2828a80
1 192.168.1.20 -> 192.168.1.3
Nov  6 12:06:11 quartz kernel: NAT: 0 dropping untracked packet c265d560
1 192.168.1.20 -> 192.168.1.3
Nov  6 12:06:11 quartz kernel: NAT: 0 dropping untracked packet c2828a80
1 192.168.1.20 -> 192.168.1.3
Nov  6 12:06:11 quartz kernel: NAT: 0 dropping untracked packet c53bc820
1 192.168.1.20 -> 192.168.1.3
Nov  6 12:06:11 quartz kernel: NAT: 0 dropping untracked packet c264d780
1 192.168.1.20 -> 192.168.1.3
Nov  6 12:06:41 quartz kernel: kernel BUG at sock.c:722!
Nov  6 12:06:41 quartz kernel: invalid operand: 0000
Nov  6 12:06:41 quartz kernel: CPU:    1
Nov  6 12:06:41 quartz kernel: EIP:    0010:[sock_wait_for_wmem+104/244]
Nov  6 12:06:41 quartz kernel: EFLAGS: 00010296
Nov  6 12:06:41 quartz kernel: eax: 0000001a   ebx: c1f54000   ecx:
c021e2e8   edx: c0266440
Nov  6 12:06:41 quartz kernel: esi: c3cd6800   edi: c3cd6800   ebp:
7fffffff   esp: c1f55c88
Nov  6 12:06:41 quartz kernel: ds: 0018   es: 0018   ss: 0018
Nov  6 12:06:41 quartz kernel: Process ping (pid: 2994,
stackpage=c1f55000)
Nov  6 12:06:41 quartz kernel: Stack: c02047a5 c02049eb 000002d2
7fffffff c3cd6800 c1f54000 00000000 c2644824
Nov  6 12:06:41 quartz kernel:        01234567 c1f54000 00000000
00000000 01234567 c1f54000 00000000 00000000
Nov  6 12:06:41 quartz kernel:        c0195c99 c3cd6800 7fffffff
c2644824 c5b8be60 c2644810 000005dc 00000000
Nov  6 12:06:41 quartz kernel: Call Trace: [vga_con+2501/10176]
[vga_con+3083/10176] [sock_alloc_send_skb+221/300]
[ip_build_xmit_slow+378/1208] [ip_build_xmit+78/816] [raw_getfrag+0/36]
[raw_sendmsg+642/752]
Nov  6 12:06:41 quartz kernel:        [raw_getfrag+0/36]
[inet_sendmsg+0/68] [inet_sendmsg+62/68] [sock_sendmsg+129/164]
[inet_sendmsg+0/68] [sys_sendmsg+380/464] [sys_recvfrom+238/256]
[kfree_skbmem+40/140]
Nov  6 12:06:41 quartz kernel:        [__kfree_skb+369/376]
[nfsd:__insmod_nfsd_O/lib/modules/2.4.0-test10-ne2k/kernel/fs/nfs+-289558/96]
[nfsd:__insmod_nfsd_O/lib/modules/2.4.0-test10-ne2k/kernel/fs/nfs+-288860/96]
[qdisc_restart+108/376] [net_tx_action+194/300] [sys_socketcall+460/484]
[system_call+55/64]
Nov  6 12:06:41 quartz kernel: Code: 0f 0b 83 c4 0c 8b 87 50 03 00 00 f0
0f ba 70 04 00 8d 4c 24

Sorry, I can't pass it througth ksymoops because it doesn't work for me
in later kernels (RH 6.9.5) it says Fatal Error (re_compile) - Invalid
range end, and I have recompiled it. So I have to give you the results
of sysklogd.

As a side note I have to say that after those BUG the net is still
working, and I have those rules added in init scripts:
        modprobe -k ip_tables
        modprobe -k iptable_nat
        insmod -k ipt_MASQUERADE 
        iptables -t nat -A POSTROUTING -o ppp+ -j MASQUERADE
        iptables -A FORWARD -i ppp+ -m state --state RELATED,ESTABLISHED
-j ACCEPT
        iptables -A FORWARD -o ppp+ -j ACCEPT
        echo 0 >/proc/sys/net/ipv4/tcp_ecn
Under heavy packet load in these tests I see that NAT messages about
dropped packets.

More tests as requested.

-- 
Jorge Nerin
<comandante@zaralinux.com>
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
