Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S135931AbREBFNs>; Wed, 2 May 2001 01:13:48 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S135942AbREBFNi>; Wed, 2 May 2001 01:13:38 -0400
Received: from ns1.crl.go.jp ([133.243.3.1]:20868 "EHLO ns1.crl.go.jp")
	by vger.kernel.org with ESMTP id <S135931AbREBFN0>;
	Wed, 2 May 2001 01:13:26 -0400
Date: Wed, 2 May 2001 14:13:22 +0900 (JST)
From: Tom Holroyd <tomh@po.crl.go.jp>
To: kernel mailing list <linux-kernel@vger.kernel.org>
Subject: Unknown HZ value! (2000) Assume 1024.
Message-ID: <Pine.LNX.4.30.0105021348480.27862-100000@holly.crl.go.jp>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Alpha.  2.4.1.  Hz = 1024.  Uptime > 48.54518 days (low idle).
(Subject message from ps and friends.)

/proc/uptime:
4400586.27 150439.36

/proc/stat:
cpu  371049158 3972370867 8752820 4448994822
     (user,    nice,      system, idle)

In .../fs/proc/proc_misc.c:kstat_read_proc(), the cpu line is being
computed by:

        len = sprintf(page, "cpu  %u %u %u %lu\n", user, nice, system,
                      jif * smp_num_cpus - (user + nice + system));

The user, nice, and system values add up to 4352172845 > 2^32, and jif is
4400586.27 * 1024 = 4506200340, leading to the incorrect idle time (1
cpu).  It should be calculated this way:

        len = sprintf(page, "cpu  %u %u %u %lu\n", user, nice, system,
                      jif * smp_num_cpus - ((unsigned long)user + nice + system));

or just declare those as unsigned longs instead of ints.  I notice also
that since kstat.per_cpu_nice is an int, it's going to overflow in another
3.6 days anyhow.  I'll let you know what blows up then.  Any chance of
making those guys longs?

The ps program, of course, is trying to calculate HZ by inverting the
above calculation, and it gets a bogus value.  I suppose it could use
(uptime[0] - uptime[1]) / (user + nice + system) instead of trying to
calculate jif first, but it'll still fail when the ints roll over.

