Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261747AbVDOOmc@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261747AbVDOOmc (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 15 Apr 2005 10:42:32 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261819AbVDOOmc
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 15 Apr 2005 10:42:32 -0400
Received: from thunk.org ([69.25.196.29]:44498 "EHLO thunker.thunk.org")
	by vger.kernel.org with ESMTP id S261747AbVDOOm2 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 15 Apr 2005 10:42:28 -0400
Date: Fri, 15 Apr 2005 10:42:16 -0400
From: "Theodore Ts'o" <tytso@mit.edu>
To: linux@horizon.com
Cc: jlcooke@certainkey.com, linux-kernel@vger.kernel.org, mpm@selenic.com
Subject: Re: Fortuna
Message-ID: <20050415144216.GA9352@thunk.org>
Mail-Followup-To: Theodore Ts'o <tytso@mit.edu>, linux@horizon.com,
	jlcooke@certainkey.com, linux-kernel@vger.kernel.org,
	mpm@selenic.com
References: <20050414133336.GA16977@thunk.org> <20050415013417.3536.qmail@science.horizon.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20050415013417.3536.qmail@science.horizon.com>
User-Agent: Mutt/1.5.8i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Apr 15, 2005 at 01:34:17AM -0000, linux@horizon.com wrote:
> (Speaking of which, perhaps it's time, in light of the breaking of MD5,
> to revisit the cut-down MD4 routine used in the TCP ISN selection?
> I haven't read the MD5 & SHA1 papers in enough detail to understand the
> flaw, but perhaps some defenses could be erected?)

The ISN selection is there only to make it harder to accomplish TCP
hijacking attacks from people who are on networking path between the
source and destination.  And you have to guess the ISI before the
3-way TCP handshake has been negotiated (or if you can stop the SYN
packet in flight, before the other side times out the attempted TCP
connection); and we also rekey every few minutes, so even if you do
figure out the seed that we are using to generate the ISI (which is
harder than just merely finding a hash collision; find the preimage
that we are using as a seed given the only a portion of the crypto
hash output), it becomes useless and you have to start all over again
within a few minutes.

Furthermore, if you really cared about preventing TCP hijacks, the
only real way to do this is to use Real Crypto.  And these days, Cisco
boxes support Kerberized telnets and ssh connections, which is the
real Right Answer.

It might be possible to use a more expensive crypto primitive here,
since CPU's have gotten so much faster, but the reason why we moved to
MD4, and then cut it down, was because otherwise it was causing a
noticeable difference in the speed we could establish TCP connections,
and hence for certain network-based benchmarks.

> Just to be clear, I don't remember it ever throwing entropy away, but
> it hoards some for years, thereby making it effectively unavailable.
> Any catastrophic reseeding solution has to hold back entropy for some
> time.

It depends on how often you reseed, but my recollection was that it
was far more than years; it was *centuries*.  And as far as I'm
concerned, that's equivalent to throwing it away, especially given the
pathetically small size of the Fortuna pools.

							- Ted
