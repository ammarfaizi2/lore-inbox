Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751475AbWF1Rgq@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751475AbWF1Rgq (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 28 Jun 2006 13:36:46 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751493AbWF1Rgq
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 28 Jun 2006 13:36:46 -0400
Received: from py-out-1112.google.com ([64.233.166.183]:47336 "EHLO
	py-out-1112.google.com") by vger.kernel.org with ESMTP
	id S1751475AbWF1Rgp (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 28 Jun 2006 13:36:45 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=AQ+MHlIm8VyLooqzhLcorptvZ6+SyO7KUqmzJ1idY3vEQ7uL8IpC8KzbRvZ3sTestFjgtSLZzZ9tg0N/mlnNVnE5/kirVOAt597p3rI+a9i9cXTe/sS58pMn9IfnvVtFXsZga3sOzCguNxxqsE+Fk89n8Flc0S4w4rFt0fRBBhI=
Message-ID: <9e4733910606281036k53956aaev3d323fbb7a2cb7a9@mail.gmail.com>
Date: Wed, 28 Jun 2006 13:36:43 -0400
From: "Jon Smirl" <jonsmirl@gmail.com>
To: "Alan Cox" <alan@lxorguk.ukuu.org.uk>
Subject: Re: tty_mutex and tty_old_pgrp
Cc: "Paul Fulghum" <paulkf@microgate.com>, lkml <linux-kernel@vger.kernel.org>,
       "Theodore Ts'o" <tytso@mit.edu>
In-Reply-To: <1151490240.15166.5.camel@localhost.localdomain>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
References: <9e4733910606261538i584e2203o9555d77094de6fe7@mail.gmail.com>
	 <44A1B79F.9020204@microgate.com>
	 <9e4733910606272029r32255d27we6e8b34a4c2e569@mail.gmail.com>
	 <1151490240.15166.5.camel@localhost.localdomain>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This selinux code is checking to see if the current process still has
access rights to it's controlling tty, right? If it doesn't tty and
tty_old_pgrp are nulled out. Does this need locking? Can you
disassociate a task like this by nulling out tty, what about the child
tasks in the session if it is the leader?

security/selinux/hooks.c

/* Derived from fs/exec.c:flush_old_files. */
static inline void flush_unauthorized_files(struct files_struct * files)
{
        struct avc_audit_data ad;
        struct file *file, *devnull = NULL;
        struct tty_struct *tty = current->signal->tty;
        struct fdtable *fdt;
        long j = -1;

        if (tty) {
                file_list_lock();
                file = list_entry(tty->tty_files.next, typeof(*file),
f_u.fu_list);
                if (file) {
                        /* Revalidate access to controlling tty.
                           Use inode_has_perm on the tty inode directly rather
                           than using file_has_perm, as this particular open
                           file may belong to another process and we are only
                           interested in the inode-based check here. */
                        struct inode *inode = file->f_dentry->d_inode;
                        if (inode_has_perm(current, inode,
                                           FILE__READ | FILE__WRITE, NULL)) {
                                /* Reset controlling tty. */
                                current->signal->tty = NULL;
                                current->signal->tty_old_pgrp = 0;
                        }
                }
                file_list_unlock();
        }



-- 
Jon Smirl
jonsmirl@gmail.com
