Return-Path: <linux-kernel-owner+willy=40w.ods.org-S267363AbUHJAaS@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S267363AbUHJAaS (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 9 Aug 2004 20:30:18 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267361AbUHJAaS
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 9 Aug 2004 20:30:18 -0400
Received: from thunk.org ([140.239.227.29]:51923 "EHLO thunker.thunk.org")
	by vger.kernel.org with ESMTP id S267378AbUHJA36 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 9 Aug 2004 20:29:58 -0400
Date: Mon, 9 Aug 2004 20:22:55 -0400
From: "Theodore Ts'o" <tytso@mit.edu>
To: Jean-Luc Cooke <jlcooke@certainkey.com>
Cc: James Morris <jmorris@redhat.com>,
       "YOSHIFUJI Hideaki / ?$B5HF#1QL@" <yoshfuji@linux-ipv6.org>,
       mludvig@suse.cz, cryptoapi@lists.logix.cz, linux-kernel@vger.kernel.org,
       davem@redhat.com
Subject: Re: [PATCH]
Message-ID: <20040810002255.GA3556@thunk.org>
Mail-Followup-To: Theodore Ts'o <tytso@mit.edu>,
	Jean-Luc Cooke <jlcooke@certainkey.com>,
	James Morris <jmorris@redhat.com>,
	"YOSHIFUJI Hideaki / ?$B5HF#1QL@" <yoshfuji@linux-ipv6.org>,
	mludvig@suse.cz, cryptoapi@lists.logix.cz,
	linux-kernel@vger.kernel.org, davem@redhat.com
References: <20040806042852.GD23994@certainkey.com> <Xine.LNX.4.44.0408060040360.20834-100000@dhcp83-76.boston.redhat.com> <20040806125427.GE23994@certainkey.com> <20040807222634.GA15806@thunk.org> <20040808153846.GR23994@certainkey.com> <20040809184324.GA22741@thunk.org> <20040809184951.GH2192@certainkey.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20040809184951.GH2192@certainkey.com>
User-Agent: Mutt/1.5.6+20040523i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Aug 09, 2004 at 02:49:51PM -0400, Jean-Luc Cooke wrote:
> The only parts we're proposing to replace are:
>  - TCP sequence number generation (AES in CTR mode truncated to 32 bits, has
>    period of 2^32 and cannot be easily determined from pervious sequences)
>    I will read your reference and learn from the implementation in random.c

Nope, that's not sufficient.  There's a reason why we're doing what
we're doing in random.c.  To quote from RFC 1948:

   The choice of initial sequence numbers for a connection is not
   random.  Rather, it must be chosen so as to minimize the probability
   of old stale packets being accepted by new incarnations of the same
   connection [6, Appendix A].  Furthermore, implementations of TCP
   derived from 4.2BSD contain special code to deal with such
   reincarnations when the server end of the original connection is
   still in TIMEWAIT state [7, pp. 945].  Accordingly, SIMPLE
   RANDOMIZATION, AS SUGGESTED IN [8], WILL NOT WORK WELL.

The F() as defined in RFC 1948, needs to be a crypto hash.  But it
doesn't need to be a particularly strong hash.  If it takes longer for
the attacker to break the hash than our rekey interval, that's
sufficient, since what we're protecting any kind of secrecy of the
data; we just need to prevent the attacker from guessing the initial
sequence number just long enough so that he can't hijack a TCP
connection.  Hence the use of a cut-down MD4.  It's kludgy, yeah, and
it smells of roll-your-own-crypto, granted, but I emphasize again that
(a) this was never considered very high protection; if you really care
about protecting against these sorts of attacks, you will be using
application-level crypto (i.e., ssh'ing to a Cisco box instead of
using an unencrypted telnet connection), and (b) using real crypto is
too slow, and was affecting Linux in various network benchmarks.
That's why it was changed from the original MD5 as suggested by
Bellovin in RFC 1948, to a cut-down MD4.  

And we ***never*** were insane enough to use SHA, or suggest that the
use of SHA was a good idea in this particular application.  I don't
know why some people had the assumption that SHA was ever used in TCP
sequence number generation, but they were wrong; that was never the
case.

						- Ted

