Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S267121AbTGGRVx (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 7 Jul 2003 13:21:53 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267151AbTGGRVx
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 7 Jul 2003 13:21:53 -0400
Received: from 69-55-72-144.ppp.netsville.net ([69.55.72.144]:56756 "EHLO
	tiny.suse.com") by vger.kernel.org with ESMTP id S267121AbTGGRTu
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 7 Jul 2003 13:19:50 -0400
Subject: Re: [BUG] heavy disk access sometimes freezes 2.5.73-mm[123]
From: Chris Mason <mason@suse.com>
To: Thomas Schlichter <schlicht@uni-mannheim.de>, green@namesys.com
Cc: "Barry K. Nathan" <barryn@pobox.com>, Andrew Morton <akpm@osdl.org>,
       Nick Piggin <piggin@cyberone.com.au>, linux-kernel@vger.kernel.org
In-Reply-To: <200307071758.45702.schlicht@uni-mannheim.de>
References: <20030703090541.GB5044@ip68-101-124-193.oc.oc.cox.net>
	 <20030706193722.79352bc3.akpm@osdl.org>
	 <20030707033058.GA2860@ip68-4-255-84.oc.oc.cox.net>
	 <200307071758.45702.schlicht@uni-mannheim.de>
Content-Type: text/plain
Organization: 
Message-Id: <1057599193.20904.1352.camel@tiny.suse.com>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.2.2 
Date: 07 Jul 2003 13:33:13 -0400
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 2003-07-07 at 11:58, Thomas Schlichter wrote:
> On Monday 07 July 2003 05:30, Barry K. Nathan wrote:
> > On Sun, Jul 06, 2003 at 07:37:22PM -0700, Andrew Morton wrote:
> > > Nick Piggin <piggin@cyberone.com.au> wrote:
> > >
> > > Barry says the problem started with 2.5.73-mm1.  There was a reiserfs
> > > patch added in that kernel.
> > >
> > > Does a `patch -R' of this fix it up?
> >
> > [patch snipped]
> >
> > Yes, backing that patch out fixes it.
> 
> I had similar problems with my reiserfs root FS. For me backing out only the 
> second chunk of the patch made it, too. I've attached the patch I used for 
> that. If someone sees something really bad I'm doing with this please write, 
> because I'm playing with my root FS... ;-)

> diff -u linux-2.5.74-mm2/fs/reiserfs/tail_conversion.c.orig linux-2.5.74-mm2/fs/reiserfs/tail_conversion.c
> --- linux-2.5.74-mm2/fs/reiserfs/tail_conversion.c.orig	2003-06-23 09:26:10.000000000 -0700
> +++ linux-2.5.74-mm2/fs/reiserfs/tail_conversion.c	2003-06-23 09:26:10.000000000 -0700
> @@ -190,9 +190,6 @@ unmap_buffers(struct page *page, loff_t 
>          }
>  	bh = next ;
>        } while (bh != head) ;
> -      if ( PAGE_SIZE == bh->b_size ) {
> -	ClearPageDirty(page);
> -      }
>      }
>    } 
>  }

Heh, you read my mind.  It makes more sense for this hunk to be causing
problems than the first one.  Still we should be allowed to clear the
dirty bit since we've cleaned all the buffers on the page.

-chris


