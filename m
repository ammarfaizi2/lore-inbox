Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S315821AbSEJHMT>; Fri, 10 May 2002 03:12:19 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S315823AbSEJHMS>; Fri, 10 May 2002 03:12:18 -0400
Received: from parcelfarce.linux.theplanet.co.uk ([195.92.249.252]:19978 "EHLO
	www.linux.org.uk") by vger.kernel.org with ESMTP id <S315821AbSEJHMS>;
	Fri, 10 May 2002 03:12:18 -0400
Message-ID: <3CDB7387.F309D519@zip.com.au>
Date: Fri, 10 May 2002 00:15:19 -0700
From: Andrew Morton <akpm@zip.com.au>
X-Mailer: Mozilla 4.79 [en] (X11; U; Linux 2.4.19-pre4 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: Lincoln Dale <ltd@cisco.com>
CC: Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: O_DIRECT performance impact on 2.4.18 (was: Re: [PATCH] 2.5.14IDE 
 56)
In-Reply-To: <3CDAC4EB.FC4FE5CF@zip.com.au> <5.1.0.14.2.20020510155122.02d97910@mira-sjcm-3.cisco.com>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Lincoln Dale wrote:
> 
> At 11:50 AM 9/05/2002 -0700, Andrew Morton wrote:
> > >          /dev/md0 raid-0 with O_DIRECT:          91847kbyte/sec (2781usec
> > >          /dev/md0
> > raid-0:                                129455kbyte/sec (1978usec
> > >          /dev/md0 raid-0 with O_NOCOPY:  195868kbyte/sec (1297usec
> >
> >hmm.  Why is O_DIRECT always the slowest?  (and it would presumably do
> >even worse with an 8k transfer size).
> 
> i just reproduced the test to validate the data.  i'm using 8kbyte blocks here.
> on kernel is 2.4.18, O_DIRECT is still the slowest.

8k would rather disadvantage O_DIRECT.  It can't do readahead and it
can't to write-behind.  It'll be forced to do tons of tiny I/Os.

> ...
> 
> the biggest difference here is bounce_end_io_read in O_DIRECT.

Well hopefully that will be gone in 2.4.20, for many popular 
controllers.

Not sure why it bit you here.  It could be that the page allocator
just happened to give you highmem pages for the O_DIRECT test. 
Turning off highmem may make the test more repeatable.

> given there's still lots of idle-time, i'll file up lockmeter on here and
> see if theres any gremlins there.

lockmeter will go off the dial.  All those copies happen at
interrupt time, inside the global io_request_lock.  It's horrid.

Try it with the block-highmem patch:
 http://www.kernel.org/pub/linux/kernel/people/andrea/kernels/v2.4/2.4.19pre1aa1/00_block-highmem-all-18b-4.gz

-
