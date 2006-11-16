Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1424656AbWKPVnk@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1424656AbWKPVnk (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 16 Nov 2006 16:43:40 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1424663AbWKPVnk
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 16 Nov 2006 16:43:40 -0500
Received: from nz-out-0102.google.com ([64.233.162.192]:12725 "EHLO
	nz-out-0102.google.com") by vger.kernel.org with ESMTP
	id S1424656AbWKPVnj (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 16 Nov 2006 16:43:39 -0500
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=Oc9U+mzCxNnQNTNa34Ck9QeleDP2YzpCqltybwM7JK8YMR1YEtOTOQghRhw/nq/hthw1YX4PUfmyNLtgBUmXFj258p6y8DCpL58Py//1xpuuwm0xprCCROI5ciSmF51JecNF552ZawUOpma80+lCMwKy/aUbbB+rkVsBo30T9HI=
Message-ID: <9a8748490611161343x44e759acs9b70247c84452ba5@mail.gmail.com>
Date: Thu, 16 Nov 2006 22:43:36 +0100
From: "Jesper Juhl" <jesper.juhl@gmail.com>
To: "Shailendra Tripathi" <stripathi@agami.com>
Subject: Re: [PATCH][RFC][resend] potential NULL pointer deref in XFS on failed mount
Cc: linux-kernel@vger.kernel.org, xfs@oss.sgi.com, xfs-masters@oss.sgi.com,
       nathans@sgi.com, "Andrew Morton" <akpm@osdl.org>
In-Reply-To: <455CD6C8.5030907@agami.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
References: <200611162218.26945.jesper.juhl@gmail.com>
	 <455CD6C8.5030907@agami.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 16/11/06, Shailendra Tripathi <stripathi@agami.com> wrote:
> Hey Jesper,
>                 Rather,  it can be done as below. Nothing to say that
> your code wouldn't work. Just that catch it early, so that potential
> function call overhead to call xfs_free_buftarg can be avoided.
>
Hi Shailendra,

The reason I want to fix it in the freeing function is that many other
functions in the kernel that free resources are safe to call with NULL
pointers and this would make xfs_free_buftarg() follow that
convention.  This would perhaps also allow for some cleanups in other
places that call the function since then there's no longer a need for
explicit NULL checks any more (haven't checked if there's anything to
gain there though).
I don't think the function call overhead matters much since this is in
a case of a failed mount, so it should happen very rarely.

> void
> xfs_unmountfs_close(xfs_mount_t *mp, struct cred *cr)
> {
>        if (mp->m_logdev_targp && (mp->m_logdev_targp != mp->m_ddev_targp))
>                 xfs_free_buftarg(mp->m_logdev_targp, 1);
>         if (mp->m_rtdev_targp)
>                 xfs_free_buftarg(mp->m_rtdev_targp, 1);
>         xfs_free_buftarg(mp->m_ddev_targp, 0);
> }
>


-- 
Jesper Juhl <jesper.juhl@gmail.com>
Don't top-post  http://www.catb.org/~esr/jargon/html/T/top-post.html
Plain text mails only, please      http://www.expita.com/nomime.html
