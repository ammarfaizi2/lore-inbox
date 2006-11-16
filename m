Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1424739AbWKPWSF@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1424739AbWKPWSF (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 16 Nov 2006 17:18:05 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1424741AbWKPWSF
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 16 Nov 2006 17:18:05 -0500
Received: from wx-out-0506.google.com ([66.249.82.224]:26721 "EHLO
	wx-out-0506.google.com") by vger.kernel.org with ESMTP
	id S1424738AbWKPWSB (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 16 Nov 2006 17:18:01 -0500
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=fxWJIx/kFTWISpWVFDc/ECqc69sydbTwZlyvr21cSme6ClbsYjzu4RV5dyluuYfOIXyWLNUtLIyWvfAKJFo5LCNDwkkI2iuVUdZq1ZJ2isbLkvIavCLkL6HpSrW+YzWun8jIdnArzGxTS8MqjDogw2lZMvEkPt5bNboWVeN+YO8=
Message-ID: <9a8748490611161418l4d5a773k76cf7061d73c8a51@mail.gmail.com>
Date: Thu, 16 Nov 2006 23:18:00 +0100
From: "Jesper Juhl" <jesper.juhl@gmail.com>
To: "David Chinner" <dgc@sgi.com>
Subject: Re: [PATCH][RFC][resend] potential NULL pointer deref in XFS on failed mount
Cc: linux-kernel@vger.kernel.org, xfs@oss.sgi.com, xfs-masters@oss.sgi.com,
       "Andrew Morton" <akpm@osdl.org>
In-Reply-To: <20061116220958.GE11034@melbourne.sgi.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
References: <200611162218.26945.jesper.juhl@gmail.com>
	 <20061116220958.GE11034@melbourne.sgi.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 16/11/06, David Chinner <dgc@sgi.com> wrote:
> On Thu, Nov 16, 2006 at 10:18:26PM +0100, Jesper Juhl wrote:
> > (got no reply on this when I originally send it on 20061031, so resending
> >  now that a bit of time has passed.  The patch still applies cleanly to
> >  Linus' git tree as of today.)
> >
> >
> > The Coverity checker spotted a potential problem in XFS.
> >
> > The problem is that if, in xfs_mount(), this code triggers:
> >
> >       ...
> >       if (!mp->m_logdev_targp)
> >               goto error0;
> >       ...
> >
> > Then we'll end up calling xfs_unmountfs_close() with a NULL
> > 'mp->m_logdev_targp'.
> > This in turn will result in a call to xfs_free_buftarg() with its 'btp'
> > argument == NULL. xfs_free_buftarg() dereferences 'btp' leading to
> > a NULL pointer dereference and crash.
>
> Interesting that coverity found that, but failed to find the other
> leaks in that function from exactly the same code and error
> case.....
>
> > I think this can happen, since the fatal call to xfs_free_buftarg()
> > happens when 'm_logdev_targp != m_ddev_targp' and due to a check of
> > 'm_ddev_targp' against NULL in xfs_mount() (and subsequent return if it is
> > NULL) the two will never both be NULL when we hit the error0 label from
> > the two lines cited above.
> >
> > Comments welcome (please keep me on Cc: on replies).
> >
> > Here's a proposed patch to fix this by testing 'btp' against NULL in
> > xfs_free_buftarg().
>
> Not the right fix - we should only be trying to free valid
> buftargs, which means xfs_unmountfs_close() is the correct
> place to fix this....
>

Ok.

> e.g:
>
> -       if (mp->m_logdev_targp != mp->m_ddev_targp)
> +       if (mp->m_logdev_targp && (mp->m_logdev_targp != mp->m_ddev_targp))
>
> As to the afore-mentioned leaks, if we fail to allocate a realtime
> buftarg, then we will leak a reference to both the rtdev and logdev,
> and if we fail to allocate an external log buftarg we'll leak a
> reference to the logdev. i.e., we fail to do one or both of:
>
>         xfs_blkdev_put(logdev);
>         xfs_blkdev_put(rtdev);
>
> To remove the bdev references we may have gained earlier. Normally,
> these references are released by xfs_free_buftarg(), but because we
> failed to allocate the buftarg, we can't drop the references via
> that method....
>

Thanks a lot for commenting Dave.

I don't have time to look more at this tonight or tomorrow, but I'll
try to cook up a proper fix covering all cases during the weekend.

-- 
Jesper Juhl <jesper.juhl@gmail.com>
Don't top-post  http://www.catb.org/~esr/jargon/html/T/top-post.html
Plain text mails only, please      http://www.expita.com/nomime.html
