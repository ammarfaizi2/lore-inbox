Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S279105AbRKDWBN>; Sun, 4 Nov 2001 17:01:13 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S279603AbRKDWBH>; Sun, 4 Nov 2001 17:01:07 -0500
Received: from humbolt.nl.linux.org ([131.211.28.48]:16071 "EHLO
	humbolt.nl.linux.org") by vger.kernel.org with ESMTP
	id <S279105AbRKDWA5>; Sun, 4 Nov 2001 17:00:57 -0500
Content-Type: text/plain;
  charset="koi8-r"
From: Daniel Phillips <phillips@bonn-fries.net>
To: Alexander Viro <viro@math.psu.edu>, Jakob ?stergaard <jakob@unthought.net>
Subject: Re: PROPOSAL: dot-proc interface [was: /proc stuff]
Date: Sun, 4 Nov 2001 23:01:26 +0100
X-Mailer: KMail [version 1.3.2]
Cc: Alex Bligh - linux-kernel <linux-kernel@alex.org.uk>,
        John Levon <moz@compsoc.man.ac.uk>, linux-kernel@vger.kernel.org,
        Tim Jansen <tim@tjansen.de>
In-Reply-To: <Pine.GSO.4.21.0111041450410.21449-100000@weyl.math.psu.edu>
In-Reply-To: <Pine.GSO.4.21.0111041450410.21449-100000@weyl.math.psu.edu>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Message-Id: <20011104220016Z17053-23341+42@humbolt.nl.linux.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

(Whoops, sorry about the 200K spam the first time, hope that was bounced
from the list, here's the abridged version.)

On November 4, 2001 08:52 pm, Alexander Viro wrote:
> On Sun, 4 Nov 2001, [iso-8859-1] Jakob Østergaard wrote:
> 
> > > If you feel it's too hard to write use scanf(), use sh, awk, perl
> > > etc. which all have their own implementations that appear to have
> > > served UNIX quite well for a long while.
> > 
> > Witness ten lines of vmstat output taking 300+ millions of clock cycles.
> 
> Would the esteemed sir care to check where these cycles are spent?
> How about "traversing page tables of every damn process out there"?
> Doesn't sound like a string operation to me...

Doing 'top -d .1' eats 18% of a 1GHz cpu, which is abominable.  A kernel
profile courtesy of sgi's kernprof shows that scanning pages does not move
the needle, whereas sprintf does.  Notice that the biggest chunk of time
is spent in user space, possibly decoding proc values.  I didn't profile
user space, and I should but I'm not set up to do that just now.  Another
main cause of this embarrassing waste of cpu cycles is the bazillions of
file operations.  Enjoy:

		     Call graph (explanation follows)

granularity: each sample hit covers 4 byte(s) for 0.00% of 38.05 seconds

index % time    self  children    called     name
                                                 <spontaneous>
[1]     78.0    0.00   29.67                 cpu_idle [1]
               29.65    0.00   54034/54034       default_idle [2]
                0.01    0.00    1805/3791        schedule [81]
                0.00    0.00    1804/1806        check_pgt_cache [225]
-----------------------------------------------
               29.65    0.00   54034/54034       cpu_idle [1]
[2]     77.9   29.65    0.00   54034         default_idle [2]
-----------------------------------------------
                                                 <spontaneous>
[3]     11.2    4.26    0.00                 USER [3]
-----------------------------------------------
                                                 <spontaneous>
[4]     10.4    0.04    3.94                 system_call [4]
                0.01    2.85   19776/19776       sys_read [5]
                0.01    0.48   17031/17031       sys_open [14]
                0.00    0.15    5742/5742        sys_stat64 [24]
                0.00    0.12    4554/4554        sys_write [28]
                0.00    0.09     642/642         sys_getdents64 [30]
                0.01    0.08    1544/1544        sys_select [32]
                0.00    0.03     767/767         sys_poll [69]
                0.01    0.02   16901/16903       sys_close [75]
                0.00    0.02    3969/3969        sys_fcntl64 [82]
                0.00    0.01    1046/1046        sys_ioctl [137]
                0.00    0.01     134/134         old_mmap [142]
                0.00    0.01    5376/5376        sys_alarm [145]
                0.00    0.00    3644/3644        sys_gettimeofday [154]
                0.00    0.00       1/1           sys_fork [165]
                0.00    0.00     128/128         sys_access [176]
                0.00    0.00     130/130         sys_munmap [188]
                0.00    0.00       1/1           sys_execve [201]
                0.00    0.00     385/385         sys_lseek [214]
                0.00    0.00     263/263         sys_fstat64 [219]
                0.00    0.00    3615/3615        sys_rt_sigaction [224]
                0.00    0.00     128/128         sys_llseek [232]
                0.00    0.00      17/17          sys_wait4 [237]
                0.00    0.00       1/1           sys_exit [239]
                0.00    0.00       4/4           sys_brk [297]
                0.00    0.00       6/6           sys_writev [304]
                0.00    0.00       1/1           sys_mprotect [350]
                0.00    0.00     148/148         sys_time [425]
                0.00    0.00      34/34          sys_rt_sigprocmask [433]
                0.00    0.00       2/2           sys_setpgid [504]
                0.00    0.00       1/1           sys_newuname [550]
                0.00    0.00       1/1           sys_getpid [549]
                0.00    0.00       1/1           sys_sigreturn [551]
-----------------------------------------------
                0.01    2.85   19776/19776       system_call [4]
[5]      7.5    0.01    2.85   19776         sys_read [5]
                0.01    1.50   16512/16512       proc_info_read [6]
                0.00    1.27     524/524         proc_file_read [7]
                0.00    0.02     781/781         tty_read [92]
                0.00    0.02    1793/1798        generic_file_read [98]
                0.01    0.01   19776/80631       fput [45]
                0.00    0.01     166/166         sock_read [121]
                0.01    0.00   19776/52388       fget [90]
-----------------------------------------------
                0.01    1.50   16512/16512       sys_read [5]
[6]      4.0    0.01    1.50   16512         proc_info_read [6]
                0.03    1.04    5504/5504        proc_pid_statm [8]
                0.12    0.12    5504/5504        proc_pid_stat [23]
                0.09    0.00   15360/27661       _generic_copy_to_user [25]
                0.01    0.04    5504/5504        proc_pid_cmdline [48]
                0.00    0.04   16512/20003       _get_free_pages [50]
                0.02    0.00   16512/20160       _free_pages_ok [77]
                0.00    0.00   16512/87748       _free_pages [107]
                0.00    0.00   16512/80548       free_pages [167]
-----------------------------------------------
                0.00    1.27     524/524         sys_read [5]
[7]      3.3    0.00    1.27     524         proc_file_read [7]
                0.00    0.92     128/128         meminfo_read_proc [10]
                0.01    0.29     128/128         kstat_read_proc [21]
                0.00    0.03      12/12          ksyms_read_proc [68]
                0.00    0.00     524/27661       _generic_copy_to_user [25]
                0.00    0.00     128/128         loadavg_read_proc [230]
                0.00    0.00     128/128         uptime_read_proc [231]
                0.00    0.00     524/20003       _get_free_pages [50]
                0.00    0.00     524/20160       _free_pages_ok [77]
                0.00    0.00     524/87748       _free_pages [107]
                0.00    0.00     524/80548       free_pages [167]
                0.00    0.00     384/512         proc_calc_metrics [417]
-----------------------------------------------
                0.03    1.04    5504/5504        proc_info_read [6]
[8]      2.8    0.03    1.04    5504         proc_pid_statm [8]
                0.98    0.00  177792/177792      statm_pgd_range [9]
                0.00    0.05    5504/44307       sprintf [16]
                0.00    0.00    4352/17928       mmput [152]
-----------------------------------------------
                0.98    0.00  177792/177792      proc_pid_statm [8]
[9]      2.6    0.98    0.00  177792         statm_pgd_range [9]
-----------------------------------------------
                0.00    0.92     128/128         proc_file_read [7]
[10]     2.4    0.00    0.92     128         meminfo_read_proc [10]
                0.92    0.00     128/128         si_swapinfo [11]
                0.00    0.00     256/44307       sprintf [16]
                0.00    0.00     128/128         si_meminfo [271]
                0.00    0.00     128/128         nr_inactive_clean_pages [429]
                0.00    0.00     128/512         proc_calc_metrics [417]
-----------------------------------------------
                0.92    0.00     128/128         meminfo_read_proc [10]
[11]     2.4    0.92    0.00     128         si_swapinfo [11]
-----------------------------------------------
[12]     1.3    0.07    0.44   22903+4       <cycle 1 as a whole> [12]
                0.07    0.44   22905             path_walk <cycle 1> [13]
-----------------------------------------------
                                   2             vfs_follow_link <cycle 1> [506]
                0.00    0.00       2/22903       open_exec [326]
                0.02    0.11    5870/22903       _user_walk [26]
                0.05    0.33   17031/22903       open_namei [19]
[13]     1.3    0.07    0.44   22905         path_walk <cycle 1> [13]
                0.03    0.24   38529/38529       real_lookup [22]
                0.02    0.08   85429/108334      dput [27]
                0.01    0.02   63040/63041       cached_lookup [74]
                0.01    0.01   63042/80076       vfs_permission [71]
                0.01    0.00   63042/80076       permission [120]
                0.00    0.00   22389/22389       lookup_mnt [200]
                0.00    0.00     244/5999        path_release [136]
                0.00    0.00       2/1809        update_atime [402]
                0.00    0.00       2/2           ext2_follow_link [492]
                                   2             vfs_follow_link <cycle 1> [506]
-----------------------------------------------
                0.01    0.48   17031/17031       system_call [4]
[14]     1.3    0.01    0.48   17031         sys_open [14]
                0.00    0.44   17031/17031       filp_open [15]
                0.01    0.01   17031/22902       getname [86]
                0.01    0.00   17031/17032       get_unused_fd [110]
                0.00    0.00   17031/111161      kmem_cache_free [70]
-----------------------------------------------
                0.00    0.44   17031/17031       sys_open [14]
[15]     1.2    0.00    0.44   17031         filp_open [15]
                0.01    0.40   17031/17031       open_namei [19]
                0.01    0.01   16902/16904       dentry_open [84]
-----------------------------------------------
                0.00    0.00     128/44307       loadavg_read_proc [230]
                0.00    0.00     128/44307       uptime_read_proc [231]
                0.00    0.00     256/44307       meminfo_read_proc [10]
                0.00    0.03    3347/44307       get_ksyms_list [67]
                0.00    0.05    5504/44307       proc_pid_stat [23]
                0.00    0.05    5504/44307       proc_pid_statm [8]
                0.00    0.29   29440/44307       kstat_read_proc [21]
[16]     1.2    0.00    0.44   44307         sprintf [16]
                0.00    0.43   44307/44310       vsprintf [17]
-----------------------------------------------
                0.00    0.00       3/44310       printk [327]
                0.00    0.43   44307/44310       sprintf [16]
[17]     1.1    0.00    0.43   44310         vsprintf [17]
                0.09    0.34   44310/44310       vsnprintf [18]
-----------------------------------------------
                0.09    0.34   44310/44310       vsprintf [17]
[18]     1.1    0.09    0.34   44310         vsnprintf [18]
                0.34    0.00  281878/281878      number [20]
                0.00    0.00    3843/3843        skip_atoi [280]
-----------------------------------------------
                0.01    0.40   17031/17031       filp_open [15]
[19]     1.1    0.01    0.40   17031         open_namei [19]
                0.05    0.33   17031/22903       path_walk <cycle 1> [13]
                0.01    0.00   17031/22903       path_init [109]
                0.00    0.00   17030/80076       vfs_permission [71]
                0.00    0.00   17030/80076       permission [120]
                0.00    0.00     129/5999        path_release [136]
                0.00    0.00       1/1           do_truncate [356]
                0.00    0.00       1/108334      dput [27]
                0.00    0.00       1/1           lookup_hash [380]
                0.00    0.00       1/2           get_write_access [494]
-----------------------------------------------
                0.34    0.00  281878/281878      vsnprintf [18]
[20]     0.9    0.34    0.00  281878         number [20]
-----------------------------------------------
                0.01    0.29     128/128         proc_file_read [7]
[21]     0.8    0.01    0.29     128         kstat_read_proc [21]
                0.00    0.29   29440/44307       sprintf [16]
-----------------------------------------------
                0.03    0.24   38529/38529       path_walk <cycle 1> [13]
[22]     0.7    0.03    0.24   38529         real_lookup [22]
                0.03    0.05   22016/22016       proc_pid_lookup [31]
                0.00    0.05   22017/22017       proc_root_lookup [41]
                0.01    0.04   16512/16512       proc_base_lookup [47]
                0.03    0.01   38529/38529       d_alloc [65]
                0.01    0.00   38529/101570      d_lookup [57]
-----------------------------------------------
                0.12    0.12    5504/5504        proc_info_read [6]
[23]     0.6    0.12    0.12    5504         proc_pid_stat [23]
                0.00    0.05    5504/44307       sprintf [16]
                0.05    0.00    5504/5504        collect_sigign_sigcatch [44]
                0.01    0.00    5504/5504        get_wchan [130]
                0.00    0.00    4352/17928       mmput [152]
-----------------------------------------------
                0.00    0.15    5742/5742        system_call [4]
[24]     0.4    0.00    0.15    5742         sys_stat64 [24]
                0.00    0.14    5742/5870        _user_walk [26]
                0.00    0.01    5626/5999        path_release [136]
                0.01    0.00    5626/5889        cp_new_stat64 [157]
-----------------------------------------------
                0.00    0.00     166/27661       memcpy_toiovec [263]
                0.00    0.00     524/27661       proc_file_read [7]
                0.00    0.00     857/27661       read_chan [99]
                0.06    0.00   10754/27661       filldir64 [39]
                0.09    0.00   15360/27661       proc_info_read [6]
[25]     0.4    0.16    0.00   27661         _generic_copy_to_user [25]
-----------------------------------------------
                0.00    0.00     128/5870        sys_access [176]
                0.00    0.14    5742/5870        sys_stat64 [24]
[26]     0.4    0.00    0.14    5870         _user_walk [26]
                0.02    0.11    5870/22903       path_walk <cycle 1> [13]
                0.00    0.00    5870/22902       getname [86]
                0.00    0.00    5870/22903       path_init [109]
                0.00    0.00    5870/111161      kmem_cache_free [70]
-----------------------------------------------
                0.00    0.00       1/108334      open_namei [19]
                0.00    0.00       2/108334      do_exit [238]
                0.00    0.01    5999/108334      path_release [136]
                0.00    0.02   16903/108334      fput [45]
                0.02    0.08   85429/108334      path_walk <cycle 1> [13]
[27]     0.3    0.02    0.10  108334         dput [27]
                0.02    0.04   38529/38529       iput [42]
                0.04    0.00  146863/203321      atomic_dec_and_lock [49]
                0.01    0.00   38529/111161      kmem_cache_free [70]
                0.00    0.00   38528/38528       pid_delete_dentry [212]
                0.00    0.00       1/1           proc_delete_dentry [532]
-----------------------------------------------
                0.00    0.12    4554/4554        system_call [4]
[28]     0.3    0.00    0.12    4554         sys_write [28]
                0.01    0.08    4237/4237        tty_write [29]
                0.00    0.02     317/317         sock_write [87]
                0.00    0.00    4554/80631       fput [45]
                0.00    0.00    4554/52388       fget [90]
-----------------------------------------------
                0.01    0.08    4237/4237        sys_write [28]
[29]     0.2    0.01    0.08    4237         tty_write [29]
                0.00    0.08    4237/4237        write_chan [34]
-----------------------------------------------
                0.00    0.09     642/642         system_call [4]
[30]     0.2    0.00    0.09     642         sys_getdents64 [30]
                0.00    0.08     642/642         vfs_readdir [33]
                0.00    0.00     642/80631       fput [45]
                0.00    0.00     642/52388       fget [90]
-----------------------------------------------
                0.03    0.05   22016/22016       real_lookup [22]
[31]     0.2    0.03    0.05   22016         proc_pid_lookup [31]
                0.01    0.03   22016/38528       proc_pid_make_inode [40]
                0.01    0.00   22016/38529       d_rehash [131]
                0.00    0.00   22016/38529       d_instantiate [140]
                0.00    0.00   22016/87748       _free_pages [107]
                0.00    0.00   22016/80548       free_pages [167]
-----------------------------------------------
                0.01    0.08    1544/1544        system_call [4]
[32]     0.2    0.01    0.08    1544         sys_select [32]
                0.01    0.07    1544/1544        do_select [36]
                0.00    0.00    1544/1544        select_bits_alloc [205]
                0.00    0.00    1545/2963        kfree [192]
                0.00    0.00    1545/1545        select_bits_free [405]
-----------------------------------------------
                0.00    0.08     642/642         sys_getdents64 [30]
[33]     0.2    0.00    0.08     642         vfs_readdir [33]
                0.00    0.05     512/512         proc_pid_readdir [51]
                0.00    0.04     640/640         proc_root_readdir [61]
                0.00    0.00       2/2           ext2_readdir [338]
-----------------------------------------------
                0.00    0.08    4237/4237        tty_write [29]
[34]     0.2    0.00    0.08    4237         write_chan [34]
                0.02    0.02    4361/4361        opost_block [56]
                0.00    0.03    4225/4225        opost [72]
                0.00    0.00    4237/16341       add_wait_queue [129]
                0.00    0.00    4237/16343       remove_wait_queue [156]
                0.00    0.00    4237/8714        tty_hung_up_p [223]
                0.00    0.00       4/12687       pty_write [59]
-----------------------------------------------
                0.00    0.00       1/2050        smp_apic_timer_interrupt [329]
                0.01    0.01     313/2050        stext_lock [95]
                0.04    0.03    1736/2050        do_IRQ [37]
[35]     0.2    0.05    0.03    2050         do_softirq [35]
                0.00    0.02     488/488         net_rx_action [83]
                0.00    0.01    1428/1428        tasklet_hi_action [132]
                0.00    0.00     132/132         net_tx_action [308]
                0.00    0.00       2/2           tasklet_action [346]
-----------------------------------------------
                0.01    0.07    1544/1544        sys_select [32]
[36]     0.2    0.01    0.07    1544         do_select [36]
                0.00    0.01    4473/4473        tty_poll [108]
                0.00    0.01    1545/2312        poll_freewait [106]
                0.00    0.01    1228/1958        schedule_timeout [104]
                0.00    0.01    5626/9901        sock_poll [101]
                0.01    0.00   13757/80631       fput [45]
                0.01    0.00   13757/52388       fget [90]
                0.00    0.00    3658/3658        pipe_poll [164]
                0.00    0.00    1544/1544        max_select_fd [193]
-----------------------------------------------
                0.00    0.07    1760/1760        ret_from_intr [38]
[37]     0.2    0.00    0.07    1760         do_IRQ [37]
                0.04    0.03    1736/2050        do_softirq [35]
                0.00    0.00    1760/1760        handle_IRQ_event [216]
                0.00    0.00    1428/1428        ack_edge_ioapic_irq [406]
                0.00    0.00    1428/1428        end_edge_ioapic_irq [408]
                0.00    0.00     332/332         mask_and_ack_level_ioapic_irq [420]
                0.00    0.00     332/332         end_level_ioapic_irq [419]
-----------------------------------------------
                                                 <spontaneous>
[38]     0.2    0.00    0.07                 ret_from_intr [38]
                0.00    0.07    1760/1760        do_IRQ [37]
-----------------------------------------------
                0.00    0.00       2/10882       ext2_readdir [338]
                0.00    0.03    5248/10882       proc_readdir [62]
                0.00    0.03    5632/10882       proc_pid_readdir [51]
[39]     0.2    0.01    0.06   10882         filldir64 [39]
                0.06    0.00   10754/27661       _generic_copy_to_user [25]
-----------------------------------------------
                0.01    0.02   16512/38528       proc_base_lookup [47]
                0.01    0.03   22016/38528       proc_pid_lookup [31]
[40]     0.2    0.01    0.06   38528         proc_pid_make_inode [40]
                0.01    0.04   38528/38528       get_empty_inode [46]
                0.01    0.00   16512/16512       task_dumpable [158]
-----------------------------------------------
                0.00    0.05   22017/22017       real_lookup [22]
[41]     0.2    0.00    0.05   22017         proc_root_lookup [41]
                0.05    0.00   22017/22017       proc_lookup [43]
-----------------------------------------------
                0.02    0.04   38529/38529       dput [27]
[42]     0.1    0.02    0.04   38529         iput [42]
                0.00    0.01   38529/38529       destroy_inode [117]
                0.01    0.00   38529/203321      atomic_dec_and_lock [49]
                0.01    0.00   38528/87748       _free_pages [107]
                0.01    0.00   38529/38529       force_delete [148]
                0.00    0.00   38528/38528       proc_pid_delete_inode [199]
                0.00    0.00   38528/80548       free_pages [167]
                0.00    0.00   38529/38529       proc_delete_inode [260]
-----------------------------------------------
                0.05    0.00   22017/22017       proc_root_lookup [41]
[43]     0.1    0.05    0.00   22017         proc_lookup [43]
                0.00    0.00       1/1           proc_get_inode [349]
                0.00    0.00       1/38529       d_rehash [131]
                0.00    0.00       1/38529       d_instantiate [140]
-----------------------------------------------
                0.05    0.00    5504/5504        proc_pid_stat [23]
[44]     0.1    0.05    0.00    5504         collect_sigign_sigcatch [44]
-----------------------------------------------
                0.00    0.00       1/80631       search_binary_handler [217]
                0.00    0.00       1/80631       load_elf_binary [218]
                0.00    0.00       2/80631       unmap_fixup [272]
                0.00    0.00       3/80631       old_mmap [142]
                0.00    0.00       6/80631       sys_writev [304]
                0.00    0.00      31/80631       exit_mmap [241]
                0.00    0.00     128/80631       sys_llseek [232]
                0.00    0.00     263/80631       sys_fstat64 [219]
                0.00    0.00     384/80631       sys_lseek [214]
                0.00    0.00     642/80631       sys_getdents64 [30]
                0.00    0.00    1046/80631       sys_ioctl [137]
                0.00    0.00    3584/80631       fcntl_setlk [96]
                0.00    0.00    3969/80631       sys_fcntl64 [82]
                0.00    0.00    4275/80631       do_pollfd [113]
                0.00    0.00    4554/80631       sys_write [28]
                0.00    0.00   11303/80631       poll_freewait [106]
                0.01    0.00   13757/80631       do_select [36]
                0.01    0.00   16906/80631       filp_close [100]
                0.01    0.01   19776/80631       sys_read [5]
[45]     0.1    0.03    0.02   80631         fput [45]
                0.00    0.02   16903/108334      dput [27]
                0.00    0.00   16903/16903       locks_remove_flock [221]
                0.00    0.00     132/132         ext2_release_file [278]
-----------------------------------------------
                0.01    0.04   38528/38528       proc_pid_make_inode [40]
[46]     0.1    0.01    0.04   38528         get_empty_inode [46]
                0.03    0.00   38528/38529       clean_inode [79]
                0.01    0.00   38528/111164      kmem_cache_alloc [78]
-----------------------------------------------
                0.01    0.04   16512/16512       real_lookup [22]
[47]     0.1    0.01    0.04   16512         proc_base_lookup [47]
                0.01    0.02   16512/38528       proc_pid_make_inode [40]
                0.00    0.00   16512/38529       d_rehash [131]
                0.00    0.00   16512/38529       d_instantiate [140]
-----------------------------------------------
                0.01    0.04    5504/5504        proc_info_read [6]
[48]     0.1    0.01    0.04    5504         proc_pid_cmdline [48]
                0.00    0.04    4736/4736        access_process_vm [55]
                0.00    0.00    4352/17928       mmput [152]
-----------------------------------------------
                0.00    0.00       1/203321      free_uid [393]
                0.00    0.00   17928/203321      mmput [152]
                0.01    0.00   38529/203321      iput [42]
                0.04    0.00  146863/203321      dput [27]
[49]     0.1    0.05    0.00  203321         atomic_dec_and_lock [49]
-----------------------------------------------
                0.00    0.00       1/20003       mm_init [275]
                0.00    0.00       1/20003       do_fork [166]
                0.00    0.00       6/20003       pte_alloc [240]
                0.00    0.00     524/20003       proc_file_read [7]
                0.00    0.00     726/20003       sys_poll [69]
                0.00    0.00    2233/20003       _pollwait [139]
                0.00    0.04   16512/20003       proc_info_read [6]
[50]     0.1    0.00    0.04   20003         _get_free_pages [50]
                0.01    0.04   20003/20162       _alloc_pages [54]
                0.00    0.00   20003/20162       alloc_pages [302]
-----------------------------------------------
                0.00    0.05     512/512         vfs_readdir [33]
[51]     0.1    0.00    0.05     512         proc_pid_readdir [51]
                0.00    0.03    5632/10882       filldir64 [39]
                0.01    0.00     512/512         get_pid_list [118]
-----------------------------------------------
                0.01    0.04     293/293         error_code [53]
[52]     0.1    0.01    0.04     293         do_page_fault [52]
                0.00    0.04     293/293         handle_mm_fault [58]
                0.00    0.00     293/5429        find_vma [243]
-----------------------------------------------
                                                 <spontaneous>
[53]     0.1    0.00    0.05                 error_code [53]
                0.01    0.04     293/293         do_page_fault [52]
-----------------------------------------------
                0.00    0.00       1/20162       copy_strings [265]
                0.00    0.00       2/20162       filemap_nopage [342]
                0.00    0.00       2/20162       grow_buffers [363]
                0.00    0.00      20/20162       do_wp_page [151]
                0.00    0.00     134/20162       do_anonymous_page [76]
                0.01    0.04   20003/20162       _get_free_pages [50]
[54]     0.1    0.01    0.04   20162         _alloc_pages [54]
                0.04    0.00   20162/20162       rmqueue [63]
-----------------------------------------------
                0.00    0.04    4736/4736        proc_pid_cmdline [48]
[55]     0.1    0.00    0.04    4736         access_process_vm [55]
                0.00    0.04    4736/4736        access_mm [60]
                0.00    0.00    4736/17928       mmput [152]
                0.00    0.00    4736/4736        find_extend_vma [264]
-----------------------------------------------
                0.02    0.02    4361/4361        write_chan [34]
[56]     0.1    0.02    0.02    4361         opost_block [56]
                0.00    0.01    4361/12687       pty_write [59]
                0.00    0.00    4361/5138        _generic_copy_from_user [173]
                0.00    0.00    4361/8586        pty_write_room [203]
-----------------------------------------------
                0.01    0.00   38529/101570      real_lookup [22]
                0.02    0.00   63041/101570      cached_lookup [74]
[57]     0.1    0.04    0.00  101570         d_lookup [57]
-----------------------------------------------
                0.00    0.04     293/293         do_page_fault [52]
[58]     0.1    0.00    0.04     293         handle_mm_fault [58]
                0.00    0.03     242/242         do_no_page [73]
                0.01    0.00      51/51          do_wp_page [151]
                0.00    0.00     293/325         pte_alloc [240]
-----------------------------------------------
                0.00    0.00       4/12687       write_chan [34]
                0.00    0.01    4361/12687       opost_block [56]
                0.00    0.02    8322/12687       tty_default_put_char [80]
[59]     0.1    0.00    0.04   12687         pty_write [59]
                0.02    0.02   12687/12687       n_tty_receive_buf [66]
                0.00    0.00   12691/33964       n_tty_receive_room [155]
                0.00    0.00       4/5138        _generic_copy_from_user [173]
-----------------------------------------------
                0.00    0.04    4736/4736        access_process_vm [55]
[60]     0.1    0.00    0.04    4736         access_mm [60]
                0.03    0.01    4736/4736        access_one_page [64]
-----------------------------------------------
                0.00    0.04     640/640         vfs_readdir [33]
[61]     0.1    0.00    0.04     640         proc_root_readdir [61]
                0.00    0.03     256/256         proc_readdir [62]
-----------------------------------------------
                0.00    0.03     256/256         proc_root_readdir [61]
[62]     0.1    0.00    0.03     256         proc_readdir [62]
                0.00    0.03    5248/10882       filldir64 [39]
-----------------------------------------------
                0.04    0.00   20162/20162       _alloc_pages [54]
[63]     0.1    0.04    0.00   20162         rmqueue [63]
-----------------------------------------------
                0.03    0.01    4736/4736        access_mm [60]
[64]     0.1    0.03    0.01    4736         access_one_page [64]
                0.01    0.00    4736/6752        kunmap_high [135]
                0.00    0.00    4736/6752        kmap_high [181]
                0.00    0.00    4736/87748       _free_pages [107]
-----------------------------------------------
                0.03    0.01   38529/38529       real_lookup [22]
[65]     0.1    0.03    0.01   38529         d_alloc [65]
                0.01    0.00   38529/111164      kmem_cache_alloc [78]
-----------------------------------------------
                0.02    0.02   12687/12687       pty_write [59]
[66]     0.1    0.02    0.02   12687         n_tty_receive_buf [66]
                0.01    0.00    1548/2506        _wake_up [112]
                0.01    0.00   12686/12686       kill_fasync [143]
                0.00    0.00   12687/33964       n_tty_receive_room [155]
                0.00    0.00       6/6           n_tty_receive_char [466]
-----------------------------------------------
                0.00    0.03      12/12          ksyms_read_proc [68]
[67]     0.1    0.00    0.03      12         get_ksyms_list [67]
                0.00    0.03    3347/44307       sprintf [16]
-----------------------------------------------
                0.00    0.03      12/12          proc_file_read [7]
[68]     0.1    0.00    0.03      12         ksyms_read_proc [68]
                0.00    0.03      12/12          get_ksyms_list [67]
-----------------------------------------------
                0.00    0.03     767/767         system_call [4]
[69]     0.1    0.00    0.03     767         sys_poll [69]
                0.00    0.02     767/767         do_poll [93]
                0.00    0.00     767/2312        poll_freewait [106]
                0.00    0.00     726/20003       _get_free_pages [50]
                0.00    0.00     726/2963        kmalloc [161]
                0.00    0.00     726/20160       _free_pages_ok [77]
                0.00    0.00     726/2963        kfree [192]
                0.00    0.00     726/5138        _generic_copy_from_user [173]
                0.00    0.00     726/87748       _free_pages [107]
                0.00    0.00     726/80548       free_pages [167]
-----------------------------------------------
                0.00    0.00       1/111161      sys_execve [201]
                0.00    0.00       1/111161      _mmdrop [377]
                0.00    0.00       1/111161      put_files_struct [365]
                0.00    0.00       1/111161      do_exit [238]
                0.00    0.00       1/111161      exit_sighand [277]
                0.00    0.00       1/111161      collect_signal [386]
                0.00    0.00      40/111161      exit_mmap [241]
                0.00    0.00     130/111161      unmap_fixup [272]
                0.00    0.00     132/111161      do_munmap [159]
                0.00    0.00     142/111161      kfree_skbmem [234]
                0.00    0.00    1792/111161      locks_delete_lock [261]
                0.00    0.00    3584/111161      fcntl_setlk [96]
                0.00    0.00    5376/111161      posix_lock_file [122]
                0.00    0.00    5870/111161      _user_walk [26]
                0.00    0.00   17031/111161      sys_open [14]
                0.01    0.00   38529/111161      dput [27]
                0.01    0.00   38529/111161      destroy_inode [117]
[70]     0.1    0.03    0.00  111161         kmem_cache_free [70]
                0.00    0.00       2/12          free_block [439]
-----------------------------------------------
                0.00    0.00       1/80076       flush_old_exec [242]
                0.00    0.00       1/80076       lookup_hash [380]
                0.00    0.00       2/80076       open_exec [326]
                0.00    0.00   17030/80076       open_namei [19]
                0.01    0.01   63042/80076       path_walk <cycle 1> [13]
[71]     0.1    0.02    0.01   80076         vfs_permission [71]
                0.00    0.01   72794/72794       in_group_p [114]
-----------------------------------------------
                0.00    0.03    4225/4225        write_chan [34]
[72]     0.1    0.00    0.03    4225         opost [72]
                0.00    0.03    8322/8322        tty_default_put_char [80]
                0.00    0.00    4225/8586        pty_write_room [203]
-----------------------------------------------
                0.00    0.03     242/242         handle_mm_fault [58]
[73]     0.1    0.00    0.03     242         do_no_page [73]
                0.03    0.00     136/136         do_anonymous_page [76]
                0.00    0.00     106/106         filemap_nopage [342]
-----------------------------------------------
                0.00    0.00       1/63041       lookup_hash [380]
                0.01    0.02   63040/63041       path_walk <cycle 1> [13]
[74]     0.1    0.01    0.02   63041         cached_lookup [74]
                0.02    0.00   63041/101570      d_lookup [57]
-----------------------------------------------
                0.00    0.00       1/16903       flush_old_exec [242]
                0.00    0.00       1/16903       load_elf_binary [218]
                0.01    0.02   16901/16903       system_call [4]
[75]     0.1    0.01    0.02   16903         sys_close [75]
                0.00    0.02   16903/16906       filp_close [100]
-----------------------------------------------
                0.03    0.00     136/136         do_no_page [73]
[76]     0.1    0.03    0.00     136         do_anonymous_page [76]
                0.00    0.00     134/20162       _alloc_pages [54]
                0.00    0.00     134/6752        kunmap_high [135]
                0.00    0.00     134/6752        kmap_high [181]
                0.00    0.00     134/20162       alloc_pages [302]
-----------------------------------------------
                0.00    0.00       1/20160       _mmdrop [377]
                0.00    0.00       1/20160       sys_wait4 [237]
                0.00    0.00       1/20160       do_wp_page [151]
                0.00    0.00       6/20160       clear_page_tables [341]
                0.00    0.00     155/20160       free_page_and_swap_cache [266]
                0.00    0.00     524/20160       proc_file_read [7]
                0.00    0.00     726/20160       sys_poll [69]
                0.00    0.00    2234/20160       poll_freewait [106]
                0.02    0.00   16512/20160       proc_info_read [6]
[77]     0.1    0.03    0.00   20160         _free_pages_ok [77]
-----------------------------------------------
                0.00    0.00       1/111164      get_new_inode [347]
                0.00    0.00       1/111164      copy_files [276]
                0.00    0.00       1/111164      send_signal [392]
                0.00    0.00       1/111164      mprotect_fixup [352]
                0.00    0.00       1/111164      setup_arg_pages [361]
                0.00    0.00       2/111164      do_fork [166]
                0.00    0.00       2/111164      get_unused_buffer_head [384]
                0.00    0.00      21/111164      skb_clone [190]
                0.00    0.00      32/111164      copy_mm [209]
                0.00    0.00     122/111164      alloc_skb [187]
                0.00    0.00     132/111164      do_munmap [159]
                0.00    0.00     137/111164      do_mmap_pgoff [150]
                0.00    0.00   10752/111164      locks_alloc_lock [171]
                0.01    0.00   22902/111164      getname [86]
                0.01    0.00   38528/111164      get_empty_inode [46]
                0.01    0.00   38529/111164      d_alloc [65]
[78]     0.1    0.03    0.00  111164         kmem_cache_alloc [78]
                0.00    0.00       1/11          kmem_cache_alloc_batch [440]
-----------------------------------------------
                0.00    0.00       1/38529       get_new_inode [347]
                0.03    0.00   38528/38529       get_empty_inode [46]
[79]     0.1    0.03    0.00   38529         clean_inode [79]
-----------------------------------------------
                0.00    0.03    8322/8322        opost [72]
[80]     0.1    0.00    0.03    8322         tty_default_put_char [80]
                0.00    0.02    8322/12687       pty_write [59]
-----------------------------------------------
                0.00    0.00       1/3791        do_exit [238]
                0.00    0.00       1/3791        sys_wait4 [237]
                0.00    0.00       3/3791        _wait_on_buffer [331]
                0.00    0.00      23/3791        reschedule [315]
                0.01    0.00    1805/3791        cpu_idle [1]
                0.01    0.00    1958/3791        schedule_timeout [104]
[81]     0.1    0.02    0.00    3791         schedule [81]
                0.00    0.00    3764/3765        _switch_to [184]
                0.00    0.00       1/1           _mmdrop [377]
-----------------------------------------------
                0.00    0.02    3969/3969        system_call [4]
[82]     0.1    0.00    0.02    3969         sys_fcntl64 [82]
                0.00    0.02    3969/3969        do_fcntl [94]
                0.00    0.00    3969/80631       fput [45]
                0.00    0.00    3969/52388       fget [90]
-----------------------------------------------
                0.00    0.02     488/488         do_softirq [35]
[83]     0.1    0.00    0.02     488         net_rx_action [83]
                0.00    0.02     488/488         ip_rcv [91]
-----------------------------------------------
                0.00    0.00       2/16904       open_exec [326]
                0.01    0.01   16902/16904       filp_open [15]
[84]     0.1    0.01    0.01   16904         dentry_open [84]
                0.01    0.00   16904/16904       get_empty_filp [127]
                0.00    0.00   16904/16904       file_move [172]
                0.00    0.00     133/133         ext2_open_file [427]
                0.00    0.00       1/2           get_write_access [494]
                0.00    0.00       1/1           chrdev_open [511]
-----------------------------------------------
                0.00    0.00       6/323         sock_readv_writev [306]
                0.00    0.02     317/323         sock_write [87]
[85]     0.1    0.00    0.02     323         sock_sendmsg [85]
                0.00    0.02     323/323         inet_sendmsg [88]
-----------------------------------------------
                0.00    0.00       1/22902       sys_execve [201]
                0.00    0.00    5870/22902       _user_walk [26]
                0.01    0.01   17031/22902       sys_open [14]
[86]     0.1    0.01    0.02   22902         getname [86]
                0.01    0.00   22902/22902       strncpy_from_user [119]
                0.01    0.00   22902/111164      kmem_cache_alloc [78]
-----------------------------------------------
                0.00    0.02     317/317         sys_write [28]
[87]     0.1    0.00    0.02     317         sock_write [87]
                0.00    0.02     317/323         sock_sendmsg [85]
-----------------------------------------------
                0.00    0.02     323/323         sock_sendmsg [85]
[88]     0.1    0.00    0.02     323         inet_sendmsg [88]
                0.01    0.01     323/323         tcp_sendmsg [89]
-----------------------------------------------
                0.01    0.01     323/323         inet_sendmsg [88]
[89]     0.1    0.01    0.01     323         tcp_sendmsg [89]
                0.00    0.01     318/322         tcp_write_xmit [123]
                0.00    0.00     349/689         alloc_skb [187]
                0.00    0.00      27/27          tcp_push_one [269]
                0.00    0.00      15/144         tcp_mem_schedule [292]
                0.00    0.00       1/1           _release_sock [333]
-----------------------------------------------
                0.00    0.00       3/52388       old_mmap [142]
                0.00    0.00       6/52388       sys_writev [304]
                0.00    0.00     128/52388       sys_llseek [232]
                0.00    0.00     263/52388       sys_fstat64 [219]
                0.00    0.00     385/52388       sys_lseek [214]
                0.00    0.00     642/52388       sys_getdents64 [30]
                0.00    0.00    1046/52388       sys_ioctl [137]
                0.00    0.00    3584/52388       fcntl_setlk [96]
                0.00    0.00    3969/52388       sys_fcntl64 [82]
                0.00    0.00    4275/52388       do_pollfd [113]
                0.00    0.00    4554/52388       sys_write [28]
                0.01    0.00   13757/52388       do_select [36]
                0.01    0.00   19776/52388       sys_read [5]
[90]     0.1    0.02    0.00   52388         fget [90]
-----------------------------------------------
                0.00    0.02     488/488         net_rx_action [83]
[91]     0.1    0.00    0.02     488         ip_rcv [91]
                0.00    0.02     488/488         ip_local_deliver [102]
                0.00    0.00     176/176         ip_route_input [198]
-----------------------------------------------
                0.00    0.02     781/781         sys_read [5]
[92]     0.1    0.00    0.02     781         tty_read [92]
                0.01    0.01     781/781         read_chan [99]
-----------------------------------------------
                0.00    0.02     767/767         sys_poll [69]
[93]     0.1    0.00    0.02     767         do_poll [93]
                0.00    0.01    1435/1435        do_pollfd [113]
                0.00    0.01     709/1958        schedule_timeout [104]
-----------------------------------------------
                0.00    0.02    3969/3969        sys_fcntl64 [82]
[94]     0.1    0.00    0.02    3969         do_fcntl [94]
                0.00    0.02    3584/3584        fcntl_setlk [96]
-----------------------------------------------
                                                 <spontaneous>
[95]     0.1    0.01    0.01                 stext_lock [95]
                0.01    0.01     313/2050        do_softirq [35]
-----------------------------------------------
                0.00    0.02    3584/3584        do_fcntl [94]
[96]     0.1    0.00    0.02    3584         fcntl_setlk [96]
                0.00    0.01    3584/3584        posix_lock_file [122]
                0.00    0.00    3584/80631       fput [45]
                0.00    0.00    3584/52388       fget [90]
                0.00    0.00    3584/10752       locks_alloc_lock [171]
                0.00    0.00    3584/3584        flock_to_posix_lock [245]
                0.00    0.00    3584/111161      kmem_cache_free [70]
-----------------------------------------------
                0.00    0.02    1798/1798        generic_file_read [98]
[97]     0.1    0.00    0.02    1798         do_generic_file_read [97]
                0.01    0.00    1798/1798        file_read_actor [103]
                0.00    0.00    1798/1798        generic_file_readahead [247]
                0.00    0.00    1798/87748       _free_pages [107]
                0.00    0.00    1798/1809        update_atime [402]
-----------------------------------------------
                0.00    0.00       5/1798        kernel_read [325]
                0.00    0.02    1793/1798        sys_read [5]
[98]     0.1    0.00    0.02    1798         generic_file_read [98]
                0.00    0.02    1798/1798        do_generic_file_read [97]
-----------------------------------------------
                0.01    0.01     781/781         tty_read [92]
[99]     0.1    0.01    0.01     781         read_chan [99]
                0.00    0.00     857/27661       _generic_copy_to_user [25]
                0.00    0.00     781/781         check_unthrottle [162]
                0.00    0.00     781/16341       add_wait_queue [129]
                0.00    0.00     781/5256        n_tty_chars_in_buffer [210]
                0.00    0.00     781/16343       remove_wait_queue [156]
                0.00    0.00       4/1958        schedule_timeout [104]
                0.00    0.00       4/8714        tty_hung_up_p [223]
-----------------------------------------------

--
Daniel
