Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261615AbTBEQaG>; Wed, 5 Feb 2003 11:30:06 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261624AbTBEQaF>; Wed, 5 Feb 2003 11:30:05 -0500
Received: from facesaver.epoch.ncsc.mil ([144.51.25.10]:53728 "EHLO
	epoch.ncsc.mil") by vger.kernel.org with ESMTP id <S261615AbTBEQaF>;
	Wed, 5 Feb 2003 11:30:05 -0500
Message-Id: <200302051647.LAA05940@moss-shockers.ncsc.mil>
Date: Wed, 5 Feb 2003 11:47:05 -0500 (EST)
From: "Stephen D. Smalley" <sds@epoch.ncsc.mil>
Reply-To: "Stephen D. Smalley" <sds@epoch.ncsc.mil>
Subject: Re: [BK PATCH] LSM changes for 2.5.59
To: hch@infradead.org
Cc: greg@kroah.com, torvalds@transmeta.com, linux-security-module@wirex.com,
       linux-kernel@vger.kernel.org
MIME-Version: 1.0
Content-Type: TEXT/plain; charset=us-ascii
Content-MD5: oYdK5KG1nA32Gb4DcjIsQw==
X-Mailer: dtmail 1.2.0 CDE Version 1.2 SunOS 5.6 sun4u sparc 
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Christoph Hellwig wrote:
> Yes, and exactly that's the whole point of it!  The problem with LSM
> is that it tries to be overly flexible and thus adds random hooks that
> expose internal details all over the place.  Just stop that silly no policy
> approach and life will get a lot simpler.  There's no reason to implement
> everything and a kitchen sink in LSM.

The sysctl hook simply provides a way for a security module to
implement a security check for access to sysctl variables.  It provides
a classic kernel object (ctl_table) x operation interface, with the
subject implicitly passed via current, just like permission() for
inodes.  A security module can leave the hook unimplemented (no
restrictions beyond DAC), or implement a purely process-based
restriction or implement fine-grained controls to individual sysctls.
Sysctls are already exposed to userspace via sysctl(2) and/or
/proc/sys, so I'm not sure what the concern is there.  Nothing
complicated here.

As to your argument about LSM's flexibility, LSM simply followed the
guidance on what would be accepted into 2.5.  The original
SELinux/Flask architecture was more tightly integrated and had
well-defined boundaries while still providing substantial flexibility,
but the response to the SELinux presentation was to move towards
something more like LSM.  Seems pointless to argue about it now, except
as suggestions for future directions for LSM in 2.7.

> If you need attributes attached to the sysctl nodes just diable sysctl by
> number and use the existing filesystem based hooks.

Sorry, I don't see why this is preferable to implementing a single
security hook in ctl_perm that is invoked for both sysctl(2) and
/proc/sys access, providing a consistent access control regardless of
the interface.  Your approach is more prone to vulnerability (failing to
disable the sysctl(2) interface), and breaking application compatibility.

--
Stephen Smalley, NSA
sds@epoch.ncsc.mil

