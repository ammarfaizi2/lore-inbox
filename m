Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S264829AbRGCQOE>; Tue, 3 Jul 2001 12:14:04 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S264827AbRGCQNy>; Tue, 3 Jul 2001 12:13:54 -0400
Received: from nat-pool-meridian.redhat.com ([199.183.24.200]:38398 "EHLO
	devserv.devel.redhat.com") by vger.kernel.org with ESMTP
	id <S264816AbRGCQNp>; Tue, 3 Jul 2001 12:13:45 -0400
Date: Tue, 3 Jul 2001 16:48:33 +0100
From: "Stephen C. Tweedie" <sct@redhat.com>
To: Daryll Strauss <daryll@valinux.com>
Cc: "Stephen C. Tweedie" <sct@redhat.com>, Dan Kegel <dank@kegel.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: O_DIRECT please; Sybase 12.5
Message-ID: <20010703164833.F28793@redhat.com>
In-Reply-To: <3B3C4CB4.6B3D2B2F@kegel.com> <20010703104253.B29868@redhat.com> <20010703081039.C3942@newbie>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <20010703081039.C3942@newbie>; from daryll@valinux.com on Tue, Jul 03, 2001 at 08:10:39AM -0700
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On Tue, Jul 03, 2001 at 08:10:39AM -0700, Daryll Strauss wrote:

> I recall hearing about a problem with the md device and raw IO. It was
> something about the block sizes not matching causing performance
> problems. Has anything been done to improve those issues?

The problem is a combination of two things.  First, raw IO is always
fully synchronous, so with raw IO (and O_DIRECT) you are, in effect,
explicitly instructing the kernel not to do any readahead.  That makes
it hard to keep two disks running in parallel with soft raid if you
are using small IOs, obviously.

Secondly, raw IO pins buffers in physical memory, and to avoid
causing serious VM problems due to having too much unswappable memory
pinned by arbitrary applications, the current raw IO driver limits the
pinned chunk size to 64k.  That, combined with the sequential nature
of raw IO, can limit performance, certainly.

Raw IO is quite capable of running with larger chunk sizes, but we
really need a kernel limiter of some description to prevent users from
using this mechanism to pin massive amounts of memory for raw IO at
once.  There are several candidate mechanisms for that, but none in
the main kernel right now.

Cheers,
 Stephen
