Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262380AbUFJHqp@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262380AbUFJHqp (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 10 Jun 2004 03:46:45 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264524AbUFJHqp
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 10 Jun 2004 03:46:45 -0400
Received: from rwcrmhc13.comcast.net ([204.127.198.39]:59565 "EHLO
	rwcrmhc13.comcast.net") by vger.kernel.org with ESMTP
	id S262380AbUFJHqn (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 10 Jun 2004 03:46:43 -0400
From: "Buddy Lumpkin" <b.lumpkin@comcast.net>
To: "'Bill Davidsen'" <davidsen@tmr.com>,
       "'John Bradford'" <john@grabjohn.com>
Cc: "'Rik van Riel'" <riel@redhat.com>,
       "=?iso-8859-1?Q?'Lasse_K=E4rkk=E4inen_/_Tronic'?=" <tronic2@sci.fi>,
       <linux-kernel@vger.kernel.org>
Subject: RE: Some thoughts about cache and swap
Date: Thu, 10 Jun 2004 00:47:32 -0700
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
X-Mailer: Microsoft Office Outlook, Build 11.0.5510
In-Reply-To: <40C76861.4040600@tmr.com>
X-MimeOLE: Produced By Microsoft MimeOLE V6.00.2800.1409
Thread-Index: AcROWi4P/0FaXUgjTA6GoV19Bc35CwAYh7Sw
Message-Id: <S262380AbUFJHqn/20040610074643Z+777@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>> Is the current system really bad enough to make it worthwhile, though?

> Yes! The current implementation just uses all the memory available, and 
> pushes any programs not actively running out to disk. Click the window 
> and go for coffee. On a small machine that's needed, but for almost any 
> typical usage, desktop or server, pushing out programs to have 3.5GB of 
> buffer instead of 3.0 doesn't help disk performance.

And for these larger systems, a simple list where pages are evicted from the
tail, and pages that are referenced are moved back to the head creates a
very natural, light overhead LRU mechanism for the page cache.

If this list can be treated as free memory, then pages_low would only be
reached in a true memory shortage. In that case, by all means walk all pages
in memory in a non-descriminating fashion looking for pages to evict. When I
say "true memory shortage", I am referring to cases like Bill's excellent
analogy above where 500mb of executables and anonymous memory are evicted
from memory so that the pagecache can grow from 3GB to 3.5GB. This is
exactly how I see this issue, probably because I have spent most of my time
working on large systems that are sized such that I never expect the working
set to exceed physical RAM, and there is plenty (many GB) of free memory for
pagecache).

If the VM were implemented this way, so long as you are willing to waste
some memory, you can benefit from minimal performance impact to a large
system due to memory pressure from I/O.

For the people that just can't stand the thought of keeping old anonymous
pages resident when they could be evicted to save precious memory, then add
a desktop knob that allows you to choose how much of the page cache is
considered "free memory". That way pages_low will be reached sooner and the
desired effect of evicting old anonymous pages from memory will occur as the
more expensive and accurate LRU mechanism is awaken.

Lastly, it would be really nice if the parts of an executable address space
that are backed by a named file could be preferenced, skipped over or
whatever to keep executables from being evicted only to be faulted back in,
but I'll keep my wish list short for now :)

--Buddy



>> Is there really much performance to be gained from tuning the 'limited'
>> cache
>> space, or will it just hurt as many or more systems than it helps?

> I doubt it, but it would be nice to have a tuner the admin could use 
> instead of trying to guess what the priority of program response and i/o 
> response should be. So if I have a graphics program which might open an 
> image (small file) and decompress it into 1500MB of raw image, I can set 
>  the buffer space down to a GB or so (I assume that I do this on a 
> machine fitted to such use) and get good response.



