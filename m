Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S285173AbRLFRFV>; Thu, 6 Dec 2001 12:05:21 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S285176AbRLFRFL>; Thu, 6 Dec 2001 12:05:11 -0500
Received: from neon-gw-l3.transmeta.com ([63.209.4.196]:39182 "EHLO
	neon-gw.transmeta.com") by vger.kernel.org with ESMTP
	id <S285173AbRLFRE5>; Thu, 6 Dec 2001 12:04:57 -0500
To: linux-kernel@vger.kernel.org
From: torvalds@transmeta.com (Linus Torvalds)
Subject: Re: Linux/Pro  -- clusters
Date: Thu, 6 Dec 2001 16:58:34 +0000 (UTC)
Organization: Transmeta Corporation
Message-ID: <9uo83q$aa7$1@penguin.transmeta.com>
In-Reply-To: <9um58i$9no$1@penguin.transmeta.com> <E16BlnL-00080m-00@the-village.bc.nu>
X-Trace: palladium.transmeta.com 1007658287 10402 127.0.0.1 (6 Dec 2001 17:04:47 GMT)
X-Complaints-To: news@transmeta.com
NNTP-Posting-Date: 6 Dec 2001 17:04:47 GMT
Cache-Post-Path: palladium.transmeta.com!unknown@penguin.transmeta.com
X-Cache: nntpcache 2.4.0b5 (see http://www.nntpcache.org/)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

In article <E16BlnL-00080m-00@the-village.bc.nu>,
Alan Cox  <alan@lxorguk.ukuu.org.uk> wrote:
>
>You still need the scsi code. There are a whole sequence of common, quite
>complex and generic functions that the scsi layer handles (in paticular
>error handling).

Well, the preliminary patches already handle _some_ common things, like
building the proper command request for reads and writes etc, and that
will probably continue.  We'll probably have to have all the old helpers
for things like "this target only wants to be probed on lun 0" etc.

I disagree about the error handling, though.

Traditionally, the timeouts and the reset handling was handled in the
SCSI mid-layer, and it was a complete and utter disaster.  Different
hosts simply wanted so different behaviour that it's not even funny.
Timeouts for different commands were so different that people ended up
making most timeouts so long that they no longer made sense for other
commands etc.

Other device drivers have been able to handle timeouts and errors on
their own before, and have _not_ had the kinds of horrendous problems
that the SCSI layer has had.

We'll see what the details will end up being, but I personally think
that it is a major mistake to try to have generic error handling.  The
only true generic thing is "this request finished successfully / with an
error", and _no_ high-level retries etc. It's up to the driver to decide
if retries make sense.

(Often retrying _doesn't_ make sense, because the firmware on the
high-end card or disk itself may already have done retries on its own,
and high-level error handling is nothing but a waste of time and causes
the error notification to be even more delayed).

		Linus
