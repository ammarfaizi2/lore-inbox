Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262517AbRENVqw>; Mon, 14 May 2001 17:46:52 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262513AbRENVqm>; Mon, 14 May 2001 17:46:42 -0400
Received: from ns.suse.de ([213.95.15.193]:43020 "HELO Cantor.suse.de")
	by vger.kernel.org with SMTP id <S262522AbRENVqb>;
	Mon, 14 May 2001 17:46:31 -0400
Date: Mon, 14 May 2001 23:46:04 +0200
From: Andi Kleen <ak@suse.de>
To: Samuel Meder <meder@mcs.anl.gov>
Cc: linux-kernel@vger.kernel.org
Subject: Re: TCP capture effect (was Re: Linux TCP impotency)
Message-ID: <20010514234604.A4694@gruyere.muc.suse.de>
In-Reply-To: <20010514161509.B3192@titan.mcs.anl.gov>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <20010514161509.B3192@titan.mcs.anl.gov>; from meder@mcs.anl.gov on Mon, May 14, 2001 at 04:15:12PM -0500
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, May 14, 2001 at 04:15:12PM -0500, Samuel Meder wrote:
> I'm seeing a similar effect myself. When I use all my available sdsl
> bandwidth (say doing a bulk data transfer), DNS lookups will often
> time out. This is with the default buffer settings/2.4.4. 

The problem is that the DNS resolver in glibc has a too low setting
for retransmits before giving up (4-5 or so only, it's also a big problem
together with dynamic IP and dial-on-demand where the socket address rewriting
needs some time) Fix is to change glibc to retransmit more often and 
recompile it or alternatively use a local dns proxy that does more aggressive
retransmits (that won't fix the low timeout though)

> I'm curious about this effect so I've been trying to find information
> on this and while I can find lots of information on the Ethernet
> capture effect there doesn't seem to be anything on the TCP capture
> effect. Could someone point me at an explanation of this effect?

I also don't know that term, but the basic problem is that TCP only slows
down when its packets are dropped. Packets are dropped when a device queue
fills, and when one sender is much faster than the other the faster sender
often wins the race, while the packets of the slower one get dropped.
[this is a rough simplification; there have been many books and papers
written on queueing in the internet]

One problem is for example that Linux's default queue length is good
for ethernet, but not slower or higher latency links.
You can try to tune it using ifconfig device txqueuelen <number>. 
Try values between 5-30, default is 100.

DSL also has very asymetric bandwidth, if you're saturating e.g. the uplink
channel completely acks in the other direction will also have a hard
time to get through.

-Andi

