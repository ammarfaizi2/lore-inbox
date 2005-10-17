Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932306AbVJQTNE@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932306AbVJQTNE (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 17 Oct 2005 15:13:04 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932308AbVJQTNE
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 17 Oct 2005 15:13:04 -0400
Received: from mf01.sitadelle.com ([212.94.174.68]:52353 "EHLO
	smtp.cegetel.net") by vger.kernel.org with ESMTP id S932306AbVJQTNC
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 17 Oct 2005 15:13:02 -0400
Message-ID: <4353F7B5.1040101@cosmosbay.com>
Date: Mon, 17 Oct 2005 21:12:53 +0200
From: Eric Dumazet <dada1@cosmosbay.com>
User-Agent: Mozilla Thunderbird 1.0 (Windows/20041206)
X-Accept-Language: fr, en
MIME-Version: 1.0
To: Linus Torvalds <torvalds@osdl.org>
Cc: dipankar@in.ibm.com, Jean Delvare <khali@linux-fr.org>,
       Serge Belyshev <belyshev@depni.sinp.msu.ru>,
       LKML <linux-kernel@vger.kernel.org>, Andrew Morton <akpm@osdl.org>,
       Manfred Spraul <manfred@colorfullife.com>
Subject: Re: VFS: file-max limit 50044 reached
References: <Pine.LNX.4.64.0510161912050.23590@g5.osdl.org> <JTFDVq8K.1129537967.5390760.khali@localhost> <20051017084609.GA6257@in.ibm.com> <43536A6C.102@cosmosbay.com> <20051017103244.GB6257@in.ibm.com> <Pine.LNX.4.64.0510170829000.23590@g5.osdl.org> <4353CADB.8050709@cosmosbay.com> <Pine.LNX.4.64.0510170911370.23590@g5.osdl.org> <20051017162930.GC13665@in.ibm.com> <4353E6F1.8030206@cosmosbay.com> <Pine.LNX.4.64.0510171112040.3369@g5.osdl.org>
In-Reply-To: <Pine.LNX.4.64.0510171112040.3369@g5.osdl.org>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Linus Torvalds a écrit :
> 
> On Mon, 17 Oct 2005, Eric Dumazet wrote:
> 
>><lazy_mode=ON>
>>Do we really need a TIF_RCUUPDATE flag, or could we just ask for a resched ?
>></lazy_mode>
> 
> 
> Hmm.. Your patch looks very much like one I tried already, but the big 
> difference being that I just cleared the count when doing the rcu 
> callback. That was because I hadn't realized the importance of the 
> maxbatch thing (so it didn't work for me, like it did for you).
> 
> Still - the actual RCU callback will only be called at the next timer tick 
> or whatever as far as I can tell, so the first time you'll still have a 
> _long_ RCU queue (and thus bad latency).
> 
> I guess that's inevitable - and TIF_RCUUPDATE wouldn't even help, because 
> we still need to wait for the _other_ CPU's to get to their RCU quiescent 
> event.
> 
> However, that leaves us with the nasty situation that we'll ve very 
> inefficient: we'll do "maxbatch" RCU entries, and then return, and then 
> force a whole re-schedule. That just can't be good.
>

Thats strange, because on my tests it seems that I dont have one reschedule 
for 'maxbatch' items. Doing 'grep filp /proc/slabinfo' it seems I have one 
'schedule' then filp count goes back to 1000.

vmstat shows about 150 context switches per second.

(This machines does 1.000.000 pair of open/close in 4.88 seconds)

oprofile data shows verly little schedule overhead :

CPU: P4 / Xeon with 2 hyper-threads, speed 1993.83 MHz (estimated)
Counted GLOBAL_POWER_EVENTS events (time during which processor is not 
stopped) with a unit mask of 0x01 (mandatory) count 100000
samples  %        symbol name
132578   11.3301  path_lookup
104788    8.9551  __d_lookup
85220     7.2829  link_path_walk
63013     5.3851  sysenter_past_esp
53287     4.5539  _atomic_dec_and_lock
45825     3.9162  chrdev_open
43105     3.6837  get_unused_fd
39948     3.4139  kmem_cache_alloc
38308     3.2738  strncpy_from_user
35738     3.0542  rcu_do_batch
31850     2.7219  __link_path_walk
31355     2.6796  get_empty_filp
25941     2.2169  kmem_cache_free
24455     2.0899  __fput
24422     2.0871  sys_close
19814     1.6933  filp_dtor
19616     1.6764  free_block
19000     1.6237  open_namei
18214     1.5566  fput
15991     1.3666  fd_install
14394     1.2301  file_kill
14365     1.2276  call_rcu
14338     1.2253  kref_put
13679     1.1690  file_move
13646     1.1662  schedule
13456     1.1499  getname
13019     1.1126  kref_get



> How about instead of depending on "maxbatch", we'd depend on 
> "need_resched()"? Mabe the "maxbatch" be a _minbatch_ thing, and then once 
> we've done the minimum amount we _need_ to do (or emptied the RCU queue) 
> we start honoring need_resched(), and return early if we do? 
> 
> That, together with your patch, should work, without causing ludicrous 
> "reschedule every ten system calls" behaviour..
> 
> Hmm?
> 
> 		Linus
> 
> 

