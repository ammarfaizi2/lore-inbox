Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S317063AbSIILT6>; Mon, 9 Sep 2002 07:19:58 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S317073AbSIILT6>; Mon, 9 Sep 2002 07:19:58 -0400
Received: from dell-paw-3.cambridge.redhat.com ([195.224.55.237]:24826 "EHLO
	passion.cambridge.redhat.com") by vger.kernel.org with ESMTP
	id <S317063AbSIILT5>; Mon, 9 Sep 2002 07:19:57 -0400
X-Mailer: exmh version 2.5 13/07/2001 with nmh-1.0.4
From: David Woodhouse <dwmw2@infradead.org>
X-Accept-Language: en_GB
In-Reply-To: <20020909121348.B4855@redhat.com> 
References: <20020909121348.B4855@redhat.com>  <2653.1031563253@redhat.com> 
To: "Stephen C. Tweedie" <sct@redhat.com>
Cc: linux-kernel@vger.kernel.org, linux-mm@kvack.org
Subject: Re: [RFC] On paging of kernel VM. 
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Date: Mon, 09 Sep 2002 12:24:40 +0100
Message-ID: <28099.1031570680@redhat.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


sct@redhat.com said:
>  The alternative is a kmap-style mechanism for temporarily mapping
> pages beyond physical memory on demand.

That's a possibility I'd considered, but in this case there are problems
with explicitly mapping and unmapping the pages. The locking of the chip is
a detail I was hoping to avoid exposing to the users of the device. 

With mapping/unmapping done explicitly, not only does an active mapping
prevent all other users from writing to the same device, hence requiring a
'cond_temporarily_unmap()' kind of function, but you also get deadlock if a
user of the device tries to write while they have a mapping active. The
answer "don't do that then" is workable but not preferable. 

Given that all the logic to mark pages present on read and then invalidate
them on write access is going to have to be there for userspace _anyway_,
being able to keep the API nice and simple by using that in kernelspace too
would be far better, if we can justify the change to the slow path of the 
vmalloc fault case.

But yes, what you suggest is the current API for the flash stuff, sans the 
'cond_temporarily_unmap_if_people_are_waiting()' bit. And that's why I've 
avoided actually _using_ it, preferring to put up with the overhead of 
reading into a RAM buffer until we can fix it.

--
dwmw2


