Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265495AbTLKS4Z (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 11 Dec 2003 13:56:25 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265496AbTLKS4Z
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 11 Dec 2003 13:56:25 -0500
Received: from rzfoobar.is-asp.com ([217.11.194.155]:37080 "EHLO mail.isg.de")
	by vger.kernel.org with ESMTP id S265495AbTLKS4X (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 11 Dec 2003 13:56:23 -0500
Message-ID: <3FD8BE9D.9000701@isg.de>
Date: Thu, 11 Dec 2003 19:59:41 +0100
From: Lutz Vieweg <lkv@isg.de>
Organization: IS Innovative Software AG
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.3.1) Gecko/20030613
X-Accept-Language: de-de, de, en-us, en
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org
Subject: mlock() "bogus check" (locked > num_physpages/2) _does_ hurt!
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi everyone,

in kernel 2.4.23, file mm/mlock.c, line 215, there's the following
piece of code:

         /* we may lock at most half of physical memory... */
         /* (this check is pretty bogus, but doesn't hurt) */
         if (locked > num_physpages/2)
                 goto out;

Obviously, the author already realized this check is bogus,
but the assumption that it doesn't hurt is very wrong... at least
for me: I'm writing a server application that uses much more virtual memory
than there's physical memory (and on 64bit systems, there can be a lot more
virtual memory!). The application needs to access only a small fraction of
the memory used during normal operation, the rest of the virtual memory used
is used for (slowly) rebuilding indicies in the background. So it is completely
ok for me that most of the applications memory is swapped out, and to make sure
that response times are low even after much of the memory is on disk, I use
mlock() to lock the interesting pages in memory.

And yes, I would very much like to use more than half of the physical memory
for that purpose!

Is there any good reason to keep this check in the 2.4 kernel sources?
Is there any good reason to not use a different default value
for the RLIMIT_MEMLOCK value (which is currently 0xffffffffffffffff), instead?

It's good to know the check is not present in the 2.6 sources, but I would
like to get rid of it in 2.4, too...

Regards,

Lutz Vieweg




