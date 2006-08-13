Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751479AbWHMVWu@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751479AbWHMVWu (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 13 Aug 2006 17:22:50 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751503AbWHMVWu
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 13 Aug 2006 17:22:50 -0400
Received: from smtp-out.google.com ([216.239.45.12]:16235 "EHLO
	smtp-out.google.com") by vger.kernel.org with ESMTP
	id S1751479AbWHMVWt (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 13 Aug 2006 17:22:49 -0400
DomainKey-Signature: a=rsa-sha1; s=beta; d=google.com; c=nofws; q=dns;
	h=received:message-id:date:from:user-agent:
	x-accept-language:mime-version:to:cc:subject:references:in-reply-to:
	content-type:content-transfer-encoding;
	b=rSduHWNoR2HK1/VDf5wDjZhPry5piUo5m6AyuOngfdpG41YABc1j3W6iFu17XbhR9
	+ueVJCmIw+uCm9LnUQeiw==
Message-ID: <44DF9817.8070509@google.com>
Date: Sun, 13 Aug 2006 14:22:31 -0700
From: Daniel Phillips <phillips@google.com>
User-Agent: Mozilla Thunderbird 1.0.8 (X11/20060502)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: David Miller <davem@davemloft.net>
CC: a.p.zijlstra@chello.nl, tgraf@suug.ch, linux-mm@kvack.org,
       linux-kernel@vger.kernel.org, netdev@vger.kernel.org
Subject: Re: [RFC][PATCH 2/9] deadlock prevention core
References: <44D976E6.5010106@google.com>	<20060809131942.GY14627@postel.suug.ch>	<1155132440.12225.70.camel@twins> <20060809.165846.107940575.davem@davemloft.net>
In-Reply-To: <20060809.165846.107940575.davem@davemloft.net>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

David Miller wrote:
> From: Peter Zijlstra <a.p.zijlstra@chello.nl>
>>Hmm, what does sk_buff::input_dev do? That seems to store the initial
>>device?
> 
> You can run grep on the tree just as easily as I can which is what I
> did to answer this question.  It only takes a few seconds of your
> time to grep the source tree for things like "skb->input_dev", so
> would you please do that before asking more questions like this?
> 
> It does store the initial device, but as Thomas tried so hard to
> explain to you guys these device pointers in the skb are transient and
> you cannot refer to them outside of packet receive processing.

Thomas did a great job of explaining and without any flaming or ad
hominem attacks.

We have now formed a decent plan for doing the accounting in a stable
way without adding new fields to sk_buff, thankyou for the catch.

> The reason is that there is no refcounting performed on these devices
> when they are attached to the skb, for performance reasons, and thus
> the device can be downed, the module for it removed, etc. long before
> the skb is freed up.

The virtual block device can refcount the network device on virtual
device create and un-refcount on virtual device delete.  We need to
add that to the core patch and maybe package it nicely so the memalloc
reserve/unreserve happens at the same time, in a tidy little library
function to share with other virtual devices like iSCSI that also need
some anti-deadlock lovin.

Regards,

Daniel
