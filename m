Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S266153AbSKFWTF>; Wed, 6 Nov 2002 17:19:05 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S266163AbSKFWTF>; Wed, 6 Nov 2002 17:19:05 -0500
Received: from bozo.vmware.com ([65.113.40.131]:19719 "EHLO
	mailout1.vmware.com") by vger.kernel.org with ESMTP
	id <S266153AbSKFWTE>; Wed, 6 Nov 2002 17:19:04 -0500
Date: Wed, 6 Nov 2002 17:24:55 -0800
From: Christopher Li <chrisl@vmware.com>
To: "Theodore Ts'o" <tytso@mit.edu>, Jeremy Fitzhardinge <jeremy@goop.org>,
       Ext2 devel <ext2-devel@lists.sourceforge.net>,
       Linux Kernel List <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] Fix bug in ext3 htree rename: doesn't delete old name, leaves ino with bad nlink
Message-ID: <20021106172455.A7778@vmware.com>
References: <1036471670.21855.15.camel@ixodes.goop.org> <20021105212415.GB1472@vmware.com> <20021106082500.GA3680@vmware.com> <20021106214027.GA9711@think.thunk.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <20021106214027.GA9711@think.thunk.org>; from tytso@mit.edu on Wed, Nov 06, 2002 at 04:40:27PM -0500
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Nov 06, 2002 at 04:40:27PM -0500, Theodore Ts'o wrote:
> On Wed, Nov 06, 2002 at 12:25:00AM -0800, chrisl@vmware.com wrote:
> > This should fix the ext3 htree rename problem. Please try it again.
> 
> I've looked over the patch, and I've got some comments....
> 
> >         handle = ext3_journal_start(old_dir, 2 * EXT3_DATA_TRANS_BLOCKS +
> > -                                       EXT3_INDEX_EXTRA_TRANS_BLOCKS + 2);
> > +                                       EXT3_INDEX_EXTRA_TRANS_BLOCKS + 3);
> 
> There's no need to increase the number of blocks that might need to be
> dirtied; if ext3_delete_entry() can't find the missing entry, it won't
> dirty the block, so the number of blocks that might need to modified
> remains constant.

Even for the same block dirty twice? I am not sure about that case
so I put it there. I got a lots of thing to do tonight.

> 
> > -       ext3_delete_entry(handle, old_dir, old_de, old_bh);
> > +       retval = ext3_delete_entry(handle, old_dir, old_de, old_bh);
> > +       if (retval == -ENOENT) {
> > +               /*
> > +                * old_de can be moved during ext3_add_entry.
> > +                */
> > +               struct buffer_head * old_bh2;
> > +               struct ext3_dir_entry_2 * old_de2;
> > +               old_bh2 = ext3_find_entry (old_dentry, &old_de2);
> > +               if (old_bh2) {
> > +                       retval = ext3_delete_entry(handle, old_dir, old_de2,
> > +                                                  old_bh2);
> > +                       brelse(old_bh2);
> > +               } else {
> > +                       ext3_warning(old_dir->i_sb, "ext3_rename",
> > +                                    "Deleting old file not found (%lu), %d",
> > +                                    old_dir->i_ino, old_dir->i_nlink);
> > +               }
> >  
> > +       }
> 
> Simply retrying the ext3_delete_entry() isn't sufficient, since
> another ext3_add_entry() could move the directory entry again while
> you're reading in the blocks as part of ext3_find_entry().  OK, that
> would be pretty rare, since enough other directory adds would have
> to fill up enough that another split could happen, but *is* possible.
> (Surely our scheduler isn't that unfair....)

I think we have the lock on ext3_rename. I might be wrong.
If other process can change the dir between the add new entry
and delete old entry. We should also need to check the entry have
been delete from other process in case fall into dead loop? 

Too bad I don't have time to look at those until tonight.

> 
> Probably a better thing to do is use a while loop, and retry as long
> (a) ext3_delete_entry fails, and (b) old_dir->i_version has changed.
> In practice this will probably never happen, but I'll feel better with
> that change.
> 
> Anyway, I plan to make these two changes to your patch, and then
> submit it to Linus.

Do you have time to look at the missing "." and ".." entry patch?

Can you please change my email address in source file to vmware
if you submit it?

Thanks

Chris



