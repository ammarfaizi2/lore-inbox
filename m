Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262431AbVGLXnq@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262431AbVGLXnq (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 12 Jul 2005 19:43:46 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262465AbVGLXlh
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 12 Jul 2005 19:41:37 -0400
Received: from ms-smtp-02.nyroc.rr.com ([24.24.2.56]:47254 "EHLO
	ms-smtp-02.nyroc.rr.com") by vger.kernel.org with ESMTP
	id S262458AbVGLXlN (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 12 Jul 2005 19:41:13 -0400
Subject: Re: Merging relayfs?
From: Steven Rostedt <rostedt@goodmis.org>
To: Tom Zanussi <zanussi@us.ibm.com>
Cc: Jason Baron <jbaron@redhat.com>, richardj_moore@uk.ibm.com,
       varap@us.ibm.com, karim@opersys.com, linux-kernel@vger.kernel.org,
       akpm@osdl.org
In-Reply-To: <17108.14426.607378.262959@tut.ibm.com>
References: <17107.6290.734560.231978@tut.ibm.com>
	 <Pine.LNX.4.61.0507121050390.25408@dhcp83-105.boston.redhat.com>
	 <1121183607.6917.47.camel@localhost.localdomain>
	 <17107.60140.948145.153144@tut.ibm.com>
	 <1121185393.6917.59.camel@localhost.localdomain>
	 <17107.61864.621401.440354@tut.ibm.com>
	 <1121186981.6917.67.camel@localhost.localdomain>
	 <17107.63309.475838.635711@tut.ibm.com>
	 <17108.14426.607378.262959@tut.ibm.com>
Content-Type: text/plain
Organization: Kihon Technologies
Date: Tue, 12 Jul 2005 19:40:55 -0400
Message-Id: <1121211655.3548.28.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Evolution 2.2.2 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 2005-07-12 at 16:38 -0500, Tom Zanussi wrote:
> Tom Zanussi writes:
>  > 
>  > 
>  > I was thinking of something simpler, like just using the page array we
>  > already have in relayfs, but not vmap'ing it and instead writing to
>  > the current page, detecting when to split a record, moving on to the
>  > next page, etc. and seeing how it compares with the vmap version.
>  > 
> 
> Just a clarification - I didn't mean to ignore your ring buffers - it
> would be good to try both, I think...

Oh, by all means, simple is usually better.  I didn't take any offense
to not using it.  My ring buffers are quite confusing, and took quite of
bit debugging to finally get them straight.  If you get something that
works then it should be good to go.  My ring buffers were meant to be
always used as a ring buffer that would only save the latest data and
not stop when full.  So, each page had to have it's own start and stop
since the beginning of the buffer could actually be anywhere on any
page. That's because, once the ring buffer filled up, the start of the
buffer would move as you added more data.

A simple approach should be best, but if you start doing the individual
page accounting, and find that it's getting complex to handle all cases,
then it's good to know that my ring buffers are always out there :-)

I will also admit that my ring buffers lost one byte per page.  Because
I wanted to save on space with the accounting, and only had a start and
end pointer per page.  So when start and end were equal, the buffer was
considered empty and when end was one less than start, it was considered
full. But since end always pointed to an empty spot, it would still be
empty when the buffer was full, thus wasting one byte per page. But to
solve this, I would either have to add another variable in the buffer
page descriptor (adding at least one byte, but probably 4 bytes) which
would just be more waste, or I would have to make a complex system even
more complex (ie. adding a flag on the end pointer at the MSB to
differentiate between end being empty or filled).

-- Steve


