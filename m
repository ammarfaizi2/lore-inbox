Return-Path: <linux-kernel-owner+willy=40w.ods.org-S263020AbVAFUSO@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263020AbVAFUSO (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 6 Jan 2005 15:18:14 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263027AbVAFUPw
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 6 Jan 2005 15:15:52 -0500
Received: from adsl-63-197-226-105.dsl.snfc21.pacbell.net ([63.197.226.105]:62866
	"EHLO cheetah.davemloft.net") by vger.kernel.org with ESMTP
	id S263014AbVAFUEp (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 6 Jan 2005 15:04:45 -0500
Date: Thu, 6 Jan 2005 11:59:59 -0800
From: "David S. Miller" <davem@davemloft.net>
To: Andi Kleen <ak@suse.de>
Cc: greg@kroah.com, ak@suse.de, linux-usb-devel@lists.sourceforge.net,
       vandrove@vc.cvut.cz, mst@mellanox.co.il, akpm@osdl.org,
       linux-kernel@vger.kernel.org, discuss@x86-64.org
Subject: Re: [PATCH] macros to detect existance of unlocked_ioctl and
 ioctl_compat
Message-Id: <20050106115959.45d793e1.davem@davemloft.net>
In-Reply-To: <20050106195144.GE28889@wotan.suse.de>
References: <20050105144043.GB19434@mellanox.co.il>
	<s5hd5wjybt8.wl@alsa2.suse.de>
	<20050105133448.59345b04.akpm@osdl.org>
	<20050106140636.GE25629@mellanox.co.il>
	<20050106145356.GA18725@infradead.org>
	<20050106163559.GG5772@vana.vc.cvut.cz>
	<20050106165715.GH1830@wotan.suse.de>
	<20050106172613.GI5772@vana.vc.cvut.cz>
	<20050106175342.GA28889@wotan.suse.de>
	<20050106193520.GA5481@kroah.com>
	<20050106195144.GE28889@wotan.suse.de>
X-Mailer: Sylpheed version 1.0.0rc (GTK+ 1.2.10; sparc-unknown-linux-gnu)
X-Face: "_;p5u5aPsO,_Vsx"^v-pEq09'CU4&Dc1$fQExov$62l60cgCc%FnIwD=.UF^a>?5'9Kn[;433QFVV9M..2eN.@4ZWPGbdi<=?[:T>y?SD(R*-3It"Vj:)"dP
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 6 Jan 2005 20:51:44 +0100
Andi Kleen <ak@suse.de> wrote:

> DaveM can probably give you more details since he tried unsucessfully
> to make it work. I think the problem is that there is no enough
> information for the compat layer to convert everything.

When the usbfs async stuff writes back the status, we are no
longer within the original syscall/ioctl execution any more,
therefore we don't know if we're doing this for a compat task
or not.

Technically we could create a "is_compat_task()" type thing
to check but Andi has always been against that and he's given
good reasons.  I tend to agree with him, especially in that there
are valid cases where a compat task might want to make 64-bit
system calls (f.e. to support 64-bit process debugging from
a 32-bit binary, and this is not fantasy as sparc64 could support
this right now)

As mentioned in the code comment, there are also memory management
issues.  We can cons up a temporary kernel buffer in order to
convert the 32-bit structs into 64-bit ones the usbfs code
expects, but then we have the issue of whether we can keep that
buffer around during the entirety of the async operation and
if so who in the world will free it up and how will they know
to do so?

Finally there are complications wrt. using a kernel buffer in that
we have to thus use set_fs(KERNEL_DS) in order for kernel buffers
to be passed into the usbfs routine translated.  This means that
user space accesses of the actual user buffers wouldn't work, and
we thus need to use temporary kernel buffers for that as well.
This is also incompatible with the async nature of how usbfs wants
to work.

I would suggest something that had a fixed sized and fixed layout
status block.  Something that doesn't change layout or size on any
platform.

It's the pointers all over the place in the usbfs ioctl commands
that causes all of the problems.  If you split things up into,
say, user buffer pointer/len struct and status block struct, it might
be a lot easier to support this stuff.  But I'm even skeptical about
this working.
