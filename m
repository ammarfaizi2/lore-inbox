Return-Path: <linux-kernel-owner+w=401wt.eu-S1751195AbXANJLN@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751195AbXANJLN (ORCPT <rfc822;w@1wt.eu>);
	Sun, 14 Jan 2007 04:11:13 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751177AbXANJLN
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 14 Jan 2007 04:11:13 -0500
Received: from nf-out-0910.google.com ([64.233.182.187]:15151 "EHLO
	nf-out-0910.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751195AbXANJLK (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 14 Jan 2007 04:11:10 -0500
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=beta;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=bOhiGbjNjc5Boo/6hQSU9+L9bsWViKWyuV6lhUs4dl1TCje7iQN3ZJCc1Sgbee7Wgav6d2yShI+jUP/W/mJ2XZIZej/seUbxSQKC7wxt/RvNtUv7PCqA6agpScOnVprR/M3aqCBhY/mgMOt5r8IfqbT6QxOOeGud2sf5U7FcPYA=
Message-ID: <5c49b0ed0701140111p6fd2d60at7ec246738b887a73@mail.gmail.com>
Date: Sun, 14 Jan 2007 01:11:08 -0800
From: "Nate Diller" <nate.diller@gmail.com>
To: "Andrew Morton" <akpm@osdl.org>
Subject: Re: O_DIRECT question
Cc: andersen@codepoet.org, "Linus Torvalds" <torvalds@osdl.org>,
       "Michael Tokarev" <mjt@tls.msk.ru>,
       "Chris Mason" <chris.mason@oracle.com>, "dean gaudet" <dean@arctic.org>,
       Viktor <vvp01@inbox.ru>, Aubrey <aubreylee@gmail.com>,
       "Hua Zhong" <hzhong@gmail.com>, "Hugh Dickins" <hugh@veritas.com>,
       linux-kernel@vger.kernel.org, hch@infradead.org,
       kenneth.w.chen@intel.com
In-Reply-To: <20070112144748.6c4bb19e.akpm@osdl.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
References: <Pine.LNX.4.64.0701110750520.3594@woody.osdl.org>
	 <20070112202316.GA28400@think.oraclecorp.com>
	 <45A7F396.4080600@tls.msk.ru> <45A7F4F2.2080903@tls.msk.ru>
	 <45A7F7A7.1080108@tls.msk.ru>
	 <Pine.LNX.4.64.0701121611370.3470@woody.osdl.org>
	 <45A8038F.2040609@tls.msk.ru>
	 <Pine.LNX.4.64.0701121705440.3470@woody.osdl.org>
	 <20070112223509.GA12512@codepoet.org>
	 <20070112144748.6c4bb19e.akpm@osdl.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 1/12/07, Andrew Morton <akpm@osdl.org> wrote:
> On Fri, 12 Jan 2007 15:35:09 -0700
> Erik Andersen <andersen@codepoet.org> wrote:
>
> > On Fri Jan 12, 2007 at 05:09:09PM -0500, Linus Torvalds wrote:
> > > I suspect a lot of people actually have other reasons to avoid caches.
> > >
> > > For example, the reason to do O_DIRECT may well not be that you want to
> > > avoid caching per se, but simply because you want to limit page cache
> > > activity. In which case O_DIRECT "works", but it's really the wrong thing
> > > to do. We could export other ways to do what people ACTUALLY want, that
> > > doesn't have the downsides.
> >
> > I was rather fond of the old O_STREAMING patch by Robert Love,
>
> That was an akpmpatch whcih I did for the Digeo kernel.  Robert picked it
> up to dehackify it and get it into mainline, but we ended up deciding that
> posix_fadvise() was the way to go because it's standards-based.
>
> It's a bit more work in the app to use posix_fadvise() well.  But the
> results will be better.  The app should also use sync_file_range()
> intelligently to control its pagecache use.

and there's an interesting note that i should add here, cause there's
a downside to using fadvise() instead of O_STREAM when the programmer
is not careful.  I spent at least a month doing some complex blktrace
analysis to try to figure out why Digeo's new platform (which used the
fadvise() call) didn't have the kind of streaming performance that it
should have.  One symptom I found was that even on the media partition
where I/O should have always been happening in nice 512K chunks
(ra_pages == 128), it seemed to be happening in random values between
32K and 512K.  It turns out that the code pulls in some size chunk,
maybe 32K, then does an fadvise DONTNEED on the fd, *with zero offset
and zero length*, meaning that it wipes out *all* the pagecache for
the file.  That means that the rest of the 512K from the readahead
would get discarded before it got used, and later the remaining pages
in the ra window would get faulted in again.

Most applications don't get the kind of performance analysis that
Digeo was doing, and even then, it's rather lucky that we caught that.
 So I personally think it'd be best for libc or something to simulate
the O_STREAM behavior if you ask for it.  That would simplify things
for the most common case, and have the side benefit of reducing the
amount of extra code an application would need in order to take
advantage of that feature.

NATE
