Return-Path: <linux-kernel-owner+w=401wt.eu-S965024AbXAGUB1@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965024AbXAGUB1 (ORCPT <rfc822;w@1wt.eu>);
	Sun, 7 Jan 2007 15:01:27 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965038AbXAGUB1
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 7 Jan 2007 15:01:27 -0500
Received: from smtp.osdl.org ([65.172.181.24]:44264 "EHLO smtp.osdl.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S965024AbXAGUB0 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 7 Jan 2007 15:01:26 -0500
Date: Sun, 7 Jan 2007 11:59:57 -0800
From: Andrew Morton <akpm@osdl.org>
To: vatsa@in.ibm.com
Cc: Oleg Nesterov <oleg@tv-sign.ru>, David Howells <dhowells@redhat.com>,
       Christoph Hellwig <hch@infradead.org>, Ingo Molnar <mingo@elte.hu>,
       Linus Torvalds <torvalds@osdl.org>, linux-kernel@vger.kernel.org,
       Gautham shenoy <ego@in.ibm.com>
Subject: Re: [PATCH] fix-flush_workqueue-vs-cpu_dead-race-update
Message-Id: <20070107115957.6080aa08.akpm@osdl.org>
In-Reply-To: <20070107110013.GD13579@in.ibm.com>
References: <20061218162701.a3b5bfda.akpm@osdl.org>
	<20061219004319.GA821@tv-sign.ru>
	<20070104113214.GA30377@in.ibm.com>
	<20070104142936.GA179@tv-sign.ru>
	<20070104091850.c1feee76.akpm@osdl.org>
	<20070106151036.GA951@tv-sign.ru>
	<20070106154506.GC24274@in.ibm.com>
	<20070106163035.GA2948@tv-sign.ru>
	<20070106163851.GA13579@in.ibm.com>
	<20070106111117.54bb2307.akpm@osdl.org>
	<20070107110013.GD13579@in.ibm.com>
X-Mailer: Sylpheed version 2.2.7 (GTK+ 2.8.17; x86_64-unknown-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 7 Jan 2007 16:30:13 +0530
Srivatsa Vaddagiri <vatsa@in.ibm.com> wrote:

> On Sat, Jan 06, 2007 at 11:11:17AM -0800, Andrew Morton wrote:
> > Has anyone thought seriously about using the process freezer in the
> > cpu-down/cpu-up paths?  That way we don't need to lock anything anywhere?
> 
> How would this provide a stable access to cpu_online_map in functions
> that need to block while accessing it (as flush_workqueue requires)?

If a thread simply blocks, that will not permit a cpu plug/unplug to proceed.

The thread had to explicitly call try_to_freeze().  CPU plug/unplug will
not occur (and cpu_online_map will not change) until every process in the
machine has called try_to_freeze()).

So the problem which you're referring to will only occur if a workqueue
callback function calls try_to_freeze(), which would be mad.



Plus flush_workqueue() is on the way out.  We're slowly edging towards a
working cancel_work() which will only block if the work which you're trying
to cancel is presently running.  With that, pretty much all the
flush_workqueue() calls go away, and all these accidental rarely-occurring
deadlocks go away too.

