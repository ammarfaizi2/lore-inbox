Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263823AbUBEE5b (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 4 Feb 2004 23:57:31 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264252AbUBEE5a
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 4 Feb 2004 23:57:30 -0500
Received: from amber.ccs.neu.edu ([129.10.116.51]:48273 "EHLO
	amber.ccs.neu.edu") by vger.kernel.org with ESMTP id S263823AbUBEE5S
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 4 Feb 2004 23:57:18 -0500
Date: Wed, 4 Feb 2004 23:57:18 -0500 (EST)
From: Jim Faulkner <jfaulkne@ccs.neu.edu>
To: Andrew Morton <akpm@osdl.org>
Cc: linux-kernel@vger.kernel.org, kraxel@bytesex.org, davem@redhat.com,
       manmower@signalmarketing.com
Subject: Re: major network performance difference between 2.4 and 2.6.2-rc2
In-Reply-To: <20040204125444.3f2b5e79.akpm@osdl.org>
Message-ID: <Pine.GSO.4.58.0402042248300.27381@denali.ccs.neu.edu>
References: <Pine.GSO.4.58.0401302108560.1211@denali.ccs.neu.edu>
 <Pine.GSO.4.58.0402041529160.7454@denali.ccs.neu.edu> <20040204125444.3f2b5e79.akpm@osdl.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


On Wed, 4 Feb 2004, Andrew Morton wrote:

> Jim Faulkner <jfaulkne@ccs.neu.edu> wrote:
> >
> >
> > I am still experiencing severely degraded network performance under
> > 2.6.2-rc3 and 2.6.2-rc3-mm1.
>
> A kernel profile is needed.
>
> >  Based on some kernel output, I think this
> > problem may be related to Gerd Knorr's input patches, so I am CCing him on
> > this e-mail.
>
> Sounds unlikely.
>
> > Additionally, while large network transfers are going on, both ksoftirqd/0
> > and events/0 start going crazy, putting a huge load on my system:
> >
> >   PID USER      PR  NI  VIRT  RES  SHR S %CPU %MEM    TIME+  COMMAND
> >   3 root      35  19     0    0    0 S 45.9  0.0   0:46.98 ksoftirqd/0
> >   6 root       5 -10     0    0    0 S 43.3  0.0   1:56.63 events/0
> >   12008 dogshu 15   0  4800 2356 3828 S  5.3  0.2   0:05.98 proftpd
> >   12 root      15   0     0    0    0 S  0.3  0.0   0:00.41 pdflush
> >   9778 root    16   0  5888 1724 5516 R  0.3  0.2   0:00.12 sshd
> >
> > the load before that network transfer was 0.01, and the load after the
> > network transfer was 1.45.
>
> Could be a networking problem, but boy that's a lot of CPU time.
>

Thanks to Andrew's suggestion of profiling my kernel, I've figured out
what is happening here.  It is my fault, it is not a bug.

I use this iptables script generator:
http://ftp.berlios.de/pub/mldonkey/pango/goodies/ipblacklist_convert
in combination with this blacklist:
http://www.peerguardian.net/pgipdb/guarding.p2p

I had already modified the script so everything on my LAN interface was
accepted, however I didn't realize that the scipt was using "-I INPUT 1"
for all of its blacklist rules.  iptables was going through around 5300
rules for each and every packet that came in through my LAN interface,
which is definately not what I intended.

I fixed my firewall script, and my LAN throughput is back up at 10
megabytes per second, with nowhere near the load.

Sorry about that.  I'm not sure what the hauppauge messages are about, but
they're not the cause of my problem.

> > > Could be a networking problem, but boy that's a lot of CPU time.
> >
> > Andrew maybe something bolixed in the MAX_SOFTIRQ_RESTART stuff
> > we put into kernel/softirq.c?  Just a guess...
>
> Might be.  Jim, does a `patch -p1 -R' of the below help things?

I did try the patch before fixing my firewall rules.  ksoftirqd/0 was no
longer using alot of CPU time, however events/0 still was using alot of
CPU time, and of course my performance was still bad.

> Please, do this:
>
> - Boot with `profile=1' on the kernel command line
>
> sudo readprofile -r
> sudo readprofile -M10
> time <whatever command it is that is causing the problem>
> readprofile -n -v -m /boot/System.map | sort -n +2 | tail -40 | tee ~/log

If you're still curious, here is the output while I had my bad firewall
enabled:

c037a340 sock_def_readable                          1933  10.9830
c0149180 kmem_cache_free                            1954  20.3542
c03b3810 tcp_recvmsg                                2032   1.0672
c0174b20 do_select                                  2049   2.6680
c037aa30 skb_release_data                           2098  13.1125
c037a8e0 alloc_skb                                  2129   9.5045
c03ac190 ip_queue_xmit                              2181   1.6829
c01b62b0 is_leaf                                    2230   4.8060
c0174e50 sys_select                                 2274   1.7991
c03b1f70 tcp_sendmsg                                2679   0.5419
c037fb60 process_backlog                            2797   8.7406
c04110ff sysenter_past_esp                          2978  29.4851
c037f9b0 netif_receive_skb                          3115   7.2106
c03a61c0 ip_route_input                             3130   5.9280
c03b0810 tcp_poll                                   3208   8.3542
c012ca50 del_timer_sync                             3356  11.6528
c03a8700 ip_rcv                                     3429   2.6458
c03baf00 tcp_rcv_established                        3589   1.8538
c012c620 __mod_timer                                3835   6.3076
c037ab00 __kfree_skb                                3864  15.0938
c012c990 del_timer                                  3894  20.2812
c03a8c10 ip_local_deliver_finish                    4009   7.5928
c038a570 nf_iterate                                 4049  23.0057
c03bc6a0 tcp_transmit_skb                           4078   2.7114
c01491e0 kfree                                      4135  36.9196
c03e1b20 tcp_packet                                 4514   9.4042
c0163200 __find_get_block                           4607  22.1490
c0163b80 __block_prepare_write                      4860   4.5336
c0121640 __preempt_spin_lock                        4996  52.0417
c01b6590 search_by_key                              7268   1.9750
c02148f4 csum_partial                               8790  30.5208
c0215440 __copy_from_user_ll                       10875  84.9609
c03c4910 tcp_v4_rcv                                12975   5.4793
c011f760 __wake_up                                 15757 140.6875
c02153d0 __copy_to_user_ll                         17531 156.5268
c011efb0 schedule                                  18536  10.5318
c0116730 delay_tsc                                 25865 808.2812
c03e3730 ipt_do_table                             3933402 4552.5486
c0108c70 default_idle                             5633092 88017.0625
00000000 total                                    9915575   3.1080

sorry about the false alarm,
Jim Faulkner
