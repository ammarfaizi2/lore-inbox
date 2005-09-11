Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932411AbVIKDQO@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932411AbVIKDQO (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 10 Sep 2005 23:16:14 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932414AbVIKDQO
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 10 Sep 2005 23:16:14 -0400
Received: from smtpout.mac.com ([17.250.248.71]:998 "EHLO smtpout.mac.com")
	by vger.kernel.org with ESMTP id S932411AbVIKDQN (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 10 Sep 2005 23:16:13 -0400
In-Reply-To: <20050910174818.579bc287.akpm@osdl.org>
References: <C670AD22-97CF-46AA-A527-965036D78667@mac.com> <20050903064124.GA31400@codepoet.org> <4319BEF5.2070000@zytor.com> <B9E70F6F-CC0A-4053-AB34-A90836431358@mac.com> <dfhs4u$1ld$1@terminus.zytor.com> <5A37B032-9BBD-4AEA-A9BF-D42AFF79BC86@mac.com> <9C47C740-86CF-48F1-8DB6-B547E5D098FF@mac.com> <97597F8E-DDCE-479F-AE8D-CC7DC75AB3C3@mac.com> <20050910014543.1be53260.akpm@osdl.org> <4FAE9F58-7153-4574-A2C3-A586C9C3CFF1@mac.com> <20050910150446.116dd261.akpm@osdl.org> <E352D8E3-771F-4A0D-9403-DBAA0C8CBB83@mac.com> <20050910174818.579bc287.akpm@osdl.org>
Mime-Version: 1.0 (Apple Message framework v734)
Content-Type: text/plain; charset=US-ASCII; delsp=yes; format=flowed
Message-Id: <93E9C5F9-A083-4322-A580-236E2232CCC0@mac.com>
Cc: linux-kernel@vger.kernel.org, hpa@zytor.com, bunk@stusta.de
Content-Transfer-Encoding: 7bit
From: Kyle Moffett <mrmacman_g4@mac.com>
Subject: Re: [RFC][MEGAPATCH] Change __ASSEMBLY__ to __ASSEMBLER__ (defined by GCC from 2.95 to current CVS)
Date: Sat, 10 Sep 2005 23:15:44 -0400
To: Andrew Morton <akpm@osdl.org>
X-Mailer: Apple Mail (2.734)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sep 10, 2005, at 20:48:18, Andrew Morton wrote:
>>  1)  At some point the arch/driver/etc maintainers (for anything that
>>  interacts with userspace), need to start converting things on their
>>  own (such as moving ioctl and struct declarations to a <kabi/*.h>
>>  header file), because the people working on it certainly don't have
>>  all the varieties of hardware and userspace programs that would be
>>  affected by this change.
>
> This will be very disruptive.

I know, but currently it places a lot of unnecessary load on the
linux-libc-headers maintainer, and sometimes that doesn't get done
correctly.  For most of the above, all the maintainer will need to
do is move the ioctl and struct declarations necessary in userspace
from the header file in linux/ to a corresponding one in kabi/,
_maybe_ change a few macro names, and then verify that it all still
works correctly.

>>  2)  The goal is to minimize changes to kernel code.  I'm not out to
>>  rename "struct list_head", that would be silly!  Instead, the header
>>  <linux/list.h>  would be basically reduced to this:
>>
>>  #ifndef  __LINUX_LIST_H
>>  # define __LINUX_LIST_H 1
>>  # ifdef __KERNEL__
>>
>>  #  define __kcore_list_item list_head
>>  #  include <kcore/list.h>
>>  #  define list_add(x,y) __kcore_list_add(x,y)
>>
>>  [...etc...]
>>
>>  # endif /* __KERNEL__ */
>>  #endif /* not __LINUX_LIST_H */
>
> I hope list.h was a poorly-chosen example, and that there are no  
> plans to
> actually do anything like the above to list.h.

Yeah, that was actually a rather poorly chosen example, but it
does somewhat illustrate the way we would preserve compatibility.

> Surely the only files which need to be altered are those which we can
> reasonably expect userspace to actually include.

Yeah.  I would have given one of the types.h files, except those
are so massively chaotic and with all sorts of cross dependencies
that I haven't tinkered with them enough yet.  I'm working on it,  
though!

>>  3)  Another side effect of this project will be that we will have
>>  the chance to clean up and merge some of the stuff currently in
>>  the asm-* directories.
>
> I'd suggest that you avoid side-effects.  Unrelated cleanups are  
> unrelated
> - do it as a separate project.

My plan is to start with a bunch of cleanups that make it easier
to split the files, and then proceed to begin splitting the low
level files that are essential to everything else.  Once that's
done, I would move on to the other headers, the ones that have
dependencies on lots of headers.  I'll probably have to submit
cleanups to stuff like linux/kernel.h, linux/sched.h, etc, to
prevent include cycles.

> I'm very dubious about the whole idea, frankly.

This would make life a million times easier for the UML people,
the glibc people, the klibc people, and the linux-libc-headers
maintainer (IE: you don't need one, and he can go do something
more productive), etc.  If you want proof, several of the above
groups have previously voiced in support of this project in
this very thread.

This is definitely not a short-term project, and will really only
reach significant improvements for those groups by around
2.6.30 or so, but many feel it's a necessary change.

Cheers,
Kyle Moffett

--
I lost interest in "blade servers" when I found they didn't throw  
knives at
people who weren't supposed to be in your machine room.
   -- Anthony de Boer


