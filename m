Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S284180AbSBDSaI>; Mon, 4 Feb 2002 13:30:08 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S285023AbSBDS36>; Mon, 4 Feb 2002 13:29:58 -0500
Received: from parcelfarce.linux.theplanet.co.uk ([195.92.249.252]:23816 "EHLO
	www.linux.org.uk") by vger.kernel.org with ESMTP id <S284180AbSBDS3z>;
	Mon, 4 Feb 2002 13:29:55 -0500
Date: Mon, 4 Feb 2002 18:29:42 +0000
From: Joel Becker <jlbec@evilplan.org>
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
Cc: Steve Lord <lord@sgi.com>, Chris Wedgwood <cw@f00f.org>,
        Jeff Garzik <garzik@havoc.gtf.org>, Chris Mason <mason@suse.com>,
        Andrea Arcangeli <andrea@suse.de>, Andrew Morton <akpm@zip.com.au>,
        Ricardo Galli <gallir@uib.es>,
        Linux Kernel <linux-kernel@vger.kernel.org>
Subject: Re: O_DIRECT fails in some kernel and FS
Message-ID: <20020204182942.C2092@parcelfarce.linux.theplanet.co.uk>
Mail-Followup-To: Joel Becker <jlbec@evilplan.org>,
	Alan Cox <alan@lxorguk.ukuu.org.uk>, Steve Lord <lord@sgi.com>,
	Chris Wedgwood <cw@f00f.org>, Jeff Garzik <garzik@havoc.gtf.org>,
	Chris Mason <mason@suse.com>, Andrea Arcangeli <andrea@suse.de>,
	Andrew Morton <akpm@zip.com.au>, Ricardo Galli <gallir@uib.es>,
	Linux Kernel <linux-kernel@vger.kernel.org>
In-Reply-To: <1012835730.26397.519.camel@jen.americas.sgi.com> <E16XlK0-0007Wu-00@the-village.bc.nu>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
In-Reply-To: <E16XlK0-0007Wu-00@the-village.bc.nu>; from alan@lxorguk.ukuu.org.uk on Mon, Feb 04, 2002 at 03:46:20PM +0000
X-Burt-Line: Trees are cool.
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Feb 04, 2002 at 03:46:20PM +0000, Alan Cox wrote:
> > If an application is multithreaded and is doing mmap and direct I/O
> > from different threads without doing its own synchronization, then it
> > is broken, there is no ordering guarantee provided by the kernel as
> > to what happens first.
> 
> Providing we don't allow asynchronous I/O with O_DIRECT once asynchronous
> I/O is merged.

	Oh, but async + O_DIRECT is a good thing.  The fundamental
ordering comes down at the block layer.  Things are synchronous there.
An application using async I/O knows that ordering is not guaranteed.
Applications using O_DIRECT know they are skipping the buffer cache.
"Caveat emptor" and "Don't do that then" apply to stupid applications.
	The big issues I see are O_DIRECT alignment size (see my patch
to allow hardsectsize alignment on O_DIRECT ops) and whether or not to
synchronize with the caches upon O_DIRECT write.  Keeping the
page/buffer caches in sync with O_DIRECT writes is a bit of work,
especially with writes smaller than sb_blocksize.  You can either do
that work, or you can say that applications and people using O_DIRECT
should know the caches might be inconsistent.  Large O_DIRECT users,
such as databases, already know this.  They are happily ignorant of
cache inconsistencies.  All they care about is hardsectsize O_DIRECT
operations.

Joel

-- 

Life's Little Instruction Book #267

	"Lie on your back and look at the stars."

			http://www.jlbec.org/
			jlbec@evilplan.org
