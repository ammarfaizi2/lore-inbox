Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261717AbTHYHXd (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 25 Aug 2003 03:23:33 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261720AbTHYHXd
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 25 Aug 2003 03:23:33 -0400
Received: from mail3.ithnet.com ([217.64.64.7]:58242 "HELO
	heather-ng.ithnet.com") by vger.kernel.org with SMTP
	id S261717AbTHYHX3 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 25 Aug 2003 03:23:29 -0400
X-Sender-Authentication: SMTPafterPOP by <info@euro-tv.de> from 217.64.64.14
Date: Mon, 25 Aug 2003 09:23:26 +0200
From: Stephan von Krawczynski <skraw@ithnet.com>
To: TeJun Huh <tejun@aratech.co.kr>
Cc: linux-kernel@vger.kernel.org
Subject: Re: Race condition in 2.4 tasklet handling (cli() broken?)
Message-Id: <20030825092326.7d360471.skraw@ithnet.com>
In-Reply-To: <20030825063155.GA11458@atj.dyndns.org>
References: <20030823025448.GA32547@atj.dyndns.org>
	<20030823040931.GA3872@atj.dyndns.org>
	<20030823052633.GA4307@atj.dyndns.org>
	<20030823122813.0c90e241.skraw@ithnet.com>
	<20030823151315.GA6781@atj.dyndns.org>
	<20030823173736.13235adc.skraw@ithnet.com>
	<20030825063155.GA11458@atj.dyndns.org>
Organization: ith Kommunikationstechnik GmbH
X-Mailer: Sylpheed version 0.9.4 (GTK+ 1.2.10; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 25 Aug 2003 15:31:55 +0900
TeJun Huh <tejun@aratech.co.kr> wrote:

> On Sat, Aug 23, 2003 at 05:37:36PM +0200, Stephan von Krawczynski wrote:
> > 
> > Feel free to ask anything about the issue, I will try to help however possible.
> 
>  A deadlock occured today on our test machine, and the offending part
> was drivers/char/random.c:iplock.  The spinlock is used without _bh
> suffix both by the connect and accept paths causing deadlock
> occasionally.  This seemed to be already fixed in the latest 2.4 bk
> tree.  I believe this will cure our problem. :-)
> 
> -- 
> tejun

Hello TeJun,

I started testing your latest patch yesterday on top of rc3 and got the following:

ksymoops 2.4.8 on i686 2.4.22-rc3-huh.  Options used
     -V (default)
     -k /proc/ksyms (default)
     -l /proc/modules (default)
     -o /lib/modules/2.4.22-rc3-huh/ (default)
     -m /boot/System.map-2.4.22-rc3-huh (default)

Warning: You did not tell me where to find symbol information.  I will
assume that the log matches the kernel and modules that are running
right now and I'll use the default options above for symbol resolution.
If the current kernel and/or modules do not match the log, you can get
more accurate output by telling me the kernel version and where to find
map, modules, ksyms etc.  ksymoops -h explains the options.

Kernel panic: Ththththaats all folks.  Too dangerous to continue.
NMI Watchdog detected LOCKUP on CPU0, eip c01db130, registers:
CPU:    0
EIP:    0010:[<c01db130>]    Not tainted
Using defaults from ksymoops -t elf32-i386 -a i386
EFLAGS: 00000082
eax: 00000400   ebx: c3461640   ecx: 00000803   edx: f79bc000
esi: c1000020   edi: cccb0f38   ebp: 00000001   esp: f46fdbec
ds: 0018   es: 0018   ss: 0018
Process tar (pid: 9634, stackpage=f46fd000)
Stack: 0000007d 0009b220 9410d001 f0000000 00000001 00000003 c3461640 c0115f54
       00000400 00000200 00000000 00000000 c3461648 00000000 00000008 002a2480
       00000000 00000803 cccb0f38 00000008 00000001 c01da99e c3461618 00000001
Call Trace:    [<c0115f54>] [<c01da99e>] [<c01daa7e>] [<c0144a9c>] [<c0144bb0>]
  [<c01cbe24>] [<c01ce9b8>] [<c01d6590>] [<c011cc9e>] [<c0144be5>] [<c0144d2a>]
  [<c0144ee1>] [<c0144f7f>] [<c011c788>] [<c02174c1>] [<c021779d>] [<c01da4b0>]
  [<c01da99e>] [<c01daa7e>] [<c0146ce7>] [<c013aee2>] [<c0130dce>] [<c0195aa0>]
  [<c01314bf>] [<c01317a1>] [<c0131da0>] [<c013204c>] [<c0131da0>] [<c01432db>]
  [<c010782f>]
Code: f3 90 7e f5 e9 db f0 ff ff 80 3d b8 fb 30 c0 00 f3 90 7e f5


>>EIP; c01db130 <.text.lock.ll_rw_blk+57/77>   <=====

>>ebx; c3461640 <_end+3099fe0/38512a00>
>>edx; f79bc000 <_end+375f49a0/38512a00>
>>esi; c1000020 <_end+c389c0/38512a00>
>>edi; cccb0f38 <_end+c8e98d8/38512a00>
>>esp; f46fdbec <_end+3433658c/38512a00>

Trace; c0115f54 <smp_apic_timer_interrupt+134/160>
Trace; c01da99e <generic_make_request+be/140>
Trace; c01daa7e <submit_bh+5e/c0>
Trace; c0144a9c <write_locked_buffers+2c/40>
Trace; c0144bb0 <write_some_buffers+100/110>
Trace; c01cbe24 <lf+74/80>
Trace; c01ce9b8 <vt_console_print+248/370>
Trace; c01d6590 <serial_console_write+120/220>
Trace; c011cc9e <__call_console_drivers+4e/70>
Trace; c0144be5 <write_unlocked_buffers+25/30>
Trace; c0144d2a <sync_buffers+1a/80>
Trace; c0144ee1 <fsync_dev+21/a0>
Trace; c0144f7f <sys_sync+f/20>
Trace; c011c788 <panic+128/140>
Trace; c02174c1 <dump_stats+61/b0>
Trace; c021779d <scsi_back_merge_fn_c+7d/c0>
Trace; c01da4b0 <__make_request+380/7b0>
Trace; c01da99e <generic_make_request+be/140>
Trace; c01daa7e <submit_bh+5e/c0>
Trace; c0146ce7 <block_read_full_page+2d7/2f0>
Trace; c013aee2 <__alloc_pages+42/190>
Trace; c0130dce <page_cache_read+be/e0>
Trace; c0195aa0 <reiserfs_get_block+0/1490>
Trace; c01314bf <generic_file_readahead+af/1a0>
Trace; c01317a1 <do_generic_file_read+1c1/470>
Trace; c0131da0 <file_read_actor+0/110>
Trace; c013204c <generic_file_read+19c/1b0>
Trace; c0131da0 <file_read_actor+0/110>
Trace; c01432db <sys_read+9b/180>
Trace; c010782f <system_call+33/38>

Code;  c01db130 <.text.lock.ll_rw_blk+57/77>
00000000 <_EIP>:
Code;  c01db130 <.text.lock.ll_rw_blk+57/77>   <=====
   0:   f3 90                     repz nop    <=====
Code;  c01db132 <.text.lock.ll_rw_blk+59/77>
   2:   7e f5                     jle    fffffff9 <_EIP+0xfffffff9>
Code;  c01db134 <.text.lock.ll_rw_blk+5b/77>
   4:   e9 db f0 ff ff            jmp    fffff0e4 <_EIP+0xfffff0e4>
Code;  c01db139 <.text.lock.ll_rw_blk+60/77>
   9:   80 3d b8 fb 30 c0 00      cmpb   $0x0,0xc030fbb8
Code;  c01db140 <.text.lock.ll_rw_blk+67/77>
  10:   f3 90                     repz nop 
Code;  c01db142 <.text.lock.ll_rw_blk+69/77>
  12:   7e f5                     jle    9 <_EIP+0x9>


1 warning issued.  Results may not be reliable.

Can you comment this one?

Regards,
Stephan

