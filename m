Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262710AbTDVCCM (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 21 Apr 2003 22:02:12 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262834AbTDVCCM
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 21 Apr 2003 22:02:12 -0400
Received: from rwcrmhc51.attbi.com ([204.127.198.38]:15869 "EHLO
	rwcrmhc51.attbi.com") by vger.kernel.org with ESMTP id S262710AbTDVCCL
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 21 Apr 2003 22:02:11 -0400
Message-ID: <3EA4A54F.6060709@quark.didntduck.org>
Date: Mon, 21 Apr 2003 22:13:35 -0400
From: Brian Gerst <bgerst@quark.didntduck.org>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.3) Gecko/20030313
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Manfred Spraul <manfred@colorfullife.com>
CC: linux-kernel@vger.kernel.org
Subject: Re: [RFC, PATCH] fix verify_write for 80386 support
References: <3EA45485.2080500@colorfullife.com> <3EA4565D.4070302@colorfullife.com>
In-Reply-To: <3EA4565D.4070302@colorfullife.com>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Manfred Spraul wrote:
> [ 2nd part of the mail, after hitting the send button in the middle of 
> the sentence]
> 
> The solution is to perform the check for write protection in the actual 
> access functions, not during access_ok.
> 
> The attached patch does that:
> - remove the check from access_ok
> - redirect all user space write access into __copy_to_user_ll
> - within __copy_to_user_ll: use get_user_pages, and write directly to 
> the obtained kernel address.
> 
> This fixes all swapout & data corruption bugs, and even removes 26 lines 
> from the kernel.
> 
> What do you think? The alternative would be to drop support for real 
> 80386 cpus.
> 
> Not tested on a real 80386, I've just replace wp_works_ok with 
> !wp_works_ok.
> 
> -- 
>    Manfred
> 

Close, but there is still a race here.  You need to hold mmap_sem over 
the memcpy.  Another thread will expect the memory to not be written to 
after write-protecting it.

--
				Brian Gerst

