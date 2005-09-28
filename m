Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751143AbVI1Wim@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751143AbVI1Wim (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 28 Sep 2005 18:38:42 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751146AbVI1Wim
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 28 Sep 2005 18:38:42 -0400
Received: from ppp-217-133-42-200.cust-adsl.tiscali.it ([217.133.42.200]:22070
	"EHLO opteron.random") by vger.kernel.org with ESMTP
	id S1751143AbVI1Wim (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 28 Sep 2005 18:38:42 -0400
Date: Thu, 29 Sep 2005 00:38:29 +0200
From: Andrea Arcangeli <andrea@suse.de>
To: Dave Kleikamp <shaggy@austin.ibm.com>
Cc: Valdis.Kletnieks@vt.edu, Con Kolivas <kernel@kolivas.org>,
       linux-kernel@vger.kernel.org
Subject: Re: 2.6.14-rc2-mm1 - ext3 wedging up
Message-ID: <20050928223829.GH10408@opteron.random>
References: <200509221959.j8MJxJsY010193@turing-police.cc.vt.edu> <200509231036.16921.kernel@kolivas.org> <200509230720.j8N7KYGX023826@turing-police.cc.vt.edu> <20050923153158.GA4548@x30.random> <1127509047.8880.4.camel@kleikamp.austin.ibm.com> <1127509155.8875.6.camel@kleikamp.austin.ibm.com> <1127511979.8875.11.camel@kleikamp.austin.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1127511979.8875.11.camel@kleikamp.austin.ibm.com>
User-Agent: Mutt/1.5.9i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Sep 23, 2005 at 04:46:19PM -0500, Dave Kleikamp wrote:
> On Fri, 2005-09-23 at 15:59 -0500, Dave Kleikamp wrote:
> I'd guess that it's spinning in balance_dirty_pages.
> /proc/<pid>/future_dirty is 25650 for fsx.  It appears that
> nr_reclaimable is not going to zero for some reason.

Even if nr_reclaimable isn't going to zero, eventually the loop should
break out because pages_written must increase.

So this make me think it might be the nr_unstable that destabilizes it,
and whatever it is, it is a bug in mainline as well, except it was well
hidden until now, because the dirty levels never approached zero during
heavy write-IO like it can happen with this feature enabled.

Basically whatever we account as "reclaimable" must be _written_out_ and
accounted as well in the "pages_written" otherwise it'll just hang. 
If there's a problem, it shall be a longstanding one.

Can you try with this new patch that stops accounting "unstable" as
"reclaimable". It should be possible to flush the dirty pages to disk so
"nr_dirty" should be safe because they should always increase the
"pages_written". I'm not sure if this fixes it, but this at least rule
out the nfs from the equation (perhaps nfs will never be accounted as
"pages_written" and that would be a possible explanation of the infinite
loop).

This new update also makes sure to never account rewrites (except for
reiserfs where it's more difficult to change the code for this).

I tried with fsx (no params) but I couldn't reproduce any problem yet,
but I've no nfs workload involved in my test box.

http://www.kernel.org/pub/linux/kernel/people/andrea/patches/v2.6/2.6.14-rc1/per-task-predictive-write-throttling-4

thanks for the help!
