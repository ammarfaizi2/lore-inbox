Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263764AbUCXQNe (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 24 Mar 2004 11:13:34 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263762AbUCXQNe
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 24 Mar 2004 11:13:34 -0500
Received: from gamemakers.de ([217.160.141.117]:8665 "EHLO www.gamemakers.de")
	by vger.kernel.org with ESMTP id S263764AbUCXQNb (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 24 Mar 2004 11:13:31 -0500
Message-ID: <4061B41B.30305@gamemakers.de>
Date: Wed, 24 Mar 2004 17:15:23 +0100
From: =?ISO-8859-1?Q?R=FCdiger_Klaehn?= <rudi@gamemakers.de>
Reply-To: rudi@lambda-computing.de
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.6) Gecko/20040122 Debian/1.6-1
X-Accept-Language: en
MIME-Version: 1.0
To: Alexander Larsson <alexl@redhat.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: [RFC,PATCH] dnotify: enhance or replace?
References: <4061986E.6020208@gamemakers.de> <1080142815.8108.90.camel@localhost.localdomain>
In-Reply-To: <1080142815.8108.90.camel@localhost.localdomain>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Alexander Larsson wrote:

[snip]
> I think everyone agrees that dnotify is a POS that needs replacement,
> however coming up with a good new API and implementation seems to be
> hard (or at least uninteresting to kernel developers). 
> 
I want something like this, so I am willing to spend some time 
implementing it.

> I for sure would welcome a sane file change notification API, i.e. one
> that doesn't require the use of signals. However, I don't really care
> about recursive monitors, and I'm actually unsure if you really want the
> DN_EXTENDED functionallity in the kernel. It seems like a great way to
> make the kernel use a lot of unswappable memory, unless you limit the
> event queues, and if you do that you need to stat all files in userspace
> anyway so you can correctly handle queue overflows.
> 
About recursive notification:

Some way to watch for changes on a whole file system is a must. 
Otherwise there is really no need to replace dnotify. When I start up 
KDE it watches for 256 different directories in my /home directory. It 
would probably watch even more directories if it could. With recursive 
watching it would only need to watch two or three directories recursively.

About the buffer memory usage problem:

I have been testing the current approach for a few days continuously 
now, and I don't get event buffer overflows even if I watch for all 
events on "/". Of course the event buffer size should be limited. The 
current implementation uses 10*4096 bytes, but in most cases starting 
with a single 4096 byte page should be enough.

Note that the most common events (read and write) are quite small. 
Currently they are 32 bytes, but it would not be that hard to get them 
even smaller if nessecary. This is quite good compared to libraries like 
dazuko that report the complete path for each change.

Extended information about the type of change has been requested by many 
persons, and it is nessecary for many applications. People have been 
writing ugly syscall table hacks for this, so they must be really 
desperate to get this information...

It should be optional though.

> I think the most important properties for a good dnotify replacement is:
> 
> * Don't use signals or any other global resource that makes it
> impossible to use the API in a library thats supposed to be used by all
> sorts of applications.
> 
Agreed.

> * Get sane semantics. i.e. if a hardlink changes notify a file change in
> all directories the file is in. (This is hard though, it needs backlinks
> from the inodes to the directories, at least for the directories with a
> monitor, something i guess we don't have today.)
> 
This would require large changes, and I think figuring out all aliases 
to a path might as well be done in userspace. You don't gain much by 
putting this in the kernel, and it requires a lot of complexity.

> * Some way to get an event when the last open fd to the file is closed
> after a file change. This means you won't get hundreds of write events
> for a single file change. (Of course, you won't catch writes to e.g.
> logs which aren't closed, so this has to be optional. But for a desktop,
> this is often what you want.)
> 
Should be no problem to add this with the current approach. But it is 
not that bad if you are getting hundreds of write events for a single 
file. They are just 32 bytes, so you can just throw them away in the 
userspace if you are not interested in them.
