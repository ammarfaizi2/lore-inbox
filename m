Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S266196AbSKFWwt>; Wed, 6 Nov 2002 17:52:49 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S266204AbSKFWwt>; Wed, 6 Nov 2002 17:52:49 -0500
Received: from bozo.vmware.com ([65.113.40.131]:25096 "EHLO
	mailout1.vmware.com") by vger.kernel.org with ESMTP
	id <S266196AbSKFWwq>; Wed, 6 Nov 2002 17:52:46 -0500
Date: Wed, 6 Nov 2002 17:58:37 -0800
From: Christopher Li <chrisl@vmware.com>
To: "Theodore Ts'o" <tytso@mit.edu>, Jeremy Fitzhardinge <jeremy@goop.org>,
       Ext2 devel <ext2-devel@lists.sourceforge.net>,
       Linux Kernel List <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] Fix bug in ext3 htree rename: doesn't delete old name, leaves ino with bad nlink
Message-ID: <20021106175837.B7778@vmware.com>
References: <1036471670.21855.15.camel@ixodes.goop.org> <20021105212415.GB1472@vmware.com> <20021106082500.GA3680@vmware.com> <20021106214027.GA9711@think.thunk.org> <20021106172455.A7778@vmware.com> <20021106224112.GA10130@think.thunk.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <20021106224112.GA10130@think.thunk.org>; from tytso@mit.edu on Wed, Nov 06, 2002 at 05:41:12PM -0500
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Nov 06, 2002 at 05:41:12PM -0500, Theodore Ts'o wrote:
> On Wed, Nov 06, 2002 at 05:24:55PM -0800, Christopher Li wrote:
> > 
> > I think we have the lock on ext3_rename. I might be wrong.
> > If other process can change the dir between the add new entry
> > and delete old entry. We should also need to check the entry have
> > been delete from other process in case fall into dead loop? 
> 
> We take the BKL, yes; but if we need to sleep waiting for a block to
> be read in, that's when another process can run.  Yes, that means
> another process could end up deleting the entry out from under us ---
> or make some other change to the directory.  I was actually quite

Then the correct fix for the rename problem is very nasty then.
I thought about remove entry first then add new entry. Then if
add new entry fail abort the whole transaction. It looks nasty
also if it sleep in between, the file goes nowhere.

> nervous about this, so I spent some time auditing the code paths of
> when do_split() might sleep, to make sure it would never leave the
> directory in an unstable condition.
> 
> Things will actually get easier once we fine-grain lock ext3 (and
> remove the BKL), since we'll very likely end up locking the directory
> during an insert, rename, or delete, and so we don't have to worry
> about things happening in an interleaved fashion.

Agree.

>
> I wasn't able to find your e-mail address in the source file.... 
> grep -i chrisl fs/ext3/*.c didn't turn up anything?
Sorry, indeed I did not put my email address there. Never mind.

Chris


