Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261416AbVFNXWe@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261416AbVFNXWe (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 14 Jun 2005 19:22:34 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261411AbVFNXWe
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 14 Jun 2005 19:22:34 -0400
Received: from web30701.mail.mud.yahoo.com ([68.142.200.134]:63623 "HELO
	web30701.mail.mud.yahoo.com") by vger.kernel.org with SMTP
	id S261416AbVFNXWH (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 14 Jun 2005 19:22:07 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
  s=s1024; d=yahoo.com;
  h=Message-ID:Received:Date:From:Reply-To:Subject:To:Cc:In-Reply-To:MIME-Version:Content-Type:Content-Transfer-Encoding;
  b=iuuxVn/KVKk3y9+nA0E/UhGlOpFKEirMcwkgvkbtFhwRDz7vpn/pQPkhbTrEZOkBxeLQTk73KBDY+YMF6dOrC5+bi1qwVMdM6z+X0taSO5VXBgZUm/dJ7i3re7jm1dUMgMSWiDWL9brekQU2sbMyqHFUKwjMtz950pI16f4ZJPM=  ;
Message-ID: <20050614232154.17077.qmail@web30701.mail.mud.yahoo.com>
Date: Tue, 14 Jun 2005 16:21:54 -0700 (PDT)
From: <spaminos-ker@yahoo.com>
Reply-To: spaminos-ker@yahoo.com
Subject: Re: cfq misbehaving on 2.6.11-1.14_FC3
To: Andrew Morton <akpm@osdl.org>
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <20050614000352.7289d8f1.akpm@osdl.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

--- Andrew Morton <akpm@osdl.org> wrote:
> > For some reason, doing a "cp" or appending to files is very fast. I suspect
> > that vi's mmap calls are the reason for the latency problem.
> 
> Don't know.  Try to work out (from vmstat or diskstats) how much reading is
> going on.
> 
> Try stracing the check, see if your version of vi is doing a sync() or
> something odd like that.

The read/write patterns of the background process is about 35% reads.

vi is indeed doing a sync on the open file, and that's where the time was
spend.
So I just changed my test to simply opening a file, writing some data in it and
calling flush on the fd.

I also reduced the sleep to 1s instead of 1m, and here are the results:

cfq: 20,20,21,21,20,22,20,20,18,21 - avg 20.3
noop: 12,12,12,13,5,10,10,12,12,13 - avg 11.1
deadline: 16,9,16,14,10,6,8,8,15,9 - avg 11.1
as: 6,11,14,11,9,15,16,9,8,9 - avg 10.8

As you can see, cfq stands out (and it should stand out the other way).

> OK, well if the latency is mainly due to reads then one would hope that the
> anticipatory scheduler would do better than that.

I suspect the latency is due to writes: it seems (and correct me if I am wrong)
that write requests are enqueued in one giant queue, thus the cfq algorithm can
not be applied to the requests.

Either that, or there is a different queue that cancels out the benefits of cfq
when writing (because even though the writes are down the right way, this other
queue to the device keeps way too much data).

But then, why would other i/o schedulers perform better in that case?

> 
> But what happened to this, from your first report?
> 
> > On the other hand, opening a blank new file in vi and saving it takes about
> 5
> > minutes or so.
> 
> Are you able to reproduce that 5-minute stall in the more recent testing?
> 
> 
The most I got with this kernel, is a 1 minute stall, so there is improvement
there. Yet, a single process should not be able to cause this kind of stall
with cfq.

Nicolas


------------------------------------------------------------
video meliora proboque deteriora sequor
------------------------------------------------------------
