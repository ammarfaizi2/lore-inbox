Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129345AbQKGSVo>; Tue, 7 Nov 2000 13:21:44 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129352AbQKGSVf>; Tue, 7 Nov 2000 13:21:35 -0500
Received: from vger.timpanogas.org ([207.109.151.240]:22790 "EHLO
	vger.timpanogas.org") by vger.kernel.org with ESMTP
	id <S129345AbQKGSVR>; Tue, 7 Nov 2000 13:21:17 -0500
Message-ID: <3A084738.EF27BE8F@timpanogas.org>
Date: Tue, 07 Nov 2000 11:17:28 -0700
From: "Jeff V. Merkey" <jmerkey@timpanogas.org>
Organization: TRG, Inc.
X-Mailer: Mozilla 4.7 [en] (WinNT; I)
X-Accept-Language: en
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org
Subject: sendmail has low memory problems on 2.4.0 - Working Sets Required? 
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Linus/Rik,

I might be missing something, but with final load testing of NWFS on
2.4, I occasionally see sendmail fail to accept connections on a live
internet server when low memory conditions are present.  I reviewed the
buffer cache, and it does appear that periodically buffer cache pages
get freed and the buffer cache shrinks when memory gets low, however,
the code that does this gets kicked by calling sync() functions and
seems to happen in bdflush.  

I've plummed NWFS to mimic the buffer cache in-kernel with the same
memory calls.  The size the cache could grow to in 2.2.X was based on
some global variables that looked at high and low water marks before
freeing pages out of the buffer cache.  In 2.4, the bdflush daemon
appears to do this and comically, has a CHECK_EMERGENCY_SYNC macro it
calls, then frantically attempts to flush and free pages.  

I have found that even with this in place, I am still seeing sendmail
and other internet daemons  start dropping connections when heavy I/O
loading is occurring, like an NFS copy over 100 mbit ethernet while a
large numberof ftp downloads are occuring simultaneously.  

I am wondering if anyone has or considered a registration funtion to
provide working set-like functinality, so Rik's VM could signal (by
calling an API) into the buffer cache and my LRU to brute-force release
pages and ask the buffer cache or some other registered agent to return
pages when memory becomes low.  UnixWare uses working sets and allows
Cache agents (like the buffer cache and the NWFS LRU) to register a
working set callback to request free pages when memory gets low.  The VM
performance has been getting better in 2.4, but this low memory problem
has gotten worse for some reason.  I am seeing sendmail drop and refuse
connections  more often than seems to happen on 2.2.X.

The way the code in structured, it appears that bdflush has to get woken
up before the buffer cache can free memory rather than allowing an agent
to come in via an API and just take it.  I have found that when my AMD
650Mhz server gets realy busy, the method being used in bdflush isn't
working as intended because it does not seem to be getting cycles.

The console lockup problem is also apparently here, because bdflush is
masking off signals then trying to flush all the dirty pages to free up
memory -- causing the server to process stuff in "waves" (king of like a
car with an engine that has a bad spark plug or two lurching along the
road as it stalls and lurches, stalls and lurches -- rather than
smoothly cycling memory through the box.

I can work around for now, but perhaps I am missing something.  I would
like to know if there's a better way to get signals from the OS about
returning pages.  Having something as simple as a global event registry
for page *return_a_page_if_you_can() function for consumers of a lot of
pages would be very helpful and allow me to return memory more smoothly
than guessing and grepping around with global high and low water marks
in the OS.

:-)

Jeff
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
