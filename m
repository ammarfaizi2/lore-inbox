Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S289114AbSA2J3v>; Tue, 29 Jan 2002 04:29:51 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S289226AbSA2J3k>; Tue, 29 Jan 2002 04:29:40 -0500
Received: from parcelfarce.linux.theplanet.co.uk ([195.92.249.252]:12551 "EHLO
	www.linux.org.uk") by vger.kernel.org with ESMTP id <S289114AbSA2J3e>;
	Tue, 29 Jan 2002 04:29:34 -0500
Message-ID: <3C5669D6.B81E0B4@zip.com.au>
Date: Tue, 29 Jan 2002 01:22:30 -0800
From: Andrew Morton <akpm@zip.com.au>
X-Mailer: Mozilla 4.77 [en] (X11; U; Linux 2.4.18-pre7 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: Rusty Russell <rusty@rustcorp.com.au>
CC: linux-kernel@vger.kernel.org, torvalds@transmeta.com
Subject: Re: [PATCH] per-cpu areas for 2.5.3-pre6
In-Reply-To: <E16VU8j-0006Hm-00@wagner.rustcorp.com.au>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Rusty Russell wrote:
> 
> This patch introduces the __per_cpu_data tag for data, and the
> per_cpu() & this_cpu() macros to go with it.
> 
> This allows us to get rid of all those special case structures
> springing up all over the place for CPU-local data.

Am I missing something? smp_init() is called quite late in
the boot process, and if any code touches per-cpu data before
this, it'll get a null pointer deref, won't it?

You could possibly do:

unsigned long __per_cpu_offset[NR_CPUS] = { (unsigned long *)&__per_cpu_start, };

which takes care of the boot processor.  You lose the ability
to put statically initialised data into the per-cpu area, but
that's not too bad.

Also the boot processor won't be able to initialise stuff which
belongs to other CPUs.

Or the whole thing needs to be moved super-early into the boot
process.

Or I missed something :)

-
