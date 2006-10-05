Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751428AbWJEDr2@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751428AbWJEDr2 (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 4 Oct 2006 23:47:28 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751429AbWJEDr2
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 4 Oct 2006 23:47:28 -0400
Received: from smtpout.mac.com ([17.250.248.185]:61155 "EHLO smtpout.mac.com")
	by vger.kernel.org with ESMTP id S1751428AbWJEDr2 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 4 Oct 2006 23:47:28 -0400
In-Reply-To: <20061004124310.10c9939b.akpm@osdl.org>
References: <20061004183752.GG28596@parisc-linux.org> <20061004120242.319a47e4.akpm@osdl.org> <20061004192537.GH28596@parisc-linux.org> <20061004124310.10c9939b.akpm@osdl.org>
Mime-Version: 1.0 (Apple Message framework v752.2)
Content-Type: text/plain; charset=US-ASCII; delsp=yes; format=flowed
Message-Id: <945E314B-86E1-4DDE-9F8F-347A11C78393@mac.com>
Cc: Matthew Wilcox <matthew@wil.cx>, linux-kernel@vger.kernel.org
Content-Transfer-Encoding: 7bit
From: Kyle Moffett <mrmacman_g4@mac.com>
Subject: Re: Must check what?
Date: Wed, 4 Oct 2006 23:47:17 -0400
To: Andrew Morton <akpm@osdl.org>
X-Mailer: Apple Mail (2.752.2)
X-Brightmail-Tracker: AAAAAA==
X-Brightmail-scanned: yes
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Oct 04, 2006, at 15:43:10, Andrew Morton wrote:
> (Or we do
>
> 	return assert_zero_or_errno(ret);
>
> which is a bit ug, but gets us there)

I'm personally a big fan of:

   typedef int kerr_t;
   # define kreterr_t kerr_t __must_check

Then:

   kreterr_t some_device_function(void *data)
   {
   	kerr_t result;
   	if (!data)
   		return -EINVAL;
   	result = other_device_function(data + sizeof(struct foo));
   	[...]
   	return result;
   }

You could even tag __bitwise on kerr_t except that wouldn't work  
nicely with returning a negative error code.  Is there any way to  
tell sparse that:

   -ESOMECODE => -((__force kerr_t)3)

is ok when kerr_t is a bitwise type, without allowing any other math  
operations?

Alternatively you could:

   #ifdef __KERNEL__
   # define KENOENT ((__force kerr_t) -ENOENT)
   # define KENOMEM ((__force kerr_t) -ENOMEM)
   [...]
   #endif

But that's a _lot_ of code churn for fairly minimal gain.  It might  
be easier just to patch sparse to add an errcode type attribute with  
the desired behavior.  There also might be some way to do it with  
enums but I'm not familiar enough with the exact GCC behavior to  
comment.

Cheers,
Kyle Moffett
