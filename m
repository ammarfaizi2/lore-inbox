Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S279382AbRKGKBr>; Wed, 7 Nov 2001 05:01:47 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S279556AbRKGKBh>; Wed, 7 Nov 2001 05:01:37 -0500
Received: from atlas.inria.fr ([138.96.66.22]:18181 "HELO atlas.inria.fr")
	by vger.kernel.org with ESMTP id <S279382AbRKGKBS>;
	Wed, 7 Nov 2001 05:01:18 -0500
Message-Id: <20011107100127Z279382-17408+11789@vger.kernel.org>
From: <Nicolas.Turro@sophia.inria.fr>
To: unlisted-recipients:; (no To-header on input)@localhost.localdomain
Date: Wed, 7 Nov 2001 05:01:18 -0500
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi.
Hi.
i upgrade from 2.2.18 to 2.2.20 today and could not apply a patch that
increases the maximum number of symbolic link to follow during a lookup.

We used to change the 5 in  :
        if ((follow & LOOKUP_FOLLOW)
            && inode && inode->i_op && inode->i_op->follow_link) {
                if (current->link_count <= 5) {
                        struct dentry * result;
                       current->link_count++;
                        /* This eats the base */
                        result = inode->i_op->follow_link(dentry, base, follow);
                        current->link_count--;
                        dput(dentry);
                        return result;

by 20.

But now, in 2.2.20 the code is :

        if ((follow & LOOKUP_FOLLOW)
            && inode && inode->i_op && inode->i_op->follow_link) {
                if (current->link_count < 25) {
                        struct dentry * result;
                        if (current->need_resched) {
                                current->state = TASK_RUNNING;
                                schedule();
                        }
                        /* This eats the base */
                        result = inode->i_op->follow_link(dentry, base, follow|LOOKUP_INSYMLINK);
                        current->link_count -= 4;
                        dput(dentry);
                        return result;

And i must admit i am not sure that changing the 25 into 100 will do the
same...
I don't understand the comment :
/*
 * Yes, this really increments the link_count by 5, and
 * decrements it by 4. Together with checking against 25,
 * this limits recursive symlink follows to 5, while
 * limiting consecutive symlinks to 25.
 *
 * Without that kind of total limit, nasty chains of consecutive
 * symlinks can cause almost arbitrarily long lookups.
 */

what is the difference between recursive symlink  and consecutive symlinks ?

Can someone explain me on an exemple ?
 
N. Turro

