Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S284736AbRLPRkb>; Sun, 16 Dec 2001 12:40:31 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S284737AbRLPRkW>; Sun, 16 Dec 2001 12:40:22 -0500
Received: from dsl081-242-114.sfo1.dsl.speakeasy.net ([64.81.242.114]:130 "EHLO
	drscience.sciencething.org") by vger.kernel.org with ESMTP
	id <S284736AbRLPRkP>; Sun, 16 Dec 2001 12:40:15 -0500
From: "Britt Park" <britt@drscience.sciencething.org>
To: <linux-kernel@vger.kernel.org>
Subject: Correct rmdir behavior
Date: Sun, 16 Dec 2001 09:41:53 -0800
Message-ID: <NFBBJPODOLDHKMANGFPGAECNCAAA.britt@sciencething.org>
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
X-Priority: 3 (Normal)
X-MSMail-Priority: Normal
X-Mailer: Microsoft Outlook IMO, Build 9.0.2416 (9.0.2910.0)
X-MimeOLE: Produced By Microsoft MimeOLE V5.00.2615.200
Importance: Normal
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I'm in the process of revivifying a user space filesystem I wrote for
2.0 kernels several years ago.  I have a simple pass through
filesystem basically working.  However, if I run a busy loop such as

while true
do
    ls -l >/dev/null
done

in a directory within the filesystem and then do a rmdir on that
directory, strange behavior follows.  The directory is indeed removed.
I can then create a new directory with the same name as the deleted
directory, but if I then try to create any files or directories within
the new directory I fail.  VFS traffic shows that lookups are made for
the files or directories I try to create but no create or mkdir calls.
It appears that some artifacts are left either in the inode cache or
the dentry cache.  I'm not sure, but I believe that the problem lies in
my inode_operations::rmdir function which I list below.  If I insert a

if (!d_unhashed(entry))
{
    return -EBUSY;
}

into the code, as coda does, I am forbidden from deleting a directory
in which processes are active.  Any clues as to how to handle rmdir so
that I get ext2 behavior?  TIA for any help.

Britt

int uvfs_rmdir(struct inode* dir, struct dentry* entry)
{
    int i;
    int slot;
    int error = 0;
    uvfs_rmdir_req_s* request;
    uvfs_rmdir_rep_s* reply;
    
    spin_lock(&Uvfs_lock);
    /* Grabs a communications slot. */
    slot = uvfs_find_accepting_slot();
    if (slot < 0)
    {
        spin_unlock(&Uvfs_lock);
        return slot;
    }
    
    request = &Uvfs_slots[slot].request.rmdir;
    request->type = UVFS_RMDIR;
    request->slot = slot;
    request->size = sizeof(*request);
    request->dir_inode = dir->i_ino;
    memcpy(request->name, entry->d_name.name, entry->d_name.len);
    request->namelen = entry->d_name.len;
    
    wake_up_interruptible(&Uvfs_slots[slot].driver_queue);
    /* This is just an unrolled version of interruptible_sleep_on */
    safe_sleep_on(&Uvfs_slots[slot].fs_queue, &Uvfs_lock);
    
    if (signal_pending(current))
    {
        error = -ERESTARTSYS;
        goto out;
    }

    reply = &Uvfs_slots[slot].reply.rmdir;
    error = reply->error;
    if (error == 0)
    {
        entry->d_inode->i_nlink = 0;
        d_drop(entry);
    }
out:
    /* Releases communication slot */
    uvfs_empty_slot(slot);
    spin_unlock(&Uvfs_lock);
    dprintk("<1>Exited uvfs_rmdir. %d\n", error);
    return error;
}

