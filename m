Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932557AbWG0KDT@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932557AbWG0KDT (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 27 Jul 2006 06:03:19 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932559AbWG0KDT
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 27 Jul 2006 06:03:19 -0400
Received: from smtp110.mail.mud.yahoo.com ([209.191.85.220]:65420 "HELO
	smtp110.mail.mud.yahoo.com") by vger.kernel.org with SMTP
	id S932557AbWG0KDS (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 27 Jul 2006 06:03:18 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
  s=s1024; d=yahoo.com.au;
  h=Received:Message-ID:Date:From:User-Agent:X-Accept-Language:MIME-Version:To:CC:Subject:References:In-Reply-To:Content-Type:Content-Transfer-Encoding;
  b=R/zLtEflJTdR1CebKMDufor2zKY5GN/u9j2eM+O4cmtevBcGta5lRi16XQjWKLdT5wra01CsCyVQNiokE21ic/TueZQ2GY/sPnQb4fHMpc87M/tCnsSH0NQyMqr3WmByesQk2Brvy1ZCrcToRFxrv1PGIhaqp0UZ44SS8WVxLks=  ;
Message-ID: <44C88F46.9010201@yahoo.com.au>
Date: Thu, 27 Jul 2006 20:02:46 +1000
From: Nick Piggin <nickpiggin@yahoo.com.au>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.7.12) Gecko/20051007 Debian/1.7.12-1
X-Accept-Language: en
MIME-Version: 1.0
To: Anton Altaparmakov <aia21@cam.ac.uk>
CC: Andrew Morton <akpm@osdl.org>, eike-kernel@sf-tec.de,
       linux-kernel@vger.kernel.org, aia21@cantab.net
Subject: Re: [BUG?] possible recursive locking detected
References: <200607261805.26711.eike-kernel@sf-tec.de>	 <20060726225311.f51cee6d.akpm@osdl.org> <44C86271.9030603@yahoo.com.au>	 <1153984527.21849.2.camel@imp.csi.cam.ac.uk>	 <20060727003806.def43f26.akpm@osdl.org>	 <1153988398.21849.16.camel@imp.csi.cam.ac.uk>	 <44C884EF.6010705@yahoo.com.au> <1153992928.21849.41.camel@imp.csi.cam.ac.uk>
In-Reply-To: <1153992928.21849.41.camel@imp.csi.cam.ac.uk>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Anton Altaparmakov wrote:
> On Thu, 2006-07-27 at 19:18 +1000, Nick Piggin wrote:
> 
>>Anton Altaparmakov wrote:

>>>I beg to differ.  It is a bug.  You cannot reenter the file system when
>>>the file system is trying to allocate memory.  Otherwise you can never
>>>allocate memory with any locks held or you are bound to introduce an
>>>A->B B->A deadlock somewhere.
>>
>>I don't think it is a bug in general. It really depends on the allocation:
>>
>>- If it is a path that might be required in order to writeout a page, then
>>yes GFP_NOFS is going to help prevent deadlocks.
>>
>>- If it is a path where you'll take the same locks as page reclaim requires,
>>then again GFP_NOFS is required.
>>
>>For NTFS case, it seems like holding i_mutex on the write path falls foul
>>of the second problem. But I agree with Andrew that this is a critical case
>>where we do have to enter the fs. GFP_NOFS is too big a hammer to use.
>>
>>I guess you'd have to change NTFS to do something sane privately, or come
>>up with a nice general solution that doesn't harm the common filesystems
>>that apparently don't have a problem here... can you just add GFP_NOFS to
>>NTFS's mapping_gfp_mask to start with?
> 
> 
> I don't think NTFS has a problem either.  It is a theoretical problem

No, I mean: *really* doesn't have a problem. If Andrew says ext2 doesn't
need i_mutex in reclaim, then I tend to believe him.

> with an extremely small chance of being hit.  I am happy to have such a
> problem for now.  There are more pressing problems to solve.  The only
> thing that needs to happen is for the messages to stop so people stop
> complaining / getting worried about them...

I guess the memory deadlock issue is probably mostly theoretical, although
it is still nice to get them fixed. I'd imagine a deadlock condition -- if
one really exists -- could be hit without much problem though. Page reclaim
will readily get kicked from the write(2) path, and will potentially free
*lots* of stuff from there.

If it isn't a problem for you, I'd suspect it might be due to some other
conditions which happen to mean it is avoided. For example, the inode who's
i_mutex you are holding will have a raised refcount AFAIK, so it will not
get reclaimed and so may get around your problem.

This would be a valid solution IMO. It probably could do with documentation
to outline the issues, though.

-- 
SUSE Labs, Novell Inc.
Send instant messages to your online friends http://au.messenger.yahoo.com 
