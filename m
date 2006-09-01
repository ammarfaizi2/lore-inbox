Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751497AbWIAMyH@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751497AbWIAMyH (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 1 Sep 2006 08:54:07 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751499AbWIAMyH
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 1 Sep 2006 08:54:07 -0400
Received: from mailer.gwdg.de ([134.76.10.26]:39592 "EHLO mailer.gwdg.de")
	by vger.kernel.org with ESMTP id S1751494AbWIAMyD (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 1 Sep 2006 08:54:03 -0400
Date: Fri, 1 Sep 2006 14:50:10 +0200 (MEST)
From: Jan Engelhardt <jengelh@linux01.gwdg.de>
To: Josef Sipek <jsipek@cs.sunysb.edu>
cc: linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org,
       hch@infradead.org, akpm@osdl.org, viro@ftp.linux.org.uk
Subject: Re: [PATCH 04/22][RFC] Unionfs: Common file operations
In-Reply-To: <20060901014138.GE5788@fsl.cs.sunysb.edu>
Message-ID: <Pine.LNX.4.61.0609011445580.15283@yvahk01.tjqt.qr>
References: <20060901013512.GA5788@fsl.cs.sunysb.edu> <20060901014138.GE5788@fsl.cs.sunysb.edu>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
X-Spam-Report: Content analysis: 0.0 points, 6.0 required
	_SUMMARY_
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


>+	if (!d_deleted(dentry) &&
>+	    ((sbgen > fgen) || (dbstart(dentry) != fbstart(file)))) {

(sbgen > fgen || dbstart(dentry) != fbstart(file)) should suffice. (Read:
reduce the amount of "()" depth.)

>+int unionfs_file_release(struct inode *inode, struct file *file)
>+{
>+	int err = 0;
>+	struct file *hidden_file = NULL;
>+	int bindex, bstart, bend;
>+	int fgen;
>+
>+	/* fput all the hidden files */
>+	fgen = atomic_read(&ftopd(file)->ufi_generation);
>+	bstart = fbstart(file);
>+	bend = fbend(file);
>+
>+	for (bindex = bstart; bindex <= bend; bindex++) {
>+		hidden_file = ftohf_index(file, bindex);
>+
>+		if (hidden_file) {
>+			fput(hidden_file);
>+			unionfs_read_lock(inode->i_sb);
>+			branchput(inode->i_sb, bindex);
>+			unionfs_read_unlock(inode->i_sb);
>+		}
>+	}
>+	kfree(ftohf_ptr(file));
>+
>+	if (ftopd(file)->rdstate) {
>+		ftopd(file)->rdstate->uds_access = jiffies;
>+		printk(KERN_DEBUG "Saving rdstate with cookie %u [%d.%lld]\n",
>+		       ftopd(file)->rdstate->uds_cookie,
>+		       ftopd(file)->rdstate->uds_bindex,
>+		       (long long)ftopd(file)->rdstate->uds_dirpos);
>+		spin_lock(&itopd(inode)->uii_rdlock);
>+		itopd(inode)->uii_rdcount++;
>+		list_add_tail(&ftopd(file)->rdstate->uds_cache,
>+			      &itopd(inode)->uii_readdircache);
>+		mark_inode_dirty(inode);
>+		spin_unlock(&itopd(inode)->uii_rdlock);
>+		ftopd(file)->rdstate = NULL;
>+	}
>+	kfree(ftopd(file));
>+	return err;
>+}

"err" is unused in this function. Rid it.

>+			}
>+		}
>+
>+	}



Jan Engelhardt
-- 
