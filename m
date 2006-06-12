Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750736AbWFLBMv@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750736AbWFLBMv (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 11 Jun 2006 21:12:51 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750777AbWFLBMv
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 11 Jun 2006 21:12:51 -0400
Received: from smtp.ustc.edu.cn ([202.38.64.16]:61925 "HELO ustc.edu.cn")
	by vger.kernel.org with SMTP id S1750736AbWFLBMu (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 11 Jun 2006 21:12:50 -0400
Message-ID: <350074764.23563@ustc.edu.cn>
X-EYOUMAIL-SMTPAUTH: wfg@mail.ustc.edu.cn
Date: Mon, 12 Jun 2006 09:12:45 +0800
From: Wu Fengguang <wfg@mail.ustc.edu.cn>
To: Michael Tokarev <mjt@tls.msk.ru>
Cc: Ingo Oeser <ioe-lkml@rameria.de>, Andrew Morton <akpm@osdl.org>,
       linux-kernel@vger.kernel.org, Jens Axboe <axboe@suse.de>
Subject: Re: [PATCH 4/5] readahead: backoff on I/O error
Message-ID: <20060612011245.GA5214@mail.ustc.edu.cn>
Mail-Followup-To: Wu Fengguang <wfg@mail.ustc.edu.cn>,
	Michael Tokarev <mjt@tls.msk.ru>, Ingo Oeser <ioe-lkml@rameria.de>,
	Andrew Morton <akpm@osdl.org>, linux-kernel@vger.kernel.org,
	Jens Axboe <axboe@suse.de>
References: <20060609080801.741901069@localhost.localdomain> <349840680.03819@ustc.edu.cn> <200606102033.46844.ioe-lkml@rameria.de> <448B221D.3080907@tls.msk.ru>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <448B221D.3080907@tls.msk.ru>
User-Agent: Mutt/1.5.11+cvs20060126
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Ingo and Michael,

On Sat, Jun 10, 2006 at 11:48:45PM +0400, Michael Tokarev wrote:
> Ingo Oeser wrote:
> >> Backoff readahead size exponentially on I/O error.
> >  
> >> With this patch, retries are expected to be reduced from, say, 256, to 5.
> >  
> > 1. Would you mind to push this patch to -stable?
> > 
> > Reason: If killing a drive was hit in the field, this should be critical 
> > 	enough.
> 

Andrew:
I was a bit afraid about that because I have no CDROM to try it out.
But since Michael has tested it OK, it should be OK for the stable kernel.

> > 2. Could you disable (at least optionally) read ahead complety 
> >   on the first IO error?
> > 
> > Reason: In a data recovery situation (hitting EIO quite often, 
> > 	but not really sequentially) readahead is counter productive.
> > 	E.g. trying to save an old CD with the cdparanoia software.

Should be ok. I have no experience on it. So Michael and users with
the taste have the last word :)

It might also be helpful to generate some uevent for it. User land
tools can then run blockdev --setra in a configurable way.

> I'm thinking about all this again.. well.  Read-ahead is definitely
> very useful on a CD (I'm referring to all optical media here, be it
> DVD, or BlueRay, or whatever; floppies too, but there it's less useful
> due to speed of the whole thing) - I mean, say, DVDs are played more
> smoothly if readahead is enabled; a "live CD" distro will be more
> responsive if readahead is enabled, and so on - the effect of RA is
> trivially visible.
> 
> But still, for a scratched CD, it might be a good idea to turn RA off
> while playing it, completely - by means of, eg, blockdev --setra 0,
> or something like that.  Yes not many (end)users know this tool, yes
> it's privileged (oh well), but it helps.
> 
> Why I recall --setra is: when kernel will start reducing RA by its
> own, next question will be "why my CD is too slow?" -- after playing
> a scratched CD, you insert another one, and RA is *still* zero...
> 
> So I'm not really sure how simple the solution should be.

The patch operates on a per-fd basis. Thus the readahead size will not
be affected for other files and CDs. The readahead size also restores
on reopening the file :) 

Thanks,
Wu
