Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964846AbWIJUFY@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964846AbWIJUFY (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 10 Sep 2006 16:05:24 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964849AbWIJUFY
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 10 Sep 2006 16:05:24 -0400
Received: from ebiederm.dsl.xmission.com ([166.70.28.69]:24747 "EHLO
	ebiederm.dsl.xmission.com") by vger.kernel.org with ESMTP
	id S964846AbWIJUFX (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 10 Sep 2006 16:05:23 -0400
From: ebiederm@xmission.com (Eric W. Biederman)
To: Pete Zaitcev <zaitcev@redhat.com>
Cc: Andrew Morton <akpm@osdl.org>,
       Linux Containers <containers@lists.osdl.org>,
       Greg Kroah-Hartman <gregkh@suse.de>, linux-kernel@vger.kernel.org,
       linux-usb-devel@lists.sourceforge.net
Subject: Re: [PATCH] usb: Fixup usb so it uses struct pid
References: <m1hczgfi3h.fsf@ebiederm.dsl.xmission.com>
	<20060910111249.c2e9c5f2.zaitcev@redhat.com>
Date: Sun, 10 Sep 2006 14:04:06 -0600
In-Reply-To: <20060910111249.c2e9c5f2.zaitcev@redhat.com> (Pete Zaitcev's
	message of "Sun, 10 Sep 2006 11:12:49 -0700")
Message-ID: <m1d5a3ebex.fsf@ebiederm.dsl.xmission.com>
User-Agent: Gnus/5.110004 (No Gnus v0.4) Emacs/21.4 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Pete Zaitcev <zaitcev@redhat.com> writes:

> On Sat, 09 Sep 2006 22:42:10 -0600, ebiederm@xmission.com (Eric W. Biederman)
> wrote:
>
>> The problem by remember a user space process by it's pid it is
>> possible that the process will exit, pid wrap around will occur and a
>> different process will appear in it's place.
>
> ... which is completely all right in this case. We used to have an
> implementation which tried to hold onto the task_struct and that sucked.
> It is only possible for the task to disappear without notifying devio
> under very special conditions only, which involve forking with parent
> exiting. In other words, even a buggy application won't trigger this
> without deliberately trying. And when it happens, uid checks make sure
> that other users are not affected.

Right.  I looked to see how hard it was in the usb case, but since
you are in the open and release case I can see it being hard.  I think
this case can also be triggered by file descriptor passing, as that
is another subtle way to dup a file descriptor.

The uid checks keep the current situation from being a security
hole but it is still possible to confuse user space, although you
should be able to do that much more simply by just sending the signal
yourself :)

>>  Holding a reference
>> to a struct pid avoid that problem, and paves the way
>> for implementing a pid namespace.
>
> That may be useful.
>
> The patch itself seems straightforward if we can trust your struct
> pid thingies. If OpenVZ people approve, I don't mind.

So far I haven't seen any complaints on that score.  None from
the mainstream kernel folks the vserver guys or the OpenVz guys.
struct pid itself is in 2.6.18, performing this same function for
proc, but not all of the helper functions have made it beyond -mm
yet.  Most of the rest should make it into 2.6.19.

Eric
