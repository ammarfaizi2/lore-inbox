Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S264700AbSJUC5N>; Sun, 20 Oct 2002 22:57:13 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S264701AbSJUC5N>; Sun, 20 Oct 2002 22:57:13 -0400
Received: from mail.cscoms.net ([202.183.255.13]:24588 "EHLO csmail.cscoms.com")
	by vger.kernel.org with ESMTP id <S264700AbSJUC5L>;
	Sun, 20 Oct 2002 22:57:11 -0400
Date: Mon, 21 Oct 2002 10:02:07 +0700
From: Alain Fauconnet <alain@cscoms.net>
To: linux-kernel@vger.kernel.org
Cc: Alan Cox <gw4pts@gw4pts.ampr.org>, Alexey Kuznetsov <kuznet@ms2.inr.ac.ru>,
       "Vitaly E.Lavrov" <lve@ns.aanet.ru>
Subject: UPD: Frequent/consistent panics in 2.4.19 at ip_route_input_slow, in_dev_get(dev)
Message-ID: <20021021100207.E302@cscoms.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

I'm  updating  this  information:  the  box  that has been upgraded to
2.4.19 crashes as well exactly at *the same* instruction.

I'm not sure what to do next: AFAIK the kernel crash dump patches  are
not available for 2.4.19 yet so I can't generate a core dump  on  this
box. Since it's definitely the same problem, I'd think that collecting
a full crash core dump under 2.4.17 or 2.4.18 would help, wouldn't it?

As I wrote down below, these box have 200++ ppp interfaces up all  the
time. Such interfaces come and go  many  times  per  minute  as  users
connect and disconnect. I really suspect like a race condition on  the
net  interfaces  structures   and  the  comments in ./net/ipv4/route.c
imply that such race conditions have been identified and fixed in  the
past.

What  I  can't  explain  is why these servers used to be quite stable.
Their load has increased, sure, but slowly. It  really  looked  to  me
like some traffic caused the crashes  at  first  sight  (kind  of  DoS
attack)  but  the  crash  context  doesn't  quite  back up this guess.

I'm Cc'ing this message to  the  people  whose  names  appear  in  the
route.c  file  as  per  the  kernel crash "howto" docs. Hope that this
won't get me flamed.

Greets,
_Alain_

----- Forwarded message from Alain Fauconnet <alain@cscoms.net> -----

Date: Fri, 18 Oct 2002 10:38:49 +0700
From: Alain Fauconnet <alain@cscoms.net>
To: linux-kernel@vger.kernel.org
Subject: Frequent/consistent panics in 2.4.17/.18 at ip_route_input_slow, in_dev_get(dev) 

Hello all,

I've been getting frequent and consistent panics  on  three  different
boxes running 2.4.17 and 2.4.18 kernels,  always  at  the  same  exact
instruction,    a    "incl      0x4(%edx)"   at   the   beginning   of
ip_route_input_slow().

The boxes are very busy PPTP (PoPToP) servers on brand single-CPU (P3,
P4) SCSI-based hardware (2 x IBM, 1 x Asus MB).

Example for a 2.4.17 kernel:

Unable to handle kernel paging request at virtual address f73cdc48
Oops = 0002
EIP = 0010:c0223ff9 not tainted

(gdb) x/10i 0xc0223ff9
0xc0223ff9 <ip_route_input_slow+33>:    incl   0x4(%edx)

EAX = 0 EBX = 410c0100 ECX = f69a30ac EDX = f73cdc44

The indexed access through EDX is causing the fault

ESI = ccb23fc6 EDI = d71a10ac EBP =  c583b0a0
ESP = d01d1e6c

DS = 0010 ES = 0018 SS = 0018

Process varies, in this case pptpctrl.

Stack: 410c0100 ccb23fcb d71a10ac c583b0ad 0000003d 

Call trace:

c023f91b <raw_recvmsg+111>
c022491a <ip_route_input+338>
c0226834 <ip_rcv_finish+40>
d88251ae ?
d8825180 ?
c0117867 <update_wall_time+11>
c0117c42 <timer_bh+546>
...

Sorry,  this partial data was hand-written in haste, I *really* had to
reboot this production box immediately.

Looking  at  the code in net/ipv4/route.c, I strongly suspect that the
offending line is:

int ip_route_input_slow(struct sk_buff *skb, u32 daddr, u32 saddr,
                        u8 tos, struct net_device *dev)
{
        struct rt_key   key;
        struct fib_result res;
------> struct in_device *in_dev = in_dev_get(dev); <-------

Because that's quite close to the beginning of the function:

0xc0223fd8 <ip_route_input_slow>:       sub    $0x50,%esp
0xc0223fdb <ip_route_input_slow+3>:     push   %ebp
0xc0223fdc <ip_route_input_slow+4>:     push   %edi
0xc0223fdd <ip_route_input_slow+5>:     push   %esi
0xc0223fde <ip_route_input_slow+6>:     push   %ebx
0xc0223fdf <ip_route_input_slow+7>:     mov    0x74(%esp,1),%edx
0xc0223fe3 <ip_route_input_slow+11>:    mov    0x70(%esp,1),%eax
0xc0223fe7 <ip_route_input_slow+15>:    mov    %al,0x2f(%esp,1)
0xc0223feb <ip_route_input_slow+19>:    mov    0xac(%edx),%edx
0xc0223ff1 <ip_route_input_slow+25>:    mov    %edx,0x24(%esp,1)
0xc0223ff5 <ip_route_input_slow+29>:    test   %edx,%edx
0xc0223ff7 <ip_route_input_slow+31>:    je     0xc0223ffc <ip_route_input_slow+36>
0xc0223ff9 <ip_route_input_slow+33>:    incl   0x4(%edx) <----- offending instruction

and in_dev_get() inlines to:

in_dev_get(const struct net_device *dev)
{
        struct in_device *in_dev;

        read_lock(&inetdev_lock);
        in_dev = dev->ip_ptr;
        if (in_dev)
                atomic_inc(&in_dev->refcnt); <---- inlines to "lock incl %0"
        read_unlock(&inetdev_lock);
        return in_dev;
}

So  unless  I  am  seriously  misled, we fault when trying to bump the
in_dev reference count up. What could that mean? This box  is  a  busy
PPTP  (PoPToP) server usually serving 200-350 sessions at once, with a
lot of connections/disconnections per  minute.  Could  it  be  a  race
condition that causes the  in_dev  structure  to  go  away  before  we
reference it? I'm  not  familiar  with  the  Linux  kernel  enough  to
investigate further.

I've got up to 4 crashes on these 3 boxes in a single day, all at that
precise instruction. Nothing has changed lately on the servers, except
a steadily increasing load. They  had  been  rock  solid  for  several
months   before   this   started   happening   about   a   week   ago.

They  run  a  quite  simple  configuration,  almost  vanilla  hardened
Slackware with  ppptp  compiled  from  source  (no  encryption).  Only
modification to kernel is in ./net/core/dev.c where I have  upped  the
max   number   of   instances   for  a  device  from  100  to  500  in
dev_alloc_name(). Algorithm is unchanged yet (yes,  I  have  read  the
comments). 

One  of  the boxes has been upgraded to 2.4.19 (it broke everything, I
had to get pppd 2.4.2b1 to fix - don't know if that's to be  expected)
and has been running stable since then  (only  1  day,  doesn't  prove
much   yet).   My   next   plan is to implement LKCD on the 2.4.17 box
(not available for 2.4.19 yet as it  seems)  and  capture  a  complete
crash dump. Would that help tracking down?

Thanks in advance for any help,

Greets,

_Alain_
"I've RTFM. It says: `see your system administrator'. But... *I* am  
the system administrator"
(DECUS US symposium session title, author unknown, ca. 1990)


----- End forwarded message -----
