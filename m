Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261654AbTCYI72>; Tue, 25 Mar 2003 03:59:28 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261764AbTCYI72>; Tue, 25 Mar 2003 03:59:28 -0500
Received: from [131.215.233.56] ([131.215.233.56]:36616 "EHLO haxor-lan")
	by vger.kernel.org with ESMTP id <S261654AbTCYI70>;
	Tue, 25 Mar 2003 03:59:26 -0500
Date: Tue, 25 Mar 2003 00:57:59 -0800
From: Bryan Rittmeyer <bryanr@bryanr.org>
To: oprofile-list@lists.sourceforge.net
Cc: linux-kernel@vger.kernel.org, linuxppc-dev@lists.linuxppc.org
Subject: Re: [patch] oprofile + ppc750cx perfmon
Message-ID: <20030325085759.GB30294@bryanr.org>
References: <20030325050900.GA30294@bryanr.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20030325050900.GA30294@bryanr.org>
User-Agent: Mutt/1.3.28i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Mar 24, 2003 at 09:09:00PM -0800, Bryan Rittmeyer wrote:
> I'm going to try the hybrid approach and will post new patches soon.

done. patches are -v0002 at http://bryanr.org/linux/oprofile/

seems to be working pretty well, definitely _way_ more stable than
the patches that mix perfmon+decrementer... biggest kernel cycle
wasters during an imac ping -f run over ssh:

c0031344 20524    1.02949     kmalloc
c00d4ab4 22232    1.11516     netif_rx
c0074b98 24220    1.21488     n_tty_receive_buf
c00332e0 25583    1.28325     __free_pages_ok
c008ce68 28961    1.45269     gem_start_xmit
c00223a0 31661    1.58812     sys_rt_sigprocmask
c00eb92c 35584    1.7849      tcp_sendmsg
c003be24 38461    1.92921     fput
c004c55c 44923    2.25335     do_select
c0012804 47443    2.37975     memcpy
c0012980 50239    2.52        __copy_tofrom_user
c000452c 51645    2.59053     restore
c008c570 53061    2.66155     gem_rx
c004c7cc 56388    2.82844     sys_select
c008cae0 64265    3.22355     gem_interrupt
c0005b9c 148240   7.43576     idled
c000db34 242388   12.1583     openpic_read

wow. inside of open_pic.c, I bet it's code like this

        while (openpic_read(addr) & OPENPIC_ACTIVITY);

that's showing up.

anyway, a short-term PPC oprofile TODO:

- further stress/stability testing (overnight etc)
- re-allow power_save_6xx() when not profiling
- actually use config options instead of hardcoding perfmon rate
- userspace profiling system call hooks
- fix op_start race between perfmon and decrementer (?)
- code to call timer_interrupt() at approximately HZ
independent of profile counter rate (or is it 2*HZ, heh)
- add support for other perfmon features (possible given that we have
to call timer_interrupt and thus need something periodic?)

If you play with this, please let me know how it goes. Ignoring the
rough edges it should be basically useable for kernel/module profiling,
even on code with irqs disabled.

-Bryan
