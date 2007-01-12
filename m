Return-Path: <linux-kernel-owner+w=401wt.eu-S1030256AbXALUqW@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030256AbXALUqW (ORCPT <rfc822;w@1wt.eu>);
	Fri, 12 Jan 2007 15:46:22 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030324AbXALUqW
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 12 Jan 2007 15:46:22 -0500
Received: from hobbit.corpit.ru ([81.13.94.6]:23748 "EHLO hobbit.corpit.ru"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1030256AbXALUqU (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 12 Jan 2007 15:46:20 -0500
Message-ID: <45A7F396.4080600@tls.msk.ru>
Date: Fri, 12 Jan 2007 23:46:14 +0300
From: Michael Tokarev <mjt@tls.msk.ru>
Organization: Telecom Service, JSC
User-Agent: Icedove 1.5.0.8 (X11/20061128)
MIME-Version: 1.0
To: Chris Mason <chris.mason@oracle.com>
CC: Linus Torvalds <torvalds@osdl.org>, dean gaudet <dean@arctic.org>,
       Viktor <vvp01@inbox.ru>, Aubrey <aubreylee@gmail.com>,
       Hua Zhong <hzhong@gmail.com>, Hugh Dickins <hugh@veritas.com>,
       linux-kernel@vger.kernel.org, hch@infradead.org,
       kenneth.w.chen@intel.com, akpm@osdl.org
Subject: Re: O_DIRECT question
References: <6d6a94c50701101857v2af1e097xde69e592135e54ae@mail.gmail.com> <Pine.LNX.4.64.0701101902270.3594@woody.osdl.org> <45A629E9.70502@inbox.ru> <Pine.LNX.4.64.0701110750520.3594@woody.osdl.org> <Pine.LNX.4.64.0701112351520.18431@twinlark.arctic.org> <Pine.LNX.4.64.0701120955440.3594@woody.osdl.org> <20070112202316.GA28400@think.oraclecorp.com>
In-Reply-To: <20070112202316.GA28400@think.oraclecorp.com>
X-Enigmail-Version: 0.94.1.0
OpenPGP: id=4F9CF57E
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Chris Mason wrote:
[]
> I recently spent some time trying to integrate O_DIRECT locking with
> page cache locking.  The basic theory is that instead of using
> semaphores for solving O_DIRECT vs buffered races, you put something
> into the radix tree (I call it a placeholder) to keep the page cache
> users out, and lock any existing pages that are present.

But seriously - what about just disallowing non-O_DIRECT opens together
with O_DIRECT ones ?

If the thing will allow non-DIRECT READ-ONLY open, I personally see no
problems whatsoever, at all.  If non-DIRECT READONLY open will be disallowed
too, -- well, a bit less nice, but still workable (allowing online backup
of database files opened in O_DIRECT mode using other tools such as `cp' --
if non-direct opens aren't allowed, i'll switch to using dd or somesuch).

Yes there may be still a race between ftruncate() and reads (either direct
or not), or when filling gaps by writing into places which were skipped
by using ftruncate.  I don't know how serious those races are.

That to say - if the whole thing will be a bit more strict wrt allowing
set of operations, races (or some of them, anyway) will just go away
(and maybe it will work even better due to quite some code and lock
contention removal), and maybe after that, Linus will like the whole
thing a bit better... ;)

After all the explanations, I still don't see anything wrong with the
interface itself.  O_DIRECT isn't "different semantics" - we're still
writing and reading some data.  Yes, O_DIRECT and non-O_DIRECT usages
somewhat contradicts with each other, but there are other ways to make
the two happy, instead of introducing alot of stupid, complex, and racy
code all over.

/mjt
