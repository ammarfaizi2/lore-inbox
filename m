Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S264646AbTA0Xvd>; Mon, 27 Jan 2003 18:51:33 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S264688AbTA0Xvd>; Mon, 27 Jan 2003 18:51:33 -0500
Received: from holomorphy.com ([66.224.33.161]:24487 "EHLO holomorphy")
	by vger.kernel.org with ESMTP id <S264646AbTA0Xvc>;
	Mon, 27 Jan 2003 18:51:32 -0500
Date: Mon, 27 Jan 2003 15:59:39 -0800
From: William Lee Irwin III <wli@holomorphy.com>
To: Stephen Hemminger <shemminger@osdl.org>
Cc: Andrew Morton <akpm@digeo.com>, green@namesys.com,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, hch@lst.de,
       jack@suse.cz, mason@suse.com
Subject: Re: ext2 FS corruption with 2.5.59.
Message-ID: <20030127235939.GC780@holomorphy.com>
Mail-Followup-To: William Lee Irwin III <wli@holomorphy.com>,
	Stephen Hemminger <shemminger@osdl.org>,
	Andrew Morton <akpm@digeo.com>, green@namesys.com,
	Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
	hch@lst.de, jack@suse.cz, mason@suse.com
References: <20030124023213.63d93156.akpm@digeo.com> <20030124153929.A894@namesys.com> <20030124225320.5d387993.akpm@digeo.com> <20030125153607.A10590@namesys.com> <20030125190410.7c91e640.akpm@digeo.com> <20030126032815.GA780@holomorphy.com> <20030125194648.6c417699.akpm@digeo.com> <20030126041426.GB780@holomorphy.com> <20030125211003.082cb92c.akpm@digeo.com> <1043708361.10153.151.camel@dell_ss3.pdx.osdl.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1043708361.10153.151.camel@dell_ss3.pdx.osdl.net>
User-Agent: Mutt/1.3.25i
Organization: The Domain of Holomorphy
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

William Lee Irwin III <wli@holomorphy.com> wrote:
>>>>> Ticket locks need atomic fetch and increment. These don't look right.

On Mon, Jan 27, 2003 at 02:59:21PM -0800, Stephen Hemminger wrote:
> Atomic fetch/increment is not necessary since it is assumed that
> only a single writer is doing the increment at a time, either with a
> lock or a semaphore.  The fr_write_lock primitive incorporates the
> spinlock and the sequence number. 

Ticket locks still need atomic fetch and increment. You don't because
not only are you not implementing a ticket lock, you've got an outright
spinlock around the fetch and increment.


William Lee Irwin III <wli@holomorphy.com> wrote:
>>> 	(1) increment ->pre_sequence
>>> 	(2) wmb()
>>> 	(3) get inode->i_size
>>> 	(4) wmb() 
>>> 	(5) increment ->post_sequence
>>> 	(6) wmb()
>>> Supposing the overall scheme is sound, one of the wmb()'s is unnecessary;

On Mon, Jan 27, 2003 at 02:59:21PM -0800, Stephen Hemminger wrote:
> Each wmb() has a purpose. (2) is to make sure the first increment
> happens before the update. (4) makes sure the update happens before the
> second increment.  
> The last wmb is unnecessary. Also on many architectures, the wmb()
> disappears since writes are never reordered.

This is apparently based on some misunderstanding wrt. thinking the
sequence of events above described a read. Obviously converting (3)
to "modify inode->i_size" makes the (4) wmb() necessary.


-- wli
