Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265611AbTFXB3X (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 23 Jun 2003 21:29:23 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265612AbTFXB3X
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 23 Jun 2003 21:29:23 -0400
Received: from twinlark.arctic.org ([168.75.98.6]:43664 "EHLO
	twinlark.arctic.org") by vger.kernel.org with ESMTP id S265611AbTFXB3V
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 23 Jun 2003 21:29:21 -0400
Date: Mon, 23 Jun 2003 18:43:28 -0700 (PDT)
From: dean gaudet <dean-list-linux-kernel@arctic.org>
To: Samphan Raruenrom <samphan@thai.com>
cc: Vojtech Pavlik <vojtech@suse.cz>, linux-kernel@vger.kernel.org
Subject: Re: Crusoe's performance on linux?
In-Reply-To: <3EF74DBF.6000703@thai.com>
Message-ID: <Pine.LNX.4.53.0306231821480.17484@twinlark.arctic.org>
References: <3EF1E6CD.4040800@thai.com> <20030619200308.A2135@ucw.cz>
 <3EF2144D.5060902@thai.com> <20030619221126.B3287@ucw.cz> <3EF67AD4.4040601@thai.com>
 <20030623102623.A18000@ucw.cz> <3EF74DBF.6000703@thai.com>
X-comment: visit http://arctic.org/~dean/legal for information regarding copyright and disclaimer.
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 23 Jun 2003, Samphan Raruenrom wrote:

> Desktop - Pentium III 1 G Hz 754 MB	->	10.x min.
> Tablet PC - Crusoe TM5800 1 GHz 731 MB	->	17.x min.

how much real memory are in these boxes?  the above don't look like any
real memory sizes i'm aware of (even if i try to guess if your M=10^6
or M=2^20).


>  From freshdiagnos benchmack, the TPC has about 2x faster RAM.

you're mistaken if you believe marketing doodoo which says that DDR is
"twice as fast" as SDR -- only data transfer is clocked at twice the
bus speed.  there's command bus costs which are identical between SDR
and DDR -- and its these costs which dominate the bus in non-sequential
benchmarks such as compilation (as opposed to excessively sequential
benchmarks which are used for marketing purposes).

expansion memory for the tablet PC is PC133 -- you can verify this
by reading the part numbers off the SODIMM and doing a lookup on the
manufacturer's website...

if you don't have any expansion memory in your tablet PC then you've
got only 256MB of RAM and i really don't think you should be using tmpfs.


> Shouldn't TM5800 with 4-wide VLIW engine and 64 registers,
> working on a single task, run as fast as a Pentium III?

nope.

you're assuming that the VLIW has 4 completely orthogonal processing
units -- it doesn't.  try measuring code sequences such as:

	add %eax,%ebx
	add %eax,%ecx
	add %eax,%edx
	add %eax,%edi
	add %eax,%ebx
	add %eax,%ecx
	add %eax,%edx
	add %eax,%edi
	...

you'll quickly figure out how many ALUs the machine has, plus you can
figure out their latencies and throughputs (by increasing or decreasing
the number of independent additions).  if you do this you'll find
that p3 and tm5800 are essentially just as "wide" as each other for
ALU operations:  a pair of 32-bit ALUs with single-cycle latency and
single-cycle throughput.

similar microarchitctural analysis of other aspects of the cores can
help explain the differences you see.

traditionally VLIW have been used for DSP and other such related tasks
in which there are a large number of orthogonal units.  in tm5800 you
can think of the VLIW as a set of up to 4 micro-ops which feed the front
of up to 4 pipelines in each cycle -- much like the decoded micro-ops
in the p3 feed one of several pipelines in each cycle.

but i'm really guessing you're causing excessive disk i/o by having a
small memory system use a huge tmpfs... get rid of the tmpfs and
see what happens.  and also consider doing i/o benchmarks while
running something which soaks up idle cycles (i.e. a tight loop
incrementing a counter) to see how the two architectures differ.

-dean
