Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267163AbTBUFPw>; Fri, 21 Feb 2003 00:15:52 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267174AbTBUFPw>; Fri, 21 Feb 2003 00:15:52 -0500
Received: from packet.digeo.com ([12.110.80.53]:37307 "EHLO packet.digeo.com")
	by vger.kernel.org with ESMTP id <S267163AbTBUFPZ>;
	Fri, 21 Feb 2003 00:15:25 -0500
Date: Thu, 20 Feb 2003 21:27:03 -0800
From: Andrew Morton <akpm@digeo.com>
To: linux-kernel@vger.kernel.org
Subject: iosched: impact of streaming write on streaming read
Message-Id: <20030220212703.04e3df17.akpm@digeo.com>
In-Reply-To: <20030220212304.4712fee9.akpm@digeo.com>
References: <20030220212304.4712fee9.akpm@digeo.com>
X-Mailer: Sylpheed version 0.8.9 (GTK+ 1.2.10; i586-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-OriginalArrivalTime: 21 Feb 2003 05:25:24.0783 (UTC) FILETIME=[A2E9F3F0:01C2D969]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Here we take a look at the impact which a streaming write has upon streaming
read bandwidth.

A single streaming write was set up with:

	while true
	do
	        dd if=/dev/zero of=foo bs=1M count=512 conv=notrunc
	done

and we measure how long it takes to read a 100 megabyte file from the same
filesystem with

	time cat 100m-file > /dev/null

I'll include `vmstat 1' snippets here as well.


2.4.21-pre4:	42 seconds
 1  3    276   4384   2144 222300    0    0    80 26480  520   743  0  6 94  0
 0  3    276   4344   2144 222240    0    0    76 25224  512   492  0  4 96  0
 0  3    276   4340   2148 222220    0    0   124 25584  520   536  0  3 97  0
 0  3    276   4404   2152 222132    0    0    44 26604  538   533  0  5 95  0
 0  4    276   4464   2160 221928    0    0    60 25040  516   559  0  4 96  0
 0  4    276   4460   2160 221900    0    0   612 27456  560   621  0  4 96  0
 0  4    276   4392   2156 221972    0    0   708 23872  488   566  0  4 95  0
 0  4    276   4420   2168 221852    0    0   688 26668  545   653  0  4 96  0
 0  4    276   4204   2164 221912    0    0   696 21588  492   884  0  5 95  0
 0  4    276   4448   2164 221668    0    0   396 21376  423   833  0  4 96  0
 0  4    276   4432   2160 221688    0    0   784 26368  544   705  0  4 96  0
 0  4    276   4400   2168 221608    0    0   560 27640  563   596  0  5 95  0
 4  1    276   4324   2188 221616    0    0 12476 12996  538   908  0  4 96  0
 0  4    276   3516   2196 222408    0    0 12320 16048  529   971  0  2 98  0
 0  4    276   3468   2212 222424    0    0 12704 14428  540  1039  0  4 96  0
 0  4    276   4112   2208 221700    0    0   552 20824  474   539  0  4 96  0
 3  2    276   3768   2208 222040    0    0   524 25428  503   612  0  3 97  0
 0  4    276   4452   2216 221344    0    0   536 19548  437  1241  0  3 97  0

2.5.61+hacks:	48 seconds
 0  5      0   2140   1296 227700    0    0     0 22236 1213   126  0  4  0 96
 0  5      0   2252   1296 227664    0    0     0 23340 1219   123  0  3  0 97
 0  6      0   4044   1288 225904    0    0  1844 13632 1183   236  0  2  0 98
 0  6      0   4100   1268 225788    0    0  1920 13780 1173   217  0  2  0 98
 0  6      0   4156   1248 225908    0    0  2184 14828 1184   236  0  3  0 97
 0  6      0   4100   1244 226012    0    0  2176 13720 1173   237  0  2  0 98
 0  6      0   4212   1240 225980    0    0  1924 13900 1175   236  0  2  0 98
 0  5      0   5444   1192 224824    0    0  2304 11820 1164   206  0  2  0 98
 0  6      0   2196   1180 228088    0    0  2308 14460 1180   269  0  3  0 97

2.5.61+CFQ:	27 seconds
 1  3      0   6196   2060 222852    0    0     0 23840 1247   220  0  4  4 92
 0  2      0   4404   1820 224880    0    0     0 22208 1237   271  0  3  8 89
 2  4      0   2884   1680 226588    0    0  1496 26944 1263   355  0  4  2 94
 0  4      0   4332   1312 225388    0    0  4592 14692 1244   414  0  3  0 97
 0  4      0   4268   1012 225764    0    0  1408 29540 1308   671  0  5  0 95
 0  4      0   3316   1016 226752    0    0  2820 27500 1306   668  0  5  0 95
 0  4      0   4212    992 225924    0    0  3076 22148 1255   508  0  3  0 97

2.5.61+AS:	3.8 seconds
 0  4      0   2236   1320 227548    0    0     0 36684 1335   136  0  5  0 95
 0  4      0   2236   1296 227636    0    0     0 37736 1334   134  0  5  0 95
 0  5      0   3348   1088 226604    0    0  1232 30040 1320   174  0  4  0 96
 0  5      0   2284   1056 227920    0    0 29088  5488 1536   855  0  4  0 96
 0  5      0   4916   1080 225672    0    0 26904  8452 1517   993  0  5  0 95
 0  5    120   2228   1108 228732    0  120 29472  6752 1545   940  0  3  1 96
 0  4    120   4196   1060 226984    0    0 16164 15740 1426   627  0  3  3 93
	

