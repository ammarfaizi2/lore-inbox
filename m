Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S313139AbSDTTCp>; Sat, 20 Apr 2002 15:02:45 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S313163AbSDTTCo>; Sat, 20 Apr 2002 15:02:44 -0400
Received: from nacho.alt.net ([207.14.113.18]:48652 "HELO nacho.alt.net")
	by vger.kernel.org with SMTP id <S313139AbSDTTCo>;
	Sat, 20 Apr 2002 15:02:44 -0400
Date: Sat, 20 Apr 2002 12:02:43 -0700 (PDT)
From: Chris Caputo <ccaputo@alt.net>
To: Ben Greear <greearb@candelatech.com>
cc: linux-kernel@vger.kernel.org
Subject: Re: unresolved symbol: __udivdi3
In-Reply-To: <3CC0A95A.2070000@candelatech.com>
Message-ID: <Pine.LNX.4.44.0204201144510.4529-100000@nacho.alt.net>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 19 Apr 2002, Ben Greear wrote:
> Also, for what it's worth, do_div on x86 seems to corrupt arguments
> given to it, and may do other screwy things.  I'm just going to
> go back to casting and let user-space do any precise division.

Or consider the code from:

 http://nemesis.sourceforge.net/browse/lib/static/intmath/ix86/intmath.c.html

Adapted as follows...

Chris

---

#define DIV 0
#define REM 1

// Function copied/adapted/optimized from:
//
//  nemesis.sourceforge.net/browse/lib/static/intmath/ix86/intmath.c.html
//
// Copyright 1994, University of Cambridge Computer Laboratory
// All Rights Reserved.
//
// TODO: When running on a 64-bit CPU platform, this should no longer be
// TODO: necessary.
//
s64 divremdi3(s64 x,
              s64 y,
              int type)
{
  u64 a = (x < 0) ? -x : x;
  u64 b = (y < 0) ? -y : y;
  u64 res = 0, d = 1;

  if (b > 0) while (b < a) b <<= 1, d <<= 1;

  do
    {
      if ( a >= b ) a -= b, res += d;
      b >>= 1;
      d >>= 1;
    }
  while (d);

  if (DIV == type)
    {
      return (((x ^ y) & (1ll<<63)) == 0) ? res : -(s64)res;
    }
  else
    {
      return ((x & (1ll<<63)) == 0) ? a : -(s64)a;
    }
}

