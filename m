Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751482AbWFJKsg@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751482AbWFJKsg (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 10 Jun 2006 06:48:36 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751484AbWFJKsg
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 10 Jun 2006 06:48:36 -0400
Received: from linux01.gwdg.de ([134.76.13.21]:55172 "EHLO linux01.gwdg.de")
	by vger.kernel.org with ESMTP id S1751482AbWFJKsg (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 10 Jun 2006 06:48:36 -0400
Date: Sat, 10 Jun 2006 12:48:27 +0200 (MEST)
From: Jan Engelhardt <jengelh@linux01.gwdg.de>
To: "Theodore Ts'o" <tytso@mit.edu>
cc: linux-kernel@vger.kernel.org
Subject: Re: [RFC]  Slimming down struct inode
In-Reply-To: <E1Foqjw-00010e-Ln@candygram.thunk.org>
Message-ID: <Pine.LNX.4.61.0606101237020.23706@yvahk01.tjqt.qr>
References: <E1Foqjw-00010e-Ln@candygram.thunk.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


>1) Move i_blksize (optimal size for I/O, reported by the stat system
>   call).  Is there any reason why this needs to be per-inode, instead
>   of per-filesystem?
>
I do not know much about XFS's realtime feature, but from what I have read 
about it so far, it sounds to be a potential source where i_blksize might 
differ from the regular filesystem. A guess, though.


>3) Move i_pipe, i_bdev, and i_cdev into a union.  An inode cannot
>    simultaneously be a pipe, block device, and character device at the
>    same time.
>
Ah, finally this is being tackled. Let's recall Bernd's post:

  "Mabe a regular file inode atribute can be put in that union, too?"

which made me think about members in struct inode that are only useful for 
regular files. Is i_blkbits/i_blksize relevant for block special files? I 
doubt that, since (as you mentioned above) it is (=should be) a 
per-filesystem option, but block devices don't have to do anything with 
filesystems in this respect. IOW,

  struct ionde {
      ...
      union {
          struct regular_file {
              unsigned int i_blkbits;
              unsigned long i_blksize;
              ...
          };
          ...
          struct block_device *i_bdev;
          struct cdev *i_cdev;
      };
      ...
  };              

something like that. (Yes, i_blkbits/size should go into the sb, but maybe 
there are other regular-files-only members.)


>6) Separate out those elements which are only used if the inode is open
>   into a separate data structure (call it "struct inode_state" for
>   the sake of argument):
>
>	i_flock, i_mapping, i_data, i_dnotify_mask, i_dnotify,
>	inotify_watches, inotify_sem, i_state, dirtied_when,
>	i_size_seqcount, i_mutex, i_alloc_sem
>
>   This is the motherload.  Moving these fields out to a separate
>   structure which is only allocated for inodes which are open will save
>   a huge amount of memory.  But, of course, sweeping through all of the
>   code which uses these variables to move them would be a major code
>   change.  (We can do it initially with #define magic, but we will need
>   to audit the code paths to see if it's always to safe to assume that
>   inode is open before dereferencing the i_state pointer, or whether we
>   need to check to see if it is valid first.)
>
Maybe doing it one at a time.


How long is inotify going to remain around?


>#6 is going to be the hard one, since it will involving touching the
>largest amount of code.  But of course, the payoff will be quite big as
>well.  Of course, memory is pretty cheap these days, which is probably
>
Cheap is relative :)

>What do people think?  Is it worth putting together patches to do some
>or all of the above?


Jan Engelhardt
-- 
