Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751123AbWANVTf@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751123AbWANVTf (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 14 Jan 2006 16:19:35 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751279AbWANVTf
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 14 Jan 2006 16:19:35 -0500
Received: from atrey.karlin.mff.cuni.cz ([195.113.31.123]:16068 "EHLO
	atrey.karlin.mff.cuni.cz") by vger.kernel.org with ESMTP
	id S1751123AbWANVTe (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 14 Jan 2006 16:19:34 -0500
Date: Sat, 14 Jan 2006 22:19:33 +0100
From: Jan Kara <jack@suse.cz>
To: Valdis.Kletnieks@vt.edu
Cc: Andrew Morton <akpm@osdl.org>, linux-kernel@vger.kernel.org
Subject: Re: 2.6.15-mm3 - disk quotas apparently busticated..
Message-ID: <20060114211933.GC21901@atrey.karlin.mff.cuni.cz>
References: <200601122116.k0CLGaiO005357@turing-police.cc.vt.edu>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200601122116.k0CLGaiO005357@turing-police.cc.vt.edu>
User-Agent: Mutt/1.5.9i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

  Hello,

> Disk quotas have been functioning for me for quite a while (including 2.6.15 and
> 2.6.15-rc*-mm* - haven't tried 15-mm1 or 15-mm2 yet).
> 
> Under the 2.6.15-mm3 kernel, 'quotaon /home' (or any other ext3 filesystem
> that had functional quotas on it fails:
> 
> # quotaon /home
> quotaon: using /home/aquota.group on /dev/mapper/rootvg-home [/home]: Invalid argument
> quotaon: Maybe create new quota files with quotacheck(8)?
> quotaon: using /home/aquota.user on /dev/mapper/rootvg-home [/home]: Invalid argument
> quotaon: Maybe create new quota files with quotacheck(8)?
> # quotacheck -u -g -m /home
> # quotaon /home
> quotaon: using /home/aquota.group on /dev/mapper/rootvg-home [/home]: Invalid argument
> quotaon: Maybe create new quota files with quotacheck(8)?
> quotaon: using /home/aquota.user on /dev/mapper/rootvg-home [/home]: Invalid argument
> quotaon: Maybe create new quota files with quotacheck(8)?
> 
> Using quota-3.13.
> 
> Poking with strace finds:
> ...
> quotactl(Q_QUOTAON|GRPQUOTA, "/dev/mapper/rootvg-home", 2, {8169863311701010479, 8030594534456192885, 141733949557, 8097873655606109231, 8390047167027504496, 28549297904379766, 1309965025280, 13254570172929388888}) = -1 EINVAL (Invalid argument)
> ...
> quotactl(Q_QUOTAON|USRQUOTA, "/dev/mapper/rootvg-home", 2, {8169863311701010479, 7310315462216413045, 141733920882, 8097873655606109231, 8390047167027504496, 28549297904379766, 210453397504, 7018986666877744431}) = -1 EINVAL (Invalid argument)
> 
> And the following corresponding cryptic messages in dmesg:
> 
> [ 1833.288000] failed read
> [ 1833.332000] failed read
> 
> (which is why I just submitted a patch to fs/quota_v2.c)
  Yes, thanks for that.

> Further digging based on the info from that patch implicates ext3_quota_read()
> (which itself seems potentially buggy - it has code that says:
> 
>                 bh = ext3_bread(NULL, inode, blk, 0, &err);
>                 if (err)
>                         return err;
> 
> which is returning 1 in my case.  Good thing that ext3_get_blocks_handle()
> (which eventually gets called) can't return 8....
> 
> It's getting down to fs/ext3/inode.c ext3_getblk() and this code:
> 
>         *errp = ext3_get_blocks_handle(handle, inode, block, 1, &dummy, create, 1);
>         if ((*errp == 1 ) && buffer_mapped(&dummy)) {
> 
> which sets *errp to 1. We then enter a 40-line block, which can return a valid
> struct buffer_head, but never set another value into *errp.
> 
> Bug/question: Should that big 'if' statement reset *errp if things work out OK?
> 
> --- inode.c     2006-01-12 13:35:44.000000000 -0500
> +++ inode.c.temp        2006-01-12 16:13:44.000000000 -0500
> @@ -1048,14 +1048,16 @@
>                 } else {
>                         BUFFER_TRACE(bh, "not a new buffer");
>                 }
>                 if (fatal) {
>                         *errp = fatal;
>                         brelse(bh);
>                         bh = NULL;
> +               } else {
> +                       *errp = 0;
>                 }
>                 return bh;
>         }
>  err:
>         return NULL;
>  }
  Yup, that patch seems to be correct. I'm not sure if Andrew has picked
up the patch as it is missing Signed-off-by and also directory of the
file being patched (see Documentation/SubmittingPatches for general
guidelines). So if Andrew has not responded yet, regenerate the patch
and send it to him please. Thanks for the fix.

								Honza
-- 
Jan Kara <jack@suse.cz>
SuSE CR Labs
