Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261773AbTCaSs4>; Mon, 31 Mar 2003 13:48:56 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261789AbTCaSs4>; Mon, 31 Mar 2003 13:48:56 -0500
Received: from bi01p1.co.us.ibm.com ([32.97.110.142]:45720 "EHLO
	dyn9-47-17-83.beaverton.ibm.com") by vger.kernel.org with ESMTP
	id <S261773AbTCaSsp>; Mon, 31 Mar 2003 13:48:45 -0500
Message-ID: <3E8889B4.FB716506@us.ibm.com>
Date: Mon, 31 Mar 2003 10:32:20 -0800
From: Janet Morgan <janetmor@us.ibm.com>
Reply-To: janetmor@us.ibm.com
X-Mailer: Mozilla 4.79 [en] (X11; U; Linux 2.4.18-3 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: akpm@digeo.com
CC: suparna@in.ibm.com, bcrl@redhat.com, linux-aio@kvack.org,
       linux-kernel@vger.kernel.org
Subject: Re: [Patch 2/2] Retry based aio read - filesystem read changes
References: <20030305144754.A1600@in.ibm.com> <20030305150026.B1627@in.ibm.com> <20030305024254.7f154afc.akpm@digeo.com> <20030305174452.A1882@in.ibm.com>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> On Wed, Mar 05, 2003 at 02:42:54AM -0800, Andrew Morton wrote:
>  > Suparna Bhattacharya <suparna@in.ibm.com> wrote:
>  >
>  > +extern int FASTCALL(aio_wait_on_page_bit(struct page *page, int bit_nr));
>  > +static inline int aio_wait_on_page_locked(struct page *page)
>
>  Oh boy.
>
>  There are soooo many more places where we can block:
>
>  - write() -> down(&inode->i_sem)
>
>  - read()/write() -> read indirect block -> wait_on_buffer()
>
>  - read()/write() -> read bitmap block -> wait_on_buffer()
>
>  - write() -> allocate block -> mark_buffer_dirty() ->
>     balance_dirty_pages() -> writer throttling
>
>  - write() -> allocate block -> journal_get_write_access()
>
>  - read()/write() -> update_a/b/ctime() -> journal_get_write_access()
>
>  - ditto for other journalling filesystems
>
>  - read()/write() -> anything -> get_request_wait()
>    (This one can be avoided by polling the backing_dev_info congestion
>     flags)
>
>  - read()/write() -> page allocator -> blk_congestion_wait()
>
>  - write() -> balance_dirty_pages() -> writer throttling
>
>  - probably others.
>
>  Now, I assume that what you're looking for here is an 80% solution, but it
>  seems that a lot more changes will be needed to get even that far.

I'm trying to identify significant blocking points in the filesystem read
path.  I'm not sure what the best approach is, so figured I'd just track
callers of schedule() under a heavy dd workload.

I collected data while running 1000 processes, where each process was
using dd to sequentially read from a 1GB file.  I used 10 target files
in all, so 100 processes read from file1, 100 processes read from file2,
etc.  All these numbers were pretty much arbitrary.  I used stock 2.5.62
to test.

The top 3 callers of schedule based on my dd read workload are listed
below.  Together they accounted for 92% of all calls to schedule.
Suparna's filesystem aio patch already modifies 2 of these 3 callpoints
to be "retryable".  So the remaining candidate is the call to cond_resched
from do_generic_mapping_read.  Question is whether this qualifies as the
sort of thing that should cause a retry, i.e., is cond_resched a kind of
voluntary yield/preemption point which may not even result in a context
switch if there is nothing more preferable to run?   And even if the call to
cond_resched is not cause for retry, the profile data seems to indicate that
Suparna's patch is roughly an 80% solution (unless I'm missing something here,
which is entirely possible ;-).

So here are the call statistics:

  70% of all calls to schedule were from __lock_page:
        Based on the profile data, almost all calls to _lock_page were
        from do_generic_mapping_read (see filemap.c/Line 101 below).
        Suparna's patch already retries here.

  15% of all calls to schedule were from __cond_resched:
        do_generic_mapping_read -> cond_resched -> __cond_resched
        (see filemap.c/Line 41 below).
        Should this be made retryable ???

   7% of all calls to schedule were from wait_on_page_bit:
        Based on the profile data, almost all calls to wait_on_page_bit were
        from do_generic_mapping_read->wait_on_page_locked -> wait_on_page_bit
        (see filemap.c/Line 123 below).  Suparna's patch covers this
        callpoint, too.


Here's some detail....

Callers of schedule()

     7768210  Total calls to schedule
   ------------
     5440195  __lock_page+176
     1143862  do_generic_mapping_read+d6
      569139  wait_on_page_bit+17e
      488273  work_resched+5
       43414  __wait_on_buffer+14a
       23594  blk_congestion_wait+99
       21171  worker_thread+14f
        9838  cpu_idle+6d
        6308  do_select+29b
        5178  schedule_timeout+b8
        4136  sys_sched_yield+d9
        2096  kswapd+122
        1796  sleep_on+55
        1767  sys_nanosleep+f8
        1655  do_exit+4eb
        1643  wait_for_completion+d2
        1365  interruptible_sleep_on+55
        1034  pipe_wait+98
        1004  balanced_irq+6d
         975  ksoftirqd+108
         971  journal_stop+107
         884  sys_wait4+2ff
         780
         658  unix_wait_for_peer+d6
         576  read_chan+52c
         580  __pdflush+d2
         105  do_poll+ec
         102  __down+9e
          71  tty_wait_until_sent+f2
          59  ksoftirqd+b5
          55  __down_interruptible+d8
          41
          16  migration_thread+cc
          10  uart_wait_until_sent+d6
           9  unix_stream_data_wait+109
           8  tcp_data_wait+16c
           4  wait_for_packet+140
           3  wait_til_done+110
           2  write_chan+280
           2  generic_file_aio_write_nolock+bf4
           2  journal_commit_transaction+97a
           1  usb_hub_thread+c0
           1  jfs_lazycommit+1c6
           1  serio_thread+e0
           1  jfs_sync+259
           1  jfsIOWait+15d
           1  _lock_fdc+12f
           1  acpi_ex_system_do_suspend+3d
           1  init_pcmcia_ds+25e


readprofile:

10058989 total                                  2.9520
5982060 __copy_to_user_ll                       41542.0833
928000 do_generic_mapping_read                  698.7952
447968 poll_idle                                4666.3333
301263 file_read_actor                          1176.8086
265660 radix_tree_lookup                        1844.8611
209991 page_cache_readahead                     410.1387
129655 vfs_read                                 311.6707
117666 kmap_atomic                              919.2656
111874 fget                                     1165.3542
110996 __generic_file_aio_read                  182.5592
109402 kunmap_atomic                            3418.8125
 95092 vfs_write                                228.5865
 76119 mark_page_accessed                       679.6339
 69564 current_kernel_time                      724.6250
 52569 fput                                     1095.1875
 51824 update_atime                             231.3571
 51375 activate_page                            267.5781
 46577 scsi_request_fn                           61.9375
 41731 generic_file_read                        237.1080
 39300 shrink_cache                              38.9881
 37658 schedule                                  26.1514
 37501 refill_inactive_zone                      22.3220
 37325 scsi_dispatch_cmd                         70.6913
 32762 unlock_page                              292.5179
 31924 buffered_rmqueue                          86.7500
 30454 __make_request                            21.3862
 28532 do_page_cache_readahead                   54.0379
 27783 delay_tsc                                434.1094
 27723 ext2_get_branch                           69.3075
 25726 shrink_list                               13.1793
 25246 __find_get_block                          63.1150
 24443 mpage_end_io_read                        169.7431
 23800 add_to_page_cache                         87.5000
 20669 do_softirq                                71.7674
 19895 system_call                              452.1591
 18906 do_mpage_readpage                         14.4101
 18783 page_referenced                           73.3711
 18137 free_hot_cold_page                        59.6612
 18015 __wake_up                                225.1875
 13790 radix_tree_insert                         53.8672
 11227 radix_tree_delete                         31.8949
 11188 __alloc_pages                             11.4631
 10885 __brelse                                 136.0625
 10699 write_null                               668.6875
 10299 __pagevec_lru_add                         35.7604
 10100 page_address                              42.0833
  9968 ext2_get_block                             7.5976


2.5.62 filemap.c/do_generic_mapping_read:
     1  /*
     2   * This is a generic file read routine, and uses the
     3   * inode->i_op->readpage() function for the actual low-level
     4   * stuff.
     5   *
     6   * This is really ugly. But the goto's actually try to clarify some
     7   * of the logic when it comes to error handling etc.
     8   * - note the struct file * is only passed for the use of readpage
     9   */
    10  void do_generic_mapping_read(struct address_space *mapping,
    11                               struct file_ra_state *ra,
    12                               struct file * filp,
    13                               loff_t *ppos,
    14                               read_descriptor_t * desc,
    15                               read_actor_t actor)
    16  {
    17          struct inode *inode = mapping->host;
    18          unsigned long index, offset;
    19          struct page *cached_page;
    20          int error;
    21
    22          cached_page = NULL;
    23          index = *ppos >> PAGE_CACHE_SHIFT;
    24          offset = *ppos & ~PAGE_CACHE_MASK;
    25
    26          for (;;) {
    27                  struct page *page;
    28                  unsigned long end_index, nr, ret;
    29
    30                  end_index = inode->i_size >> PAGE_CACHE_SHIFT;
    31
    32                  if (index > end_index)
    33                          break;
    34                  nr = PAGE_CACHE_SIZE;
    35                  if (index == end_index) {
    36                          nr = inode->i_size & ~PAGE_CACHE_MASK;
    37                          if (nr <= offset)
    38                                  break;
    39                  }
    40
    41                  cond_resched();
    42                  page_cache_readahead(mapping, ra, filp, index);
    43
    44                  nr = nr - offset;
    45
    46                  /*
    47                   * Try to find the data in the page cache..
    48                   */
    49  find_page:
    50                  read_lock(&mapping->page_lock);
    51                  page = radix_tree_lookup(&mapping->page_tree, index);
    52                  if (!page) {
    53                          read_unlock(&mapping->page_lock);
    54                          handle_ra_miss(mapping,ra);
    55                          goto no_cached_page;
    56                  }
    57                  page_cache_get(page);
    58                  read_unlock(&mapping->page_lock);
    59
    60                  if (!PageUptodate(page))
    61                          goto page_not_up_to_date;
    62  page_ok:
    63                  /* If users can be writing to this page using arbitrary
    64                   * virtual addresses, take care about potential aliasing
    65                   * before reading the page on the kernel side.
    66                   */
    67                  if (!list_empty(&mapping->i_mmap_shared))
    68                          flush_dcache_page(page);
    69
    70                  /*
    71                   * Mark the page accessed if we read the beginning.
    72                   */
    73                  if (!offset)
    74                          mark_page_accessed(page);
    75
    76                  /*
    77                   * Ok, we have the page, and it's up-to-date, so
    78                   * now we can copy it to user space...
    79                   *
    80                   * The actor routine returns how many bytes were actually
used..
    81                   * NOTE! This may not be the same as how much of a user
buffer
    82                   * we filled up (we may be padding etc), so we can only
update
    83                   * "pos" here (the actor routine has to update the user
buffer
    84                   * pointers and the remaining count).
    85                   */  86                  ret = actor(desc, page, offset,
nr);
    87                  offset += ret;
    88                  index += offset >> PAGE_CACHE_SHIFT;
    89                  offset &= ~PAGE_CACHE_MASK;
    90
    91                  page_cache_release(page);
    92                  if (ret == nr && desc->count)
    93                          continue;
    94                  break;
    95
    96  page_not_up_to_date:
    97                  if (PageUptodate(page))
    98                          goto page_ok;
    99
   100                  /* Get exclusive access to the page ... */
   101                  lock_page(page);
   102
   103                  /* Did it get unhashed before we got the lock? */
   104                  if (!page->mapping) {
   105                          unlock_page(page);
   106                          page_cache_release(page);
   107                          continue;
   108                  }
   109
   110                  /* Did somebody else fill it already? */
   111                  if (PageUptodate(page)) {
   112                          unlock_page(page);
   113                          goto page_ok;
   114                  }
   115
   116  readpage:
   117                  /* ... and start the actual read. The read will unlock the
page. */
   118                  error = mapping->a_ops->readpage(filp, page);
   119
   120                  if (!error) {
   121                          if (PageUptodate(page))
   122                                  goto page_ok;
   123                          wait_on_page_locked(page);
   124                          if (PageUptodate(page))
   125                                  goto page_ok;
   126                          error = -EIO;
   127                  }
   128
   129                  /* UHHUH! A synchronous read error occurred. Report it */
   130                  desc->error = error;
   131                  page_cache_release(page);
   132                  break;
   133
   134  no_cached_page:
   135                  /*
   136                   * Ok, it wasn't cached, so we need to create a new
   137                   * page..
   138                   */
   139                  if (!cached_page) {
   140                          cached_page = page_cache_alloc_cold(mapping);
   141                          if (!cached_page) {
   142                                  desc->error = -ENOMEM;
   143                                  break;
   144                          }
   145                  }
   146                  error = add_to_page_cache_lru(cached_page, mapping,
   147                                                  index, GFP_KERNEL);
   148                  if (error) {
   149                          if (error == -EEXIST)
   150                                  goto find_page;
   151                          desc->error = error;
   152                          break;
   153                  }
   154                  page = cached_page;
   155                  cached_page = NULL;
   156                  goto readpage;
   157          }
   158
   159          *ppos = ((loff_t) index << PAGE_CACHE_SHIFT) + offset;
   160          if (cached_page)
   161                  page_cache_release(cached_page);
   162          UPDATE_ATIME(inode);
   163  }







