Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S313115AbSDIJ7V>; Tue, 9 Apr 2002 05:59:21 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S313119AbSDIJ7V>; Tue, 9 Apr 2002 05:59:21 -0400
Received: from velli.mail.jippii.net ([195.197.172.114]:52185 "HELO
	velli.mail.jippii.net") by vger.kernel.org with SMTP
	id <S313115AbSDIJ7T>; Tue, 9 Apr 2002 05:59:19 -0400
Date: Tue, 9 Apr 2002 13:01:29 +0300
From: Anssi Saari <as@sci.fi>
To: Mark Hahn <hahn@physics.mcmaster.ca>
Cc: linux-kernel@vger.kernel.org
Subject: Re: PROMBLEM: CD burning at 16x uses excessive CPU, although DMA is enabled
Message-ID: <20020409100129.GA29606@sci.fi>
In-Reply-To: <20020408154732.GA10271@sci.fi> <Pine.LNX.4.33.0204081754010.10199-100000@coffee.psychology.mcmaster.ca>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.3.28i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Apr 08, 2002 at 06:02:55PM -0400, Mark Hahn wrote:
> I think someone else already pointed out that doing
> a kernel profile would be good.  strace would also
> be quite useful, even just the -c form.
 
Here it is:

With unmaskirq=1 first:

     3 block_read_full_page                       0.0059
     3 fget                                       0.0625
     3 get_unused_buffer_head                     0.0234
     3 kmalloc                                    0.0134
     3 kmem_cache_free                            0.0187
     4 __free_pages_ok                            0.0081
     4 ext3_get_branch                            0.0147
     4 get_hash_table                             0.0278
     4 journal_try_to_free_buffers                0.0278
     4 rmqueue                                    0.0093
     4 scsi_old_done                              0.0027
     5 generic_make_request                       0.0164
     5 try_to_free_buffers                        0.0223
     6 ext3_releasepage                           0.1250
     6 sys_read                                   0.0268
     6 system_call                                0.1071
     7 __rdtsc_delay                              0.2188
     7 apm_bios_call                              0.0547
     7 scsi_request_fn                            0.0093
     8 __make_request                             0.0050
     8 ide_wait_stat                              0.0294
     8 schedule                                   0.0091
     9 ide_dmaproc                                0.0161
     9 start_request                              0.0148
    13 do_generic_file_read                       0.0123
    14 ide_end_request                            0.0972
    22 do_rw_disk                                 0.0229
    49 handle_IRQ_event                           0.5104
   239 file_read_actor                            2.4896
  3324 default_idle                              69.2500
 20097 ide_output_data                          104.6719
 23952 total                                      0.0236
Number of interrupts on ide1 during burn: 17531

And then, unmaskirq=0:
     3 __free_pages                               0.0938
     3 ext3_get_branch                            0.0110
     3 fget                                       0.0625
     3 kmem_cache_reap                            0.0069
     3 page_cache_read                            0.0156
     3 scsi_block_when_processing_errors          0.0144
     3 shrink_cache                               0.0042
     4 __make_request                             0.0025
     4 __rdtsc_delay                              0.1250
     4 __switch_to                                0.0208
     4 ext3_get_block_handle                      0.0058
     4 fput                                       0.0179
     4 get_unused_buffer_head                     0.0312
     4 ide_dma_intr                               0.0208
     4 ide_dmaproc                                0.0071
     4 ide_output_data                            0.0208
     4 kfree                                      0.0250
     4 kmem_cache_free                            0.0250
     4 rmqueue                                    0.0093
     4 sys_read                                   0.0179
     4 try_to_free_buffers                        0.0179
     6 ext3_releasepage                           0.1250
     6 generic_file_readahead                     0.0179
     6 timer_bh                                   0.0099
     7 scsi_old_done                              0.0048
     8 start_request                              0.0132
     8 system_call                                0.1429
     9 ide_wait_stat                              0.0331
    10 do_generic_file_read                       0.0095
    10 ide_end_request                            0.0694
    10 schedule                                   0.0114
    11 do_rw_disk                                 0.0115
    15 apm_bios_call                              0.1172
   168 do_softirq                                 0.9545
   234 file_read_actor                            2.4375
  1942 handle_IRQ_event                          20.2292
  2949 default_idle                              61.4375
  6808 ide_intr                                  18.5000
 12333 total                                      0.0122
Number of interrupts on ide1 during burn: 17532

Strace -c with unmaskirq=1:

execve("/usr/local/bin/cdrdao", ["cdrdao", "simulate", "-n", "--speed", "16", "f
oo.cue"], [/* 34 vars */]) = 0
% time     seconds  usecs/call     calls    errors syscall
------ ----------- ----------- --------- --------- ----------------
 95.66    2.141856         244      8767           ioctl
  2.16    0.048346           3     17516           gettimeofday
  1.08    0.024089          45       534           write
  0.51    0.011371           2      5826           rt_sigprocmask
  0.43    0.009593         564        17         5 open
  0.10    0.002251         225        10         1 read
  0.03    0.000694         174         4           munmap
  0.01    0.000314           1       314           nanosleep
  0.01    0.000122           7        18           old_mmap
  0.00    0.000055           5        12           close
  0.00    0.000053           5        10           brk
  0.00    0.000041          21         2         2 rt_sigsuspend
  0.00    0.000033           2        16           rt_sigaction
  0.00    0.000029          29         1           pipe
  0.00    0.000028           3        11           fstat64
  0.00    0.000024           5         5           mprotect
  0.00    0.000021          21         1           clone
  0.00    0.000010          10         1           wait4
  0.00    0.000010           5         2         2 sigreturn
  0.00    0.000008           4         2           uname
  0.00    0.000008           8         1           _sysctl
  0.00    0.000008           3         3           fcntl64
  0.00    0.000003           3         1         1 munlockall
  0.00    0.000003           2         2           geteuid32
  0.00    0.000002           2         1           getpid
  0.00    0.000002           2         1           setrlimit
  0.00    0.000002           2         1           getrlimit
------ ----------- ----------- --------- --------- ----------------
100.00    2.238976                 33079        11 total

and with unmaskirq=0:
execve("/usr/local/bin/cdrdao", ["cdrdao", "simulate", "-n", "--speed", "16", "f
oo.cue"], [/* 34 vars */]) = 0
% time     seconds  usecs/call     calls    errors syscall
------ ----------- ----------- --------- --------- ----------------
 99.75   35.801229        4084      8767           ioctl
  0.14    0.051375           3     17516           gettimeofday
  0.07    0.024269          45       534           write
  0.03    0.011883           2      5826           rt_sigprocmask
  0.00    0.000709         177         4           munmap
  0.00    0.000267          18        15         3 open
  0.00    0.000263           1       263           nanosleep
  0.00    0.000117           7        18           old_mmap
  0.00    0.000083           8        10         1 read
  0.00    0.000057          29         2         2 rt_sigsuspend
  0.00    0.000056           5        12           close
  0.00    0.000048           5        10           brk
  0.00    0.000036           2        16           rt_sigaction
  0.00    0.000029          29         1           pipe
  0.00    0.000028           3        11           fstat64
  0.00    0.000026           5         5           mprotect
  0.00    0.000020          20         1           clone
  0.00    0.000010           5         2         2 sigreturn
  0.00    0.000009           9         1           wait4
  0.00    0.000008           4         2           uname
  0.00    0.000008           8         1           _sysctl
  0.00    0.000007           2         3           fcntl64
  0.00    0.000003           3         1           setrlimit
  0.00    0.000003           3         1         1 munlockall
  0.00    0.000003           3         1           getrlimit
  0.00    0.000003           2         2           geteuid32
  0.00    0.000002           2         1           getpid
------ ----------- ----------- --------- --------- ----------------
100.00   35.890551                 33026         9 total

> > But even though 50% is quite high, CPU load is not the problem as such,
> 
> 50% of what CPU?
 
AMD Duron 800MHz. Of course it's a problem but not the main problem here.

> it would also be interesting to look at memory behavior.

How would I get that?

