Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S272079AbRH2VO4>; Wed, 29 Aug 2001 17:14:56 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S272078AbRH2VOt>; Wed, 29 Aug 2001 17:14:49 -0400
Received: from [208.48.139.185] ([208.48.139.185]:33155 "HELO
	forty.greenhydrant.com") by vger.kernel.org with SMTP
	id <S272079AbRH2VOj>; Wed, 29 Aug 2001 17:14:39 -0400
Date: Wed, 29 Aug 2001 14:14:51 -0700
From: David Rees <dbr@greenhydrant.com>
To: Andrew Morton <akpm@zip.com.au>
Cc: linux-raid@vger.kernel.org, linux-kernel@vger.kernel.org,
        ext3-users@redhat.com
Subject: Re: kupdated, bdflush and kjournald stuck in D state on RAID1 device (deadlock?)
Message-ID: <20010829141451.A20968@greenhydrant.com>
Mail-Followup-To: David Rees <dbr@greenhydrant.com>,
	Andrew Morton <akpm@zip.com.au>, linux-raid@vger.kernel.org,
	linux-kernel@vger.kernel.org, ext3-users@redhat.com
In-Reply-To: <20010829131720.A20537@greenhydrant.com> <3B8D54F3.46DC2ABB@zip.com.au>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <3B8D54F3.46DC2ABB@zip.com.au>; from akpm@zip.com.au on Wed, Aug 29, 2001 at 01:47:47PM -0700
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Aug 29, 2001 at 01:47:47PM -0700, Andrew Morton wrote:
> 
> Certainly seems that way.
> 
> Can you please send the output of
> 
> 	ps xwo pid,command,wchan
> 
> Also, try a SYSRQ-T and, if the result makes it into the
> logs, please pass it through `ksymoops -m System.map'.

OK, here's the ps output:

# ps xwo pid,command,wchan
  PID COMMAND          WCHAN
    1 init [3]         do_select
    2 [keventd]        context_thread
    3 [ksoftirqd_CPU0] ksoftirqd
    4 [kswapd]         kswapd
    5 [kreclaimd]      kreclaimd
    6 [bdflush]        raid1_alloc_r1bh
    7 [kupdated]       log_wait_commit
    9 [mdrecoveryd]    md_thread
   10 [raid1d]         md_thread
   11 [kjournald]      kjournald
  130 [kjournald]      kjournald
  131 [kjournald]      wait_on_buffer
  374 syslogd -m 0     do_select
  379 klogd -2         do_syslog
  433 ntpd             do_select
  444 sshd             do_select
  475 crond            nanosleep
  489 /sbin/mingetty t read_chan
  490 /sbin/mingetty t read_chan
  491 /sbin/mingetty t read_chan
  492 /sbin/mingetty t read_chan
  493 /sbin/mingetty t read_chan
16670 xinetd -stayaliv do_select
17481 /sbin/mingetty t read_chan
17814 sshd             do_select
18006 [rpciod]         rpciod
18007 [lockd]          svc_recv
18061 sshd             do_select
18238 su -             wait4
18239 -bash            wait4
18274 umount /opt      rwsem_down_write_failed
18277 su -             wait4
18278 -bash            wait4
18321 CROND            pipe_wait
18322 /bin/bash /usr/b wait4
18324 awk -v progname= pipe_wait
18325 /bin/sh /usr/lib wait4
18327 /usr/lib/sa/sadc pause
18328 ps xwo pid,comma -
#

Since last time I had tried unsuccessfully unmount the /opt partition which
is the RAID1 disk.  Otherwise, the partition still seems to behaving
normally.

Below is the output from ksymoops.

Thanks,
Dave

# ksymoops -m /boot/System.map < ksym.out 
ksymoops 2.4.0 on i686 2.4.9-pl2-c1.  Options used
     -V (default)
     -k /proc/ksyms (default)
     -l /proc/modules (default)
     -o /lib/modules/2.4.9-pl2-c1/ (default)
     -m /boot/System.map (specified)

No modules in ksyms, skipping objects
Warning (read_lsmod): no symbols in lsmod, is /proc/modules a valid lsmod
file?
Warning (compare_maps): mismatch on symbol partition_name  , ksyms_base says
c01f17e0, System.map says c014c590.  Ignoring ksyms_base entry
Call Trace: [<c011144d>] [<c0111380>] [<c013dafb>] [<c013de8c>] [<c0106cdb>] 
Call Trace: [<c011ebbd>] [<c011eac0>] [<c0105000>] [<c0105516>] [<c011eac0>] 
Call Trace: [<c0105000>] [<c0117bdf>] [<c0105516>] [<c0117b70>] 
Call Trace: [<c011144d>] [<c0111380>] [<c0111b71>] [<c012a139>] [<c0105000>] 
   [<c0105000>] [<c0105516>] [<c012a090>] 
Call Trace: [<c0111b0c>] [<c012a1fa>] [<c0105000>] [<c0105516>] [<c012a1b0>] 
Call Trace: [<c01e9745>] [<c01e9e80>] [<c01d23fa>] [<c01f1609>] [<c01c3c70>] 
   [<c01d2a53>] [<c01c3cd8>] [<c0130554>] [<c0130613>] [<c0133656>]
[<c0105000>] 
   [<c0105516>] [<c01335e0>] 
Call Trace: [<c0111bcc>] [<c015a8ca>] [<c0156e7e>] [<c0156eba>] [<c0155381>] 
   [<c0105bd7>] [<c01553d4>] [<c013452e>] [<c01334cc>] [<c0133786>]
[<c0105000>] 
   [<c0105516>] [<c0133690>] 
Call Trace: [<c01f5536>] [<c0105516>] [<c01f5460>] 
Call Trace: [<c01f5536>] [<c0105516>] [<c01f5460>] 
Call Trace: [<c0111b0c>] [<c015a49a>] [<c015a350>] [<c0105516>] [<c015a370>] 
Call Trace: [<c0111b0c>] [<c015a49a>] [<c015a350>] [<c0105516>] [<c015a370>] 
Call Trace: [<c01304b8>] [<c0157c4f>] [<c015a476>] [<c015a350>] [<c0105516>] 
   [<c015a370>] 
Call Trace: [<c013d7c3>] [<c01113e7>] [<c01fceaf>] [<c013dafb>] [<c013de8c>] 
   [<c0106cdb>] 
Call Trace: [<c01139ee>] [<c012f725>] [<c0108208>] [<c010822c>] [<c0106cdb>] 
Call Trace: [<c01113e7>] [<c013e039>] [<c013e103>] [<c013e139>] [<c013e3a9>] 
   [<c0106cdb>] 
Call Trace: [<c01113e7>] [<c01fceaf>] [<c013dafb>] [<c013de8c>] [<c0106cdb>] 
Call Trace: [<c013d7c3>] [<c01113e7>] [<c01fceaf>] [<c013dafb>] [<c013de8c>] 
   [<c0106cdb>] 
Call Trace: [<c01113e7>] [<c01fceaf>] [<c013dafb>] [<c013de8c>] [<c0106cdb>] 
Call Trace: [<c011144d>] [<c0111380>] [<c01374e2>] [<c011ae12>] [<c0106cdb>] 
Call Trace: [<c01113e7>] [<c01ae39b>] [<c01afab5>] [<c01ac046>] [<c0121b5e>] 
   [<c012f725>] [<c012f2f2>] [<c0121ba2>] [<c0106cdb>] 
Call Trace: [<c01113e7>] [<c01ae39b>] [<c01afab5>] [<c01ac046>] [<c0121b5e>] 
   [<c012f725>] [<c012f2f2>] [<c0121ba2>] [<c0106cdb>] 
Call Trace: [<c01113e7>] [<c01ae39b>] [<c01afab5>] [<c01ac046>] [<c0121b5e>] 
   [<c012f725>] [<c012f2f2>] [<c0121ba2>] [<c0106cdb>] 
Call Trace: [<c01113e7>] [<c01ae39b>] [<c01afab5>] [<c01ac046>] [<c0121b5e>] 
   [<c012f725>] [<c012f2f2>] [<c0121ba2>] [<c0106cdb>] 
Call Trace: [<c01113e7>] [<c01ae39b>] [<c01afab5>] [<c01ac046>] [<c0121b5e>] 
   [<c012f725>] [<c012f2f2>] [<c0121ba2>] [<c0106cdb>] 
Call Trace: [<c01113e7>] [<c0110c16>] [<c01fceaf>] [<c013dafb>] [<c013de8c>] 
   [<c0106cdb>] 
Call Trace: [<c01113e7>] [<c01ae39b>] [<c01afab5>] [<c01ac046>] [<c0121b5e>] 
   [<c012f725>] [<c012f2f2>] [<c0121ba2>] [<c0106cdb>] 
Call Trace: [<c01113e7>] [<c01fceaf>] [<c013dafb>] [<c013de8c>] [<c010823c>] 
   [<c0106cdb>] 
Call Trace: [<c0116a71>] [<c0106cdb>] 
Call Trace: [<c02358e2>] [<c0105516>] [<c0235750>] 
Call Trace: [<c01113e7>] [<c0127f07>] [<c02385c6>] [<c0181c12>] [<c0181ac0>] 
   [<c0105516>] [<c0181ac0>] 
Call Trace: [<c01113e7>] [<c01fceaf>] [<c013dafb>] [<c013de8c>] [<c0202e92>] 
   [<c010823c>] [<c0106cdb>] 
Call Trace: [<c01113e7>] [<c01afab5>] [<c01ac046>] [<c011c652>] [<c012f725>] 
   [<c0120df7>] [<c0106cdb>] 
Call Trace: [<c0116a71>] [<c0106cdb>] 
Call Trace: [<c0116a71>] [<c0106cdb>] 
Call Trace: [<c023b6d5>] [<c023db5e>] [<c0139697>] [<c0135058>] [<c012f2f2>] 
   [<c0121ba2>] [<c013509b>] [<c0106cdb>] 
Call Trace: [<c0116a71>] [<c0106cdb>] 
Call Trace: [<c01113e7>] [<c01afab5>] [<c01ac046>] [<c011c652>] [<c012f725>] 
   [<c0106cdb>] 
Call Trace: [<c013882b>] [<c0138914>] [<c012f725>] [<c012f677>] [<c0106cdb>] 
Call Trace: [<c0116a71>] [<c0106cdb>] 
Call Trace: [<c013882b>] [<c0138914>] [<c012f725>] [<c0120df7>] [<c012f677>] 
   [<c0106cdb>] 
Call Trace: [<c0116a71>] [<c0106cdb>] 
Call Trace: [<c010b912>] [<c0106cdb>] 
Warning (Oops_read): Code line not seen, dumping what data is available

Trace; c011144d <schedule_timeout+7d/a0>
Trace; c0111380 <process_timeout+0/50>
Trace; c013dafb <do_select+1fb/230>
Trace; c013de8c <sys_select+32c/480>
Trace; c0106cdb <system_call+33/38>
Trace; c011ebbd <context_thread+fd/1b0>
Trace; c011eac0 <context_thread+0/1b0>
Trace; c0105000 <_stext+0/0>
Trace; c0105516 <kernel_thread+26/30>
Trace; c011eac0 <context_thread+0/1b0>
Trace; c0105000 <_stext+0/0>
Trace; c0117bdf <ksoftirqd+6f/c0>
Trace; c0105516 <kernel_thread+26/30>
Trace; c0117b70 <ksoftirqd+0/c0>
Trace; c011144d <schedule_timeout+7d/a0>
Trace; c0111380 <process_timeout+0/50>
Trace; c0111b71 <interruptible_sleep_on_timeout+41/60>
Trace; c012a139 <kswapd+a9/b0>
Trace; c0105000 <_stext+0/0>
Trace; c0105000 <_stext+0/0>
Trace; c0105516 <kernel_thread+26/30>
Trace; c012a090 <kswapd+0/b0>
Trace; c0111b0c <interruptible_sleep_on+3c/60>
Trace; c012a1fa <kreclaimd+4a/a0>
Trace; c0105000 <_stext+0/0>
Trace; c0105516 <kernel_thread+26/30>
Trace; c012a1b0 <kreclaimd+0/a0>
Trace; c01e9745 <raid1_alloc_r1bh+f5/140>
Trace; c01e9e80 <raid1_make_request+50/330>
Trace; c01d23fa <ide_wait_stat+ba/100>
Trace; c01f1609 <md_make_request+49/80>
Trace; c01c3c70 <generic_make_request+100/110>
Trace; c01d2a53 <ide_do_request+293/2e0>
Trace; c01c3cd8 <submit_bh+58/70>
Trace; c0130554 <write_locked_buffers+24/30>
Trace; c0130613 <write_some_buffers+b3/120>
Trace; c0133656 <bdflush+76/b0>
Trace; c0105000 <_stext+0/0>
Trace; c0105516 <kernel_thread+26/30>
Trace; c01335e0 <bdflush+0/b0>
Trace; c0111bcc <sleep_on+3c/60>
Trace; c015a8ca <log_wait_commit+3a/50>
Trace; c0156e7e <journal_stop+17e/190>
Trace; c0156eba <journal_force_commit+2a/30>
Trace; c0155381 <ext3_force_commit+21/30>
Trace; c0105bd7 <__down_failed_trylock+7/c>
Trace; c01553d4 <ext3_write_super+44/60>
Trace; c013452e <sync_supers+be/e0>
Trace; c01334cc <sync_old_buffers+c/40>
Trace; c0133786 <kupdate+f6/100>
Trace; c0105000 <_stext+0/0>
Trace; c0105516 <kernel_thread+26/30>
Trace; c0133690 <kupdate+0/100>
Trace; c01f5536 <md_thread+d6/160>
Trace; c0105516 <kernel_thread+26/30>
Trace; c01f5460 <md_thread+0/160>
Trace; c01f5536 <md_thread+d6/160>
Trace; c0105516 <kernel_thread+26/30>
Trace; c01f5460 <md_thread+0/160>
Trace; c0111b0c <interruptible_sleep_on+3c/60>
Trace; c015a49a <kjournald+12a/1a0>
Trace; c015a350 <commit_timeout+0/10>
Trace; c0105516 <kernel_thread+26/30>
Trace; c015a370 <kjournald+0/1a0>
Trace; c0111b0c <interruptible_sleep_on+3c/60>
Trace; c015a49a <kjournald+12a/1a0>
Trace; c015a350 <commit_timeout+0/10>
Trace; c0105516 <kernel_thread+26/30>
Trace; c015a370 <kjournald+0/1a0>
Trace; c01304b8 <__wait_on_buffer+68/90>
Trace; c0157c4f <journal_commit_transaction+40f/1090>
Trace; c015a476 <kjournald+106/1a0>
Trace; c015a350 <commit_timeout+0/10>
Trace; c0105516 <kernel_thread+26/30>
Trace; c015a370 <kjournald+0/1a0>
Trace; c013d7c3 <__pollwait+33/90>
Trace; c01113e7 <schedule_timeout+17/a0>
Trace; c01fceaf <sock_poll+1f/30>
Trace; c013dafb <do_select+1fb/230>
Trace; c013de8c <sys_select+32c/480>
Trace; c0106cdb <system_call+33/38>
Trace; c01139ee <do_syslog+be/2e0>
Trace; c012f725 <sys_read+95/d0>
Trace; c0108208 <do_IRQ+68/b0>
Trace; c010822c <do_IRQ+8c/b0>
Trace; c0106cdb <system_call+33/38>
Trace; c01113e7 <schedule_timeout+17/a0>
Trace; c013e039 <do_pollfd+59/80>
Trace; c013e103 <do_poll+a3/100>
Trace; c013e139 <do_poll+d9/100>
Trace; c013e3a9 <sys_poll+249/380>
Trace; c0106cdb <system_call+33/38>
Trace; c01113e7 <schedule_timeout+17/a0>
Trace; c01fceaf <sock_poll+1f/30>
Trace; c013dafb <do_select+1fb/230>
Trace; c013de8c <sys_select+32c/480>
Trace; c0106cdb <system_call+33/38>
Trace; c013d7c3 <__pollwait+33/90>
Trace; c01113e7 <schedule_timeout+17/a0>
Trace; c01fceaf <sock_poll+1f/30>
Trace; c013dafb <do_select+1fb/230>
Trace; c013de8c <sys_select+32c/480>
Trace; c0106cdb <system_call+33/38>
Trace; c01113e7 <schedule_timeout+17/a0>
Trace; c01fceaf <sock_poll+1f/30>
Trace; c013dafb <do_select+1fb/230>
Trace; c013de8c <sys_select+32c/480>
Trace; c0106cdb <system_call+33/38>
Trace; c011144d <schedule_timeout+7d/a0>
Trace; c0111380 <process_timeout+0/50>
Trace; c01374e2 <sys_stat64+62/70>
Trace; c011ae12 <sys_nanosleep+122/1a0>
Trace; c0106cdb <system_call+33/38>
Trace; c01113e7 <schedule_timeout+17/a0>
Trace; c01ae39b <opost+1ab/1c0>
Trace; c01afab5 <read_chan+365/690>
Trace; c01ac046 <tty_read+b6/e0>
Trace; c0121b5e <do_munmap+26e/280>
Trace; c012f725 <sys_read+95/d0>
Trace; c012f2f2 <filp_close+52/60>
Trace; c0121ba2 <sys_munmap+32/50>
Trace; c0106cdb <system_call+33/38>
Trace; c01113e7 <schedule_timeout+17/a0>
Trace; c01ae39b <opost+1ab/1c0>
Trace; c01afab5 <read_chan+365/690>
Trace; c01ac046 <tty_read+b6/e0>
Trace; c0121b5e <do_munmap+26e/280>
Trace; c012f725 <sys_read+95/d0>
Trace; c012f2f2 <filp_close+52/60>
Trace; c0121ba2 <sys_munmap+32/50>
Trace; c0106cdb <system_call+33/38>
Trace; c01113e7 <schedule_timeout+17/a0>
Trace; c01ae39b <opost+1ab/1c0>
Trace; c01afab5 <read_chan+365/690>
Trace; c01ac046 <tty_read+b6/e0>
Trace; c0121b5e <do_munmap+26e/280>
Trace; c012f725 <sys_read+95/d0>
Trace; c012f2f2 <filp_close+52/60>
Trace; c0121ba2 <sys_munmap+32/50>
Trace; c0106cdb <system_call+33/38>
Trace; c01113e7 <schedule_timeout+17/a0>
Trace; c01ae39b <opost+1ab/1c0>
Trace; c01afab5 <read_chan+365/690>
Trace; c01ac046 <tty_read+b6/e0>
Trace; c0121b5e <do_munmap+26e/280>
Trace; c012f725 <sys_read+95/d0>
Trace; c012f2f2 <filp_close+52/60>
Trace; c0121ba2 <sys_munmap+32/50>
Trace; c0106cdb <system_call+33/38>
Trace; c01113e7 <schedule_timeout+17/a0>
Trace; c01ae39b <opost+1ab/1c0>
Trace; c01afab5 <read_chan+365/690>
Trace; c01ac046 <tty_read+b6/e0>
Trace; c0121b5e <do_munmap+26e/280>
Trace; c012f725 <sys_read+95/d0>
Trace; c012f2f2 <filp_close+52/60>
Trace; c0121ba2 <sys_munmap+32/50>
Trace; c0106cdb <system_call+33/38>
Trace; c01113e7 <schedule_timeout+17/a0>
Trace; c0110c16 <do_page_fault+176/470>
Trace; c01fceaf <sock_poll+1f/30>
Trace; c013dafb <do_select+1fb/230>
Trace; c013de8c <sys_select+32c/480>
Trace; c0106cdb <system_call+33/38>
Trace; c01113e7 <schedule_timeout+17/a0>
Trace; c01ae39b <opost+1ab/1c0>
Trace; c01afab5 <read_chan+365/690>
Trace; c01ac046 <tty_read+b6/e0>
Trace; c0121b5e <do_munmap+26e/280>
Trace; c012f725 <sys_read+95/d0>
Trace; c012f2f2 <filp_close+52/60>
Trace; c0121ba2 <sys_munmap+32/50>
Trace; c0106cdb <system_call+33/38>
Trace; c01113e7 <schedule_timeout+17/a0>
Trace; c01fceaf <sock_poll+1f/30>
Trace; c013dafb <do_select+1fb/230>
Trace; c013de8c <sys_select+32c/480>
Trace; c010823c <do_IRQ+9c/b0>
Trace; c0106cdb <system_call+33/38>
Trace; c0116a71 <sys_wait4+371/3a0>
Trace; c0106cdb <system_call+33/38>
Trace; c02358e2 <rpciod+192/240>
Trace; c0105516 <kernel_thread+26/30>
Trace; c0235750 <rpciod+0/240>
Trace; c01113e7 <schedule_timeout+17/a0>
Trace; c0127f07 <kmem_cache_free+237/2e0>
Trace; c02385c6 <svc_recv+1a6/3e0>
Trace; c0181c12 <lockd+152/270>
Trace; c0181ac0 <lockd+0/270>
Trace; c0105516 <kernel_thread+26/30>
Trace; c0181ac0 <lockd+0/270>
Trace; c01113e7 <schedule_timeout+17/a0>
Trace; c01fceaf <sock_poll+1f/30>
Trace; c013dafb <do_select+1fb/230>
Trace; c013de8c <sys_select+32c/480>
Trace; c0202e92 <net_tx_action+52/c0>
Trace; c010823c <do_IRQ+9c/b0>
Trace; c0106cdb <system_call+33/38>
Trace; c01113e7 <schedule_timeout+17/a0>
Trace; c01afab5 <read_chan+365/690>
Trace; c01ac046 <tty_read+b6/e0>
Trace; c011c652 <sys_rt_sigaction+92/f0>
Trace; c012f725 <sys_read+95/d0>
Trace; c0120df7 <sys_brk+b7/f0>
Trace; c0106cdb <system_call+33/38>
Trace; c0116a71 <sys_wait4+371/3a0>
Trace; c0106cdb <system_call+33/38>
Trace; c0116a71 <sys_wait4+371/3a0>
Trace; c0106cdb <system_call+33/38>
Trace; c023b6d5 <rwsem_down_write_failed+115/140>
Trace; c023db5e <stext_lock+6ce/2cae>
Trace; c0139697 <path_release+27/30>
Trace; c0135058 <sys_umount+d8/110>
Trace; c012f2f2 <filp_close+52/60>
Trace; c0121ba2 <sys_munmap+32/50>
Trace; c013509b <sys_oldumount+b/10>
Trace; c0106cdb <system_call+33/38>
Trace; c0116a71 <sys_wait4+371/3a0>
Trace; c0106cdb <system_call+33/38>
Trace; c01113e7 <schedule_timeout+17/a0>
Trace; c01afab5 <read_chan+365/690>
Trace; c01ac046 <tty_read+b6/e0>
Trace; c011c652 <sys_rt_sigaction+92/f0>
Trace; c012f725 <sys_read+95/d0>
Trace; c0106cdb <system_call+33/38>
Trace; c013882b <pipe_wait+7b/b0>
Trace; c0138914 <pipe_read+b4/220>
Trace; c012f725 <sys_read+95/d0>
Trace; c012f677 <sys_llseek+c7/e0>
Trace; c0106cdb <system_call+33/38>
Trace; c0116a71 <sys_wait4+371/3a0>
Trace; c0106cdb <system_call+33/38>
Trace; c013882b <pipe_wait+7b/b0>
Trace; c0138914 <pipe_read+b4/220>
Trace; c012f725 <sys_read+95/d0>
Trace; c0120df7 <sys_brk+b7/f0>
Trace; c012f677 <sys_llseek+c7/e0>
Trace; c0106cdb <system_call+33/38>
Trace; c0116a71 <sys_wait4+371/3a0>
Trace; c0106cdb <system_call+33/38>
Trace; c010b912 <sys_pause+12/20>
Trace; c0106cdb <system_call+33/38>


3 warnings issued.  Results may not be reliable.
# 
