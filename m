Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S280357AbRKKSdc>; Sun, 11 Nov 2001 13:33:32 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S280000AbRKKSdW>; Sun, 11 Nov 2001 13:33:22 -0500
Received: from neon-gw-l3.transmeta.com ([63.209.4.196]:3341 "EHLO
	neon-gw.transmeta.com") by vger.kernel.org with ESMTP
	id <S280357AbRKKSdH>; Sun, 11 Nov 2001 13:33:07 -0500
From: Linus Torvalds <torvalds@transmeta.com>
Date: Sun, 11 Nov 2001 10:29:09 -0800
Message-Id: <200111111829.fABIT9v14680@penguin.transmeta.com>
To: sim@netnation.com, linux-kernel@vger.kernel.org
Subject: Re: Writing over NFS causes lots of paging
Newsgroups: linux.dev.kernel
In-Reply-To: <20011111024855.A5893@netnation.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

In article <20011111024855.A5893@netnation.com> you write:
>It looks like when writing large amounts of data to NFS where the remote
>end is slower than the local end the local end appears to start swapping
>out a lot I'm guessing this is because it can read much faster than it
>can write.

No, the real reason for why the NFS write stuff causes page-outs is that
the VM layer does not really understand the notion of writeback pages.

The VM layer has one explicit special case: it knows about the magic in
"page->buffers", and can handle writeback for block-oriented devices
sanely. But any non-buffer-oriented filesystem is "invisible" to the VM
layer, and has to use other tricks to make the VM ignore its pages.

In the case of NFS, it increments the page count and has it's own
private non-VM-visible writeback data structures.  This pins the page in
memory, but at the same time, because the VM doesn't understand it, the
VM will end up thinking the page is mapped in user space or something
else, and won't know how to start writeouts. 

Quite frankly, I don't rightly know what the real fix is. Making
"page->buffers" be a generic thing (a "void *") along with making the
buffer flushing logic be behind a address space operation is probably
the right thing in the long run.

		Linus
