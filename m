Return-Path: <linux-kernel-owner+willy=40w.ods.org-S266349AbUHFCTk@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266349AbUHFCTk (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 5 Aug 2004 22:19:40 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S268059AbUHFCTk
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 5 Aug 2004 22:19:40 -0400
Received: from smtp101.mail.sc5.yahoo.com ([216.136.174.139]:28596 "HELO
	smtp101.mail.sc5.yahoo.com") by vger.kernel.org with SMTP
	id S266349AbUHFCTa (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 5 Aug 2004 22:19:30 -0400
Message-ID: <4112EAAB.8040005@yahoo.com.au>
Date: Fri, 06 Aug 2004 12:19:23 +1000
From: Nick Piggin <nickpiggin@yahoo.com.au>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.7.1) Gecko/20040726 Debian/1.7.1-4
X-Accept-Language: en
MIME-Version: 1.0
To: Phillip Lougher <phillip@lougher.demon.co.uk>
CC: linux-kernel@vger.kernel.org, Andrew Morton <akpm@osdl.org>,
       viro@parcelfarce.linux.theplanet.co.uk
Subject: Re: [PATCH] VFS readahead bug in 2.6.8-rc[1-3]
References: <41127371.1000603@lougher.demon.co.uk> <4112D6FD.4030707@yahoo.com.au>
In-Reply-To: <4112D6FD.4030707@yahoo.com.au>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Nick Piggin wrote:

> Phillip Lougher wrote:
>
>> Hi,
>>
>> There is a readahead bug in do_generic_mapping_read (filemap.c).  This
>> bug appears to have been introduced in 2.6.8-rc1.  Specifically the bug
>> is caused by an incorrect code change which causes VFS to call
>> readpage() for indexes beyond the end of files where the file length is
>> zero or a 4k multiple.
>>
>> In Squashfs this causes a variety of almost immediate OOPes because
>> Squashfs trusts the VFS not to pass invalid index values.  For other
>> filesystems it may also be causing subtle bugs.  I have received
>> prune_dcache oopes similar to Gene Heskett's (which was also
>> pointer corruption), and so it may fix this and other reported
>> readahead bugs.
>>
>> The patch is against 2.6.8-rc3.
>>
>
> Good work - bug is mine, sorry.
>

On second thought, maybe not. I think your filesystem is at fault.

Firstly, there possibly is a bug in do_pagecache_readahead which allows 
it to
read off the end of the file in a completely serialised situation. But 
even so,
notice the absence of locking - i_size can change at any time can't it? Then
your fix will blow up when you race with a truncate, right?

I think you need to handle reading off the end of the file properly: I'm not
too familiar with this code, but IIRC you are allowed to setup pagecache 
past
the end of the file - it gets handled correctly in 
do_generic_mapping_read, and
ends up falling off the LRU. This should help you.

