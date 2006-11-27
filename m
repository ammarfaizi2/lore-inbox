Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1758246AbWK0Ofl@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758246AbWK0Ofl (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 27 Nov 2006 09:35:41 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1758247AbWK0Ofl
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 27 Nov 2006 09:35:41 -0500
Received: from mx1.redhat.com ([66.187.233.31]:7393 "EHLO mx1.redhat.com")
	by vger.kernel.org with ESMTP id S1758246AbWK0Ofk (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 27 Nov 2006 09:35:40 -0500
Message-ID: <456AF7A8.8020901@redhat.com>
Date: Mon, 27 Nov 2006 15:35:20 +0100
From: Milan Broz <mbroz@redhat.com>
User-Agent: Thunderbird 1.5.0.8 (X11/20061107)
MIME-Version: 1.0
To: Matthias Lederhofer <matled@gmx.net>
CC: Linux Kernel <linux-kernel@vger.kernel.org>, dm-crypt@saout.de
Subject: Re: freeze with swap on dm-crypt on smp system (v2.6.18-g23541d2)
References: <20061127000234.GA2084@moooo.ath.cx>
In-Reply-To: <20061127000234.GA2084@moooo.ath.cx>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Matthias Lederhofer wrote:
> I think I found a bug introduced in v2.6.18-g23541d2 (git-bisect).
> The computer has a dual core amd64 with 1GB ram and 3GB swap space,
> 64 bit kernel and 32 bit userland.

[23541d2] dm crypt: move io to workqueue

So this patch is the source of problems ?

> What I did:
>  - run the mprime 'torture test' with the memory option set to 1500MB
>     (ftp://mersenne.org/gimps/mprime235.tar.gz, I ran
>      echo -e '15\n\n1500\n1500\n\n\n\n17\n\n6\n' | ./mprime)
>  - mount a tmpfs with 2GB and write to it (stops at 1.0-1.1GB)
> What happened:
> With mprime normal keyboard input was ignored totally.  The machine
> still responds to ping/sysrq but killing all processes with sysrq does
> not help.  Sometimes with tmpfs I was able to type, but ^C did not
> work and I was not able to do anything (e.g. get a new shell, start a
> program etc.).
> 
> The swap space has to be on a dm-crypt and smp has to be enabled,
> without this the bug did not occur.  Just ask if you need any other
> information about the system, output from sysrq debug commands or
> anything else.

Please, if you can send task list when system stops responding (sysrq + t)
and output of
	dmsetup table
	dmsetup info -c

Are there any messages in syslog related to this hang ?

> 
> I found that enabling this options from 'Kernel hacking' helps, even
> though it once froze when I tried to quit mprime.
>> CONFIG_DEBUG_KERNEL=y
>> CONFIG_DEBUG_PREEMPT=y
>> CONFIG_DEBUG_SPINLOCK=y
>> CONFIG_DEBUG_MUTEXES=y
>> CONFIG_DEBUG_RWSEMS=y
>> CONFIG_DEBUG_LOCK_ALLOC=y
>> CONFIG_PROVE_LOCKING=y
>> CONFIG_LOCKDEP=y
>> CONFIG_DEBUG_LOCKDEP=y
>> CONFIG_TRACE_IRQFLAGS=y
>> CONFIG_STACKTRACE=y
>> CONFIG_DEBUG_VM=y
> While running mprime with this options I got this warning:
>> warning: many lost ticks.
>> Your time source seems to be instable or some driver is hogging interupts
>> rip xor_128+0x2/0x20

Not sure if this can be related... did you try compile it without config_preempt ?
(and dynamic overclocking in BIOS is disabled ?)

Milan

> 
> kernel boot output:
> Linux version 2.6.18-g23541d2d (matled@foo) (gcc version 4.1.2 20061028 (prerelease) (Debian 4.1.1-19)) #1 SMP PREEMPT Sun Nov 26 21:20:27 CET 2006
> Command line: root=/dev/md10 ro panic=20 console=tty0 console=ttyS0,115200
> BIOS-provided physical RAM map:
...
