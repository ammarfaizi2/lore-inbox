Return-Path: <linux-kernel-owner+w=401wt.eu-S932520AbXAIXXl@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932520AbXAIXXl (ORCPT <rfc822;w@1wt.eu>);
	Tue, 9 Jan 2007 18:23:41 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932515AbXAIXXl
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 9 Jan 2007 18:23:41 -0500
Received: from e31.co.us.ibm.com ([32.97.110.149]:43443 "EHLO
	e31.co.us.ibm.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932520AbXAIXXk (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 9 Jan 2007 18:23:40 -0500
Date: Tue, 9 Jan 2007 17:23:39 -0600
From: Michael Halcrow <mhalcrow@us.ibm.com>
To: Andrew Morton <akpm@osdl.org>
Cc: linux-kernel@vger.kernel.org, tshighla@us.ibm.com, theotso@us.ibm.com
Subject: Re: [PATCH 0/3] eCryptfs: Support metadata in xattr
Message-ID: <20070109232339.GA32343@us.ibm.com>
Reply-To: Michael Halcrow <mhalcrow@us.ibm.com>
References: <20070109222107.GC16578@us.ibm.com> <20070109143519.dce0ed8b.akpm@osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20070109143519.dce0ed8b.akpm@osdl.org>
User-Agent: Mutt/1.5.9i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jan 09, 2007 at 02:35:19PM -0800, Andrew Morton wrote:
> On Tue, 9 Jan 2007 16:21:07 -0600
> Michael Halcrow <mhalcrow@us.ibm.com> wrote:
> 
> > This patch set introduces the ability to store cryptographic metadata
> > into an lower file extended attribute rather than the lower file
> > header region.
> >
> > This patch set implements two new mount options:
> >
> > ecryptfs_xattr_metadata
> >  - When set, newly created files will have their cryptographic
> >    metadata stored in the extended attribute region of the file rather
> >    than the header.
> 
> Why is this useful?

When storing the data in the file header, there is a minimum of 8KB
reserved for the header information for each file, making each file at
least 12KB in size. This can take up a lot of extra disk space if the
user creates a lot of small files. By storing the data in the extended
attribute, each file will only occupy at least of 4KB of space.

As the eCryptfs metadata set becomes larger with new features such as
multi-key associations, most popular filesystems will not be able to
store all of the information in the xattr region in some cases due to
space constraints. However, the majority of users will only ever
associate one key per file, so most users will be okay with storing
their data in the xattr region.

This option should be used with caution. I want to emphasize that the
xattr must be maintained under all circumstances, or the file will be
rendered permanently unrecoverable. The last thing I want is for a
user to forget to set an xattr flag in a backup utility, only to later
discover that their backups are worthless.

> > ecryptfs_encrypted_view
> >  - When set, this option causes eCryptfs to present applications a
> >    view of encrypted files as if the cryptographic metadata were
> >    stored in the file header, whether the metadata is actually stored
> >    in the header or in the extended attributes.
> 
> Sounds kludgy.  "This mode of operation is useful for applications
> like incremental backup utilities that do not preserve the extended
> attributes when directly accessing the lower files.".  Wouldn't it
> be better to lean on people to use better backup tools, and to fix
> existing ones?

No matter what eCryptfs winds up doing in the lower filesystem, I want
to preserve a baseline format compatibility for the encrypted
files. As of right now, the metadata may be in the file header or in
an xattr. There is no reason why the metadata could not be put in a
separate file in future versions.

Without the compatibility mode, backup utilities would have to know to
back up the metadata file along with the files. The semantics of
eCryptfs have always been that the lower files are self-contained
units of encrypted data, and the only additional information required
to decrypt any given eCryptfs file is the key. That is what has always
been emphasized about eCryptfs lower files, and that is what users
expect. Providing the encrypted view option will provide a way to
userspace applications wherein they can always get to the same old
familiar eCryptfs encrypted files, regardless of what eCryptfs winds
up doing with the metadata behind the scenes.

Mike
