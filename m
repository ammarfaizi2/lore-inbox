Return-Path: <linux-kernel-owner+willy=40w.ods.org-S267537AbUIUIzv@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S267537AbUIUIzv (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 21 Sep 2004 04:55:51 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267511AbUIUIyg
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 21 Sep 2004 04:54:36 -0400
Received: from fw.osdl.org ([65.172.181.6]:2990 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S267537AbUIUIwc (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 21 Sep 2004 04:52:32 -0400
Date: Tue, 21 Sep 2004 01:50:20 -0700
From: Andrew Morton <akpm@osdl.org>
To: "Stephen C. Tweedie" <sct@redhat.com>
Cc: gene.heskett@verizon.net, sct@redhat.com, linux-kernel@vger.kernel.org
Subject: Re: journal aborted, system read-only
Message-Id: <20040921015020.7372faac.akpm@osdl.org>
In-Reply-To: <1095088378.2765.18.camel@sisko.scot.redhat.com>
References: <200409121128.39947.gene.heskett@verizon.net>
	<1095088378.2765.18.camel@sisko.scot.redhat.com>
X-Mailer: Sylpheed version 0.9.7 (GTK+ 1.2.10; i386-redhat-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

"Stephen C. Tweedie" <sct@redhat.com> wrote:
>
> Hi,
> 
> On Sun, 2004-09-12 at 16:28, Gene Heskett wrote:
> 
> > I just got up, and found advisories on every shell open that the 
> > journal had encountered an error and aborted, converting my / 
> > partition to read-only.
> ...
> > The kernel is 2.6.9-rc1-mm4.  .config available on request.
> 
> > This is precious little info to go on, but basicly I'm wondering if 
> > anyone else has encountered this?
> 
> Well, we really need to see _what_ error the journal had encountered to
> be able to even begin to diagnose it.  But 2.6.9-rc1-mm3 and -mm4 had a
> bug in the journaling introduced by low-latency work on the checkpoint
> code; can you try -mm5 or back out
> "journal_clean_checkpoint_list-latency-fix.patch" and try again?
> 

Turns out this is due to the reworked buffer/page sleep/wakeup code in
recent -mm's.  If the journal timer wakes kjournald while kjournald is
waiting on a read of a journal indirect block, kjournald just plunges ahead
with a still-locked, non-uptodate buffer.  Which it treats as an I/O error,
and things don't improve from there.

This should fix.

--- 25/kernel/wait.c~wait_on_bit-must-loop	2004-09-21 01:33:18.000000000 -0700
+++ 25-akpm/kernel/wait.c	2004-09-21 01:44:36.706435616 -0700
@@ -157,8 +157,9 @@ __wait_on_bit(wait_queue_head_t *wq, str
 	int ret = 0;
 
 	prepare_to_wait(wq, &q->wait, mode);
-	if (test_bit(q->key.bit_nr, q->key.flags))
+	do {
 		ret = (*action)(q->key.flags);
+	} while (test_bit(q->key.bit_nr, q->key.flags) && !ret);
 	finish_wait(wq, &q->wait);
 	return ret;
 }
_

