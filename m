Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932188AbWC3MNB@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932188AbWC3MNB (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 30 Mar 2006 07:13:01 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932189AbWC3MNB
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 30 Mar 2006 07:13:01 -0500
Received: from mx2.mail.elte.hu ([157.181.151.9]:41396 "EHLO mx2.mail.elte.hu")
	by vger.kernel.org with ESMTP id S932188AbWC3MNA (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 30 Mar 2006 07:13:00 -0500
Date: Thu, 30 Mar 2006 14:10:30 +0200
From: Ingo Molnar <mingo@elte.hu>
To: Jens Axboe <axboe@suse.de>
Cc: linux-kernel@vger.kernel.org, akpm@osdl.org, torvalds@osdl.org
Subject: Re: [PATCH] splice support #2
Message-ID: <20060330121030.GA14621@elte.hu>
References: <20060330100630.GT13476@suse.de> <20060330120055.GA10402@elte.hu> <20060330120512.GX13476@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20060330120512.GX13476@suse.de>
User-Agent: Mutt/1.4.2.1i
X-ELTE-SpamScore: -2.6
X-ELTE-SpamLevel: 
X-ELTE-SpamCheck: no
X-ELTE-SpamVersion: ELTE 2.0 
X-ELTE-SpamCheck-Details: score=-2.6 required=5.9 tests=ALL_TRUSTED,AWL,BAYES_50 autolearn=no SpamAssassin version=3.0.3
	-3.3 ALL_TRUSTED            Did not pass through any untrusted hosts
	0.0 BAYES_50               BODY: Bayesian spam probability is 40 to 60%
	[score: 0.5000]
	0.7 AWL                    AWL: From: address is in the auto white-list
X-ELTE-VirusStatus: clean
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


* Jens Axboe <axboe@suse.de> wrote:

> On Thu, Mar 30 2006, Ingo Molnar wrote:
> > 
> > * Jens Axboe <axboe@suse.de> wrote:
> > 
> > > Hi,
> > > 
> > > This patch should resolve all issues mentioned so far. I'd still like 
> > > to implement the page moving, but that should just be a separate 
> > > patch.
> > 
> > neat stuff. One question: why do we require fdin or fdout to be a pipe?  
> > Is there any fundamental problem with implementing what Larry's original 
> > paper described too: straight pagecache -> socket transfers? Without a
> > pipe intermediary forced inbetween. It only adds unnecessary overhead.
> 
> No, not a fundamental problem. I think I even hid that in some comment 
> in there, at least if it's decipharable by someone else than myself... 
> Basically I think it would be nice in the future to tidy this a little 
> bit and separate the actual container from the pipe itself - and have 
> the pipe just fill/use the same container.

why is there a container needed at all? If i splice pagecache->socket, 
we can use sendpage to send it off immediately. There is no need for any 
container - both the pagecache and sendpage use struct page, and when we 
iterate to create a container we might as well ->sendpage() those pages 
off immediately instead.

I agree with the purpose of making sys_splice() generic and in 
particular usable in scripts/shells where pipes are commonly used, but 
we should also fulfill the original promise (outlined 15 years ago or 
so) and not limit this to pipes. That way i could improve TUX to make 
use of it for example ;)

	Ingo
