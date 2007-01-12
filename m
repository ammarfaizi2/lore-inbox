Return-Path: <linux-kernel-owner+w=401wt.eu-S1030261AbXALVDl@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030261AbXALVDl (ORCPT <rfc822;w@1wt.eu>);
	Fri, 12 Jan 2007 16:03:41 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030274AbXALVDl
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 12 Jan 2007 16:03:41 -0500
Received: from hobbit.corpit.ru ([81.13.94.6]:24719 "EHLO hobbit.corpit.ru"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1030261AbXALVDk (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 12 Jan 2007 16:03:40 -0500
Message-ID: <45A7F7A7.1080108@tls.msk.ru>
Date: Sat, 13 Jan 2007 00:03:35 +0300
From: Michael Tokarev <mjt@tls.msk.ru>
Organization: Telecom Service, JSC
User-Agent: Icedove 1.5.0.8 (X11/20061128)
MIME-Version: 1.0
To: Michael Tokarev <mjt@tls.msk.ru>
CC: Chris Mason <chris.mason@oracle.com>, Linus Torvalds <torvalds@osdl.org>,
       dean gaudet <dean@arctic.org>, Viktor <vvp01@inbox.ru>,
       Aubrey <aubreylee@gmail.com>, Hua Zhong <hzhong@gmail.com>,
       Hugh Dickins <hugh@veritas.com>, linux-kernel@vger.kernel.org,
       hch@infradead.org, kenneth.w.chen@intel.com, akpm@osdl.org
Subject: Re: O_DIRECT question
References: <6d6a94c50701101857v2af1e097xde69e592135e54ae@mail.gmail.com> <Pine.LNX.4.64.0701101902270.3594@woody.osdl.org> <45A629E9.70502@inbox.ru> <Pine.LNX.4.64.0701110750520.3594@woody.osdl.org> <Pine.LNX.4.64.0701112351520.18431@twinlark.arctic.org> <Pine.LNX.4.64.0701120955440.3594@woody.osdl.org> <20070112202316.GA28400@think.oraclecorp.com> <45A7F396.4080600@tls.msk.ru> <45A7F4F2.2080903@tls.msk.ru>
In-Reply-To: <45A7F4F2.2080903@tls.msk.ru>
X-Enigmail-Version: 0.94.1.0
OpenPGP: id=4F9CF57E
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Michael Tokarev wrote:
> Michael Tokarev wrote:
> By the way.  I just ran - for fun - a read test of a raid array.
> 
> Reading blocks of size 512kbytes, starting at random places on a 400Gb
> array, doing 64threads.
> 
>  O_DIRECT: 336.73 MB/sec.
> !O_DIRECT: 146.00 MB/sec.

And when turning off read-ahead, the speed dropped to 30 MB/sec.  Read-ahead
should not help here, I think... But after analyzing the "randomness" a bit,
it turned out alot of requests are coming to places "near" the ones which has
been read recently.  After switching to another random number generator,
speed in a case WITH readahead enabled dropped to almost 5Mb/sec ;)

And sure thing, withOUT O_DIRECT, the whole system is almost dead under this
load - because everything is thrown away from the cache, even caches of /bin
/usr/bin etc... ;)  (For that, fadvise() seems to help a bit, but not alot).

(No, really - this load isn't entirely synthetic.  It's a typical database
workload - random I/O all over, on a large file.  If it can, it combines
several I/Os into one, by requesting more than a single block at a time,
but overall it is random.)

/mjt

