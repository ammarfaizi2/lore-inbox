Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262181AbTIQQ5i (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 17 Sep 2003 12:57:38 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262594AbTIQQ5i
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 17 Sep 2003 12:57:38 -0400
Received: from dbl.q-ag.de ([80.146.160.66]:16768 "EHLO dbl.q-ag.de")
	by vger.kernel.org with ESMTP id S262181AbTIQQ5h (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 17 Sep 2003 12:57:37 -0400
Message-ID: <3F689270.7050606@colorfullife.com>
Date: Wed, 17 Sep 2003 18:57:20 +0200
From: Manfred Spraul <manfred@colorfullife.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.4) Gecko/20030701
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Pavel Machek <pavel@suse.cz>
CC: Jeff Garzik <jgarzik@pobox.com>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] add likely around access_ok for uaccess
References: <3F644E36.5010402@colorfullife.com> <20030916194929.GF602@elf.ucw.cz> <20030916205545.GA14153@gtf.org> <20030916205931.GF1205@elf.ucw.cz>
In-Reply-To: <20030916205931.GF1205@elf.ucw.cz>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Pavel Machek wrote:

>Hi!
>
>  
>
>>>>while trying to figure out why sysv msg is around 30% slower than pipes 
>>>>for data transfers I noticed that gcc's autodetection (3.2.2) guesses 
>>>>the "if(access_ok())" tests in uaccess.h wrong and puts the error memset 
>>>>into the direct path and the copy out of line.
>>>>
>>>>The attached patch adds likely to the tests - any objections? What about 
>>>>the archs except i386?
>>>>        
>>>>
>>>How much speedup did you gain?
>>>      
>>>
>>How much can it hurt?
>>    
>>
>
>The change is obviously okay, I just wanted to know... If it gains 30%
>on sysv messages.. that would be pretty big surprise.
>
No.
I didn't benchmark it at all. I'd expect one or two cycles.
The 30% difference are due to misaligned buffers: The sysvmsg ABI uses
struct msgbuf {
    unsigned long type;
    char data[];
};
msgbuf was aligned, thus data on an not 8-byte aligned address. Thus the 
"rep;movsl" microcode fastpath didn't kick in, and that caused the 
30-50% slowdown.
After manually misaligning the msgbuf structure, and properly aligning 
the kernel buffers, the performance of sysvmsg is now identical to 
pipes: Around 4 k cycles for a one-byte ping-pong, and around 10k cycles 
for 4 kB ping-pong, with a Celeron mobile 1.13 GHz.

I haven't decided yet if a patch to align the kernel buffers is a good 
thing or not - it only helps my benchmark, I'm not aware of a real-world 
app that uses sysvmsg for bulk data transfers.

--
    Manfred

