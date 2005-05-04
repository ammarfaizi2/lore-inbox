Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261851AbVEDOV5@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261851AbVEDOV5 (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 4 May 2005 10:21:57 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261848AbVEDOV5
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 4 May 2005 10:21:57 -0400
Received: from rev.193.226.232.93.euroweb.hu ([193.226.232.93]:65035 "EHLO
	dorka.pomaz.szeredi.hu") by vger.kernel.org with ESMTP
	id S261847AbVEDOVj (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 4 May 2005 10:21:39 -0400
To: ericvh@gmail.com
CC: linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
       smfrench@austin.rr.com, hch@infradead.org
In-reply-to: <a4e6962a05050406086e3ab83b@mail.gmail.com> (message from Eric
	Van Hensbergen on Wed, 4 May 2005 08:08:00 -0500)
Subject: Re: [RCF] [PATCH] unprivileged mount/umount
References: <E1DSyQx-0002ku-00@dorka.pomaz.szeredi.hu> <a4e6962a05050406086e3ab83b@mail.gmail.com>
Message-Id: <E1DTKkd-0003rC-00@dorka.pomaz.szeredi.hu>
From: Miklos Szeredi <miklos@szeredi.hu>
Date: Wed, 04 May 2005 16:21:23 +0200
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> I was starting down this track in my tree, but I'm glad you beat me
> to it ;).  Your initial limit (10) seems low if you consider binds
> as mounts.

Where did you see 10 as the limit?  The initial global limit is zero,
the initial per-user limit is infinity (I did actually test these ;)

> I can easily see a user using more than 10 binds in an environment.
> As Ram mentioned earlier - we are going to run into problems with
> the shared-subtree stuff if propagations into private namespaces
> count as a new mount.  We need to think through how we are going to
> deal with this.

Hmm, interesting question.  The safest is to account all mounts in
private namespace (including initial and propagated mounts) to the
user creating the namespace.

> My  major complaint is that I really think having user mounts without
> requiring them to be in a user's private namespace creates quite a
> mess.  It potentially pollutes the system's namespace and opens up the
> possibility of all sorts of synthetic file system "traps".  I'd rather
> see the private namespace stuff enforced before enabling user-mounts.

Yes, I see your point.  However the problem of malicious filesystem
"traps" applies to private namespaces as well (because of suid
programs).

So if a user creates a private namespace, it should have the choice of:

   1) Giving up all suid rights (i.e. all mounts are cloned and
      propagated with nosuid)

   2) Not giving up suid for cloned and propagated mounts, but having
      extra limitations (suid/sgid programs cannot access unprivileged
      "synthetic" mounts)

1) could have the advantage of allowing the user _arbitrary_
modification to the namespace, without limitations on mountpoint
writablity, etc.

Bind mounts are less problematic than user-controlled "synthetic"
filesystems, but it could still cause problems (e.g. trick updatedb to
enter directories which are otherwise in it's prune list).

So what are the possible solutions?

  a) Use "invisible" mounts (a-la my earlier patch) to hide
     problematic mounts from other users.  This would not be a
     replacement for private namespaces, rather a supplement.

  b) same as a) but disallow unprivileged mounts in the global
     namespace completely

  c/d) same as a/b) but without invisible mounts, simply by not
       allowing processes owned by other users (incl. suid/sgid
       processes started by mount owner) to access the files.  FUSE
       now does c).

  e) ???

My order of preference is a), c), d), b).  I don't see any advantage
of b) over a).

Opinions?  Ideas?

Thanks,
Miklos
