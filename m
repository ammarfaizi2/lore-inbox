Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266095AbTIKAHb (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 10 Sep 2003 20:07:31 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266098AbTIKAHb
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 10 Sep 2003 20:07:31 -0400
Received: from caramon.arm.linux.org.uk ([212.18.232.186]:17928 "EHLO
	caramon.arm.linux.org.uk") by vger.kernel.org with ESMTP
	id S266095AbTIKAHN (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 10 Sep 2003 20:07:13 -0400
Date: Thu, 11 Sep 2003 01:07:02 +0100
From: Russell King <rmk@arm.linux.org.uk>
To: Jamie Lokier <jamie@shareable.org>
Cc: linux-kernel@vger.kernel.org
Subject: Re: Virtual alias cache coherency results (was: x86, ARM, PARISC, PPC, MIPS and Sparc folks please run this)
Message-ID: <20030911010702.W30046@flint.arm.linux.org.uk>
Mail-Followup-To: Jamie Lokier <jamie@shareable.org>,
	linux-kernel@vger.kernel.org
References: <20030910210416.GA24258@mail.jlokier.co.uk> <20030910233951.Q30046@flint.arm.linux.org.uk> <20030910233720.GA25756@mail.jlokier.co.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
In-Reply-To: <20030910233720.GA25756@mail.jlokier.co.uk>; from jamie@shareable.org on Thu, Sep 11, 2003 at 12:37:20AM +0100
X-Message-Flag: Your copy of Microsoft Outlook is vulnerable to viruses. See www.mutt.org for more details.
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Sep 11, 2003 at 12:37:20AM +0100, Jamie Lokier wrote:
> > The kernel works around this, but, due to some bugs on StrongARM chips
> > in the write buffer, it appears that we need further work-arounds, which
> > are already implemented.
> 
> There is one thing which puzzles me.  The ARM test program outputs
> I've been sent say that the cache is incoherent, _not_ just the write
> buffers.  You said you have results which report write buffers, but I
> don't have those in detail, only descriptions.

Well, this machine which my test passes (this is run on a kernel with
the work-around in, but since it detected the write buffer works, does
not activate it.)

Processor       : StrongARM-110 rev 2 (v4l)

never reports problems with the write buffer, and produces a consistent
set of results:

(128) [93,20,4] Test separation: 4096 bytes: FAIL - too slow
(128) [94,20,4] Test separation: 8192 bytes: FAIL - too slow
(128) [93,20,4] Test separation: 16384 bytes: FAIL - too slow
(128) [93,20,4] Test separation: 32768 bytes: FAIL - too slow
(128) [93,20,4] Test separation: 65536 bytes: FAIL - too slow
(128) [93,20,4] Test separation: 131072 bytes: FAIL - too slow
(128) [93,20,4] Test separation: 262144 bytes: FAIL - too slow
(128) [93,20,4] Test separation: 524288 bytes: FAIL - too slow
(128) [93,20,4] Test separation: 1048576 bytes: FAIL - too slow
(128) [93,20,4] Test separation: 2097152 bytes: FAIL - too slow
(128) [93,20,4] Test separation: 4194304 bytes: FAIL - too slow
(128) [93,20,4] Test separation: 8388608 bytes: FAIL - too slow
(128) [93,20,4] Test separation: 16777216 bytes: FAIL - too slow
VM page alias coherency test: failed; will use copy buffers instead

And then there's ARM920T, and this is run on a kernel without
the work-around:

# cat /proc/cpuinfo 
Processor       : Arm920Tid(wb) rev 0 (v4l)
BogoMIPS        : 29.90
Features        : swp half thumb 
CPU implementer : 0x41
CPU architecture: 4T
CPU variant     : 0x1
CPU part        : 0x920
CPU revision    : 0
Cache type      : write-back
Cache clean     : cp15 c7 ops
Cache lockdown  : format A
Cache format    : Harvard
I size          : 16384
I assoc         : 64
I line length   : 32
I sets          : 8
D size          : 16384
D assoc         : 64
D line length   : 32
D sets          : 8

Hardware        : ARM-Integrator
Revision        : 0000
Serial          : 0000000000000000
# /mnt/src/tests/general/pagealias-v3                                          
(64) [83,29,7] Test separation: 4096 bytes: FAIL - too slow
(64) [83,29,7] Test separation: 8192 bytes: FAIL - too slow
(64) [84,29,7] Test separation: 16384 bytes: FAIL - too slow
(64) [84,29,7] Test separation: 32768 bytes: FAIL - too slow
(64) [84,29,7] Test separation: 65536 bytes: FAIL - too slow
(64) [84,29,7] Test separation: 131072 bytes: FAIL - too slow
(64) [83,29,7] Test separation: 262144 bytes: FAIL - too slow
(64) [83,29,7] Test separation: 524288 bytes: FAIL - too slow
(64) [84,29,7] Test separation: 1048576 bytes: FAIL - too slow
(64) [84,29,7] Test separation: 2097152 bytes: FAIL - too slow
(64) [83,29,7] Test separation: 4194304 bytes: FAIL - too slow
(64) [83,29,7] Test separation: 8388608 bytes: FAIL - too slow
(64) [84,29,7] Test separation: 16777216 bytes: FAIL - too slow
VM page alias coherency test: failed; will use copy buffers instead

> Does your fix, which makes pages uncacheable andq disables write
> combining (correct?) only fix your test results which intermittently
> reported write buffer problems, or does it fix _all_ the ARM test
> results I received, including those which don't report write buffer
> problems?

It's relatively simple, and I'm not sure why its causing such
misunderstanding.  Let me try one more time:

ARM caches are VIVT.  VIVT caches have inherent aliasing issues.  The
kernel works around these issues by marking memory uncacheable where
appropriate, and will continue to do so for VIVT cached ARM CPUs.

Separate issue: Some StrongARM-110 devices contain buggy write buffers.
For these devices, we need to do a little bit extra than we currently
do to ensure that they are coherent, by disabling the write buffer as
well as the cache for these regions.  Current kernels do not work
around this issue.

-- 
Russell King (rmk@arm.linux.org.uk)	http://www.arm.linux.org.uk/personal/
Linux kernel maintainer of:
  2.6 ARM Linux   - http://www.arm.linux.org.uk/
  2.6 PCMCIA      - http://pcmcia.arm.linux.org.uk/
  2.6 Serial core
