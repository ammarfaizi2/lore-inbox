Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262754AbTDFB1G (for <rfc822;willy@w.ods.org>); Sat, 5 Apr 2003 20:27:06 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262763AbTDFB1G (for <rfc822;linux-kernel-outgoing>); Sat, 5 Apr 2003 20:27:06 -0500
Received: from [12.47.58.55] ([12.47.58.55]:16538 "EHLO pao-ex01.pao.digeo.com")
	by vger.kernel.org with ESMTP id S262754AbTDFB1D (for <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 5 Apr 2003 20:27:03 -0500
Date: Sat, 5 Apr 2003 17:39:34 -0800
From: Andrew Morton <akpm@digeo.com>
To: Andrea Arcangeli <andrea@suse.de>
Cc: wli@holomorphy.com, mbligh@aracnet.com, mingo@elte.hu, hugh@veritas.com,
       dmccr@us.ibm.com, linux-kernel@vger.kernel.org, linux-mm@kvack.org
Subject: Re: objrmap and vmtruncate
Message-Id: <20030405173934.766b1e85.akpm@digeo.com>
In-Reply-To: <20030406001407.GL1326@dualathlon.random>
References: <20030404163154.77f19d9e.akpm@digeo.com>
	<12880000.1049508832@flay>
	<20030405024414.GP16293@dualathlon.random>
	<20030404192401.03292293.akpm@digeo.com>
	<20030405040614.66511e1e.akpm@digeo.com>
	<20030405232524.GD1828@holomorphy.com>
	<20030405155740.3da6a5bf.akpm@digeo.com>
	<20030406001407.GL1326@dualathlon.random>
X-Mailer: Sylpheed version 0.8.9 (GTK+ 1.2.10; i586-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-OriginalArrivalTime: 06 Apr 2003 01:38:27.0618 (UTC) FILETIME=[38A07820:01C2FBDD]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Andrea Arcangeli <andrea@suse.de> wrote:
>
> 2.4-aa is outperforming 2.5 in almost all tiobenchs results, so I doubt
> the elevator is that bad and could explain such drop in performance. 

Well.  tiobench doesn't measure concurrent reads and writes.

A quick test shows the anticipatory scheduler runs `tiobench --threads 16'
1.5x faster on reads and 1.15x faster on writes.  But that's a damn good
result for a 2.4 elevator.

It has a starvation problem though.

Running this:

while true
do
	dd if=/dev/zero of=x bs=1M count=300 conv=notrunc
done

in parallel with five reads from five 200M files shows writes getting stalled
for 20 second periods.


 0  8      0   3980   1800 223056    0    0 11688 10168  450   351  0  1 99  0
 0  7      0   3516   1792 223548    0    0 20036  4136  491   476  0  5 95  0
 2  5      0   3864   1792 223200    0    0 23444     0  469   727  1  2 97  0
 0  7      0   3384   1792 223684    0    0 21952     0  456   639  0  6 94  0
 1  6      0   3468   1792 223596    0    0 23436     0  475   680  0  2 98  0
 0  7      0   4172   1792 222896    0    0 22824     0  469   597  0  2 98  0
 0  7      0   3472   1792 223592    0    0 24376     0  493   599  0  5 95  0
procs -----------memory---------- ---swap-- -----io---- --system-- ----cpu----
 r  b   swpd   free   buff  cache   si   so    bi    bo   in    cs us sy id wa
 4  4      0   3352   1792 223712    0    0 24680     0  496   574  1 11 88  0
 0  7      0   3920   1792 223144    0    0 24120     0  482   708  1  5 94  0
 0  7      0   3920   1792 223144    0    0 23536     0  474   556  1  4 95  0
 0  7      0   3912   1792 223152    0    0 22524     0  468   502  0  5 95  0
 0  7      0   3564   1792 223500    0    0 23120     0  471   510  0  4 96  0
 0  7      0   3324   1792 223740    0    0 21732     0  449   657  0  4 96  0
 0  7      0   3656   1792 223408    0    0 24236     0  484   554  1  3 96  0
 0  7      0   4256   1792 222808    0    0 23076     0  474   561  0  8 92  0
 0  7      0   3436   1792 223628    0    0 22312     0  455   501  0  1 99  0
 0  7      0   3384   1792 223680    0    0 23588     0  476   611  1  1 98  0
 0  8      0   3408   1792 223656    0    0 21464  1312  474   615  0  7 93  0
 0  8      0   3328   1792 223736    0    0 13772 10300  478   467  0  1 99  0
 0  8      0   3492   1656 223712    0    0 11988 12612  497   409  0  1 99  0
 0  8      0   3976    796 224088    0    0 14748  5952  432   367  0  2 98  0
 0  8      0   3812    728 224324    0    0 15636  8064  476   449  1  2 97  0
 0  8      0   3768    732 224364    0    0 12328 10880  469   361  0  1 99  0
 0  8      0   3504    752 224608    0    0 12548  8452  435   354  0  2 98  0
 0  8      0   4180    760 223924    0    0 14676  9920  492   419  0  4 96  0
 0  8      0   3616    776 224472    0    0 12976  9660  462   367  0  3 97  0
 0  7      0   3784    792 224288    0    0 15312  8864  483   401  0  4 96  0
 0  7      0   3328    808 224728    0    0 21060     0  443   468  0  2 98  0
 3  4      0   3324    832 224708    0    0 21752     0  449   470  0  4 96  0
procs -----------memory---------- ---swap-- -----io---- --system-- ----cpu----
 r  b   swpd   free   buff  cache   si   so    bi    bo   in    cs us sy id wa
 1  7      0   3496    852 224516    0    0 21584     0  447   427  0  5 95  0
 0  7      0   3760    876 224228    0    0 22772     0  458   526  1  3 96  0
 0  7      0   4240    896 223728    0    0 22172     0  460   448  0  4 96  0
 0  7      0   3308    920 224636    0    0 22428     0  461   471  0  5 95  0
 0  7      0   3292    944 224628    0    0 22660     0  463   493  0  5 95  0
 5  2      0   3592    960 224312    0    0 21328     0  445   459  0  1 99  0
 1  6      0   4120    980 223764    0    0 22508     0  453   435  1  1 98  0
 1  6      0   3568   1008 224288    0    0 23332     0  475   516  1  5 94  0
 0  7      0   3484   1024 224356    0    0 21968     0  457   476  1  4 95  0
 1  6      0   3928   1048 223888    0    0 20284     0  427   494  0  3 97  0
 0  7      0   3996   1072 223796    0    0 22584     0  461   538  0  3 97  0
 0  7      0   3892   1088 223884    0    0 21728     0  455   470  1  5 94  0
 0  7      0   3916    728 224220    0    0 22884     0  463   503  1  7 92  0
 0  7      0   4340    752 223772    0    0 23000     0  473   502  0  6 94  0
 0  8      0   3600    768 224496    0    0 20692  1124  447   519  0  3 97  0


> I suspect it must be something on the lines of the filesystem doing
> synchronous I/O for some reason inside writepage, like doing a
> wait_on_buffer for every writepage, generating the above fake results.
> Note the 0% cpu time. You're not benchmarking the vm here. Infact I
> would be interested to see the above repeated on ext2.
> 
> It's not true that ext3 is sharing the same writepage of ext2 as you
> said in a earlier email, the ext3 writepage starts like this:

No, that code's all just fluff.  These pages get a disk mapping real early
(I've just added an msync to make sure though).  So ext3_writepage() is
really nothing in this test except for block_write_full_page().  The
journalling system does not get involved much at all with overwrites to
blocks on an ordered-data filesystem.

> and even the ext2 writepage can be synchronous if it has to call
> get_block. Infact I would reccomend to fill the "foo" file with zeros
> and not to have holes in it just to avoid additional synchronous fs
> overhead and to only be sync in the inode map lookup.

Yup, I did that.  It doesn't make any difference.

But you're right, the problem does not occur on 2.4.21-pre5aa2+ext2.  Nor
does it occur on 2.5+ext3, and nor does it occur on 2.4.21-pre5+ext3.  It is
something specific to aa+ext3.

I don't know what's gone wrong.  It's just stuck in filemap_nopage->lock_page
all the time, seeking all over the disk.  It smells like a VM/VFS problem.

procs -----------memory---------- ---swap-- -----io---- --system-- ----cpu----
 r  b   swpd   free   buff  cache   si   so    bi    bo   in    cs us sy id wa
 1  1   6380   4064   5836 232120    0    0  2940     0  214   231  0  2 98  0
 1  0   6380   3196   5836 233032    0    0  3164     0  217   239  0  0 100  0
 0  1   6380   3516   5836 232752    0    0  3136     0  216   234  0  0 100  0
 0  1   6380   3764   5836 232612    0    0  3080     0  214   231  0  2 98  0
 0  1   6380   4028   5836 232432    0    0  3080     0  214   231  0  1 99  0
 1  0   6380   3224   5836 233292    0    0  3108     0  215   231  0  1 99  0
 1  0   6380   3396   5836 233176    0    0  3164     0  216   238  0  0 100  0
 0  1   6380   3600   5836 233048    0    0  3248     0  220   243  0  3 97  0
 0  1   6380   3732   5836 232968    0    0  3192     0  218   239  0  1 99  0

It should look like:

procs -----------memory---------- ---swap-- -----io---- --system-- ----cpu----
 r  b   swpd   free   buff  cache   si   so    bi    bo   in    cs us sy id wa
 1  2   8656   3200    588 241892    0    0  6440 11928  548   545  0  1 99  0
 1  0   8656   2272    588 242896    0    0 13804  7172  817  1173  0  3 97  0
 0  1   8656   2240    588 243036   20   60 16344 14572  924  1236  0  4 96  0
 0  1   8656   2380    528 243188    0    0 16060 16044  965  1183  0  9 91  0
 0  2   8656   3192    544 242068  312    4 13104 13316  801  1038  0  5 95  0
 0  2   8656   2208    564 243204    0    0 14676 17920  929  1086  0  5 95  0
 0  1   8656   2264    576 243160   20    0 16160 11836  892  1231  0  3 97  0
 1  0   8656   4444    584 240956    0    0 10200 15640  740   829  0  3 97  0

File layout is OK, same as ext2:

79895-79895: 0-0 (1)
79896-79902: 260848-260854 (7)
79903-79903: 0-0 (1)
79904-79910: 32607-32613 (7)
79911-79911: 0-0 (1)
79912-79918: 260904-260910 (7)
79919-79919: 0-0 (1)
79920-79926: 32614-32620 (7)
79927-79927: 0-0 (1)
79928-79934: 260960-260966 (7)
79935-79935: 0-0 (1)
79936-79942: 32621-32627 (7)
79943-79943: 0-0 (1)
79944-79950: 261016-261022 (7)
79951-79951: 0-0 (1)

I applied the -aa ext3 patches to 2.4.21-pre5 and that ran OK.

It's almost like the VM is refusing to call ext3_writepage() for some reason,
or is only reclaiming clean pagecache, or the filemap_nopage() readaround
isn't working.  Very odd.

