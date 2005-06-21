Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262148AbVFUQCH@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262148AbVFUQCH (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 21 Jun 2005 12:02:07 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262161AbVFUP6v
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 21 Jun 2005 11:58:51 -0400
Received: from peabody.ximian.com ([130.57.169.10]:22183 "EHLO
	peabody.ximian.com") by vger.kernel.org with ESMTP id S262148AbVFUPz0
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 21 Jun 2005 11:55:26 -0400
Subject: Re: [patch] inotify.
From: Robert Love <rml@novell.com>
To: Neil Brown <neilb@cse.unsw.edu.au>
Cc: John McCutchan <ttb@tentacle.dhs.org>, Andrew Morton <akpm@osdl.org>,
       Christoph Hellwig <hch@lst.de>, arnd@arndb.de, zab@zabbo.net,
       linux-kernel@vger.kernel.org, viro@parcelfarce.linux.theplanet.co.uk
In-Reply-To: <17079.31644.985407.988980@cse.unsw.edu.au>
References: <1118855899.3949.21.camel@betsy> <42B1BC4B.3010804@zabbo.net>
	 <1118946334.3949.63.camel@betsy> <200506171907.39940.arnd@arndb.de>
	 <20050617175605.GB1981@tentacle.dhs.org>
	 <20050617143334.41a31707.akpm@osdl.org> <1119044430.7280.22.camel@phantasy>
	 <1119052357.7280.24.camel@phantasy>
	 <17079.25741.91251.232880@cse.unsw.edu.au>
	 <1119320137.17767.10.camel@vertex>
	 <17079.31644.985407.988980@cse.unsw.edu.au>
Content-Type: text/plain
Date: Tue, 21 Jun 2005 11:55:27 -0400
Message-Id: <1119369327.3949.251.camel@betsy>
Mime-Version: 1.0
X-Mailer: Evolution 2.2.1 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 2005-06-21 at 12:29 +1000, Neil Brown wrote:

> There may well be other good arguments against 'fd's, but I'm trying
> to point out that this isn't one of them, and so shouldn't appear in
> this part of the FAQ.

You raise a good point, although one could argue that raising the fd
limit is not necessarily feasible.

There are other good arguments.  With a single fd, there is a single
item to block on, which is mapped to a single queue of events.  The
single fd returns all watch events and also any potential out-of-band
data.  If every fd was a separate watch,

	- There would be no way to get event ordering.  Events on file
	  foo and file bar would pop poll() on both fd's, but there
	  would be no way to tell which happened first.  A single queue
	  trivially gives you ordering.
	- We'd have to maintain n fd's and n internal queues with state,
	  versus just one.  It is a lot messier in the kernel.
	- User-space developers prefer the current API.  The Beagle
	  guys, for example, love it.  Trust me, I asked.  It is not
	  a surprise: Who'd want to manage and block on 1000 fd's?
	- You'd have to manage the fd's, as an example: call close()
	  when you received a delete event.
	- No way to get out of band data.
	- 1024 is still too low.  ;-)

When you talk about designing a file change notification system that
scales to 1000s of directories, juggling 1000s of fd's just does not
seem the right interface.  It is too heavy.

I should add this to the FAQ, yes.  ;-)

	Robert Love


