Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261809AbTDQUyv (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 17 Apr 2003 16:54:51 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262637AbTDQUyv
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 17 Apr 2003 16:54:51 -0400
Received: from zcars04f.nortelnetworks.com ([47.129.242.57]:5542 "EHLO
	zcars04f.nortelnetworks.com") by vger.kernel.org with ESMTP
	id S261809AbTDQUyt (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 17 Apr 2003 16:54:49 -0400
Message-ID: <3E9F175E.1000504@nortelnetworks.com>
Date: Thu, 17 Apr 2003 17:06:38 -0400
X-Sybari-Space: 00000000 00000000 00000000
From: Chris Friesen <cfriesen@nortelnetworks.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:0.9.8) Gecko/20020204
X-Accept-Language: en-us
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org
Subject: trying to understand mmap, msync, O_SYNC, and devices
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


With the discussions over the past while, it is now clear that shared mappings 
of normal files will not be written out until forced to, and that this is the 
correct thing to do in almost all cases.

In this case, changing something in the mapped area will make the changes 
visible to all other processes mapping the same area, but the changes are not 
guaranteed to be flushed to the backing store.

What I am not clear on is how this interacts with mapping *devices*.  Does it 
still go through the buffer cache?


Details follow for those who are interested:

I have hardware which does not wipe ram on reset as long as it is not powered 
off.  On boot I force a limit on the amount of memory used by the kernel, which 
leaves a chunk of unused memory beyond normally-accessable memory.  I have a 
char driver which then implements mmap by mapping this memory to the calling 
process.  This mapping is shared between many processes and is used for logging, 
with appropriate locking mechanisms.

My key issue is this--how do I ensure that the contents of this memory are 
consistant and up to date when the board may be rebooted at any time?

I have three levels of enforcement that I have considered:

1) Opening the device with O_SYNC.  This also tells the mmap code in the driver 
to set the memory to uncached, the same way that mem.c does in pgprot_noncached().

2) Calls to wmb() in the code to enforce order when setting critical fields.

3) Explicit calls to msync() in place of the wmb() calls. (Which slows it down 
by a factor of 2.5 as compared to #2.)


I assume that #1 is required to guard against resetting of the board.  Beyond 
that is #2 sufficient, or is #3 required?

Thanks,

Chris


-- 
Chris Friesen                    | MailStop: 043/33/F10
Nortel Networks                  | work: (613) 765-0557
3500 Carling Avenue              | fax:  (613) 765-2986
Nepean, ON K2H 8E9 Canada        | email: cfriesen@nortelnetworks.com

