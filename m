Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932301AbWDBJAs@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932301AbWDBJAs (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 2 Apr 2006 05:00:48 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932302AbWDBJAs
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 2 Apr 2006 05:00:48 -0400
Received: from smtp108.mail.mud.yahoo.com ([209.191.85.218]:8574 "HELO
	smtp108.mail.mud.yahoo.com") by vger.kernel.org with SMTP
	id S932301AbWDBJAs (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 2 Apr 2006 05:00:48 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
  s=s1024; d=yahoo.com.au;
  h=Received:Message-ID:Date:From:User-Agent:X-Accept-Language:MIME-Version:To:CC:Subject:References:In-Reply-To:Content-Type:Content-Transfer-Encoding;
  b=fAJm9xNDssJFemxy3HbkGd6W34JKSjFnso47vcR0gEZc9Ok21/4P8y3809Q1mTRgjG8VLrVgXnyIC5PGjPLzIJx1GzL/p418wAvVRcGG80nbD4Riq8DWI1oFe3uEZ7iMlIuJomChGRDVzjKSZXb8rOsABdc0eO4ruvLUTdK9g8I=  ;
Message-ID: <442F5E78.9010905@yahoo.com.au>
Date: Sun, 02 Apr 2006 15:17:44 +1000
From: Nick Piggin <nickpiggin@yahoo.com.au>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.7.12) Gecko/20051007 Debian/1.7.12-1
X-Accept-Language: en
MIME-Version: 1.0
To: Andrea Arcangeli <andrea@suse.de>
CC: Andrew Morton <akpm@osdl.org>, hugh@veritas.com,
       linux-kernel@vger.kernel.org
Subject: Re: smp race fix between invalidate_inode_pages* and do_no_page
References: <43C484BF.2030602@yahoo.com.au> <20060111082359.GV15897@opteron.random> <20060111005134.3306b69a.akpm@osdl.org> <20060111090225.GY15897@opteron.random> <20060111010638.0eb0f783.akpm@osdl.org> <20060111091327.GZ15897@opteron.random> <Pine.LNX.4.61.0601111949070.6448@goblin.wat.veritas.com> <43C75834.3040007@yahoo.com.au> <20060112234726.676c3873.akpm@osdl.org> <43C782F3.1090803@yahoo.com.au> <20060331123622.GB18093@opteron.random>
In-Reply-To: <20060331123622.GB18093@opteron.random>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Andrea, seems good to me.

Andrea Arcangeli wrote:

> The PG_truncate is needed as well because we can't know in do_no_page if
> page->mapping is legitimate null or not (think bttv and other device
> drivers returning page->mapping null because they're private but not
> reserved pages etc..)
> 
> From: Andrea Arcangeli <andrea@suse.de>
> Subject: avoid race between invalidate_inode_pages2 and do_no_page
> 
> Use page lock and new bitflag to serialize.
> 

As clean upstream solution, could we make truncatable (ie. regular
file backed) mappings set a vma flag which changes its nopage protocol
to return a locked page?

filemap_nopage itself, rather than do_no_page would then take care of
handling the truncate races. That seems to be a better layer to handle
it in.

Also, after this there should be no reason for truncate_count, right?
(At least in its truncate/nopage capacity.) If so, we should remove it
as part of the same patch / patchset.

-- 
SUSE Labs, Novell Inc.
Send instant messages to your online friends http://au.messenger.yahoo.com 
