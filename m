Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932420AbWEVCMv@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932420AbWEVCMv (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 21 May 2006 22:12:51 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932423AbWEVCMv
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 21 May 2006 22:12:51 -0400
Received: from mail.gmx.net ([213.165.64.20]:38286 "HELO mail.gmx.net")
	by vger.kernel.org with SMTP id S932420AbWEVCMv (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 21 May 2006 22:12:51 -0400
X-Authenticated: #14349625
Subject: Re: 2.6.17-rc2+ regression -- audio skipping
From: Mike Galbraith <efault@gmx.de>
To: Con Kolivas <kernel@kolivas.org>
Cc: Rene Herman <rene.herman@keyaccess.nl>, Lee Revell <rlrevell@joe-job.com>,
       Linux Kernel <linux-kernel@vger.kernel.org>,
       Linus Torvalds <torvalds@osdl.org>, Ingo Molnar <mingo@elte.hu>
In-Reply-To: <200605221033.49153.kernel@kolivas.org>
References: <4470CC8F.9030706@keyaccess.nl>
	 <1148247047.20472.78.camel@mindpipe> <44710162.3070406@keyaccess.nl>
	 <200605221033.49153.kernel@kolivas.org>
Content-Type: text/plain
Date: Mon, 22 May 2006 04:14:03 +0200
Message-Id: <1148264043.7643.15.camel@homer>
Mime-Version: 1.0
X-Mailer: Evolution 2.4.0 
Content-Transfer-Encoding: 7bit
X-Y-GMX-Trusted: 0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 2006-05-22 at 10:33 +1000, Con Kolivas wrote:
> On Monday 22 May 2006 10:10, Rene Herman wrote:
> > Lee Revell wrote:
> > > On Sun, 2006-05-21 at 22:24 +0200, Rene Herman wrote:
> > >> 2.6.17-rc2 (and 3 and 4) make my audio skip. Audio player is ogg123
> > >> running in an xterm. Browsing heavy sites (say, eBay) with Firefox
> > >> 1.5.0.3 gets me audio underruns quickly. This does not happen on
> > >> 2.6.17-rc1 and earlier (I just tested extensively; quite impossible to
> > >> generate underruns on -rc1, quickly on -rc2 and later).
> > >>
> > >> It's not ALSA; reverted */sound/* from the rc1-rc2 interdiff. It's also
> > >> not cfq-iosched.c. Any likely culprits in there? (I'm not a GIT user).
> > >
> > > I would suspect the scheduler interactivity patches.  Please confirm
> > > this by running ogg123 at nice -20 - do the underruns persist?
> >
> > They do persist. Thanks for the hint though -- "sched: fix interactive
> > task starvation" is the culprit:
> >
> > http://www.kernel.org/git/?p=linux/kernel/git/torvalds/linux-2.6.git;a=comm
> >it;h=5ce74abe788a26698876e66b9c9ce7e7acc25413
> 
> Good investigative work! Makes sense that falling on the expired array would 
> make for terrible latency for audio apps if your cpu was stretched just the 
> right amount.

Yup.  Note that you can hit the array switch without this patch as well,
but with it, you'll hit it for sure if you're at 100% cpu.

> > Added author and acked-by's to the CC. Mike, this patch is no good for
> > me. Audio underruns galore, with only ogg123 and firefox (browsing the
> > GIT tree online is also a nice trigger by the way).
> >
> > If I back it out, everything is fine for me again. Back-out attached as
> > a patch against -rc4. This also backs out your follow-up "don't awaken
> > RT tasks on expired array" as it was dependant:
> >
> > http://www.kernel.org/git/?p=linux/kernel/git/torvalds/linux-2.6.git;a=comm
> >it;h=8a5bc075b8d8cf7a87b3f08fad2fba0f5d13295e
> >
> > While looking at the patch I noticed there was +1 difference in the
> > "limit" value between the macro and the static inline version of
> > expired_starving() so I experimented with adding that back but that
> > wasn't it unfortunately.
> >
> > I can test patches (preferably versus -rc4) although possibly not quickly.
> 
> This close to 2.6.17 the safest thing we can and should do is simply back out 
> the patch.

Agreed.  That will reinstate terminal starvation in some cases, but
those cases are much less common than this one.

In my tree, I don't use the expired array for anything except batch
tasks any more for this very reason. The latency just hurts too bad.

	-Mike

