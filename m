Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750826AbVLPEfN@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750826AbVLPEfN (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 15 Dec 2005 23:35:13 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751249AbVLPEfN
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 15 Dec 2005 23:35:13 -0500
Received: from e34.co.us.ibm.com ([32.97.110.152]:24018 "EHLO
	e34.co.us.ibm.com") by vger.kernel.org with ESMTP id S1750826AbVLPEfL
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 15 Dec 2005 23:35:11 -0500
Message-ID: <43A243F9.7040600@us.ibm.com>
Date: Thu, 15 Dec 2005 23:35:05 -0500
From: JANAK DESAI <janak@us.ibm.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.7.12) Gecko/20050922
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Jamie Lokier <jamie@shareable.org>
CC: "Eric W. Biederman" <ebiederm@xmission.com>, viro@ftp.linux.org.uk,
       chrisw@osdl.org, dwmw2@infradead.org, serue@us.ibm.com, mingo@elte.hu,
       linuxram@us.ibm.com, jmorris@namei.org, sds@tycho.nsa.gov,
       akpm@osdl.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH -mm 1/9] unshare system call: system call handler function
References: <1134513959.11972.167.camel@hobbs.atlanta.ibm.com> <m1k6e687e2.fsf@ebiederm.dsl.xmission.com> <43A1D435.5060602@us.ibm.com> <20051215212845.GA6990@mail.shareable.org>
In-Reply-To: <20051215212845.GA6990@mail.shareable.org>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Jamie Lokier wrote:

>JANAK DESAI wrote:
>  
>
>>clone checks to
>>makes sure that CLONE_NEWNS and CLONE_FS are not specified together, while
>>unshare will force CLONE_FS if CLONE_NEWNS is spefcified.
>>    
>>
>[ ... ]
>  
>
>>since clone and unshare are doing opposite things, sharing code
>>between them that checks constraints on the flags can get
>>convoluted.
>>    
>>
>
>clone() and unshare() are not doing opposite things.  They do the same
>thing, which is to unshare some properties while keeping others
>shared, and the only differences are that clone() first creates a new
>task, and the defaults for flags that aren't specified.
>
>  
>
Well .. by opposite I meant one allows you to share specific contexts while
the other allows you to unshare specific contexts. In case of clone, by not
specifying flags you can also unshare, however the same is not true for
the unshare system call. That is, if you don't specify a flag, that 
structure
is left alone in its current state. It does not become shared if it was 
not being
shared to begin with.

>It is the polarity of _some_ flags which is opposite in your unshare()
>API: In your API, CLONE_FS means "unshare fs", while with clone() it
>means "share fs".  Same for other flags - except for CLONE_NEWNS,
>where unshare() and clone() both take it to mean "unshare ns".
>
>That's a bit of a confusing mixture of polarities, in my opinion.
>
>I think it would be better if this:
>
>	pid = clone(flags);
>
>Could be always equivalent to this:
>
>	pid = clone(CLONE_FLAGS_TO_SHARE_EVERYTHING)
>	if (pid == 0)
>		unshare(flags);
>
>Or, if you don't like that, then this:
>
>	pid = clone(CLONE_FLAGS_TO_SHARE_EVERYTHING)
>	if (pid == 0)
>		unshare(~flags);
>
>However, if the API you've chosen for unshare() must be kept, then you
>can still have the same checks in clone() and unshare().  Just XOR the
>flags word with bits for polarities that are different between the two
>calls, before doing the checks, and XOR again afterwards to include
>any flags that were forced by the checks.
>
>  
>
I am in the process of writing up a more detailed description for this 
feature.
Description, which will include requirements, detail design and cost. When I
started, I did try to use as much of the existing code (clone, copy_*) as
possible, but I may have missed things. As I write things down, I will try
and see if I can make flags less confusing.

I am off for the next two weeks with limited email access so don't want to
rearrange stuff now.

>-- Jamie
>
>
>  
>

