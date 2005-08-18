Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932370AbVHRSp6@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932370AbVHRSp6 (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 18 Aug 2005 14:45:58 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932388AbVHRSp6
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 18 Aug 2005 14:45:58 -0400
Received: from ixca-out.ixiacom.com ([67.133.120.10]:399 "EHLO
	ixca-ex1.ixiacom.com") by vger.kernel.org with ESMTP
	id S932370AbVHRSp5 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 18 Aug 2005 14:45:57 -0400
Message-ID: <4304D763.4090001@rincewind.tv>
Date: Thu, 18 Aug 2005 11:45:55 -0700
X-Sybari-Trust: abba61d6 453feeff 4098152d 0000010c
From: Ollie Wild <aaw@rincewind.tv>
User-Agent: Mozilla Thunderbird 1.0.6 (X11/20050725)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Ollie Wild <aaw@rincewind.tv>
CC: Patrick McHardy <kaber@trash.net>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] fix dst_entry leak in icmp_push_reply()
References: <43039C3F.2000207@rincewind.tv> <4303CEC5.3010502@trash.net> <43042D94.4030303@rincewind.tv>
In-Reply-To: <43042D94.4030303@rincewind.tv>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Ollie Wild wrote:

> Patrick McHardy wrote:
>
>> Your patch doesn't fit your description, the else-condition you're
>> adding triggers when the queue is empty, so what is the point?
>
>
> Since we're only calling ip_append_data() once here, the two 
> conditions are identical.

I should mention that this problem is not academic.  We've run into it 
in the field.  If a lot of ICMP destination unreachable messages are 
generated (by flooding a net_device with bad UDP packets for instance), 
the net_device can no longer be unregistered.

That said, I appreciate that the if-else condition doesn't seem quite 
right.  The problem is, the icmp_push_reply() routine is implicitly 
using the queue as a success indicator.  I put the 
ip_flush_pending_frames() call inside the else block because I wanted to 
guarantee that one of ip_push_pending_frames() and 
ip_flush_pending_frames() is always called.  Both will do proper cleanup.

I'm open to suggestions if you think there's a cleaner way to implement 
this.

Ollie
