Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932419AbWE3TFa@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932419AbWE3TFa (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 30 May 2006 15:05:30 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932424AbWE3TF3
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 30 May 2006 15:05:29 -0400
Received: from a222036.upc-a.chello.nl ([62.163.222.36]:22176 "EHLO
	laptopd505.fenrus.org") by vger.kernel.org with ESMTP
	id S932419AbWE3TF2 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 30 May 2006 15:05:28 -0400
Subject: Re: 2.6.17-rc5-mm1
From: Arjan van de Ven <arjan@linux.intel.com>
To: Michal Piotrowski <michal.k.k.piotrowski@gmail.com>
Cc: sds@tycho.nsa.gov, jamesm@redhat.com, Andrew Morton <akpm@osdl.org>,
       Ingo Molnar <mingo@elte.hu>, linux-kernel@vger.kernel.org
In-Reply-To: <6bffcb0e0605301139l2b4895d0mbecffb422fb2c0cf@mail.gmail.com>
References: <20060530022925.8a67b613.akpm@osdl.org>
	 <6bffcb0e0605301139l2b4895d0mbecffb422fb2c0cf@mail.gmail.com>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Date: Tue, 30 May 2006 21:04:50 +0200
Message-Id: <1149015890.3636.92.camel@laptopd505.fenrus.org>
Mime-Version: 1.0
X-Mailer: Evolution 2.2.3 (2.2.3-2.fc4) 
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 2006-05-30 at 20:39 +0200, Michal Piotrowski wrote:
> Hi,
> 
> On 30/05/06, Andrew Morton <akpm@osdl.org> wrote:
> >
> > ftp://ftp.kernel.org/pub/linux/kernel/people/akpm/patches/2.6/2.6.17-rc5/2.6.17-rc5-mm1/
> >
> 
> I get this on 2.6.17-rc5-mm1 + hot fixes + Arjan's net/ipv4/igmp.c patch.
> 
> May 30 20:25:56 ltg01-fedora kernel:
> May 30 20:25:56 ltg01-fedora kernel:
> =====================================================
> May 30 20:25:56 ltg01-fedora kernel: [ BUG: possible circular locking
> deadlock detected! ]
> May 30 20:25:56 ltg01-fedora kernel:
> -----------------------------------------------------
> May 30 20:25:56 ltg01-fedora kernel: umount/2322 is trying to acquire lock:
> May 30 20:25:56 ltg01-fedora kernel:  (sb_security_lock){--..}, at:
> [<c01d6400>] selinux_sb_free_security+0x17/0x4e


ok so  selinux_complete_init() does
        spin_lock(&sb_security_lock);
next_sb:
        if (!list_empty(&superblock_security_head)) {
                struct superblock_security_struct *sbsec =
                                list_entry(superblock_security_head.next,
                                           struct superblock_security_struct,
                                           list);
                struct super_block *sb = sbsec->sb;
                spin_lock(&sb_lock);
                sb->s_count++;
                spin_unlock(&sb_lock);
                spin_unlock(&sb_security_lock);

nesting sb_lock inside sb_security_lock

while

put_super() takes the sb_lock, then calls __put_super() which calls 
selinux_sb_free_security which calls superblock_free_security() which takes sb_security_lock
which means the nesting is opposite.


textbook AB-BA deadlock
