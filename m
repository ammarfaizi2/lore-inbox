Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262279AbSJAXnS>; Tue, 1 Oct 2002 19:43:18 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262853AbSJAXnS>; Tue, 1 Oct 2002 19:43:18 -0400
Received: from jdike.solana.com ([198.99.130.100]:58752 "EHLO karaya.com")
	by vger.kernel.org with ESMTP id <S262279AbSJAXnR>;
	Tue, 1 Oct 2002 19:43:17 -0400
Message-Id: <200210012351.g91NpS902023@karaya.com>
X-Mailer: exmh version 2.2 06/23/2000 with nmh-1.0.4
To: linux-kernel@vger.kernel.org
cc: wstearns@pobox.com
Subject: Process hangs in 2.4.19, RH7.latest, and 2.4.20-pre7-ac2
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Date: Tue, 01 Oct 2002 19:51:28 -0400
From: Jeff Dike <jdike@karaya.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I (and other people) have seen process hangs on stock 2.4.19, 2.4.20-pre7-ac2,
and (iirc) the latest RH 7.x kernel.  Any process that does the moral
equivalent of ps hangs.  The machine quickly becomes unusable, and needs to
be crashed.

It's been seen most often under heavy UML load.  I've seen it most often
doing UML development inside UML (stock 2.4.19).  It's been seen on
2.4.20-pre7-ac2 on a UML server.  However, I have had it happen with no
UMLs in sight.

We finally got sysrq information on this.  The hung processes all look like
this:
	Proc;  ps
	>>EIP; e352bef4 <_end+2307b320/386c042c>   <=====
	Trace; c032a955 <rwsem_down_read_failed+195/1c0>
	Trace; c016e3c0 <.text.lock.array+73/123>
	Trace; c016b340 <proc_info_read+50/110>
	Trace; c0148736 <sys_read+96/190>
	Trace; c0147fb3 <sys_open+53/b0>
	Trace; c01092cb <system_call+33/38>

The lock in question is the mmap_sem being acquired in proc_pid_stat.  There
should be a sleeping process which is holding the semaphore, but I haven't 
spotted it among the multitudes that were running at the time.

The full ksymoops-ed sysrq-t output is available at 
	http://www.stearns.org/slartibartfast/sym_stacks

I'm not including it here because it's too large.

There should be one process which started this by grabbing a mm_sem and 
sleeping forever and I would think its stack would be different from all
the others.  There are a few processes whose deepest IP are unique:

Proc;  grep
>>EIP; 00000002 Before first symbol   <=====
Trace; c0118120 <do_page_fault+0/438>

Proc;  killall
>>EIP; ea4b5ee4 <_end+2a005310/386c042c>   <=====
Trace; c0130b72 <__vma_link+62/c0>
Trace; c032a955 <rwsem_down_read_failed+195/1c0>
Trace; c016e3c0 <.text.lock.array+73/123>
Trace; c016b340 <proc_info_read+50/110>

Proc;  init
>>EIP; 00000000 Before first symbol
Trace; c013f5e3 <__get_free_pages+13/30>

None of these look like to culprits.  init is probably innocent, the grep
was processing the output of a hung ps, so it was too late, and the killall
is itself hung.

I'd appreciate any clues about what's going on here.  If anyone needs more
info than what's in the sysrq output at the URL above, contact me or Bill
Stearns (wstearns at pobox dot com).

				Jeff

