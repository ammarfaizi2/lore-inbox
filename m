Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263078AbUCSTTc (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 19 Mar 2004 14:19:32 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263158AbUCSTTc
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 19 Mar 2004 14:19:32 -0500
Received: from stine.vestdata.no ([195.204.68.10]:29158 "EHLO
	stine.vestdata.no") by vger.kernel.org with ESMTP id S263078AbUCSTTa
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 19 Mar 2004 14:19:30 -0500
Date: Fri, 19 Mar 2004 20:19:16 +0100
From: Ragnar =?iso-8859-15?Q?Kj=F8rstad?= <kernel@ragnark.vestdata.no>
To: Tim Schmielau <tim@physik3.uni-rostock.de>
Cc: lkml <linux-kernel@vger.kernel.org>,
       Arthur Corliss <corliss@digitalmages.com>,
       Albert Cahalan <albert@users.sourceforge.net>
Subject: Re: [patch,rfc] BSD accounting format rework
Message-ID: <20040319191916.GQ1066@vestdata.no>
References: <Pine.LNX.4.53.0403161414150.19052@gockel.physik3.uni-rostock.de> <Pine.LNX.4.53.0403191424480.19032@gockel.physik3.uni-rostock.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-15
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <Pine.LNX.4.53.0403191424480.19032@gockel.physik3.uni-rostock.de>
User-Agent: Mutt/1.5.2i
X-Zet.no-MailScanner-Information: Please contact the ISP for more information
X-MailScanner: Found to be clean
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Mar 19, 2004 at 03:09:20PM +0100, Tim Schmielau wrote:
> This is what came out of my BSD accounting format rework.
> 
> I've used up all explicit and implicit padding in struct acct to
>  - correctly report 32 bit uid/gid,
>  - correctly report jobs (e.g., daemons) running longer than 497 days,
>  - increase the precision of ac_etime from 2^-13 to 2^-20
>    (i.e., from ~6 hours to ~1 min. after a year)
>  - allow cross-platform processing of the accounting file
>    (except for some platforms (m68k, arm?) which already have incompatible
>    padding)
>  - smoothen transition to incompatible formats in the future.
> All this is accomplished without breaking binary compatibility. 32 bit 
> uid/gid support is compatible with the previously floating patch used e.g. 
> by Red Hat.

Looks good :)

> I also made a config option for a new, binary incompatible format. By 
> getting rid of the compatibility stuff, I could also
>  - store pid and ppid of the process
>  - further increase the precision of ac_etime to 2^-24
>    (i.e., to ~1sec after a year)
>  - have a uniform format on all platforms
>  - use AHZ==100 on all platforms (allows to report longer times)
> This new "version 2" format is source compatible with current GNU acct 
> tools. However, current GNU acct tools can be compiled for only one
> format. As there is no way to pass the kernel configuration to userspace,
> with my patch it will still only support the old v1 format. Only if
> v1 support is removed from the kernel, recompiling GNU acct tools will
> yield v2 support.

Do you mind adding the session-id (sid) as well?

There is still a lot of information left in the kernel that we are not
including in the log. I'm not proposing adding all that other stuff
(except the sid, already mentioned), but maybe we can make it even
easier to add them in the future:

One idea is to add the size of the structure to log. The start of the
struct could be something like:
struct acct_base {
	char flags;
	char ac_version;
	__u16 ac_size;
}

This makes future extentions easier in two seperate ways:
Userspace acct can recognize futuristic data structures. It will, of
course, not be able to process them, but it can warn the user and then
continue on to the next struct.

Also, it would make it possible to add new fields at the end of the
structure _without_ bumping the version-number. (Like an extention to
the same format). When userspace find a v2 struct bigger that it's
"struct acct_v2" it can parse the first part of the data with struct
acct_v2 and just ignore the rest. This makes it trivial to add new
fields without breaking userspace.


-- 
Ragnar Kjørstad
Software Engineer
Scali - http://www.scali.com
High Performance Clustering
