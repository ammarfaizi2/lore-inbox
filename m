Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030194AbWGMRsX@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030194AbWGMRsX (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 13 Jul 2006 13:48:23 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964789AbWGMRsX
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 13 Jul 2006 13:48:23 -0400
Received: from e31.co.us.ibm.com ([32.97.110.149]:2962 "EHLO e31.co.us.ibm.com")
	by vger.kernel.org with ESMTP id S964787AbWGMRsW (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 13 Jul 2006 13:48:22 -0400
Date: Thu, 13 Jul 2006 12:47:21 -0500
From: "Serge E. Hallyn" <serue@us.ibm.com>
To: Cedric Le Goater <clg@fr.ibm.com>
Cc: "Eric W. Biederman" <ebiederm@xmission.com>, linux-kernel@vger.kernel.org,
       Andrew Morton <akpm@osdl.org>, Kirill Korotaev <dev@openvz.org>,
       Andrey Savochkin <saw@sw.ru>, Herbert Poetzl <herbert@13thfloor.at>,
       Sam Vilain <sam.vilain@catalyst.net.nz>,
       "Serge E. Hallyn" <serue@us.ibm.com>, Dave Hansen <haveblue@us.ibm.com>
Subject: Re: [PATCH -mm 5/7] add user namespace
Message-ID: <20060713174721.GA21399@sergelap.austin.ibm.com>
References: <20060711075051.382004000@localhost.localdomain> <20060711075420.937831000@localhost.localdomain> <m1fyh7eb9i.fsf@ebiederm.dsl.xmission.com> <44B50088.1010103@fr.ibm.com> <m1psgaag7y.fsf@ebiederm.dsl.xmission.com> <44B684A5.2040008@fr.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <44B684A5.2040008@fr.ibm.com>
User-Agent: Mutt/1.5.11
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Quoting Cedric Le Goater (clg@fr.ibm.com):
> Eric W. Biederman wrote:
> 
> >> I think user namespace should be unshared with filesystem. if not, the
> >> user/admin should know what is doing.
> > 
> > No.  The uids in a filesystem are interpreted in some user namespace
> > context.  We can discover that context at the first mount of the
> > filesystem. 
> 
> ok. so once you're in such a user namespace, you can't unshare from it
> without loosing access to all your files ?
> 
> > Assuming the uids on a filesystem are the same set of uids your process
> > is using is just wrong.
> 
> well, this is what is currently done without user namespaces.
> 
> >>> I believe some of the key infrastructure which is roughly kerberos
> >>> authentication tokens could be used for this purpose.
> >> please elaborate ? i'm not sure to understand why you want to use the keys
> >> to map users.
> > 
> > keys are essentially security credentials for something besides the
> > local kernel.  Think kerberos tickets.  That makes the keys the
> > obvious place to say what uid you are in a different user namespace
> > and similar things.
> 
> what about performance ? wouldn't that slow the checking ?

Rather than try to store (uid, namespace) on the filesystem, I like the
idea of doing something like

	mount --bind -o ro --uidswap 500,1001 --uidswap 501,0 /home /home

In other words, when you unshare the user namespace, nothing
filesystem-related changes unless you also unshare the fs-namespace and
set uid info on the vfsmount.  This is fully backward-compatible and
should have no overhead if you don't need the feature.

-serge
