Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932336AbWAQSZ5@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932336AbWAQSZ5 (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 17 Jan 2006 13:25:57 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932324AbWAQSZ5
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 17 Jan 2006 13:25:57 -0500
Received: from smtp.osdl.org ([65.172.181.4]:43153 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S932336AbWAQSZ4 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 17 Jan 2006 13:25:56 -0500
Date: Tue, 17 Jan 2006 10:25:49 -0800 (PST)
From: Linus Torvalds <torvalds@osdl.org>
To: Diego Calleja <diegocg@gmail.com>
cc: linux-kernel@vger.kernel.org
Subject: Re: Linux 2.6.16-rc1
In-Reply-To: <20060117183916.399b030f.diegocg@gmail.com>
Message-ID: <Pine.LNX.4.64.0601170946050.3240@g5.osdl.org>
References: <Pine.LNX.4.64.0601170001530.13339@g5.osdl.org>
 <20060117183916.399b030f.diegocg@gmail.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Tue, 17 Jan 2006, Diego Calleja wrote:
> 
> Can I ask if it's possible to "mark" new features/important changes?

Well, I'd rather not do it in the source control management itself, simply 
because people are notoriously bad at deciding what is "important".

It goes something like this: "By definition, anything _you_ work for is 
crap and unimportant, while _my_ work is the most important thing ever, 
even if it happens to be just fixing typos".

Yeah, that's a bit over-generalized, but it definitely has a kernel of 
truth to it. Also, it sometimes turns out that something nobody ever 
really thought about turns out to have tons of side effects and needs lots 
of fixing.

So asking developers to rate how important their work is just doesn't 
really work. 

On the other hand, maybe we could have something where people could easily 
send hints - as they are merged - about new things, just to help. Also, 
we do have automation that can help.

For example, one thing that git does well is that almost all tools can 
follow not just a particular file, but a whole subdirectory (or a set of 
subdirectories). So what _I_ did when I looked at the shortlog and 
realized that it's huge, but I wanted to give something of a view of what 
changed, was to do

	git log v2.6.15..v2.6.16-rc1 -- fs/ |
		git-shortlog |
		less -S

which restricts the log to just things that changed in the fs/ 
subdirectory. That allows you to look at more focused logs, which makes it 
easier to dig into a particular feature or area.

[ Side note: you don't have to have just one directory you track: if 
  you're only interested in a certain set of areas, you can ask for 
  several specific subdirectories or files:

	git log v2.6.15..v2.6.16-rc1 -- fs/ext3/ fs/xfs/

  will give the log only for stuff that changed either of those two 
  directories ]

Also, if you want to judge how big a patch is by the number of files it 
changed, that's easy enough to do too:

	git-rev-list v2.6.15..v2.6.16-rc1 |
		while read id
		do
			files=$(git-diff-tree -r --name-only $id | wc -l)
			echo -e $id $files
		done |
		sort -k2 -n -r | 
		git-diff-tree --pretty --stdin -s |
		less -S

which admittedly takes a bit of time, but will give you a "log" of every 
single commit in the 2.6.15..2.6.16-rc1 range, sorted by how many files it 
touches (most files first).

Now, admittedly, "number of files touched" is not a very good 
approximation of importance, but it can still be interesting, and it may 
be a good approximation for "how invasive was the change", in the sense 
that it is a real measure of how likely a commit was to impact other 
people.

For example, in this case, the #1 commit is 2e4e6a17:

    [NETFILTER] x_tables: Abstraction layer for {ip,ip6,arp}_tables

which actually is one of the more important ones. The other top ones are 
(#2..#10):

    [PATCH] USB: remove .owner field from struct usb_driver
    [PATCH] mutex subsystem, semaphore to mutex: VFS, ->i_sem
    [PATCH] TTY layer buffering revamp
    [PATCH] I2C: Remove .owner setting from i2c_driver as it's no longer needed
    [PATCH] i2c: Drop i2c_driver.flags, 2 of 3
    [INET_SOCK]: Move struct inet_sock & helper functions to net/inet_sock.h
    [ARM] 3260/1: remove phys_ram from struct machine_desc (part 2)
    V4L/DVB (3344a): Conversions from kmalloc+memset to k(z|c)alloc
    [PATCH] powerpc: sanitize header files for user space includes

some of which are very core (the TTY layer buffering revamp), others are 
more pedestrian and just happen to change a lot.

Btw: a word of warning - git is efficient, but doing things like the above 
does require a bit of computing power. The above pipeline to generate the 
log sorted by number of files changed takes just over a minute to execute 
on a 2.5GHz dual G5 box. I'd also suggest you do this on a tree that you 
have recently re-packed, just to avoid the expense of opening millions of 
small files.

Now, if you save off the ordered list of commit IDs to a file:

	git-rev-list v2.6.15..v2.6.16-rc1 |
		while read id
		do
			files=$(git-diff-tree -r --name-only $id | wc -l)
			echo -e $id $files
		done |
		sort -k2 -n -r > most-invasive-commits

you can do other tricks with git too:

	head -25 most-invasive-commits |
		git-diff-tree --stdin --pretty -s | 
		git-shortlog |
		less -S

will do a shortlog that contains just the 25 most invasive commits.

Is this useful to you? I dunno.  I thought I'd spread the git gospel and 
see if somebody gives me a "Halleluja!"

		Linus
