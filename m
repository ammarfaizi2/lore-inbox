Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S131009AbRAWQzV>; Tue, 23 Jan 2001 11:55:21 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S131491AbRAWQzL>; Tue, 23 Jan 2001 11:55:11 -0500
Received: from monsoon.newjersey.sco.com ([132.147.103.53]:28313 "EHLO
	monsoon.newjersey.sco.com") by vger.kernel.org with ESMTP
	id <S131489AbRAWQy4>; Tue, 23 Jan 2001 11:54:56 -0500
Message-ID: <3A6DB617.9B2320AF@sco.com>
Date: Tue, 23 Jan 2001 11:49:27 -0500
From: Jun Nakajima <jun@sco.com>
Organization: SCO, Inc.
X-Mailer: Mozilla 4.75 [en] (X11; U; Linux 2.2.16-22smp i686)
X-Accept-Language: en
MIME-Version: 1.0
To: Mike Kravetz <mkravetz@sequent.com>
CC: lse-tech@lists.sourceforge.net, linux-kernel@vger.kernel.org
Subject: Re: [Lse-tech] multi-queue scheduler update
In-Reply-To: <20010118155311.B8637@w-mikek.des.sequent.com>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I tried to run SDET (Software Development Environment Throughput), which
basically is a system level, throughput oriented benchmark, on the 2.4.0
kernel and 2.4.0 kernel with this patch. 

I guess many (old?) Unix guys are familiar with it, and it is (was?)
sometimes used to check some aspects of scalability of the system. The
details of this bechmark are not so important in this mail (available
upon request).

The following are very preliminary numbers from the benchmark. Tests
were run on a system with 8 550 MHz Pentium III processors. I think
those results are encouraging.

# of Scripts	Throughput 	Throughput
                2.4		2.4-multi-queue
---------	----------	--------
1       	2057.1		1978.0
2       	4114.3		4067.8
4       	7700.5		7700.5
6       	10746.3		10746.3
8       	12973.0		12576.4
10      	13186.8		13235.3
15      	13138.7		13235.3
20      	12996.4		13043.5
25      	13005.8		13005.8
30      	12811.4		13059.3
40      	12676.1		12732.1
50      	12121.2		12676.1
60      	12314.7		12442.4
70      	12051.6		11954.5
80      	11871.4		11985.0
90      	11608.7		11777.5
100     	10849.9		11523.7
125     	10678.7		10940.9
150     	10416.7		10503.8
175     	10187.6		10314.3
200     	9749.5		10106.7
250     	8343.4		8787.3

I also checked hot-spots with the 2.4.0 kernel (not with multi-queue)
with lockmeter (http://oss.sgi.com/projects/lockmeter/). The data were
sampled when the number of scripte is 175.

SPINLOCKS       HOLD          WAIT
   UTIL   CON   MEAN (MAX)    MEAN (MAX)        TOTAL   NAME
...
10.56%  26.89%  7.4us(175us)  3.4us(692us)  1569304   runqueue_lock
 2.23%  29.75%  4.5us(20us)   4.4us(646us)   550505    __wake_up+0x7c
 0.01%  11.62%  6.6us(15us)   1.0us(65us)      2056    __wake_up+0x128
 0.00%  14.29%  0.4us(2.6us)  3.0us(332us)     1393   
deliver_signal+0x58
 0.00%   9.94%  7.2us(16us)   1.2us(56us)       332   
process_timeout+0x14
 0.01%  26.70%  4.7us(16us)   5.0us(296us)     1457   
schedule_tail+0x58
 7.53%  23.28%   11us(175us)  3.0us(692us)   781676    schedule+0xd0
 0.66%  35.42%  3.5us(23us)   2.8us(486us)   206008    schedule+0x458
 0.00%  11.79%  4.2us(78us)   1.1us(56us)       560    schedule+0x504
 0.11%   9.42%  5.0us(21us)   2.3us(420us)    25317   
wake_up_process+0x14

The above result basically tells utilization of runqueue_lock is about
10% of all spinlocks held during the benchmarck and nealy 27% of the
requests for this lock need to spin and wait for the lock (The NAMEs
below the lock are the locations where that lock is used). This might
explain the throughput improvements gained by the multi-queue scheduler.

Now who has the largest utilization? Of course it's kernel_flag.
SPINLOCKS       HOLD          WAIT
   UTIL   CON   MEAN (MAX)    MEAN (MAX)      TOTAL  NAME
...
43.15%  33.08%  13us(95971us) 12us(95997us) 3558789  kernel_flag
 0.02%  38.26%  0.7us(29us)   34us(94975us)   23788   acct_process+0x1c
 0.02%  44.63%  8.3us(43us)    23us(675us)     2012   chrdev_open+0x4c
 0.00%  22.26%  0.9us(2.5us)   16us(525us)      283   de_put+0x28
 5.26%  38.34%  244us(1184us) 21us(53127us)   23788   do_exit+0xf8
 0.99%  36.22%   11us(840us)  12us(53195us)   96205   
ext2_delete_inode+0x20
 0.46%  29.64%  1.2us(159us)  9.1us(53249us) 430421  
ext2_discard_prealloc+0x20
 1.28%  40.60%  9.7us(152us)   22us(43404us) 146014  
ext2_get_block+0x54
 0.00%  40.00%  0.4us(0.7us)   8.6us(34us)        5  
locks_remove_flock+0x34
 0.00%  40.00%  0.6us(1.2us)   4.5us(14us)        5  
locks_remove_posix+0x38
 0.92%  40.80%  12us(572us)    16us(47804us)  84618   lookup_hash+0x84
 0.16%  37.35%  1.0us(178us)   13us(53173us) 175002   notify_change+0x68
 7.78%  15.00%  46us(2523us)   3.1us(27213us)188485   permission+0x38
20.34%  32.99%  12us(1981us)   12us(95997us)1927065   real_lookup+0x64
 0.05%  47.31%  595us(51910us) 22us(270us)       93   schedule+0x490
 0.56%  42.11%  32861us(95971us)41us(405us)      19  
sync_old_buffers+0x20
 0.83%  40.22%  19us(1473us)   19us(41614us)  48081   sys_fcntl64+0x44
 0.01%  38.05%  1.3us(37us)    22us(49506us)  12422   sys_ioctl+0x4c
 0.06%  33.12%  0.5us(62us)    15us(49778us) 132230   sys_llseek+0x88
 0.00%  39.64%  0.9us(4.9us)   19us(849us)     5401   sys_lseek+0x6c
 0.00%  37.50%  28us(48us)     12us(222us)      200   sys_rename+0x1a0
 0.02%  42.29%  6.2us(22us)    81us(93181us)   3802   sys_sysctl+0x4c
 0.00%  52.27%   6.4us(29us)   13us(156us)      132   tty_read+0xbc
 0.01%  41.36%  13us(37us)     16us(434us)      810   tty_release+0x1c
 0.00%  48.12%  17us(143us)    22us(497us)      133   tty_write+0x1bc
 2.08%  41.32%  25us(309us)    18us(29470us)  92009   vfs_create+0x98
 0.52%  38.57%  85us(227us)    12us(698us)     6800   vfs_mkdir+0x90
 1.10%  38.40%  20us(317us)    14us(1100us)   60359   vfs_readdir+0x68
 0.07%  41.66%  12us(78us)    18us(1120us)     6800   vfs_rmdir+0x188
 0.00% 100.00%  24us(24us)    21us(27us)          2   vfs_statfs+0x4c
 0.60%  36.52%  7.2us(104us)  9.4us(904us)    91805   vfs_unlink+0x110

This tells many things, but 
- utilization of kernel_flag is about 43% and more than half of that 
  utilization is done by real_lookup.
- its average hold-time is not relatively significant, but max wait-time 
  is.
- The location sync_old_buffers+0x20 looks responsible for the longest 
  wait-time (95997us).
- sync_old_buffers is responsible only for 0.83% of lock utilization,
but
  it has the largest average (32861us) and max (95971us) hold-time.

So if we replace the big kernel lock with a fine-grained lock in the
real_lookup function, we would see more throughput improvements at
leaset for this benchmarck. 

But I guess the reason for holding the big kernel in real_lookup() is
that not all filesystems don't implement an MP-safe lookup routine. Is
that correct assumption?

For sync_old_buffers, we could hold the big kernel lock per filesystem,
for example. 

static struct dentry * real_lookup(struct dentry * parent, struct qstr *
name, int flags)
{
 ...

        result = d_lookup(parent, name);
        if (!result) {
                struct dentry * dentry = d_alloc(parent, name);
                result = ERR_PTR(-ENOMEM);
                if (dentry) {
                        lock_kernel();
                        result = dir->i_op->lookup(dir, dentry);
                        unlock_kernel();
                        if (result)
                                dput(dentry);
                        else
                                result = dentry;
                }
                up(&dir->i_sem);
                return result;
        }

...
}

static int sync_old_buffers(void)
{
        lock_kernel();
        sync_supers(0);
        sync_inodes(0);
        unlock_kernel();

        flush_dirty_buffers(1);
        /* must really sync all the active I/O request to disk here */
        run_task_queue(&tq_disk);
        return 0;
}



Mike Kravetz wrote:
> 
> I just posted an updated version of the multi-queue scheduler
> for the 2.4.0 kernel.  This version also contains support for
> realtime tasks.  The patch can be found at:
> 
> http://lse.sourceforge.net/scheduling/
> 
> Here are some very preliminary numbers from sched_test_yield
> (which was previously posted to this (lse-tech) list by Bill
> Hartner).  Tests were run on a system with 8 700 MHz Pentium
> III processors.
> 
>                            microseconds/yield
> # threads      2.2.16-22           2.4        2.4-multi-queue
> ------------   ---------         --------     ---------------
> 16               18.740            4.603         1.455
> 32               17.702            5.134         1.456
> 64               23.300            5.586         1.466
> 128              47.273           18.812         1.480
> 256             105.701           71.147         1.517
> 512               FRC            143.500         1.661
> 1024              FRC            196.425         6.166
> 2048              FRC              FRC          23.291
> 4096              FRC              FRC          47.117
> 
> *FRC = failed to reach confidence level
> 
> --
> Mike Kravetz                                 mkravetz@sequent.com
> IBM Linux Technology Center
> 15450 SW Koll Parkway
> Beaverton, OR 97006-6063                     (503)578-3494
> 
> _______________________________________________
> Lse-tech mailing list
> Lse-tech@lists.sourceforge.net
> http://lists.sourceforge.net/lists/listinfo/lse-tech

-- 
Jun U Nakajima
Core OS Development
SCO/Murray Hill, NJ
Email: jun@sco.com, Phone: 908-790-2352 Fax: 908-790-2426
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
