Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S287841AbSBCWp7>; Sun, 3 Feb 2002 17:45:59 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S287855AbSBCWpk>; Sun, 3 Feb 2002 17:45:40 -0500
Received: from tapu.f00f.org ([63.108.153.39]:44734 "EHLO tapu.f00f.org")
	by vger.kernel.org with ESMTP id <S287841AbSBCWpc>;
	Sun, 3 Feb 2002 17:45:32 -0500
Date: Sun, 3 Feb 2002 14:44:06 -0800
From: Chris Wedgwood <cw@f00f.org>
To: Stephen Lord <lord@sgi.com>
Cc: Jeff Garzik <garzik@havoc.gtf.org>, Chris Mason <mason@suse.com>,
        Andrea Arcangeli <andrea@suse.de>, Andrew Morton <akpm@zip.com.au>,
        Ricardo Galli <gallir@uib.es>,
        Linux Kernel <linux-kernel@vger.kernel.org>
Subject: Re: O_DIRECT fails in some kernel and FS
Message-ID: <20020203224406.GA17396@tapu.f00f.org>
In-Reply-To: <1012597538.26363.443.camel@jen.americas.sgi.com> <20020202093554.GA7207@tapu.f00f.org> <234710000.1012674008@tiny> <20020202205438.D3807@athlon.random> <242700000.1012680610@tiny> <3C5C4929.5080403@sgi.com> <20020202155028.B26147@havoc.gtf.org> <3C5D3DE9.4080503@sgi.com> <20020203140926.GA14532@tapu.f00f.org> <3C5D51A0.4050509@sgi.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <3C5D51A0.4050509@sgi.com>
User-Agent: Mutt/1.3.27i
X-No-Archive: Yes
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Feb 03, 2002 at 09:05:04AM -0600, Stephen Lord wrote:

    I agree is is not a big issue in this case - my interpretation of
    tails was the end of any file could be packed, but if it is only
    small files.....

But you can't mmap (say) a 1k file right now...  so right now this
isn't a problem, but at some point a larger mmap granularity would be
nice --- especially on architectures with small (or untagged) TLBs.
I'm guessing so as not to break backwards compatibility we will have
to support variable page-sizes (creating a plethora of nasties I
imagine).

    They are invalidated at the start of the I/O

Cool.  That much I'd like to see under Linux

    but page faults are not blocked out for the duration of the I/O so
    the coherency is weak.

I was thinking this would also be goof, basically invalidate those
pages and remove them from the VMAs, marking them as unusable pending
IO completion --- the logic her being if you were to fault on an
invalidated page during IO you deserve to block indefinitely until the
IO completes.

    However, if an application is doing a combination of mmapped and
    direct I/O to a file at the same time, then it should generally
    have some form of user space synchronization anyway.

I hadn't considered that.  I imagined an application doing either but
not both, and the kernel enforcing this.  However, in the case when
you want to mmap a large file, you may want to manipulate some pages
using mmap whilst writing others with O_DIRECT.  Although, in such
cases arguably you could using multiple mapping's.



   --cw
