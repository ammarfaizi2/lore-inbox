Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S288086AbSA0PuG>; Sun, 27 Jan 2002 10:50:06 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S288092AbSA0Pt5>; Sun, 27 Jan 2002 10:49:57 -0500
Received: from shed.alex.org.uk ([195.224.53.219]:64156 "HELO shed.alex.org.uk")
	by vger.kernel.org with SMTP id <S288086AbSA0Ptp>;
	Sun, 27 Jan 2002 10:49:45 -0500
Date: Sun, 27 Jan 2002 15:43:39 -0000
From: Alex Bligh - linux-kernel <linux-kernel@alex.org.uk>
Reply-To: Alex Bligh - linux-kernel <linux-kernel@alex.org.uk>
To: linux-kernel@vger.kernel.org
Cc: Alex Bligh - linux-kernel <linux-kernel@alex.org.uk>
Subject: Sanity check: 2.2.20 patched ip_rcv, dst->input == NULL?
Message-ID: <1208245822.1012146219@[195.224.237.69]>
X-Mailer: Mulberry/2.1.0 (Win32)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

[Having great difficulty getting this to
propagate to the list - according to
marc.theaimsgroup.com and my own logs. Third
time lucky - perhaps / in subject
line is not allowed. Apols if it is a dupe.]


This is a long mail (apologies), but I /think/ it may point to
some race condition in the routing table on 2.2.20.

I am getting occasional oops on a 2.2.20 box (plus patches, will
publish if required) routing several hundreds of megabits a second
between Acenic cards in a hostile environment, with a full (zebra
populated) BGP table.

There are patches on this box which I will hapilly publish if
required, however I'm almost 100% sure these aren't the cause
of the problem. It did the same on 2.2.19.

The symptom is an occasional oops, always with EIP set to 0,
and the last (sensible) thing in the stack trace is always
net_bh, inevitably the return address being the final
line which calls
  if (pt_prev)
     pt_prev->func(skb, skb->dev, pt_prev).

Now I thought that somehow 'func' was getting set to zero,
so I did:


# define pt_call_func(a,b,c) \
  do \
  { \
    if (pt_prev->func) \
      pt_prev->func(a,b,c); \
    else \
      printk(KERN_ERR "net/core/dev: NULL function proto=0x%x\n", type); \
  } while(0)

...

   if(pt_prev)
     pt_call_func(skb, skb->dev, pt_prev);


and of course no printk(), and it still crashes.

The relevant part of the oops (full oops below) looks like this. I've
inserted some annotations; don't bother too much about run_vlan_queues
or qdisc_run_queues (the former is a function from my patch);
I think this is only on the stack because it was 'there from before'.
Certainly qdisc_run_queues does not and cannot call run_vlan_queues.
This seems likely as the return address within net_bh is after the
call to the protocol handler (pt_prev->func() ), and not the call
to qdisc_run_queues.

Oops: 0000
CPU:    0
EIP:    0010:[<00000000>]
Using defaults from ksymoops -t elf32-i386 -a i386
EFLAGS: 00010283
eax: 00000000   ebx: cf284460   ecx: cffdd840   edx: ccea50a0
esi: cf3a0ca4   edi: 00000014   ebp: ce88decc   esp: ce88de98
ds: 0018   es: 0018   ss: 0018
Process kvrrpd - n.625 (pid: 1868, process nr: 179, stackpage=ce88d000)
Stack: cffe6400 c022d720 c017a00c 00000000
                   ^         ^
                   |   in run_vlan_queues
                qdisc_head

       c022e128 cf284460 c015211b cffe6400
          ^                  ^
      ip_packet_type    in qdisc_run_queues

       c022e128 ce30f020 0000002e 00000002
           ^
      ip_packet_type

       c0261ea4 00000008 c014db9b cf284460
           ^                 ^
       tqueue_lock       in net_bh

       ce77f41c c022e128 00000297 00000001
                     ^
                ip_packet_type
       c0261ea4 c0261e60 00000000 ce31a340
           ^         ^
       tqueue_lock   |
                 local_bh_count

Call Trace: [<c017a00c>] [<c015211b>] [<c014db9b>] [<c01186c9>]
[<c0110ea2>] [<c0110f21>] [<c0110d38>]        [<c0110d2f>] [<c014d261>]
[<c0173515>] [<c0110ab0>] [<c0111280>] [<c01f1800>] [<c0173ca9>]
[<c01f1800>]        [<c0173e15>] [<c0107c2b>] [<c0107c34>]
Code: Bad EIP value.

>> EIP; 00000000 Before first symbol
Trace; c017a00c <run_vlan_queues+1c4/204>
Trace; c015211a <qdisc_run_queues+2e/60>
Trace; c014db9a <net_bh+20e/274>
Trace; c01186c8 <do_bottom_half+50/6c>
Trace; c0110ea2 <schedule+146/278>
Trace; c0110f20 <schedule+1c4/278>
Trace; c0110d38 <schedule_timeout+78/94>
Trace; c0110d2e <schedule_timeout+6e/94>
Trace; c014d260 <dev_get+14/3c>
Trace; c0173514 <gratuitous_arp+68/88>
Trace; c0110ab0 <process_timeout+0/14>
Trace; c0111280 <interruptible_sleep_on_timeout+38/60>
Trace; c01f1800 <timer_bug_msg+1980/2f20>
Trace; c0173ca8 <vrrp_timer+144/2f4>
Trace; c01f1800 <timer_bug_msg+1980/2f20>
Trace; c0173e14 <vrrp_timer+2b0/2f4>
Trace; c0107c2a <kernel_thread+1e/38>
Trace; c0107c34 <kernel_thread+28/38>

Now, disassembling net_bh:

0xc014db6f <net_bh+483>:        test   %esi,%esi    ; if (pt_prev)
0xc014db71 <net_bh+485>:        je     0xc014dba0 <net_bh+532>

(then run through macro to check pt_prev->func is non-null)

0xc014db73 <net_bh+487>:        mov    0x8(%esi),%edx
0xc014db76 <net_bh+490>:        test   %edx,%edx
0xc014db78 <net_bh+492>:        jne    0xc014db90 <net_bh+516>

; if it's null, printk()
0xc014db7a <net_bh+494>:        add    $0xfffffff8,%esp
0xc014db7d <net_bh+497>:        xor    %eax,%eax
0xc014db7f <net_bh+499>:        mov    %bp,%ax
0xc014db82 <net_bh+502>:        push   %eax
0xc014db83 <net_bh+503>:        push   $0xc01ed420
0xc014db88 <net_bh+508>:        call   0xc0113c10 <printk>
0xc014db8d <net_bh+513>:        jmp    0xc014dbb7 <net_bh+555>
0xc014db8f <net_bh+515>:        nop

; pt_prev->func is non null, call it
0xc014db90 <net_bh+516>:        add    $0xfffffffc,%esp
0xc014db93 <net_bh+519>:        push   %esi
0xc014db94 <net_bh+520>:        mov    0x18(%edi),%eax
0xc014db97 <net_bh+523>:        push   %eax
0xc014db98 <net_bh+524>:        push   %edi
0xc014db99 <net_bh+525>:        call   *%edx   ; <==== HERE
0xc014db9b <net_bh+527>:        jmp    0xc014dbb7 <net_bh+555>

However, clearly this does not call qdisc_run_queues, which would
however have been called earlier, and thus conceivably have a return
address within it on the stack.

On 2.2.19 I've seen multiple of these oops's, with net_bh the
top of what's reported on the call trace.

Instead, it should be calling ip_rcv; this is likely as pt_func is
pushed onto the stack and indeed ip_packet_type is on the stack,
which means ip_rcv will be called.

ip_rcv itself won't have an address on the stack at this point. However,
if it (somehow) sets EIP to zero, the oops above would result.

Reading through ip_rcv, this would appear to happen if the
ip_route returns 0, but does not set skb->dst->input from
it's default null value, as the
        return skb->dst->input(skb);
will do something similar to the above (admittedly I think
it would put its address on the stack).

The path to set skb->dst in ip_route is convoluted to say the least,
and it depends amongst other things on the route cache and neighbor
table. I get period warnings of overflow of this. However, it
seems to me to be tempting fate not to do something like (in ip_rcv)

if (skb->dst && skb->dst->input)
  return skb->dst->input(skb);
else {
  printk("Oh dear\n");
  goto drop;
}

Else either some logic error could result in dst->input
not being set; or some race condition, could result in a half
entered route not having dst->input set correctly. As I say,
the routing table is extremely volatile (read probably doing
a complete table reload or 2 whilst this happened).

Now I haven't found the race condition, nor the logic error
(which doesn't mean there isn't one)

My questions are:
* Is the current 2.2.20 ip_rcv sufficiently safe?
* Am I on even vaguely the right track tracking this down?
* Any other ideas?

--
Alex Bligh


---------- End Forwarded Message ----------



--
Alex Bligh


---------- End Forwarded Message ----------



--
Alex Bligh
