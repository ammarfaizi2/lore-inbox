Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S317378AbSGITVB>; Tue, 9 Jul 2002 15:21:01 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S317379AbSGITVA>; Tue, 9 Jul 2002 15:21:00 -0400
Received: from deming-os.org ([63.229.178.1]:17668 "EHLO deming-os.org")
	by vger.kernel.org with ESMTP id <S317378AbSGITVA>;
	Tue, 9 Jul 2002 15:21:00 -0400
Message-ID: <3D2B3833.99029EDE@deming-os.org>
Date: Tue, 09 Jul 2002 12:23:31 -0700
From: Russ Lewis <spamhole-2001-07-16@deming-os.org>
X-Mailer: Mozilla 4.75 [en] (Windows NT 5.0; U)
X-Accept-Language: en
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org
Subject: Re: RE2: [OKS] Module removal
References: <31775.1025581336@kao2.melbourne.sgi.com>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Keith Owens wrote:

> All functions passed to registration routines by modules are uncounted
> references.  A module is loaded, registers its operations and exits
> from the cleanup routine.  At that point its use count is 0, even
> though it there are references to the module from tables outside the
> module.

Perhaps we should have 2 counters: a use count and a reference count.  You can

start the unload process at any time that the use count is 0, but you can't
unload the module's memory until the reference count is 0.  This is the
2-stage unload, formalized with counters for each stage.

You could register references from outside the module.  AFAIK, you can take
any pointer or function pointer and do a lookup to find out what module it
belongs to.  Thus, when you pass pointers (in a registration) to another
module, then it calls some function (register_reference, say) on each pointer
and function pointer.  When it can guarantee that it is about to discard a
pointer (and so it will never use it again), then it calls
unregister_reference.

You may not have to register each pointer in an ops structure...it might be
enough to just call register_reference on the ops structure itself, since that

would hold the module in place.  Doesn't work if the ops structure is
dynamically allocated memory, but then register_reference would be able to
return a failure return code "NOT_MODULE_MEMORY" or some such.

--
The Villagers are Online! villagersonline.com

.[ (the fox.(quick,brown)) jumped.over(the dog.lazy) ]
.[ (a version.of(English).(precise.more)) is(possible) ]
?[ you want.to(help(develop(it))) ]




