Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S315540AbSFCVKj>; Mon, 3 Jun 2002 17:10:39 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S315546AbSFCVKi>; Mon, 3 Jun 2002 17:10:38 -0400
Received: from parcelfarce.linux.theplanet.co.uk ([195.92.249.252]:36881 "EHLO
	www.linux.org.uk") by vger.kernel.org with ESMTP id <S315540AbSFCVKh>;
	Mon, 3 Jun 2002 17:10:37 -0400
Message-ID: <3CFBDAF7.6E9398D4@zip.com.au>
Date: Mon, 03 Jun 2002 14:09:11 -0700
From: Andrew Morton <akpm@zip.com.au>
X-Mailer: Mozilla 4.79 [en] (X11; U; Linux 2.5.1-pre8 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: Robert Love <rml@tech9.net>
CC: Mike Kravetz <kravetz@us.ibm.com>, Andi Kleen <ak@muc.de>,
        linux-kernel@vger.kernel.org, icollinson@imerge.co.uk, andrea@suse.de
Subject: Re: realtime scheduling problems with 2.4 linux kernel >= 2.4.10
In-Reply-To: <3CFBCCB1.A8F7D16B@zip.com.au> <1023135208.963.365.camel@sinai>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Robert Love wrote:
> 
> On Mon, 2002-06-03 at 13:08, Andrew Morton wrote:
> 
> > keventd is a "process context bottom half handler".  It's designed
> > for use by interrupt handlers for handing off awkward, occasional
> > things which need process context.  For example, device hotplugging,
> > which was the original reason for its introduction.
> >
> > So it makes sense to give keventd SCHED_RR policy and maximum
> > priority.  Which should fix this problem as well, yes?
> 
> Next to ditching keventd, this is probably the best thing we can do.

I think the design is OK.  It's for "misc stuff".  There's only
a single instance, it's only lightly used.

> I wonder how much code _really_ needs it - that is, what really needs to
> be running in process-context?

Pretty much every use of keventd make sense as-is, IMO.

>  Obviously device hotplug probably does.
> But for things like that, what about spawning (temporarily) a kernel
> thread?

We need process context for starting a thread...

It's just an 8k stack.  I believe that keventd is OK, as
long as people don't go nuts when using it.   It may make
some sense to overload ksoftirqd to provide keventd functionality.
Except ksoftirqd runs at super-low priority, which is exactly
what keventd doesn't want.

-
