Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S264004AbSKRRsx>; Mon, 18 Nov 2002 12:48:53 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S264010AbSKRRsx>; Mon, 18 Nov 2002 12:48:53 -0500
Received: from e2.ny.us.ibm.com ([32.97.182.102]:48842 "EHLO e2.ny.us.ibm.com")
	by vger.kernel.org with ESMTP id <S264004AbSKRRsv>;
	Mon, 18 Nov 2002 12:48:51 -0500
Message-ID: <3DD92914.1060301@us.ibm.com>
Date: Mon, 18 Nov 2002 09:53:24 -0800
From: Dave Hansen <haveblue@us.ibm.com>
User-Agent: Mozilla/5.0 (compatible; MSIE5.5; Windows 98;
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: William Lee Irwin III <wli@holomorphy.com>
CC: "Martin J. Bligh" <mbligh@aracnet.com>, linux-kernel@vger.kernel.org,
       mingo@elte.hu, rml@tech9.net, riel@surriel.com, akpm@zip.com.au
Subject: Re: unusual scheduling performance
References: <20021118081854.GJ23425@holomorphy.com> <705474709.1037608454@[10.10.2.3]> <20021118165316.GK23425@holomorphy.com>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

William Lee Irwin III wrote:
> On Mon, Nov 18, 2002 at 08:34:34AM -0800, Martin J. Bligh wrote:
> 
>>1. make -j <what?>
>>2. profiles?
>>3. Can you try the latest set of NUMA sched patches posted by Eric Focht?
> 
> (1) make -j64 bzImage
> (2) doesn't sound useful for load balancing
> (3) sure

I'm seeing the same thing.  In my pagecache warmup test, I do 20 greps 
to pull in a 10-gig fileset.  Each grep works on 1/20th of the files.

For a long, long time, one the file set was warmed up, the time to do 
the test took ~14 secdonds:
Average Real: 14.0824
Average User: 0.94055
Average Sys:  5.20875
Full profile here:
http://www.sr71.net/prof/grep/run-grep-warm-2.5.47-11-15-2002-15.21.31/

As of 2.5.47, it looks like this:
Average Real: 18.9168
Average User: 1.0073
Average Sys:  4.9918
Full profile here: 
http://www.sr71.net/prof/grep/run-grep-warm-2.5.47-11-15-2002-15.58.02/

                                readprofile ticks
                                ------------------
                                fast   slow   diff
        page_cache_readahead:     93     82    -11
     __generic_file_aio_read:     73     83     10
                   file_move:     52     86     34
                 dget_locked:     57     87     30
               proc_pid_stat:    149     88    -61
        ep_notify_file_close:     59     89     30
                get_pid_list:     21     91     70
                update_atime:    100     93     -7
               get_unused_fd:     23    105     82
                        fget:    120    113     -7
                        dput:    100    120     20
              get_empty_filp:    105    121     16
                 system_call:    113    129     16
     rwsem_down_write_failed:           133    133
             vfs_follow_link:    116    164     48
             file_read_actor:    198    227     29
                      __fput:    178    241     63
           radix_tree_lookup:    324    293    -31
         atomic_dec_and_lock:    229    307     78
     .text.lock.dec_and_lock:    111    331    220
              try_to_wake_up:           374    374
                 kmap_atomic:    346    398     52
               kunmap_atomic:    379    409     30
                    vfs_read:    440    431     -9
            .text.lock.namei:    149    482    333
                  __d_lookup:    456    518     62
              link_path_walk:    533    710    177
                    schedule:      1   1060   1059
     do_generic_mapping_read:   1880   1846    -34
                   poll_idle:   2059  33416  31357
              __copy_to_user:  94208  87678  -6530
                       total: 104173 132206  28033

So, schedule() is being called a _lot_ more.  But, for some reason, 
the slower one wasn't caught doing __copy_to_user() as much.

Bill, does this look like what you're seeing?
-- 
Dave Hansen
haveblue@us.ibm.com

