Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932800AbWCQVu6@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932800AbWCQVu6 (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 17 Mar 2006 16:50:58 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932801AbWCQVu6
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 17 Mar 2006 16:50:58 -0500
Received: from mx1.redhat.com ([66.187.233.31]:30137 "EHLO mx1.redhat.com")
	by vger.kernel.org with ESMTP id S932800AbWCQVu4 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 17 Mar 2006 16:50:56 -0500
Subject: Re: ext3_ordered_writepage() questions
From: "Stephen C. Tweedie" <sct@redhat.com>
To: Jamie Lokier <jamie@shareable.org>
Cc: "Theodore Ts'o" <tytso@mit.edu>, Badari Pulavarty <pbadari@us.ibm.com>,
       Andrew Morton <akpm@osdl.org>, linux-kernel@vger.kernel.org,
       linux-fsdevel@vger.kernel.org, jack@suse.cz,
       Stephen Tweedie <sct@redhat.com>
In-Reply-To: <20060317153213.GA20161@mail.shareable.org>
References: <1141777204.17095.33.camel@dyn9047017100.beaverton.ibm.com>
	 <20060308124726.GC4128@lst.de> <4410551D.5000303@us.ibm.com>
	 <20060309153550.379516e1.akpm@osdl.org> <4410CA25.2090400@us.ibm.com>
	 <20060316180904.GA29275@thunk.org>
	 <20060317153213.GA20161@mail.shareable.org>
Content-Type: text/plain
Date: Fri, 17 Mar 2006 16:50:21 -0500
Message-Id: <1142632221.3641.33.camel@orbit.scot.redhat.com>
Mime-Version: 1.0
X-Mailer: Evolution 2.6.0 (2.6.0-1) 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On Fri, 2006-03-17 at 15:32 +0000, Jamie Lokier wrote:

> That's the wrong way around for uses which check mtimes to revalidate
> information about a file's contents.

It's actually the right way for newly-allocated data: the blocks being
written early are invisible until the mtime update, because the mtime
update is an atomic part of the transaction which links the blocks into
the inode.

> Local search engines like Beagle, and also anything where "make" is
> involved, and "rsync" come to mind.

Make and rsync (when writing, that is) are not usually updating in
place, so they do in fact want the current ordered mode.

It's *only* for updating existing data blocks that there's any
justification for writing mtime first.  That's the question here.

There's a significant cost in forcing the mtime to go first: it means
that the VM cannot perform any data writeback for data written by a
transaction until the transaction has first been committed.  That's the
last thing you want to be happening under VM pressure, as you may not in
fact be able to close the transaction without first allocating more
memory.

--Stephen

