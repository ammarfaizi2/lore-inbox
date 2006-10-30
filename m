Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1422633AbWJ3Upb@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1422633AbWJ3Upb (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 30 Oct 2006 15:45:31 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030595AbWJ3Upb
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 30 Oct 2006 15:45:31 -0500
Received: from 195-13-16-24.net.novis.pt ([195.23.16.24]:47493 "EHLO
	bipbip.grupopie.com") by vger.kernel.org with ESMTP
	id S1030592AbWJ3Upa (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 30 Oct 2006 15:45:30 -0500
Message-ID: <45466465.3000007@grupopie.com>
Date: Mon, 30 Oct 2006 20:45:25 +0000
From: Paulo Marques <pmarques@grupopie.com>
Organization: Grupo PIE
User-Agent: Thunderbird 1.5.0.7 (X11/20060909)
MIME-Version: 1.0
To: Miguel Ojeda <maxextreme@gmail.com>
CC: Franck <vagabon.xyz@gmail.com>, akpm@osdl.org,
       linux-kernel@vger.kernel.org
Subject: Re: [PATCH 2.6.19-rc1 full] drivers: add LCD support
References: <20061013023218.31362830.maxextreme@gmail.com>	 <653402b90610230908y2be5007dga050c78ee3993d81@mail.gmail.com>	 <cda58cb80610231015i4b59a571kaea5711ae1659f0d@mail.gmail.com>	 <653402b90610260755t75b3a539rb5f54bad0688c3c1@mail.gmail.com>	 <cda58cb80610271303p29f6f1a2vc3ebd895ab36eb53@mail.gmail.com>	 <653402b90610271325l1effa77eq179ca1bda135445@mail.gmail.com>	 <4545C52A.5010105@innova-card.com> <4545FCB1.8030900@grupopie.com>	 <653402b90610300611ucdc46d9y88f016800b498538@mail.gmail.com>	 <45461890.2000007@grupopie.com> <653402b90610300932r3c96445bxb8e5d34f8f768ec4@mail.gmail.com>
In-Reply-To: <653402b90610300932r3c96445bxb8e5d34f8f768ec4@mail.gmail.com>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Miguel Ojeda wrote:
>[...]
> Yes, I get the idea, you mean to "unmap" the page but don't remove the
> vma so a page fault is raised and nopage() op must be called again.
> May it decrease performance? (Linux /you must take care of a page
> fault calling nopage() each time you write/refresh the LCD, then
> actually use it).

Well, it's a trade-off: you pay a little extra when you write to the 
display, but you pay _zero_ when you leave the display alone. And this 
zero is an important concept for some applications like dynticks.

If you want to achieve deep sleep states on a laptop you might want to 
be able to let it sleep for extended periods. Having a thread that wakes 
up every 50 ms even when there is nothing to do is not so good in this 
situation.

If your refresh rate is 20Hz you pay *at most* 20 minor faults per 
second if the application is writing a lot to the display. That doesn't 
sound so bad.

Even more, the application still as the option of using seek/write 
instead of using mmap to avoid the page faults, but if you're writing a 
lot, it might be better to take just one page fault and then write at 
full speed than to pay the price of a seek/write every time.

I didn't include the locking in the description, though. If you're going 
this way, you need to make sure that some of this operations are atomic 
so that you don't mark the display as clean just as the userspace app is 
dirtying it, leaving the physical display inconsistent until the next 
refresh.

-- 
Paulo Marques - www.grupopie.com

"The face of a child can say it all, especially the
mouth part of the face."
