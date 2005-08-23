Return-Path: <linux-kernel-owner+willy=40w.ods.org-S965070AbVHZPJR@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965070AbVHZPJR (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 26 Aug 2005 11:09:17 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965072AbVHZPJQ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 26 Aug 2005 11:09:16 -0400
Received: from smtp004.mail.ukl.yahoo.com ([217.12.11.35]:60507 "HELO
	smtp004.mail.ukl.yahoo.com") by vger.kernel.org with SMTP
	id S965070AbVHZPJQ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 26 Aug 2005 11:09:16 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
  s=s1024; d=yahoo.it;
  h=Received:From:To:Subject:Date:User-Agent:Cc:References:In-Reply-To:MIME-Version:Content-Type:Content-Transfer-Encoding:Content-Disposition:Message-Id;
  b=LSsqLfrRvt3XTrt4zYSo2FnBpT3upb4fjprs7j536uA2F9AW56UqN8uTtsTaAT7X8TROiepz2GKOA0BELzdnYJuAPIIsttcWlhdqeR2LTW5dbiOrl6jMEkiBsoCzYekVP1JjbmvRGKxZlv8ejz4NYtjF56M5LeUP549ms3jg4W4=  ;
From: Blaisorblade <blaisorblade@yahoo.it>
To: Benjamin LaHaise <bcrl@kvack.org>
Subject: Re: [patch 1/1] uml: fixes performance regression in activate_mm and thus exec()
Date: Tue, 23 Aug 2005 11:57:15 +0200
User-Agent: KMail/1.8.1
Cc: LKML <linux-kernel@vger.kernel.org>, Jeff Dike <jdike@addtoit.com>
References: <20050812175914.2946A24EA14@zion.home.lan> <20050812201145.GA10796@kvack.org>
In-Reply-To: <20050812201145.GA10796@kvack.org>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200508231157.16118.blaisorblade@yahoo.it>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Friday 12 August 2005 22:11, Benjamin LaHaise wrote:
> Is it possible to get an optimization for this case where uml can execute
> the kernel thread in the same process as it normally executes kernel mode
> for the given mm?  AIO performance on uml is pretty bad when it has to
> access userspace.
I thought to another solution to that, i.e. use get_user_pages() and kmap() 
the resulting pages, like other kernel threads do when accessing userspace 
context.

However, by looking at the code (starting from aio_pread), maybe AIO reuses 
too much normal I/O code to do this.

Actually, the changes wouldn't maybe be so intrusive, they're limited to 
__generic_file_aio_read (conditionalize access_ok, and change the setup of 
read_descriptor_t) and file_read_actor, plus the write side, plus anything 
not using  pagecache - generic_file_aio_read.

Having a different actor for AIO would work. The real problem is adding a 
field to iovec to specify whether we're passing in a page array (given by 
get_user_pages) rather than a void __user *, or passing an iovec "wrapper" 
structure, which can carry either a normal iovec or the new kind of 
descriptor.

However, this does not sound like too much added complexity. Instead, allowing 
to move a kernel thread elsewhere on the host is a lot more difficult.
-- 
Inform me of my mistakes, so I can keep imitating Homer Simpson's "Doh!".
Paolo Giarrusso, aka Blaisorblade (Skype ID "PaoloGiarrusso", ICQ 215621894)
http://www.user-mode-linux.org/~blaisorblade


	

	
		
___________________________________ 
Yahoo! Mail: gratis 1GB per i messaggi e allegati da 10MB 
http://mail.yahoo.it
