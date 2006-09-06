Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751258AbWIFGxm@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751258AbWIFGxm (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 6 Sep 2006 02:53:42 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751509AbWIFGxm
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 6 Sep 2006 02:53:42 -0400
Received: from mailhub.sw.ru ([195.214.233.200]:38513 "EHLO relay.sw.ru")
	by vger.kernel.org with ESMTP id S1751258AbWIFGxk (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 6 Sep 2006 02:53:40 -0400
Message-ID: <44FE704E.8000700@sw.ru>
Date: Wed, 06 Sep 2006 10:53:02 +0400
From: Vasily Averin <vvs@sw.ru>
User-Agent: Thunderbird 1.5.0.5 (X11/20060725)
MIME-Version: 1.0
To: Eric Sandeen <sandeen@sandeen.net>, Eric Lammerts <eric@lammerts.org>
CC: Theodore Tso <tytso@mit.edu>, Stephen Tweedie <sct@redhat.com>,
       Andrew Morton <akpm@osdl.org>, adilger@clusterfs.com,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       linux-ext4@vger.kernel.org, devel@openvz.org, cmm@us.ibm.com
Subject: Re: [PATCH] ext3: wrong error behavior
References: <44F96DD0.30608@sw.ru> <44FDF83A.8010707@sandeen.net>
In-Reply-To: <44FDF83A.8010707@sandeen.net>
X-Enigmail-Version: 0.94.0.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Eric Sandeen wrote:
> Vasily Averin wrote:
>> In case ext3 file system is mounted with errors=continue
>> (EXT3_ERRORS_CONTINUE)
>> errors should be ignored when possible. However at present in case of
>> any error
>> kernel aborts journal and remounts filesystem to read-only. Such
>> behavior was
>> hit number of times and noted to differ from that of 2.4.x kernels.
> 
> I've also noticed this differing behavior,
> 
> http://marc.theaimsgroup.com/?l=linux-ext4&m=115376966821953&w=2
> 
> It passed w/o comment.  :)

I would note that one of our developers has noticed it 3 year ago.
http://marc.theaimsgroup.com/?l=linux-kernel&m=104824948712104&w=2
it was w/o comments too.

> Unless Ted had a specific reason for changing the behavior, 2.4 and 2.6
> should probably be brought into line.

I did not found any arguments explaining Ted's reasons, I believe he did not
noticed that he had inversed this condition. If otherwise he had some important
reasons, there is another bug: he must change the documentation at least.

I would like to add that our customers are really discontented by this change.
Now they pays a high price for any minor ext3 errors: they should stop any
processes that uses this partition, check the partition, restart the processes
again... Downtime is too long and there is not any workarounds.

> Calling ext3_commit_super()
> before the panic may defeat (some of) the purpose of the panic option,
> though, which is to preserve as much state as possible at the time of
> the error for later analysis...

On the other hand if error is not saved on the disc, fsck will not check this
filesystem automatically on the next reboot and therefore node will mount
corrupted filesystem, it's dangerous too. In the worst scenario  the node find
the same error on the disc and rebooted again and it is real nightmare for
remote admins.

I would note that Eric Lammerts has tried to fix this issue, however I'm not
sure that he has achieved a success:
http://marc.theaimsgroup.com/?l=ext3-users&m=110651773907882&w=2

Also I would like to add that Andrew Morton has signed off the patch and added
it to the -mm tree.

Thank you,
	Vasily Averin

SWsoft Virtuozzo/OpenVZ Linux kernel team
