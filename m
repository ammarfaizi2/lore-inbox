Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263625AbUDFFBi (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 6 Apr 2004 01:01:38 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263624AbUDFFBi
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 6 Apr 2004 01:01:38 -0400
Received: from adelaide.maptek.com.au ([202.174.40.42]:11964 "EHLO
	mail.adelaide.maptek.com.au") by vger.kernel.org with ESMTP
	id S263620AbUDFFBe (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 6 Apr 2004 01:01:34 -0400
Message-ID: <407239DB.1010600@maptek.com.au>
Date: Tue, 06 Apr 2004 14:32:19 +0930
From: Malcolm Blaney <malcolm.blaney@maptek.com.au>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.4.1) Gecko/20031030
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: lkml <linux-kernel@vger.kernel.org>
Subject: Re: mark_offset_tsc() hangs usb
References: <406BA62A.2090503@maptek.com.au>
In-Reply-To: <406BA62A.2090503@maptek.com.au>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
X-MailScanner-Information: Please contact the ISP for more information
X-MailScanner: Found to be clean
X-MailScanner-SpamCheck: not spam, SpamAssassin (score=-6.1, required 5,
	BAYES_01 -5.40, IN_REP_TO -0.37, QUOTED_EMAIL_TEXT -0.38,
	REFERENCES -0.00, REPLY_WITH_QUOTES 0.00, TW_UH 0.08,
	USER_AGENT_MOZILLA_UA 0.00)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



I wrote:

> I have been trying to fix a problem related to usb, with the help of the 
> usb-dev list. Plugging in a usb device hangs my computer when bandwidth 
> reclamation (fsbr) is turned on in the uhci-hcd driver.
> 
> I have found though, that when an interrupt is triggered by plugging in 
> a usb device, the timer_interrupt() function in arch/i386/kernel/time.c 
> is reached, and the computer hangs in mark_offset_tsc() in 
> timers/timer_tsc.c. I removed the call to this function in 
> timer_interrupt() and then usb worked as normal. I'm hoping there's a 
> better way to get usb working than this though! This doesn't happen when 
> fsbr is switched off.
> 
> The computer has a Crusoe TM5400 cpu and a VIA VT82C686A controller.

I've been trying to work out what goes wrong in mark_offset_tsc() and 
found that it's just the outb_p() & inb_p() calls that are causing the 
problem. I found a thread relating to this, 
http://www.ussg.iu.edu/hypermail/linux/kernel/0309.2/1039.html, and 
tried the line:
#define __SLOW_DOWN_IO__ ""
which also allowed usb to work normally. Since this is just avoiding the 
read or write to port 0x80, is this a sign of having dodgy hardware? The 
thread doesn't talk about writing to the port as being fatal, even if it 
does cause problems for some people.

Anybody got a better fix?

Malcolm.

