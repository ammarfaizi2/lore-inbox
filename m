Return-Path: <linux-kernel-owner+w=401wt.eu-S932431AbXAPHY5@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932431AbXAPHY5 (ORCPT <rfc822;w@1wt.eu>);
	Tue, 16 Jan 2007 02:24:57 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932333AbXAPHYy
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 16 Jan 2007 02:24:54 -0500
Received: from smtp113.sbc.mail.mud.yahoo.com ([68.142.198.212]:42556 "HELO
	smtp113.sbc.mail.mud.yahoo.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with SMTP id S932435AbXAPHYw (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 16 Jan 2007 02:24:52 -0500
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
  s=s1024; d=pacbell.net;
  h=Received:X-YMail-OSG:From:To:Subject:Date:User-Agent:Cc:References:In-Reply-To:MIME-Version:Content-Disposition:Message-Id:Content-Type:Content-Transfer-Encoding;
  b=huTJ/7OquVcLxGJPvxnhLHZR/TE8KeGIxOVKTNoI7dI3SX8DmeZ3NFSiwCY7rUae/vfzEQodmR+JPd+ZbYTJrUXWXaS9E3KyreAUZB3Tb9nQiReir7klf1LknKMF83bfeJVcLUjcU6ITKD/RYOw1t5lCjX6Y7bWPlfmUxI3Y2EI=  ;
X-YMail-OSG: L8ZIqA0VM1l.mH8Awn74Pxfbe1uQYx015Pg3QP8DswJuF4byxYF360.IejBUglUbWDZE50Zd1vf1W_uH1ZaBG.hr34O5xH3rXzbsRUX4FN9NCK2Ucgwakx3AtC5_NTg.9OtfVcHDskA3exc-
From: David Brownell <david-b@pacbell.net>
To: Nate Diller <nate@agami.com>
Subject: Re: [PATCH -mm 9/10][RFC] aio: usb gadget remove aio file ops
Date: Mon, 15 Jan 2007 22:05:43 -0800
User-Agent: KMail/1.7.1
Cc: Nate Diller <nate.diller@gmail.com>, Andrew Morton <akpm@osdl.org>,
       Alan Cox <alan@lxorguk.ukuu.org.uk>,
       Trond Myklebust <trond.myklebust@fys.uio.no>,
       Benjamin LaHaise <bcrl@kvack.org>,
       Alexander Viro <viro@zeniv.linux.org.uk>,
       Suparna Bhattacharya <suparna@in.ibm.com>,
       Kenneth W Chen <kenneth.w.chen@intel.com>,
       David Brownell <dbrownell@users.sourceforge.net>,
       Christoph Hellwig <hch@infradead.org>, linux-kernel@vger.kernel.org,
       linux-fsdevel@vger.kernel.org, netdev@vger.kernel.org,
       ocfs2-devel@oss.oracle.com, linux-aio@kvack.org,
       xfs-masters@oss.sgi.com
References: <20070116015450.9764.62432.patchbomb.py@nate-64.agami.com>
In-Reply-To: <20070116015450.9764.62432.patchbomb.py@nate-64.agami.com>
MIME-Version: 1.0
Content-Disposition: inline
Message-Id: <200701152205.46089.david-b@pacbell.net>
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Monday 15 January 2007 5:54 pm, Nate Diller wrote:
> This removes the aio implementation from the usb gadget file system. 

NAK.  I see a deep mis-understanding here.


> Aside 
> from making very creative (!) use of the aio retry path, it can't be of any
> use performance-wise 

Other than the basic win of letting one userspace thread keep an I/O
stream active while at the same time processing the data it reads or
writes??  That's the "async" part of AIO.

There's a not-so-little thing called "I/O overlap" ... which is the only
way to prevent wasting bandwidth between (non-cacheable) I/O requests,
and thus is the only way to let userspace code achieve anything close
to the maximum I/O bandwidth the hardware can achieve.

We want to see the host side "usbfs" evolve to support AIO like this
too, for the same reasons.  (Currently it has fairly ugly AIO code
that looks unlike any other AIO code in Linux.  Recent updates to
support a file-per-endpoint device model are a necessary precursor
to switching over to standard AIO syscalls.)


> because it always kmalloc()s a bounce buffer for the 
> *whole* I/O size.

By and large that's a negligible factor compared to being able to
achieve I/O overlap.  ISTR the reason for not doing fancy DMA magic
was that the cost of this style AIO was under 1 KByte object code
on ARM, which was easy to justify ... while DMA magic to do that
sort of stuff would be much fatter, as well as more error prone.

(And that's why the "creative" use of the retry path.  As I've
observed before, "retry" is a misnomer in the general sense of
an async I/O framework.  It's more of a semi-completion callback;
I/O can't in general be "retried" on error or fault, and even in
the current usage it's not really a "retry".)


Now that high speed peripheral hardware is becoming more common on
embedded Linuxes -- TI has DaVinci, OMAP 2430, TUSB6010 (as found
in the new Nokia 800 tablets); Atmel AVR32 AP7000; at least a couple
parts that should be able to use the same musb_hdrc driver as those
TI parts; and a few other chips I've heard of -- there may be some
virtue in eliminating the memcpy, since those CPUs don't have many
MIPS to waste.  (Iff the memcpy turns out to be a real issue...)


> Perhaps the only reason to keep it around is the ability 
> to cancel I/O requests, which only applies when using the user space async
> I/O interface.  

It's good to have almost the complete kernel API functionality
exposed to userspace, and having I/O cancelation is an inevitable
consequence of a complete AIO framework ... but that particular
issue was not a driving concern.


The reason for AIO is to have a *STANDARD* userspace interface
for *ASYNC I/O* which otherwise can't exist.  You know, the kind
of I/O interface that can't be implemented with read() and write()
syscalls, which for non-buffered I/O necessarily preclude all I/O
overlap.  AIO itself is a direct match to most I/O frameworks'
primitives.  (AIOCB being directly analagous to peripheral side
"struct usb_request" and host side "struct urb".)


You know, I've always thought that one reason the AIO discussions
seemed strange is that they weren't really focussed on I/O (the
lowlevel after-the-caches stuff) so much as filesystems (several
layers up in the stack, with intervening caching frameworks).

The first several implementations of AIO that I saw were restricted
to "real" I/O and not applicable to disk backed files.  So while I
was glad the Linux approach didn't make that mistake, it's seemed
that it might be wanting to make a converse mistake: neglecting I/O
that isn't aimed at data stored on disks.


> I highly doubt that is enough incentive to justify the extra 
> complexity here or in user-space, so I think it's a safe bet to remove this. 
> If that feature still desired, it would be possible to implement a sync
> interface that does an interruptible sleep.

What's needed is an async, non-sleeeping, interface ... with I/O
overlap.  That's antithetical to using read()/write() calls, so
your proposed approach couldn't possibly work.

- Dave


