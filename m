Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263979AbUCZJvC (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 26 Mar 2004 04:51:02 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263984AbUCZJvC
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 26 Mar 2004 04:51:02 -0500
Received: from gamemakers.de ([217.160.141.117]:35548 "EHLO www.gamemakers.de")
	by vger.kernel.org with ESMTP id S263979AbUCZJu6 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 26 Mar 2004 04:50:58 -0500
Message-ID: <4063FD79.2000901@gamemakers.de>
Date: Fri, 26 Mar 2004 10:52:57 +0100
From: =?ISO-8859-1?Q?R=FCdiger_Klaehn?= <rudi@gamemakers.de>
Reply-To: rudi@lambda-computing.de
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.6) Gecko/20040122 Debian/1.6-1
X-Accept-Language: en
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org
Subject: Re: [RFC,PATCH] dnotify: enhance or replace?
References: <4061986E.6020208@gamemakers.de>	 <1080142815.8108.90.camel@localhost.localdomain>	 <4061B41B.30305@gamemakers.de> <1080202140.8108.101.camel@localhost.localdomain>
In-Reply-To: <1080202140.8108.101.camel@localhost.localdomain>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Alexander Larsson wrote:

[snip]
 >>About recursive notification:
 >>
 >>Some way to watch for changes on a whole file system is a must.
 >>Otherwise there is really no need to replace dnotify. When I start up
 >>KDE it watches for 256 different directories in my /home directory. It
 >>would probably watch even more directories if it could. With recursive
 >>watching it would only need to watch two or three directories 
recursively.
 >
 >
 > I see no reasons for a file manager to monitor all of $HOME, unless
 > you're showing all of it. Getting all the events for $HOME will just
 > cause things to be slower.
 >
I don't know why KDE does this. Probably because of the .desktop files.
   But I can see plenty of reasons to monitor large trees. For example to
keep some kind of metadata consistent with data.

What is everybodys obsession with file managers anyway? They are the
most *boring* application of an enhanced file change mechanism, and
certainly not the most demanding.

[snip]
 >>This would require large changes, and I think figuring out all aliases
 >>to a path might as well be done in userspace. You don't gain much by
 >>putting this in the kernel, and it requires a lot of complexity.
 >
 >
 > There is no sane way to do that in userspace. How would you find all the
 > aliases? traverse the whole filesystem?
  >
This would indeed be an expensive operation. You would need a mapping
from paths to inode numbers for the files you want to watch. If you just
want to watch for changes for a single file or a small subdirectory it
is not that bad though.

Want me to code this into my userspace tool to see what I mean? I am
100% certain it can be done as long as you have inode numbers or
something else to uniquely and persistently identify a file (as opposed
to the name of the file). Unfortunately inode numbers are not unique and
persistent on all file systems, but for e.g. ext3 it should be no problem.

  > What if a new alias was created?
 >
You would get an event. And the new alias would point to the same file.
No problem there.

 >
 >>>* Some way to get an event when the last open fd to the file is closed
 >>>after a file change. This means you won't get hundreds of write events
 >>>for a single file change. (Of course, you won't catch writes to e.g.
 >>>logs which aren't closed, so this has to be optional. But for a desktop,
 >>>this is often what you want.)
 >>>
 >>
 >>Should be no problem to add this with the current approach. But it is
 >>not that bad if you are getting hundreds of write events for a single
 >>file. They are just 32 bytes, so you can just throw them away in the
 >>userspace if you are not interested in them.
 >
 >
 > If you get a changed event for every write() to a file downloading to
 > the desktop then fam and the filemanager will use 100% cpu while
 > downloading. Been there, done that, added the rate limiter. However the
 > rate limiter doesn't fix the cpu use from just getting and ignoring all
 > the events.
 >
Strange. I have my userspace tool running on the first console. It is
watching for everything on "/" (throwing away most of it immediately). I
am downloading various stuff with mldonkey, playing an mp3 file with
xmms, and running a KDE session and mozilla.

My CPU load is at an average of 5%. (Athlon 2500+ with 512mb ram)

If the file manager insists on redrawing itself each time he gets a
write event, you would get 100% cpu. But such a braindead implementation
should not be blamed on the notification mechanism.
