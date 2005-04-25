Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261471AbVDYTnh@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261471AbVDYTnh (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 25 Apr 2005 15:43:37 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261689AbVDYTng
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 25 Apr 2005 15:43:36 -0400
Received: from [194.90.79.130] ([194.90.79.130]:17937 "EHLO argo2k.argo.co.il")
	by vger.kernel.org with ESMTP id S261471AbVDYTnW (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 25 Apr 2005 15:43:22 -0400
Message-ID: <426D4857.6080004@argo.co.il>
Date: Mon, 25 Apr 2005 22:43:19 +0300
From: Avi Kivity <avi@argo.co.il>
User-Agent: Mozilla Thunderbird 1.0.2-1 (X11/20050323)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: "David S. Miller" <davem@davemloft.net>
CC: galibert@pobox.com, linux-kernel@vger.kernel.org
Subject: Re: tcp_sendpage and page allocation lifetime vs. iscsi
References: <20050425170259.GA36024@dspnet.fr.eu.org>	<426D40D4.8050900@argo.co.il> <20050425121953.6b5c3278.davem@davemloft.net>
In-Reply-To: <20050425121953.6b5c3278.davem@davemloft.net>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
X-OriginalArrivalTime: 25 Apr 2005 19:43:21.0621 (UTC) FILETIME=[097D9450:01C549CF]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

David S. Miller wrote:

>On Mon, 25 Apr 2005 22:11:16 +0300
>Avi Kivity <avi@argo.co.il> wrote:
>
>  
>
>>you need a completion to tell you when your buffer has been sent. you 
>>can use the kiocb parameter to tcp_sendmsg, as it has a completion. 
>>however, tcp_sendmsg does not appear to use it.
>>
>>in effect, you need tcp aio, but the mainline kernel does not support it 
>>yet.
>>    
>>
>
>Or, he could simply not try to reuse the private buffer he is
>giving to TCP.
>  
>
you are describing a memory leak. at some point he must free (or 
otherwise reuse) these pages.

theoretically he could peek at the tcp sequence number, but an 
event-driven, protocol-agnostic completion seems better to me.

* light goes on *

yes, if he frees the pages immediately after tcp_sendpage, then the 
reference count would remain elevated until tcp completes sending these 
pages. so the sequence

  allocate pages
  fill with data
  tcp_sendpage()
  free pages

should be safe?

(I am still wishing for tcp aio, though)

-- 
Do not meddle in the internals of kernels, for they are subtle and quick to panic.

