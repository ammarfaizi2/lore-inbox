Return-Path: <linux-kernel-owner+willy=40w.ods.org-S264756AbUEKOKh@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264756AbUEKOKh (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 11 May 2004 10:10:37 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264759AbUEKOKg
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 11 May 2004 10:10:36 -0400
Received: from DELFT.AURA.CS.CMU.EDU ([128.2.206.88]:65445 "EHLO
	delft.aura.cs.cmu.edu") by vger.kernel.org with ESMTP
	id S264756AbUEKOJB (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 11 May 2004 10:09:01 -0400
Date: Tue, 11 May 2004 10:08:53 -0400
To: =?iso-8859-1?Q?J=F6rn?= Engel <joern@wohnheim.fh-wedel.de>
Cc: Steve French <smfltc@us.ibm.com>, linux-kernel@vger.kernel.org
Subject: Re: [ANNOUNCEMENT PATCH COW] proof of concept impementation of cowlinks
Message-ID: <20040511140853.GT24211@delft.aura.cs.cmu.edu>
Mail-Followup-To: =?iso-8859-1?Q?J=F6rn?= Engel <joern@wohnheim.fh-wedel.de>,
	Steve French <smfltc@us.ibm.com>, linux-kernel@vger.kernel.org
References: <20040506131731.GA7930@wohnheim.fh-wedel.de> <20040508224835.GE29255@atrey.karlin.mff.cuni.cz> <20040510155359.GB16182@wohnheim.fh-wedel.de> <20040510192601.GA11362@delft.aura.cs.cmu.edu> <20040511100232.GA31673@wohnheim.fh-wedel.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20040511100232.GA31673@wohnheim.fh-wedel.de>
User-Agent: Mutt/1.5.5.1+cvs20040105i
From: Jan Harkes <jaharkes@cs.cmu.edu>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, May 11, 2004 at 12:02:32PM +0200, Jörn Engel wrote:
> > Copyfile can trivially be implemented in libc. I don't see why it would
> > have to be a system call. If a network filesystem wants to optimize the
> > file copying it could do this based on the sendfile data. If source and
> > destination are within the same filesystem and we're copying the whole
> > file starting at offset 0, send a copyfile RPC.
> 
> Can you explain this to Steve?  I'm still quite clueless about network
> filesystems, but it sounded as if such an optimization was impossible
> to do in cifs without a combined create/copy/unlink_on_error system
> call.
> 
> If your suggestion works and the network filesystems can be changed to
> work independently of a struct file*, I agree with you that copyfile()
> is a stupid idea and should be forgotten.

I would probably do it by overriding the file_operations.sendfile
function. A first approximation of a possible implementation follows. I
went a bit crazy on the comments. The only problem is that the type of
target is unknown, block/loop.c and nfsd/vfs.c are using sendfile to
to send to something that is not a struct file.

Jan

int my_file_sendfile(struct file *in_file, loff_t *ppos, size_t count,
		     read_actor_t actor, void __user *target)
{
    struct file *out_file = NULL;

    /* We have to check the read_actor callback function to see if the
     * target actually points at a struct file. */
    if (actor != file_send_actor)
	goto copy_local;

    /* are both source and destination within the same file system
     * mountpoint? */
    if (in_file->f_dentry->d_inode->i_sb != out_file->f_dentry->d_inode->i_sb)
	goto copy_local;

    /* are we copying the entire source file? */
    if (*ppos != 0 || count != in_file->f_dentry->d_inode->i_size)
	goto copy_local;

    /* and are we at least overwriting the complete destination file?
       (alternatively we could check that the out_file is currently empty) */
    if (out_file->f_pos != 0 || out_file->f_dentry->d_inode->i_size > count)
	goto copy_local;

    /* we are in luck and can send a copyfile rpc */
    int err = make_copyfile_rpc(in_file, out_file);

    /* we probably should force a refresh of out_file as it changed on
     * the server and not locally */
    MY_I(out_file->f_dentry->d_inode)->time = 0;
    return err;

copy_local:
    /* no luck, we're sending to something that isn't a file or in the
     * same filesystem, or we only copy a partial file. any case, we
     * have to perform the copy locally. */
    return generic_file_sendfile(in_file, ppos, count, actor, target);
}

