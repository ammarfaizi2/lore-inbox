Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264679AbTFAReh (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 1 Jun 2003 13:34:37 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264680AbTFAReh
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 1 Jun 2003 13:34:37 -0400
Received: from parcelfarce.linux.theplanet.co.uk ([195.92.249.252]:36555 "EHLO
	www.linux.org.uk") by vger.kernel.org with ESMTP id S264679AbTFAReg
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 1 Jun 2003 13:34:36 -0400
Date: Sun, 1 Jun 2003 18:47:59 +0100
From: viro@parcelfarce.linux.theplanet.co.uk
To: Bernard Blackham <b-lkml@blackham.com.au>
Cc: linux-kernel@vger.kernel.org
Subject: Re: [PATCH] VFS mapping table
Message-ID: <20030601174758.GM9502@parcelfarce.linux.theplanet.co.uk>
References: <20030601133804.GA4131@amidala>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20030601133804.GA4131@amidala>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Jun 01, 2003 at 09:38:04PM +0800, Bernard Blackham wrote:

> Whilst setting up a bunch of thin clients, I thought it'd be really
> useful if a symlink could be pointed at, say /mnt/{ip}/hostname and
> {ip} would expand to the IP address of the machine (inspired by
> Tru64 unix).

You can trivially do that by having '/mnt/{ip}' a directory and
mount --bind /mnt/$IP '/mnt/{ip}' done from initscripts.  No magic
needed.
 
> So does anybody think this would be a useful feature to have, or
> just feature bloat? If useful, I'd be happy to port it to 2.5.xx.

a) it affects all pathname components.  IOW, in effect you are getting
the same bunch of symlinks in each directory.  Besides, what is supposed
to happen if somebody wants different things for different tasks (quite
realistic with your '{ip}' example)?

b) what if I set value to something that contains '/'?
c) what's so special about ' ', '\n' or '\r' (?!?) in the keys and values?
d) no locking whatsoever.

(a) is the real problem - such things should be (at the very least)
per-directory.  What's more, rationale for that stuff in OSF^WTrue64
doesn't apply to Linux - we don't have to modify any filesystem objects
to get host-specific mappings.  Yes, symlinks do not work if fs is
imported read-only.  But we don't need these beasts to be symlinks -
host (or group of processes) can have whatever mounts it wants and
bindings are mounts.  Moreover, with bindings '..' works correctly,
regardless of the relative positions in the tree, so you are less
constrained in the choice of layout.  IOW, we already have tools
to do it in a clean way - no need to copy kludges caused by lack
of decent mount layer in other kernels.
