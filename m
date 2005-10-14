Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750868AbVJNTRX@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750868AbVJNTRX (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 14 Oct 2005 15:17:23 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750881AbVJNTRX
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 14 Oct 2005 15:17:23 -0400
Received: from fmr22.intel.com ([143.183.121.14]:54680 "EHLO
	scsfmr002.sc.intel.com") by vger.kernel.org with ESMTP
	id S1750866AbVJNTRX (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 14 Oct 2005 15:17:23 -0400
Message-Id: <200510141917.j9EJHEg20883@unix-os.sc.intel.com>
From: "Chen, Kenneth W" <kenneth.w.chen@intel.com>
To: "'Arjan van de Ven'" <arjan@infradead.org>
Cc: <linux-kernel@vger.kernel.org>, "'Jens Axboe'" <axboe@suse.de>
Subject: RE: [patch] optimize disk_round_stats
Date: Fri, 14 Oct 2005 12:16:54 -0700
MIME-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: 7bit
X-Mailer: Microsoft Office Outlook, Build 11.0.6353
Thread-Index: AcXQqPwp2215Yv/fQYWI4zhxwhPyfgASQv+w
In-Reply-To: <1129285187.2873.7.camel@laptopd505.fenrus.org>
X-MimeOLE: Produced By Microsoft MimeOLE V6.00.2900.2180
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Arjan van de Ven wrote on Friday, October 14, 2005 3:20 AM
> On Thu, 2005-10-13 at 12:19 -0700, Chen, Kenneth W wrote:
> > Following the same idea, it occurs to me that we should only update
> > disk stat when "now" is different from disk->stamp.  Otherwise, we
> > are again needlessly adding zero to the stats.
> 
> have you measured this?
> Conditionals in code are not free, so it might well be more expensive...

Yes I did, on a null block driver[1], this optimization gets about
2% improvement.  The reasoning is that for example, user submits
100,000 I/O per second, we only need to update the stats per jiffies.
With latest kernel have 250 Hz as default.  It's 250 updates versus
100,000 updates (with 99,750 updates of adding zero).  I see that the
condition is well worth it.  The address calculation for per cpu disk
stats has lots of indirection and index calculation.  Compiler generates
lots of code just for address calculation.

- Ken


[1] this driver completes an I/O request as soon as it enters block queue.

