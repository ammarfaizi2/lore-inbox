Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262690AbUKRAFF@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262690AbUKRAFF (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 17 Nov 2004 19:05:05 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262619AbUKRADX
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 17 Nov 2004 19:03:23 -0500
Received: from mx1.redhat.com ([66.187.233.31]:55753 "EHLO mx1.redhat.com")
	by vger.kernel.org with ESMTP id S262643AbUKRABO (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 17 Nov 2004 19:01:14 -0500
Subject: Re: Fw: [POSSIBLE-BUG] telldir() broken on ext3 dir_index'd
	directories just after the first entry.
From: "Stephen C. Tweedie" <sct@redhat.com>
To: "Theodore Ts'o" <tytso@mit.edu>
Cc: Andrew Morton <akpm@osdl.org>, r6144 <rainy6144@gmail.com>,
       linux-kernel <linux-kernel@vger.kernel.org>,
       "ext2-devel@lists.sourceforge.net" <ext2-devel@lists.sourceforge.net>,
       phillips@istop.com, Alex Tomas <alex@clusterfs.com>,
       Christopher Li <chrisl@vmware.com>,
       Christopher Li <ext2-devel@chrisli.org>,
       Stephen Tweedie <sct@redhat.com>
In-Reply-To: <20041117223436.GB5334@thunk.org>
References: <20041116183813.11cbf280.akpm@osdl.org>
	 <20041117223436.GB5334@thunk.org>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Organization: 
Message-Id: <1100736003.11047.14.camel@sisko.sctweedie.blueyonder.co.uk>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.2.2 (1.2.2-5) 
Date: 18 Nov 2004 00:00:05 +0000
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On Wed, 2004-11-17 at 22:34, Theodore Ts'o wrote:

> Here is a patch which causes d_off of '.' to be 1, and for seekdir(1)
> to cause readdir to return the directory entry of '..'.  

Doesn't this make things worse?  The old problem was that
seekdir/telldir were broken (which we already knew for certain cases
like hash collisions).  But with...

> +		start_hash=2;

don't we end up silently ignoring all dirents with a major hash <= 1,
even for unbroken getdents() with no intervening seekdir?  Previously
we'd at least fill them into the rbtree, so sequential readdir would
find them even if the hash collided.  Now we'll skip them entirely.

If we're going to do this, I think we need to stuff . and .. into the
rbtree with the right hashes, but without ignoring other existing
dirents with colliding hashes.

--Stephen

