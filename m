Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751340AbVHQX5A@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751340AbVHQX5A (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 17 Aug 2005 19:57:00 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751343AbVHQX5A
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 17 Aug 2005 19:57:00 -0400
Received: from [62.206.217.67] ([62.206.217.67]:33983 "EHLO
	localhost.localdomain") by vger.kernel.org with ESMTP
	id S1751340AbVHQX46 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 17 Aug 2005 19:56:58 -0400
Message-ID: <4303CEC5.3010502@trash.net>
Date: Thu, 18 Aug 2005 01:56:53 +0200
From: Patrick McHardy <kaber@trash.net>
User-Agent: Debian Thunderbird 1.0.2 (X11/20050602)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Ollie Wild <aaw@rincewind.tv>
CC: linux-kernel@vger.kernel.org
Subject: Re: [PATCH] fix dst_entry leak in icmp_push_reply()
References: <43039C3F.2000207@rincewind.tv>
In-Reply-To: <43039C3F.2000207@rincewind.tv>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Ollie Wild wrote:
> If the ip_append_data() call in icmp_push_reply() fails, 
> ip_flush_pending_frames() needs to be called.  Otherwise, ip_rt_put() is 
> never called on inet_sk(icmp_socket->sk)->cork.rt, which prevents the 
> route (and net_device) from ever being freed.
> 
> I've attached a patch which fixes the problem.
> 
> Ollie Wild
> 
> 
> ------------------------------------------------------------------------
> 
> diff --git a/net/ipv4/icmp.c b/net/ipv4/icmp.c
> --- a/net/ipv4/icmp.c
> +++ b/net/ipv4/icmp.c
> @@ -368,6 +368,8 @@ static void icmp_push_reply(struct icmp_
>  		icmph->checksum = csum_fold(csum);
>  		skb->ip_summed = CHECKSUM_NONE;
>  		ip_push_pending_frames(icmp_socket->sk);
> +	} else {
> +		ip_flush_pending_frames(icmp_socket->sk);
>

Your patch doesn't fit your description, the else-condition you're
adding triggers when the queue is empty, so what is the point?
