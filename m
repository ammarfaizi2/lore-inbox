Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964997AbVJUPwr@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964997AbVJUPwr (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 21 Oct 2005 11:52:47 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964998AbVJUPwr
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 21 Oct 2005 11:52:47 -0400
Received: from smtpout.mac.com ([17.250.248.46]:29890 "EHLO smtpout.mac.com")
	by vger.kernel.org with ESMTP id S964997AbVJUPwr (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 21 Oct 2005 11:52:47 -0400
In-Reply-To: <43590B23.2090101@csc.ncsu.edu>
References: <4358F0E3.6050405@csc.ncsu.edu> <1129903396.2786.19.camel@laptopd505.fenrus.org> <4359051C.2070401@csc.ncsu.edu> <1129908179.2786.23.camel@laptopd505.fenrus.org> <43590B23.2090101@csc.ncsu.edu>
Mime-Version: 1.0 (Apple Message framework v734)
Content-Type: text/plain; charset=US-ASCII; delsp=yes; format=flowed
Message-Id: <C6F7B216-66B3-4848-9423-05AB4D826320@mac.com>
Cc: linux-kernel@vger.kernel.org
Content-Transfer-Encoding: 7bit
From: Kyle Moffett <mrmacman_g4@mac.com>
Subject: Re: Understanding Linux addr space, malloc, and heap
Date: Fri, 21 Oct 2005 11:52:45 -0400
To: "Vincent W. Freeh" <vin@csc.ncsu.edu>
X-Mailer: Apple Mail (2.734)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Oct 21, 2005, at 11:37:07, Vincent W. Freeh wrote:
> The point of the code is to show that one can protect malloc code.

You may be able to protect malloced memory, but it's not reliable, it  
doesn't follow the standard, and if it breaks you get to keep both  
pieces.  You tried to protect malloced memory, it wasn't reliable, it  
didn't follow the standard, therefore you get to keep both pieces.

> But I can't mprotect the 66th page I malloc.  And mprotect fails  
> SILENTLY!
You must understand that malloc does not necessarily return a  
_page_.  It returns a random hunk of memory aligned to a 16 byte  
boundary, which is *not* the same as aligned to a page boundary  
(usually 4096 bytes).  Your code is buggy:

>>>   mprotect((void*)((unsigned)p & ~(pgsize-1)), 1024, PROT_NONE);

You malloced 1024 bytes (1024 != page size (usually 4096)).  You then  
round down to a multiple of a page size, and mprotect that page  
(since you used a size < 1 page, it rounds up to a page).  If malloc  
returns an offset 4080 bytes into a page (aligned on a 16-byte  
boundary), and you round down and protect that page, then only the  
first 16 bytes of the memory you got will be protected.

You *cannot* reliably expect to mprotect() the results of malloc().   
If you want to mprotect() things, you _must_ do it on mmap()ed memory.

Cheers,
Kyle Moffett

--
Somone asked me why I work on this free (http://www.fsf.org/ 
philosophy/) software stuff and not get a real job. Charles Shultz  
had the best answer:

"Why do musicians compose symphonies and poets write poems? They do  
it because life wouldn't have any meaning for them if they didn't.  
That's why I draw cartoons. It's my life."
   -- Charles Shultz


