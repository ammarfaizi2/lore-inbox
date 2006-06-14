Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964984AbWFNO1M@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964984AbWFNO1M (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 14 Jun 2006 10:27:12 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964981AbWFNO1M
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 14 Jun 2006 10:27:12 -0400
Received: from relay2.uli.it ([62.212.1.5]:13782 "EHLO relay2.uli.it")
	by vger.kernel.org with ESMTP id S964978AbWFNO1K convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 14 Jun 2006 10:27:10 -0400
From: Daniele orlandi <daniele@orlandi.com>
Organization: VoiSmart
To: linux-kernel@vger.kernel.org
Subject: Passing references to kobjects between userland and kernel
Date: Wed, 14 Jun 2006 16:26:38 +0200
User-Agent: KMail/1.9.1
MIME-Version: 1.0
Content-Disposition: inline
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Message-Id: <200606141626.39273.daniele@orlandi.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Hello,

I'm trying to figure out what is the correct way to pass references to 
kobjects between userland and kernel space.

I have my big object hierarchy of kobjects representing a TDM interconnect 
graph with channels, crossconnectors, physical ports and so on.
The main objects are nodes and archs; archs connect two nodes together.

The hierarchy is exported to sysfs.

>From userland I want to tell the kernel "Connect node X to node Y".

The first problem is deciding what interface to use; currently I'm using an 
ioctl() but I'm open to suggestions.

The other issue is how to identify objects X and Y in the ioctl() request, 
here are the possible ways I've examined:

1- Path
-------

Every kobject registered in sysfs has its own path. I can use path_lookup() 
and lookup the object by its kobj.dentry.

Pros: In userland it's easy to identify kobjects by their path in sysfs. The 
path is unambiguous and already available.

Cons: Passing the pathname to the kernel requires a big ioctl() body 
(theoretically at least 2*MAX_PATH using a fixed-length structure).

Doing the reverse mapping (from kernel to userspace) is not easy since you 
need to know from which vfsmount to generate the path with d_path().

2- Relative path
----------------

Pros: No need to consider where sysfs is mounted and would also work if the 
kobjects are not registeres in sysfs.

Cons: There should be specific functions to parse/generate a pathname that is 
specific to kobject hierarchy.

3- Unique ID
------------

A unique ID, probably a integer value can be assigned to each object.

Pros: much more compact, do not need parsing

Cons: Needs an 'id' attribute in sysfs for every object and a reverse mapping 
(done with symlinks?) to allow an userland application to map IDs to paths 
and vice-versa. Unique ID allocation needs an allocator (list, bitmap, etc) 
either global or for every namespace.

4- kobject's pointer
------------------
The kobject's pointer could opaquely be seen as a unique identifier.

Pros: Compact, no need for storage.

Cons: Probably insane, exposes kernel internals to the userland, a developer 
may be tempted to deference the user-provided value directly :)

So, are there any other ways? If not, which one would be advisable among 
these?

Bye,

-- 
  Daniele "Vihai" Orlandi
