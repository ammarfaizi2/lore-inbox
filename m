Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751273AbWEAGCo@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751273AbWEAGCo (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 1 May 2006 02:02:44 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751272AbWEAGCo
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 1 May 2006 02:02:44 -0400
Received: from mx1.suse.de ([195.135.220.2]:18605 "EHLO mx1.suse.de")
	by vger.kernel.org with ESMTP id S1751176AbWEAGCn (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 1 May 2006 02:02:43 -0400
From: Neil Brown <neilb@suse.de>
To: Andrew Morton <akpm@osdl.org>
Date: Mon, 1 May 2006 16:02:37 +1000
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-ID: <17493.42109.153523.381980@cse.unsw.edu.au>
Cc: Linus Torvalds <torvalds@osdl.org>, linux-raid@vger.kernel.org,
       linux-kernel@vger.kernel.org
Subject: Re: [PATCH 004 of 11] md: Increase the delay before marking
 metadata clean, and make it configurable.
In-Reply-To: message from Andrew Morton on Sunday April 30
References: <20060501152229.18367.patches@notabene>
	<1060501053019.22949@suse.de>
	<20060430224404.1060d29a.akpm@osdl.org>
X-Mailer: VM 7.19 under Emacs 21.4.1
X-face: v[Gw_3E*Gng}4rRrKRYotwlE?.2|**#s9D<ml'fY1Vw+@XfR[fRCsUoP?K6bt3YD\ui5Fh?f
	LONpR';(ql)VM_TQ/<l_^D3~B:z$\YC7gUCuC=sYm/80G=$tt"98mr8(l))QzVKCk$6~gldn~*FK9x
	8`;pM{3S8679sP+MbP,72<3_PIH-$I&iaiIb|hV1d%cYg))BmI)AZ
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sunday April 30, akpm@osdl.org wrote:
> NeilBrown <neilb@suse.de> wrote:
> >
> > 
> > When a md array has been idle (no writes) for 20msecs it is marked as
> > 'clean'.  This delay turns out to be too short for some real
> > workloads.  So increase it to 200msec (the time to update the metadata
> > should be a tiny fraction of that) and make it sysfs-configurable.
> > 
> > 
> > ...
> > 
> > +   safe_mode_delay
> > +     When an md array has seen no write requests for a certain period
> > +     of time, it will be marked as 'clean'.  When another write
> > +     request arrive, the array is marked as 'dirty' before the write
> > +     commenses.  This is known as 'safe_mode'.
> > +     The 'certain period' is controlled by this file which stores the
> > +     period as a number of seconds.  The default is 200msec (0.200).
> > +     Writing a value of 0 disables safemode.
> > +
> 
> Why not make the units milliseconds?  Rename this to safe_mode_delay_msecs
> to remove any doubt.

Because umpteen years ago when I was adding thread-usage statistics to
/proc/net/rpc/nfsd I used milliseconds and Linus asked me to make it
seconds - a much more "obvious" unit.  See Email below.
It seems very sensible to me.

...
> > +	msec = simple_strtoul(buf, &e, 10);
> > +	if (e == buf || (*e && *e != '\n'))
> > +		return -EINVAL;
> > +	msec = (msec * 1000) / scale;
> > +	if (msec == 0)
> > +		mddev->safemode_delay = 0;
> > +	else {
> > +		mddev->safemode_delay = (msec*HZ)/1000;
> > +		if (mddev->safemode_delay == 0)
> > +			mddev->safemode_delay = 1;
> > +	}
> > +	return len;
> 
> And most of that goes away.

Maybe it could go in a library :-?

NeilBrown


------------------------------------------------------------
From: Linus Torvalds <torvalds@transmeta.com>
To: Neil Brown <neilb@cse.unsw.edu.au>
cc: nfs-devel@linux.kernel.org
Subject: Re: PATCH knfsd - stats tidy up.
Date: Tue, 18 Jul 2000 12:21:12 -0700 (PDT)
Content-Type: TEXT/PLAIN; charset=US-ASCII



On Tue, 18 Jul 2000, Neil Brown wrote:
> 
> The following patch converts jiffies to milliseconds for output, and
> also makes the number wrap predicatably at 1,000,000 seconds
> (approximately one fortnight).

If no programs depend on the format, I actually prefer format changes like
this to be of the "obvious" kind. One such obvious kind is the format

	0.001

which obviously means 0.001 seconds. 

And yes, I'm _really_ sorry that a lot of the old /proc files contain
jiffies. Lazy. Ugly. Bad. Much of it my bad.

Doing 0.001 doesn't mean that you have to use floating point, in fact
you've done most of the work already in your ms patch, just splitting
things out a bit works well:

	/* gcc knows to combine / and % - generate one "divl" */
	unsigned int sec = time / HZ, msec = time % HZ;
	msec = (msec * 1000) / HZ;

	sprintf(" %d.%03d", sec, msec)

(It's basically the same thing you already do, except it doesn't
re-combine the seconds and milliseconds but just prints them out
separately.. And it has the advantage that if you want to change it to
microseconds some day, you can do so very trivially without breaking the
format. Plus it's readable as hell.)

		Linus
