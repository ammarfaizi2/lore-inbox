Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262775AbTKWSAF (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 23 Nov 2003 13:00:05 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263376AbTKWSAF
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 23 Nov 2003 13:00:05 -0500
Received: from fw.osdl.org ([65.172.181.6]:38891 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S262775AbTKWSAB (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 23 Nov 2003 13:00:01 -0500
Date: Sun, 23 Nov 2003 09:59:47 -0800 (PST)
From: Linus Torvalds <torvalds@osdl.org>
To: "H. Peter Anvin" <hpa@zytor.com>
cc: linux-kernel@vger.kernel.org
Subject: Re: x86: SIGTRAP handling differences from 2.4 to 2.6
In-Reply-To: <bppjkt$ik0$1@cesium.transmeta.com>
Message-ID: <Pine.LNX.4.44.0311230954460.17378-100000@home.osdl.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


On 22 Nov 2003, H. Peter Anvin wrote:
> > 
> > Hmm.. Looking at the signal sending code, we actually do special-case 
> > "init" there already - but only for the "kill -1" case. If the test for 
> > "pid > 1" was moved into "group_send_sig_info()" instead, that would 
> > pretty much do it, I think.
> > 
> 
> Okay... I'm going to ask the obvious dumb question:
> 
> Why do we bother special-casing init at all?

Because the kernel depends on it existing. "init" literally _is_ special 
from a kernel standpoint, because its' the "reaper of zombies" (and, may I 
add, that would be a great name for a rock band).

So without init, the kernel wouldn't have anybody to fall back on when a 
parent process dies, and would become very very unhappy. Historically it 
actually oopsed the kernel.

UNIX semantics literally _require_ that "getppid()" should return 1 if 
your parent dies, and that's "current->p_parent->tgid". So we have to have 
a parent with pid 1, and thus init really _is_ special.

Yeah, we could have _other_ special cases (we could create another process 
that is invisible and has pid 1), but the fact is, _some_ special case is 
required. It might as well be "you can't kill init".

		Linus

