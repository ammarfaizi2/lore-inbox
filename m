Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751053AbVIXJAn@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751053AbVIXJAn (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 24 Sep 2005 05:00:43 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751200AbVIXJAn
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 24 Sep 2005 05:00:43 -0400
Received: from wombat.indigo.net.au ([202.0.185.19]:34059 "EHLO
	wombat.indigo.net.au") by vger.kernel.org with ESMTP
	id S1751053AbVIXJAm (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 24 Sep 2005 05:00:42 -0400
Date: Sat, 24 Sep 2005 16:59:57 +0800 (WST)
From: Ian Kent <raven@themaw.net>
To: Jeff Moyer <jmoyer@redhat.com>
cc: autofs@linux.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: autofs4 looks up wrong path element when ghosting is enabled
In-Reply-To: <17203.7543.949262.883138@segfault.boston.redhat.com>
Message-ID: <Pine.LNX.4.63.0509241644420.2069@donald.themaw.net>
References: <17200.23724.686149.394150@segfault.boston.redhat.com>
 <Pine.LNX.4.58.0509210916040.26144@wombat.indigo.net.au>
 <17203.7543.949262.883138@segfault.boston.redhat.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
X-MailScanner: Found to be clean
X-MailScanner-SpamCheck: not spam, SpamAssassin (score=-101.4, required 8,
	EMAIL_ATTRIBUTION, IN_REP_TO, QUOTED_EMAIL_TEXT, RCVD_IN_ORBS,
	RCVD_IN_OSIRUSOFT_COM, REFERENCES, REPLY_WITH_QUOTES,
	USER_AGENT_PINE, USER_IN_WHITELIST)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 22 Sep 2005, Jeff Moyer wrote:

> ==> Regarding Re: autofs4 looks up wrong path element when ghosting is enabled; Ian Kent <raven@themaw.net> adds:
> 
> raven> On Tue, 20 Sep 2005, Jeff Moyer wrote:
> >> Hi, Ian, list,
> >> 
> >> I have a bug filed against autofs when ghosting is enabled.  The best way
> >> to describe the bug is to walk through the reproducer, I guess.
> >> 
> >> Take the following maps, for example:
> >> 
> >> auto.master
> >> /sbox	auto.sbox
> >> 
> >> auto.sbox:
> >> src	segfault:/sbox/src/
> >> 
> >> Let's say that there is a file, id3_0.12.orig.tar.gz, in segfault:/sbox/src/.
> >> 
> >> To reproduce the problem, stop the nfs service on the server.
> >> 
> >> On the client, do an 'ls /sbox/src/id3_012.orig.tar.gz'.  This will fail,
> >> as well it should.  However, if we look in the logs, we find this:
> >> 
> >> automount[1182]: handle_packet_missing: token 1, name src 
> >> automount[1182]: attempting to mount entry /sbox/src
> >> ...
> >> automount[1481]: mount(nfs): calling mkdir_path /sbox/src
> >> automount[1481]: mount(nfs): calling mount -t nfs -s-o tcp,intr,timeo=600,rsize=8192,wsize=8192,retrans=5 segfault:/sbox/src /sbox/src
> >> automount[1481]: >> mount: RPC: Program not registered
> >> automount[1481]: mount(nfs): add_bad_host: segfault:/sbox/src
> >> automount[1481]: mount(nfs): nfs: mount failure segfault:/sbox/src on /sbox/src
> >> automount[1481]: failed to mount /sbox/src
> >> ...
> >> automount[1182]: send_fail: token=1 
> >> automount[1182]: handle_packet: type = 0 
> >> automount[1182]: handle_packet_missing: token 2, name src/id3_0.12.orig.tar.gz 
> >> automount[1182]: attempting to mount entry /sbox/src/id3_0.12.orig.tar.gz
> >> 
> >> Noteworthy are these last two lines!  Even though the mount failed, we are
> >> continuing the lookup.  The culprit is here, in cached_lookup:
> >> 
> >> if (!dentry->d_op->d_revalidate(dentry, flags) && !d_invalidate(dentry)) { 
> >> dput(dentry); 
> >> dentry = NULL; 
> >> } 
> >> 
> >> d_revalidate points to autofs4_revalidate, which calls try_to_fill_dentry,
> >> which will return a status of 0.  Since ghosting is enabled,
> >> d_invalidate(dentry) will return -EBUSY, and so we return the dentry to 
> raven> the
> >> caller, which then continues the lookup.
> >> 
> >> Ian, I'm not really sure how we can address this issue without VFS
> >> changes.  Any ideas?
> >> 
> 
> raven> I'm aware of this problem.
> raven> I'm not sure how to deal with it yet.
> raven> The case above is probably not that difficult to solve but if the last 
> raven> component is a directory it's hard to work out it's a problem.
> 
> Ugh.  If you're thinking what I think you're thinking, that's an ugly hack.

Don't think so.

I've been seeing this for a while. I wasn't quite sure of the source but, 
for some reason your report has cleared that up.

The problem is not so much the success returned on the failed mount 
(revalidate). It's the return from the following lookup. This is a lookup 
in a non-root directory. I replaced the non-root lookup with the root 
lookup a while ago and I think this is an unexpected side affect of that. 
Becuase of other changes that lead to that decision I think that it should 
be now be OK to put back the null function (always return a negative 
dentry) that was there before I started working on the browable maps 
feature.

I'll change the module I use here and test it out for a while.
If you have time I could make a patch for the 2.4 code and send it over so 
that you could test it out a bit as well.

> 
> raven> There's more information here than I've gathhered so far.
> 
> >> Oh, also note that, once the nfs service is started up again on the server,
> >> the lookup of a specific file name will still fail!  In this case, the
> >> daemon won't even be called.
> 
> raven> I'll have to check this out.
> raven> It could be helpful.
> 
> Well, I've provided a reproducer.  If you'd like log output from the kernel
> side, let me know.  I can certainly provide that.

Don't think I need it.
I'm fairly sure I understand what's happening here now. As I said above.

Ian

