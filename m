Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S271610AbRHZWdw>; Sun, 26 Aug 2001 18:33:52 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S271560AbRHZWdn>; Sun, 26 Aug 2001 18:33:43 -0400
Received: from smtp.mailbox.net.uk ([195.82.125.32]:19175 "EHLO
	smtp.mailbox.net.uk") by vger.kernel.org with ESMTP
	id <S271609AbRHZWda>; Sun, 26 Aug 2001 18:33:30 -0400
Date: Sun, 26 Aug 2001 23:33:43 +0100
From: Russell King <rmk@arm.linux.org.uk>
To: Daniel Phillips <phillips@bonn-fries.net>
Cc: Rik van Riel <riel@conectiva.com.br>, pcg@goof.com,
        Roger Larsson <roger.larsson@skelleftea.mail.telia.com>,
        linux-kernel@vger.kernel.org
Subject: Re: [resent PATCH] Re: very slow parallel read performance
Message-ID: <20010826233343.A6193@flint.arm.linux.org.uk>
In-Reply-To: <Pine.LNX.4.33L.0108261651080.5646-100000@imladris.rielhome.conectiva> <20010826200133Z16190-32385+242@humbolt.nl.linux.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <20010826200133Z16190-32385+242@humbolt.nl.linux.org>; from phillips@bonn-fries.net on Sun, Aug 26, 2001 at 10:08:07PM +0200
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Aug 26, 2001 at 10:08:07PM +0200, Daniel Phillips wrote:
> No, he's streaming mp3's:

I'd like to take the time to share some extra information on the VM
state of Nico's system.  It consists of a log of the state of every
single page in his system, which was taken after he hit the point of
no progress, and consists of the following output:

<sysrq-m output>
Zone: free 255, inactive clean 26, inactive dirty 0
      min 255, low 510, high 765
<lots of pages>
c04fd000:  0 00000002 00000000 [----] -- [---]
c04fe000:  1 00000002 00000000 [--s-] -- [---]
c04ff000:  1 00000000 c180f0f8 [----] -- [-c-]
c0500000:  1 00000002 00000000 [--s-] -- [---]
c0501000:  1 00000005 00000000 [----] -- [---]
c0502000:  1 00000002 00000000 [--s-] -- [---]
<lots of pages>
c05af000:  1 00000005 00000000 [----] -- [---]
c05b0000:  1 00000005 00000000 [----] -- [---]
c05b1000:  1 00000005 00000000 [----] -- [---]
c05b2000:  1 00000011 00000000 [----] -- [---]
c05b3000:  1 00000005 00000000 [----] -- [---]
c05b4000:  1 00000008 00000000 [----] -- [---]
<lots of pages>

In order, that is:
  virtual page address
  page->count
  paeg->age
  page->mapping

Then 4 flags:
  R - reserved
  S - swap cache
  s - slab page
  r - (not really a flag) ramdisk page

Then 2 flags:
  r - referenced
  D - dirty

Then 3 list flags:
  a - active list
  d - inactive dirty list
  c - inactive clean list

It's a little big (380K), so I won't post it here, but I'll provide a
summary of the state:

Of the 8192 pages in his system, there are 4687 anonymous pages like the
above, 466 slab pages, 636 reserved pages, 376 unused pages (for reserved
allocation) and 2000 ramdisk pages.  That leaves 27 pages, which are the
26 inactive clean pages (from the above), plus one page cache page.

Feel free to use this information to formulate new strategies on improving
the VM.

[note that it takes around 1 minute to get 32MB-worth of information out
of a serial console at 38400 baud.  You don't want to do this on GB boxes].

Thanks.

--
Russell King (rmk@arm.linux.org.uk)                The developer of ARM Linux
             http://www.arm.linux.org.uk/personal/aboutme.html

