Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S273385AbRJDLBs>; Thu, 4 Oct 2001 07:01:48 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S273463AbRJDLBh>; Thu, 4 Oct 2001 07:01:37 -0400
Received: from chunnel.redhat.com ([199.183.24.220]:34299 "EHLO
	sisko.scot.redhat.com") by vger.kernel.org with ESMTP
	id <S273385AbRJDLBe>; Thu, 4 Oct 2001 07:01:34 -0400
Date: Thu, 4 Oct 2001 12:02:00 +0100
From: "Stephen C. Tweedie" <sct@redhat.com>
To: Pascal Schmidt <pleasure.and.pain@web.de>
Cc: "Stephen C. Tweedie" <sct@redhat.com>, linux-kernel@vger.kernel.org
Subject: Re: ReiserFS data corruption in very simple configuration
Message-ID: <20011004120200.B2226@redhat.com>
In-Reply-To: <20011003171703.B5209@redhat.com> <Pine.LNX.4.33.0110032202560.26021-100000@neptune.sol.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <Pine.LNX.4.33.0110032202560.26021-100000@neptune.sol.net>; from pleasure.and.pain@web.de on Wed, Oct 03, 2001 at 10:06:58PM +0200
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On Wed, Oct 03, 2001 at 10:06:58PM +0200, Pascal Schmidt wrote:
> On Wed, 3 Oct 2001, Stephen C. Tweedie wrote:
> 
> > ext3 with ordered data writes has performance nearly up to the level
> > of the fast-and-loose writeback mode for most workloads, and still
> > avoids ever exposing stale disk blocks after a crash.
> What if the machine crashes with parts of the data blocks written to
> disk, before the commit block gets submitted to the drive?

In most cases, users write data by extending off the end of a file.
Only in a few cases (such as databases) do you ever write into the
middle of an existing file.  Even overwriting an existing file is done
by first truncating the file and then extending it again.

If you crash during such an extend, then the data blocks may have been
partially written, but the extend will not have been, so the
incompletely-written data blocks will not be part of any file.

The *only* way to get mis-ordered data blocks in ordered mode after a
crash is if you are overwriting in the middle of an existing file.  In
such a case there is no absolute guarantee about write ordering unless
you use fsync() or O_SYNC to force writes in a particular order.  

In journaled data mode, even mid-file overwrites will be strictly
ordered after a crash.

Cheers,
 Stephen
