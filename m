Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S290969AbSBSJ3m>; Tue, 19 Feb 2002 04:29:42 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S290862AbSBSJ3X>; Tue, 19 Feb 2002 04:29:23 -0500
Received: from ns1.crl.go.jp ([133.243.3.1]:16589 "EHLO ns1.crl.go.jp")
	by vger.kernel.org with ESMTP id <S290869AbSBSJ3R>;
	Tue, 19 Feb 2002 04:29:17 -0500
Date: Tue, 19 Feb 2002 18:29:03 +0900 (JST)
From: Tom Holroyd <tomh@po.crl.go.jp>
X-X-Sender: tomh@holly.crl.go.jp
To: Tim Schmielau <tim@physik3.uni-rostock.de>
cc: kernel mailing list <linux-kernel@vger.kernel.org>
Subject: Re: Unknown HZ value! (1908) Assume 1024.
In-Reply-To: <Pine.LNX.4.33.0202190951130.13518-100000@gans.physik3.uni-rostock.de>
Message-ID: <Pine.LNX.4.44.0202191817330.26361-100000@holly.crl.go.jp>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> > /proc/stat:
> > cpu  2427984276 2540057284 67737892 4296620451
> > cpu0 2427984276 2540057284 67737892 4296620451
> > ...
> >
> I'd suggest changing the declarations in kstat_read_proc to
>
>         unsigned long jif = jiffies, user = 0, nice = 0, system = 0;
>         unsigned int sum = 0;
>
> so that ticks that are lost due to overflow count as "other".

Isn't it also necessary to change the sprintf() format strings to %lu?
That is,
        len = sprintf(page, "cpu  %lu %lu %lu %lu\n", user, nice, system,
                      jif * smp_num_cpus - (user + nice + system));

Also, it looks like the per_cpu loop that follows the sprintf() also
has this bug, i.e., adding three ints to get a long.  Short of making
the kstat fields longs, it should suffice to just use a cast there,
and adjust the related sprintf(), e.g., to
                len += sprintf(page + len, "cpu%d %lu %lu %lu %lu\n",
                        i,
                        kstat.per_cpu_user[cpu_logical_map(i)],
                        kstat.per_cpu_nice[cpu_logical_map(i)],
                        kstat.per_cpu_system[cpu_logical_map(i)],
                        jif -
           ((unsigned long) kstat.per_cpu_user[cpu_logical_map(i)] +
                            kstat.per_cpu_nice[cpu_logical_map(i)] +
                            kstat.per_cpu_system[cpu_logical_map(i)]));

Might be worth sticking
	int cpu = cpu_logical_map(i);

at the top of the loop too, to clean that code up a bit.

Anyway, I'll have a go at the above and get back to you in about 48.5
days. :-)

Thanks!

