Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267424AbTBGDul>; Thu, 6 Feb 2003 22:50:41 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267426AbTBGDul>; Thu, 6 Feb 2003 22:50:41 -0500
Received: from smtp2.clear.net.nz ([203.97.37.27]:4246 "EHLO
	smtp2.clear.net.nz") by vger.kernel.org with ESMTP
	id <S267424AbTBGDuk>; Thu, 6 Feb 2003 22:50:40 -0500
Date: Fri, 07 Feb 2003 16:57:22 +1300
From: Nigel Cunningham <ncunningham@clear.net.nz>
Subject: Re: [ACPI] Re: [PATCH] s4bios for 2.5.59 + apci-20030123
In-reply-to: <20030206210542.GW1205@poup.poupinou.org>
To: Ducrot Bruno <ducrot@poupinou.org>
Cc: Pavel Machek <pavel@ucw.cz>, "Grover, Andrew" <andrew.grover@intel.com>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       ACPI List <acpi-devel@lists.sourceforge.net>,
       Swsusp <swsusp@lister.fornax.hu>
Message-id: <1044590241.1649.41.camel@laptop-linux.cunninghams>
Organization: 
MIME-version: 1.0
X-Mailer: Ximian Evolution 1.2.1
Content-type: text/plain
Content-transfer-encoding: 7bit
References: <F760B14C9561B941B89469F59BA3A847137FFE@orsmsx401.jf.intel.com>
 <20030204221003.GA250@elf.ucw.cz>
 <1044477704.1648.19.camel@laptop-linux.cunninghams>
 <20030206101645.GO1205@poup.poupinou.org>
 <1044560486.1700.13.camel@laptop-linux.cunninghams>
 <20030206210542.GW1205@poup.poupinou.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 2003-02-07 at 10:05, Ducrot Bruno wrote:
> On Fri, Feb 07, 2003 at 08:41:27AM +1300, Nigel Cunningham wrote:
> > Sorry. Perhaps I should have been clearer. I haven't spent a lot of time
> > doing timings, but there doesn't seem to be any significant difference.
> > In both versions, the amount of time varies with the amount of memory in
> 
> Ah ok.  I understand now.  S4bios is completely different from swsusp.
> It's just as if we were comparing APM suspend-to-disk and swsusp (and no, S4bios
> is *not* APM suspend-to-disk either).

FWIW, here are the results of some tests, timing
2.4.21-pre3+acpi20030125+swsusp-beta18:

Machine 1: Celeron 933 laptop 17MB/s disk throughput, 128MB RAM
Machine 2: Duron 700 desktop, 30MB/s disk throughput, 320MB RAM

Algorithm 1: Eat as much memory as possible, save remaining in one set
of pages
Algorithm 2: Save memory in two pages, only eating memory if necessary.

Same code base, just different parameters to /proc/sys/kernel/swsusp.
This means that the result for algorithm 1 are exactly the same as
Pavel's code, but should give some idea.

Columns:
(1) Machine
(2) Algorithm
(3) Initial # pages free
(4) Image size written to disk
(5) Approximate time taken (date command run on other computer at same
time as pressing enter to start command, then when computer restarts)

1  2  3           4     5
---------------------------------
1  1  25655/30592  1562 0:07
1  2  26246/30592  4302 0:05
1  1   1005/30592  5165 0:20
1  2    900/30592 30126 0:16
2  1  38604/79755     ? 0:49
2  2  39122/79755 30398 0:21
2  1   1113/79755     ? 0:50
2  2   1109/79755 82149 0:40

The question marks are because the desktop machine didn't successfully
resume using this algorithm, so stats weren't logged (probably driver
problems).

In each case, the new method is slightly faster than the old, so we don't seem to loose anything.
Particularly interesting to me was the fact that the gain was not as
high as we might expect when the memory was heavily used. I guess the
amount of I/O is getting to the point where benefits from not eating
pages are being erroded. It would be interesting to see if a machine
with more memory readed a point where it was faster to eat the memory
instead of write it.

Hope this is helpful.

Nigel

