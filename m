Return-Path: <linux-kernel-owner+willy=40w.ods.org-S267695AbUH1Tsx@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S267695AbUH1Tsx (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 28 Aug 2004 15:48:53 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267709AbUH1Tso
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 28 Aug 2004 15:48:44 -0400
Received: from mail6.bluewin.ch ([195.186.4.229]:32209 "EHLO mail6.bluewin.ch")
	by vger.kernel.org with ESMTP id S267695AbUH1Tqp (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 28 Aug 2004 15:46:45 -0400
Date: Sat, 28 Aug 2004 21:45:46 +0200
From: Roger Luethi <rl@hellgate.ch>
To: William Lee Irwin III <wli@holomorphy.com>, linux-kernel@vger.kernel.org,
       Albert Cahalan <albert@users.sf.net>, Paul Jackson <pj@sgi.com>
Subject: [BENCHMARK] nproc: netlink access to /proc information
Message-ID: <20040828194546.GA25523@k3.hellgate.ch>
Mail-Followup-To: William Lee Irwin III <wli@holomorphy.com>,
	linux-kernel@vger.kernel.org, Albert Cahalan <albert@users.sf.net>,
	Paul Jackson <pj@sgi.com>
References: <20040827122412.GA20052@k3.hellgate.ch> <20040827162308.GP2793@holomorphy.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20040827162308.GP2793@holomorphy.com>
X-Operating-System: Linux 2.6.8 on i686
X-GPG-Fingerprint: 92 F4 DC 20 57 46 7B 95  24 4E 9E E7 5A 54 DC 1B
X-GPG: 1024/80E744BD wwwkeys.ch.pgp.net
User-Agent: Mutt/1.5.6i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 27 Aug 2004 09:23:08 -0700, William Lee Irwin III wrote:
> than speed benefits. How many processes did you microbenchmark with?

Executive summary: I wrote a benchmark to compare /proc and nproc
performance. The results are as expected: Parsing even the most simple
strings is expensive. /proc performance does not scale if we have to
open and close many files, which is the common case.

In a situation with many processes p and fields/files f the delivery
overhead is roughly O(p) for nproc and O(p*f) for /proc.

The difference becomes even more pronounced if a /proc file request
triggers an expensive in-kernel computation for fields that are not
of interest but part of the file, or if human-readable files need to
be parsed.


Benchmark: I chose the most favorable scenario for /proc I could think
of: Reading a single, easy to parse file per process and find every data
item useful.  I picked /proc/pid/statm. For nproc, I chose seven fields
that are calculated with the same resource usage as the fields in statm:
NPROC_VMSIZE, NPROC_VMLOCK, NPROC_VMRSS, NPROC_VMDATA, NPROC_VMSTACK,
NPROC_VMEXE, and NPROC_VMLIB.


Numbers:
* The first run is basically lseek+read:
/proc/pid/statm for 1000 processes, 1000 times, lseek
CPU time : 7.080000s
Wall time: 7.636732s

* The second run adds a simple sscanf call to dump seven values
  into seven variables:
/prod/pid/statm for 1000 processes, 1000 times, lseek (scanf)
CPU time : 10.230000s
Wall time: 10.958432s

* If we watch p processes with f files each, we typically hit the
  file descriptor limit before p * f == 1024. From then on, lseek is
  useless, we have to resort to opening and closing files:
/prod/pid/statm for 1000 processes, 1000 times, open
CPU time : 14.920000s
Wall time: 16.087339s

* Again, parsing the string comes at a cost:
/prod/pid/statm for 1000 processes, 1000 times, open (scanf)
CPU time : 18.110000s
Wall time: 19.457451s

* What happens if we need to read 2 simple /proc files (14 fields)
  per process?
/prod/pid/statm (2x) for 1000 processes, 1000 times, open (scanf)
CPU time : 30.250000s
Wall time: 32.650314s

* 10000 processes at 3 files each (27 fields)
/prod/pid/statm (3x) for 10000 processes, 1000 times, open (scanf)
CPU time : 450.630000s
Wall time: 500.265503s

* nproc delivering said 7 fields:
nproc for 1000 processes, 1000 times, one process per request
CPU time : 7.910000s
Wall time: 8.473371s

* 200 processes per request, but still 1000 reply messages. If we stuffed
  a bunch of them into every message, performance would improve further.
nproc for 1000 processes, 1000 times, 200 processes per request
CPU time : 6.350000s
Wall time: 6.817391s

* There's no large penalty if we need additional fields:
14 nproc fields for 1000 processes, 1000 times, one process per request
CPU time : 8.680000s
Wall time: 9.328828s

27 nproc fields for 10000 processes, 1000 times, one process per request
CPU time : 88.270000s
Wall time: 98.664330s

Roger
