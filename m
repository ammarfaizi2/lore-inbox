Return-Path: <linux-kernel-owner+willy=40w.ods.org-S965002AbWEaNoL@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965002AbWEaNoL (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 31 May 2006 09:44:11 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965017AbWEaNoL
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 31 May 2006 09:44:11 -0400
Received: from smtp101.mail.mud.yahoo.com ([209.191.85.211]:56962 "HELO
	smtp101.mail.mud.yahoo.com") by vger.kernel.org with SMTP
	id S965002AbWEaNoK (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 31 May 2006 09:44:10 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
  s=s1024; d=yahoo.com.au;
  h=Received:Message-ID:Date:From:User-Agent:X-Accept-Language:MIME-Version:To:CC:Subject:References:In-Reply-To:Content-Type:Content-Transfer-Encoding;
  b=SoUeM1fDtU9kF0qNfHOLfk8oS8/qJd+x/eyQ4SaSFQfX93a2MLcClEiZHa9Eon1E2QOWJppDH2okKgPjWE4m30yDEodgDQIzk1AZktv35tpOmffQgDngghN3AXVf7A1PpyZLuFW9DMMaj8URgPHfDFHIm/7+pWJzd7SQOPzVTYg=  ;
Message-ID: <447D9D9C.1030602@yahoo.com.au>
Date: Wed, 31 May 2006 23:43:56 +1000
From: Nick Piggin <nickpiggin@yahoo.com.au>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.7.12) Gecko/20051007 Debian/1.7.12-1
X-Accept-Language: en
MIME-Version: 1.0
To: Jens Axboe <axboe@suse.de>
CC: Andrew Morton <akpm@osdl.org>, linux-kernel@vger.kernel.org,
       linux-mm@kvack.org, mason@suse.com, andrea@suse.de, hugh@veritas.com,
       torvalds@osdl.org
Subject: Re: [rfc][patch] remove racy sync_page?
References: <447AC011.8050708@yahoo.com.au> <20060529121556.349863b8.akpm@osdl.org> <447B8CE6.5000208@yahoo.com.au> <20060529183201.0e8173bc.akpm@osdl.org> <447BB3FD.1070707@yahoo.com.au> <20060529201444.cd89e0d8.akpm@osdl.org> <20060530090549.GF4199@suse.de>
In-Reply-To: <20060530090549.GF4199@suse.de>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Jens,
Sorry, I don't think I gave you any reply to this...

Jens Axboe wrote:
> On Mon, May 29 2006, Andrew Morton wrote:
> 
>>
>>Mysterious question, that.  A few years ago I think Jens tried pulling
>>unplugging out, but some devices still want it (magneto-optical
>>storage iirc).  And I think we did try removing it, and it caused
>>hurt.
> 
> 
> I did, back when we had problems due to the blk_plug_lock being a global
> one. I first wanted to investigate if plugging still made a difference,
> otherwise we could've just ripped it out back than and the problem would
> be solved. But it did get us about a 10% boost on normal SCSI drives
> (don't think I tested MO drives at all), so it was fixed up.

Interesting. I'd like to know where from. I wonder if my idea of a
process context plug/unplug would solve it...

> 
> 
>>>With splice, the mapping can change, so you can have the wrong
>>>sync_page callback run against the page.
>>
>>Oh.
> 
> 
> Maybe I'm being dense, but I don't see a problem there. You _should_
> call the new mapping sync page if it has been migrated.

But can some other thread calling lock_page first find the old mapping,
and then run its ->sync_page which finds the new mapping? While it may
not matter for anyone in-tree, it does break the API so it would be
better to either fix it or rip it out than be silently buggy.

>>>
>>>The ->pin() calls in pipe_to_file and pipe_to_sendpage?
>>
>>One for Jens...
> 
> 
> splice never incs/decs any inode related reference counts, so if it
> needs to then yes it's broken. Any references to kernel code that deals
> with that?

Most code in the VM that has an inode/mapping gets called from the VFS,
which already does its thing somehow (I guess something like the file
pins the dentry which pins the inode). An iget might solve it. Or you
could use the lock_page_nosync() if/when the patch goes in (although I
don't want that to spread too far just yet).

-- 
SUSE Labs, Novell Inc.
Send instant messages to your online friends http://au.messenger.yahoo.com 
