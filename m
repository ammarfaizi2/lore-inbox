Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262252AbVGKXLY@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262252AbVGKXLY (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 11 Jul 2005 19:11:24 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261818AbVGKXLR
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 11 Jul 2005 19:11:17 -0400
Received: from ms-smtp-02.nyroc.rr.com ([24.24.2.56]:29328 "EHLO
	ms-smtp-02.nyroc.rr.com") by vger.kernel.org with ESMTP
	id S262252AbVGKXKU (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 11 Jul 2005 19:10:20 -0400
Subject: Re: kjournald wasting CPU in invert_lock fs/jbd/commit.c
From: Steven Rostedt <rostedt@goodmis.org>
To: Andrew Morton <akpm@osdl.org>
Cc: linux-kernel@vger.kernel.org, torvalds@osdl.org, dwalker@mvista.com,
       mingo@elte.hu, sct@redhat.com
In-Reply-To: <20050711154113.5abc81dd.akpm@osdl.org>
References: <1121120222.6087.44.camel@localhost.localdomain>
	 <20050711154113.5abc81dd.akpm@osdl.org>
Content-Type: text/plain
Organization: Kihon Technologies
Date: Mon, 11 Jul 2005 19:09:42 -0400
Message-Id: <1121123382.5481.11.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Evolution 2.2.2 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 2005-07-11 at 15:41 -0700, Andrew Morton wrote:
> Steven Rostedt <rostedt@goodmis.org> wrote:
> >
> > I noticed that the code in commit.c of the jbd system can waste CPU
> > cycles.
> 
> How did you notice?  By code inspection or by runtime observation?  If the
> latter, please share.

Argh! I just realize that this problem is really more in Ingo's RT
kernel, but I assumed that it was a problem in vanilla since the code is
more from the vanilla kernel.  With Ingo's spin_locks as mutexes, this
creates a problem on UP, but your are right, this is not a problem for
vanilla UP.


> Yeah.  But these _are_ spinlocks, so spinning is what's supposed to happen.
>  Maybe we should dump that silly schedule() and just do cpu_relax(). 
> Although I do recall once theorising that the time we spend in the
> schedule() might be preventing livelocks.
> 

As mentioned above, this was a confusion of paradigms. I just got back
from Europe, so I'm blaming this on jetlag!  

OK a cpu_relax() may be better. So here it is :-)

Signed-off-by: Steven Rostedt <rostedt@goodmis.org>
---
--- a/fs/jbd/commit.c	2005-07-11 17:51:37.000000000 -0400
+++ b/fs/jbd/commit.c	2005-07-11 19:05:35.000000000 -0400
@@ -87,7 +87,7 @@ static int inverted_lock(journal_t *jour
 {
 	if (!jbd_trylock_bh_state(bh)) {
 		spin_unlock(&journal->j_list_lock);
-		schedule();
+		cpu_relax();
 		return 0;
 	}
 	return 1;


