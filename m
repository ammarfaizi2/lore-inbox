Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261793AbUCGKAg (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 7 Mar 2004 05:00:36 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261795AbUCGKAe
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 7 Mar 2004 05:00:34 -0500
Received: from main.gmane.org ([80.91.224.249]:51901 "EHLO main.gmane.org")
	by vger.kernel.org with ESMTP id S261793AbUCGKAc (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 7 Mar 2004 05:00:32 -0500
X-Injected-Via-Gmane: http://gmane.org/
To: linux-kernel@vger.kernel.org
From: Mike Hearn <mh@codeweavers.com>
Subject: Re: Potential bug in fs/binfmt_elf.c?
Date: Sun, 07 Mar 2004 09:58:44 +0000
Organization: CodeWeavers, Inc
Message-ID: <pan.2004.03.07.09.58.43.675972@codeweavers.com>
References: <1078508281.3065.33.camel@linux.littlegreen> <404A1C71.3010507@redhat.com> <1078607410.10313.7.camel@linux.littlegreen> <404ABD06.4060607@redhat.com>
Reply-To: mike@theoretic.com
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
X-Complaints-To: usenet@sea.gmane.org
X-Gmane-NNTP-Posting-Host: e-ucs036.dur.ac.uk
User-Agent: Pan/0.14.2 (This is not a psychotic episode. It's a cleansing moment of clarity.)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 06 Mar 2004 22:11:18 -0800, Ulrich Drepper wrote:
> Not everything which can be expressed in ELF is supported.  You don't
> want to load something, you want to reserve address space.  And you want
> it allocated in a certain way.  The ELF loader is no generic ELF
> interpreter.

Ah, OK. I was hoping this would not the answer.
 
> Now, if the only problem is the overcommit and making the do_brk() call
> allocate the memory as read-only a change to the do_brk() interface
> might be acceptable (well, ask somebody doing mm hacking).  I wouldn't
> be entirely sure whether read-only pages alone are enough.  This does
> not open any new holes as far as I can see.

This is certainly one long term solution, but we'd like to avoid kernel
hacking if at all possible. We have a prototype of a program which is
statically linked then turns itself into a dynamically linked app by
bootstrapping the ELF interpreter in the same way the kernel does after
mapping the range wanted with MAP_NORESERVE. Obviously we'd like the real
fix, but something which works nicely on Fedora Core 1 machines today is
also necessary.

Thanks for your advice. One quick question - you said binfmt_elf is not a
generic ELF interpreter, but the one in glibc presumably is yes? Would it
be possible to achieve the effect wanted by having a dummy stub binary
linked with -nostdlib etc, so it's a dynamically linked ELF program with
only one DT_NEEDED entry which is against the real binary.

This would short-circuit the kernel loader and pass control as soon as 
possible to glibc, which would follow the first DT_NEEDED entry and map in
the real binary, which in turn contains the PE load area reservation
section. IIRC glibc always uses mmap to map ELF sections so this could
work better.

Does this sound plausible? If so, do you have any tips on where to look
for docs on it? Last time I tried compiling something with -nostdlib, I
ran into problems with the default linker script not liking it (entry
points I think).

thanks -mike

