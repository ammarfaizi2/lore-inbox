Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030458AbWJ3PV4@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030458AbWJ3PV4 (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 30 Oct 2006 10:21:56 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030473AbWJ3PV4
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 30 Oct 2006 10:21:56 -0500
Received: from 195-13-16-24.net.novis.pt ([195.23.16.24]:57992 "EHLO
	bipbip.grupopie.com") by vger.kernel.org with ESMTP
	id S1030458AbWJ3PVz (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 30 Oct 2006 10:21:55 -0500
Message-ID: <45461890.2000007@grupopie.com>
Date: Mon, 30 Oct 2006 15:21:52 +0000
From: Paulo Marques <pmarques@grupopie.com>
Organization: Grupo PIE
User-Agent: Thunderbird 1.5.0.7 (X11/20060909)
MIME-Version: 1.0
To: Miguel Ojeda <maxextreme@gmail.com>
CC: Franck <vagabon.xyz@gmail.com>, akpm@osdl.org,
       linux-kernel@vger.kernel.org
Subject: Re: [PATCH 2.6.19-rc1 full] drivers: add LCD support
References: <20061013023218.31362830.maxextreme@gmail.com>	 <653402b90610230556y56ef2f1blc923887f049094d4@mail.gmail.com>	 <453CE85B.2080702@innova-card.com>	 <653402b90610230908y2be5007dga050c78ee3993d81@mail.gmail.com>	 <cda58cb80610231015i4b59a571kaea5711ae1659f0d@mail.gmail.com>	 <653402b90610260755t75b3a539rb5f54bad0688c3c1@mail.gmail.com>	 <cda58cb80610271303p29f6f1a2vc3ebd895ab36eb53@mail.gmail.com>	 <653402b90610271325l1effa77eq179ca1bda135445@mail.gmail.com>	 <4545C52A.5010105@innova-card.com> <4545FCB1.8030900@grupopie.com> <653402b90610300611ucdc46d9y88f016800b498538@mail.gmail.com>
In-Reply-To: <653402b90610300611ucdc46d9y88f016800b498538@mail.gmail.com>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Miguel Ojeda wrote:
>[...]
>> In this case, if nothing was ever written to the display, the CPU usage
>> would be _zero_ (as it should), and it would work nicely with dynticks
>> and such.
> 
> Hum, interesting. But what happens if...
> 
> 1. For example, the userspace app maps the fb (nopage is called, dirty
> flag set, timer created), and then the app doesn't use the fb. The
> timer will refresh the LCD, without anything new to refresh, so we are
> wasting CPU time. After refreshing, the driver clears the dirty flag
> and unmap the buffer.
> 
> 2. After some seconds, the userspace app decides to write the buffer.
> As it is not mmaped anymore, it will simply get a segmentation fault,
> right? AFAIK nopage() is not called again because we have destroyed
> the mmapping information, and Linux can't know what are the nopage()
> ops to call to.

No, this is not the sequence I thought of at all. I don't remember the 
exact API functions you need to call (I have to read LDD3 again ;), but 
if the hardware supports it, there must be a way. The plan is something 
like:

  - at mmap time you return a pointer to something that is not actually 
mapped, and do nothing else

  - when userspace actually writes to that area, you get a page fault, 
and nopage is called. At this point you map the page, and set the dirty 
state. All other writes from userspace until the timer completes are 
done without faulting.

  - when the timer completes, you unmap the page so that the next access 
will generate a fault again

As I said, I don't remember the exact details, but this should be doable.

-- 
Paulo Marques - www.grupopie.com

"The face of a child can say it all, especially the
mouth part of the face."
