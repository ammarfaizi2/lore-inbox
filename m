Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264231AbTKKFGi (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 11 Nov 2003 00:06:38 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264259AbTKKFGi
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 11 Nov 2003 00:06:38 -0500
Received: from nat-68-172-17-106.ne.rr.com ([68.172.17.106]:35831 "EHLO
	trip.jpj.net") by vger.kernel.org with ESMTP id S264231AbTKKFGg
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 11 Nov 2003 00:06:36 -0500
Subject: Re: I/O issues, iowait problems, 2.4 v 2.6
From: Paul Venezia <pvenezia@jpj.net>
To: Andrew Morton <akpm@osdl.org>
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <20031110205443.6422259f.akpm@osdl.org>
References: <1068519213.22809.81.camel@soul.jpj.net>
	 <20031110195433.4331b75e.akpm@osdl.org>
	 <1068523328.25805.97.camel@soul.jpj.net>
	 <20031110202819.7e7433a8.akpm@osdl.org>
	 <1068524657.25804.110.camel@soul.jpj.net>
	 <20031110205443.6422259f.akpm@osdl.org>
Content-Type: text/plain
Organization: 
Message-Id: <1068526547.22800.131.camel@soul.jpj.net>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.2.4 
Date: 10 Nov 2003 23:55:48 -0500
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 2003-11-10 at 23:54, Andrew Morton wrote:

> >   0 10      0 1146444  18940 286856    0    0     0  2106 21450 25860  4 14 37 45
> 
> OK, the IO rates are obviously very poor, and the context switch rate is
> suspicious as well.  Certainly, testing with the single disk would help.

I'll get to that as soon as I can.

> 
> But.  If the workload here was a simple dd of /dev/zero onto a regular
> file then why on earth is the pagecache size not rising?  

This vmstat output was shot when I was first noticing this problem. The
nbench tests were running at the time. Seems to indicate the same as
below.

> Could you please
> do:
> 
> 	rm foo
> 	cat /dev/zero > foo
> 
> and rerun the `vmstat 1' trace?  Make sure that after the big initial jump,
> the `cache' column is increasing at a rate equal to the I/O rate.  Thanks.

When I first ran this test, I killed it after 45s or so, noting that the vmstat
output didn't look right. I then deleted the sample file. The file no longer existed,
but the rm didn't exit in a timely fashion, the CPUs were at 100% iowait, the load 
was rising and vmstat was showing a consistent pattern of 5056 blocks out every two 
seconds.

I rebooted and shot these, starting 5 seconds before the cat:

 0  0      0 1474524   7084  42420    0    0     0     0 1033    47  0  0 100  0
 0  0      0 1474524   7084  42420    0    0     0     0 1031    38  0  0 100  0
 0  0      0 1474524   7084  42420    0    0     0     0 1016    12  0  0 100  0
 1  0      0 1373716   7184 140376    0    0     0     0 1020    14  0 10 90  0
 1  2      0 1166548   7392 341652    0    0     8 18836 1028    56  0 21 43 36
 1  2      0 994132   7556 509312    0    0     4  1696 1030    63  0 17 27 56
 1  2      0 867732   7684 632264    0    0     4  2400 1033    65  0 12 27 60
 0  3      0 817748   7732 680700    0    0     4  9632 1033    66  0  5 27 67
 0  4      0 817748   7732 680700    0    0     0     0 1029    47  0  0 25 75
 2  2      0 817748   7732 680700    0    0     0  5372 1032    48  0  0 25 75
 0  4      0 810324   7740 688104    0    0     0   104 1032    49  0  1 25 74
 0  4      0 810324   7740 688104    0    0     0     0 1029    48  0  0 25 75
 0  4      0 810324   7740 688104    0    0     0  4892 1038    54  0  0 25 75
 0  4      0 810324   7740 688104    0    0     0     0 1024    46  0  0 25 75
 0  4      0 793492   7756 704544    0    0     0  9952 1033    52  0  2 25 73
 0  4      0 793492   7756 704544    0    0     0     0 1032    48  0  0 25 75
 0  4      0 793428   7756 704544    0    0     0     0 1031    48  0  0 25 75
 0  4      0 793428   7756 704544    0    0     0     0 1028    52  0  0 25 75
 0  4      0 768276   7780 729136    0    0     0  4996 1032    51  0  2 25 72
 0  4      0 768276   7780 729136    0    0     0     0 1035    46  0  0 25 75
 0  4      0 768276   7780 729136    0    0     0  4892 1026    50  0  0 25 75
 0  4      0 768276   7780 729136    0    0     0     0 1037    46  0  0 25 75
 0  4      0 763988   7784 733212    0    0     0  5060 1032    56  0  0 25 75
 0  4      0 763988   7784 733212    0    0     0     0 1032    46  0  0 25 75
 0  4      0 763988   7784 733212    0    0     0  4892 1033    48  0  0 25 75
 0  4      0 763988   7784 733212    0    0     0     0 1029    50  0  0 25 75
 0  4      0 751316   7796 745508    0    0     0  5060 1039    52  0  1 25 74
 0  4      0 751316   7796 745508    0    0     0     0 1025    52  0  0 25 75

Very similar.

-Paul

