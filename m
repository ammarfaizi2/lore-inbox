Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262843AbVFVJbd@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262843AbVFVJbd (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 22 Jun 2005 05:31:33 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262828AbVFVJ1Y
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 22 Jun 2005 05:27:24 -0400
Received: from ns.virtualhost.dk ([195.184.98.160]:46317 "EHLO virtualhost.dk")
	by vger.kernel.org with ESMTP id S262925AbVFVJXx (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 22 Jun 2005 05:23:53 -0400
Subject: Re: cfq misbehaving on 2.6.11-1.14_FC3
From: Jens Axboe <axboe@suse.de>
To: spaminos-ker@yahoo.com
Cc: Andrew Morton <akpm@osdl.org>, linux-kernel@vger.kernel.org
In-Reply-To: <20050617230130.59874.qmail@web30702.mail.mud.yahoo.com>
References: <20050617230130.59874.qmail@web30702.mail.mud.yahoo.com>
Content-Type: text/plain
Date: Wed, 22 Jun 2005 11:24:44 +0200
Message-Id: <1119432285.3257.5.camel@linux>
Mime-Version: 1.0
X-Mailer: Evolution 2.2.1 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 2005-06-17 at 16:01 -0700, spaminos-ker@yahoo.com wrote:
> I don't know how all this works, but would there be a way to slow down the
> offending writer by not allowing too many pending write requests per process?
> Is there a tunable for the size of the write queue for a given device?
> Reducing it will reduce the throughput, but the latency as well.

The 2.4 SUSE kernel actually has something in place to limit in-flight
write requests against a single device. cfq will already limit the
number of write requests you can have in-flight against a single queue,
but it's request based and not size based.

> Of course, there has to be a way to get this to work right.
> 
> To go back to high latencies, maybe a different problem (but at least closely
> related):
> 
> If I start in the background the command
> dd if=/dev/zero of=/tmp/somefile2 bs=1024
> 
> and then run my test program in a loop, with
> while true ; do time ./io 1; sleep 1s ; done
> 
> I get:
> 
> cfq: 47,33,27,48,32,29,26,49,25,47 -> 36.3 avg
> deadline: 32,28,52,33,35,29,49,39,40,33 -> 37 avg
> noop: 62,47,57,39,59,44,56,49,57,47 -> 51.7 avg
> 
> Now, cfq doesn't behave worst than the others, like expected (now, why it
> behaved worst with the real daemons, I don't know).
> Still > 30 seconds has to be improved for cfq.

THe problem here is that cfq  (and the other io schedulers) still
consider the io async even if fsync() ends up waiting for it to
complete. So there's no real QOS being applied to these pending writes,
and I don't immediately see how we can improve that situation right now.

What file system are you using? I ran your test on ext2, and it didn't
give me more than ~2 seconds latency for the fsync. Tried reiserfs now,
and it's in the 23-24 range.

-- 
Jens Axboe <axboe@suse.de>

