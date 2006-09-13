Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751501AbWIMCQU@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751501AbWIMCQU (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 12 Sep 2006 22:16:20 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751502AbWIMCQT
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 12 Sep 2006 22:16:19 -0400
Received: from smtp104.mail.mud.yahoo.com ([209.191.85.214]:22960 "HELO
	smtp104.mail.mud.yahoo.com") by vger.kernel.org with SMTP
	id S1751501AbWIMCQT (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 12 Sep 2006 22:16:19 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
  s=s1024; d=yahoo.com.au;
  h=Received:Message-ID:Date:From:User-Agent:X-Accept-Language:MIME-Version:To:CC:Subject:References:In-Reply-To:Content-Type:Content-Transfer-Encoding;
  b=lIdaw7eGzXXa0pC1unyTU2tPn0ri9FXG21IgGDrW6y/FzhTjED25xIlMm6ErccEHmJkJ3H7XGEG9jd9/CSDbXFq3x/miVYzV2yFEkyAwYjY3rwQ4+MBAAqkdkxxl7Os2xsBHZokoufELTskTN3duR4W3+s/3HLzveNI1ft4yDX4=  ;
Message-ID: <450769E2.4080904@yahoo.com.au>
Date: Wed, 13 Sep 2006 12:16:02 +1000
From: Nick Piggin <nickpiggin@yahoo.com.au>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.7.12) Gecko/20051007 Debian/1.7.12-1
X-Accept-Language: en
MIME-Version: 1.0
To: David Howells <dhowells@redhat.com>
CC: Matt Mackall <mpm@selenic.com>, Aubrey <aubreylee@gmail.com>,
       linux-kernel@vger.kernel.org, davidm@snapgear.com, gerg@snapgear.com
Subject: Re: kernel BUGs when removing largish files with the SLOB allocator
References: <20060912174339.GA19707@waste.org>  <6d6a94c50609032356t47950e40lbf77f15136e67bc5@mail.gmail.com> <17162.1157365295@warthog.cambridge.redhat.com> <6d6a94c50609042052n4c1803eey4f4412f6153c4a2b@mail.gmail.com> <3551.1157448903@warthog.cambridge.redhat.com> <6d6a94c50609051935m607f976j942263dd1ac9c4fb@mail.gmail.com> <44FE4222.3080106@yahoo.com.au> <6d6a94c50609120107w1942a8d8j368dd57a271d0250@mail.gmail.com> <15193.1158088232@warthog.cambridge.redhat.com>
In-Reply-To: <15193.1158088232@warthog.cambridge.redhat.com>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

David Howells wrote:
> Matt Mackall <mpm@selenic.com> wrote:
> 
> 
>>>+		for (i = 0; i < (1 << bb->order); i++) {
>>>+			SetPageSlab(page);
>>>+			page++;
>>>+		}
>>
>>for ( ; page < page + (1 << bb->order), page++)
>>      SetPageSlab(page);
> 
> 
> Ugh.  No.  You can't do that.  "page < page + X" will be true until "page + X"
> wraps the end of memory.
> 
> 
>>>+				for (i = 0; i < (1 << bb->order); i++) {
>>>+					if (!TestClearPageSlab(page))
>>>+						BUG();
>>>+					page++;
>>>+				}
>>
>>Please drop the BUG. We've already established it's on our lists by
>>this point.
> 
> 
> I disagree.  Let's catch accidental reuse of pages.  It should, however, be
> marked unlikely().

If you do this, the biggest problem with those ops is that they are atomic,
and the latter also requires strong memory barriers. Don't use RMW variants,
and use __ prepended iff you are the only user of the page at this point.

-- 
SUSE Labs, Novell Inc.
Send instant messages to your online friends http://au.messenger.yahoo.com 
