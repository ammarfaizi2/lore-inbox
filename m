Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262486AbUKRPka@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262486AbUKRPka (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 18 Nov 2004 10:40:30 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262500AbUKRPka
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 18 Nov 2004 10:40:30 -0500
Received: from mx1.redhat.com ([66.187.233.31]:33503 "EHLO mx1.redhat.com")
	by vger.kernel.org with ESMTP id S262486AbUKRPil (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 18 Nov 2004 10:38:41 -0500
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
In-Reply-To: <20041118045336.GA5236@thunk.org>
References: <20041116183813.11cbf280.akpm@osdl.org>
	 <20041117223436.GB5334@thunk.org>
	 <1100736003.11047.14.camel@sisko.sctweedie.blueyonder.co.uk>
	 <20041118045336.GA5236@thunk.org>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Organization: 
Message-Id: <1100792279.2028.184.camel@sisko.sctweedie.blueyonder.co.uk>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.2.2 (1.2.2-5) 
Date: 18 Nov 2004 15:37:59 +0000
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On Thu, 2004-11-18 at 04:53, Theodore Ts'o wrote:

> > If we're going to do this, I think we need to stuff . and .. into the
> > rbtree with the right hashes, but without ignoring other existing
> > dirents with colliding hashes.
> 
> We can't just do that, because there are programs that's assume '.'
> and '..' are the first and second entries in the directory.  Yes, they
> are broken and non-portable, but so are programs that depend on
> d_off....

Sorry, by "right hashes" I meant adding them with hashes 0 and 2 but in
the correct place in the stream; so if we do have a hash collision on
major-hash==0, we'll get ".." slightly out of order, but will still
correctly provide all the entries.  And your second patch seems to do
exactly that.  Thanks!

> This patch should do this.

Looks good to me --- have you tested it much?

The only remaining thing I can think of is what happens if the while()
loop at the end of ext3_htree_fill_tree() exits successfully after
filling in hash-major==0.  Then we'll restart at 2 next time, and will
return ".." twice. 

I'm not sure that's actually possible, though.  Moving the filling-in of
".." into the while loop would deal with this rare possibility.

--Stephen

