Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261545AbSKRSpm>; Mon, 18 Nov 2002 13:45:42 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S263204AbSKRSpm>; Mon, 18 Nov 2002 13:45:42 -0500
Received: from packet.digeo.com ([12.110.80.53]:34504 "EHLO packet.digeo.com")
	by vger.kernel.org with ESMTP id <S261545AbSKRSpl>;
	Mon, 18 Nov 2002 13:45:41 -0500
Message-ID: <3DD936F4.EDA4968A@digeo.com>
Date: Mon, 18 Nov 2002 10:52:36 -0800
From: Andrew Morton <akpm@digeo.com>
X-Mailer: Mozilla 4.79 [en] (X11; U; Linux 2.5.46 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: Davide Libenzi <davidel@xmailserver.org>
CC: Dave Hansen <haveblue@us.ibm.com>,
       William Lee Irwin III <wli@holomorphy.com>,
       "Martin J. Bligh" <mbligh@aracnet.com>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       Ingo Molnar <mingo@elte.hu>, Robert Love <rml@tech9.net>,
       riel@surriel.com
Subject: Re: unusual scheduling performance
References: <3DD92E92.EEB9ECD6@digeo.com> <Pine.LNX.4.44.0211181031400.979-100000@blue1.dev.mcafeelabs.com>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
X-OriginalArrivalTime: 18 Nov 2002 18:52:36.0177 (UTC) FILETIME=[A907F410:01C28F33]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Davide Libenzi wrote:
> 
> On Mon, 18 Nov 2002, Andrew Morton wrote:
> 
> > Dave Hansen wrote:
> > >
> > > ...
> > >      rwsem_down_write_failed:           133    133
> >
> > Possible culprit.
> >
> > Please stick a dump_stack() in rwsem_down_write_failed(), and add the below.
> > Suggest you stick with 2.5.47 to diagnose this.  The loss of kksymoops
> > is a pain.
> >
> >
> >  fs/eventpoll.c |    2 ++
> >  1 files changed, 2 insertions(+)
> >
> > --- 25/fs/eventpoll.c~hey     Mon Nov 18 10:13:40 2002
> > +++ 25-akpm/fs/eventpoll.c    Mon Nov 18 10:14:01 2002
> > @@ -328,6 +328,8 @@ void eventpoll_release(struct file *file
> >       if (list_empty(lsthead))
> >               return;
> >
> > +     printk("hey!\n");
> > +
> 
> Andrew, if you don't use epoll there's no way you get there.

Yup.  That was a random stab based on recently-added down_write()
calls.

However the down_write isn't there in 2.5.47 so that's a false
lead.  We'll need that dump_stack() output.

Here's Dave's profile.  ep_notify_file_close() makes a small appearance.
The change you made to 2.5.48 will wipe that out.  Neat.


  0.058%       78 locks_remove_flock
  0.062%       82 page_cache_readahead
  0.062%       83 __generic_file_aio_read
  0.065%       86 file_move
  0.065%       87 dget_locked
  0.066%       88 proc_pid_stat
  0.067%       89 ep_notify_file_close
  0.068%       91 get_pid_list
  0.070%       93 update_atime
  0.079%      105 get_unused_fd
  0.085%      113 fget
  0.090%      120 dput
  0.091%      121 get_empty_filp
  0.097%      129 system_call
  0.100%      133 rwsem_down_write_failed
  0.124%      164 vfs_follow_link
  0.171%      227 file_read_actor
  0.182%      241 __fput
  0.221%      293 radix_tree_lookup
  0.232%      307 atomic_dec_and_lock
  0.250%      331 .text.lock.dec_and_lock
  0.282%      374 try_to_wake_up
  0.301%      398 kmap_atomic
  0.309%      409 kunmap_atomic
  0.326%      431 vfs_read
  0.364%      482 .text.lock.namei
  0.391%      518 __d_lookup
  0.537%      710 link_path_walk
  0.801%     1060 schedule
  1.396%     1846 do_generic_mapping_read
 25.275%    33416 poll_idle
 66.319%    87678 __copy_to_user
100.000%   132206 total
