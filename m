Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263803AbTK2RAx (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 29 Nov 2003 12:00:53 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263801AbTK2RAx
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 29 Nov 2003 12:00:53 -0500
Received: from www13.mailshell.com ([209.157.66.247]:2966 "HELO mailshell.com")
	by vger.kernel.org with SMTP id S263830AbTK2RAg (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 29 Nov 2003 12:00:36 -0500
Message-ID: <20031129170034.10522.qmail@mailshell.com>
Date: Sat, 29 Nov 2003 19:00:31 +0200
X-Accept-Language: en-us, en
MIME-Version: 1.0
Subject: Re: PROBLEM: 2.6test11 kernel panic on "head -1 /proc/net/tcp"
References: <20031128170138.9513.qmail@mailshell.com> <87d6bc2yvq.fsf@devron.myhome.or.jp>
In-Reply-To: <87d6bc2yvq.fsf@devron.myhome.or.jp>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
From: lkml-031128@amos.mailshell.com
To: linux-kernel@vger.kernel.org
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

OGAWA Hirofumi wrote:
> lkml-031128@amos.mailshell.com writes:
> 
> 
>>"bad: scheduling while atomic!
>>Call Trace:
>>   schedule+0x55d/0x570
> 
> 
> Does this patch fix this problem?
> 
> diff -puN net/ipv4/tcp_ipv4.c~tcp_seq-oops-fix net/ipv4/tcp_ipv4.c
> --- linux-2.6.0-test11/net/ipv4/tcp_ipv4.c~tcp_seq-oops-fix	2003-11-29 00:52:15.000000000 +0900
> +++ linux-2.6.0-test11-hirofumi/net/ipv4/tcp_ipv4.c	2003-11-29 00:52:28.000000000 +0900
> @@ -2356,6 +2356,7 @@ static void *tcp_get_idx(struct seq_file
>  static void *tcp_seq_start(struct seq_file *seq, loff_t *pos)
>  {
>  	struct tcp_iter_state* st = seq->private;
> +	st->state = TCP_SEQ_STATE_LISTENING;
>  	st->num = 0;
>  	return *pos ? tcp_get_idx(seq, *pos - 1) : SEQ_START_TOKEN;
>  }
> 
> _

Partially.  It seems to trigger ppp failure later.

What I do to test this:

1. Compiled a pre-emptive kernel with nothing different in the config
and the code except that I added your patch.

2. Boot to single user mode as before.

3. "cat /proc/net/tcp" runs fine.

4. "head -1 /proc/net/tcp" runs fine (it used to freeze with an oops, as
described in my original message).

5. I logout from single user mode and let the system boot to multi-user.

This gives me tons of messages like the following:

Badness in local_bh_enable at kernel/softirq.c:121
Call Trace:
  [<c011df25>] local_bh_enable+0x85/0x90
  [<c02315e2>] ppp_async_push+0xa2/0x180
  [<c0230efd>] ppp_asynctty_wakeup+0x2d/0x60
  [<c0202638>] pty_unthrottle+0x58/0x60
  [<c01ff0fd>] check_unthrottle+0x3d/0x40
  [<c01ff1a3>] n_tty_flush_buffer+0x13/0x60
  [<c0202a47>] pty_flush_buffer+0x67/0x70
  [<c01fba41>] do_tty_hangup+0x3f1/0x460
  [<c01fcfbc>] release_dev+0x62c/0x660
  [<c013dfab>] zap_pmd_range+0x4b/0x70
  [<c013e013>] unmap_page_range+0x43/0x70
  [<c01622a2>] dput+0x22/0x210
  [<c01fd38a>] tty_release+0x2a/0x60
  [<c014ccf8>] __fput+0x108/0x120
  [<c014b359>] filp_close+0x59/0x90
  [<c011b874>] put_files_struct+0x54/0xc0
  [<c011c47d>] do_exit+0x15d/0x3e0
  [<c011c79a>] do_group_exit+0x3a/0xb0
  [<c01091b7>] syscall_call+0x7/0xb

PPP fails. Re-run "pon adsl-provider" or "/etc/init.d/ppp start" fails.
What I get on such attempts are messages in /var/log/messages
like:

Nov 29 18:48:57 picton kernel: Badness in local_bh_enable at 
kernel/softirq.c:121
Nov 29 18:48:57 picton kernel: Call Trace:
Nov 29 18:48:57 picton kernel:  [local_bh_enable+133/144] 
local_bh_enable+0x85/0x90
Nov 29 18:48:57 picton kernel:  [ppp_async_push+162/384] 
ppp_async_push+0xa2/0x180
Nov 29 18:48:57 picton kernel:  [ppp_asynctty_wakeup+45/96] 
ppp_asynctty_wakeup+0x2d/0x60
Nov 29 18:48:57 picton kernel:  [pty_unthrottle+88/96] 
pty_unthrottle+0x58/0x60
Nov 29 18:48:57 picton kernel:  [check_unthrottle+61/64] 
check_unthrottle+0x3d/0x40
Nov 29 18:48:57 picton kernel:  [n_tty_flush_buffer+19/96] 
n_tty_flush_buffer+0x13/0x60
Nov 29 18:48:57 picton kernel:  [pty_flush_buffer+103/112] 
pty_flush_buffer+0x67/0x70
Nov 29 18:48:57 picton kernel:  [do_tty_hangup+1009/1120] 
do_tty_hangup+0x3f1/0x460
Nov 29 18:48:57 picton kernel:  [release_dev+1580/1632] 
release_dev+0x62c/0x660
Nov 29 18:48:57 picton kernel:  [zap_pmd_range+75/112] 
zap_pmd_range+0x4b/0x70
Nov 29 18:48:57 picton kernel:  [unmap_page_range+67/112] 
unmap_page_range+0x43/0x70
Nov 29 18:48:57 picton kernel:  [dput+34/528] dput+0x22/0x210
Nov 29 18:48:57 picton kernel:  [tty_release+42/96] tty_release+0x2a/0x60
Nov 29 18:48:57 picton kernel:  [__fput+264/288] __fput+0x108/0x120
Nov 29 18:48:57 picton kernel:  [filp_close+89/144] filp_close+0x59/0x90
Nov 29 18:48:57 picton kernel:  [put_files_struct+84/192] 
put_files_struct+0x54/0xc0
Nov 29 18:48:57 picton kernel:  [do_exit+349/992] do_exit+0x15d/0x3e0
Nov 29 18:48:57 picton kernel:  [do_group_exit+58/176] 
do_group_exit+0x3a/0xb0
Nov 29 18:48:57 picton kernel:  [syscall_call+7/11] syscall_call+0x7/0xb
Nov 29 18:48:57 picton kernel:
Nov 29 18:48:57 picton pppd[32717]: Modem hangup
Nov 29 18:48:57 picton pppd[32717]: Connection terminated.
Nov 29 18:48:57 picton pppd[32717]: Exit.

Ksymoops doesn't seem to add much useful data, here is what I get
from it:

Trace; c011df25 <local_bh_enable+85/90>
Trace; c02315e2 <ppp_async_push+a2/180>
Trace; c0230efd <ppp_asynctty_wakeup+2d/60>
Trace; c0202638 <pty_unthrottle+58/60>
Trace; c01ff0fd <check_unthrottle+3d/40>
Trace; c01ff1a3 <n_tty_flush_buffer+13/60>
Trace; c0202a47 <pty_flush_buffer+67/70>
Trace; c01fba41 <do_tty_hangup+3f1/460>
Trace; c01fcfbc <release_dev+62c/660>
Trace; c013dfab <zap_pmd_range+4b/70>
Trace; c013e013 <unmap_page_range+43/70>
Trace; c01622a2 <dput+22/210>
Trace; c01fd38a <tty_release+2a/60>
Trace; c014ccf8 <__fput+108/120>
Trace; c014b359 <filp_close+59/90>
Trace; c011b874 <put_files_struct+54/c0>
Trace; c011c47d <do_exit+15d/3e0>
Trace; c011c79a <do_group_exit+3a/b0>
Trace; c01091b7 <syscall_call+7/b>

If I avoid doing the "head -1 /proc/net/tcp" in single user then PPP
works.

Thanks,

--Amos

