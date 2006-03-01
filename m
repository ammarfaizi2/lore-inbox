Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751901AbWCAVSl@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751901AbWCAVSl (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 1 Mar 2006 16:18:41 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751914AbWCAVSl
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 1 Mar 2006 16:18:41 -0500
Received: from watts.utsl.gen.nz ([202.78.240.73]:65192 "EHLO mail.utsl.gen.nz")
	by vger.kernel.org with ESMTP id S1751901AbWCAVSk (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 1 Mar 2006 16:18:40 -0500
Message-ID: <44060FA0.2040303@vilain.net>
Date: Thu, 02 Mar 2006 10:18:24 +1300
From: Sam Vilain <sam@vilain.net>
User-Agent: Mozilla Thunderbird 1.0.7 (X11/20051013)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: tvrtko.ursulin@sophos.com
Cc: Herbert Poetzl <herbert@13thfloor.at>, Andrew Morton <akpm@osdl.org>,
       Christoph Hellwig <hch@infradead.org>,
       Linux Kernel ML <linux-kernel@vger.kernel.org>,
       Al Viro <viro@ftp.linux.org.uk>,
       LSM <linux-security-module@mail.wirex.com>
Subject: Re: [RFC] vfs: cleanup of permission()
References: <OFAFEC22B7.7F7518A9-ON80257124.0043AF58-80257124.00448503@sophos.com>
In-Reply-To: <OFAFEC22B7.7F7518A9-ON80257124.0043AF58-80257124.00448503@sophos.com>
X-Enigmail-Version: 0.92.1.0
Content-Type: text/plain; charset=US-ASCII; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

tvrtko.ursulin@sophos.com wrote:
> Also, since you are modifying LSM interfaces, why not discuss it on the 
> LSM mailing list?
> 
> And finally, please don't remove nameidata. Modules out there depend on it 
> and we at Sophos are about to release a new product which needs it as 
> well. The plan was to announce the whole thing parallel with the release, 
> but after spotting your post I was prompted to react ahead of the 
> schedule. However, I am very busy at the moment so the actual announcment 
> with full details will have to wait for a week or two.

You are treating the per-FS security hooks as if they were VFS security 
hooks.  This was an easy mistake to make, as the appearance of a (struct 
nameidata*) sure makes it look like a VFS call.

However, most functions in the kernel don't pass anything in that 
nameidata slot.  Some (eg, syscalls that work on open FDs) can't, 
either.  So the fact that it does not guarantee VFS context information 
in all situations means permission() is not a VFS function.

ie, we don't disagree with what you're trying to do, but if you want 
path information then you should be working at the VFS layer, not the FS 
layer.

Perhaps you could first come up with a patch to the LSM base that adds 
VFS hooks rather than FS hooks and make your new system use those hooks? 
  I think that it might be more obvious where such hooks should go, 
after applying this patch.

What we're aiming for, on the permission() front, is that all system 
calls, ioctls, etc, call either vfs_permission() or file_permission(). 
Only those two functions should end up calling permission() directly.

Sam.
