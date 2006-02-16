Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932152AbWBPTAV@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932152AbWBPTAV (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 16 Feb 2006 14:00:21 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932175AbWBPTAV
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 16 Feb 2006 14:00:21 -0500
Received: from e32.co.us.ibm.com ([32.97.110.150]:1960 "EHLO e32.co.us.ibm.com")
	by vger.kernel.org with ESMTP id S932152AbWBPTAU (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 16 Feb 2006 14:00:20 -0500
Subject: Re: fsck: i_blocks is xxx should be yyy on ext3
From: Mingming Cao <cmm@us.ibm.com>
Reply-To: cmm@us.ibm.com
To: Helge Hafting <helge.hafting@aitel.hist.no>
Cc: Andrew Morton <akpm@osdl.org>, linux-kernel@vger.kernel.org
In-Reply-To: <43F42DFC.4080604@aitel.hist.no>
References: <43EA079A.4010108@aitel.hist.no>
	 <20060208225359.426573cf.akpm@osdl.org>
	 <1140050679.20936.14.camel@dyn9047017067.beaverton.ibm.com>
	 <43F42DFC.4080604@aitel.hist.no>
Content-Type: text/plain
Organization: IBM LTC
Date: Thu, 16 Feb 2006 11:00:17 -0800
Message-Id: <1140116417.3757.11.camel@dyn9047017067.beaverton.ibm.com>
Mime-Version: 1.0
X-Mailer: Evolution 2.0.4 (2.0.4-7) 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 2006-02-16 at 08:47 +0100, Helge Hafting wrote:
> Mingming Cao wrote:
> 
> >On Wed, 2006-02-08 at 22:53 -0800, Andrew Morton wrote:
> >  
> >
> >>Helge Hafting <helge.hafting@aitel.hist.no> wrote:
> >>    
> >>
> >>> Today I rebooted into 2.6.16-rc2-mm1.  Fsck checked a "clean" ext3 fs,
> >>> because it was many mounts since the last time.
> >>>
> >>> I have seen that many times, but this time I got a lot of
> >>> "i_blocks is xxx, should be yyy fix?"
> >>>
> >>> In all cases, the blocks were fixed to a lower number.
> >>>      
> >>>
> >>Yes, thanks.  It's due to the ext3_getblocks() patches in -mm.  I can't
> >>think of any actual harm which it'll cause.
> >>
> >>To reproduce:
> >>
> >>mkfs
> >>mount
> >>dbench 32
> >><wait 20 seconds>
> >>killall dbench
> >>umount
> >>fsck
> >>-
> >>    
> >>
> >
> >Sorry about the late response.  I failed to reproduce the problem with
> >above instructions. I am running 2.6.16-rc2-mm1 kernel, played dbench
> >32 ,64 and 128, and tried both 8 cpu and 1 cpu, still no luck at last. I
> >am using e2fsck version 1.35 though. What versions you are using?
> >  
> >
> single cpu, e2fsck 1.39-WIP (31-Dec-2005)
>         Using EXT2FS Library version 1.39-WIP, 31-Dec-2005
> 
> I didn't use dbench, only normal use of the machine.
> 
> Helge Hafting
> 
> 

I was able to constantly reproduce this problem on another machine with
1 cpu, and find the bug.  

In the ext3_new_blocks() code, if the # of allocated blocks (num) is
less than the requested # of blocks to allocate (*count), we will need
to free some quota via DQUOT_FREE_BLOCK(), which will eventually adjust
i_blocks value properly. the delta value *count-num is wrong, as we re-
set the *count too early.


The patch seems fixed the bug on my machine, could you please give it a
try?

Thanks.


 linux-2.6.15-cmm/fs/ext3/balloc.c |    2 +-
 1 files changed, 1 insertion(+), 1 deletion(-)

diff -puN fs/ext3/balloc.c~ext3-getblocks-i_blocks-fix fs/ext3/balloc.c
--- linux-2.6.15/fs/ext3/balloc.c~ext3-getblocks-i_blocks-fix
2006-02-16 10:19:23.000000000 -0800
+++ linux-2.6.15-cmm/fs/ext3/balloc.c   2006-02-16 10:19:49.000000000
-0800
@@ -1441,8 +1441,8 @@ allocated:

        *errp = 0;
        brelse(bitmap_bh);
-       *count = num;
        DQUOT_FREE_BLOCK(inode, *count-num);
+       *count = num;
        return ret_block;

 io_error:



