Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S316635AbSEVSR5>; Wed, 22 May 2002 14:17:57 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S316640AbSEVSR4>; Wed, 22 May 2002 14:17:56 -0400
Received: from atrey.karlin.mff.cuni.cz ([195.113.31.123]:28934 "EHLO
	atrey.karlin.mff.cuni.cz") by vger.kernel.org with ESMTP
	id <S316635AbSEVSRv>; Wed, 22 May 2002 14:17:51 -0400
Date: Wed, 22 May 2002 20:17:53 +0200
From: Jan Kara <jack@suse.cz>
To: Martin Dalecki <dalecki@evision-ventures.com>
Cc: Jan Kara <jack@suse.cz>, Linus Torvalds <torvalds@transmeta.com>,
        Russell King <rmk@arm.linux.org.uk>,
        Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: Linux-2.5.17
Message-ID: <20020522181753.GE24755@atrey.karlin.mff.cuni.cz>
In-Reply-To: <Pine.LNX.4.44.0205220901430.7580-100000@home.transmeta.com> <3CEBB385.5040904@evision-ventures.com> <20020522165834.GD12982@atrey.karlin.mff.cuni.cz> <3CEBC29B.2050601@evision-ventures.com> <20020522175636.GB24755@atrey.karlin.mff.cuni.cz> <3CEBCDCA.8030905@evision-ventures.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.3.27i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> Uz.ytkownik Jan Kara napisa?:
> >>Uz.ytkownik Jan Kara napisa?:
> >>
> >>>>Uz.ytkownik Linus Torvalds napisa?:
> >>>>
> >>>>
> >>>>>On Wed, 22 May 2002, Russell King wrote:
> >>>>>
> >>>>>
> >>>>>
> >>>>>>/proc/sys has a clean and clear purpose.
> >>>>>
> >>>>>
> >>>>>Yes, but it _:would_ be good to make the quota stuff use the existign
> >>>>>helper functions to make it much cleaner.
> >>>>>
> >>>>>And some of those helper functions are definitely from sysctl's: 
> >>>>>splitting
> >>>>>up the quota file into multiple sysctls (_and_ moving it to 
> >>>>>/proc/sys/fs)
> >>>>>sounds like a good idea to me.
> >>>>
> >>>>Well I'm actually coding this right now :-).
> >>>
> >>>Thanks. I'll update quota tools to use your new files if you send me
> >>>new layout of interface...
> >>
> >>I'm not ready right now but...
> >>Well actually I went the cheapest way possible:
> >>
> >>
> >>Here is the layout of the /proc/sys/fs/dquotas array:
> >>
> >>/*
> >>* Statistics about disc quota.
> >>*/
> >>enum {
> >>	DQSTATS_LOOKUPS,
> >>	DQSTATS_DROPS,
> >>	DQSTATS_READS,
> >>	DQSTATS_WRITES,
> >>	DQSTATS_CACHE_HITS,
> >>	DQSTATS_ALLOCATED, // formerly known as nr_dquts inside kernel.
> >>	DQSTATS_FREE,       // formerly known as nr_free_dquots inside 
> >>	kernel.
> >>	DQSTATS_SYNCS,
> >>	DQSTATS_SIZE
> >>};
> >>
> >>extern __u32 dqstats_array[DQSTATS_SIZE];
> >>
> >>And here is the allocated sysctl id number:
> >>
> >>	FS_DQSTATS=16,	/* int: disc quota suage statistics *
> >>
> >>All of this appears under:
> >>
> >>static ctl_table fs_table[] = {
> >>	{FS_DQSTATS, "dqstats", dqstats_array, sizeof(dqstats_array), 0444, 
> >>	NULL, &proc_dointvec},
> >>	{},
> >>};
> >>
> >>inside /proc/sys/fs/dqstats
> >>
> >>I dodn't think the particular fields are subject to change soon
> >>so I wen't for the array.
> >>If yes - please feel rather free to complain :-).
> >>Switch over to sysctl() and see the client code
> >>melting down :-).
> >
> >  The array is OK (I don't expect any changes in statistics too).
> >I'd just like to have that 'version' and 'formats' fields somewhere.
> >Otherwise it's rather hard for quota tools to recognize quota
> >interface...
> 
> You have the sysctl id number for this purpose and the /proc/sys/fs file
> name is right now unique. So there is no need for more
> treatment here then just trying to stick to what we get once it's there.
> The versioning of syscall returns I will just preserve.
> 
> Going through sysctl *will be much easier* in code
> then fs lookup of the file above.
  OK. You convinced me that 'version' isn't needed. But how about
'formats'? Currently quotaon(8) uses this field to check which format it
should try to turn on... I can live without it as quotaon(8) might try
new format and if it doesn't succeed it will try the old one but
anyway...

							Honza
-- 
Jan Kara <jack@suse.cz>
SuSE CR Labs
