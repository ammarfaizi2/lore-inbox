Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S265051AbSLMQIg>; Fri, 13 Dec 2002 11:08:36 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S265058AbSLMQIg>; Fri, 13 Dec 2002 11:08:36 -0500
Received: from nat-pool-rdu.redhat.com ([66.187.233.200]:44239 "EHLO
	devserv.devel.redhat.com") by vger.kernel.org with ESMTP
	id <S265051AbSLMQIe>; Fri, 13 Dec 2002 11:08:34 -0500
Date: Fri, 13 Dec 2002 11:16:17 -0500
From: Pete Zaitcev <zaitcev@redhat.com>
Message-Id: <200212131616.gBDGGH302861@devserv.devel.redhat.com>
To: Marc-Christian Petersen <m.c.p@wolk-project.de>
cc: linux-kernel@vger.kernel.org
Subject: Re: Symlink indirection
In-Reply-To: <mailman.1039792562.8768.linux-kernel2news@redhat.com>
References: <3DF9F780.1070300@walrond.org> <mailman.1039792562.8768.linux-kernel2news@redhat.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>> Is the number of allowed levels of symlink indirection (if that is the
>> right phrase; I mean symlink -> symlink -> ... -> file) dependant on the
>> kernel, or libc ? Where is it defined, and can it be changed?
> 
> fs/namei.c
> 
>  if (current->link_count >= 5)
> 
> change to a higher value.

This is vey, very misleading statement. The counter mentioned above
is there to protect stacks from overflow, but our symlink resolution
is largely non-recursive, and certainly not in case of a tail
recursion within the same directory.

Also, consider this message from Al:

----------------------------------------------------
From: Alexander Viro <aviro@redhat.com>
Date: Mon, 3 Jun 2002 13:01:16 -0400

On Mon, Jun 03, 2002 at 12:21:59PM -0400, Matt Wilson wrote:
> SUSv3:
>
> http://www.opengroup.org/onlinepubs/007904975/basedefs/limits.h.html
>
> {_POSIX_SYMLOOP_MAX} The number of symbolic links that can be
>     traversed in the resolution of a pathname in the absence of a
>     loop.  Value: 8

... and that has nothing to said limit of 5.  What we do have limited
is the number of nested symlinks.  4BSD and derived Unices limit the
total amount of symlinks traveresed in pathname resolution.  Example:
if you have

/a -> b
/b/a -> b
/b/b/a -> b
/b/b/b/a -> b
/b/b/b/b/a -> b
/b/b/b/b/b/a -> b
/b/b/b/b/b/b/a -> b
/b/b/b/b/b/b/b/a -> b
/b/b/b/b/b/b/b/b/a -> b
 
the pathname
 
/a/a/a/a/a/a/a/a/a
 
will resolve to
 
/b/b/b/b/b/b/b/b/b
 
and there will be 9 symlink traversals done during the pathname resolution.
However, the depth (i.e. the thing we do limit) is 1 in that case.  OTOH,
with

/1 -> 2/a
/2 -> 3/a
/3 -> 4/a
/4 -> 5/a
/5 -> 6/a
/6 -> 7/a

/1

will resolve to

/7/a/a/a/a/a/a

with 6 symlink traversals and depth 6.  IOW, SuS limit is not an argument
for changing the Linux one - they limit different things.  They are not
independent, of course, since depth of recursion can't be greater than
total amount of symlinks we had traversed, but that's a separate story.

Frankly, all cases when I had seen the nested symlink farms of that
depth would be better served by use of bindings - these are not subject
to any limits on nesting and avoid a lot of PITA inherent to symlink
farms.  To put it another way, nested symlink farms grow from attempts
to work around the lack of bindings.  It's not that you need to replace
all symlinks with bindings, of course - the crown of the tree is usually
OK, it's the trunk that acts as source of pain.
