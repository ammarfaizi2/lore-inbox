Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262074AbUCQVSs (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 17 Mar 2004 16:18:48 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262077AbUCQVSs
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 17 Mar 2004 16:18:48 -0500
Received: from ppp-217-133-42-200.cust-adsl.tiscali.it ([217.133.42.200]:63636
	"EHLO dualathlon.random") by vger.kernel.org with ESMTP
	id S262074AbUCQVSk (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 17 Mar 2004 16:18:40 -0500
Date: Wed, 17 Mar 2004 22:19:24 +0100
From: Andrea Arcangeli <andrea@suse.de>
To: Andrew Morton <akpm@osdl.org>, Linus Torvalds <torvalds@osdl.org>
Cc: linux-kernel@vger.kernel.org, "Martin J. Bligh" <mbligh@aracnet.com>
Subject: Re: 2.4.5-rc1 shm paging blocker
Message-ID: <20040317211924.GD2548@dualathlon.random>
References: <20040317061522.GN30940@dualathlon.random> <20040317154314.GG2106@dualathlon.random>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20040317154314.GG2106@dualathlon.random>
User-Agent: Mutt/1.4.1i
X-GPG-Key: 1024D/68B9CB43 13D9 8355 295F 4823 7C49  C012 DFA1 686E 68B9 CB43
X-PGP-Key: 1024R/CB4660B9 CC A0 71 81 F4 A0 63 AC  C0 4B 81 1D 8C 15 C8 E5
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Mar 17, 2004 at 04:43:14PM +0100, Andrea Arcangeli wrote:
> it seems the testing I did on 2.6.5-rc1 was incorrect (after testing

Ok I solved it. The testing I did was perfectly correct.

But the new changes were colliding especially with objrmap and I didn't expect
a special collision breaking _only_ objrmap (this has nothing to do with the
anon_vma work I did on top of objrmap, Martin's tree will have the same problem
that I had). The new changes alone works fine, but in combination with objrmap
they cause everything to go into taking the nap in blk_congestion_wait.  Since
I tested objrmap previously extensively (on 2.6.3) I excluded originally that
it could be a problem that could trigger only in combination with objrmap, but
apparently the new code threats the referenced pages differently. This is the
fix, and I don't need this fix to avoid a system-hang-livelock with 2.6.4/2.6.3
(or with 2.6.5-rc1 with the patches backed out). 

It wasn't very easy to debug since there are around 200 tasks all
rescheduling and all cpus calling shrink_cache in a live lock loop and then
going back to sleep, and it's not a deadlock, but the machine hangs forever and
clicking reboot is the only way out.

--- 2.6.5-rc1-aa1/mm/objrmap.c.~1~	2004-03-17 18:32:58.000000000 +0100
+++ 2.6.5-rc1-aa1/mm/objrmap.c	2004-03-17 21:39:05.760714768 +0100
@@ -151,14 +151,12 @@ page_referenced_inode(struct page *page)
 {
 	struct address_space *mapping = page->as.mapping;
 	struct vm_area_struct *vma;
-	int referenced;
+	int referenced = 0;
 
 	BUG_ON(PageSwapCache(page));
 
 	if (down_trylock(&mapping->i_shared_sem))
-		return 1;
-
-	referenced = 0;
+		goto out;
 
 	list_for_each_entry(vma, &mapping->i_mmap, shared)
 		referenced += page_referenced_one(vma, page);
@@ -167,7 +165,7 @@ page_referenced_inode(struct page *page)
 		referenced += page_referenced_one(vma, page);
 
 	up(&mapping->i_shared_sem);
-
+ out:
 	return referenced;
 }
 

this is 2.6.5-rc1 + objrmap:

got shmid 32768
procs -----------memory---------- ---swap-- -----io---- --system-- ----cpu----
 r  b   swpd   free   buff  cache   si   so    bi    bo   in    cs us sy id wa
11  2      0 927636  10776  44168    0    0     7     1  270    12  0  0 100  0
25  3      0 704792  10776 263604    0    0     0     0 1087 28592 10 91  0  0
32  0      0 590800  10776 373492    0    0     0     0 1084   151 15 85  0  0
46  1      0 471056  10776 489024    0    0     0   220 1132   104 14 86  0  0
53  1      0 393480  10784 562660    0    0     0    16 1087    91 15 85  0  0
60  0      0 315264  10792 636704    0    0     0    24 1086    90 15 85  0  0
67  0      0 249208  10792 698788    0    0     0     0 1084    83 15 85  0  0
74  0      0 214112  10792 729796    0    0     0     0 1084    89 18 82  0  0
81  1      0 149384  10792 790452    0    0     0     0 1085    89 15 85  0  0
81  0      0 105992  10792 829960    0    0     0     0 1085    79 17 83  0  0
88  0      0  60736  10792 871100    0    0     0     0 1085    81 15 85  0  0
89  0      0   3880  10536 924532    0    0     0     0 1091    68 15 85  0  0
91  1      0   2248   5768 928348    0    0     0    28 1092   151  8 92  0  0
89 18    588  11864    660 920564  216  640   216   640 7108   756  2 98  0  0
92 20    908  13276    532 918532   88  376    88   376 1960   317  2 98  0  0
92 21    964  13188    532 918440  112   88   112    88  959   170  3 97  0  0
90 18    652   2068    540 930364  272  132   280   132  985   175  4 96  0  0
92 14    700   2092    532 930448   68  156    68   156 1733   248  2 98  0  0
92 17    656   2016    532 930340  156  120   156   120 1110   325  4 96  0  0
90 24  12040   2532    188 937616  772 11972   920 12012 13078  1857  1 99  0  0
89 33  11992   3184    184 938300  604  380   648   428 3211   851  1 99  0  0
91 33  11964   3012    184 938328   24   36    24    36  969   127  1 99  0  0
91 39  12272   2348    164 938756  272  416   304   416 1406   373  1 99  0  0
92 36  13952   2300    152 940492 1704 2868  2716  2868 4864   923  1 99  0  0
[hang - live lock]

this is 2.6.5-rc1 + objrmap + the above fix:

procs -----------memory---------- ---swap-- -----io---- --system-- ----cpu----
 r  b   swpd   free   buff  cache   si   so    bi    bo   in    cs us sy id wa
 9  1      0 934448   5400  43832    0    0   128     9  270   111  1  4 91  3
27  1      0 728920   5400 245588    0    0     0     0 1089 18437 11 89  0  0
41  4      0 592296   5400 378120    0    0     0     0 1083   100 13 87  0  0
49  1      0 516944   5400 449384    0    0     0     0 1086    89 15 85  0  0
56  1      0 449224   5408 513092    0    0     0    44 1087    91 15 85  0  0
69  0      0 372944   5416 585028    0    0     0    16 1089   110 14 86  0  0
69  0      0 302080   5416 652212    0    0     0     0 1085    68 15 85  0  0
76  0      0 276664   5416 673428    0    0     0     0 1086    83 15 85  0  0
76  1      0 204984   5416 741360    0    0     0     0 1083    70 14 86  0  0
83  0      0 162400   5416 779848    0    0     0     0 1085    81 15 86  0  0
83  0      0 111728   5420 826764    0    0     0   472 1095    88 13 87  0  0
90  1      0  64288   5420 870012    0    0     0     0 1195    86 15 85  0  0
90  1      0  24224   5420 906256    0    0     0     0 1083    73 15 86  0  0
92  4      0   2064   2500 927944    0    0     0   856 1214   143 11 89  0  0
91 35   4124   3016   1532 925900   64 2304    64  2324 1298  1092  9 91  0  0
95 25   7520   1996   1428 926948 3560 5816  3560  5820 1356  6653 10 90  0  0
80 43  25236   2704    168 937332 2144 17916  2144 17916 1371  8706  6 94  0  0
93 42  33312   3308    172 938176 1680 9752  2428  9752 1417  7547  2 99  0  0
99 71  44388   2232    176 931668 3392 11536  3720 11536 1503 21226  5 95  0  0
99 67  49540   2316    160 934400 2940 6084  2940  6084 1424  4030  0 100  0  0
97 59  53808   3408    164 931584 3196 5068  3392  5068 1426  2600  0 100  0  0
57 72  62420   5112    152 923976 3824 8200  3824  8200 1438 12514  2 98  0  0
99 87  69792   2928    152 927704 3184 9288  3184  9288 1518 11193  1 99  0  0
90 74  74392   3984    152 925828 2904 5556  2904  5556 1389  2431  0 100  0  0
70 82  81580   2748    152 921060 5672 8156  5672  8156 1398 17712  1 99  0  0
94 80  88064   2232    152 921404 5008 7900  5008  7900 1453 17488  1 100  0  0
99 73  93668   5044    172 920308 3372 6340  3532  6340 1437  4039  0 100  0  0
97 69  99784   2232    152 920132 3900 6664  3900  6664 1380 15020  0 100  0  0
70 71 105624   4308    152 919736 4300 7356  4300  7356 1464  9876  0 100  0  0
97 71 112260   8492    148 916520 3988 7500  3988  7500 1444 22537  0 100  0  0
49 90 118828   3668    148 914696 6076 7208  6076  7208 1464 27088  0 100  0  0
99 86 125552   3216    148 919176 2616 7608  2616  7608 1423  9301  0 100  0  0
98 84 131004   5204    148 917896 3192 6396  3192  6396 1444  2116  0 100  0  0
78 76 136884   2768    148 917520 4696 6844  4696  6844 1403 12965  0 100  0  0
84 73 142328   8108    148 913836 3504 6140  3536  6140 1363  8199  0 100  0  0
81 81 149696   5040    148 913204 4000 8356  4024  8356 1532 32326  0 100  0  0
99 81 155940   2876    148 916620 3144 6996  3144  6996 1543  7558  0 100  0  0
99 80 161800   5312    148 912484 4348 6912  4348  6912 1412  8694  0 100  0  0
99 75 168108   4428    148 914340 3656 7280  3656  7280 1443 12129  0 100  0  0
88 79 174432   3120    152 914548 4952 6936  5020  6936 1368 15244  0 100  0  0

2.6.3 + objrmap (w/o the above) fix is also working like the above w/o any live
lock condition.

So my testing was accurate, it was just my assumption that objrmap wouldn't
especially collide with the new 2.6.5-rc1 changes that was wrong and that
generated the confusion.

Now, if the new congestion-nap code is better or worse I don't know, probably
it's safer to return 0 from a failure in taking the lock anyways, so I will
apply the objrmap fix anyways (Martin you must pick it too if you want to use
objrmap on 2.6.5-rc1+), but at least now things makes sense again ;).

So now the last bit I've to fix is bttv + anon_vma (bttv is causing a BUG_ON to
trigger in xawtv context).
