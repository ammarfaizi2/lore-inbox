Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1753084AbWKGUXT@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753084AbWKGUXT (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 7 Nov 2006 15:23:19 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753086AbWKGUXT
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 7 Nov 2006 15:23:19 -0500
Received: from mx1.redhat.com ([66.187.233.31]:7825 "EHLO mx1.redhat.com")
	by vger.kernel.org with ESMTP id S1753082AbWKGUXS (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 7 Nov 2006 15:23:18 -0500
Message-ID: <4550EB22.9060805@redhat.com>
Date: Tue, 07 Nov 2006 14:22:58 -0600
From: Eric Sandeen <sandeen@redhat.com>
User-Agent: Thunderbird 1.5.0.7 (X11/20060913)
MIME-Version: 1.0
To: Mike Snitzer <snitzer@gmail.com>
CC: device-mapper development <dm-devel@redhat.com>,
       Andrew Morton <akpm@osdl.org>, linux-kernel@vger.kernel.org,
       Ingo Molnar <mingo@elte.hu>, Srinivasa DS <srinivasa@in.ibm.com>
Subject: Re: [dm-devel] [PATCH 2.6.19 5/5] fs: freeze_bdev with semaphore
 not mutex
References: <20061107183459.GG6993@agk.surrey.redhat.com> <170fa0d20611071218t3c145ef9i5413e432597d78a5@mail.gmail.com>
In-Reply-To: <170fa0d20611071218t3c145ef9i5413e432597d78a5@mail.gmail.com>
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Mike Snitzer wrote:
> On 11/7/06, Alasdair G Kergon <agk@redhat.com> wrote:
>> From: Srinivasa Ds <srinivasa@in.ibm.com>
>>
>> On debugging I found out that,"dmsetup suspend <device name>" calls
>> "freeze_bdev()",which locks "bd_mount_mutex" to make sure that no new mounts
>> happen on bdev until thaw_bdev() is called.  This "thaw_bdev()" is getting
>> called when we resume the device through "dmsetup resume <device-name>".
>> Hence we have 2 processes,one of which locks "bd_mount_mutex"(dmsetup
>> suspend) and another(dmsetup resume) unlocks it.
> 
> Srinivasa's description of the patch just speaks to how freeze_bdev
> and thaw_bdev are used by DM but completely skips justification for
> switching from mutex to semaphore.  Why is it beneficial and/or
> necessary to use a semaphore instead of a mutex here?

Because mutexes are not supposed to be released by anything other than
the thread that took them, as enforced by the various checking code and
noted in the docs...

"The stricter mutex API means you cannot use mutexes the same way you
can use semaphores: e.g. they cannot be used from an interrupt context,
nor can they be unlocked from a different context that which acquired
it."

this particular resource can sometimes be locked & unlocked from 2
different userspace threads.

-Eric
