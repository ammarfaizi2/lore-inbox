Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932460AbWDZQJj@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932460AbWDZQJj (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 26 Apr 2006 12:09:39 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932463AbWDZQJj
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 26 Apr 2006 12:09:39 -0400
Received: from smtp106.mail.mud.yahoo.com ([209.191.85.216]:27496 "HELO
	smtp106.mail.mud.yahoo.com") by vger.kernel.org with SMTP
	id S932460AbWDZQJj (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 26 Apr 2006 12:09:39 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
  s=s1024; d=yahoo.com.au;
  h=Received:Message-ID:Date:From:User-Agent:X-Accept-Language:MIME-Version:To:CC:Subject:References:In-Reply-To:Content-Type:Content-Transfer-Encoding;
  b=gluzz+PxeSGeFdbnheKC4K2Tpsd4kAL9bxzOmtNR/WLQ9hRTfodmDOe+WQnNIRlLdHEJnk/v9w1NrtyZy4uz8LeEnKGdo7JdlQafpUcJj9fOD3spJM2ZKCngsGYeQpCsxpDCYxUk3Xc/d9PM3cd2aWtyUCiIfDz7JY7PCi26r34=  ;
Message-ID: <444F3D6B.2070405@yahoo.com.au>
Date: Wed, 26 Apr 2006 19:29:15 +1000
From: Nick Piggin <nickpiggin@yahoo.com.au>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.7.12) Gecko/20051007 Debian/1.7.12-1
X-Accept-Language: en
MIME-Version: 1.0
To: Akinobu Mita <mita@miraclelinux.com>
CC: Al Viro <viro@ftp.linux.org.uk>, Greg KH <greg@kroah.com>,
       Jens Axboe <axboe@suse.de>, linux-kernel@vger.kernel.org, akpm@osdl.org
Subject: Re: [patch 3/3] use kref for bio
References: <20060426021059.235216000@localhost.localdomain> <20060426021122.069267000@localhost.localdomain> <20060426022635.GF27946@ftp.linux.org.uk> <20060426051344.GT4102@suse.de> <20060426051813.GB332@kroah.com> <20060426072030.GA7693@miraclelinux.com> <20060426073944.GL27946@ftp.linux.org.uk>
In-Reply-To: <20060426073944.GL27946@ftp.linux.org.uk>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Al Viro wrote:
> On Wed, Apr 26, 2006 at 03:20:30PM +0800, Akinobu Mita wrote:
> 
>>If this is good one and the places where Al Viro pointed out really affect
>>performance, should we propagate this faster one by introducing helper
>>function like:
>>
>>static inline int refcount_test(atomic_t *refcount)
>>{
>>	return (atomic_read(refcount) == 1) || (atomic_dec_and_test(refcount));
>>}
>>
>>and replace atomic_dec_and_test with it?
> 
> 
> No.  It's obviously slower than atomic_dec_and_test() if refcount is
> greater than 1.  And I'm less than sure that you can show that benefits
> in case when it is 1 outweight that.

Especially with the indirect function call. Modern CPUs often won't load
the destructor pointer quickly enough to avoid the pipeline bubble.

>  Moreover, for dentries, inodes,
> superblocks and vfsmounts you'd have to pull spin_lock() in front of
> it, which would _definitely_ hurt (these are atomic_dec_and_lock()).

Also, it results in altered memory barrier semantics. Whether or not
this is actually an issue anywhere, any conversion would have to be
careful. If a memory barrier is required _anywhere_, it is likely to
be required on the final put.

With all those arguments against it, you need to demonstrate
improvements before it can be considered.

-- 
SUSE Labs, Novell Inc.
Send instant messages to your online friends http://au.messenger.yahoo.com 
