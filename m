Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261221AbVD3NzR@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261221AbVD3NzR (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 30 Apr 2005 09:55:17 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261224AbVD3NzR
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 30 Apr 2005 09:55:17 -0400
Received: from ms-smtp-01.texas.rr.com ([24.93.47.40]:12006 "EHLO
	ms-smtp-01-eri0.texas.rr.com") by vger.kernel.org with ESMTP
	id S261221AbVD3NzH (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 30 Apr 2005 09:55:07 -0400
Subject: Re: [PATCH] cifs: handle termination of cifs oplockd kernel thread
From: Steve French <smfrench@austin.rr.com>
To: Christoph Hellwig <hch@infradead.org>
Cc: Miklos Szeredi <miklos@szeredi.hu>, 7eggert@gmx.de,
       linux-kernel@vger.kernel.org
In-Reply-To: <20050430082952.GA23253@infradead.org>
References: <3YLdQ-4vS-15@gated-at.bofh.it>
	 <E1DRekV-0001RN-VQ@be1.7eggert.dyndns.org>
	 <20050430073238.GA22673@infradead.org>
	 <E1DRn70-0002AD-00@dorka.pomaz.szeredi.hu>
	 <20050430082952.GA23253@infradead.org>
Content-Type: text/plain
Message-Id: <1114865576.19640.17.camel@smfhome.smfdom>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.4 
Date: Sat, 30 Apr 2005 07:52:56 -0500
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 2005-04-30 at 03:29, Christoph Hellwig wrote:
> > 
> > Having a mount owner is not a problem.
Perhaps some day "mount owner" might be more complex than simply the
uid_t of the owner (I don't know if there will be future cases in which
you might want to check the gid_t at mount time or some SELinux specific
security context), but I would prefer that mnt_uid be stored in the
superblock so I could get rid of those few lines of code in cifs, and
that is a fairly non-controversial start.   Coming up with the policy
as Miklos and Christoph were suggesting may be doable in small stages.

>   Having a good policy for
> > accepting mounts is rather more so, according to some:
> > 
> >    http://marc.theaimsgroup.com/?l=linux-kernel&m=107705608603071&w=2
> > 
> > Just a little taste of what that policy would involve:
> > 
> >   - global limit on user mounts
> 
> I don't think we need that one.

agreed

> 
> >   - possibly per user limit on mounts
> 
> Makes sense as an ulimit, that way the sysadmin can easily disable the
> user mount feature aswell.
> 

agreed.

> >   - acceptable mountpoints (unlimited writablity is probably a good minimum)
> 
> Yupp.
Yes, although not sure what unlimited means here since the filesystem
you are mounting will often forbid writes (at the server)

> 
> >   - acceptable mount options (nosuid, nodev are obviously not)
> 
> noexecis a bit too much, so the above look good.

There are cases in which adding noexec might make sense as a system
policy for user mounts, but the typical case in which user mounts are
needed are for home directories over the network or equivalent in which
noexec makes it tough for them to be very useful.  nosuid and nodev on
the other hand should be restricted and users are used to this already
since they are the two flags that are added by mount.cifs if a non-root
user mounts and the admin has configured mount.cifs to allow user
mounts, so that would be consistent.

