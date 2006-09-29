Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1422698AbWI2UAa@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1422698AbWI2UAa (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 29 Sep 2006 16:00:30 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1422690AbWI2UA3
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 29 Sep 2006 16:00:29 -0400
Received: from smtp-out.google.com ([216.239.45.12]:2140 "EHLO
	smtp-out.google.com") by vger.kernel.org with ESMTP
	id S1422698AbWI2UA1 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 29 Sep 2006 16:00:27 -0400
DomainKey-Signature: a=rsa-sha1; s=beta; d=google.com; c=nofws; q=dns;
	h=received:message-id:date:from:user-agent:
	x-accept-language:mime-version:to:cc:subject:references:in-reply-to:
	content-type:content-transfer-encoding;
	b=t9Egz4q1hkP/4tly6adgcCWpSonX73LSdy95mXyv7D0XXiOTSyRxvrtNFPhgjnt3m
	65xKzOlvF5g5FVNqiypfw==
Message-ID: <451D7B21.4050105@google.com>
Date: Fri, 29 Sep 2006 12:59:29 -0700
From: Martin Bligh <mbligh@google.com>
User-Agent: Mozilla Thunderbird 1.0.7 (X11/20051011)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Mauro Carvalho Chehab <mchehab@infradead.org>
CC: Andrew Morton <akpm@osdl.org>, Sujoy Gupta <sujoy@google.com>,
       LKML <linux-kernel@vger.kernel.org>, video4linux-list@redhat.com
Subject: Re: [PATCH] fix compiler warning in drivers/media/video/video-buf.c
References: <451C070E.8080800@google.com>	 <20060928105108.88b37304.akpm@osdl.org> <1159559648.10055.35.camel@praia>
In-Reply-To: <1159559648.10055.35.camel@praia>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Mauro Carvalho Chehab wrote:
> Em Qui, 2006-09-28 às 10:51 -0700, Andrew Morton escreveu:
> 
>>On Thu, 28 Sep 2006 10:31:58 -0700
>>Martin Bligh <mbligh@google.com> wrote:
> 
> 
>>That being said, this driver is wrong to be storing dma addresses in a
>>void*.  And indeed there is a FIXME regarding this at
>>include/linux/videodev2.h:476, so I guess hiding this warning won't obscure
>>any fault which wasn't already known about..
> 
> 
> Yes. The original structure is:
> 
> struct v4l2_framebuffer
> {
>         __u32                   capability;
>         __u32                   flags;
>         void*                   base;
>         struct v4l2_pix_format  fmt;
> };
> 
> Since this is used at ioctl definition, changing this would break
> userspace apps. We might replace this to something like:
> 
> struct v4l2_framebuffer
> {
>         __u32                   capability;
>         __u32                   flags;
> 	union {
> 	        void*		base_ptr; /*FOO definition to avoid breaking userpace apps */
> 		dma_addr_t	base;
> 	}
>         struct v4l2_pix_format  fmt;
> };
> 
> This way, base will have the expected type, and it won't break any
> userspace app if sizeof(void *)<=sizeof(base). I think this is true for
> all architectures (anyway, if it isn't, v4l is broken anyway).

Won't that just make the userspace apps not work properly? Not that
they do right now, but how does masking the problem help?

M.
