Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262906AbTCKLyA>; Tue, 11 Mar 2003 06:54:00 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262905AbTCKLyA>; Tue, 11 Mar 2003 06:54:00 -0500
Received: from inway106.cdi.cz ([213.151.81.106]:62393 "EHLO luxik.cdi.cz")
	by vger.kernel.org with ESMTP id <S262906AbTCKLx4>;
	Tue, 11 Mar 2003 06:53:56 -0500
Date: Tue, 11 Mar 2003 12:55:46 +0100 (CET)
From: devik <devik@cdi.cz>
X-X-Sender: <devik@devix>
To: bert hubert <ahu@ds9a.nl>
cc: Alexey Kuznetsov <kuznet@ms2.inr.ac.ru>,
       Linux Kernel Mailinlist <linux-kernel@vger.kernel.org>,
       David Jarvis <david@uninetwork.co.za>, <netdev@oss.sgi.com>
Subject: Re: kernel panic: bug in sch_sfq.c
In-Reply-To: <20030311094420.GB19658@outpost.ds9a.nl>
Message-ID: <Pine.LNX.4.33.0303111239440.498-100000@devix>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hmm,
I looked at it. It seems that skb linked list was corrupted
(containing NULL pointer). It could be because of two problems,
either someone (maybe htb too)'ve overwritten memory or HTB
called dequeue with wrong argument.
Latter is unlikely because I call q->dequeue and sfq's
dequeue was really called. Thus pointer is ok.
Let's examine how could HTB mungle with qdisc internals. If
htb would think that leaf is inner node, inner.feed[0] is
pointer equal to leaf.q. I examined code but there is no
way to make this mistake.

Last 3 days I got 3 bugreports. Each crashes in different
place and all seem unrelated. Each is NULL pointer dereference
though.
I think there is some place in some code which writes in
bad random places in memory :-\

To ask all people whose have seen such Oops, have you used
dynamic tc classes changes ? Like creating/deleting/changing/viewving
classes offten at runtime ? (I'm trying to find common trigger).

thanks,  devik
HTB maintainer

On Tue, 11 Mar 2003, bert hubert wrote:

> On Tue, Mar 11, 2003 at 11:14:09AM +0200, Abraham van der Merwe wrote:
> > Hi!
> >
> > I have a box that crashed today. Below is the decoded kernel panic. If you
> > track down the bug PLEASE send me a patch.
>
> Weird, Alexeys code is normally very very solid. Perhaps HTB is also
> involved. Devik?
>
> >
> > ------------< snip <------< snip <------< snip <------------
> > ksymoops 2.4.8 on i686 2.4.20-rc1.  Options used
> >      -v vmlinux-2.4.21-pre5 (specified)
> >      -K (specified)
> >      -L (specified)
> >      -O (specified)
> >      -m System.map-2.4.21-pre5 (specified)
> >
> > Unable to handle kernel NULL pointer dereference at virtual address 00000004
> > *pde = 00000000
> > Oops: 0002
> > CPU:    0
> > EIP:    0010:[<c01a5399>]    Not tainted
> > Using defaults from ksymoops -t elf32-i386 -a i386
> > EFLAGS: 00010202
> > eax: 00000000   ebx: c7b9a9e8   ecx: 0000007f   edx: c7a8eef8
> > esi: c7b9ab08   edi: 000007f0   ebp: c7a8e060   esp: c021deb8
> > ds: 0018   es: 0018   ss: 0018
> > Process swapper (pid: 0, stackpage=c021d000)
> > Stack: c7b9a9e8 c7b9ab08 c7f7ee00 c7b9a860 c7b893c0 c7f7ee00 c7b9a860 00000000
> >        c01a3507 c7b5c680 7fb9a9f0 c01a339e c7a8e000 ffffffff 00000018 00000006
> >        c7b9a800 00000018 00000006 c7b9a800 c7b9a9e8 c7b9ab08 c7f7ee00 c01a371c
> > Call Trace:    [<c01a3507>] [<c01a339e>] [<c01a371c>] [<c019f7a3>] [>c019949d>]
> >   [<c0115a6a>] [<c01082bd>] [<c0105240>] [<c0105240>] [<c010a528>] [<c0105240>]
> >   [<c0105240>] [<c0105263>] [<c01052d2>] [<c0105000>] [<c0105027>]
> > Code: 89 50 04 89 02 8b 5c 24 24 c7 03 00 00 00 00 c7 43 04 00 00
> >
> >
> > >>EIP; c01a5399 <sfq_dequeue+59/1b0>   <=====
> >
> > >>esp; c021deb8 <init_task_union+1eb8/2000>
> >
> > Trace; c01a3507 <htb_dequeue_tree+217/230>
> > Trace; c01a339e <htb_dequeue_tree+ae/230>
> > Trace; c01a371c <htb_dequeue+16c/250>
> > Trace; c019f7a3 <qdisc_restart+13/d0>
> > Trace; c0115a6a <do_softirq+5a/b0>
> > Trace; c01082bd <do_IRQ+9d/b0>
> > Trace; c0105240 <default_idle+0/30>
> > Trace; c0105240 <default_idle+0/30>
> > Trace; c010a528 <call_do_IRQ+5/d>
> > Trace; c0105240 <default_idle+0/30>
> > Trace; c0105240 <default_idle+0/30>
> > Trace; c0105263 <default_idle+23/30>
> > Trace; c01052d2 <cpu_idle+42/60>
> > Trace; c0105000 <_stext+0/0>
> > Trace; c0105027 <rest_init+27/30>
> >
> > Code;  c01a5399 <sfq_dequeue+59/1b0>
> > 00000000 <_EIP>:
> > Code;  c01a5399 <sfq_dequeue+59/1b0>   <=====
> >    0:   89 50 04                  mov    %edx,0x4(%eax)   <=====
> > Code;  c01a539c <sfq_dequeue+5c/1b0>
> >    3:   89 02                     mov    %eax,(%edx)
> > Code;  c01a539e <sfq_dequeue+5e/1b0>
> >    5:   8b 5c 24 24               mov    0x24(%esp,1),%ebx
> > Code;  c01a53a2 <sfq_dequeue+62/1b0>
> >    9:   c7 03 00 00 00 00         movl   $0x0,(%ebx)
> > Code;  c01a53a8 <sfq_dequeue+68/1b0>
> >    f:   c7 43 04 00 00 00 00      movl   $0x0,0x4(%ebx)
> >
> >  <0>Kernel panic: Aiee, killing interrupt handler!
> > ------------< snip <------< snip <------< snip <------------
> >
> > Below are the rules that were installed on the system:
> >
> > ------------< snip <------< snip <------< snip <------------
> > /sbin/tc qdisc del dev eth0 root
> > /sbin/tc qdisc del dev eth1 root
> > /sbin/iptables -t mangle -F qos
> > /sbin/iptables -t mangle -Z qos
> > /sbin/tc qdisc add dev eth0 root handle 1: htb default 5 r2q 1
> > /sbin/tc class add dev eth0 parent 1: classid 1:1 htb rate 96kbit
> > /sbin/tc class add dev eth0 parent 1:1 classid 1:2 htb rate 96kbit ceil 96kbit
> > /sbin/tc class add dev eth0 parent 1:2 classid 1:3 htb rate 48kbit ceil 96kbit prio 1
> > /sbin/tc qdisc add dev eth0 handle 3: parent 1:3 sfq perturb 10 limit 31
> > /sbin/tc class add dev eth0 parent 1:2 classid 1:4 htb rate 24kbit ceil 96kbit prio 1
> > /sbin/tc qdisc add dev eth0 handle 4: parent 1:4 sfq perturb 10 limit 31
> > /sbin/tc class add dev eth0 parent 1:2 classid 1:5 htb rate 16kbit ceil 96kbit prio 2
> > /sbin/tc qdisc add dev eth0 handle 5: parent 1:5 sfq perturb 10 limit 31
> > /sbin/iptables -t mangle -A qos -o eth0 -s 66.8.85.0/28 -j CLASSIFY --set-class 1:3
> > /sbin/iptables -t mangle -A qos -o eth0 -s 66.8.85.80/28 -j CLASSIFY --set-class 1:4
> > /sbin/iptables -t mangle -A qos -o eth0 -s 192.116.106.192/29 -j CLASSIFY --set-class 1:0
> > /sbin/iptables -t mangle -A qos -o eth0 -s 66.8.28.48/29 -j CLASSIFY --set-class 1:0
> > /sbin/tc qdisc add dev eth1 root handle 1: htb default 5 r2q 2
> > /sbin/tc class add dev eth1 parent 1: classid 1:1 htb rate 512kbit
> > /sbin/tc class add dev eth1 parent 1:1 classid 1:2 htb rate 256kbit ceil 512kbit
> > /sbin/tc class add dev eth1 parent 1:2 classid 1:3 htb rate 128kbit ceil 512kbit prio 1
> > /sbin/tc qdisc add dev eth1 handle 3: parent 1:3 sfq perturb 10 limit 169
> > /sbin/tc class add dev eth1 parent 1:2 classid 1:4 htb rate 64kbit ceil 512kbit prio 1
> > /sbin/tc qdisc add dev eth1 handle 4: parent 1:4 sfq perturb 10 limit 169
> > /sbin/tc class add dev eth1 parent 1:2 classid 1:5 htb rate 32kbit ceil 512kbit prio 2
> > /sbin/tc qdisc add dev eth1 handle 5: parent 1:5 sfq perturb 10 limit 169
> > /sbin/iptables -t mangle -A qos -o eth1 -d 66.8.85.0/28 -j CLASSIFY --set-class 1:3
> > /sbin/iptables -t mangle -A qos -o eth1 -d 66.8.85.80/28 -j CLASSIFY --set-class 1:4
> > /sbin/iptables -t mangle -A qos -o eth1 -d 192.116.106.192/29 -j CLASSIFY --set-class 1:0
> > /sbin/iptables -t mangle -A qos -o eth1 -d 66.8.28.48/29 -j CLASSIFY --set-class 1:0
> > ------------< snip <------< snip <------< snip <------------
> >
> > I've made tons of info available on my home page for you to look at (proc
> > files, vmlinux, System.map, original panic message, etc.
> >
> > http://oasis.frogfoot.net/sfq/
> >
> > --
> >
> > Regards
> >  Abraham
> >
> > I saw what you did and I know who you are.
> >
> > ___________________________________________________
> >  Abraham vd Merwe [ZR1BBQ] - Frogfoot Networks
> >  P.O. Box 3472, Matieland, Stellenbosch, 7602
> >  Cell: +27 82 565 4451 Http: http://www.frogfoot.net/
> >  Email: abz@frogfoot.net
> >
> > -
> > To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> > the body of a message to majordomo@vger.kernel.org
> > More majordomo info at  http://vger.kernel.org/majordomo-info.html
> > Please read the FAQ at  http://www.tux.org/lkml/
> >
>
> --
> http://www.PowerDNS.com      Open source, database driven DNS Software
> http://lartc.org           Linux Advanced Routing & Traffic Control HOWTO
> http://netherlabs.nl                         Consulting
>

