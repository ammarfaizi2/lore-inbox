Return-Path: <linux-kernel-owner+willy=40w.ods.org-S265267AbUGCVjR@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265267AbUGCVjR (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 3 Jul 2004 17:39:17 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265269AbUGCVjR
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 3 Jul 2004 17:39:17 -0400
Received: from spoolo3.tiscali.be ([62.235.13.169]:64225 "EHLO
	spoolo3.tiscali.be") by vger.kernel.org with ESMTP id S265267AbUGCVjJ
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 3 Jul 2004 17:39:09 -0400
Message-ID: <40E7278C.8040001@tiscali.be>
Date: Sat, 03 Jul 2004 21:39:24 +0000
From: Joel Soete <soete.joel@tiscali.be>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.7) Gecko/20040702 Debian/1.7-3
X-Accept-Language: en
MIME-Version: 1.0
To: Vojtech Pavlik <vojtech@suse.cz>
CC: Linux Kernel <linux-kernel@vger.kernel.org>, marcelo.tosatti@cyclades.com
Subject: Re: Some cleanup patches for: '...lvalues is deprecated'
References: <40E6AC41.4050804@tiscali.be> <20040703205621.GA1640@ucw.cz>
In-Reply-To: <20040703205621.GA1640@ucw.cz>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Thanks first for your attention ;)

Vojtech Pavlik wrote:
> On Sat, Jul 03, 2004 at 12:53:21PM +0000, Joel Soete wrote:
> 
>>Hi Marcelo,
>>
>>Please appolgies first for wrong presentation of previous post (that was 
>>the first and certainly the last time that I used the 'forwarding' option 
>>of this webmail interface :( ).
>>
>>Here are some backport to clean up some warning of type: use of cast 
>>experssion
>>as lvalues is deprecated.
>>--- linux-2.4.27-rc2-pa4mm/kernel/sysctl.c.Orig	2004-06-29 
>>09:03:42.000000000 +0200
>>+++ linux-2.4.27-rc2-pa4mm/kernel/sysctl.c	2004-06-29 
>>10:10:31.588030256 +0200
>>@@ -890,7 +890,7 @@
>> 				if (!isspace(c))
>> 					break;
>> 				left--;
>>-				((char *) buffer)++;
>>+				buffer += sizeof(char);
> 
> 
> This (although correct in the end) is a wrong thing to do.
> 
> It seems to look like the intention is to move the pointer by a char's
> size, however your change is equivalent to:
> 
> 	buffer += 1;
> 
> And if buffer wasn't void*, which it fortunately is, it would, unlike
> the older construction, move the pointer by a different size.
> 
Very interesting but well I am not enough fluent in C to understand this fine detail :(
Can you explain me by an example (let say a long*) what would did "((char *) buffer)++;" versus "buffer += sizeof(char);"
(Don't worry, if don't have time, I will perfectly understand and will experiment by myself)

> So just use
> 
> 	buffer++;
> 
> here, and the intent is then clear.
> 
Yes ;)
> 
>>--- linux-2.4.27-rc2-pa4mm/drivers/video/fbcon.c.Orig	2004-06-29 
>>10:47:31.901491304 +0200
>>+++ linux-2.4.27-rc2-pa4mm/drivers/video/fbcon.c	2004-06-29 
>>11:13:31.846343640 +0200
>>@@ -1877,7 +1877,10 @@
>>        font length must be multiple of 256, at least. And 256 is multiple
>>        of 4 */
>>     k = 0;
>>-    while (p > new_data) k += *--(u32 *)p;
>>+    while (p > new_data) {
>>+        p = (u8 *)((u32 *)p - 1);
>>+        k += *(u32 *)p;
>>+    }
> 
> 
> 
> How about
> 
> 	p -= 4;
> 	k += *(u32 *)p;
> 
:)

Thanks again,
	Joel
