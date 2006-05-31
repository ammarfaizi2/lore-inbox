Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964874AbWEaIt5@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964874AbWEaIt5 (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 31 May 2006 04:49:57 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964872AbWEaIt5
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 31 May 2006 04:49:57 -0400
Received: from gw.openss7.com ([142.179.199.224]:63212 "EHLO gw.openss7.com")
	by vger.kernel.org with ESMTP id S964871AbWEaIt4 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 31 May 2006 04:49:56 -0400
Date: Wed, 31 May 2006 02:49:54 -0600
From: "Brian F. G. Bidulock" <bidulock@openss7.org>
To: David Miller <davem@davemloft.net>
Cc: draghuram@rocketmail.com, linux-kernel@vger.kernel.org,
       netdev@vger.kernel.org
Subject: Re: Question about tcp hash function tcp_hashfn()
Message-ID: <20060531024954.A2458@openss7.org>
Reply-To: bidulock@openss7.org
Mail-Followup-To: David Miller <davem@davemloft.net>,
	draghuram@rocketmail.com, linux-kernel@vger.kernel.org,
	netdev@vger.kernel.org
References: <20060530235525.A30563@openss7.org> <20060531.001027.60486156.davem@davemloft.net> <20060531014540.A1319@openss7.org> <20060531.004953.91760903.davem@davemloft.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
In-Reply-To: <20060531.004953.91760903.davem@davemloft.net>; from davem@davemloft.net on Wed, May 31, 2006 at 12:49:53AM -0700
Organization: http://www.openss7.org/
Dsn-Notification-To: <bidulock@openss7.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

David,

On Wed, 31 May 2006, David Miller wrote:
> 
> For sure and there are plans afoot to move over to
> dynamic table sizing and the Jenkins hash function.

Just a suggestion, but I have an approach that stands to be
faster than Jenkins deriving from the verification tag approach
that I took for SCTP (OpenSS7 SCTP not lksctp).

TCP uses a cryptographic hash function to select its initial
sequence number (SCTP does the same for vtag).  Last I checked
it was taken from an MD4 swirled entropy pool and further
combined with the local and remote IP addresses and port
numbers.

Each received segment contains a sequence number that is offset
from the initial sequence number but is expected to appear
within the current window.  Most of the high order bits of an
in-window sequence number are predicatable at any point in time
and, due to cryptographic strength, are more efficient than
Jenkins, ... and they are right there in the received packet.

The approach would take the high order bits of the received
sequence number and use them to index a separate sequence number
keyed established hash (which could be dynamic). As the window
changes, the socket would have to be removed and reinserted into
this hash, but the repositioning would be infrequent.  Out of
window segments would fail to find a socket, but could fall back
to the current established hash, or even the bind hash.  A layer
of caching could increase the hash lookup speed further for
noisy senders.

This would be faster than a Jenkins hash approach because it
would not be necessary to calculate the hash function at all for
in-window segments.  Per packet overheads would decrease and
better small packet performance would be experienced (i.e. your
http server).  It has better hash coverage because MD4 and other
cryptographic algorithms used for initial sequence number
selection have far better properties than Jenkins.

What do you think?

