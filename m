Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S268963AbRIMLfJ>; Thu, 13 Sep 2001 07:35:09 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S269041AbRIMLeu>; Thu, 13 Sep 2001 07:34:50 -0400
Received: from atrey.karlin.mff.cuni.cz ([195.113.31.123]:40719 "EHLO
	atrey.karlin.mff.cuni.cz") by vger.kernel.org with ESMTP
	id <S268940AbRIMLem>; Thu, 13 Sep 2001 07:34:42 -0400
Date: Thu, 13 Sep 2001 13:34:57 +0200
From: Jan Kara <jack@suse.cz>
To: Anton Altaparmakov <aia21@cus.cam.ac.uk>
Cc: torvalds@transmeta.com, alan@lxorguk.ukuu.org.uk,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] NTFS fix for bug report
Message-ID: <20010913133457.M21408@atrey.karlin.mff.cuni.cz>
In-Reply-To: <E15gxDt-0005ZW-00@virgo.cus.cam.ac.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.3.15i
In-Reply-To: <E15gxDt-0005ZW-00@virgo.cus.cam.ac.uk>; from aia21@cus.cam.ac.uk on Wed, Sep 12, 2001 at 12:45:45AM +0100
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

  Hello,

> Please apply below patch. It should fix the reported hang on NTFS in Win2k
> together with a few more bugs I came across while tracking it down.
> 
> Patch is against 2.4.7-pre10 but it should apply cleanly to the latest
> -ac. (I haven't tested -ac but NTFS should be identical in both trees at
> the moment so it can#t go wrong... <famous last words>)
  Actually I've seen the hang in getdir_unsorted() in 2.4.9-ac10 on directories
larger than 4Kb on NT 4.0 drive. I'll try your patch and tell the result :).
BTW: when I was looking into the code (if I see some obvious reason for deadlock)
I found following chunk of code in inode.c in ntfs_readwrite_attr():
                /* Read uninitialized data. */
                if (offset >= attr->initialized)
                        return ntfs_read_zero(dest, l);
                if (offset + l > attr->initialized) {
                        dest->size = chunk = offset + l - attr->initialized;
                                             ^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^
shouldn't this rather be 'attr->initialized-offset'? It would make more sence
for me to call ntfs_readwrite_attr() from 'offset' to read initialized data
and then zero the rest...
                        error = ntfs_readwrite_attr(ino, attr, offset, dest);
                        if (error)
                                return error;
                        return ntfs_read_zero(dest, l - chunk);
                }

									Bye
										Honza
