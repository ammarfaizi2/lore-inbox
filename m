Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932308AbWCEAQ5@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932308AbWCEAQ5 (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 4 Mar 2006 19:16:57 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932309AbWCEAQ5
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 4 Mar 2006 19:16:57 -0500
Received: from smtp.osdl.org ([65.172.181.4]:224 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S932308AbWCEAQ4 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 4 Mar 2006 19:16:56 -0500
Date: Sat, 4 Mar 2006 16:15:19 -0800
From: Andrew Morton <akpm@osdl.org>
To: J M Cerqueira Esteves <jmce@artenumerica.com>
Cc: linux-kernel@vger.kernel.org, support@artenumerica.com, ngalamba@fc.ul.pt,
       Jens Axboe <axboe@suse.de>
Subject: Re: oom-killer: gfp_mask=0xd1 with 2.6.15.4 on EM64T [previously
 2.6.12]
Message-Id: <20060304161519.6e6fbe2c.akpm@osdl.org>
In-Reply-To: <4409B8DC.9040404@artenumerica.com>
References: <4405D383.5070201@artenumerica.com>
	<20060302011735.55851ca2.akpm@osdl.org>
	<440865A9.4000102@artenumerica.com>
	<4409B8DC.9040404@artenumerica.com>
X-Mailer: Sylpheed version 1.0.4 (GTK+ 1.2.10; i386-redhat-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

J M Cerqueira Esteves <jmce@artenumerica.com> wrote:
>
> Still on the same dual EM64T machine with a Tyan Tiger i7525 (S2672)
>  motherboard and 4 GB RAM for which I reported 2.6.12 oom killings a few
>  days ago:
> 
>  I upgraded to Ubuntu Dapper and installed its latest 2.6.15 kernel,
>  which incorporates 2.6.15.4.  Started with the original "binary"
>  linux-image-2.6.15-16-amd64-xeon package,
>  and got a few oom killings even without running the same large test
>  programs as before.  Then recompiled the kernel with
>  CONFIG_PREEMPT_NONE, CONFIG_SCHED_SMT, no CONFIG_PREEMPT_BKL,
>  and the dump_stack() call suggested by Andrew Morton for
>  mm/oom_kill.c [in out_of_memory()].
> 
>  Repeated tests with Gaussian... and got oom-killer events similar to
>  those found with 2.6.12.   At
>  http://jmce.artenumerica.org/en/tmp/linux-2.6.15-oom_killings/kern.log
>  are the kernel messages from the killing of two Gaussian runs;
>  I just show below the beginning, until the first killing.
> 
>  Any suggestions on patches or some pre-2.6.16 version I should try?
> 
> 
>  Call Trace:<ffffffff8015efcb>{out_of_memory+23}
>  <ffffffff80130465>{__wake_up+56}
>         <ffffffff80161177>{__alloc_pages+572}
>  <ffffffff8017fc25>{bio_copy_user+219}
>         <ffffffff801debbf>{blk_rq_map_user+133} <ffffffff801e1b61>{sg_io+351}
>         <ffffffff801e1ff8>{scsi_cmd_ioctl+494}
>  <ffffffff80130465>{__wake_up+56}
>         <ffffffff80265aac>{sock_def_readable+52}
>  <ffffffff802c5d68>{unix_dgram_sendmsg+1085}
>         <ffffffff88077e35>{:sd_mod:sd_ioctl+371}
>  <ffffffff801e0058>{blkdev_driver_ioctl+93}
>         <ffffffff801e0726>{blkdev_ioctl+1613}
>  <ffffffff8018ce76>{do_select+1137}
>         <ffffffff8026321e>{sys_sendto+251} <ffffffff8018c941>{__pollwait+0}
>         <ffffffff801813d2>{block_ioctl+27} <ffffffff8018c091>{do_ioctl+33}
>         <ffffffff8018c36c>{vfs_ioctl+643} <ffffffff8018c3e0>{sys_ioctl+91}
>         <ffffffff8010fa46>{system_call+126}
>  oom-killer: gfp_mask=0xd1, order=0

Yup, that looks like the same bug.

We have a candidate fix at
ftp://ftp.kernel.org/pub/linux/kernel/people/akpm/patches/2.6/2.6.16-rc5/2.6.16-rc5-mm2/broken-out/x86_64-mm-blk-bounce.patch.
 Could you test that?  (and don't alter the Cc: list!).  The patch is
against 2.6.16-rc5.

Thanks.
