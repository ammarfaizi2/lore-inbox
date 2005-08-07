Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750768AbVHGCrK@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750768AbVHGCrK (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 6 Aug 2005 22:47:10 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750773AbVHGCrK
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 6 Aug 2005 22:47:10 -0400
Received: from smtp105.rog.mail.re2.yahoo.com ([206.190.36.83]:26256 "HELO
	smtp105.rog.mail.re2.yahoo.com") by vger.kernel.org with SMTP
	id S1750768AbVHGCrJ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 6 Aug 2005 22:47:09 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
  s=s1024; d=rogers.com;
  h=Received:Subject:From:To:Cc:In-Reply-To:References:Content-Type:Date:Message-Id:Mime-Version:X-Mailer:Content-Transfer-Encoding;
  b=ksf9KPQoZJbTg4vZhJEP0oynNA6enf1SvacsITCdyQtbNFgPpAhDaS1c1v2uzxeGNOkkTwPb6vcssTb/Et2wInnIJrZ4HViX54xZe8mA9zmt1TQB8uuYvYTB2zqPqabvwwqydrtN1WMi+9+1l2cES4KZO3zmcZTa82pJyRljN/I=  ;
Subject: Re: Freeing a dynamic struct cdev
From: "James C. Georgas" <jgeorgas@rogers.com>
To: "Randy.Dunlap" <rdunlap@xenotime.net>
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <20050806155958.5f3092bc.rdunlap@xenotime.net>
References: <1123334776.29913.3.camel@Tachyon.home>
	 <20050806122108.4a458c68.rdunlap@xenotime.net>
	 <1123356380.13845.2.camel@Tachyon.home>
	 <20050806122849.452290e2.rdunlap@xenotime.net>
	 <1123362724.13845.11.camel@Tachyon.home>
	 <20050806155958.5f3092bc.rdunlap@xenotime.net>
Content-Type: text/plain
Date: Sat, 06 Aug 2005 22:47:04 -0400
Message-Id: <1123382825.15705.18.camel@Tachyon.home>
Mime-Version: 1.0
X-Mailer: Evolution 2.2.3 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Ok, I really blew it with that last post:

> 
> cdev_add() calls:
> 	kobj_map()
> 	kobject_get() [indirectly]
> 

This is wrong. When I first looked at it, I saw:

cdev_add() -> kobj_map() -> exact_lock() -> cdev_get() -> kobject_get()

but exact_lock() isn't called here; it is only passed as a function
pointer to kobj_map(), and so calling cdev_add() does /not/ increment
the reference count of the struct cdev.

I guess what threw me for a loop here was that I was expecting separate
functions: one to undo cdev_add() and one to undo cdev_alloc(), but
cdev_del() accomplishes both tasks in one function, with the
kobj_unmap() part having no effect, if the cdev is not mapped at the
time of the call.

-- 
James C. Georgas <jgeorgas@rogers.com>

