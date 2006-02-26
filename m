Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751124AbWBZNur@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751124AbWBZNur (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 26 Feb 2006 08:50:47 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751129AbWBZNur
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 26 Feb 2006 08:50:47 -0500
Received: from smtp109.mail.mud.yahoo.com ([209.191.85.219]:8287 "HELO
	smtp109.mail.mud.yahoo.com") by vger.kernel.org with SMTP
	id S1751124AbWBZNuq (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 26 Feb 2006 08:50:46 -0500
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
  s=s1024; d=yahoo.com.au;
  h=Received:Message-ID:Date:From:User-Agent:X-Accept-Language:MIME-Version:To:CC:Subject:References:In-Reply-To:Content-Type:Content-Transfer-Encoding;
  b=Rhapx7zihsE0iHmyA+v5JKswFimwdGHRqFClYTnaAL70wsrxvu97KI0+c79wE7ENvZJVwqBxLgzETtD/hjR7f+Zwf2+p6gJeNDEbvOFp1QXqr8hZ0jedz53h72nfbBrJg0wcLm7NtxPIzDeYWW8wD2pJjgz4CN6I77eG7WyAhSQ=  ;
Message-ID: <4401B233.7050308@yahoo.com.au>
Date: Mon, 27 Feb 2006 00:50:43 +1100
From: Nick Piggin <nickpiggin@yahoo.com.au>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.7.12) Gecko/20051007 Debian/1.7.12-1
X-Accept-Language: en
MIME-Version: 1.0
To: Ingo Oeser <ioe-lkml@rameria.de>
CC: linux-kernel@vger.kernel.org, Andrew Morton <akpm@osdl.org>,
       Marr <marr@flex.com>, reiserfs-dev@namesys.com
Subject: Re: Drastic Slowdown of 'fseek()' Calls From 2.4 to 2.6 -- VMM Change?
References: <200602241522.48725.marr@flex.com> <20060224211650.569248d0.akpm@osdl.org> <200602261407.33262.ioe-lkml@rameria.de>
In-Reply-To: <200602261407.33262.ioe-lkml@rameria.de>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Ingo Oeser wrote:
> On Saturday, 25. February 2006 06:16, Andrew Morton wrote:
> 
>>runs like a dog on 2.6's reiserfs.  libc is doing a (probably) 128k read
>>on every fseek.
> 
> 
> Thats the bug. If I seek, I never like to have an read issued.
> seek should just return whether the result is a valid offset 
> in the underlying object. 
> 
> It is perfectly valid to have a real time device which produces data 
> very fast and where you are allowed to skip without reading anything.
> 
> This device coul be a pipe, which just allows forward seeking for exactly
> this (implemented by me some years ago).
> 
> 
>>- fseek is a pretty dumb function anyway - you're better off with
>>  stateless functions like pread() - half the number of syscalls, don't
>>  have to track where the file pointer is at.  I don't know if there's a
>>  pread()-like function in stdio though?
> 
> 
> pread and anything else not using RELATIVE descriptor offsets are not
> very useful for pipe like interfaces that can seek, but just forward.
> 
> There are even cases, where you can seek forward and backward, but 
> only with relative offsets ever, because you have a circular buffer indexed by time.
> If you like to get the last N minutes, the relative index is always stable, 
> but the absolute offset jumps.
> 
> So I hope glibc will fix fseek to work as advertised.
> 
> But for the simple file case all your answers are valid.
> 

Not really. The app is not silly if it does an fseek() then a _write_.
Writing page sized and aligned chunks should not require previously
uptodate pagecache, so doing a pre-read like this is a complete waste.

Actually glibc tries to turn this pre-read off if the seek is to a page
aligned offset, presumably to handle this case. However a big write
would only have to RMW the first and last partial pages, so pre-reading
128KB in this case is wrong.

And I would also say a 4K read is wrong as well, because a big read will
be less efficient due to the extra syscall and small IO.

-- 
SUSE Labs, Novell Inc.
Send instant messages to your online friends http://au.messenger.yahoo.com 
