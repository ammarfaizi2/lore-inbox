Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262875AbSKYK7h>; Mon, 25 Nov 2002 05:59:37 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262876AbSKYK7h>; Mon, 25 Nov 2002 05:59:37 -0500
Received: from packet.digeo.com ([12.110.80.53]:63142 "EHLO packet.digeo.com")
	by vger.kernel.org with ESMTP id <S262875AbSKYK7g>;
	Mon, 25 Nov 2002 05:59:36 -0500
Message-ID: <3DE20443.FA5010C8@digeo.com>
Date: Mon, 25 Nov 2002 03:06:43 -0800
From: Andrew Morton <akpm@digeo.com>
X-Mailer: Mozilla 4.79 [en] (X11; U; Linux 2.5.46 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: bert hubert <ahu@ds9a.nl>
CC: Paolo Ciarrocchi <ciarrocchi@linuxmail.org>, linux-kernel@vger.kernel.org
Subject: Re: [Benchmark] AIM results
References: <20021124212337.30844.qmail@linuxmail.org> <3DE1FF62.18F7071B@digeo.com> <20021125105446.GA30842@outpost.ds9a.nl>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
X-OriginalArrivalTime: 25 Nov 2002 11:06:44.0412 (UTC) FILETIME=[BD5F57C0:01C29472]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

bert hubert wrote:
> 
> On Mon, Nov 25, 2002 at 02:45:54AM -0800, Andrew Morton wrote:
> 
> > > tcp_test 10000 805.5        72495.00 TCP/IP Messages/second
> > > tcp_test 10000 660.7        59463.00 TCP/IP Messages/second
> > > ^^^^^ Here 2.4.19 is faster then 2.5.49 (debug?)
> > >
> > > udp_test 10000 1448.6       144860.00 UDP/IP DataGrams/second
> > > udp_test 10000 1115.7       111570.00 UDP/IP DataGrams/second
> > > ^^^^^ Here 2.4.19 is faster then 2.5.49 (debug?)
> >
> > Not sure what's going on here, really.  Lots of tiny TCP and UDP
> > copies to localhost.  The profiles are splattered all over the place.
> > Networking just generally seems to have increased its cache footprint.
> 
> Dave has said there is debugging code in 2.5 that slows down traffic on
> localhost.

Yes, but that is not apparent in the profiles with this test. It
really is just all over the map. It looks like just longer code
paths touching more memory.

Here's the uniproc profile for tcp_test.  This sends small packets
to localhost - various sizes up to 512 bytes.  The instruction-level
profile showed nothing obvious either.



c026cc5c 81       0.952493    tcp_v4_send_check
c011f06c 83       0.976011    mod_timer
c02593e0 84       0.98777     ip_output
c0248344 86       1.01129     skb_clone
c026870c 86       1.01129     __tcp_select_window
c026d934 88       1.03481     tcp_v4_do_rcv
c010ef20 95       1.11712     do_gettimeofday
c013ea2c 95       1.11712     vfs_write
c024c13c 95       1.11712     net_rx_action
c026bb78 97       1.14064     __tcp_v4_lookup_established
c01cad6c 100      1.17592     __copy_user_intel
c0247f68 106      1.24647     skb_head_to_pool
c02480ec 106      1.24647     skb_headerinit
c0256e90 109      1.28175     ip_local_deliver
c011c5e0 111      1.30527     do_softirq
c025d6b4 111      1.30527     tcp_push
c0247fb8 118      1.38758     alloc_skb
c01cae10 119      1.39934     __copy_user_zeroing_intel
c0259148 119      1.39934     ip_finish_output2
c0264288 120      1.4111      tcp_ack
c02684d0 127      1.49341     tcp_write_xmit
c010a99c 137      1.61101     system_call
c024b998 137      1.61101     dev_queue_xmit
c0247f18 151      1.77563     skb_head_from_pool
c0250fac 151      1.77563     eth_type_trans
c024bf14 153      1.79915     netif_receive_skb
c01fff88 163      1.91675     loopback_xmit
c0263d18 167      1.96378     tcp_clean_rtx_queue
c0130b4c 178      2.09313     kmalloc
c024bc8c 178      2.09313     netif_rx
c024c03c 182      2.14017     process_backlog
c0266290 203      2.38711     tcp_rcv_established
c0256fec 239      2.81044     ip_rcv
c026da7c 251      2.95155     tcp_v4_rcv
c0259458 287      3.37488     ip_queue_xmit
c025f46c 309      3.63358     tcp_recvmsg
c025e27c 317      3.72766     tcp_sendmsg
c02674c4 376      4.42145     tcp_transmit_skb
