Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S316751AbSGHCvH>; Sun, 7 Jul 2002 22:51:07 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S316753AbSGHCvG>; Sun, 7 Jul 2002 22:51:06 -0400
Received: from e2.ny.us.ibm.com ([32.97.182.102]:48276 "EHLO e2.ny.us.ibm.com")
	by vger.kernel.org with ESMTP id <S316751AbSGHCvG>;
	Sun, 7 Jul 2002 22:51:06 -0400
Message-ID: <3D28FE72.1080603@us.ibm.com>
Date: Sun, 07 Jul 2002 19:52:34 -0700
From: Dave Hansen <haveblue@us.ibm.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.0.0) Gecko/20020607
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Matthew Wilcox <willy@debian.org>
CC: Oliver Neukum <oliver@neukum.name>,
       Thunder from the hill <thunder@ngforever.de>, Greg KH <greg@kroah.com>,
       kernel-janitor-discuss 
	<kernel-janitor-discuss@lists.sourceforge.net>,
       linux-kernel@vger.kernel.org
Subject: Re: BKL removal
References: <Pine.LNX.4.44.0207071702120.10105-100000@hawkeye.luckynet.adm> <200207080131.06119.oliver@neukum.name> <3D28D291.3020706@us.ibm.com> <20020708033409.P27706@parcelfarce.linux.theplanet.co.uk>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Matthew Wilcox wrote:
> On Sun, Jul 07, 2002 at 04:45:21PM -0700, Dave Hansen wrote:
> 
>>Don't forget that the BKL is released on sleep.  It is OK to hold it
>>over a schedule()able operation.  If I remember right, there is no 
>>real protection needed for the file->private_data either because there 
>>is 1 and only 1 struct file per open, and the data is not shared among 
>>struct files.
> 
> one struct file per open(), yes.  however, fork() shares a struct file,
> as does unix domain fd passing.  so we need protection between different
> processes.  there's some pretty good reasons to want to use a semaphore
> to protect the struct file (see fasync code.. bleugh).

But, this at least means that we don't need to protect 
file->private_data during the open itself, right?

> however, our semaphores currently suck.  they attempt to acquire the sem
> immediately and if they fail go straight to sleep.  schimmel (i think..)
> suggests spinning for a certain number of iterations before sleeping.
> the great thing is, it's all out of line slowpath code so the additional
> size shouldn't matter.  obviously this is SMP-only, and it does require
> someone to do it who can measure the difference (and figure out how may
> iterations to spin for before sleeping).

Well, I certainly have the hardware to measure the difference.  But, I 
seem to remember several conversations in the past where people didn't 
like this behavior.
http://groups.google.com/groups?hl=en&lr=&ie=UTF-8&oe=UTF-8&safe=off&threadm=linux.kernel.3C62DABA.3020906%40us.ibm.com

> i was wondering if this might be a project you'd like to take on which
> would upset far fewer people and perhaps yield greater advantage.

Yes, something less controvertial, please!  A dumb implementation 
would be pretty easy on top of current semaphores, but I think it was 
already done (see above).

-- 
Dave Hansen
haveblue@us.ibm.com

