Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129092AbRBFS5W>; Tue, 6 Feb 2001 13:57:22 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129383AbRBFS5C>; Tue, 6 Feb 2001 13:57:02 -0500
Received: from nat-pool.corp.redhat.com ([199.183.24.200]:36466 "EHLO
	devserv.devel.redhat.com") by vger.kernel.org with ESMTP
	id <S129092AbRBFS4v>; Tue, 6 Feb 2001 13:56:51 -0500
Date: Tue, 6 Feb 2001 13:54:45 -0500 (EST)
From: Ben LaHaise <bcrl@redhat.com>
To: Ingo Molnar <mingo@elte.hu>
cc: "Stephen C. Tweedie" <sct@redhat.com>,
        Linus Torvalds <torvalds@transmeta.com>,
        Alan Cox <alan@lxorguk.ukuu.org.uk>,
        Manfred Spraul <manfred@colorfullife.com>, Steve Lord <lord@sgi.com>,
        Linux Kernel List <linux-kernel@vger.kernel.org>,
        <kiobuf-io-devel@lists.sourceforge.net>,
        Ingo Molnar <mingo@redhat.com>
Subject: Re: [Kiobuf-io-devel] RFC: Kernel mechanism: Compound event wait
In-Reply-To: <Pine.LNX.4.30.0102061932040.7249-100000@elte.hu>
Message-ID: <Pine.LNX.4.30.0102061338380.15204-100000@today.toronto.redhat.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 6 Feb 2001, Ingo Molnar wrote:

> If you are merging based on (device, offset) values, then that's lowlevel
> - and this is what we have been doing for years.
>
> If you are merging based on (inode, offset), then it has flaws like not
> being able to merge through a loopback or stacked filesystem.

I disagree.  Loopback filesystems typically have their data contiguously
on disk and won't split up incoming requests any further.

Here are the points I'm trying to address:

	- reduce the overhead in submitting block ios, especially for
	  large ios. Look at the %CPU usages differences between 512 byte
	  blocks and 4KB blocks, this can be better.
	- make asynchronous io possible in the block layer.  This is
	  impossible with the current ll_rw_block scheme and io request
	  plugging.
	- provide a generic mechanism for reordering io requests for
	  devices which will benefit from this.  Make it a library for
	  drivers to call into.  IDE for example will probably make use of
	  it, but some high end devices do this on the controller.  This
	  is the important point: Make it OPTIONAL.

You mentioned non-spindle base io devices in your last message.  Take
something like a big RAM disk.  Now compare kiobuf base io to buffer head
based io.  Tell me which one is going to perform better.

		-ben

-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
