Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751684AbWCGGLz@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751684AbWCGGLz (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 7 Mar 2006 01:11:55 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751688AbWCGGLz
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 7 Mar 2006 01:11:55 -0500
Received: from mailhub.sw.ru ([195.214.233.200]:50010 "EHLO relay.sw.ru")
	by vger.kernel.org with ESMTP id S1751646AbWCGGLy (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 7 Mar 2006 01:11:54 -0500
Message-ID: <440D2536.60005@sw.ru>
Date: Tue, 07 Mar 2006 09:16:22 +0300
From: Kirill Korotaev <dev@sw.ru>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; ru-RU; rv:1.2.1) Gecko/20030426
X-Accept-Language: ru-ru, en
MIME-Version: 1.0
To: Neil Brown <neilb@suse.de>
CC: Balbir Singh <bsingharora@gmail.com>, linux-kernel@vger.kernel.org,
       Andrew Morton <akpm@osdl.org>, Olaf Hering <olh@suse.de>,
       Jan Blunck <jblunck@suse.de>, Kirill Korotaev <dev@openvz.org>,
       Al Viro <viro@ftp.linux.org.uk>
Subject: Re: [PATCH] Busy inodes after unmount, be more verbose in generic_shutdown_super
References: <17414.38749.886125.282255@cse.unsw.edu.au>	<17419.53761.295044.78549@cse.unsw.edu.au>	<661de9470603052332s63fd9b2crd60346324af27fbf@mail.gmail.com> <17420.59580.915759.44913@cse.unsw.edu.au>
In-Reply-To: <17420.59580.915759.44913@cse.unsw.edu.au>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>>The code changes look big, have you looked at
>>http://marc.theaimsgroup.com/?l=linux-kernel&m=113817279225962&w=2
> 
> 
> No I haven't.  I like it.
>  - Holding the semaphore shouldn't be a problem.
>  - calling down_read_trylock ought to be fast
>  - I *think* the unwanted calls to prune_dcache are always under
>    PF_MEMALLOC - they certainly seem to be.
No, it looks as it is not :(
Have you noticed my comment about "count" argument to prune_dcache()?
For example, prune_dcache() is called from shrink_dcache_parent() which 
is called in many places and not all of them have PF_MEMALLOC or 
s_umount semaphore for write. But prune_dcache() doesn't care for super 
blocks etc. It simply shrinks N dentries which are found _first_.

So the condition:
+		if ((current->flags & PF_MEMALLOC) &&
+			!(ret = down_read_trylock(&s->s_umount))) {
is not always true when the race occurs, as PF_MEMALLOC is not always set.

> And it is a nice small change.
> Have you had any other feedback on this?
here it is :)

Thanks,
Kirill

