Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S266969AbRGMInP>; Fri, 13 Jul 2001 04:43:15 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S266970AbRGMInG>; Fri, 13 Jul 2001 04:43:06 -0400
Received: from horus.its.uow.edu.au ([130.130.68.25]:46049 "EHLO
	horus.its.uow.edu.au") by vger.kernel.org with ESMTP
	id <S266969AbRGMImz>; Fri, 13 Jul 2001 04:42:55 -0400
Message-ID: <3B4EB493.DC805F45@uow.edu.au>
Date: Fri, 13 Jul 2001 18:42:59 +1000
From: Andrew Morton <andrewm@uow.edu.au>
X-Mailer: Mozilla 4.76 [en] (X11; U; Linux 2.4.6 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: malfet@gw.mipt.sw.ru
CC: linux-kernel@vger.kernel.org
Subject: Re: Question about ext2
In-Reply-To: <20010713120840.A9431@srv.mipt.sw.ru>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

malfet@gw.mipt.sw.ru wrote:
> 
> Hi all!
> I look up in implementation in ext2_rename and see the following statment:
>        if (S_ISDIR(old_inode->i_mode)) {
>                 if (new_inode) {
>                         retval = -ENOTEMPTY;
>                         if (!empty_dir (new_inode))
>                                 goto end_rename;
>                 }
> But I don't see any checkl like S_ISDIR on new_inode neither in
> ext2_rename neither in empty_dir. Is this bug? And, anyway, can
> I rename directory into not-empty file?

It's implicit - rename can only rename files to files, and
directories to directories.  So the check is made at a higher
level.  Consequently when we get to ext2_rename, if we find
that the old inode is a directory, we *know* that the new
one is a directory as well.

I recently spent an hour decrypting this function.  Here is
a commented version which may prove helpful. It is from a
non-mainline branch of ext3, but it's much the same.


static int ext3_rename (struct inode * old_dir, struct dentry *old_dentry,
			   struct inode * new_dir,struct dentry *new_dentry)
{
	handle_t *handle;

	/* old_inode is the thing we're renaming */
	struct inode * old_inode = old_dentry->d_inode;

	/* new_inode is what we're renaming it to (may be NULL) */
	struct inode * new_inode = new_dentry->d_inode;

	/* dir_bh is the buffer which contains old_inode's ".." entry */
	struct buffer_head * dir_bh = NULL;

	/* dir_de is the old_inode's ".." de.  Points into dir_bh->b_data */
	struct ext3_dir_entry_2 * dir_de = NULL;

	/* old_bh contains the old entry's de */
	struct buffer_head * old_bh;

	/* old_de points to the old entry's de, inside old_bh->b_data */
	struct ext3_dir_entry_2 * old_de;
	int err = -ENOENT;

	old_bh = NULL;

	handle = ext3_journal_start(old_dir, 2 * EXT3_DATA_TRANS_BLOCKS + 2);
	if (IS_ERR(handle))
		return PTR_ERR(handle);

	/* Find the current directory entry's bh and de */
	old_bh = ext3_find_entry (old_dentry, &old_de);
	if (!old_bh)
		goto end_rename;

	if (S_ISDIR(old_inode->i_mode)) {
		/*
		 * If the thing we're renaming is a directory, we'll need to
		 * change its ".." to point to a different parent.  Go find
		 * the ".." directory entry
		 */
		err = -EIO;
		dir_de = ext3_dotdot(handle, old_inode, &dir_bh);
		if (!dir_de)
			goto end_rename;
	}

	if (new_inode) {
		/* We're overwriting another object */
		struct buffer_head * new_bh;
		struct ext3_dir_entry_2 * new_de;

		/* If the renamee is a dir, then the victim MUST be a dir.
		 * It must not have any entries */
		err = -ENOTEMPTY;
		if (dir_de && !empty_dir (new_inode))
			goto out_dir;

		/* Go find the buffer and de for the victim */
		err = -ENOENT;
		new_bh = ext3_find_entry (new_dentry, &new_de);
		if (!new_bh)
			goto out_dir;

		/* Temporarily bump the renamee's link count.  Dunno why */
		ext3_inc_count(handle, old_inode);

		/* Overwrite the victim's directory info */
		ext3_set_link(handle, new_dir, new_de, new_bh, old_inode);
		new_inode->i_ctime = CURRENT_TIME;

		/* If renamee is a dir then the victim is a dir.  Drop nlink
		 * to account for the "." entry */
		if (dir_de)
			new_inode->i_nlink--;

		/* victim loses a refcount.  If it is a dir, it will be
		 * removed altogether, in do_rename->dput->iput */
		ext3_dec_count(handle, new_inode);

		/* Add an orphan record into this transaction.  If the victim
		 * dir is huge, iput's truncate may cross multiple transactions.
		 * We remove the orphan record inside the transaction which
		 * actually releases the inode */
		if (!new_inode->i_nlink)
			ext3_orphan_add(handle, new_inode);
	} else {
		/* The new name is not currently used */
		if (dir_de) {
			/* Moving a directory will add an extra ref to its
			 * parent because of the ".." entry */
			err = -EMLINK;
			if (new_dir->i_nlink >= EXT3_LINK_MAX)
				goto out_dir;
		}

		/* Temporarily bump the renamee's link count.  Dunno why */
		ext3_inc_count(handle, old_inode);

		/* Add the renamee to its new directory */
		err = ext3_add_entry (handle, new_dentry, old_inode);
		if (err) {
			ext3_dec_count(handle, old_inode);
			goto out_dir;
		}

		/* If we just moved a directory, parent gets another ref for
		 * ".." */
		if (dir_de)
			ext3_inc_count(handle, new_dir);
	}

	/* Remove the renamee's old directory entry */
	ext3_delete_entry(handle, old_dir, old_de, old_bh);
	old_dir->i_ctime = old_dir->i_mtime = CURRENT_TIME;
	ext3_mark_inode_dirty(handle, old_dir);
	brelse (old_bh);
	old_inode->i_ctime = CURRENT_TIME;

	/* Drop the temp refcount.  Also marks the renamee's inode dirty */
	ext3_dec_count(handle, old_inode);

	if (dir_bh) {
		/* We moved a directory.  Make its ".." entry point to the new
		 * parent */
		ext3_set_link(handle, old_inode, dir_de, dir_bh, new_dir);

		/* The old parent no longer has the renamee's ".." pointing
		 * to it */
		ext3_dec_count(handle, old_dir);
	}

	ext3_journal_stop(handle, old_dir);
	return 0;

out_dir:
	brelse (dir_bh);
end_rename:
	brelse (old_bh);
	ext3_journal_stop(handle, old_dir);
	return err;
}
