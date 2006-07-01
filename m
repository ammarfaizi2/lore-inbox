Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751004AbWGAMFR@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751004AbWGAMFR (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 1 Jul 2006 08:05:17 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751107AbWGAMFR
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 1 Jul 2006 08:05:17 -0400
Received: from ns2.suse.de ([195.135.220.15]:59880 "EHLO mx2.suse.de")
	by vger.kernel.org with ESMTP id S1751004AbWGAMFP (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 1 Jul 2006 08:05:15 -0400
From: Neil Brown <neilb@suse.de>
To: Reuben Farrelly <reuben-lkml@reub.net>
Date: Sat, 1 Jul 2006 22:05:01 +1000
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-ID: <17574.25837.681984.389682@cse.unsw.edu.au>
Cc: linux-kernel@vger.kernel.org, Andrew Morton <akpm@osdl.org>
Subject: Re: Weird RAID/SATA problem [ once was Re: 2.6.17-mm3 ]
In-Reply-To: message from Reuben Farrelly on Saturday July 1
References: <20060630105401.2dc1d3f3.akpm@osdl.org>
	<44A5C1D5.20200@reub.net>
	<17573.50871.307879.557218@cse.unsw.edu.au>
	<44A5D079.6070505@reub.net>
	<17573.55937.866300.638738@cse.unsw.edu.au>
	<44A6390E.1030608@reub.net>
	<17574.15295.828980.278323@cse.unsw.edu.au>
	<44A64BD8.90906@reub.net>
	<17574.21399.979888.127483@cse.unsw.edu.au>
	<44A65EB7.5020201@reub.net>
X-Mailer: VM 7.19 under Emacs 21.4.1
X-face: v[Gw_3E*Gng}4rRrKRYotwlE?.2|**#s9D<ml'fY1Vw+@XfR[fRCsUoP?K6bt3YD\ui5Fh?f
	LONpR';(ql)VM_TQ/<l_^D3~B:z$\YC7gUCuC=sYm/80G=$tt"98mr8(l))QzVKCk$6~gldn~*FK9x
	8`;pM{3S8679sP+MbP,72<3_PIH-$I&iaiIb|hV1d%cYg))BmI)AZ
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Saturday July 1, reuben-lkml@reub.net wrote:
> > 
> > Only difference I can think of is still barriers... Does this patch
> > make any difference?
> 
> You will be happy to know that yes, it does make a difference.
> 
> Applied to -mm4, RAID-1 now comes up with all arrays in sync and everything 
> looking good.  Tried it twice, and both times raid-1 came up perfectly with
> 
> md0 : active raid1 sdc2[1] sda2[0]
>        24410688 blocks [2/2] [UU]
>        bitmap: 0/187 pages [0KB], 64KB chunk
> 
> for each md.
> 

Cool.... so who is giving us that EIO.  I'm guessing
end_that_request_first or .._last, but where is it getting to there
from?

What is you remove that last patch (so it still tries barrier writes)
but add this patch (so WARN_ON gives us a trace when it happens).

Thanks,
NeilBrown


Signed-off-by: Neil Brown <neilb@suse.de>

### Diffstat output
 ./drivers/md/md.c |    1 +
 1 file changed, 1 insertion(+)

diff .prev/drivers/md/md.c ./drivers/md/md.c
--- .prev/drivers/md/md.c	2006-07-01 12:12:14.000000000 +1000
+++ ./drivers/md/md.c	2006-07-01 22:00:57.000000000 +1000
@@ -412,6 +412,7 @@ static int super_written_barrier(struct 
 	if (bio->bi_size)
 		return 1;
 
+	WARN_ON(error);
 	if (!test_bit(BIO_UPTODATE, &bio->bi_flags) &&
 	    error == -EOPNOTSUPP) {
 		unsigned long flags;
