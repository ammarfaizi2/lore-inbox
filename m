Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129994AbQKNSEP>; Tue, 14 Nov 2000 13:04:15 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S130191AbQKNSEG>; Tue, 14 Nov 2000 13:04:06 -0500
Received: from penguin.e-mind.com ([195.223.140.120]:55876 "EHLO
	penguin.e-mind.com") by vger.kernel.org with ESMTP
	id <S129994AbQKNSD5>; Tue, 14 Nov 2000 13:03:57 -0500
Date: Tue, 14 Nov 2000 18:34:07 +0100
From: Andrea Arcangeli <andrea@suse.de>
To: Jesse Pollard <pollard@tomcat.admin.navo.hpc.mil>
Cc: Josue.Amaro@oracle.com, linux-kernel@vger.kernel.org
Subject: Re: Advanced Linux Kernel/Enterprise Linux Kernel
Message-ID: <20001114183407.A6576@athlon.random>
In-Reply-To: <200011141459.IAA413471@tomcat.admin.navo.hpc.mil>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200011141459.IAA413471@tomcat.admin.navo.hpc.mil>; from pollard@tomcat.admin.navo.hpc.mil on Tue, Nov 14, 2000 at 08:59:49AM -0600
X-GnuPG-Key-URL: http://e-mind.com/~andrea/aa.gnupg.asc
X-PGP-Key-URL: http://e-mind.com/~andrea/aa.asc
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Nov 14, 2000 at 08:59:49AM -0600, Jesse Pollard wrote:
>    I (meaning me) would like the ability to audit every system call. (yes,
>    this is horrendous, if everything is logged, but I want to be able to
>    choose how much is logged at the source of the data, rather than at
>    the destination. That would reduce the total data flood to what is
>    manageable or desired.

Yes, you really need to control the logging at the source of the data. To do
that we need to use to use self modifying tricks as dprobes and GKHI does to
provide "fast unregistered hooks".

o	with dprobes the hooks will be _absolutely_ zero cost if they're
	unregistered but they're very costly (basically enter/exit kernel
	for every hook) when they're registered (so they're ok if
	your auditing doesn't happen all the time).

	dprobe hooks also binds you to a certain binary image (not a generic
	interface stable across different kernel binaries)

o	GKHI provides fast unregistered hooks too, if implemented with
	5 nops as suggested they will cost around 3 cycles when they're
	unregistered, and they will provide good performance also when
	they're registered (no enter/exit kernel as dprobes needs
	to do) and you can control them via userspace without being dependent
	on binary offsets (just like with every other hook we have in kernel
	just now but with the difference that our current hooks aren't self
	modifying so they adds branches also when they're unregistered so
	they're bad for usages like syscall auditing). However bloating every
	syscall with tons of GKHI hooks isn't possible either or it will become
	a performance problem too eventually. It depends what you need exactly.
	I'd say one GKHI hook per syscall shouldn't have measurable impact on
	performance.

Andrea
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
