Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262304AbUC1Ryv (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 28 Mar 2004 12:54:51 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262269AbUC1Ryv
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 28 Mar 2004 12:54:51 -0500
Received: from ns.virtualhost.dk ([195.184.98.160]:25288 "EHLO virtualhost.dk")
	by vger.kernel.org with ESMTP id S262236AbUC1Ryl (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 28 Mar 2004 12:54:41 -0500
Date: Sun, 28 Mar 2004 19:54:36 +0200
From: Jens Axboe <axboe@suse.de>
To: Jeff Garzik <jgarzik@pobox.com>
Cc: Nick Piggin <nickpiggin@yahoo.com.au>, linux-ide@vger.kernel.org,
       Linux Kernel <linux-kernel@vger.kernel.org>,
       Andrew Morton <akpm@osdl.org>
Subject: Re: [PATCH] speed up SATA
Message-ID: <20040328175436.GL24370@suse.de>
References: <4066021A.20308@pobox.com> <40661049.1050004@yahoo.com.au> <406611CA.3050804@pobox.com> <406612AA.1090406@yahoo.com.au> <4066156F.1000805@pobox.com> <20040328141014.GE24370@suse.de> <40670BD9.9020707@pobox.com> <20040328173508.GI24370@suse.de> <40670FDB.6080409@pobox.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <40670FDB.6080409@pobox.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Mar 28 2004, Jeff Garzik wrote:
> Jens Axboe wrote:
> >On Sun, Mar 28 2004, Jeff Garzik wrote:
> >
> >>Jens Axboe wrote:
> >>
> >>>On Sat, Mar 27 2004, Jeff Garzik wrote:
> >>>
> >>>
> >>>>I also wouldn't want to lock out any users who wanted to use SATA at 
> >>>>full speed ;-)
> >>>
> >>>
> >>>And full speed requires 32MB requests?
> >>
> >>
> >>Full speed is the SATA driver supporting the hardware maximum.  The 
> >
> >
> >Come on Jeff, don't be such a slave to the hardware specifications. Just
> >because it's possible to send down 32MB requests doesn't necessarily
> >mean it's a super thing to do, nor that it automagically makes 'things
> >go faster'. The claim is that back-to-back 1MB requests are every bit as
> >fast as a 32MB request (especially if you have a small queue depth, in
> >that case there truly should be zero benefit to doing the bigger ones).
> >The cut-off point is likely even lower than 1MB, I'm just using that
> >figure as a value that is 'pretty big' yet doesn't incur too large
> >latencies just because of its size.
> 
> 
> For me this is a policy issue.
> 
> I agree that huge requst hurt latency.  I just disagree that the
> _driver_ should artificially lower its maximums to fit a guess about
> what the best request size should be.
> 
> If there needs to be an overall limit on per-size size, do it at the
> block layer.  It's not scalable to hardcode that limit into every
> driver.  That's not the driver's job.  The driver just exports the
> hardware limits, nothing more.
> 
> A limit is fine.  I support that.  An artificial limit in the driver
> is not.

Sorry, but I cannot disagree more. You think an artificial limit at the
block layer is better than one imposed at the driver end, which actually
has a lot more of an understanding of what hardware it is driving? This
makes zero sense to me. Take floppy.c for instance, I really don't want
1MB requests there, since that would take a minute to complete. And I
might not want 1MB requests on my Super-ZXY storage, because that beast
completes io easily at an iorate of 200MB/sec.

So you want to put this _policy_ in the block layer, instead of in the
driver. That's an even worse decision if your reasoning is policy. The
only such limits I would want to put in, are those of the bio where
simply is best to keep that small and contained within a single page to
avoid higher order allocations to do io. Limits based on general sound
principles, not something that caters to some particular piece of
hardware. I absolutely refuse to put a global block layer 'optimal io
size' restriction in, since that is the ugliest of policies and without
having _any_ knowledge of what the hardware can do.

-- 
Jens Axboe

