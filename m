Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751180AbWIFOpl@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751180AbWIFOpl (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 6 Sep 2006 10:45:41 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751198AbWIFOpR
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 6 Sep 2006 10:45:17 -0400
Received: from cantor.suse.de ([195.135.220.2]:43730 "EHLO mx1.suse.de")
	by vger.kernel.org with ESMTP id S1750910AbWIFOpK (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 6 Sep 2006 10:45:10 -0400
Message-Id: <20060906151438.228071937@winden.suse.de>
User-Agent: quilt/0.44-16.4
Date: Wed, 06 Sep 2006 17:14:38 +0200
From: Andreas Gruenbacher <agruen@suse.de>
To: linux-kernel@vger.kernel.org
Subject: [patch 0/3] [RFC] NFSv4 ACLs on ext3
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I would like to propose the following patches, which implement NFSv4 Access 
Control Lists on Ext3 filesystems:


  [patch 1/3] Pass MAY_APPEND through to permission inode operations
	      that understand it

  [patch 2/3] Add match_string() for mount option parsing

  [patch 3/3] NFSv4 ACLs on ext3


The kernel patches and the nfs4acl user-space utility are hosted here, 
together with an extensive design document, and small bits of user 
documentation:

  http://www.suse.de/~agruen/nfs4acl/


Linux currently supports POSIX (draft) ACLs [1]. The NFSv4 protocol defines 
its own Access Control List model, which is more powerful but incompatible 
with POSIX ACLs, and close to the CIFS (Windows) ACL model.

This leads to problems both for Samba/CIFS and NFSv4, which need to map 
between NFSv4 ACLs and POSIX ACLs. A perfect mapping between the two models 
is not possible, and information will always be lost along the way. One of 
the results is that users are confronted with awkward behavior.

POSIX ACLs are not the only ACL model which can be implemented in a POSIX [2] 
compliant way: NFSv4 ACLs can also be extended to offer perfect POSIX 
semantics.

The implementation allows to choose which ACL model to use on a per-filesystem 
basis. This allows administrators to enable NFSv4 ACLs on a part or all of 
the filesystem hierarchy. As long as NFSv4 ACLs are not used, the filesystem 
will have the traditional POSIX file permission behavior.


Project Goal

My high-level goal for this project is to make Linux a much better file server 
in UNIX, Windows, and mixed environments. This will take away the excuses why 
Linux cannot be used as the server platform of choice even with lots of 
Windows clients. It will allow POSIX applications to be used for automating 
things in the traditional UNIX way, even for Windows clients, which is one of 
the areas where UNIX truly excels.


Benefits

 * POSIX applications will experience perfect POSIX semantics on an NFSv4
   enabled file system when interacting with other POSIX applications.

 * NFSv4 applications (NFSv4, CIFS, Samba) will experience perfect NFSv4 ACL
   semantics when interacting with other NFSv4 applications.

 * The losses in interactions between POSIX and NFSv4 applications are kept to
   a  minimum, without exposing "weird" file permission bits or NFSv4 ACLs to
   applications.

 * In a POSIX + CIFS / NFSv4 environment, a lot less complicated mapping
   between two different ACL models will be necessary, which will lead to
   fewer losses and less awkward behavior.

 * With native NFSv4 ACLs, Linux will become much better suited as a file
   server in multi-protocol environments. POSIX and NFSv4 ACLs are fully
   integrated, so even alternating accesses to data from multiple platforms
   will become much less painful.


Drawbacks

 * User-space that is aware of ACLs will be confronted with two different ACL
   models and may want to map between the two in some cases, so mapping
   between NFSv4 ACLs and POSIX ACLs will not go away completely. Note that we
   already have this problem with the NFSv4 client, which already exposes
   NFSv4 ACLs to user-space.

 * The NFSv4 daemon will likely also continue to map NFSv4 ACLs to POSIX ACLs
   as best as it can for compatibility with POSIX ACL filesystems. Ideally,
   this mapping would go away at least from the kernel, but as long as
   compatibility with POSIX ACL filesystems is a goal, it can't.


Open Issues

 * The kernel patches currently only support NFSv4 ACLs on Ext3.

 * As of the time of this writing, Samba does not include native NFSv4 ACL
   support. From what I have heard, the Samba team is supporting the native
   NFSv4 ACL effort though, so this is expected to change soon.

 * NFSv4 protocol support for native NFSv4 ACLs has not been implemented,
   yet. The POSIX ACL <=> NFSv4 ACL mapping code in version 4 of nfsd is
   based on different data structures for storing ACLs. Hooking NFSv4 ACLs
   up to the NFSv4 client and server shouldn't be much work, but fully
   integrating the two will be a little more difficult.

 * While NFSv4 ACLs support permissions such as WRITE_ACL and WRITE_OWNER, the
   VFS does not ask filesystems whether a process is allowed such accesses.
   Instead, it asks filesystems in terms of MAY_READ, MAY_WRITE, MAY_APPEND,
   and MAY_EXEC. Therefore, filesystems cannot allow processes such
   permissions at the moment. This could be fixed, but even without extending
   the VFS, native NFSv4 ACLs already offer much better interoperability with
   NFSv4 and CIFS than POSIX ACLs do.


References

[1] IEEE 1003.1e Draft 17: Draft Standard for Information Technology -
    Portable Operating System Interface (POSIX) - System Application Program
    Interface, October 1997. http://wt.xpilot.org/publications/posix.1e/

[2] Institute of Electrical and Electronics Engineers, "Information
    Technology - Portable Operating System Interface (POSIX)", IEEE Standard
    1003.1, December 2004. http://www.unix.org/version3/


Regards,
Andreas

--
Andreas Gruenbacher <agruen@suse.de>
SUSE Labs, SUSE LINUX Products GmbH / Novell Inc.

