Return-Path: <linux-kernel-owner+willy=40w.ods.org-S263464AbUDZVVq@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263464AbUDZVVq (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 26 Apr 2004 17:21:46 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263581AbUDZVVq
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 26 Apr 2004 17:21:46 -0400
Received: from stogtw01.enlight.net ([212.209.183.10]:35081 "EHLO
	stodns01.enlightnet.local") by vger.kernel.org with ESMTP
	id S263464AbUDZVVo (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 26 Apr 2004 17:21:44 -0400
Date: Mon, 26 Apr 2004 23:21:37 +0200 (CEST)
From: Urban Widmark <urban@teststation.com>
X-X-Sender: puw@cola.local
To: Christoph Lameter <christoph@lameter.com>
cc: linux-kernel@vger.kernel.org
Subject: Re: CIFS/SMBFS failing under load in 2.6.X
In-Reply-To: <Pine.LNX.4.58.0404221750070.14856@server.home>
Message-ID: <Pine.LNX.4.44.0404262250540.5810-100000@cola.local>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
X-OriginalArrivalTime: 26 Apr 2004 21:21:42.0161 (UTC) FILETIME=[781F8810:01C42BD4]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 22 Apr 2004, Christoph Lameter wrote:

> Well the server is under very high load in this test (up to 200) and the
> response times are also extremely high. Are timeouts new in 2.6.x? SMBFS
> in 2.4.X does not seem to timeout.

Both have a timeout but they are different. I think that if smbfs-2.4
doesn't get any data for 30sec it aborts. 2.6 wants the full reply within
that time. So the 2.4 code should be happy with 1 byte every 29.9 seconds.

Also 2.4 smbfs never has more than one request active. Is the load the 
same?

I should check the code, but I guess that a timeout is counted as a likely 
network problem. So that could be why it reconnects. Lots of reconnections 
== higher load?

You can increase the timeout with the 'timeo' option. Set it to a couple 
of minutes and see if that helps any.


> Also are there any fixes for the 4KB size limitation? Windows allows 64K
> writes and reads in one request. SMBFS only 4K.

Yes, I'm well aware of that limitation. I started looking at readahead and
read/write coalescing for the 2.4 interface but I never finished it.

The readahead code I had didn't make it noticably faster in most cases, so
it didn't feel that important to get it done (it did merge the requests).
There was some specific condition where it did help a bit but I don't
remember what that was. Could have been when transfering data over a
higher latency connection.

For 2.6 the readpages/writepages interface needs to be implemented,
probably quite similar to the smb_readpage/smb_writepage code. Possibly
with some changes to smb_proc_writeX/readX and the smb_request struct.

If you are interested in doing it I could try to give you some pointers on
how I think it can be done. If you want me to do it, sure. Just remind me
in a week or so when I haven't responded. :)

/Urban

