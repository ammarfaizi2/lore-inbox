Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S316610AbSE3MhG>; Thu, 30 May 2002 08:37:06 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S316614AbSE3MhF>; Thu, 30 May 2002 08:37:05 -0400
Received: from fungus.teststation.com ([212.32.186.211]:46600 "EHLO
	fungus.teststation.com") by vger.kernel.org with ESMTP
	id <S316610AbSE3MhD>; Thu, 30 May 2002 08:37:03 -0400
Date: Thu, 30 May 2002 14:36:43 +0200 (CEST)
From: Urban Widmark <urban@teststation.com>
X-X-Sender: <puw@cola.enlightnet.local>
To: Mike Fedyk <mfedyk@matchmail.com>
cc: <linux-kernel@vger.kernel.org>
Subject: Re: Processes stuck in D state with autofs + smbfs
In-Reply-To: <20020529172616.GB1136@matchmail.com>
Message-ID: <Pine.LNX.4.33.0205301421540.1921-100000@cola.enlightnet.local>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 29 May 2002, Mike Fedyk wrote:

> I'm currently running 2.4.19-pre6-vm33 on this 2x664Mhz P3 machine, but I've
> also had the problem in the previous UP machine.
> 
> I'm not sure what information will be helpful in debugging this probem.
> Would sysrq+t run through ksymoops be helpful?

Yes, it could show where the process is stuck. Probably what has happened
is that some process is blocked while holding the smbfs semaphore (there
is one per mount).

All others will then get stuck in 'D' state trying to get that semaphore.

The "classic" way to get this is to have a server that is shutdown while
it is mounted. There are patches to help with that (and if I wasn't so
slow sometimes a simple fix would already be in 2.4.something, after
2.4.19 I promise).


> I also have this in my kernel log:
> May 26 06:33:16 fileserver kernel: Uhhuh. NMI received. Dazed and confused, but trying to continue
> May 26 06:33:16 fileserver kernel: You probably have a hardware problem with your RAM chips

However, this error could (but I don't really know what the effects are of
this) potentially stop a process at some random point. If a process
crashes, for example an oops, while holding the semaphore that semaphore
will still be held and everyone trying to get in will stop in D state.


There are some patches here:
http://www.hojdpunkten.ac.se/054/samba/index.html

But that server appears to be down right now.

There is one patch that uses poll to help with the problem of a server
that is gone, and another that changes a lot of how smbfs sends requests
and additionaly makes the user processes always(?) be interruptible.

But if the NMIs are killing things at random points then none of those
patches will help.

/Urban

