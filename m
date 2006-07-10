Return-Path: <linux-kernel-owner+willy=40w.ods.org-S965292AbWGJWpq@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965292AbWGJWpq (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 10 Jul 2006 18:45:46 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965299AbWGJWpq
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 10 Jul 2006 18:45:46 -0400
Received: from hobbit.corpit.ru ([81.13.94.6]:43872 "EHLO hobbit.corpit.ru")
	by vger.kernel.org with ESMTP id S965292AbWGJWpp (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 10 Jul 2006 18:45:45 -0400
Message-ID: <44B2D893.9050209@tls.msk.ru>
Date: Tue, 11 Jul 2006 02:45:39 +0400
From: Michael Tokarev <mjt@tls.msk.ru>
Organization: Telecom Service, JSC
User-Agent: Mail/News 1.5 (X11/20060318)
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org
Subject: functions returning 0 on success [was: [PATCH] Fix a memory leak
 in the i386 setup code]
References: <20060710221308.5351.78741.stgit@localhost.localdomain>
In-Reply-To: <20060710221308.5351.78741.stgit@localhost.localdomain>
X-Enigmail-Version: 0.94.0.0
OpenPGP: id=4F9CF57E
Content-Type: text/plain; charset=KOI8-R
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Catalin Marinas wrote:
> From: Catalin Marinas <catalin.marinas@gmail.com>
[]
> -		request_resource(&iomem_resource, res);
> +		if (request_resource(&iomem_resource, res)) {
> +			kfree(res);
...

Just a small nitpick, or, rather, a question.
Quite alot of functions return 0 on success, or !=0 on failure.
There are other functions, which, say, return NULL on failure.
Or when 0 is valid result, something <0 is returned.. etc.

Without looking at the function description or code, it's
impossible to say wich of the above it is.  But.

When reading that kind of code as the quoted patch adds,
I for one always think it's somehow incorrect or backwards.
When used like that, request_resource() seems like a boolean,
and the whole thing becomes:

  if (do_something_successeful())
    fail();

Ofcourse, later you understand that do_something() returns 0
on failure, and the code is correct.  But the first impression
(again, for me anyway) is that it's wrong.

In such cases when a routine returns 0 on error, I usually write
it this way:

   if (request_resource() != 0)
     fail()

This way it becomes obvious what does it do, and compiler
generates EXACTLY the same instructions.

Yes it's redundrand, that "!= 0" tail.  But it makes the
whole stuff readable without a need to re-think what does it
return, and, which is especially important, logically correct
when reading.

Alternatively, it can be named something like

  request_resource_failed()

instead of just request_resource(). Compare:

 if (request_resource(..))
    fail();

(current).  And

 if (request_resource_failed())
   fail();

The latter seems more logical... ;)

But that "!= 0" tail achieves almost the same effect.
Yet again, from my point of view anyway... ;)

Thanks.

/mjt
