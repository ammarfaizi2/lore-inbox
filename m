Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750878AbVKKQo7@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750878AbVKKQo7 (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 11 Nov 2005 11:44:59 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750879AbVKKQo7
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 11 Nov 2005 11:44:59 -0500
Received: from e31.co.us.ibm.com ([32.97.110.149]:49541 "EHLO
	e31.co.us.ibm.com") by vger.kernel.org with ESMTP id S1750870AbVKKQo7
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 11 Nov 2005 11:44:59 -0500
From: Tom Zanussi <zanussi@us.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-ID: <17268.51814.215178.281986@tut.ibm.com>
Date: Fri, 11 Nov 2005 10:44:22 -0600
To: akpm@osdl.org
Cc: linux-kernel@vger.kernel.org, karim@opersys.com
Subject: [PATCH 0/12] relayfs: API additions and fixes
X-Mailer: VM 7.19 under 21.4 (patch 15) "Security Through Obscurity" XEmacs Lucid
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

This patch set is essentially the same as the set I previously posted,
but broken out into stepwise chunks.

The patches implement or fix 3 things that were specifically requested
or suggested by relayfs users:

- support for non-relay files (patches 1-6)

Currently, the relayfs API only supports the creation of directories
(relayfs_create_dir()) and relay files (relay_open()).  These patches
adds support for non-relay files (relayfs_create_file()).  This is so
relayfs applications can create 'control files' in relayfs itself
rather than in /proc or via a netlink channel, as is currently done in
the relay-app examples.  Basically what this amounts to is exporting
relayfs_create_file() with an additional file_ops param that clients
can use to supply file operations for their own special-purpose files
in relayfs.

- make exported relay file ops useful (patches 7-8)

The relayfs relay_file_operations have always been exported, the
intent being to make it possible to create relay files in other
filesystems such as debugfs.  The problem, though, is that currently
the file operations are too tightly coupled to relayfs to actually be
used for this purpose.  This patch fixes that by adding a couple of
callback functions that allow a client to hook into
relay_open()/close() and supply the files that will be used to
represent the channel buffers; the default implementation if no
callbacks are defined is to create the files in relayfs.

- add an option to create global relay buffer (patches 9-10)
    
The file creation callback also supplies an optional param, is_global,
that can be used by clients to create a single global relayfs buffer
instead of the default per-cpu buffers.  This was suggested as being
useful for certain debugging applications where it's more convenient
to be able to get all the data from a single channel without having to
go to the bother of dealing with per-cpu files.

- cleanup, some renaming and Documentation updates (patches 11-12)    

There were several comments that the use of netlink in the example
code was non-intuitive and in fact the whole relay-app business was
needlessly confusing.  Based on that feedback, the example code has
been completely converted over to relayfs control files as supported
by this patch, and have also been made completely self-contained.

The converted examples along with a couple of new examples that
demonstrate using exported relay files can be found in relay-apps
tarball:
    
http://prdownloads.sourceforge.net/relayfs/relay-apps-0.9.tar.gz?download

Tom


