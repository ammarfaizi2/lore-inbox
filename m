Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262127AbVC1Xz4@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262127AbVC1Xz4 (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 28 Mar 2005 18:55:56 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262128AbVC1Xz4
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 28 Mar 2005 18:55:56 -0500
Received: from alt.aurema.com ([203.217.18.57]:28054 "EHLO smtp.sw.oz.au")
	by vger.kernel.org with ESMTP id S262127AbVC1Xzl (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 28 Mar 2005 18:55:41 -0500
Date: Tue, 29 Mar 2005 09:43:34 +1000
From: Kingsley Cheung <kingsley@aurema.com>
To: Tom Zanussi <zanussi@us.ibm.com>
Cc: Karim Yaghmour <karim@opersys.com>, linux-kernel@vger.kernel.org
Subject: Re: read() on relayfs channel returns premature 0
Message-ID: <20050328234333.GA1794@aurema.com>
Mail-Followup-To: Tom Zanussi <zanussi@us.ibm.com>,
	Karim Yaghmour <karim@opersys.com>, linux-kernel@vger.kernel.org
References: <20050323090254.GA10630@aurema.com> <16961.35656.576684.890542@tut.ibm.com> <20050324012948.GC25134@aurema.com> <16963.4331.617958.820012@tut.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <16963.4331.617958.820012@tut.ibm.com>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Mar 24, 2005 at 01:11:39PM -0600, Tom Zanussi wrote:
> Kingsley Cheung writes:
>  > On Wed, Mar 23, 2005 at 09:29:12AM -0600, Tom Zanussi wrote:
>  > > kingsley@aurema.com writes:
>  > >  > 
>  > >  > Now I understand that this is not the latest release of relayfs (there
>  > >  > are the redux patches, which I have yet to try).  Nonetheless I'd like
> 
> [...]
> 
>  > 
>  > I've tested it on 2.6.10 with the pagg and relayfs patches from
>  > 
>  > http://www.opersys.com/ftp/pub/relayfs/patch-relayfs-2.6.10-050113 
>  > 
>  > and
>  > 
>  > ftp://oss.sgi.com/projects/pagg/download/linux-2.6.10-pagg.patch-4
>  > 
>  > read() gives me a zero still once about a page of data has been read.
>  > 
> 
> Thanks - I've tried it out and haven't immediately been able to
> reproduce the problem yet - I'll do some more pounding on it though
> when I get the chance.

Ok.  It should be fairly easy to reproduce.  On a dual 400MHz PII I've
been able to get the zero by running one reader of the channel in
parallel with a simple shell script like "while :; do ps -ef >
/dev/null; done".

> 
> BTW, I just want to point out that there aren't any problems with
> read() in the version of relayfs included in the -mm tree (i.e. the
> 'redux' version), since of course it doesn't support read().

Ok.

> I went ahead and did a quick port of your stuff to the new version of
> relayfs, which you can find here:
> 
> http://prdownloads.sourceforge.net/dprobes/RelayfsModule-new.tar.bz2?download
> 
> There's a README in the tarball with some notes on building and
> running it.  It includes both the kernel and user-side code, which makes
> use of the relay-apps code and documentation found here (I've included
> the necessary files in the RelayfsModule-new tarball so you don't have
> to actually get this):
> 
> http://prdownloads.sourceforge.net/dprobes/relay-apps-0.2.tar.gz?download
> 
> Hopefully the new version will still be useful for what you're trying
> to do, but it does differ in a couple important ways from the old
> version, and points up the fact that the new relayfs really is now
> much more specialized for high-volume applications -
> 
> - your old version used 'packet' mode with read().  The new relayfs
> only supports 'bulk' mode with mmap(), which means it's not really
> useful for notification of single events.  I'm not sure how important
> that is for your application - if you're mainly interested in
> collecting data, you can certainly use it even for low-volume
> applications, but the events will be sent to user space in 'blocks'.
> You can modify the user space app to process blocks of events as they
> come in, and play around with buffer sizes to get them more often, but
> it's not quite the same thing.
> 
> - your old version used a single buffer, while the new relayfs only
> supports per-cpu buffers, which means you'd have to sort out the
> events in user space and impose some ordering using timestamps for
> instance if your data doesn't already have a natural ordering (BTW,
> the new relayfs doesn't have an option any longer to do automatic
> timestamping either).

Right. Thanks for all your work on it Tom .  I really appreciate it.
I have been considering a move over to the redux version recently.
Your port will make it easier for me to test both versions out.  I'll
keep your pointers in mind.

> I'll continue maintaining the old relayfs for existing users (so
> thanks for the patch and the test code) so if the new version doesn't
> fit your needs, you'll still have the old version to fall back on.
> 
> Thanks,
> 
> Tom

Ok. Thanks again!
-- 
		Kingsley
