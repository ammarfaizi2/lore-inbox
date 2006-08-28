Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751503AbWH1Un2@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751503AbWH1Un2 (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 28 Aug 2006 16:43:28 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751504AbWH1Un2
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 28 Aug 2006 16:43:28 -0400
Received: from terminus.zytor.com ([192.83.249.54]:33412 "EHLO
	terminus.zytor.com") by vger.kernel.org with ESMTP id S1751503AbWH1Un1
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 28 Aug 2006 16:43:27 -0400
Message-ID: <44F3555F.6060306@zytor.com>
Date: Mon, 28 Aug 2006 13:43:11 -0700
From: "H. Peter Anvin" <hpa@zytor.com>
User-Agent: Thunderbird 1.5.0.5 (X11/20060808)
MIME-Version: 1.0
To: Matt Domsch <Matt_Domsch@dell.com>
CC: Alon Bar-Lev <alon.barlev@gmail.com>, Andi Kleen <ak@suse.de>,
       Andrew Morton <akpm@osdl.org>, linux-kernel@vger.kernel.org,
       johninsd@san.rr.com
Subject: Re: [PATCH] THE LINUX/I386 BOOT PROTOCOL - Breaking the 256 limit
 (ping)
References: <44F1F356.5030105@zytor.com> <200608272254.13871.ak@suse.de> <44F21122.3030505@zytor.com> <44F286E8.1000100@gmail.com> <44F2902B.5050304@gmail.com> <44F29BCD.3080408@zytor.com> <9e0cf0bf0608280519y7a9afcb9od29494b9cacb8852@mail.gmail.com> <44F335C8.7020108@zytor.com> <20060828184637.GD13464@lists.us.dell.com> <44F33D55.4080704@zytor.com> <20060828201223.GE13464@lists.us.dell.com>
In-Reply-To: <20060828201223.GE13464@lists.us.dell.com>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Matt Domsch wrote:
> On Mon, Aug 28, 2006 at 12:00:37PM -0700, H. Peter Anvin wrote:
>> Matt Domsch wrote:
>>> No reason.  I was just trying to be careful, not leaving data in the
>>> upper bits of those registers going uninitialized.  If we know they're
>>> not being used ever, then it's not a problem.  But I don't think
>>> that's the source of the command line size concern, is it?
>>>
>> No, it's treating the command line as a fixed buffer, as opposed to a 
>> null-terminated string.  This was always a bug, by the way.
> 
> OK, I'll look at fixing that, and using %esi throughout.
> 

There is a lot of weirdness in this code; it's broken in an enormous 
amount of ways (sorry, Matt).  This comment, for example:

	pushl	%esi
     	cmpl	$0, %cs:cmd_line_ptr
	jz	done_cl
	movl	%cs:(cmd_line_ptr), %esi
# ds:esi has the pointer to the command line now

... doesn't handle the old boot protocol, and doesn't at all deal with 
the fact that cmd_line_ptr is an absolute address, and not at all 
relative to SETUPSEG, which is the normal value for %ds at this point. 
For the old protocol, this is a 16-bit pointer which is relative to 
INITSEG (not SETUPSEG), but this code just completely ignores it.

I'll hack up a patch for this.

	-hpa
