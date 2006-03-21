Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751756AbWCUOzq@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751756AbWCUOzq (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 21 Mar 2006 09:55:46 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751751AbWCUOzq
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 21 Mar 2006 09:55:46 -0500
Received: from village.ehouse.ru ([193.111.92.18]:28175 "EHLO mail.ehouse.ru")
	by vger.kernel.org with ESMTP id S1751755AbWCUOzq (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 21 Mar 2006 09:55:46 -0500
From: "Alexander Y. Fomichev" <gluk@php4.ru>
Reply-To: "Alexander Y. Fomichev" <gluk@php4.ru>
To: David Chinner <dgc@sgi.com>
Subject: Re: xfs cluster rewrites is broken?
Date: Tue, 21 Mar 2006 17:55:35 +0300
User-Agent: KMail/1.9.1
Cc: linux-kernel@vger.kernel.org, admin@list.net.ru
References: <200603171532.04385.gluk@php4.ru> <20060320000553.GY1173973@melbourne.sgi.com>
In-Reply-To: <20060320000553.GY1173973@melbourne.sgi.com>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200603211755.35373.gluk@php4.ru>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Monday 20 March 2006 03:05, David Chinner wrote:
> Hi Alexander,
>
> On Fri, Mar 17, 2006 at 03:32:03PM +0300, Alexander Y. Fomichev wrote:
> > Hello,
> >
> > Two days ago i've try 2.6.16-rc5 on 2-way dual-core Opteron server
> > and faced with a strange system behaviour.
>
> .....
>
> >     [XFS] cluster rewrites      We can cluster mapped pages aswell, this
> > improves
> >     performances on rewrites since we can reduce the number of allocator
> >     calls.
>
> FYI, prior to this mod, XFS never clustered rewrites, so it's not
> surprising that this particular issue has only recently come to light.
>
> > diff -urN a/fs/xfs/linux-2.6/xfs_aops.c b/fs/xfs/linux-2.6/xfs_aops.c
> > --- a/fs/xfs/linux-2.6/xfs_aops.c	2006-03-17 13:13:53.000000000 +0300
> > +++ b/fs/xfs/linux-2.6/xfs_aops.c	2006-03-17 15:12:12.000000000 +0300
> > @@ -616,8 +616,6 @@
> >  				acceptable = (type == IOMAP_UNWRITTEN);
> >  			else if (buffer_delay(bh))
> >  				acceptable = (type == IOMAP_DELAY);
> > -			else if (buffer_mapped(bh))
> > -				acceptable = (type == 0);
> >  			else
> >  				break;
> >  		} while ((bh = bh->b_this_page) != head);
>
> Well, that switches off rewrite clustering altogether, so it's
> not surprising that it fixed your problem. It also points out the
> problem as well - we don't every check if the buffer is dirty before
> declaring that the page is acceptible for write clustering.
>
> The other cases checked here (buffer_unwritten() and buffer_delay())
> are, by defintition, dirty buffers and so they only ever cluster
> dirty pages. buffer_mapped(), OTOH, could be clean or dirty.....
>
> Can you try the patch below, and see if that fixes the problem
> you are seeing?
>
> Cheers,
>
> Dave.

Yes, it works as expected. Thank you very mach for quick answer and
clarification.

-- 
Best regards.
        Alexander Y. Fomichev <gluk@php4.ru>
        Public PGP key: http://sysadminday.org.ru/gluk.asc
