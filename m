Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262809AbRE0Q1U>; Sun, 27 May 2001 12:27:20 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262810AbRE0Q1K>; Sun, 27 May 2001 12:27:10 -0400
Received: from twilight.cs.hut.fi ([130.233.40.5]:32567 "EHLO
	twilight.cs.hut.fi") by vger.kernel.org with ESMTP
	id <S262809AbRE0Q1H>; Sun, 27 May 2001 12:27:07 -0400
Date: Sun, 27 May 2001 19:26:50 +0300
From: Ville Herva <vherva@mail.niksula.cs.hut.fi>
To: Alan Cox <laughing@shared-source.org>
Cc: linux-kernel@vger.kernel.org
Subject: [OOPS] Re: Linux 2.4.5-ac1
Message-ID: <20010527192650.H11981@niksula.cs.hut.fi>
In-Reply-To: <20010526225825.A31713@lightning.swansea.linux.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <20010526225825.A31713@lightning.swansea.linux.org.uk>; from laughing@shared-source.org on Sat, May 26, 2001 at 10:58:25PM +0100
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, May 26, 2001 at 10:58:25PM +0100, you [Alan Cox] claimed:
>
> o	Free the initial ramdisk correctly

Who made this fix, or who can I contact? 

I have a reproducible oops on 2.4.4ac17 (see
http://marc.theaimsgroup.com/?l=linux-kernel&m=99079948404775&w=2 for
details) that seems to be related:

(1)Unable to handle kernel NULL pointer
dereference at virtual address 00000013

>>EIP; c02997f6 <__devices_1045+5a/a8>   <=====                                 
Trace; c0136447 <ioctl_by_bdev+77/90>                                           
Trace; c017fec3 <batch_entropy_process+b3/c0>                                   
Trace; c0118769 <__run_task_queue+49/60>                                        
Trace; c011b0f6 <update_wall_time+16/50>                                        
Trace; c011b304 <timer_bh+24/250>                                               
Trace; c011868c <bh_action+1c/60>                                               
Trace; c0118596 <tasklet_hi_action+36/60>                                       
Trace; c011849b <do_softirq+5b/80>                                              
Trace; c010832f <do_IRQ+9f/b0>                                                  
Trace; c0106f14 <ret_from_intr+0/20>                                            
Trace; c0199756 <rd_make_request+d6/100>                                        
Trace; c01330d6 <try_to_free_buffers+f6/140>                                    
Trace; c0131447 <getblk+e7/100>                                                 
Trace; c0122cf5 <truncate_list_pages+145/170>                                   
Trace; c01416db <destroy_inode+1b/20>                                           
Trace; c0142b81 <iput+121/130>                                                  
Trace; c0136641 <blkdev_put+71/a0>                                              
Trace; c013484a <kill_super+da/100>                                             
Trace; c0134ab0 <do_umount+e0/f0>                                               
Trace; c0105000 <do_linuxrc+0/e0>                                               
Trace; c01177e6 <sys_waitpid+16/20>                                             
Trace; c0105000 <do_linuxrc+0/e0>                                               
Trace; c01051da <prepare_namespace+fa/120>                                      
Trace; c010520e <init+e/140>                                                    
Trace; c0105000 <do_linuxrc+0/e0>                                               
Trace; c01056a6 <kernel_thread+26/30>                                           
Trace; c0105200 <init+0/140>                                                    
Code;  c02997f6 <__devices_1045+5a/a8>                                          
00000000 <_EIP>:                                                                
Code;  c02997f6 <__devices_1045+5a/a8>   <=====                                 
   0:   8b 40 10                  mov    0x10(%eax),%eax   <=====               
Code;  c02997f9 <__devices_1045+5d/a8>                                          
   3:   83 f8 02                  cmp    $0x2,%eax                              
Code;  c02997fc <__devices_1045+60/a8>                                          
   6:   7e 62                     jle    6a <_EIP+0x6a> c0299860                
<__devices_104a                                                                 
+c/20>                                                                          
Code;  c02997fe <__devices_1045+62/a8>                                          
   8:   b8 f0 ff ff ff            mov    $0xfffffff0,%eax                       
Code;  c0299803 <__devices_1045+67/a8>                                          
   d:   eb 74                     jmp    83 <_EIP+0x83> c0299879                
<__devices_104b                                                                 
+5/18>                                                                          
Code;  c0299805 <__devices_1045+69/a8>                                          
   f:   85 c9                     test   %ecx,%ecx                              
Code;  c0299807 <__devices_1045+6b/a8>                                          
  11:   b8 ea ff 00 00            mov    $0xffea,%eax                           

Judging from the stack trace, I suspect that after kill_super is called (and
hence, root device invalidated and freed), a function that that assumes a
valid rootdev (ioctl_by_bdev) is called. Rdev is NULL, and hence the null
ptr deref. Is this anywhere near the truth?


-- v --

v@iki.fi

PS: A this is a 600Mhz Xeon w/ 256MB RAM. Right after boot I did 
'diff -nauR linux-2.4.5 linux-2.4.4ac17' on redhat 2.4.2-2, and it never
finished:

root@machine:/poista>diff -nauR linux-2.4.5 linux-2.4.4ac17
zsh: terminated  diff -nauR linux-2.4.5 linux-2.4.4ac17
root@machine:/poista>free
             total       used       free     shared    buffers     cached
Mem:        255572     253140       2432          0       8332     215108
-/+ buffers/cache:      29700     225872
Swap:            0          0          0
root@machine:/poista>uname -a
Linux machine 2.4.2-2 #1 Sun Apr 8 20:41:30 EDT 2001 i686 unknown
root@machine:/poista>dmesg | tail -2
Out of Memory: Killed process 804 (xfs).
Out of Memory: Killed process 15857 (diff).

So diff (which used very little RAM) filled the _cache_ and OOM rambo kicked
in. Pretty embarrassing to say at least...
