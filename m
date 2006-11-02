Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1752790AbWKBLda@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752790AbWKBLda (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 2 Nov 2006 06:33:30 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752833AbWKBLda
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 2 Nov 2006 06:33:30 -0500
Received: from pfx2.jmh.fr ([194.153.89.55]:27850 "EHLO pfx2.jmh.fr")
	by vger.kernel.org with ESMTP id S1752790AbWKBLd3 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 2 Nov 2006 06:33:29 -0500
From: Eric Dumazet <dada1@cosmosbay.com>
To: Evgeniy Polyakov <johnpol@2ka.mipt.ru>
Subject: Re: [take22 0/4] kevent: Generic event handling mechanism.
Date: Thu, 2 Nov 2006 12:33:26 +0100
User-Agent: KMail/1.9.5
Cc: zhou drangon <drangon.mail@gmail.com>, linux-kernel@vger.kernel.org
References: <20061101160551.GA2598@elf.ucw.cz> <4549A9EF.9000303@cosmosbay.com> <20061102084608.GB22909@2ka.mipt.ru>
In-Reply-To: <20061102084608.GB22909@2ka.mipt.ru>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="utf-8"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200611021233.26768.dada1@cosmosbay.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thursday 02 November 2006 09:46, Evgeniy Polyakov wrote:

> By poll design we have to setup following data:
> poll_table_struct, which contains a callback
> that callback will be called in each
> sys_poll()->drivers_poll()->poll_wait(),
> callback will allocate new private structure, which must have
> wait_queue_t (it's callback will be invoked each time wake_up() is
> called for given wait_queue_head), which should be linked to the given
> wait_queue_head.

In epoll case, the setup is done at epoll_ctl() time, not for each event 
received by the consumer like poll()/select()

As for wake_up() overhead, I feel it's necessary if we want to wakeup a 
consumer (tell him some events are availlable)

I suspect benchmark results might depend for a large part on some 'features' 
of the scheduler, or the number of events provider and CPU cache size, not on 
inherent limitations of epoll.

I changed a litle bit epoll_pipe_bench and we can see effects of scheduling on 
the overall rate of events per second.

I can now receive 350.000 events per second, instead of 230.000

Tests done on my laptop : a UP machine (Intel(R) Pentium(R) M processor 
1.60GHz) (Dell latitude D610)

# ./epoll_pipe_bench -n 1000 -l 1
1000 pipes setup
223065 evts/sec 1.00563 samples per call
228508 evts/sec 1.00277 samples per call
229076 evts/sec 1.00184 samples per call
227860 evts/sec 1.00191 samples per call
229498 evts/sec 1.00153 samples per call
228027 evts/sec 1.00136 samples per call
229465 evts/sec 1.00122 samples per call
227845 evts/sec 1.00132 samples per call
227456 evts/sec 1.00118 samples per call
228355 evts/sec 1.00113 samples per call

# ./epoll_pipe_bench -n 1000 -l 10
1000 pipes setup
328599 evts/sec 314.75 samples per call
344947 evts/sec 314.447 samples per call
342844 evts/sec 314.185 samples per call
345486 evts/sec 314.013 samples per call
345144 evts/sec 314.079 samples per call
344270 evts/sec 313.989 samples per call
344249 evts/sec 314.004 samples per call
320577 evts/sec 326.967 samples per call
313990 evts/sec 343.926 samples per call
313578 evts/sec 359.034 samples per call

In oprofile, It's not obvious epoll is responsible for cpu costs...

CPU: PIII, speed 1600 MHz (estimated)
Counted CPU_CLK_UNHALTED events (clocks processor is not halted) with a unit 
mask of 0x00 (No unit mask) count 50000
samples  %        symbol name
206966    7.9385  sysenter_past_esp
158337    6.0733  _spin_lock_irqsave
143339    5.4980  pipe_writev
137434    5.2715  fget_light
132293    5.0743  _spin_unlock_irqrestore
109593    4.2036  pipe_readv
102669    3.9380  ep_poll_callback
99801     3.8280  dnotify_parent
99388     3.8122  sys_epoll_wait
98710     3.7862  vfs_write
94560     3.6270  _write_lock_irqsave
91774     3.5201  current_fs_time
90541     3.4728  pipe_poll
89153     3.4196  _spin_lock
85150     3.2661  __wake_up
83213     3.1918  __wake_up_common
72913     2.7967  try_to_wake_up
67996     2.6081  rw_verify_area
64243     2.4641  file_update_time
54211     2.0793  vfs_read


But but but ! If I add more pipes, results are reversed, because CPU cache is 
not large enough : It's better to deliver events as fast as possible to 
consumer to keep hot caches (but only on UP machine, and because my test prog 
is threaded. If it was using two process, context switch would be more 
expensive)


# ./epoll_pipe_bench -n 10000 -l 1
10000 pipes setup
171444 evts/sec 1 samples per call
174556 evts/sec 1 samples per call
173976 evts/sec 1 samples per call
174715 evts/sec 1.00003 samples per call
173215 evts/sec 1.00478 samples per call
174930 evts/sec 1.00397 samples per call

# ./epoll_pipe_bench -n 10000 -l 10
10000 pipes setup
149701 evts/sec 759.904 samples per call
153476 evts/sec 767.537 samples per call
149217 evts/sec 767.585 samples per call
152396 evts/sec 763.624 samples per call
153517 evts/sec 762.215 samples per call
148026 evts/sec 763.434 samples per call

CPU: PIII, speed 1600 MHz (estimated)
Counted CPU_CLK_UNHALTED events (clocks processor is not halted) with a unit 
mask of 0x00 (No unit mask) count 50000
samples  %        symbol name
404924   12.4647  pipe_poll
263399    8.1081  pipe_writev
259230    7.9798  rw_verify_area
246368    7.5839  fget_light
242360    7.4605  sys_epoll_wait
174913    5.3843  kmap_atomic
168623    5.1907  __wake_up_common
147661    4.5454  ep_poll_callback
137003    4.2173  pipe_readv
128799    3.9648  _spin_lock_irqsave
100015    3.0787  sysenter_past_esp
74031     2.2789  __copy_to_user_ll
72857     2.2427  file_update_time
69523     2.1401  vfs_write
69444     2.1377  mutex_lock


I also added a -f flag, to bypass epoll completely and measure the 
pipe/read/write overhead/performance.

# ./epoll_pipe_bench -n 10000 -f
10000 pipes setup
300230 evts/sec
309770 evts/sec
264426 evts/sec
265842 evts/sec
265551 evts/sec
266814 evts/sec
266551 evts/sec
264415 evts/sec

