Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S263246AbSLTRov>; Fri, 20 Dec 2002 12:44:51 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S263256AbSLTRov>; Fri, 20 Dec 2002 12:44:51 -0500
Received: from 12-231-249-244.client.attbi.com ([12.231.249.244]:61702 "HELO
	kroah.com") by vger.kernel.org with SMTP id <S263246AbSLTRou>;
	Fri, 20 Dec 2002 12:44:50 -0500
Date: Fri, 20 Dec 2002 09:49:52 -0800
From: Greg KH <greg@kroah.com>
To: lvm-devel@sistina.com, linux-kernel@vger.kernel.org
Subject: Re: [lvm-devel] [PATCH] add kobject to struct mapped_device
Message-ID: <20021220174952.GB12128@kroah.com>
References: <20021218184307.GA32190@kroah.com> <20021219105530.GA2003@reti> <20021220083149.GA10484@kroah.com> <20021220094447.GA1169@reti>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20021220094447.GA1169@reti>
User-Agent: Mutt/1.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Dec 20, 2002 at 09:44:47AM +0000, Joe Thornber wrote:
> On Fri, Dec 20, 2002 at 12:31:50AM -0800, Greg KH wrote:
> > Look reasonable?
> 
> Yes, it looks promising.  Some worries:
> 
> i) The 'status' and 'table' files do not contain a single value.
> Splitting it up into single values would be ungainly to say the least,
> eg.
> 
>   dm
>   |-- table
>       |-- target1
>       |   |-- sector_start
>       |   |-- sector_len
>       |   |-- target_type
>       |   `-- target args
>       |
>       |-- target2
>           |-- sector_start
> 
>   hmm ... maybe that's not too bad.

Yeah, it's not that bad, I'll look into it when I get to those files :)

> ii) If the table files are not split up then we have the problem that
>     they can be larger than a single page, which sysfs can't handle
>     (is this still true ?).

Yes, I think this is still true.  And it's also a good way to enforce
the "one value per file" rule :)

> iii) We need to be able to poll on the status file so that people can
>      block until there is a change of status.  eg, a snapshot uses up
>      another 5% of its COW storage, a mirror completes its initial
>      build, a path fails in the multipath target.

I saw that logic.  I don't think sysfs can handle poll right now, but we
could modify the last access/modify/change time when the status changes
so stat(2) can be used on the file.  This is how usbfs currently
notifies userspace of changes to their files.  Would this be acceptable?

> > Ok.  I can place all of the sysfs specific functions in dm.c, just like
> > drivers/block/genhd.c has, or if we place struct mapped_device into
> > dm.h, they can live in their own file.  Doesn't bother me either way.
> 
> Either put it in dm.c, or define some extra access functions (like
> dm_suspended() and dm_kdev()) to get the information you need.  I
> would prefer the latter, but we can always move things later.

Ok, will do.

thanks for your comments,

greg k-h
