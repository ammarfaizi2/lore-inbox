Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751364AbWFOI1U@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751364AbWFOI1U (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 15 Jun 2006 04:27:20 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751373AbWFOI1T
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 15 Jun 2006 04:27:19 -0400
Received: from gw.openss7.com ([142.179.199.224]:18376 "EHLO gw.openss7.com")
	by vger.kernel.org with ESMTP id S1751364AbWFOI1T (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 15 Jun 2006 04:27:19 -0400
Date: Thu, 15 Jun 2006 02:27:15 -0600
From: "Brian F. G. Bidulock" <bidulock@openss7.org>
To: Theodore Tso <tytso@mit.edu>, linux-kernel@vger.kernel.org
Subject: Re: [RFC]  Slimming down struct inode
Message-ID: <20060615022715.A5168@openss7.org>
Reply-To: bidulock@openss7.org
Mail-Followup-To: Theodore Tso <tytso@mit.edu>,
	linux-kernel@vger.kernel.org
References: <E1Foqjw-00010e-Ln@candygram.thunk.org> <20060614181627.B28144@openss7.org> <20060615044302.GA7318@thunk.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
In-Reply-To: <20060615044302.GA7318@thunk.org>; from tytso@mit.edu on Thu, Jun 15, 2006 at 12:43:02AM -0400
Organization: http://www.openss7.org/
Dsn-Notification-To: <bidulock@openss7.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Theodore,

On Thu, 15 Jun 2006, Theodore Tso wrote:
> 
> I'm not particularly sympathetic to out of tree implementations,

I believe you asked for comments; not proposed to offer sympathy.

> especially one which is as (NOT!) likely to be merged as STREAMS
> support.  Out of tree patches can always patch struct inode to add all
> the bloat they want.

Bloat that nobody complained about for 10 years or so...  Sounds pretty
antagonistic to me.  Streams are pretty basic character devices.

> Also, it souinds like you're not usually using
> i_pipe as a true pointer to a struct pipe_inode_info, but rather as
> kludged location to stash your v_str pointer.

It points to a STREAMS-based FIFO which, of course, uses a Stream head
structure instead of a pipe_inode_info structure.  Is is used in the
same fashion as Linux FIFOs use the pointer: to attach information to
an inode in a foreign filesystem.  generic_ip and such does not help
here because they are already used by the foreign filesystem.

The cdev structure used to have a private pointer (cd_private) that
could be used to the same effect, but it disappeared some time ago when
char_device was reworked into cdev.  block_device still has a bd_private
pointer.  Merging i_pipe will remove the ability for a character
device driver to association a private pointer with the inode at open
to obtain FIFO-like behaviour (where the device is associated with the
specific inode rather than the device number), reducing the flexibility
of the Linux VFS.

i_pipe is not necessary for Unnamed FIFOs or pipes in Linux (those
inodes are allocated from the pipefs and could very well use the
generic_ip pointer.  i_pipe is only necessary for named FIFOs because
these are attached to inodes belonging to filesystems foreign to the
pipefs.  It is a slim special case of file on file mounting.  Regardless
of STREAMS I think that it deserves to be separate from i_cdev and
i_bdev.

All other basic character device mechanisms either allocate their own
inodes or hang their private data off of the open file pointer.  As
do STREAMS, which, aside from STREAMS-based FIFOs are basic character
devices.


> Why not just have your
> STREAMS implementation patch include/linux/fs.h to add a v_str pointer?

Because it does not patch the kernel but simply loads as a set of
GPL'ed kernel modules.
