Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129436AbRCWDvd>; Thu, 22 Mar 2001 22:51:33 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129446AbRCWDvX>; Thu, 22 Mar 2001 22:51:23 -0500
Received: from chromium11.wia.com ([207.66.214.139]:777 "EHLO
	neptune.kirkland.local") by vger.kernel.org with ESMTP
	id <S129436AbRCWDvL>; Thu, 22 Mar 2001 22:51:11 -0500
Message-ID: <3ABAC8D4.B464EB9B@chromium.com>
Date: Thu, 22 Mar 2001 19:53:57 -0800
From: Fabio Riccardi <fabio@chromium.com>
X-Mailer: Mozilla 4.76 [en] (X11; U; Linux 2.4.2 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: "David S. Miller" <davem@redhat.com>, Zach Brown <zab@zabbo.net>
CC: linux-kernel@vger.kernel.org
Subject: Re: user space web server accelerator support
In-Reply-To: <3AB6D0A5.EC4807E3@chromium.com>
		<15030.54194.780246.320476@pizda.ninka.net>
		<3AB6D574.8C123AE9@chromium.com> <15030.54685.535763.403057@pizda.ninka.net>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Dave, Zach,

thanks for your help, I've implemented a file descriptor passing mechanism
very similar to that of Zach's and it worked.

The problem now is performance, fd passing is utterly slow!

On my system (a 1GHz Pentium III + 2G RAM) I can do 1300 SpecWeb99 with a
khttp-like socket passing mechanism, while I only get something like 500 using
file descriptor passing. Indeed with fd passing I decrease Apache's
performance instead of increasing it!

I've checked my code several times and I don't believe that I have introduced
any specific bottleneck of my own (the code actually is quite trivial).

I've profiled the kernel and some interesting differences show:

With direct socket passing, 1300 SpecWeb load:

  9759 total                                      0.0071
   902 handle_IRQ_event                           7.5167
   256 skb_clone                                  0.6957
   256 do_tcp_sendpages                           0.0954
   239 tcp_v4_rcv                                 0.1572
   238 schedule                                   0.1766
   226 __kfree_skb                                0.9741
   207 skb_release_data                           1.7845
   204 tcp_transmit_skb                           0.1541
   199 d_lookup                                   0.6910
   190 path_walk                                  0.0973
   181 ip_output                                  0.6754
   168 fget                                       2.2105
   165 do_softirq                                 1.1786
   158 do_generic_file_read                       0.1287

With file descriptor passing, 500 SpecWeb load:

  8621 total                                      0.0063
  7037 schedule                                   5.2203
   462 handle_IRQ_event                           3.8500
   188 __wake_up                                  0.9216
   114 unix_stream_data_wait                      0.4191
    81 __switch_to                                0.3750
    58 schedule_timeout                           0.3718
    25 d_lookup                                   0.0868
    20 skb_clone                                  0.0543
    19 path_walk                                  0.0097
    17 tcp_transmit_skb                           0.0128
    17 do_tcp_sendpages                           0.0063
    17 do_softirq                                 0.1214
    15 system_call                                0.2679
    15 sys_rt_sigtimedwait                        0.0207

Zach, have you ever noticed such a performance bottleneck in your phhttpd?

SpecWeb has about 30% of its load as dynamic requests, so the amount of
forwarding is definitively significative in my case. Sime time ago I measured
khttp's impact in socket passing and I found that it was negligible
(forwarding everything to Apache instead of having it directly listening on
the socket had an impact of a few percent).

My impression from a first look to the profiling data is that the kernel is
doing a very poor job of scheduling and is ping-ponging between processes...
like it is not doing any buffering whatsoever and it is doing a contect switch
for every passed file descriptor.

Any thoughts?

 - Fabio


