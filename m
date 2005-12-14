Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964885AbVLNSwE@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964885AbVLNSwE (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 14 Dec 2005 13:52:04 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964891AbVLNSwE
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 14 Dec 2005 13:52:04 -0500
Received: from ip67-153-25-67.z25-153-67.customer.algx.net ([67.153.25.67]:35774
	"EHLO mail.ticom-geo.com") by vger.kernel.org with ESMTP
	id S964885AbVLNSwD (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 14 Dec 2005 13:52:03 -0500
Message-ID: <43A06AA8.9050804@ticom-geo.com>
Date: Wed, 14 Dec 2005 12:55:36 -0600
From: Rudy Klinksiek <rklinksiek@ticom-geo.com>
User-Agent: Mozilla/5.0 (Windows; U; Windows NT 5.1; en-US; rv:1.7.1) Gecko/20040707
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org
Subject: 2.4.27    do_IRQ: stack overflow issues/questions
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi:

6 questions with traces and config info at the end.  Explanation after the questions.

+++++

For Box 1 & 2 "misc.c" has the "stacksize" #define bumped from 4096 to 8192.


Question 1:  Does this actually change the stacksize for everyone or is this
              just a define for a "local" condition?


Question 2: Are these valid stack traces??  The reason for this question is that
              I don't see a clean "Hilvl()->Lolvl()->Notify_users()->proc_signl()->send_sig_info()"
              trace on the stack. There are only pieces.  These routines are not
              inlined and are the interrupt->pgm_notify call sequence.

               
Question 3: There seem to be a lot of routines related to the network traffic -
              tcp_xxxx, ip_xxxx, e1000_xxxx, __kfree_skb.
            What's going on?  Has some parameter been misconfigured?


Question 4: It would be possible to convert Lolvl_intr_handler() into a tasklet, a fairly
              painful ordeal since it will require a lot of internal restructuring.
            Does anyone know if that approach would help this situation or not?


Question 5: As a curiosity, when I used SA_INTERRUPT in the flags for request_irq(),
              frequently the interrupt routine would be called but there would
              be no interrupt pending on the cards.
            Has anyone experienced this?  I assume this should not be set, as the
              device drivers book recommends.

Question 6: Is there only 1 interrupt stack in total, or 1/cpu?

+++++

Explanation::

I am working on a pci device driver.  plx9080 pci interface, repetitive dmas of 32Kb
into a set of kernel ring buffers ( user mmappable ) at continuous rates of 32Mb/sec.
Time before problems develop vary from less than an hour to 1-2 days.

After several hangs and crashes( with the oopes not making any sense)kernel debugging was
turned on: stack overflows, spinlock, frame pointer.

Result was that the stack overflow check was tripped on both systems.


Box 1: Debian 2.4.27 + bigpysmem patch  -- dual Xenons 3.06G - hyperthreading enabled
                                                               himem not enabled
         The two pci cards on this system are on different pci busses.

Box 2: same as Box 1 but different hw and 1 one of the Xenons is down.
         The two pci cards on this system are on the same pci bus.

Box 3: Debian 2.4.27 + bigpysmem patch  -- PIII uniprocessor - himem not enabled
         No kernel debugging turned on ( yet )
	 The two pci cards on the same bus
         Interrupt sharing is on.             


General Operation: 

        Crds are set to aquiring data, with the amount of data_acquired/data_ready_interrupt
         determining the interrupt rate.  Typically both cards interrupt with data
         ready at the same time.  The sequence is then

        Hilvl_intr_handler() - fields the data ready interrupt - starts dma
                             - fields the dma complete interrupt and calls
          Lolvl_intr_handler() - which calls
            Notify_users() ... - which goes down a list of processes and  foreach calls
              proc_signal() .. - which calls send_sig_info() to notify the process
                                   of new data ready.

    
My initial concern on Box 1, because of hangs, was that my driver locking scheme
was somehow incorrect, and deadlock was resulting.  But after rereading the 
Documentatio/*.txt on smp and locking and going over the driver several times, 
I am somewhat discounting this possiblity.  Also the latest run on this box had
200 stack overflows over 2.5 days, with none less than 800 bytes.

On Box 2 now I typically get into a "looping situation" in which the overflow
stack size will be stable for a while, and then will drop to a lower level, but with
extra frames on the stack.  See the two stack traces below ...

Box 3 presents me with the least problems, although I have experienced 1 or 2 hangups
over several weeks of testing.


This driver ( at least the essential structure - with no tasklet/bhs ) was originally
written for a quad ppc board and handled 3 different types of pmc cards.  Obviously
here the cards are different, but the driver internals are essentially the same.
I had no such stack overflow problems in the ppc case.  However, the ppc platform
distributed interrupts over the different cpus, if configd in.

For the X86, which is the version I'm working  on the only way that I can see to do 
that is through /proc/irq/xxx/smp_affinity.  If the interrupts are not distributed
to different cpus, they all seem to end up on cpu0, in which case there seems to
be rapid system degradation - stack_overflows, nmi_watchdog oopes, etc. under
moderate interrupt loading ( about 8 interrupts/millisec )

Also a version of this driver works under Solaris 5.8 .


Any comments, questions, ideas, things to try would be greatly appreciated.

Also things to avoid.

At the momment I am about out of ideas except for the tasklet approach ( hopefully
avoidable ) and trying to wipeout as much of my stack usage as possible.


TIA
klink




-----------------------------------------------------------------------------------------


Note that the "f89xxxxx" addresses translated [drq] below are my driver.

All for Box 1

Stack trace 1:    a series of these at the 904 level and then at the 760 level

another run:

Stack trace 2:    after a series of these and then ...
Stack trace 4:    again 4 extra frames on top of the stack ...

Config file


-----------------------------------------------------------------------------------------
Stack trace 1: 

ksymoops < oops/oops.junk7_b
ksymoops 2.4.9 on i686 2.4.27-ticomgeo-v86sx.  Options used
     -V (default)
     -k /proc/ksyms (default)
     -l /proc/modules (default)
     -o /lib/modules/2.4.27-ticomgeo-v86sx/ (default)
     -m /boot/System.map-2.4.27-ticomgeo-v86sx (default)

Warning: You did not tell me where to find symbol information.  I will
assume that the log matches the kernel and modules that are running
right now and I'll use the default options above for symbol resolution.
If the current kernel and/or modules do not match the log, you can get
more accurate output by telling me the kernel version and where to find
map, modules, ksyms etc.  ksymoops -h explains the options.

f2a9a9a8 000002f8 00000000 00000000 00000200 00000000 00000004 00000000 
       00000000 f2a9a000 f2a9a000 00000001 00000000 f2a9aa30 c010c983 f7c36680 
       00000004 f2a9aa74 00000001 00000000 f2a9aa30 04000000 f2a90018 c0100018 
Call Trace:    [<c010c983>] [<c010969c>] [<c0107cd9>] [<c0109a44>] [<c010c983>]
  [<c0142584>] [<c0387427>] [<c0387483>] [<c038758b>] [<c038758b>] [<c03dfb54>]
  [<c03dfda5>] [<c03e0428>] [<c0387483>] [<c03e3277>] [<c03ec80f>] [<c03ecf5e>]
  [<c040f885>] [<c03cd02d>] [<c0396612>] [<c03cced0>] [<c03cca3f>] [<c03cced0>]
  [<c03cd249>] [<c03cd050>] [<c0396612>] [<c03cd050>] [<c03cce64>] [<c03cd050>]
  [<c03871ec>] [<c038c27f>] [<c0298355>] [<c0297c4a>] [<c038c535>] [<c0127538>]
  [<c0109af2>] [<c010c983>] [<f890ed04>] [<f89158fa>] [<c03d19e0>] [<c03d01d5>]
  [<c0296909>] [<c0296909>] [<c0296909>] [<c012db86>] [<c012dc4e>] [<c012db86>]
  [<f890eb87>] [<c012db86>] [<c012dc4e>] [<f890eb87>] [<c012da5a>] [<c0387483>]
  [<c038758b>] [<c03dfda5>] [<c0387483>] [<c038758b>] [<c03e3282>] [<c03ec80f>]
  [<c0387483>] [<c038758b>] [<c03dfda5>] [<c0387483>] [<c038758b>] [<c0387483>]
  [<c038758b>] [<c03dfd59>] [<c0387483>] [<c038758b>] [<c03e3282>] [<c03ec80f>]
  [<c03ecf5e>] [<c040f885>] [<c03cd02d>] [<c0396612>] [<c03cced0>] [<c03cca3f>]
  [<c03cced0>] [<c03cd249>] [<c010fb98>] [<c0106ce1>] [<c0106e2c>] [<c01073b7>]
  [<c0107696>] [<c0297aae>] [<c011c248>] [<c01068d9>] [<c0163e6b>] [<c01078c7>]
Warning (Oops_read): Code line not seen, dumping what data is available


Trace; c010c983 <call_do_IRQ+5/a>
Trace; c010969c <handle_IRQ_event+4c/a0>
Trace; c0107cd9 <show_stack+79/90>
Trace; c0109a44 <do_IRQ+134/220>
Trace; c010c983 <call_do_IRQ+5/a> <----------------<<< Top of Stack for do_IRQ: stack overflow: 904
Trace; c0142584 <kfree+54/b0>
Trace; c0387427 <kfree_skbmem+17/80>
Trace; c0387483 <kfree_skbmem+73/80>
Trace; c038758b <__kfree_skb+fb/160>
Trace; c038758b <__kfree_skb+fb/160>
Trace; c03dfb54 <tcp_clean_rtx_queue+134/390>
Trace; c03dfda5 <tcp_clean_rtx_queue+385/390>
Trace; c03e0428 <tcp_ack+c8/5a0>
Trace; c0387483 <kfree_skbmem+73/80>
Trace; c03e3277 <tcp_rcv_established+547/9b0>
Trace; c03ec80f <tcp_v4_do_rcv+12f/140>
Trace; c03ecf5e <tcp_v4_rcv+73e/8e0>
Trace; c040f885 <ipt_hook+35/40>
Trace; c03cd02d <ip_local_deliver_finish+15d/180>
Trace; c0396612 <nf_hook_slow+132/200>
Trace; c03cced0 <ip_local_deliver_finish+0/180>
Trace; c03cca3f <ip_local_deliver+1bf/1f0>
Trace; c03cced0 <ip_local_deliver_finish+0/180>
Trace; c03cd249 <ip_rcv_finish+1f9/266>
Trace; c03cd050 <ip_rcv_finish+0/266>
Trace; c0396612 <nf_hook_slow+132/200>
Trace; c03cd050 <ip_rcv_finish+0/266>
Trace; c03cce64 <ip_rcv+3f4/460>
Trace; c03cd050 <ip_rcv_finish+0/266>
Trace; c03871ec <alloc_skb+cc/1e0>
Trace; c038c27f <netif_receive_skb+14f/220>
Trace; c0298355 <e1000_clean_rx_irq+3f5/480>
Trace; c0297c4a <e1000_clean+4a/c0>
Trace; c038c535 <net_rx_action+b5/190>
Trace; c0127538 <do_softirq+108/110>
Trace; c0109af2 <do_IRQ+1e2/220>
Trace; c010c983 <call_do_IRQ+5/a>
Trace; f890ed04 <[drq]get_device_unit_data_structure+15/1f>
Trace; f89158fa <[drq]drq_ioctl+2f/2a1e>
Trace; c03d19e0 <ip_finish_output2+0/180>
Trace; c03d01d5 <ip_output+1f5/200>
Trace; c0296909 <e1000_xmit_frame+539/660>
Trace; c0296909 <e1000_xmit_frame+539/660>
Trace; c0296909 <e1000_xmit_frame+539/660>
Trace; c012db86 <send_signal+76/110>
Trace; c012dc4e <deliver_signal+2e/110>
Trace; c012db86 <send_signal+76/110>
Trace; f890eb87 <[drq]proc_signal+30/38>
Trace; c012db86 <send_signal+76/110>
Trace; c012dc4e <deliver_signal+2e/110>
Trace; f890eb87 <[drq]proc_signal+30/38>
Trace; c012da5a <ignored_signal+3a/50>
Trace; c0387483 <kfree_skbmem+73/80>
Trace; c038758b <__kfree_skb+fb/160>
Trace; c03dfda5 <tcp_clean_rtx_queue+385/390>
Trace; c0387483 <kfree_skbmem+73/80>
Trace; c038758b <__kfree_skb+fb/160>
Trace; c03e3282 <tcp_rcv_established+552/9b0>
Trace; c03ec80f <tcp_v4_do_rcv+12f/140>
Trace; c0387483 <kfree_skbmem+73/80>
Trace; c038758b <__kfree_skb+fb/160>
Trace; c03dfda5 <tcp_clean_rtx_queue+385/390>
Trace; c0387483 <kfree_skbmem+73/80>
Trace; c038758b <__kfree_skb+fb/160>
Trace; c0387483 <kfree_skbmem+73/80>
Trace; c038758b <__kfree_skb+fb/160>
Trace; c03dfd59 <tcp_clean_rtx_queue+339/390>
Trace; c0387483 <kfree_skbmem+73/80>
Trace; c038758b <__kfree_skb+fb/160>
Trace; c03e3282 <tcp_rcv_established+552/9b0>
Trace; c03ec80f <tcp_v4_do_rcv+12f/140>
Trace; c03ecf5e <tcp_v4_rcv+73e/8e0>
Trace; c040f885 <ipt_hook+35/40>
Trace; c03cd02d <ip_local_deliver_finish+15d/180>
Trace; c0396612 <nf_hook_slow+132/200>
Trace; c03cced0 <ip_local_deliver_finish+0/180>
Trace; c03cca3f <ip_local_deliver+1bf/1f0>
Trace; c03cced0 <ip_local_deliver_finish+0/180>
Trace; c03cd249 <ip_rcv_finish+1f9/266>
Trace; c010fb98 <save_i387+1f8/250>
Trace; c0106ce1 <setup_sigcontext+e1/130>
Trace; c0106e2c <setup_frame+fc/220>
Trace; c01073b7 <handle_signal+187/1d0>
Trace; c0107696 <do_signal+296/371>
Trace; c0297aae <e1000_irq_enable+6e/80>
Trace; c011c248 <schedule+378/820>
Trace; c01068d9 <restore_sigcontext+119/130>
Trace; c0163e6b <sys_ioctl+12b/36d>
Trace; c01078c7 <system_call+33/38>


2 warnings issued.  Results may not be reliable.
-----------------------------------------------------------------------------------------
Stack trace 2:

ksymoops < oops/oops.junk8_b
ksymoops 2.4.9 on i686 2.4.27-ticomgeo-v86sx.  Options used
     -V (default)
     -k /proc/ksyms (default)
     -l /proc/modules (default)
     -o /lib/modules/2.4.27-ticomgeo-v86sx/ (default)
     -m /boot/System.map-2.4.27-ticomgeo-v86sx (default)

Warning: You did not tell me where to find symbol information.  I will
assume that the log matches the kernel and modules that are running
right now and I'll use the default options above for symbol resolution.
If the current kernel and/or modules do not match the log, you can get
more accurate output by telling me the kernel version and where to find
map, modules, ksyms etc.  ksymoops -h explains the options.

f3268804 00000154 00000000 00000000 00000200 00000000 00000004 00000000 
       00000000 f3268000 f3268000 00000001 00000000 f326888c c010c983 f5f4d940 
       00000004 f32688d0 00000001 00000000 f326888c 04000000 f3260018 c0100018 
Call Trace:    [<c010c983>] [<c010969c>] [<c0107cd9>] [<c0109a44>] [<c010c983>]
  [<c029690b>] [<c012dc4e>] [<c0397133>] [<c038baff>] [<c03d19e0>] [<c03d1ad9>]
  [<c0396612>] [<c03d19e0>] [<c03d19e0>] [<c03d01d5>] [<c03d19e0>] [<c03d1c28>]
  [<c0396612>] [<c03d1b60>] [<c03d067a>] [<c03d1b60>] [<c03eb4b6>] [<c03e4e7e>]
  [<c03e7795>] [<c03d5620>] [<c03d5620>] [<c03e34d2>] [<c03ec80f>] [<c03ecf5e>]
  [<c040f885>] [<c03cd02d>] [<c0396612>] [<c03cced0>] [<c03cca3f>] [<c03cced0>]
  [<c03cd249>] [<c03cd050>] [<c0396612>] [<c03cd050>] [<c03cce64>] [<c03cd050>]
  [<c038c27f>] [<c0298355>] [<c0297f4d>] [<c012c8ab>] [<c0297c4a>] [<c038c535>]
  [<c0127538>] [<c0109af2>] [<c010c983>] [<f8916508>] [<c012dd26>] [<c012dd26>]
  [<c012dd26>] [<f890eb87>] [<c012dd26>] [<f890eb87>] [<c012dd26>] [<f8925d38>]
  [<c012dd26>] [<f890eb87>] [<c012db86>] [<c012dc4e>] [<f891ac36>] [<f8925d38>]
  [<f890eb87>] [<f891ac36>] [<f8925d38>] [<c012c526>] [<c011843c>] [<c010d308>]
  [<c0296909>] [<c012c526>] [<c0396fc8>] [<c038baff>] [<c03d19e0>] [<c03d1ad9>]
  [<c0396612>] [<c03d19e0>] [<c03d19e0>] [<c03d01d5>] [<c03d19e0>] [<c03d1c28>]
  [<c0396612>] [<c03d1b60>] [<c03d067a>] [<c03d1b60>] [<c03eb4b6>] [<c03e4e7e>]
  [<c010fa9e>] [<c010fb98>] [<c03e5c0d>] [<c03871ec>] [<c03d7e65>] [<c0107696>]
  [<c03fcf31>] [<c03830f9>] [<c011c248>] [<c0163e6b>] [<c01078c7>]
Warning (Oops_read): Code line not seen, dumping what data is available


Trace; c010c983 <call_do_IRQ+5/a>
Trace; c010969c <handle_IRQ_event+4c/a0>
Trace; c0107cd9 <show_stack+79/90>
Trace; c0109a44 <do_IRQ+134/220>
Trace; c010c983 <call_do_IRQ+5/a>   <----------------<<< Top of Stack for do_IRQ: stack overflow: 404
Trace; c029690b <e1000_xmit_frame+53b/660>
Trace; c012dc4e <deliver_signal+2e/110>
Trace; c0397133 <qdisc_restart+183/2f0>
Trace; c038baff <dev_queue_xmit+3df/510>
Trace; c03d19e0 <ip_finish_output2+0/180>
Trace; c03d1ad9 <ip_finish_output2+f9/180>
Trace; c0396612 <nf_hook_slow+132/200>
Trace; c03d19e0 <ip_finish_output2+0/180>
Trace; c03d19e0 <ip_finish_output2+0/180>
Trace; c03d01d5 <ip_output+1f5/200>
Trace; c03d19e0 <ip_finish_output2+0/180>
Trace; c03d1c28 <ip_queue_xmit2+c8/231>
Trace; c0396612 <nf_hook_slow+132/200>
Trace; c03d1b60 <ip_queue_xmit2+0/231>
Trace; c03d067a <ip_queue_xmit+49a/560>
Trace; c03d1b60 <ip_queue_xmit2+0/231>
Trace; c03eb4b6 <tcp_v4_send_check+46/d0>
Trace; c03e4e7e <tcp_transmit_skb+42e/6c0>
Trace; c03e7795 <tcp_send_ack+85/d0>
Trace; c03d5620 <tcp_rfree+0/20>
Trace; c03d5620 <tcp_rfree+0/20>
Trace; c03e34d2 <tcp_rcv_established+7a2/9b0>
Trace; c03ec80f <tcp_v4_do_rcv+12f/140>
Trace; c03ecf5e <tcp_v4_rcv+73e/8e0>
Trace; c040f885 <ipt_hook+35/40>
Trace; c03cd02d <ip_local_deliver_finish+15d/180>
Trace; c0396612 <nf_hook_slow+132/200>
Trace; c03cced0 <ip_local_deliver_finish+0/180>
Trace; c03cca3f <ip_local_deliver+1bf/1f0>
Trace; c03cced0 <ip_local_deliver_finish+0/180>
Trace; c03cd249 <ip_rcv_finish+1f9/266>
Trace; c03cd050 <ip_rcv_finish+0/266>
Trace; c0396612 <nf_hook_slow+132/200>
Trace; c03cd050 <ip_rcv_finish+0/266>
Trace; c03cce64 <ip_rcv+3f4/460>
Trace; c03cd050 <ip_rcv_finish+0/266>
Trace; c038c27f <netif_receive_skb+14f/220>
Trace; c0298355 <e1000_clean_rx_irq+3f5/480>
Trace; c0297f4d <e1000_clean_tx_irq+28d/2a0>
Trace; c012c8ab <timer_bh+24b/4f0>
Trace; c0297c4a <e1000_clean+4a/c0>
Trace; c038c535 <net_rx_action+b5/190>
Trace; c0127538 <do_softirq+108/110>
Trace; c0109af2 <do_IRQ+1e2/220>
Trace; c010c983 <call_do_IRQ+5/a>
Trace; f8916508 <[drq]drq_ioctl+c3d/2a1e>
Trace; c012dd26 <deliver_signal+106/110>
Trace; c012dd26 <deliver_signal+106/110>
Trace; c012dd26 <deliver_signal+106/110>
Trace; f890eb87 <[drq]proc_signal+30/38>
Trace; c012dd26 <deliver_signal+106/110>
Trace; f890eb87 <[drq]proc_signal+30/38>
Trace; c012dd26 <deliver_signal+106/110>
Trace; f8925d38 <[drq]lolvl_intr_tv+0/8>
Trace; c012dd26 <deliver_signal+106/110>
Trace; f890eb87 <[drq]proc_signal+30/38>
Trace; c012db86 <send_signal+76/110>
Trace; c012dc4e <deliver_signal+2e/110>
Trace; f891ac36 <[drq]embedded_lolvl_intr_handler+994/a4f>
Trace; f8925d38 <[drq]lolvl_intr_tv+0/8>
Trace; f890eb87 <[drq]proc_signal+30/38>
Trace; f891ac36 <[drq]embedded_lolvl_intr_handler+994/a4f>
Trace; f8925d38 <[drq]lolvl_intr_tv+0/8>
Trace; c012c526 <update_process_times+36/d0>
Trace; c011843c <smp_apic_timer_interrupt+13c/140>
Trace; c010d308 <call_apic_timer_interrupt+5/d>
Trace; c0296909 <e1000_xmit_frame+539/660>
Trace; c012c526 <update_process_times+36/d0>
Trace; c0396fc8 <qdisc_restart+18/2f0>
Trace; c038baff <dev_queue_xmit+3df/510>
Trace; c03d19e0 <ip_finish_output2+0/180>
Trace; c03d1ad9 <ip_finish_output2+f9/180>
Trace; c0396612 <nf_hook_slow+132/200>
Trace; c03d19e0 <ip_finish_output2+0/180>
Trace; c03d19e0 <ip_finish_output2+0/180>
Trace; c03d01d5 <ip_output+1f5/200>
Trace; c03d19e0 <ip_finish_output2+0/180>
Trace; c03d1c28 <ip_queue_xmit2+c8/231>
Trace; c0396612 <nf_hook_slow+132/200>
Trace; c03d1b60 <ip_queue_xmit2+0/231>
Trace; c03d067a <ip_queue_xmit+49a/560>
Trace; c03d1b60 <ip_queue_xmit2+0/231>
Trace; c03eb4b6 <tcp_v4_send_check+46/d0>
Trace; c03e4e7e <tcp_transmit_skb+42e/6c0>
Trace; c010fa9e <save_i387+fe/250>
Trace; c010fb98 <save_i387+1f8/250>
Trace; c03e5c0d <tcp_write_xmit+1dd/2b0>
Trace; c03871ec <alloc_skb+cc/1e0>
Trace; c03d7e65 <tcp_sendmsg+6c5/13c0>
Trace; c0107696 <do_signal+296/371>
Trace; c03fcf31 <inet_sendmsg+41/50>
Trace; c03830f9 <sock_sendmsg+69/b0>
Trace; c011c248 <schedule+378/820>
Trace; c0163e6b <sys_ioctl+12b/36d>
Trace; c01078c7 <system_call+33/38>


2 warnings issued.  Results may not be reliable.


-----------------------------------------------------------------------------------------
Config file


#
# Automatically generated by make menuconfig: don't edit
#
CONFIG_X86=y
CONFIG_UID16=y
CONFIG_EXPERIMENTAL=y
CONFIG_MODULES=y
CONFIG_MODVERSIONS=y
CONFIG_KMOD=y
CONFIG_LOLAT=y
CONFIG_MPENTIUM4=y
CONFIG_X86_WP_WORKS_OK=y
CONFIG_X86_INVLPG=y
CONFIG_X86_CMPXCHG=y
CONFIG_X86_XADD=y
CONFIG_X86_BSWAP=y
CONFIG_X86_POPAD_OK=y
CONFIG_RWSEM_XCHGADD_ALGORITHM=y
CONFIG_X86_L1_CACHE_SHIFT=7
CONFIG_X86_HAS_TSC=y
CONFIG_X86_GOOD_APIC=y
CONFIG_X86_PGE=y
CONFIG_X86_USE_PPRO_CHECKSUM=y
CONFIG_X86_F00F_WORKS_OK=y
CONFIG_X86_MCE=y
CONFIG_MICROCODE=y
CONFIG_X86_MSR=y
CONFIG_X86_CPUID=y
CONFIG_NOHIGHMEM=y
CONFIG_MTRR=y
CONFIG_BIGPHYS_AREA=y
CONFIG_SMP=y
CONFIG_PREEMPT=y
CONFIG_NR_CPUS=32
CONFIG_X86_TSC=y
CONFIG_HAVE_DEC_LOCK=y
CONFIG_NET=y
CONFIG_X86_IO_APIC=y
CONFIG_X86_LOCAL_APIC=y
CONFIG_PCI=y
CONFIG_PCI_GOANY=y
CONFIG_PCI_BIOS=y
CONFIG_PCI_DIRECT=y
CONFIG_ISA=y
CONFIG_PCI_NAMES=y
CONFIG_HOTPLUG=y
CONFIG_SYSVIPC=y
CONFIG_BSD_PROCESS_ACCT=y
CONFIG_SYSCTL=y
CONFIG_KCORE_ELF=y
CONFIG_BINFMT_AOUT=y
CONFIG_BINFMT_ELF=y
CONFIG_BINFMT_MISC=y
CONFIG_PM=y
CONFIG_ACPI=y
CONFIG_ACPI_BOOT=y
CONFIG_ACPI_BUS=y
CONFIG_ACPI_INTERPRETER=y
CONFIG_ACPI_EC=y
CONFIG_ACPI_POWER=y
CONFIG_ACPI_PCI=y
CONFIG_ACPI_MMCONFIG=y
CONFIG_ACPI_SLEEP=y
CONFIG_ACPI_SYSTEM=y
CONFIG_ACPI_AC=y
CONFIG_ACPI_BATTERY=y
CONFIG_ACPI_BUTTON=y
CONFIG_ACPI_FAN=y
CONFIG_ACPI_PROCESSOR=y
CONFIG_ACPI_THERMAL=y
CONFIG_PARPORT=m
CONFIG_PARPORT_PC=m
CONFIG_PARPORT_PC_CML1=m
CONFIG_PARPORT_PC_FIFO=y
CONFIG_BLK_DEV_FD=y
CONFIG_BLK_DEV_LOOP=y
CONFIG_PACKET=y
CONFIG_PACKET_MMAP=y
CONFIG_NETFILTER=y
CONFIG_FILTER=y
CONFIG_UNIX=y
CONFIG_INET=y
CONFIG_IP_MULTICAST=y
CONFIG_SYN_COOKIES=y
CONFIG_IP_NF_CONNTRACK=y
CONFIG_IP_NF_FTP=y
CONFIG_IP_NF_AMANDA=y
CONFIG_IP_NF_TFTP=y
CONFIG_IP_NF_IRC=y
CONFIG_IP_NF_QUEUE=y
CONFIG_IP_NF_IPTABLES=y
CONFIG_IP_NF_MATCH_LIMIT=y
CONFIG_IP_NF_MATCH_MAC=y
CONFIG_IP_NF_MATCH_PKTTYPE=y
CONFIG_IP_NF_MATCH_MARK=y
CONFIG_IP_NF_MATCH_MULTIPORT=y
CONFIG_IP_NF_MATCH_TOS=y
CONFIG_IP_NF_MATCH_RECENT=y
CONFIG_IP_NF_MATCH_ECN=y
CONFIG_IP_NF_MATCH_DSCP=y
CONFIG_IP_NF_MATCH_AH_ESP=y
CONFIG_IP_NF_MATCH_LENGTH=y
CONFIG_IP_NF_MATCH_TTL=y
CONFIG_IP_NF_MATCH_TCPMSS=y
CONFIG_IP_NF_MATCH_HELPER=y
CONFIG_IP_NF_MATCH_STATE=y
CONFIG_IP_NF_MATCH_CONNTRACK=y
CONFIG_IP_NF_MATCH_UNCLEAN=y
CONFIG_IP_NF_MATCH_OWNER=y
CONFIG_IP_NF_FILTER=y
CONFIG_IP_NF_TARGET_REJECT=y
CONFIG_IP_NF_TARGET_MIRROR=y
CONFIG_IP_NF_NAT=y
CONFIG_IP_NF_NAT_NEEDED=y
CONFIG_IP_NF_TARGET_MASQUERADE=y
CONFIG_IP_NF_TARGET_REDIRECT=y
CONFIG_IP_NF_NAT_AMANDA=y
CONFIG_IP_NF_NAT_SNMP_BASIC=y
CONFIG_IP_NF_NAT_IRC=y
CONFIG_IP_NF_NAT_FTP=y
CONFIG_IP_NF_NAT_TFTP=y
CONFIG_IP_NF_MANGLE=y
CONFIG_IP_NF_TARGET_TOS=y
CONFIG_IP_NF_TARGET_ECN=y
CONFIG_IP_NF_TARGET_DSCP=y
CONFIG_IP_NF_TARGET_MARK=y
CONFIG_IP_NF_TARGET_LOG=y
CONFIG_IP_NF_TARGET_ULOG=y
CONFIG_IP_NF_TARGET_TCPMSS=y
CONFIG_IP_NF_ARPTABLES=y
CONFIG_IP_NF_ARPFILTER=y
CONFIG_IP_NF_ARP_MANGLE=y
CONFIG_IPV6=y
CONFIG_IP6_NF_QUEUE=y
CONFIG_IP6_NF_IPTABLES=y
CONFIG_IP6_NF_MATCH_LIMIT=y
CONFIG_IP6_NF_MATCH_MAC=y
CONFIG_IP6_NF_MATCH_RT=y
CONFIG_IP6_NF_MATCH_OPTS=y
CONFIG_IP6_NF_MATCH_FRAG=y
CONFIG_IP6_NF_MATCH_HL=y
CONFIG_IP6_NF_MATCH_MULTIPORT=y
CONFIG_IP6_NF_MATCH_OWNER=y
CONFIG_IP6_NF_MATCH_MARK=y
CONFIG_IP6_NF_MATCH_IPV6HEADER=y
CONFIG_IP6_NF_MATCH_AHESP=y
CONFIG_IP6_NF_MATCH_LENGTH=y
CONFIG_IP6_NF_MATCH_EUI64=y
CONFIG_IP6_NF_FILTER=y
CONFIG_IP6_NF_TARGET_LOG=y
CONFIG_IP6_NF_MANGLE=y
CONFIG_IP6_NF_TARGET_MARK=y
CONFIG_IP_SCTP=y
CONFIG_SCTP_HMAC_MD5=y
CONFIG_VLAN_8021Q=y
CONFIG_BRIDGE=y
CONFIG_IDE=y
CONFIG_BLK_DEV_IDE=y
CONFIG_BLK_DEV_IDEDISK=y
CONFIG_IDEDISK_MULTI_MODE=y
CONFIG_BLK_DEV_IDECD=y
CONFIG_BLK_DEV_IDEPCI=y
CONFIG_IDEPCI_SHARE_IRQ=y
CONFIG_BLK_DEV_IDEDMA_PCI=y
CONFIG_IDEDMA_PCI_AUTO=y
CONFIG_BLK_DEV_IDEDMA=y
CONFIG_BLK_DEV_PIIX=y
CONFIG_IDEDMA_AUTO=y
CONFIG_SCSI=y
CONFIG_BLK_DEV_SD=y
CONFIG_SD_EXTRA_DEVS=40
CONFIG_CHR_DEV_ST=y
CONFIG_BLK_DEV_SR=y
CONFIG_BLK_DEV_SR_VENDOR=y
CONFIG_SR_EXTRA_DEVS=2
CONFIG_CHR_DEV_SG=y
CONFIG_SCSI_DEBUG_QUEUES=y
CONFIG_SCSI_MULTI_LUN=y
CONFIG_SCSI_CONSTANTS=y
CONFIG_SCSI_AIC79XX=y
CONFIG_AIC79XX_CMDS_PER_DEVICE=32
CONFIG_AIC79XX_RESET_DELAY_MS=15000
CONFIG_AIC79XX_DEBUG_MASK=0
CONFIG_SCSI_BUSLOGIC=y
CONFIG_SCSI_SYM53C8XX=y
CONFIG_SCSI_NCR53C8XX_DEFAULT_TAGS=4
CONFIG_SCSI_NCR53C8XX_MAX_TAGS=32
CONFIG_SCSI_NCR53C8XX_SYNC=20
CONFIG_NETDEVICES=y
CONFIG_BONDING=y
CONFIG_NET_ETHERNET=y
CONFIG_NET_PCI=y
CONFIG_PCNET32=y
CONFIG_E100=y
CONFIG_E1000=y
CONFIG_E1000_NAPI=y
CONFIG_NET_BROADCOM=y
CONFIG_PPP=y
CONFIG_PPP_MULTILINK=y
CONFIG_PPP_FILTER=y
CONFIG_PPP_ASYNC=y
CONFIG_PPP_SYNC_TTY=y
CONFIG_PPP_DEFLATE=y
CONFIG_PPP_BSDCOMP=y
CONFIG_INPUT=y
CONFIG_INPUT_KEYBDEV=y
CONFIG_INPUT_MOUSEDEV=y
CONFIG_INPUT_MOUSEDEV_SCREEN_X=1024
CONFIG_INPUT_MOUSEDEV_SCREEN_Y=768
CONFIG_INPUT_EVDEV=y
CONFIG_INPUT_UINPUT=y
CONFIG_VT=y
CONFIG_VT_CONSOLE=y
CONFIG_SERIAL=y
CONFIG_SERIAL_CONSOLE=y
CONFIG_UNIX98_PTYS=y
CONFIG_UNIX98_PTY_COUNT=256
CONFIG_PRINTER=m
CONFIG_LP_CONSOLE=y
CONFIG_PPDEV=m
CONFIG_I2C=m
CONFIG_I2C_ALGOBIT=m
CONFIG_I2C_PHILIPSPAR=m
CONFIG_I2C_ELV=m
CONFIG_I2C_VELLEMAN=m
CONFIG_SCx200_ACB=m
CONFIG_I2C_ALGOPCF=m
CONFIG_I2C_ELEKTOR=m
CONFIG_I2C_CHARDEV=m
CONFIG_I2C_PROC=m
CONFIG_MOUSE=y
CONFIG_PSMOUSE=y
CONFIG_INTEL_RNG=y
CONFIG_HW_RANDOM=y
CONFIG_AUTOFS4_FS=y
CONFIG_EXT3_FS=y
CONFIG_JBD=y
CONFIG_FAT_FS=y
CONFIG_MSDOS_FS=y
CONFIG_VFAT_FS=y
CONFIG_TMPFS=y
CONFIG_RAMFS=y
CONFIG_ISO9660_FS=y
CONFIG_JOLIET=y
CONFIG_PROC_FS=y
CONFIG_DEVFS_FS=y
CONFIG_DEVPTS_FS=y
CONFIG_EXT2_FS=y
CONFIG_XFS_FS=y
CONFIG_NFS_FS=y
CONFIG_NFS_V3=y
CONFIG_NFS_DIRECTIO=y
CONFIG_SUNRPC=y
CONFIG_LOCKD=y
CONFIG_LOCKD_V4=y
CONFIG_MSDOS_PARTITION=y
CONFIG_NLS=y
CONFIG_NLS_DEFAULT="iso8859-1"
CONFIG_NLS_CODEPAGE_437=y
CONFIG_NLS_ISO8859_1=y
CONFIG_NLS_ISO8859_15=y
CONFIG_NLS_UTF8=y
CONFIG_VGA_CONSOLE=y
CONFIG_SOUND=y
CONFIG_USB=y
CONFIG_USB_EHCI_HCD=y
CONFIG_USB_UHCI_ALT=y
CONFIG_USB_HID=y
CONFIG_USB_HIDINPUT=y
CONFIG_USB_HIDDEV=y
CONFIG_USB_PEGASUS=m
CONFIG_USB_RTL8150=m
CONFIG_USB_KAWETH=m
CONFIG_USB_CATC=m
CONFIG_USB_CDCETHER=m
CONFIG_USB_USBNET=m
CONFIG_USB_SERIAL=m
CONFIG_USB_SERIAL_GENERIC=y
CONFIG_USB_SERIAL_BELKIN=m
CONFIG_USB_SERIAL_WHITEHEAT=m
CONFIG_USB_SERIAL_DIGI_ACCELEPORT=m
CONFIG_USB_SERIAL_EMPEG=m
CONFIG_USB_SERIAL_FTDI_SIO=m
CONFIG_USB_SERIAL_VISOR=m
CONFIG_USB_SERIAL_IPAQ=m
CONFIG_USB_SERIAL_IR=m
CONFIG_USB_SERIAL_EDGEPORT=m
CONFIG_USB_SERIAL_EDGEPORT_TI=m
CONFIG_USB_SERIAL_KEYSPAN_PDA=m
CONFIG_USB_SERIAL_KEYSPAN=m
CONFIG_USB_SERIAL_KEYSPAN_USA28=y
CONFIG_USB_SERIAL_KEYSPAN_USA28X=y
CONFIG_USB_SERIAL_KEYSPAN_USA28XA=y
CONFIG_USB_SERIAL_KEYSPAN_USA28XB=y
CONFIG_USB_SERIAL_KEYSPAN_USA19=y
CONFIG_USB_SERIAL_KEYSPAN_USA18X=y
CONFIG_USB_SERIAL_KEYSPAN_USA19W=y
CONFIG_USB_SERIAL_KEYSPAN_USA19QW=y
CONFIG_USB_SERIAL_KEYSPAN_USA19QI=y
CONFIG_USB_SERIAL_KEYSPAN_MPR=y
CONFIG_USB_SERIAL_KEYSPAN_USA49W=y
CONFIG_USB_SERIAL_KEYSPAN_USA49WLC=y
CONFIG_USB_SERIAL_MCT_U232=m
CONFIG_USB_SERIAL_KLSI=m
CONFIG_USB_SERIAL_KOBIL_SCT=m
CONFIG_USB_SERIAL_PL2303=m
CONFIG_USB_SERIAL_CYBERJACK=m
CONFIG_USB_SERIAL_XIRCOM=m
CONFIG_USB_SERIAL_OMNINET=m
CONFIG_DEBUG_KERNEL=y
CONFIG_DEBUG_STACKOVERFLOW=y
CONFIG_DEBUG_IOVIRT=y
CONFIG_MAGIC_SYSRQ=y
CONFIG_DEBUG_SPINLOCK=y
CONFIG_FRAME_POINTER=y
CONFIG_LOG_BUF_SHIFT=0
CONFIG_CRC32=y
CONFIG_ZLIB_INFLATE=y
CONFIG_ZLIB_DEFLATE=y


-----------------------------------------------------------------------------------------



