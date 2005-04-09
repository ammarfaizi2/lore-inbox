Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261305AbVDIHVH@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261305AbVDIHVH (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 9 Apr 2005 03:21:07 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261306AbVDIHVH
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 9 Apr 2005 03:21:07 -0400
Received: from willy.net1.nerim.net ([62.212.114.60]:40712 "EHLO
	willy.net1.nerim.net") by vger.kernel.org with ESMTP
	id S261305AbVDIHVB (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 9 Apr 2005 03:21:01 -0400
Date: Sat, 9 Apr 2005 09:20:35 +0200
From: Willy Tarreau <willy@w.ods.org>
To: Linus Torvalds <torvalds@osdl.org>
Cc: Chris Wedgwood <cw@f00f.org>,
       Matthias-Christian Ott <matthias.christian@tiscali.de>,
       Andrea Arcangeli <andrea@suse.de>,
       Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: Kernel SCM saga..
Message-ID: <20050409072035.GB7858@alpha.home.local>
References: <20050408041341.GA8720@taniwha.stupidest.org> <Pine.LNX.4.58.0504072127250.28951@ppc970.osdl.org> <20050408071428.GB3957@opteron.random> <Pine.LNX.4.58.0504080724550.28951@ppc970.osdl.org> <4256AE0D.201@tiscali.de> <Pine.LNX.4.58.0504081010540.28951@ppc970.osdl.org> <20050408171518.GA4201@taniwha.stupidest.org> <Pine.LNX.4.58.0504081037310.28951@ppc970.osdl.org> <20050408180540.GA4522@taniwha.stupidest.org> <Pine.LNX.4.58.0504081149010.28951@ppc970.osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.58.0504081149010.28951@ppc970.osdl.org>
User-Agent: Mutt/1.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Apr 08, 2005 at 12:03:49PM -0700, Linus Torvalds wrote:
 
> And if you do actively malicious things in your own directory, you get
> what you deserve. It's actually _hard_ to try to fool git into believing a
> file hasn't changed: you need to not only replace it with the exact same
> file length and ctime/mtime, you need to reuse the same inode/dev numbers
> (again - I didn't worry about portability, and filesystems where those
> aren't stable are a "don't do that then") and keep the mode the same. Oh,
> and uid/gid, but that was much me being silly.

It would be even easier to touch the tree with a known date before
patching (eg:1/1/70). It would protect against any accidental date
change if for any reason your system time went backwards while
working on the tree.

Another trick I use when I build the 2.4-hf patches is to build a
list of filenames from the patches. It works only because I want
to keep all original patches and no change should appear outside
those patches. Using this + cp -al + diff -pruN makes the process
very fast. It would not work if I had to rebuild those patches from
hand-edited files of course.

Last but not least, it only takes 0.26 seconds on my dual athlon
1800 to find date/size changes between 2.6.11{,.7} and 4.7s if the
tool includes the md5 sum in its checks :

$ time flx check --ignore-owner --ignore-mode --ignore-ldate --ignore-dir \
  --ignore-dot --only-new --ignore-sum linux-2.6.11/. linux-2.6.11.7/. |wc -l
     47

real    0m0.255s
user    0m0.094s
sys     0m0.162s

$ time flx check --ignore-owner --ignore-mode --ignore-ldate --ignore-dir \
  --ignore-dot --only-new linux-2.6.11/. linux-2.6.11.7/. |wc -l
     47

real    0m4.705s
user    0m3.398s
sys     0m1.310s

(This was with 'flx', a tool a friend developped for file-system integrity
checking which we also use to build our packages). Anyway, what I wanted
to show is that once the trees are cached, even somewhat heavy operations
such as checksumming can be done occasionnaly (such as md5 for double
checking) without you waiting too long. And I don't think that a database
would provide all the comfort of a standard file-system (cp -al, rsync,
choice of tools, etc...).

Willy

