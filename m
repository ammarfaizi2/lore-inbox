Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263857AbUDNCsc (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 13 Apr 2004 22:48:32 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263862AbUDNCsc
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 13 Apr 2004 22:48:32 -0400
Received: from fw.osdl.org ([65.172.181.6]:12958 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S263857AbUDNCs3 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 13 Apr 2004 22:48:29 -0400
Date: Tue, 13 Apr 2004 19:47:34 -0700
From: Andrew Morton <akpm@osdl.org>
To: Mingming Cao <cmm@us.ibm.com>
Cc: tytso@mit.edu, pbadari@us.ibm.com, linux-kernel@vger.kernel.org,
       ext2-devel@lists.sourceforge.net
Subject: Re: [PATCH 0/4] ext3 block reservation patch set
Message-Id: <20040413194734.3a08c80f.akpm@osdl.org>
In-Reply-To: <1081903949.3548.6837.camel@localhost.localdomain>
References: <200403190846.56955.pbadari@us.ibm.com>
	<20040321015746.14b3c0dc.akpm@osdl.org>
	<1080636930.3548.4549.camel@localhost.localdomain>
	<20040330014523.6a368a69.akpm@osdl.org>
	<1080956712.15980.6505.camel@localhost.localdomain>
	<20040402175049.20b10864.akpm@osdl.org>
	<1080959870.3548.6555.camel@localhost.localdomain>
	<20040402185007.7d41e1a2.akpm@osdl.org>
	<1081903949.3548.6837.camel@localhost.localdomain>
X-Mailer: Sylpheed version 0.9.7 (GTK+ 1.2.10; i386-redhat-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Mingming Cao <cmm@us.ibm.com> wrote:
>
> Here is a set of patches which implement the in-memory ext3 block
>  reservation (previously called reservation based ext3 preallocation). 

Great, thanks.  Let's get these in the pipeline.

A few thoughts, from a five-minute read:


- The majority of in-core inodes are not open for reading, and we've
  added 24 bytes to the inode just for inodes which are open for writing.

  At some stage we should stop aggregating struct reserve_window into the
  inode and dynamically allocate it.  We can move i_next_alloc_block,
  i_next_alloc_goal and possibly other fields in there too.

  At which point it has the wrong name ;) Should be `write_state' or
  something.

  It's not clear when we should free up the write_state.  I guess we
  could leave it around for the remaining lifetime of the inode - that'd
  still be a net win.

  Is this something you can look at as a low-priority activity?

- You're performing ext3_discard_reservation() in ext3_release_file(). 
  Note that the file may still have pending allocations at this stage: say,
  open a file, map it MAP_SHARED, dirty some pages which lie over file
  holes then close the file again.

  Later, the VM will come along and write those dirty pages into the
  file, at which point allocations need to be performed.  But we have no
  reservation data and, later, we may have no inode->write_state at all.

  What will happen?

- Have you tested and profiled this with a huge number of open files?  At
  what stage do we get into search complexity problems?

- Why do we discard the file's reservation on every iput()?  iput's are
  relatively common operations. (see fs/fs-writeback.c)

- What locking protects rsv_alloc_hit?  i_sem is not held during
  VM-initiated writeout.  Maybe an atomic_t there, or just say that if we
  race and the number is a bit inaccurate, we don't care?

