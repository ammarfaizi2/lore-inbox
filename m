Return-Path: <linux-kernel-owner+w=401wt.eu-S1422785AbXAMU12@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1422785AbXAMU12 (ORCPT <rfc822;w@1wt.eu>);
	Sat, 13 Jan 2007 15:27:28 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1422786AbXAMU12
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 13 Jan 2007 15:27:28 -0500
Received: from hobbit.corpit.ru ([81.13.94.6]:24687 "EHLO hobbit.corpit.ru"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1422785AbXAMU11 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 13 Jan 2007 15:27:27 -0500
Message-ID: <45A940A9.2030001@tls.msk.ru>
Date: Sat, 13 Jan 2007 23:27:21 +0300
From: Michael Tokarev <mjt@tls.msk.ru>
Organization: Telecom Service, JSC
User-Agent: Icedove 1.5.0.8 (X11/20061128)
MIME-Version: 1.0
To: Bill Davidsen <davidsen@tmr.com>
CC: Chris Mason <chris.mason@oracle.com>, dean gaudet <dean@arctic.org>,
       Viktor <vvp01@inbox.ru>, Aubrey <aubreylee@gmail.com>,
       Hua Zhong <hzhong@gmail.com>, Hugh Dickins <hugh@veritas.com>,
       linux-kernel@vger.kernel.org, hch@infradead.org,
       kenneth.w.chen@intel.com, akpm@osdl.org
Subject: Re: O_DIRECT question
References: <6d6a94c50701101857v2af1e097xde69e592135e54ae@mail.gmail.com> <Pine.LNX.4.64.0701101902270.3594@woody.osdl.org> <45A629E9.70502@inbox.ru> <Pine.LNX.4.64.0701110750520.3594@woody.osdl.org> <Pine.LNX.4.64.0701112351520.18431@twinlark.arctic.org> <Pine.LNX.4.64.0701120955440.3594@woody.osdl.org> <20070112202316.GA28400@think.oraclecorp.com> <45A7F396.4080600@tls.msk.ru> <45A7F4F2.2080903@tls.msk.ru> <45A7F7A7.1080108@tls.msk.ru> <Pine.LNX.4.64.0701121611370.3470@woody.osdl.org> <45A93BEA.6040601@tmr.com>
In-Reply-To: <45A93BEA.6040601@tmr.com>
X-Enigmail-Version: 0.94.1.0
OpenPGP: id=4F9CF57E
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Bill Davidsen wrote:
> Linus Torvalds wrote:
>>
[]
>> But what O_DIRECT does right now is _not_ really sensible, and the
>> O_DIRECT propeller-heads seem to have some problem even admitting that
>> there _is_ a problem, because they don't care. 
> 
> You say that as if it were a failing. Currently if you mix access via
> O_DIRECT and non-DIRECT you can get unexpected results. You can screw
> yourself, mangle your data, or have no problems at all if you avoid
> trying to access the same bytes in multiple ways. There are lots of ways
> to get or write stale data, not all involve O_DIRECT in any way, and the
> people actually using O_DIRECT now are managing very well.
> 
> I don't regard it as a system failing that I am allowed to shoot myself
> in the foot, it's one of the benefits of Linux over Windows. Using
> O_DIRECT now is like being your own lawyer, room for both creativity and
> serious error. But what's there appears portable, which is important as
> well.

If I got it right (and please someone tell me if I *really* got it right!),
the problem is elsewhere.

Suppose you have a filesystem, not at all related to databases and stuff.
Your usual root filesystem, with your /etc/ /var and so on directories.

Some time ago you edited /etc/shadow, updating it by writing new file and
renaming it to proper place.  So you have that old content of your shadow
file (now deleted) somewhere on the disk, but not accessible from the
filesystem.

Now, a bad guy deliberately tries to open some file on this filesystem, using
O_DIRECT flag, ftruncates() it to some huge size (or does seek+write), and
at the same time tries to use O_DIRECT read of the data.

Due to all the races etc, it is possible for him to read that old content of
/etc/shadow file you've deleted before.

> I do have one thought, WRT reading uninitialized disk data. I would hope
> that sparse files are handled right, and that when doing a write with
> O_DIRECT the metadata is not updated until the write is done.

"hope that sparse files are handled right" is a high hope.  Exactly because
this very place IS racy.

Again, *IF* I got it correctly.

/mjt
