Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751859AbWHAUun@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751859AbWHAUun (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 1 Aug 2006 16:50:43 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751860AbWHAUum
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 1 Aug 2006 16:50:42 -0400
Received: from static-ip-62-75-166-246.inaddr.intergenia.de ([62.75.166.246]:44933
	"EHLO bu3sch.de") by vger.kernel.org with ESMTP id S1751859AbWHAUum
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 1 Aug 2006 16:50:42 -0400
From: Michael Buesch <mb@bu3sch.de>
To: moreau francis <francis_moreau2000@yahoo.fr>
Subject: Re: [HW_RNG] How to use generic rng in kernel space
Date: Tue, 1 Aug 2006 22:49:20 +0200
User-Agent: KMail/1.9.1
References: <20060801120937.69641.qmail@web25813.mail.ukl.yahoo.com>
In-Reply-To: <20060801120937.69641.qmail@web25813.mail.ukl.yahoo.com>
Cc: linux-kernel@vger.kernel.org
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200608012249.20324.mb@bu3sch.de>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tuesday 01 August 2006 14:09, moreau francis wrote:
> Hi
> 
> I developped a HW RNG for a custom board and several
> other drivers are using it through a special entry I made.
> I was planning to move the code in order to use the generic
> the RNG layer but I encounter an issue.
>
> Currently it seems not possible for a driver to use HW RNG,
> because there's no entry point for that. Is that something
> deliberate ?
> 
Never ever do that. Never use the data from a hardware RNG
directly. There is intentionally no interface to do so.
If you need random data in some driver, use the functions
in random.h to get random data.

The dataflow is as follows:

HW-RNG -> userspace RNGD (through /dev/hwrng) -> the daemon
checks it for sanity and puts it back into the kernel through
/dev/random -> Your driver gets the data from the /dev/random
entropy pools.

This is very neccesary, because your HW-RNG may fail and
so you may unintentionally use non-random data, if you use
the random data from the RNG directly.
The data _must_ go through userspace rngd, which does FIPS
sanity checks on the data.

> Another question about the implementation. If O_NONBLOCK
> flag is passed when opening /dev/hw_random, how does the
> read method ensure that the caller won't sleep since it calls
> mutex_lock_interruptible() function unconditiannaly ? I must
> miss something but don't know what...

I second Alan's answer here. ;)

-- 
Greetings Michael.
