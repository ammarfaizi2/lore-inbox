Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262512AbUJ0QeR@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262512AbUJ0QeR (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 27 Oct 2004 12:34:17 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262532AbUJ0QeL
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 27 Oct 2004 12:34:11 -0400
Received: from mail4.speakeasy.net ([216.254.0.204]:51434 "EHLO
	mail4.speakeasy.net") by vger.kernel.org with ESMTP id S262512AbUJ0Qbz
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 27 Oct 2004 12:31:55 -0400
Message-ID: <417FCD78.6020807@speakeasy.net>
Date: Wed, 27 Oct 2004 12:31:52 -0400
From: Andrew <cmkrnl@speakeasy.net>
User-Agent: Mozilla Thunderbird 0.8 (X11/20041020)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Greg KH <greg@kroah.com>
CC: linux-kernel@vger.kernel.org
Subject: Re: [Patch] 2.6.10.rc1.bk6 /lib/kobject_uevent.c buffer issues
References: <20041027142925.GA17484@imladris.arnor.me> <20041027152134.GA13991@kroah.com>
In-Reply-To: <20041027152134.GA13991@kroah.com>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Greg KH wrote:
> 
> 
> Why not just use the same buffer?  We should be able to do that.
> 
> 
> I'd prefer we use the same buffer.  Care to respin your patch?
> 

Sure, I can only see two ways of achieving that however.
1) Change the API of kset_hotplug_ops.hotplug() to return the amount
    of consumed buffer (and possibly an updated value for i (num_envp)
    and then changing every real function that implements that interface
    or
2) Spin through the envp[] starting at i to NUM_ENVP looking for a NULL
    pointer dropping back 1 (last_used) then do a
    scratch += strlen(envp[last_used]) + 1

I don't know if you would rather keep the kset_hotplug_ops.hotplug() API
unchanged and have a "find the NULL" or vice-versa? -- or are both
too ugly? Ultimately the first option would generate the "cleanest"
solution, but I would be wary to change an API (especially one I didn't
create myself)

I can also see variation of 2), where buffer is prefilled with something
like '0xff' then the find the null would run in reverse from
buffer+BUFFER_SIZE-1.  Either way with 2), the reservation in envp[] for
the seq_num would have to stay, but its locaton in buffer would be at the
end.  As a bonus of course then the call to send_uevent could see the
entire buffer.

I'm looking now for how many changes would be required to do option 1.

Andrew



> thanks,
> 
> greg k-h
> 
> 
