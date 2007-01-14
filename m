Return-Path: <linux-kernel-owner+w=401wt.eu-S1751319AbXANPjl@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751319AbXANPjl (ORCPT <rfc822;w@1wt.eu>);
	Sun, 14 Jan 2007 10:39:41 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751321AbXANPjl
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 14 Jan 2007 10:39:41 -0500
Received: from mail.tmr.com ([64.65.253.246]:44106 "EHLO gaimboi.tmr.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751319AbXANPjk (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 14 Jan 2007 10:39:40 -0500
Message-ID: <45AA4EC8.7020707@tmr.com>
Date: Sun, 14 Jan 2007 10:39:52 -0500
From: Bill Davidsen <davidsen@tmr.com>
Organization: TMR Associates Inc, Schenectady NY
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.8.0.8) Gecko/20061105 SeaMonkey/1.0.6
MIME-Version: 1.0
To: Michael Tokarev <mjt@tls.msk.ru>
CC: Chris Mason <chris.mason@oracle.com>, dean gaudet <dean@arctic.org>,
       Viktor <vvp01@inbox.ru>, Aubrey <aubreylee@gmail.com>,
       Hua Zhong <hzhong@gmail.com>, Hugh Dickins <hugh@veritas.com>,
       linux-kernel@vger.kernel.org, hch@infradead.org,
       kenneth.w.chen@intel.com, akpm@osdl.org
Subject: Re: O_DIRECT question
References: <6d6a94c50701101857v2af1e097xde69e592135e54ae@mail.gmail.com> <Pine.LNX.4.64.0701101902270.3594@woody.osdl.org> <45A629E9.70502@inbox.ru> <Pine.LNX.4.64.0701110750520.3594@woody.osdl.org> <Pine.LNX.4.64.0701112351520.18431@twinlark.arctic.org> <Pine.LNX.4.64.0701120955440.3594@woody.osdl.org> <20070112202316.GA28400@think.oraclecorp.com> <45A7F396.4080600@tls.msk.ru> <45A7F4F2.2080903@tls.msk.ru> <45A7F7A7.1080108@tls.msk.ru> <Pine.LNX.4.64.0701121611370.3470@woody.osdl.org> <45A93BEA.6040601@tmr.com> <45A940A9.2030001@tls.msk.ru>
In-Reply-To: <45A940A9.2030001@tls.msk.ru>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Michael Tokarev wrote:
> Bill Davidsen wrote:

> If I got it right (and please someone tell me if I *really* got it right!),
> the problem is elsewhere.
> 
> Suppose you have a filesystem, not at all related to databases and stuff.
> Your usual root filesystem, with your /etc/ /var and so on directories.
> 
> Some time ago you edited /etc/shadow, updating it by writing new file and
> renaming it to proper place.  So you have that old content of your shadow
> file (now deleted) somewhere on the disk, but not accessible from the
> filesystem.
> 
> Now, a bad guy deliberately tries to open some file on this filesystem, using
> O_DIRECT flag, ftruncates() it to some huge size (or does seek+write), and
> at the same time tries to use O_DIRECT read of the data.

Which should be identified and zeros returned. Consider: I open a file 
for database use, and legitimately seek to a location out at, say, 
250MB, and then write at the location my hash says I should. That's all 
legitimate. Now when some backup program accesses the file sequentially, 
it gets a boatload of zeros, because Linux "knows" that is sparse data. 
Yes, the backup program should detect this as well, so what?

My point is, that there is code to handle sparse data now, without 
O_DIRECT involved, and if O_DIRECT bypasses that, it's not a problem 
with the idea of O_DIRECT, the kernel has a security problem.
> 
> Due to all the races etc, it is possible for him to read that old content of
> /etc/shadow file you've deleted before.
> 
>> I do have one thought, WRT reading uninitialized disk data. I would hope
>> that sparse files are handled right, and that when doing a write with
>> O_DIRECT the metadata is not updated until the write is done.
> 
> "hope that sparse files are handled right" is a high hope.  Exactly because
> this very place IS racy.

Other than assuring that a program can't read where no program has 
written, I don't see a problem. Anyone accessing the same file with 
multiple processes had better be doing user space coordination, and gets 
no sympathy from me if they don't. In this case, "works right" does not 
mean "works as expected," because the program has no right to assume the 
kernel will sort out poor implementations.

Without O_DIRECT the problem of doing ordered i/o in user space becomes 
very difficult, if not impossible, so "get rid of O_DIRECT" is the wrong 
direction. When the program can be sure the i/o is done, then cleverness 
in user space can see that it's done RIGHT.

-- 
bill davidsen <davidsen@tmr.com>
   CTO TMR Associates, Inc
   Doing interesting things with small computers since 1979
