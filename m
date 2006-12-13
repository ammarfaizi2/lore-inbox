Return-Path: <linux-kernel-owner+w=401wt.eu-S964892AbWLMB5Y@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964892AbWLMB5Y (ORCPT <rfc822;w@1wt.eu>);
	Tue, 12 Dec 2006 20:57:24 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964889AbWLMB5Y
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 12 Dec 2006 20:57:24 -0500
Received: from smtp108.mail.mud.yahoo.com ([209.191.85.218]:45649 "HELO
	smtp108.mail.mud.yahoo.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with SMTP id S964892AbWLMB5X (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 12 Dec 2006 20:57:23 -0500
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
  s=s1024; d=yahoo.com.au;
  h=Received:X-YMail-OSG:Message-ID:Date:From:User-Agent:X-Accept-Language:MIME-Version:To:CC:Subject:References:In-Reply-To:Content-Type:Content-Transfer-Encoding;
  b=agQ9PY9UusKrrULKEC5i0PQDDQrMcWbYYWHlBX+bdjbmOxGWlj0ElWmWEuiGFDW5HuDYjVZDCObGD/oVQdxzzoP71WGBOdWeKJoryh1xDHFmUNd9ZtfF5Y3y5w9oDEx/2zDIU7aP3ja5Gg7KhlXsojCRyG27CvZQlZTlbKBCi/0=  ;
X-YMail-OSG: HR2VXTIVM1nCItxYcLUOtsEZbWoooL1js1j_rYJD9gBE9a5eWi.CI0ahfef_mn2WI9PirdPeBlrGRLPrV2_iKWx3LM.0AaZfQ8pPMOoKmZpxjcsfJPbwa38uJe9n.Se14mL28JLMs9OMaaU-
Message-ID: <457F5DD8.3090909@yahoo.com.au>
Date: Wed, 13 Dec 2006 12:56:40 +1100
From: Nick Piggin <nickpiggin@yahoo.com.au>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.7.12) Gecko/20051007 Debian/1.7.12-1
X-Accept-Language: en
MIME-Version: 1.0
To: Trond Myklebust <trond.myklebust@fys.uio.no>
CC: Mark Fasheh <mark.fasheh@oracle.com>,
       Linux Memory Management <linux-mm@kvack.org>,
       linux-fsdevel@vger.kernel.org,
       linux-kernel <linux-kernel@vger.kernel.org>,
       OGAWA Hirofumi <hirofumi@mail.parknet.co.jp>,
       Andrew Morton <akpm@google.com>
Subject: Re: Status of buffered write path (deadlock fixes)
References: <45751712.80301@yahoo.com.au>	 <20061207195518.GG4497@ca-server1.us.oracle.com>	 <4578DBCA.30604@yahoo.com.au>	 <20061208234852.GI4497@ca-server1.us.oracle.com>	 <457D20AE.6040107@yahoo.com.au> <457D7EBA.7070005@yahoo.com.au>	 <20061212223109.GG6831@ca-server1.us.oracle.com>	 <457F4EEE.9000601@yahoo.com.au> <1165974458.5695.17.camel@lade.trondhjem.org>
In-Reply-To: <1165974458.5695.17.camel@lade.trondhjem.org>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Trond Myklebust wrote:
> On Wed, 2006-12-13 at 11:53 +1100, Nick Piggin wrote:
> 
> 
>>Not silly -- I guess that is the main sticking point. Luckily *most*
>>!uptodate pages will be ones that we have newly allocated so will
>>not be in pagecache yet.
>>
>>If it is in pagecache, we could do one of a number of things: either
>>remove it or try to bring it uptodate ourselves. I'm not yet sure if
>>either of these actions will cause other problems, though :P
>>
>>If both of those are really going to cause problems, then we could
>>solve this in a more brute force way (assuming that !uptodate, locked
>>pages, in pagecache at this point are very rare -- AFAIKS these will
>>only be caused by IO errors?). We could allocate another, temporary
>>page and copy the contents into there first, then into the target
>>page after the prepare_write.
> 
> 
> We are NOT going to mandate read-modify-write behaviour on
> prepare_write()/commit_write(). That would be a completely unnecessary
> slowdown for write-only workloads on NFS.

Note that these pages should be *really* rare. Definitely even for normal
filesystems I think RMW would use too much bandwidth if it were required
for any significant number of writes.

I don't want to mandate anything just yet, so I'm just going through our
options. The first two options (remove, and RMW) are probably trickier
than they need to be, given the 3rd option available (temp buffer). Given
your input, I'm increasingly thinking that the best course of action would
be to fix this with the temp buffer and look at improving that later if it
causes a noticable slowdown.

Thanks,
Nick

-- 
SUSE Labs, Novell Inc.
Send instant messages to your online friends http://au.messenger.yahoo.com 
