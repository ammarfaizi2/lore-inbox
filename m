Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263986AbUCZJ5Q (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 26 Mar 2004 04:57:16 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263984AbUCZJ5Q
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 26 Mar 2004 04:57:16 -0500
Received: from gamemakers.de ([217.160.141.117]:35804 "EHLO www.gamemakers.de")
	by vger.kernel.org with ESMTP id S263986AbUCZJ5L (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 26 Mar 2004 04:57:11 -0500
Message-ID: <4063FEED.1050503@gamemakers.de>
Date: Fri, 26 Mar 2004 10:59:09 +0100
From: =?ISO-8859-1?Q?R=FCdiger_Klaehn?= <rudi@gamemakers.de>
Reply-To: rudi@lambda-computing.de
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.6) Gecko/20040122 Debian/1.6-1
X-Accept-Language: en
MIME-Version: 1.0
To: Alexander Larsson <alexl@redhat.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: [RFC,PATCH] dnotify: enhance or replace?
References: <4061986E.6020208@gamemakers.de>	 <1080142815.8108.90.camel@localhost.localdomain>	 <4061B41B.30305@gamemakers.de>	 <1080202140.8108.101.camel@localhost.localdomain>	 <4062C63F.6050907@gamemakers.de> <1080219862.8108.138.camel@localhost.localdomain>
In-Reply-To: <1080219862.8108.138.camel@localhost.localdomain>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Alexander Larsson wrote:
 > On Thu, 2004-03-25 at 12:45, Rüdiger Klaehn wrote:
 >
 >>I don't know why KDE does this. Probably because of the .desktop files.
 >>  But I can see plenty of reasons to monitor large trees. For example to
 >>keep some kind of metadata consistent with data.
 >>
 >>What is everybodys obsession with file managers anyway? They are the
 >>most *boring* application of an enhanced file change mechanism, and
 >>certainly not the most demanding.
 >
 >
 > I happen to be interested in file managers because I maintain one.
 >
OK, no offense. I just wanted to make it clear that file managers are
not the most demanding use case.

[snip]
 >>Want me to code this into my userspace tool to see what I mean? I am
 >>100% certain it can be done as long as you have inode numbers or
 >>something else to uniquely and persistently identify a file (as opposed
 >>to the name of the file). Unfortunately inode numbers are not unique and
 >>persistent on all file systems, but for e.g. ext3 it should be no 
problem.
 >
 >
 > I'm sure you can look at all the files in the filesystem for a inode,
 > but I hardly think such an expensive operation is useful in practice.
 > Also, such a sweep over the filesystem would be racy and to fix that
 > you'd have to monitor the whole filesystem to catch additions while
 > scanning. And even this is racy, because of possible queue overflows.
 >
You would get notified if the queue overflows. And as long as you empty
it often enough, it should not happen. Events are really small, so for a
reasonably sized queue you would have to try really hard to get it to
overflow.

 > This gets even more complicated with recursive monitors. If you
 > recursively monitor all of "/dir" you have to look for aliases to all
 > the inodes inside /dir in the rest of the filesystem, and whenever new
 > files show up in /dir you'd have to look for aliases to them too.
 >
 > Also, unless you also monitor mounts and unmounts that sort of changes
 > won't be detected. (Not to mention that mounts can now be per-process.)
 >
I guess I should just implement it. All this inode stuff would just be
nessecary if you want to be really sure you detect every change, even
the ones over hard links. For a file manager it would IMHO be OK just to
ignore hard links.

 >
 >> > What if a new alias was created?
 >>
 >>You would get an event. And the new alias would point to the same file.
 >>No problem there.
 >
 >
 > You'd only get an event if you were monitoring the directory where the
 > new alias appeared. This means you have to constantly monitor the whole
 > filesystem to reliably get told about them. Also, of course, in case of
 > a queue overflow while monitoring the whole system you could miss the
 > creation of an alias.
 >
Yes of course. If you want to catch hard links, you need to watch the
root, and it is more expensive than just ignoring hard links like the
current dnotify does. But it *is* possible, and it is not prohibitively
expensive.

 >
 >>If the file manager insists on redrawing itself each time he gets a
 >>write event, you would get 100% cpu. But such a braindead implementation
 >>should not be blamed on the notification mechanism.
 >
 >
 > If you're monitoring a file due to it being visible (say e.g. the file
 > size) on the screen, you *will* be updating and redrawing it all the
 > time, unless you rate-limit your changes.
  >
Yes, but this rate limiting could as well be done in the file manager.

  > Being able to get an event
 > when the file is closed would make this a lot better, because then you
 > can rate-limit heavily, but still get the final result instantly when
 > the download is finished.
 >
You can have that if you want.
