Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750998AbVIVVJl@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750998AbVIVVJl (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 22 Sep 2005 17:09:41 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751204AbVIVVJl
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 22 Sep 2005 17:09:41 -0400
Received: from mx1.redhat.com ([66.187.233.31]:36840 "EHLO mx1.redhat.com")
	by vger.kernel.org with ESMTP id S1750998AbVIVVJk (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 22 Sep 2005 17:09:40 -0400
From: Jeff Moyer <jmoyer@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-ID: <17203.7543.949262.883138@segfault.boston.redhat.com>
Date: Thu, 22 Sep 2005 17:09:11 -0400
To: Ian Kent <raven@themaw.net>
Cc: autofs@linux.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: autofs4 looks up wrong path element when ghosting is enabled
In-Reply-To: <Pine.LNX.4.58.0509210916040.26144@wombat.indigo.net.au>
References: <17200.23724.686149.394150@segfault.boston.redhat.com>
	<Pine.LNX.4.58.0509210916040.26144@wombat.indigo.net.au>
X-Mailer: VM 7.17 under 21.4 (patch 15) "Security Through Obscurity" XEmacs Lucid
Reply-To: jmoyer@redhat.com
X-PGP-KeyID: 1F78E1B4
X-PGP-CertKey: F6FE 280D 8293 F72C 65FD  5A58 1FF8 A7CA 1F78 E1B4
X-PCLoadLetter: What the f**k does that mean?
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

==> Regarding Re: autofs4 looks up wrong path element when ghosting is enabled; Ian Kent <raven@themaw.net> adds:

raven> On Tue, 20 Sep 2005, Jeff Moyer wrote:
>> Hi, Ian, list,
>> 
>> I have a bug filed against autofs when ghosting is enabled.  The best way
>> to describe the bug is to walk through the reproducer, I guess.
>> 
>> Take the following maps, for example:
>> 
>> auto.master
>> /sbox	auto.sbox
>> 
>> auto.sbox:
>> src	segfault:/sbox/src/
>> 
>> Let's say that there is a file, id3_0.12.orig.tar.gz, in segfault:/sbox/src/.
>> 
>> To reproduce the problem, stop the nfs service on the server.
>> 
>> On the client, do an 'ls /sbox/src/id3_012.orig.tar.gz'.  This will fail,
>> as well it should.  However, if we look in the logs, we find this:
>> 
>> automount[1182]: handle_packet_missing: token 1, name src 
>> automount[1182]: attempting to mount entry /sbox/src
>> ...
>> automount[1481]: mount(nfs): calling mkdir_path /sbox/src
>> automount[1481]: mount(nfs): calling mount -t nfs -s-o tcp,intr,timeo=600,rsize=8192,wsize=8192,retrans=5 segfault:/sbox/src /sbox/src
>> automount[1481]: >> mount: RPC: Program not registered
>> automount[1481]: mount(nfs): add_bad_host: segfault:/sbox/src
>> automount[1481]: mount(nfs): nfs: mount failure segfault:/sbox/src on /sbox/src
>> automount[1481]: failed to mount /sbox/src
>> ...
>> automount[1182]: send_fail: token=1 
>> automount[1182]: handle_packet: type = 0 
>> automount[1182]: handle_packet_missing: token 2, name src/id3_0.12.orig.tar.gz 
>> automount[1182]: attempting to mount entry /sbox/src/id3_0.12.orig.tar.gz
>> 
>> Noteworthy are these last two lines!  Even though the mount failed, we are
>> continuing the lookup.  The culprit is here, in cached_lookup:
>> 
>> if (!dentry->d_op->d_revalidate(dentry, flags) && !d_invalidate(dentry)) { 
>> dput(dentry); 
>> dentry = NULL; 
>> } 
>> 
>> d_revalidate points to autofs4_revalidate, which calls try_to_fill_dentry,
>> which will return a status of 0.  Since ghosting is enabled,
>> d_invalidate(dentry) will return -EBUSY, and so we return the dentry to 
raven> the
>> caller, which then continues the lookup.
>> 
>> Ian, I'm not really sure how we can address this issue without VFS
>> changes.  Any ideas?
>> 

raven> I'm aware of this problem.
raven> I'm not sure how to deal with it yet.
raven> The case above is probably not that difficult to solve but if the last 
raven> component is a directory it's hard to work out it's a problem.

Ugh.  If you're thinking what I think you're thinking, that's an ugly hack.

raven> There's more information here than I've gathhered so far.

>> Oh, also note that, once the nfs service is started up again on the server,
>> the lookup of a specific file name will still fail!  In this case, the
>> daemon won't even be called.

raven> I'll have to check this out.
raven> It could be helpful.

Well, I've provided a reproducer.  If you'd like log output from the kernel
side, let me know.  I can certainly provide that.

-Jeff
