Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964797AbWFHLhc@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964797AbWFHLhc (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 8 Jun 2006 07:37:32 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964810AbWFHLhc
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 8 Jun 2006 07:37:32 -0400
Received: from smtp.ustc.edu.cn ([202.38.64.16]:65414 "HELO ustc.edu.cn")
	by vger.kernel.org with SMTP id S964801AbWFHLhb (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 8 Jun 2006 07:37:31 -0400
Message-ID: <349766648.27054@ustc.edu.cn>
X-EYOUMAIL-SMTPAUTH: wfg@mail.ustc.edu.cn
Date: Thu, 8 Jun 2006 19:37:31 +0800
From: Fengguang Wu <wfg@mail.ustc.edu.cn>
To: Voluspa <lista1@comhem.se>
Cc: Andrew Morton <akpm@osdl.org>, Valdis.Kletnieks@vt.edu, diegocg@gmail.com,
       linux-kernel@vger.kernel.org
Subject: adaptive readahead overheads
Message-ID: <20060608113731.GA5813@mail.ustc.edu.cn>
Mail-Followup-To: Fengguang Wu <wfg@mail.ustc.edu.cn>,
	Voluspa <lista1@comhem.se>, Andrew Morton <akpm@osdl.org>,
	Valdis.Kletnieks@vt.edu, diegocg@gmail.com,
	linux-kernel@vger.kernel.org
References: <349406446.10828@ustc.edu.cn> <20060604020738.31f43cb0.akpm@osdl.org> <1149413103.3109.90.camel@laptopd505.fenrus.org> <20060605031720.0017ae5e.lista1@comhem.se> <349562623.17723@ustc.edu.cn> <20060608094356.5c1272cc.lista1@comhem.se>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20060608100444.5212162d.lista1@comhem.se>
User-Agent: Mutt/1.5.11+cvs20060126
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I'd like to show some numbers on the pure software overheads come with
the adaptive readahead in daily operations.

SEQUENTIAL ACCESS OVERHEADS, or: PER-PAGE OVERHEADS
===================================================

SUMMARY
                      user       sys       cpu         total
	ARA	      0.13       5.30      92.0%       5.87
	STOCK         0.12       5.34      91.8%       5.91

        It shows about 0.8% overhead.

	They are mainly contributed by:
	- debug/accounting code
	- smooth aging accounting for the stateful method
	- readahead hit feedback

	However, if necessary, each of the obove can be seperated out
	and made a kconfig option. They won't affect the main
	functionality of ARA.

DETAILS

% time cp work/sparse /dev/null # repeat 5 times each

/proc/sys/vm/readahead_ratio = 1

cp work/sparse /dev/null  0.13s user 5.30s system 93% cpu 5.780 total
cp work/sparse /dev/null  0.13s user 5.29s system 92% cpu 5.847 total
cp work/sparse /dev/null  0.13s user 5.27s system 92% cpu 5.860 total
cp work/sparse /dev/null  0.13s user 5.32s system 91% cpu 5.961 total
cp work/sparse /dev/null  0.12s user 5.32s system 92% cpu 5.902 total

/proc/sys/vm/readahead_ratio = 100

cp work/sparse /dev/null  0.12s user 5.39s system 93% cpu 5.888 total
cp work/sparse /dev/null  0.13s user 5.32s system 92% cpu 5.923 total
cp work/sparse /dev/null  0.11s user 5.32s system 91% cpu 5.901 total
cp work/sparse /dev/null  0.12s user 5.35s system 92% cpu 5.952 total
cp work/sparse /dev/null  0.12s user 5.30s system 91% cpu 5.900 total


SMALL FILES OVERHEADS, or: PER-FILE OVERHEADS
=============================================

SUMMARY
                    user	sys	   cpu       total
	ARA         405.90     326.54      97%     12:27.59 
	stock       407.53     322.02      97%     12:27.52

	No obvious overhead.

	There is overhead in calling readahead_close() on each file.
	However, the small-io-go-all-down-to-lowlevel events are
	sucessfully reduced, making up for the overhead.

DETAILS
	In a qemu with 156M memory and a host system with 4G memory,
	traverse a whole tree of 434M /usr, and do this repeatedly.
	So that the 2+ runs do not involve true disk I/O.

# time find /usr -type f -exec md5sum {} \; >/dev/null

ARA

406.00s user 325.16s system 97% cpu 12:28.17 total
403.35s user 325.15s system 97% cpu 12:23.86 total
403.00s user 325.03s system 97% cpu 12:23.61 total
406.43s user 327.64s system 97% cpu 12:30.64 total
407.03s user 325.46s system 97% cpu 12:28.17 total
406.46s user 326.89s system 98% cpu 12:26.31 total
405.96s user 328.45s system 98% cpu 12:27.08 total
409.05s user 328.55s system 97% cpu 12:32.85 total

STOCK(vanilla kernel)

408.64s user 321.55s system 97% cpu 12:27.68 total
406.39s user 320.55s system 97% cpu 12:24.58 total
408.41s user 321.22s system 97% cpu 12:27.91 total
409.10s user 324.72s system 97% cpu 12:33.16 total
406.60s user 321.81s system 97% cpu 12:26.48 total
405.60s user 322.49s system 97% cpu 12:25.29 total
408.13s user 322.19s system 97% cpu 12:27.92 total
407.35s user 321.66s system 97% cpu 12:27.11 total

Thanks,
Wu
