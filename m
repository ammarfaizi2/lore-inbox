Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S278427AbRJMW1r>; Sat, 13 Oct 2001 18:27:47 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S278429AbRJMW1i>; Sat, 13 Oct 2001 18:27:38 -0400
Received: from neon-gw-l3.transmeta.com ([63.209.4.196]:61967 "EHLO
	neon-gw.transmeta.com") by vger.kernel.org with ESMTP
	id <S278427AbRJMW13>; Sat, 13 Oct 2001 18:27:29 -0400
To: linux-kernel@vger.kernel.org
From: torvalds@transmeta.com (Linus Torvalds)
Subject: Re: Security question: "Text file busy" overwriting executables but
 not shared libraries?
Date: Sat, 13 Oct 2001 22:27:30 +0000 (UTC)
Organization: Transmeta Corporation
Message-ID: <9qaf4i$8qa$1@penguin.transmeta.com>
In-Reply-To: <20011013205445.A24854@kushida.jlokier.co.uk> <Pine.LNX.4.33.0110131219520.8900-100000@penguin.transmeta.com>
X-Trace: palladium.transmeta.com 1003012058 26376 127.0.0.1 (13 Oct 2001 22:27:38 GMT)
X-Complaints-To: news@transmeta.com
NNTP-Posting-Date: 13 Oct 2001 22:27:38 GMT
Cache-Post-Path: palladium.transmeta.com!unknown@penguin.transmeta.com
X-Cache: nntpcache 2.4.0b5 (see http://www.nntpcache.org/)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

In article <Pine.LNX.4.33.0110131219520.8900-100000@penguin.transmeta.com>,
Linus Torvalds  <torvalds@transmeta.com> wrote:
>
>The explicit flag is probably a good idea also because of usage patterns
>(PAGE_COPY is a slowdown _if_ the file is actually written to or even
>mapped shared).

Actually, I missed the obvious case: quite often when you do a "read()",
the reader itself will end up writing to the area read into.  In which
case doing the PAGE_COPY would also slow down measurably, due to the
extra overhead of the copy-on-write fault (which not just does the copy
that we tried to avoid, but will take a fault and more VM locks). 

So if we want to do this optimization, we _definitely_ want it to be
explicitly controlled by a flag, like O_DIRECT is.  There are just too
many cases where it's a pessimization, and while the user can often tell
before-hand, the kernel simply cannot. 

		Linus
