Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261398AbTBEOnR>; Wed, 5 Feb 2003 09:43:17 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261409AbTBEOnR>; Wed, 5 Feb 2003 09:43:17 -0500
Received: from facesaver.epoch.ncsc.mil ([144.51.25.10]:60638 "EHLO
	epoch.ncsc.mil") by vger.kernel.org with ESMTP id <S261398AbTBEOnQ>;
	Wed, 5 Feb 2003 09:43:16 -0500
Message-Id: <200302051500.KAA05879@moss-shockers.ncsc.mil>
Date: Wed, 5 Feb 2003 10:00:23 -0500 (EST)
From: "Stephen D. Smalley" <sds@epoch.ncsc.mil>
Reply-To: "Stephen D. Smalley" <sds@epoch.ncsc.mil>
Subject: Re: [BK PATCH] LSM changes for 2.5.59
To: hch@infradead.org
Cc: greg@kroah.com, hch@infradead.org, torvalds@transmeta.com,
       linux-security-module@wirex.com, linux-kernel@vger.kernel.org
MIME-Version: 1.0
Content-Type: TEXT/plain; charset=us-ascii
Content-MD5: quDVD4JA+tZnpa0j+Hd8+A==
X-Mailer: dtmail 1.2.0 CDE Version 1.2 SunOS 5.6 sun4u sparc 
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Christoph Hellwig wrote:
> Of course that needs further changes!
> 
> (a) actually implement that field, and
> (b) change the prototype of the hook to int (*sysctl)(int op, enum sensitivity);

No.  If one were to add such a field, then it would be accessible
through the ctl_table structure that is already passed to the hook.
You would not replace the ctl_table parameter with the kernel's
sensitivity hint, since the security module must be able to make its
own determination as to the protection requirements based on its
particular security model and attributes.  If you only pass the
kernel's view of the sensitivity, then you are hardcoding a specific
policy into the kernel and severely limiting the flexibility of the
security module.  Since the kernel's hint is necessarily independent of
any particular security model/attributes, it will only provide a
coarse-grained partitioning, e.g. you are unlikely to be able to
uniquely distinguish the modprobe variable if you want to specifically
limit a particular process to modifying it.  The existing hook
interface does not need to change.

Implementing a sensitivity hint field in the ctl_table structure would
be trivial, but determining a set of policy-neutral hint values that
capture important confidentiality, integrity, and functional
characteristics and mapping the existing set of sysctl variables to
those hint values is a longer term task.  The hook provides useful
functionality now, apart from such hints, and should not need to wait
on them.  In the short term, there may be a certain amount of
duplication of information among security modules regarding sensitive
sysctl variables, but that information can actually help to feed back
into the process of determining the right general set of hint values
necessary to support multiple security models and the mappings for
the existing sysctl variables.

--
Stephen Smalley, NSA
sds@epoch.ncsc.mil

