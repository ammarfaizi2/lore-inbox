Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1945995AbWBOP4G@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1945995AbWBOP4G (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 15 Feb 2006 10:56:06 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1945996AbWBOP4G
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 15 Feb 2006 10:56:06 -0500
Received: from iriserv.iradimed.com ([69.44.168.233]:29856 "EHLO iradimed.com")
	by vger.kernel.org with ESMTP id S1945995AbWBOP4E (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 15 Feb 2006 10:56:04 -0500
Message-ID: <43F34ED5.8020306@cfl.rr.com>
Date: Wed, 15 Feb 2006 10:55:01 -0500
From: Phillip Susi <psusi@cfl.rr.com>
User-Agent: Thunderbird 1.5 (Windows/20051201)
MIME-Version: 1.0
To: Pekka Enberg <penberg@cs.helsinki.fi>
CC: Peter Osterlund <petero2@telia.com>, linux-kernel@vger.kernel.org,
       bfennema@falcon.csc.calpoly.edu, Christoph Hellwig <hch@lst.de>,
       Al Viro <viro@ftp.linux.org.uk>, Andrew Morton <akpm@osdl.org>
Subject: Re: [RFC][PATCH] UDF filesystem uid fix
References: <m3lkwg4f25.fsf@telia.com>  <84144f020602130149k72b8ebned89ff5719cdd0c2@mail.gmail.com>  <43F0B8FC.6020605@cfl.rr.com>  <Pine.LNX.4.58.0602140916230.15339@sbz-30.cs.Helsinki.FI>  <43F1FD39.1040900@cfl.rr.com> <84144f020602142331s756aff15o69d1d67f1b18127e@mail.gmail.com>
In-Reply-To: <84144f020602142331s756aff15o69d1d67f1b18127e@mail.gmail.com>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
X-OriginalArrivalTime: 15 Feb 2006 15:57:37.0521 (UTC) FILETIME=[8AD9EE10:01C63248]
X-TM-AS-Product-Ver: SMEX-7.2.0.1122-3.52.1006-14269.000
X-TM-AS-Result: No--17.340000-5.000000-31
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Pekka Enberg wrote:
> Reading mount man pages, the definition for uid/gid mount option for
> udf is "default user/group." I am pretty convinced that their original
> intent was to provide meaningful id for inodes that don't have one.
> Now what you're looking for sounds more like "mount whole filesystem
> as user/group" which is something different.
>   

Not quite, it's a bit of a compromise.  It only applies the id as a 
default for on disk inodes which don't have an id ( it is -1 ).  My 
patch just fixes it so that when writing IDs back to disk, it stores -1 
only in the case where the id matches the mount option.  If a file is 
owned by any other id, then that is what gets written to the disk. 

Generally speaking, this option is used to make sure that the desktop 
user has access to files on removable media which normally would have 
incorrect ownerships ( root ).  With this patch, the ownerships are 
maintained in the form the desktop user expects, which is to say, they 
own the files, not root or nobody. 
> The ownership changing to root thing is a bug caused by explicit
> memset() straight after we read the inode followed by flawed logic
> that forgets to set the uid. Your patch doesn't really fix that
> either, but it masks it. Unfortunately, now combining uid/git options
> with filesystem in which some inodes _have_ proper id yields to
> strange results. I don't see how it's reasonable for a filesystem to
> write invalid id on disk if I change the owner to myself even if I did
> use the mount options.
>
>   

What strange results?  If the filesystem has proper IDs on it they will 
be maintained.  The only case this patch effects is when the ID matches 
that given on the mount options, in which case, the user can not tell 
the difference; the file always looks like it is owned by him, unless 
you remount with a different mount option. 

If you create a file on the disk and you gave your id in the mount 
options, what difference does it make if the media gets a -1 written to 
it?  You still see the files as owned by you. 

> So I don't think your patch is a proper fix for the ownership changing
> to root bug, nor do I think it is sufficient to provide the "mount fs
> as user" thing (which does sound useful). Now if you want to change
> uid/gid option semantics to "mount fs as user", please explain why you
> don't think my case matters, that is using uid/gid to provide id for
> inodes that don't have one but still expecting chown to work?

IIRC, the file changed ownership to root because the existing code only 
saved the id to disk if it did NOT match the mount option.  I suppose I 
could have simply removed the test and always stored the id, but then 
the mount option would be meaningless.  Thus it seemed more logical to 
handle the other case, and store a value ( -1 ) such that when 
remounted, the mount option would have meaning.

Also, chown does still work.  If you chown a file to an id other than 
the one in the mount option, that id will be preserved on disk.  If you 
chown a file to the id in the mount option, then it will appear to work 
correctly, so long as you don't change the mount option.  If you do 
change the mount option, it is likely because you are logging in on 
another machine where your id is different, or you have given the disc 
to someone else and want them to be able to access it.  In that case, 
you will be treated as the same user, which is a desired result. 


In the general case, it would be nice to have two options; one that 
specifies defaults that only apply if there is no owner info, and 
another option that overrides any owner info that does exist.  In the 
specific case of removable media though, having an option to not bother 
storing ownerships is handy because most of the time, you don't care 
about that info and it just gets in the way. 


Maybe I should amend the patch to work like this:

uid/gid : specify default id when -1 is on disk
uid/gid = force : ignore ids on disk
uid/gid = [no]save : do [not] save actual id to disk ( save -1 instead )

Possibly with nosave being the default.  Would this be more acceptable?

I thought about doing this but decided to go with the simpler patch 
because I really can't think of any case where storing uids on removable 
media makes any kind of sense, and udf was made for removable media, and 
ubuntu at least, auto mounts removable media via hal and pmount with the 
uid/gid options already. 


