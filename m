Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932429AbWHQEs5@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932429AbWHQEs5 (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 17 Aug 2006 00:48:57 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932419AbWHQEs4
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 17 Aug 2006 00:48:56 -0400
Received: from smtp-out.google.com ([216.239.45.12]:62568 "EHLO
	smtp-out.google.com") by vger.kernel.org with ESMTP id S932247AbWHQEsy
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 17 Aug 2006 00:48:54 -0400
DomainKey-Signature: a=rsa-sha1; s=beta; d=google.com; c=nofws; q=dns;
	h=received:message-id:date:from:user-agent:
	x-accept-language:mime-version:to:cc:subject:references:in-reply-to:
	content-type:content-transfer-encoding;
	b=unWPmHjEDr6NHRVxL/nEBiTLeCKE1wgHnBl6Kzvku3B7WreUhk2FLZddDAGIybpeY
	F+IxDzMz7ANJvD2uRVC0g==
Message-ID: <44E3F525.3060303@google.com>
Date: Wed, 16 Aug 2006 21:48:37 -0700
From: Daniel Phillips <phillips@google.com>
User-Agent: Mozilla Thunderbird 1.0.8 (X11/20060502)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Evgeniy Polyakov <johnpol@2ka.mipt.ru>
CC: Peter Zijlstra <a.p.zijlstra@chello.nl>,
       David Miller <davem@davemloft.net>, linux-mm@kvack.org,
       linux-kernel@vger.kernel.org, netdev@vger.kernel.org
Subject: Re: [RFC][PATCH 0/9] Network receive deadlock prevention for NBD
References: <1155127040.12225.25.camel@twins> <20060809130752.GA17953@2ka.mipt.ru> <1155130353.12225.53.camel@twins> <20060809.165431.118952392.davem@davemloft.net> <1155189988.12225.100.camel@twins> <44DF888F.1010601@google.com> <20060814051323.GA1335@2ka.mipt.ru>
In-Reply-To: <20060814051323.GA1335@2ka.mipt.ru>
Content-Type: text/plain; charset=KOI8-R; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Evgeniy Polyakov wrote:
> On Sun, Aug 13, 2006 at 01:16:15PM -0700, Daniel Phillips (phillips@google.com) wrote:
>>Indeed.  The rest of the corner cases like netfilter, layered protocol and
>>so on need to be handled, however they do not need to be handled right now
>>in order to make remote storage on a lan work properly.  The sane thing for
>>the immediate future is to flag each socket as safe for remote block IO or
>>not, then gradually widen the scope of what is safe.  We need to set up an
>>opt in strategy for network block IO that views such network subsystems as
>>ipfilter as not safe by default, until somebody puts in the work to make
>>them safe.
> 
> Just for clarification - it will be completely impossible to login using 
> openssh or some other priveledge separation protocol to the machine due
> to the nature of unix sockets. So you will be unable to manage your
> storage system just because it is in OOM - it is not what is expected
> from reliable system.

The system is not OOM, it is in reclaim, a transient condition that will be
resolved in normal course by IO progress.  However you raise an excellent
point: if there is any remote management that we absolutely require to be
available while remote IO is interrupted - manual failover for example -
then we must supply a means of carrying out such remote administration, that
is guaranteed not to deadlock on a normal mode memory request.  This ends up
as a new network stack feature I think, and probably a theoretical one for
the time being since we don't actually know of any such mandatory login
that must be carried out while remote disk IO is suspended.

>>But really, if you expect to run reliable block IO to Zanzibar over an ssh
>>tunnel through a firewall, then you might also consider taking up bungie
>>jumping with the cord tied to your neck.
> 
> Just pure openssh for control connection (admin should be able to
> login).

And the admin will be able to, but in the cluster stack itself we don't
bless such stupidity as emailing an admin to ask for a login in order to
break a tie over which node should take charge of DLM recovery.

Regards,

Da niel
