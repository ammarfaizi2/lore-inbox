Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S132427AbRDMXv7>; Fri, 13 Apr 2001 19:51:59 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S132433AbRDMXvu>; Fri, 13 Apr 2001 19:51:50 -0400
Received: from freya.yggdrasil.com ([209.249.10.20]:20609 "EHLO
	freya.yggdrasil.com") by vger.kernel.org with ESMTP
	id <S132427AbRDMXvh>; Fri, 13 Apr 2001 19:51:37 -0400
From: "Adam J. Richter" <adam@yggdrasil.com>
Date: Fri, 13 Apr 2001 16:51:34 -0700
Message-Id: <200104132351.QAA05523@adam.yggdrasil.com>
To: chief@bandits.org
Subject: Re: PATCH(?): linux-2.4.4-pre2: fork should run child first
Cc: linux-kernel@vger.kernel.org, torvalds@transmeta.com
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

"John Fremlin" <chief@bandits.org> writes:
> "Adam J. Richter" <adam@yggdrasil.com> writes:
>> 	Guess why you're seeing this email.  That's right.  Linux-2.4.3's
>> fork() does not run the child first.

>[...] If an app wants to fork and exec, it
>should use *vfork* and exec, which is a performance win across many
>OSs because the COW mappings don't even have to be set up, IIRC.

	Even in that case, you want to run the child first because
it may block on I/O when it does the exec or the new program starts
running, and you are likely to be able to use that time while the
child is waiting on I/O for the parent to run (typically just to
record the process in its internal data structures and then call
wait()).  Basically, you want to kick off some new I/O before running
something that can run while that I/O is pending.

	Of course, in the vfork case, this change is probably only a
very small win.  The real advantage is with regular fork() followed
by an exec, which happens quite a lot.  For example, I do not see
vfork anywhere in the bash sources.

Adam J. Richter     __     ______________   4880 Stevens Creek Blvd, Suite 104
adam@yggdrasil.com     \ /                  San Jose, California 95129-1034
+1 408 261-6630         | g g d r a s i l   United States of America
fax +1 408 261-6631      "Free Software For The Rest Of Us."
