Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751103AbVIUPuv@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751103AbVIUPuv (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 21 Sep 2005 11:50:51 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751104AbVIUPuv
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 21 Sep 2005 11:50:51 -0400
Received: from frankvm.xs4all.nl ([80.126.170.174]:52131 "EHLO
	janus.localdomain") by vger.kernel.org with ESMTP id S1751103AbVIUPuv
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 21 Sep 2005 11:50:51 -0400
Date: Wed, 21 Sep 2005 17:50:49 +0200
From: Frank van Maarseveen <frankvm@frankvm.com>
To: Christoph Lameter <clameter@engr.sgi.com>
Cc: Hugh Dickins <hugh@veritas.com>,
       Frank van Maarseveen <frankvm@frankvm.com>,
       linux-kernel@vger.kernel.org, jlan@sgi.com
Subject: Re: [PATCH 2.6.14-rc2] fix incorrect mm->hiwater_vm and mm->hiwater_rss
Message-ID: <20050921155049.GA16198@janus>
References: <20050921121915.GA14645@janus> <Pine.LNX.4.61.0509211515330.6114@goblin.wat.veritas.com> <Pine.LNX.4.62.0509210824350.10125@schroedinger.engr.sgi.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.62.0509210824350.10125@schroedinger.engr.sgi.com>
User-Agent: Mutt/1.4.1i
X-Subliminal-Message: Use Linux!
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Sep 21, 2005 at 08:26:28AM -0700, Christoph Lameter wrote:
> On Wed, 21 Sep 2005, Hugh Dickins wrote:
> 
> > On Wed, 21 Sep 2005, Frank van Maarseveen wrote:
> > > This fixes a post 2.6.11 regression in maintaining the mm->hiwater_* counters.
> > 
> > It would be a good idea to CC Christoph Lameter, who I believe was the
> > one who very intentionally moved most of these updates out to timer tick.
> 
> Right and we need to include Jay who introduced these in the first place.
> 
> What is the reason to move these counters back into the performance 
> critical vm paths? We agreed that some inaccuracy in these numbers was 
> acceptable.

Try running the script below after exposing hiwater_vm via
/proc/pid/status as "VmPeak:" (see my other mail in this thread).

========
#!/bin/sh

for f in /proc/*/status
do
	awk '
		BEGIN{ state = 0; }
		/^Name:/	{ name = $2;	++state; }
		/^Pid:/		{ pid = $2;	++state; }
		/^VmPeak:/	{ x = $2;	++state; }
		/^VmSize:/	{ y = $2;	++state; }
		END{ if (state == 4 && x < y)
			printf("pid %d (%s): %d < %d\n", pid, name, x, y);
		}
	    ' <$f
done
========

On 2.6.12.2 it prints:

pid 13170 (sh): 3312 < 3336
pid 16621 (sh): 2916 < 2996
pid 1696 (getty): 1576 < 1580
pid 2338 (getty): 1576 < 1580
pid 2344 (getty): 1444 < 1580
pid 24497 (getty): 1576 < 1580
pid 27929 (knews.sh): 2984 < 2988
pid 6207 (rsh-title): 1156 < 2980
pid 6208 (rsh): 1952 < 2036
pid 16749 (awk): 1836 < 2368

On 2.6.13 it is much worse.

-- 
Frank
