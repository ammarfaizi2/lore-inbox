Return-Path: <linux-kernel-owner+willy=40w.ods.org-S934034AbWK2Lad@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S934034AbWK2Lad (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 29 Nov 2006 06:30:33 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S935031AbWK2Lac
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 29 Nov 2006 06:30:32 -0500
Received: from smtp.ustc.edu.cn ([202.38.64.16]:49546 "HELO ustc.edu.cn")
	by vger.kernel.org with SMTP id S934034AbWK2La2 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 29 Nov 2006 06:30:28 -0500
Message-ID: <364799787.25059@ustc.edu.cn>
X-EYOUMAIL-SMTPAUTH: wfg@mail.ustc.edu.cn
Message-Id: <20061129111416.430835000@intel.ustc.edu.cn>
User-Agent: quilt/0.45-1
Date: Wed, 29 Nov 2006 19:14:16 +0800
From: Fengguang Wu <wfg@mail.ustc.edu.cn>
To: Andrew Morton <akpm@osdl.org>
Cc: Neil Brown <neilb@suse.de>, linux-kernel@vger.kernel.org
Subject: [patch 0/2] adaptive readahead fixes
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Andrew,

Here are two bug fix patches against -mm, with their recommended placement:


 readahead-events-accounting.patch
 readahead-rescue_pages.patch
 readahead-sysctl-parameters.patch
+readahead-sysctl-parameters-fix.patch
 readahead-min-max-sizes.patch
 readahead-state-based-method-aging-accounting.patch
 readahead-state-based-method-routines.patch

 readahead-loop-case.patch
 readahead-nfsd-case.patch
 readahead-nfsd-case-fix.patch
+readahead-nfsd-case-fix-uninitialized-ra_min-ra_max.patch
 readahead-turn-on-by-default.patch
 readahead-remove-size-limit-on-read_ahead_kb.patch
 readahead-remove-size-limit-of-max_sectors_kb-on-read_ahead_kb.patch


readahead-sysctl-parameters-fix.patch
=====================================

Two trivial fixes.
// Was three, but you were so swift on CTL_UNNUMBERED :-)


readahead-nfsd-case-fix-uninitialized-ra_min-ra_max.patch
=========================================================

The NFS benchmark is ran again with the bug fixed.
The summary is included in the patch as changelog.
The raw numbers are here:

pattern=f rsize=8k

ratio=1 	3.04s clock  0.64s kernel  0.01s user  224+1987 cs
ratio=1 	3.06s clock  0.66s kernel  0.02s user  199+2340 cs
ratio=1 	3.10s clock  0.63s kernel  0.02s user  254+2264 cs

ratio=50 	2.59s clock  0.60s kernel  0.02s user  106+1180 cs
ratio=50 	2.43s clock  0.59s kernel  0.01s user  94+1189 cs
ratio=50 	2.50s clock  0.59s kernel  0.02s user  98+1174 cs

pattern=f rsize=32k

ratio=1 	2.39s clock  0.29s kernel  0.02s user  1046+59 cs
ratio=1 	2.40s clock  0.29s kernel  0.01s user  1040+69 cs
ratio=1 	2.41s clock  0.28s kernel  0.02s user  1114+55 cs

ratio=50 	2.18s clock  0.32s kernel  0.02s user  227+213 cs
ratio=50 	2.15s clock  0.32s kernel  0.02s user  230+215 cs
ratio=50 	2.17s clock  0.33s kernel  0.01s user  225+208 cs

pattern=f rsize=128k

ratio=1 	2.42s clock  0.32s kernel  0.01s user  436+131 cs
ratio=1 	2.38s clock  0.33s kernel  0.02s user  441+128 cs
ratio=1 	2.39s clock  0.31s kernel  0.01s user  448+122 cs

ratio=50 	2.36s clock  0.30s kernel  0.01s user  202+67 cs
ratio=50 	2.21s clock  0.31s kernel  0.02s user  194+72 cs
ratio=50 	2.47s clock  0.30s kernel  0.01s user  201+63 cs

pattern=ff rsize=8k

ratio=1 	12.19s clock  1.18s kernel  0.38s user  4152+13042 cs
ratio=1 	12.88s clock  1.21s kernel  0.33s user  4564+12574 cs
ratio=1 	12.26s clock  1.22s kernel  0.38s user  4857+12453 cs

ratio=50 	6.53s clock  1.27s kernel  0.32s user  174+2256 cs
ratio=50 	6.33s clock  1.27s kernel  0.33s user  164+2252 cs
ratio=50 	6.35s clock  1.24s kernel  0.35s user  151+2264 cs

pattern=ff rsize=32k

ratio=1 	14.49s clock  0.90s kernel  0.37s user  2904+9906 cs
ratio=1 	14.55s clock  1.00s kernel  0.34s user  2899+9803 cs
ratio=1 	14.81s clock  1.00s kernel  0.31s user  2910+10147 cs

ratio=50 	5.48s clock  0.65s kernel  0.30s user  177+512 cs
ratio=50 	5.42s clock  0.68s kernel  0.29s user  181+509 cs
ratio=50 	5.47s clock  0.65s kernel  0.29s user  175+521 cs

pattern=ff rsize=128k

ratio=1 	15.87s clock  0.90s kernel  0.32s user  1496+8738 cs
ratio=1 	15.33s clock  0.89s kernel  0.34s user  1718+8350 cs
ratio=1 	16.17s clock  0.91s kernel  0.32s user  1706+7959 cs

ratio=50 	5.18s clock  0.56s kernel  0.28s user  175+255 cs
ratio=50 	5.22s clock  0.57s kernel  0.30s user  172+258 cs
ratio=50 	5.16s clock  0.54s kernel  0.30s user  168+260 cs

pattern=d rsize=8k

ratio=1 	2.86s clock  0.45s kernel  0.07s user  7961+729 cs
ratio=1 	2.87s clock  0.50s kernel  0.07s user  8036+627 cs
ratio=1 	2.80s clock  0.51s kernel  0.07s user  7986+640 cs

ratio=50 	2.58s clock  0.51s kernel  0.07s user  8873+177 cs
ratio=50 	2.39s clock  0.51s kernel  0.05s user  8782+194 cs
ratio=50 	2.48s clock  0.51s kernel  0.06s user  8884+171 cs

pattern=d rsize=32k

ratio=1 	2.49s clock  0.40s kernel  0.05s user  7428+83 cs
ratio=1 	2.57s clock  0.40s kernel  0.06s user  7425+86 cs
ratio=1 	2.54s clock  0.41s kernel  0.06s user  7427+83 cs

ratio=50 	2.02s clock  0.40s kernel  0.08s user  7478+169 cs
ratio=50 	1.99s clock  0.43s kernel  0.05s user  7488+162 cs
ratio=50 	1.95s clock  0.39s kernel  0.05s user  7483+169 cs

pattern=d rsize=128k

ratio=1 	2.17s clock  0.41s kernel  0.05s user  7248+120 cs
ratio=1 	2.13s clock  0.42s kernel  0.05s user  7242+133 cs
ratio=1 	2.23s clock  0.43s kernel  0.07s user  7247+121 cs

ratio=50 	2.09s clock  0.39s kernel  0.06s user  7315+97 cs
ratio=50 	1.93s clock  0.41s kernel  0.05s user  7314+131 cs
ratio=50 	1.97s clock  0.43s kernel  0.07s user  7317+132 cs

pattern=dd rsize=8k

ratio=1 	8.23s clock  1.04s kernel  0.18s user  15564+1306 cs
ratio=1 	8.20s clock  1.06s kernel  0.17s user  15465+1251 cs
ratio=1 	8.04s clock  1.03s kernel  0.15s user  15487+1226 cs

ratio=50 	8.06s clock  1.03s kernel  0.18s user  16992+291 cs
ratio=50 	8.14s clock  0.98s kernel  0.19s user  17011+297 cs
ratio=50 	7.77s clock  1.01s kernel  0.16s user  16920+292 cs

pattern=dd rsize=32k

ratio=1 	8.46s clock  0.91s kernel  0.16s user  14248+593 cs
ratio=1 	8.27s clock  0.85s kernel  0.17s user  14266+564 cs
ratio=1 	8.09s clock  0.86s kernel  0.18s user  14255+551 cs

ratio=50 	6.85s clock  0.89s kernel  0.18s user  14304+301 cs
ratio=50 	6.79s clock  0.93s kernel  0.14s user  14302+274 cs
ratio=50 	6.99s clock  0.93s kernel  0.17s user  14296+303 cs

pattern=dd rsize=128k

ratio=1 	7.87s clock  0.88s kernel  0.17s user  13845+368 cs
ratio=1 	7.81s clock  0.89s kernel  0.17s user  13853+393 cs
ratio=1 	7.57s clock  0.90s kernel  0.17s user  13838+433 cs

ratio=50 	6.97s clock  0.84s kernel  0.19s user  13816+235 cs
ratio=50 	6.90s clock  0.88s kernel  0.19s user  13816+225 cs
ratio=50 	7.03s clock  0.84s kernel  0.18s user  13813+222 cs


Regards,
Fengguang Wu

PS.
About the partial sendfile problem mentioned in the previous benchmark mail:
The stock readahead is not handling it correctly, but not so destructive.
So I choose not to submit the patch.
