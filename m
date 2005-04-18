Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262010AbVDROHN@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262010AbVDROHN (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 18 Apr 2005 10:07:13 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262025AbVDROHN
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 18 Apr 2005 10:07:13 -0400
Received: from mx1.redhat.com ([66.187.233.31]:21429 "EHLO mx1.redhat.com")
	by vger.kernel.org with ESMTP id S262010AbVDROHD (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 18 Apr 2005 10:07:03 -0400
Date: Mon, 18 Apr 2005 10:06:55 -0400 (EDT)
From: Rik van Riel <riel@redhat.com>
X-X-Sender: riel@chimarrao.boston.redhat.com
To: Takashi Ikebe <ikebe.takashi@lab.ntt.co.jp>
cc: Chris Wedgwood <cw@f00f.org>, Paul Jackson <pj@sgi.com>,
       linux-kernel@vger.kernel.org
Subject: Re: [PATCH x86_64] Live Patching Function on 2.6.11.7
In-Reply-To: <4263AD94.0@lab.ntt.co.jp>
Message-ID: <Pine.LNX.4.61.0504181001470.8456@chimarrao.boston.redhat.com>
References: <4263275A.2020405@lab.ntt.co.jp> <20050418040718.GA31163@taniwha.stupidest.org>
 <4263356D.9080007@lab.ntt.co.jp> <20050418061221.GA32315@taniwha.stupidest.org>
 <42636285.9060405@lab.ntt.co.jp> <20050418075635.GB644@taniwha.stupidest.org>
 <20050418021609.07f6ec16.pj@sgi.com> <20050418092505.GA2206@taniwha.stupidest.org>
 <Pine.LNX.4.61.0504180726320.3232@chimarrao.boston.redhat.com>
 <4263AD94.0@lab.ntt.co.jp>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 18 Apr 2005, Takashi Ikebe wrote:

> I believe process status copy consume more time, may be below sequences are
> needed;
> - Stop the service on ACT-process.
> - Copy on memory/on transaction status to shared memory.

No need for this, the process could ALWAYS store its
status in a shared memory status.  This is just as
fast as private memory, only more flexible.

> - Takeover shared memory key to SBY process and release the shared memory
> - SBY process access to shared memory.

Which means the SBY process can attach to the shared
memory region while the ACT process is running.  It
can then communicate with the ACT process through a
socket ...

> - SBY process checks the memory and reset broken sessions.
> - SBY process restart the service.

... and the SBY process can take over immediately.
The state machine running the SBY software can
continue using the same data structures the ACT
process was using beforehand, since they're in a 
shared memory region.

> Some part may be parallelize, but seems the more data make service 
> disruption time longer...(It seems exceeds 100 milliseconds depends on 
> data size..) and process will be more complicated....makes more bugs...

The data size should not be an issue, since the primary
copy of the state is in the shared memory area.

The state machine in the SBY process can directly run
using those data structures, so no copying is needed.

The only overhead will be inter-process communication,
having the first process close file descriptors, yielding
the CPU to the second process, which then opens up the
devices again.  We both know how long a context switch
and an open() syscall take - negligable.

The old version of the program can shut itself down
after it knows the new version has taken over - in the
background, without disrupting the now active process.

-- 
"Debugging is twice as hard as writing the code in the first place.
Therefore, if you write the code as cleverly as possible, you are,
by definition, not smart enough to debug it." - Brian W. Kernighan
