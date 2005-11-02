Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030202AbVKBXgj@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030202AbVKBXgj (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 2 Nov 2005 18:36:39 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030205AbVKBXgj
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 2 Nov 2005 18:36:39 -0500
Received: from tirith.ics.muni.cz ([147.251.4.36]:51637 "EHLO
	tirith.ics.muni.cz") by vger.kernel.org with ESMTP id S1030202AbVKBXgj
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 2 Nov 2005 18:36:39 -0500
Date: Thu, 3 Nov 2005 00:36:29 +0100
From: Jan Kasprzak <kas@fi.muni.cz>
To: Nathan Scott <nathans@sgi.com>
Cc: linux-kernel@vger.kernel.org, linux-xfs@oss.sgi.com
Subject: Re: XFS information leak during crash
Message-ID: <20051102233629.GD6759@fi.muni.cz>
References: <20051102212722.GC6759@fi.muni.cz> <20051103101107.O6239737@wobbly.melbourne.sgi.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20051103101107.O6239737@wobbly.melbourne.sgi.com>
User-Agent: Mutt/1.4.1i
X-Muni-Spam-TestIP: 147.251.48.3
X-Muni-Envelope-From: kas@fi.muni.cz
X-Muni-Virus-Test: Clean
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Nathan Scott wrote:
: > The result is that those files contain data from random blocks on the
: > disk (e.g. from previously deleted files). This can have security/privacy
: > implications - users can see the contents of other users' old files.
: 
: If you think you have found a security issue, it would be courteous
: to at least discuss this with the maintainers first.

	Well, I think while it is a security issue, it is not serious
enough to make it secret (it is not exploitable by anyone except those
who are able to crash the machine).

: And since you
: are a frequent linux-xfs list poster too, it seems a bit odd that
: you're reporting this on linux-kernel instead... *shrug*, whatever.

	I am sorry for this one - I am not subscribed to linux-xfs.
Next time I will post to linux-xfs first.
: 
: This issue affects every filesystem, right?  Or are you claiming its
: only XFS affected here?  Have you run your parallel-buffered-writers
: test case on any other filesystems?  I'd be interested in the results,
: in particular, with all of the data=xxx modes of other filesystems.
: 
	I will do this tomorrow or the day after and post the results.

: > either). Does XFS support a something like ext3's "data=ordered" mount
: > option? 
: 
: No, it doesn't.
: 
	OK.

: > Otherwise it is pretty unusable on multi-user systems.
: 
: That's a ridiculous assertion.  While this small metadata vs. buffered-
: data-write window exists on _any_ filesystem not using a data=ordered/
: data=journaled mode (which I believe is quite a common mode of operation
: even on filesystems that offer those modes),

	As for ext3, I believe the vast majority of ext3 filesystems
run in data=ordered mode. But yes, the same problem affects all filesystem
except those running in data=ordered/journal mode.

: it is impossible to exploit
: this in any sane way.  You'd think people on a multi-user system might
: actually notice the machine being frequently rebooted while you try to
: tickle this window to get at "interesting" uninitialised freespace, no?

	Yes, of course. However, the issue is probably much worse
on XFS, because on XFS it probably affects not only the files being
created/extended, but also the files being rewritten. Most other
filesystems rewrite the files in-place, so when you rewrite the file,
even with data=writeback you get only the mix of the old and new
contents. Not somebody else's random data.

	This particular problem was that one of my users apparently opened
his TeX document just to fix few typos, and ended up with the file which
contained some part of a shell script and some binary data :-(

	I agree this is hard to exploit on purpose, however it can still
leak a sensitive data. For example, this particular server runs also
a mail server for ~2200 users, so a private mail can end up in somebody
else's files.

: Having said that, a data=ordered mode for XFS would be a nice feature.
: It just hasn't reached the top of our priority list, and its not been
: offered up as a patch by anyone yet.  If anyone's interested in writing
: this, they should coordinate with hch and myself - there's a fair bit
: of I/O path work being done at the moment, which in the end will make
: a data=ordered mode alot easier to implement.

	OK, thanks! I wish I would have time to do more kernel hacking ...

-Yenya

-- 
| Jan "Yenya" Kasprzak  <kas at {fi.muni.cz - work | yenya.net - private}> |
| GPG: ID 1024/D3498839      Fingerprint 0D99A7FB206605D7 8B35FCDE05B18A5E |
| http://www.fi.muni.cz/~kas/    Journal: http://www.fi.muni.cz/~kas/blog/ |
> Specs are a basis for _talking_about_ things. But they are _not_ a basis <
> for implementing software.                              --Linus Torvalds <
