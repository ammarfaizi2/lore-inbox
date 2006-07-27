Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750773AbWG0JTI@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750773AbWG0JTI (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 27 Jul 2006 05:19:08 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750967AbWG0JTI
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 27 Jul 2006 05:19:08 -0400
Received: from smtp108.mail.mud.yahoo.com ([209.191.85.218]:56483 "HELO
	smtp108.mail.mud.yahoo.com") by vger.kernel.org with SMTP
	id S1750773AbWG0JTH (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 27 Jul 2006 05:19:07 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
  s=s1024; d=yahoo.com.au;
  h=Received:Message-ID:Date:From:User-Agent:X-Accept-Language:MIME-Version:To:CC:Subject:References:In-Reply-To:Content-Type:Content-Transfer-Encoding;
  b=cgWOblKYqgn2ShsGZPXbG0gLkO+aFKKeRvAuGdAJNE1yihFxcRiTOCgBpMf3MNzAoa3shxy21mBWKkYxli1adm3Fmh3FGBDETZnFMbOsfnijN8esRRESYLzJpEdWPyuSE1CeI9s3bJbB14ENGpAYFsok2edoENasK8xVNapDd2M=  ;
Message-ID: <44C884EF.6010705@yahoo.com.au>
Date: Thu, 27 Jul 2006 19:18:39 +1000
From: Nick Piggin <nickpiggin@yahoo.com.au>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.7.12) Gecko/20051007 Debian/1.7.12-1
X-Accept-Language: en
MIME-Version: 1.0
To: Anton Altaparmakov <aia21@cam.ac.uk>
CC: Andrew Morton <akpm@osdl.org>, eike-kernel@sf-tec.de,
       linux-kernel@vger.kernel.org, aia21@cantab.net
Subject: Re: [BUG?] possible recursive locking detected
References: <200607261805.26711.eike-kernel@sf-tec.de>	 <20060726225311.f51cee6d.akpm@osdl.org> <44C86271.9030603@yahoo.com.au>	 <1153984527.21849.2.camel@imp.csi.cam.ac.uk>	 <20060727003806.def43f26.akpm@osdl.org> <1153988398.21849.16.camel@imp.csi.cam.ac.uk>
In-Reply-To: <1153988398.21849.16.camel@imp.csi.cam.ac.uk>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Anton Altaparmakov wrote:
> On Thu, 2006-07-27 at 00:38 -0700, Andrew Morton wrote:
> 
>>On Thu, 27 Jul 2006 08:15:27 +0100
>>Anton Altaparmakov <aia21@cam.ac.uk> wrote:
>>
>>
>>>>I'm surprised ext2 is allocating with __GFP_FS set, though. Would that
>>>>cause any problem?
>>>
>>>That is an ext2 bug IMO.
>>
>>There is no bug.
>>
>>What there is is an ill-defined set of rules.  If we want to tighten these
>>rules we have a choice between
> 
> 
> I beg to differ.  It is a bug.  You cannot reenter the file system when
> the file system is trying to allocate memory.  Otherwise you can never
> allocate memory with any locks held or you are bound to introduce an
> A->B B->A deadlock somewhere.

I don't think it is a bug in general. It really depends on the allocation:

- If it is a path that might be required in order to writeout a page, then
yes GFP_NOFS is going to help prevent deadlocks.

- If it is a path where you'll take the same locks as page reclaim requires,
then again GFP_NOFS is required.

For NTFS case, it seems like holding i_mutex on the write path falls foul
of the second problem. But I agree with Andrew that this is a critical case
where we do have to enter the fs. GFP_NOFS is too big a hammer to use.

I guess you'd have to change NTFS to do something sane privately, or come
up with a nice general solution that doesn't harm the common filesystems
that apparently don't have a problem here... can you just add GFP_NOFS to
NTFS's mapping_gfp_mask to start with?

-- 
SUSE Labs, Novell Inc.
Send instant messages to your online friends http://au.messenger.yahoo.com 
