Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750916AbWEGFEZ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750916AbWEGFEZ (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 7 May 2006 01:04:25 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751024AbWEGFEZ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 7 May 2006 01:04:25 -0400
Received: from waste.org ([64.81.244.121]:17618 "EHLO waste.org")
	by vger.kernel.org with ESMTP id S1750916AbWEGFEY (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 7 May 2006 01:04:24 -0400
Date: Sat, 6 May 2006 23:59:20 -0500
From: Matt Mackall <mpm@selenic.com>
To: "David S. Miller" <davem@davemloft.net>
Cc: tytso@mit.edu, mrmacman_g4@mac.com, akpm@osdl.org,
       linux-kernel@vger.kernel.org
Subject: Re: [PATCH 7/14] random: Remove SA_SAMPLE_RANDOM from network drivers
Message-ID: <20060507045920.GH15445@waste.org>
References: <20060505203436.GW15445@waste.org> <20060506115502.GB18880@thunk.org> <20060506164808.GY15445@waste.org> <20060506.170810.74552888.davem@davemloft.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20060506.170810.74552888.davem@davemloft.net>
User-Agent: Mutt/1.5.9i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, May 06, 2006 at 05:08:10PM -0700, David S. Miller wrote:
> From: Matt Mackall <mpm@selenic.com>
> Date: Sat, 6 May 2006 11:48:08 -0500
> 
> > But network traffic should be _assumed_ to be observable to some
> > degree.
> 
> Please put together a test case that proves that /dev/random can
> be predicted just by being on the wire sniffing packets going into
> the machine.  Then you will have my full support.

Sure.

First, since the existence of /dev/random's entropy accounting scheme
is predicated on the assumption that we can break the hash function at
will, I'll replace SHA1 with, oh, say, CRC-16. This'll be illustrative
until someone has a nice preimage attack against SHA1.

Then I'll run my test on one of the various arches where HZ=~100 and
we don't have a TSC. Like Sparc?

  /* XXX Maybe do something better at some point... -DaveM */
  typedef unsigned long cycles_t;
  #define get_cycles()    (0)
 
Now all the inputs are easily predictable from anywhere with <10ms
ping, with the occassional need to guess between a pair of timer
ticks. And since I can calculate preimages of CRC-16, I can now deduce
the state of the pool if I can watch some subset of its output, say
https session keys I request. And then I can start guessing future
outputs and breaking into other people's https sessions.

The point of /dev/random is to -survive- SHA1 being broken by never
giving out more secrets than we take in. That doesn't work if we give
it observable inputs and claim they're not observable, which is what
you're doing by setting SA_SAMPLE_RANDOM.

-- 
Mathematics is the supreme nostalgia of our time.
