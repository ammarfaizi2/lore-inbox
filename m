Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751201AbWFLR7E@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751201AbWFLR7E (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 12 Jun 2006 13:59:04 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751508AbWFLR7D
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 12 Jun 2006 13:59:03 -0400
Received: from nz-out-0102.google.com ([64.233.162.200]:55828 "EHLO
	nz-out-0102.google.com") by vger.kernel.org with ESMTP
	id S1751201AbWFLR7C (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 12 Jun 2006 13:59:02 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:to:subject:cc:message-id:date:from;
        b=n8wOzKJgXrzGzksNh2DaeCPcA3CbPpX/bVax+90CcFYJ0MKNlql806nzO6sRli6kWiZ4pjkIOpq9E+8QpTKUzvgWoCQ20IGe7lc38ueEbiW6qMICy1xS5wPPJwN/3Ul3grK7ZY+rlGD5vkBN2lk7h1qLs4MjtYKHNZwh9JJeEtA=
To: linux-kernel@vger.kernel.org
Subject: [RFC] vfs: Support for COW files in sys_open
Cc: akpm@osdl.org
Message-Id: <20060612181025.597041185DC@localhost.localdomain>
Date: Mon, 12 Jun 2006 14:10:25 -0400 (EDT)
From: Carl Spalletta <cspalletta@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I need a quick heads up on the following proposal regarding adding
support for COW files in sys_open.  The way it works is this:

A self described "COW-aware" application will open files with the proposed
O_COW flag to sys_open.  Getting back the proposed error value ECOW it
knows it has requested write permissions on a COW file (marked as such
by its owner with the proposed value S_COW) and it must preserve the
contents of the original file.

Applications can set their own policy on this:  For illustration,
one policy would be if the path given to open was a symlink it can
provisionally rename the link and open a new unlinked regular file with
the same contents.  If anything actually gets written it just closes the
regular file when it is done.  Otherwise it deletes the unchanged regular
file and moves back the symlink where it was.  If the path given to open
was a hard link it can do the same, moving aside the file and creating
a new unlinked file, treating them both with the same logic as in the
previous case.

There are probably many different policies that could be adopted, that
is not what I am arguing about.

The point is, this proposal is intended as a bridge to allow COW semantics
to be provided by applications until a final solution is agreed upon
in the kernel.  It could in some measure serve as a testbed  for that
hypothetical "final solution".  And files marked S_COW would remain so
even if this proposal was to be superseded by a kernel-only approach.

Applications would not need to be concerned with the different IOCTLs
and IOCTL args for each filesystem, or the status of individual
filesystems with regard to implementation of the proposed S_COW
flag. Just 'open("path",flag | O_COW)';  moreover nothing would be
broken either in userspace or the kernel since ECOW is never returned
from anything that does not end up passing a mask containing O_COW to
fs/namei.c::permission(); ie, only if an application or a kernel user
deliberately adds that flag to the mask.

Original patch here:

http://lkml.org/lkml/2006/6/8/213

