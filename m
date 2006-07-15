Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1946030AbWGOMg7@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1946030AbWGOMg7 (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 15 Jul 2006 08:36:59 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1946034AbWGOMg7
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 15 Jul 2006 08:36:59 -0400
Received: from ebiederm.dsl.xmission.com ([166.70.28.69]:13493 "EHLO
	ebiederm.dsl.xmission.com") by vger.kernel.org with ESMTP
	id S1946030AbWGOMg6 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 15 Jul 2006 08:36:58 -0400
From: ebiederm@xmission.com (Eric W. Biederman)
To: Kyle Moffett <mrmacman_g4@mac.com>
Cc: Trond Myklebust <trond.myklebust@fys.uio.no>,
       Dave Hansen <haveblue@us.ibm.com>, "Serge E. Hallyn" <serue@us.ibm.com>,
       Cedric Le Goater <clg@fr.ibm.com>, linux-kernel@vger.kernel.org,
       Andrew Morton <akpm@osdl.org>, Kirill Korotaev <dev@openvz.org>,
       Andrey Savochkin <saw@sw.ru>, Herbert Poetzl <herbert@13thfloor.at>,
       Sam Vilain <sam.vilain@catalyst.net.nz>
Subject: Re: [PATCH -mm 5/7] add user namespace
References: <m1mzbd1if1.fsf@ebiederm.dsl.xmission.com>
	<1152815391.7650.58.camel@localhost.localdomain>
	<m1wtahz5u2.fsf@ebiederm.dsl.xmission.com>
	<1152821011.24925.7.camel@localhost.localdomain>
	<m17j2gzw5u.fsf@ebiederm.dsl.xmission.com>
	<1152887287.24925.22.camel@localhost.localdomain>
	<m17j2gw76o.fsf@ebiederm.dsl.xmission.com>
	<20060714162935.GA25303@sergelap.austin.ibm.com>
	<m18xmwuo5r.fsf@ebiederm.dsl.xmission.com>
	<1152896138.24925.74.camel@localhost.localdomain>
	<20060714170814.GE25303@sergelap.austin.ibm.com>
	<1152897579.24925.80.camel@localhost.localdomain>
	<m17j2gt7fo.fsf@ebiederm.dsl.xmission.com>
	<1152900911.5729.30.camel@lade.trondhjem.org>
	<m1hd1krpx6.fsf@ebiederm.dsl.xmission.com>
	<1152911079.5729.70.camel@lade.trondhjem.org>
	<m1psg7qzjl.fsf@ebiederm.dsl.xmission.com>
	<4DBD2EBA-9AE2-4598-A9E5-FE7ADCA60B44@mac.com>
Date: Sat, 15 Jul 2006 06:35:18 -0600
In-Reply-To: <4DBD2EBA-9AE2-4598-A9E5-FE7ADCA60B44@mac.com> (Kyle Moffett's
	message of "Sat, 15 Jul 2006 00:35:34 -0400")
Message-ID: <m1d5c7qc55.fsf@ebiederm.dsl.xmission.com>
User-Agent: Gnus/5.110004 (No Gnus v0.4) Emacs/21.4 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Kyle Moffett <mrmacman_g4@mac.com> writes:

> Here's a possible example:
>
> I have one disk which I want to share between multiple virtualized  instances
> for root filesystems.  I bind-mount /onedisk/foo as the foo  virtual machine's
> root and /onedisk/bar as the bar virtual machine's  root.  There should (must)
> be two interpretations of the linear UID  space on that disk, one for the foo
> virtual machine, and one for the  bar virtual machine.  By allowing the
> administrator to determine UID  namespace per-vfsmount, you make such an
> arrangement possible where  it otherwise would not be.

Yes.

With the scenario you describe there is a confusing case of how do
you interpret uids on the /onedisk mount.  uid mapping may be a more
appropriate strategy to remove all confusion there.

> With NFS and the proposed superblock-sharing patches (necessary for  efficiency
> and other reasons I don't entirely understand), the  situation is worse:  A
> mount of server:/foo/bar on / in the bar virtual machine may get its superblock
> merged with a mount of server:/ foo/baz on / in the baz virtual machine.  If
> it's efficient to merge  those superblocks we should, and once again it's
> necessary to tie the  UID namespace to the vfsmount, not the
> superblock.

I completely agree that pushing nameidata down into generic_permission
where we can use per mount properties in our permission checks is
ideal.  The benefit I see is just a small increase in flexibility.
So I don't really care either way.

Currently there are several additional flags that could benefit
from a per vfsmount interpretation as well:  nosuid, noexec, nodev,
and readonly, how do we handle those?

noexec is on the vfsmount.
nosuid is on the vfsmount
nodev  is on the vfsmount
readonly is not on the vfsmount.

The existing precedent is clearly in favor of putting this kind of
information on the vfsmount.  The read-only attribute seems to
be the only hold out.  If readonly has deep implications like
no journal replay it makes sense to keep it per mount.  Which
indicates we could nose a nowrite option to express the per
vfsmount property.

I hope the confusion has passed for Trond.  My impression was he
figured this was per process data so it didn't make sense any where
near a filesystem, and the superblock was the last place it should
be.

Eric
