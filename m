Return-Path: <linux-kernel-owner+willy=40w.ods.org-S267184AbUGMWbp@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S267184AbUGMWbp (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 13 Jul 2004 18:31:45 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267173AbUGMWb3
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 13 Jul 2004 18:31:29 -0400
Received: from outmx003.isp.belgacom.be ([195.238.2.100]:3046 "EHLO
	outmx003.isp.belgacom.be") by vger.kernel.org with ESMTP
	id S265814AbUGMWbX (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 13 Jul 2004 18:31:23 -0400
Date: Wed, 14 Jul 2004 00:31:36 +0200
From: Fons Adriaensen <fons.adriaensen@skynet.be>
To: "The Linux Audio Developers' Mailing List" 
	<linux-audio-dev@music.columbia.edu>
Cc: Paul Davis <paul@linuxaudiosystems.com>, florin@sgi.com,
       linux-kernel@vger.kernel.org, albert@users.sourceforge.net
Subject: Re: [linux-audio-dev] Re: desktop and multimedia as an afterthought?
Message-ID: <20040713223136.GB3009@linux>
References: <200407131455.i6DEtmAo006203@localhost.localdomain> <006401c46929$f3edf390$161b14ac@boromir>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <006401c46929$f3edf390$161b14ac@boromir>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jul 13, 2004 at 11:37:12PM +0100, Martijn Sipkema wrote:

> IMHO it is the lack of a mutex implementation with priority ceiling
> or inheritance and the stories about relying on either being a design
> problem that have caused the Linux audio community to not use
> mutexes and declare them non-RT safe while in fact they are
> required according to POSIX to synchronize memory between
> cooperating threads.

Does someone have an authoritive answer to the following question:

   Will using try_lock() on a mutex ever block the caller ?

AFAIK it will not. If this is true I don't see the point of a
lock-free ring buffer at all. You will need some way to wake up the
non-RT thread anyway, in case it went to sleep when finding and
empty ring buffer. This same synchronisation method can be used
to share the state of the buffer between two threads.

For example if you use a counting semaphore (built using a condition
variable and a mutex), the RT thread would increment the sema for
every N samples it adds to a circular buffer, and the consumer will
decrement it for every N samples it reads. Then the state of the sema
at all times reflects the number of samples in the buffer.

If ever the V operation in the RT thread fails (unlikely, but possible
since it has to use try_lock()), it will remember this and increment
by one more the next time.  

The point is that there is no need to use lock-free techniques to
maintain a shared sample count - it's already provided by the sync
mechanism which you need anayway. I've been using this method for
years in critical apps, and never seen it fail.

-- 
FA

