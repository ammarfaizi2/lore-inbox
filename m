Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S317251AbSHHAUu>; Wed, 7 Aug 2002 20:20:50 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S317253AbSHHAUu>; Wed, 7 Aug 2002 20:20:50 -0400
Received: from kweetal.tue.nl ([131.155.2.7]:20999 "EHLO kweetal.tue.nl")
	by vger.kernel.org with ESMTP id <S317251AbSHHAUt>;
	Wed, 7 Aug 2002 20:20:49 -0400
Date: Thu, 8 Aug 2002 02:24:19 +0200
From: Andries Brouwer <aebr@win.tue.nl>
To: Andrew Morton <akpm@zip.com.au>
Cc: Paul Larson <plars@austin.ibm.com>,
       Linus Torvalds <torvalds@transmeta.com>,
       lkml <linux-kernel@vger.kernel.org>, davej@suse.de, frankeh@us.ibm.com,
       andrea@suse.de
Subject: Re: [PATCH] Linux-2.5 fix/improve get_pid()
Message-ID: <20020808002419.GA528@win.tue.nl>
References: <1028757835.22405.300.camel@plars.austin.ibm.com> <3D51A7DD.A4F7C5E4@zip.com.au>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <3D51A7DD.A4F7C5E4@zip.com.au>
User-Agent: Mutt/1.3.25i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Aug 07, 2002 at 04:06:05PM -0700, Andrew Morton wrote:

> Has this been evaluated against Bill Irwin's constant-time
> allocator?  Bill says it has slightly worse normal-case and
> vastly improved worst-case performance over the stock allocator.
> Not sure how it stacks up against this one.   Plus it's much nicer
> looking code.

> #define PID_MAX		0x8000
> #define RESERVED_PIDS	300
> 
> #define MAP0_SIZE	(PID_MAX   >> BITS_PER_LONG_SHIFT)
> #define MAP1_SIZE	(MAP0_SIZE >> BITS_PER_LONG_SHIFT)
> #define MAP2_SIZE	(MAP1_SIZE >> BITS_PER_LONG_SHIFT)
> 
> static unsigned long pid_map0[MAP0_SIZE];
> static unsigned long pid_map1[MAP1_SIZE];
> static unsigned long pid_map2[MAP2_SIZE];

Here it is of interest how large a pid is.
With a 64-bit pid_t it is just

  static pid_t last_pid;

  pid_t get_next_pid() {
	return ++last_pid;
  }

since 2^64 is a really large number.
Unfortunately glibc does not support this (on x86).

With a 32-bit pid_t wraparounds will occur, but very infrequently.
Thus, finding the next pid will be very fast on average, much faster
than the above algorithm, and no arrays are required.
One only loses the guaranteed constant time property.
Unless hard real time is required, this sounds like the best version.

Andries
