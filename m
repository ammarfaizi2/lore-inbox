Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262880AbVAQVVi@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262880AbVAQVVi (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 17 Jan 2005 16:21:38 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262877AbVAQVVi
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 17 Jan 2005 16:21:38 -0500
Received: from dsl093-002-214.det1.dsl.speakeasy.net ([66.93.2.214]:60816 "EHLO
	pickle.fieldses.org") by vger.kernel.org with ESMTP id S261378AbVAQVVb
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 17 Jan 2005 16:21:31 -0500
Date: Mon, 17 Jan 2005 16:21:28 -0500
To: Mike Waychison <Michael.Waychison@Sun.COM>
Cc: Al Viro <viro@parcelfarce.linux.theplanet.co.uk>,
       linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [RFC] shared subtrees
Message-ID: <20050117212128.GJ24830@fieldses.org>
References: <20050113221851.GI26051@parcelfarce.linux.theplanet.co.uk> <41EC0466.9010509@sun.com> <20050117190028.GF24830@fieldses.org> <41EC1253.8080902@sun.com> <20050117193206.GH24830@fieldses.org> <41EC1BE6.1030506@sun.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <41EC1BE6.1030506@sun.com>
User-Agent: Mutt/1.5.6+20040907i
From: "J. Bruce Fields" <bfields@fieldses.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jan 17, 2005 at 03:11:18PM -0500, Mike Waychison wrote:
> I don't think that solves the problem.  B should receive copies (with
> shared semantics if called for) of all mountpoints C1,..,Cn that are
> children of A if A->A.  This is regardless of whether or not propagation
> occurs before or after the attach.

Consider this situation:
# #make new vfsmounts at /foo and /bar:
# mount --bind /foo /foo
# mount --bind /bar /bar
# # mount /bar under /foo, *then* put /bar and /mnt2 in the same p-node:
# mount --bind /bar /foo/mnt1
# mount --make-shared /foo
# mount --bind /foo /mnt2
# find # and I think this is what you'll get:
.
./foo
./bar
./bar/file_in_bar
./foo/mnt1
./foo/mnt1/file_in_bar
./mnt2/
./mnt2/mnt1/

Since /mnt2 and /foo are in the same p-node, any mounts we may make
under them later will be shared.  But the mount under under /foo/mnt1 is
*not* automatically propagated to /mnt2/mnt1, and /mnt1 is still in its
own little p-node (so mounts under it won't be replicated).

At least, I think I have that right.

In any case, setting up propagation between two vfsmounts needn't force
propagation of preexisting mounts, it need only affect mounts made later.

--b.
