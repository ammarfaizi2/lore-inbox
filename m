Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932307AbWHJXrq@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932307AbWHJXrq (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 10 Aug 2006 19:47:46 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932328AbWHJXrp
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 10 Aug 2006 19:47:45 -0400
Received: from nf-out-0910.google.com ([64.233.182.191]:59067 "EHLO
	nf-out-0910.google.com") by vger.kernel.org with ESMTP
	id S932307AbWHJXrp (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 10 Aug 2006 19:47:45 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=ZenzJPgCn7GO1S//MZDYPjX+ep3zA/DOOJa6rcuEh4AaiMyRlVXOvUFjp5gEPmjJ8F7pLAm31jAgqZCrZDFTkR/fhfUc1hTmaltUd0z5MO76WD1HiftTJF9gCGecwdIsGhQl9wHNKPebqhF7lN1KHw1qVn4oNYiN8J/89tdA7VY=
Message-ID: <9a8748490608101647l4f51e761o6dc1f703c9d012b2@mail.gmail.com>
Date: Fri, 11 Aug 2006 01:47:43 +0200
From: "Jesper Juhl" <jesper.juhl@gmail.com>
To: "Nathan Scott" <nathans@sgi.com>
Subject: Re: XFS warning in 2.6.18-rc4
Cc: "Meelis Roos" <mroos@linux.ee>,
       "Linux Kernel list" <linux-kernel@vger.kernel.org>
In-Reply-To: <20060810085616.C2581413@wobbly.melbourne.sgi.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
References: <Pine.SOC.4.61.0608092303570.27011@math.ut.ee>
	 <20060810085616.C2581413@wobbly.melbourne.sgi.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 10/08/06, Nathan Scott <nathans@sgi.com> wrote:
> On Wed, Aug 09, 2006 at 11:04:53PM +0300, Meelis Roos wrote:
> > fs/xfs/xfs_bmap.c: In function 'xfs_bmapi':
> > fs/xfs/xfs_bmap.c:2662: warning: 'rtx' is used uninitialized in this function
>
> You have a particularly dense compiler, unfortunately.  This code
> has always been this way, its just a false cc warning that can be
> safely ignored until you upgrade to a fixed compiler (unless I'm
> missing something - please enlighten me if so).  It does seem to
> be the case that there is no way 'rtx' will be used uninitialised
> when xfs_rtpick_extent() doesn't fail... no?
>
Ok, I may be reading something wrong here, but I think the warning is
actually not correct.

In fs/xfs/xfs_rtalloc.c::xfs_rtpick_extent() there is this code :

...
        if ((error = xfs_trans_iget(mp, tp, mp->m_sb.sb_rbmino, 0,
                                        XFS_ILOCK_EXCL, &ip)))
                return error;
...
before anything even touches 'pick' (which is the last argument of
type "xfs_rtblock_t  *" which is what "&rtx" is being passed to that
function as, from fs/xfs/xfs_bmap.c::xfs_bmap_rtalloc() at line 2659
before 'rtx' then used at line 2662.

Look at this block of code from fs/xfs/xfs_bmap.c::xfs_bmap_rtalloc()  :

...
 2658:       if (ap->eof && ap->off == 0) {
 2659:                error = xfs_rtpick_extent(mp, ap->tp, ralen, &rtx);
 2660:                if (error)
 2661:                        return error;
 2662:                ap->rval = rtx * mp->m_sb.sb_rextsize;
 2663:        } else {
 2664:                ap->rval = 0;
 2665:        }
..

'rtx' has not been initialized in this function before this block of code.
If the call to xfs_rtpick_extent() should happen to fail from the
check quoted above, then 'rtx' will in fact be used uninitialized in
line 2662 - except that will never happen, because if the check in In
fs/xfs/xfs_rtalloc.c::xfs_rtpick_extent() fails then error will be !=
0 and then well never get down to line 2662.

Or am I missing something ?


PS. Above line numbers etc are from 2.6.18-rc4.


-- 
Jesper Juhl <jesper.juhl@gmail.com>
Don't top-post  http://www.catb.org/~esr/jargon/html/T/top-post.html
Plain text mails only, please      http://www.expita.com/nomime.html
