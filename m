Return-Path: <linux-kernel-owner+willy=40w.ods.org-S267313AbUGNG6N@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S267313AbUGNG6N (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 14 Jul 2004 02:58:13 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267314AbUGNG6N
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 14 Jul 2004 02:58:13 -0400
Received: from fw.osdl.org ([65.172.181.6]:15806 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S267313AbUGNG6H (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 14 Jul 2004 02:58:07 -0400
Date: Tue, 13 Jul 2004 23:56:55 -0700
From: Andrew Morton <akpm@osdl.org>
To: Lee Revell <rlrevell@joe-job.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: XRUN traces
Message-Id: <20040713235655.263ce5f3.akpm@osdl.org>
In-Reply-To: <1089787542.3360.11.camel@mindpipe>
References: <1089758294.2747.4.camel@mindpipe>
	<20040713161004.37a4654e.akpm@osdl.org>
	<1089787542.3360.11.camel@mindpipe>
X-Mailer: Sylpheed version 0.9.7 (GTK+ 1.2.10; i386-redhat-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Lee Revell <rlrevell@joe-job.com> wrote:
>
> This is the only one I am still seeing that does not involve
>  get_user_pages().  I am seeing quite a lot with get_user_pages, but very
>  few of these:

get_user_pages() shold be fixed in rc1-mm1.  But that kernel is busted, so
wait until I have a fix.


>  Jul 14 02:40:56 mindpipe kernel: 
>  Jul 14 02:40:56 mindpipe kernel: ALSA /home/rlrevell/cvs/alsa-driver/alsa-kernel/core/pcm_lib.c:169: XRUN: pcmC0D0p
>  Jul 14 02:40:56 mindpipe kernel:  [dump_stack+23/32] dump_stack+0x17/0x20
>  Jul 14 02:40:56 mindpipe kernel:  [__crc_totalram_pages+168797/3558647] snd_pcm_period_elapsed+0x2c7/0x400 [snd_pcm]
>  Jul 14 02:40:56 mindpipe kernel:  [__crc_totalram_pages+344957/3558647] snd_emu10k1_interrupt+0x337/0x3c0 [snd_emu10k1]
>  Jul 14 02:40:56 mindpipe kernel:  [handle_IRQ_event+51/96] handle_IRQ_event+0x33/0x60
>  Jul 14 02:40:56 mindpipe kernel:  [do_IRQ+165/368] do_IRQ+0xa5/0x170
>  Jul 14 02:40:56 mindpipe kernel:  [common_interrupt+24/32] common_interrupt+0x18/0x20
>  Jul 14 02:40:56 mindpipe kernel:  [pty_write+301/320] pty_write+0x12d/0x140
>  Jul 14 02:40:56 mindpipe kernel:  [opost_block+231/416] opost_block+0xe7/0x1a0
>  Jul 14 02:40:56 mindpipe kernel:  [write_chan+382/528] write_chan+0x17e/0x210
>  Jul 14 02:40:56 mindpipe kernel:  [tty_write+247/448] tty_write+0xf7/0x1c0
>  Jul 14 02:40:56 mindpipe kernel:  [vfs_write+188/272] vfs_write+0xbc/0x110
>  Jul 14 02:40:56 mindpipe kernel:  [sys_write+46/80] sys_write+0x2e/0x50
>  Jul 14 02:40:56 mindpipe kernel:  [syscall_call+7/11] syscall_call+0x7/0xb

Try this:

--- 25/drivers/char/pty.c~pty_write-latency-fix	2004-07-13 23:54:55.891614544 -0700
+++ 25-akpm/drivers/char/pty.c	2004-07-13 23:55:35.539587136 -0700
@@ -126,7 +126,8 @@ static int pty_write(struct tty_struct *
 			n = to->ldisc.receive_room(to);
 			if (n > count)
 				n = count;
-			if (!n) break;
+			if (!n)
+				break;
 
 			n  = min(n, PTY_BUF_SIZE);
 			n -= copy_from_user(temp_buffer, buf, n);
@@ -140,11 +141,13 @@ static int pty_write(struct tty_struct *
 			room = to->ldisc.receive_room(to);
 			if (n > room)
 				n = room;
-			if (!n) break;
+			if (!n)
+				break;
 			buf   += n; 
 			c     += n;
 			count -= n;
 			to->ldisc.receive_buf(to, temp_buffer, NULL, n);
+			cond_resched();
 		}
 		up(&tty->flip.pty_sem);
 	} else {
_

