Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S271694AbRIMNqt>; Thu, 13 Sep 2001 09:46:49 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S271697AbRIMNqj>; Thu, 13 Sep 2001 09:46:39 -0400
Received: from orange.csi.cam.ac.uk ([131.111.8.77]:39139 "EHLO
	orange.csi.cam.ac.uk") by vger.kernel.org with ESMTP
	id <S271694AbRIMNq1>; Thu, 13 Sep 2001 09:46:27 -0400
Message-Id: <5.1.0.14.2.20010913141429.00a76560@pop.cus.cam.ac.uk>
X-Mailer: QUALCOMM Windows Eudora Version 5.1
Date: Thu, 13 Sep 2001 14:46:26 +0100
To: Jan Kara <jack@suse.cz>
From: Anton Altaparmakov <aia21@cam.ac.uk>
Subject: Re: [PATCH] NTFS fix for bug report
Cc: Anton Altaparmakov <aia21@cus.cam.ac.uk>, torvalds@transmeta.com,
        alan@lxorguk.ukuu.org.uk, linux-kernel@vger.kernel.org
In-Reply-To: <20010913133457.M21408@atrey.karlin.mff.cuni.cz>
In-Reply-To: <E15gxDt-0005ZW-00@virgo.cus.cam.ac.uk>
 <E15gxDt-0005ZW-00@virgo.cus.cam.ac.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"; format=flowed
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

At 12:34 13/09/01, Jan Kara wrote:
> > Please apply below patch. It should fix the reported hang on NTFS in Win2k
> > together with a few more bugs I came across while tracking it down.
> >
> > Patch is against 2.4.7-pre10 but it should apply cleanly to the latest
> > -ac. (I haven't tested -ac but NTFS should be identical in both trees at
> > the moment so it can#t go wrong... <famous last words>)
>   Actually I've seen the hang in getdir_unsorted() in 2.4.9-ac10 on 
> directories larger than 4Kb on NT 4.0 drive. I'll try your patch and tell 
> the result :).

Yes, that would be expected. It's just that NT 4.0 doesn't allow creation 
of volumes with > 4kiB cluster size unless you use a third party tool, like 
my mkntfs for example, or partition magic or whatever... (-;

I can tell you already that Wayne Brown, who reported the lockup bug told 
me that the patch fixed it. Also, I was able to reproduce the bug and the 
patch fixed it for me as well.

Further, Richard Russon gave the driver + my patch a very heavy beating 
with up to 200 parallel processes doing cat, stat, find, and du and the 
driver remained rock solid. (-:

Now I just need a volunteer who has SMP hardware and Windows NT/2k/XP 
partition to try it on SMP. My SMP motherboard unfortunately converted 
itself into a very expensive paperweight two nights ago. )-: And the 
replacement is going to be non-SMP for cost reasons...

>BTW: when I was looking into the code (if I see some obvious reason for 
>deadlock) I found following chunk of code in inode.c in ntfs_readwrite_attr():
>                 /* Read uninitialized data. */
>                 if (offset >= attr->initialized)
>                         return ntfs_read_zero(dest, l);
>                 if (offset + l > attr->initialized) {
>                         dest->size = chunk = offset + l - attr->initialized;
>                                              ^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^
>shouldn't this rather be 'attr->initialized-offset'? It would make more 
>sence for me to call ntfs_readwrite_attr() from 'offset' to read 
>initialized data and then zero the rest...
>                         error = ntfs_readwrite_attr(ino, attr, offset, dest);
>                         if (error)
>                                 return error;
>                         return ntfs_read_zero(dest, l - chunk);
>                 }

Yes, you are right that there is a problem.

We check for overflowing initialized data and if we are doing so, we set 
the amount to read down to the initialized amount, which is as you say 
attr->initialized - offset.

We then call ourselves to do the read and when we return without error 
dest->size is the number of bytes actually read. That must be equal to 
chunk, the number of bytes we expected to read.

Succeeding that we need to read in l - chunk worth of zeros and update the 
number of read bytes accordingly otherwise we return error. This means the 
above code fragment should actually be:

if (offset >= attr->initialized)
         return ntfs_read_zero(dest, l);
if (offset + l > attr->initialized) {
         dest->size = chunk = attr->initialized - offset;
         err = ntfs_readwrite_attr(ino, attr, offset, dest);
         if (err || (dest->size != chunk && (err = -EIO, 1)))
                 return err;
         dest->size += l - chunk;
         return ntfs_read_zero(dest, l - chunk);
}

Thanks for pointing the problem out. I will fix it in my tree and submit 
with the next release. It's not very critical and I need to make sure the 
rest of the driver can cope with the fact the dest->size will now be setup 
differently. I am not convinced it is safe, we might be relying on a 
smaller dest->size in some parts...

This is a perfect example of why NTFS has so many bugs... If you read dir.c 
for example in pretty much every function when you look closely enough you 
find this kind of subtle bugs all over the place. Sometimes it's just that 
the wrong offset or the wrong sized variable is read/written, sometimes 
it's the size being set wrong, sometimes it's setting a memory buffer, then 
freeing it and then trying to use it, etc... )-: And this is very 
complicated to fix up because there are so many hidden interactions between 
structure members. For example one function will setup something in 
walk->... then a different function later on will look at that and do 
something. Now if the first function sets that particular walk member wrong 
the second function even if it looks correct will do something wrong...

For example when cleaning up readwrite_attr and the other attribute writing 
functions, I had to spend a lot of time finding exactly what part of the 
attribute sizes are updated where and when and by the time I had a full 
picture of what was going on I also had a long list of bugs that needed 
fixing. - I have now attacked directory handling, reading should now be 
fine with the last patch, but writing is proving to be absolutely mad. )-: 
I am tempted to delete it all and write from scratch at the moment but I 
will stare at it a it longer before I give up on it for good...

Thanks for your input.

Best regards,

Anton


-- 
   "Nothing succeeds like success." - Alexandre Dumas
-- 
Anton Altaparmakov <aia21 at cam.ac.uk> (replace at with @)
Linux NTFS Maintainer / WWW: http://linux-ntfs.sf.net/
ICQ: 8561279 / WWW: http://www-stu.christs.cam.ac.uk/~aia21/

