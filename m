Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265452AbTIFBHm (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 5 Sep 2003 21:07:42 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265455AbTIFBHm
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 5 Sep 2003 21:07:42 -0400
Received: from mail.netbeat.de ([62.208.140.19]:57609 "HELO mail.netbeat.de")
	by vger.kernel.org with SMTP id S265452AbTIFBHj (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 5 Sep 2003 21:07:39 -0400
Subject: Re: 2.6.0-test4-mm6
From: Jan Ischebeck <mail@jan-ischebeck.de>
To: lkml <linux-kernel@vger.kernel.org>
In-Reply-To: <20030905145124.GF454@parcelfarce.linux.theplanet.co.uk>
References: <1062766000.2081.11.camel@JHome.uni-bonn.de>
	 <20030905145124.GF454@parcelfarce.linux.theplanet.co.uk>
Content-Type: text/plain
Message-Id: <1062810478.2101.27.camel@JHome.uni-bonn.de>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.4 
Date: Sat, 06 Sep 2003 03:07:58 +0200
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Am Fr, 2003-09-05 um 16.51 schrieb
viro@parcelfarce.linux.theplanet.co.uk:
> On Fri, Sep 05, 2003 at 02:46:40PM +0200, Jan Ischebeck wrote:
> > Seems like I got the reason for X not starting:
> > 
> > pseudo terminals can't be acquired and only two consoles are
running.
> > 
> > -> X11 can't get console Vt7
> > -> pppd doesn't work either
> > 
> > This definitely worked with -mm5.
> 
> Grr...  Dumb typo.  Patch below should fix that...
> 
> diff -urN B4-misc3/drivers/char/tty_io.c
B4-current/drivers/char/tty_io.c
> --- B4-misc3/drivers/char/tty_io.c    Thu Sep  4 02:19:38 2003
> +++ B4-current/drivers/char/tty_io.c  Fri Sep  5 10:46:59 2003
> @@ -1334,7 +1334,7 @@
>               return -ENODEV;
>       }
>  
> -     if (device == MKDEV(TTY_MAJOR,2)) {
> +     if (device == MKDEV(TTYAUX_MAJOR,2)) {
>  #ifdef CONFIG_UNIX98_PTYS
>               /* find a device that is not in use. */
>               retval = -1;

Thank you, that solved the problem with X.

But PPP is still broken, I get the following errors when I've tried to
setup a connection. And after trying to use ppp the machine oops at
shutdown.

(that appears in syslog)
pppd[2007]: Serial connection established.
pppd[2007]: Couldn't get channel number: Input/output error


(oops on shutdown)
 kernel: Badness in local_bh_enable at kernel/softirq.c:119
 kernel: Call Trace:
 kernel: [<c0128065>] local_bh_enable+0x85/0x87
 kernel: [<e0a33b42>] ppp_async_push+0x9e/0x180 [ppp_async]
 kernel: [<e0a3344e>] ppp_asynctty_wakeup+0x2d/0x5e [ppp_async]
 kernel: [<c020092f>] pty_unthrottle+0x58/0x5a
 kernel: [<c01fd40d>] check_unthrottle+0x39/0x3b
 kernel: [<c01fd4af>] n_tty_flush_buffer+0x13/0x55
 kernel: [<c0200cea>] pty_flush_buffer+0x66/0x68
 kernel: [<c01f9d24>] do_tty_hangup+0x489/0x4ef
 kernel: [<c01fb33a>] release_dev+0x6f4/0x721
 kernel: [<c014a605>] unmap_page_range+0x43/0x69
 kernel: [<c01fb6e9>] tty_release+0x2d/0x66
 kernel: [<c0159aef>] __fput+0x102/0x114
 kernel: [<c015826b>] filp_close+0x59/0x86
 kernel: [<c0125ada>] put_files_struct+0x84/0xe9
 kernel: [<c01266f4>] do_exit+0x15d/0x3f8
 kernel: [<c0126a16>] do_group_exit+0x3a/0xac
 kernel: [<c02ddc7b>] syscall_call+0x7/0xb
 kernel: 


Thanks for the great work!

-- 
Jan Ischebeck <mail@jan-ischebeck.de>



