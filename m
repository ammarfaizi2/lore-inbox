Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S314204AbSDZV2n>; Fri, 26 Apr 2002 17:28:43 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S314210AbSDZV2m>; Fri, 26 Apr 2002 17:28:42 -0400
Received: from gateway2.ensim.com ([65.164.64.250]:20236 "EHLO
	nasdaq.ms.ensim.com") by vger.kernel.org with ESMTP
	id <S314204AbSDZV2l>; Fri, 26 Apr 2002 17:28:41 -0400
X-Mailer: exmh version 2.5 01/15/2001 with nmh-1.0
From: Paul Menage <pmenage@ensim.com>
To: Maneesh Soni <maneesh@in.ibm.com>
cc: pmenage@ensim.com, linux-kernel@vger.kernel.org, viro@math.psu.edu
Subject: Re: [RFC] link_path_walk cleanup
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Date: Fri, 26 Apr 2002 14:28:26 -0700
Message-Id: <E171DGU-0003m7-00@pmenage-dt.ensim.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Hi Maneesh,

The handling of '/' in path_walk() and vfs_follow_link() is broken - if
the pathname consists entirely of  '/' characters, then lookup_parent
returns the base immediately without setting nd->last. If there's more
than one '/', then the check for looking up '/' won't be triggered, and
walk_one() will be called with an undefined nd->last.

So e.g. running

ls '//'

produces

ls: //: File name too long

(but I suspect that it could Oops, depending on what was on the stack 
when the nameidata was allocated.)

Ideally the tests in vfs_follow_link() and path_walk() ought to be
testing for (nd->last_type == LAST_ROOT), rather than checking
explicitly for '/' followed by NUL. But that doesn't work, as last_type
is only set if you include LOOKUP_PARENT in the flags. Setting last_type
on every path element resolution would probably be unecessary overhead
given the relative infrequency of looking up "/".

So the alternative that I suggest is to change lookup_parent() as 
follows:

	while (*name=='/')
		name++;
	if (!*name) {
		nd->last = (struct qstr) { name : ".", len : 1, hash : 0 };
		goto return_base;
	}

and remove the tests for "/" in vfs_follow_link() and path_walk().
Setting nd->last to refer to "." will cause walk_one() to return
immediately, so the zero hash value is OK.

Paul

