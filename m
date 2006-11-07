Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1752622AbWKGXSp@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752622AbWKGXSp (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 7 Nov 2006 18:18:45 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753334AbWKGXSo
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 7 Nov 2006 18:18:44 -0500
Received: from mx1.redhat.com ([66.187.233.31]:61120 "EHLO mx1.redhat.com")
	by vger.kernel.org with ESMTP id S1752622AbWKGXSo (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 7 Nov 2006 18:18:44 -0500
Message-ID: <45511430.8030703@redhat.com>
Date: Tue, 07 Nov 2006 17:18:08 -0600
From: Eric Sandeen <sandeen@redhat.com>
User-Agent: Thunderbird 1.5.0.7 (X11/20061008)
MIME-Version: 1.0
To: "Rafael J. Wysocki" <rjw@sisk.pl>
CC: Andrew Morton <akpm@osdl.org>, Alasdair G Kergon <agk@redhat.com>,
       linux-kernel@vger.kernel.org, dm-devel@redhat.com,
       Ingo Molnar <mingo@elte.hu>, Srinivasa DS <srinivasa@in.ibm.com>
Subject: Re: [PATCH 2.6.19 5/5] fs: freeze_bdev with semaphore not mutex
References: <20061107183459.GG6993@agk.surrey.redhat.com> <20061107122837.54828e24.akpm@osdl.org> <45510C73.7060408@redhat.com> <200611080005.50070.rjw@sisk.pl>
In-Reply-To: <200611080005.50070.rjw@sisk.pl>
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Rafael J. Wysocki wrote:
> On Tuesday, 7 November 2006 23:45, Eric Sandeen wrote:
>> Andrew Morton wrote:
>>
>>>> --- linux-2.6.19-rc4.orig/fs/buffer.c	2006-11-07 17:06:20.000000000 +0000
>>>> +++ linux-2.6.19-rc4/fs/buffer.c	2006-11-07 17:26:04.000000000 +0000
>>>> @@ -188,7 +188,9 @@ struct super_block *freeze_bdev(struct b
>>>>  {
>>>>  	struct super_block *sb;
>>>>  
>>>> -	mutex_lock(&bdev->bd_mount_mutex);
>>>> +	if (down_trylock(&bdev->bd_mount_sem))
>>>> +		return -EBUSY;
>>>> +
>>> This is a functional change which isn't described in the changelog.  What's
>>> happening here?
>> Only allow one bdev-freezer in at a time, rather than queueing them up?
> 
> But freeze_bdev() is supposed to return the result of get_super(bdev)
> _unconditionally_.  Moreover, in its current form freeze_bdev() _cannot_
> _fail_, so I don't see how this change doesn't break any existing code.

Well, it could return NULL.  Is that a failure?

But, nobody is checking for an outright error, certainly.  Especially
when the error hasn't been ERR_PTR'd.  :)  So I agree, that's not so good.

But, how is a stampede of fs-freezers -supposed- to work?  I could
imagine something like a freezer count, and the filesystem is only
unfrozen after everyone has thawed?  Or should only one freezer be
active at a time... which is what we have now I guess.

-Eric
