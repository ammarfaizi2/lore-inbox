Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S279805AbRJ0LPb>; Sat, 27 Oct 2001 07:15:31 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S279806AbRJ0LPV>; Sat, 27 Oct 2001 07:15:21 -0400
Received: from rockover.demon.co.uk ([158.152.81.109]:9988 "HELO
	rockover.demon.co.uk") by vger.kernel.org with SMTP
	id <S279805AbRJ0LPQ>; Sat, 27 Oct 2001 07:15:16 -0400
Date: Sat, 27 Oct 2001 12:15:47 +0100 (BST)
From: Mike Fleetwood <mike@rockover.demon.co.uk>
To: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: crontab -e scuppered by non-updated mtime.  fstat64() lied!
In-Reply-To: <Pine.LNX.4.33.0108150035360.1427-100000@rockover.demon.co.uk>
Message-ID: <Pine.LNX.4.33.0110271116550.1069-100000@rockover.demon.co.uk>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This message is to thank Dr. Horst H. von Brand and to act as an 
explanation:

Over 2 month ago I questioned fstat64() and whether st_mtime was being 
updated correctly after using crontab -e reported no changes made.
Dr. Horst H. von Brand sent me the following explanation:
> Some editors (e.g. emacs, vi) go to lengths to ensure the "new" file
> is the same inode as the "old" one. Others (jed) don't. Has screwed me
> more than once...

This was exactly the problem I was having.  I had all the evidence I
needed but I couldn't see it.  The details were as follows:
  1)  Crontab -e command created a temporary file called
      /tmp/crontab.812, and with the open file handle called fstat64()
      to get the mtime.
  2)  Crontab ran Vim on the temporary file and I edited the file and
      saved it.
      Unknown to me Vim (6.0z BETA) had replaced the /tmp/crontab.812
      file with a new one of the same name.  The stat /tmp/crontab.812
      commands I ran did show that the inode had changed but I didn't
      notice it.
  3)  Crontab then called fstat64() on its original open file handle
      to the now deleted file.  Since Vim did not edit this file its
      mtime had not changed, hence crontab reported no changes made. 
      (When a file is deleted the directory entry is removed and
      the inode link count is reduced by 1.  When the link count
      reaches 0 the file is removed, but not before all open file
      handles are closed).

Thanks,
Mike


On Wed, 15 Aug 2001, Mike Fleetwood wrote:

> Hello all,
> 
> I have found an unexpected behaviour of fstat64() I hope someone here
> can explain.  I used crontab -e but after making a change I got the
> following error:
>     crontab: no changes made to crontab.
> 
> The crontab process calls fstat() just before handing a temporary file
> to your favourite editor and just after.  It compares the st_mtime
> value to see it you made a change and updates your crontab if required.
> The problem is I did make a change but crontab didn't see one.  I did
> the following:
> 
>     strace -v crontab -e 2> /tmp/crontab.strace
>     ^Z  (Suspended Vim)
>     stat /tmp/crontab.812
>     fg
>     (Made a change and wrote the file)
>     ^Z
>     stat /tmp/crontab.812   (mtime had been updated)
>     fg
>     (Quit Vim)
>     crontab: no changes made to crontab.
> 
> 
> The strace file showed that fstat64() returned exactly the same data
> before and after, seeing no change!
> 
> fstat64() now becomes inconsistent, if I change my editor to the
> following shell script (/tmp/edit):
> 
>     sleep 2
>     echo "# edit $$ was here!" >> "$1"
> 
> and run it with:
> 
>     EDITOR=/tmp/edit strace -v crontab -e 2> /tmp/crontab.strace-2
> 
> 
> everything works as expected.  The strace file showed that fstat64()
> reported different mtimes and crontab did its job as expected.
> 
> I got the same results with kernel 2.4.8 and RedHat patched 2.4.3-12.
> All file-systems are ext2.
> 
> Can anybody else reproduce this behaviour?
> It something broken?
> 
> Mike
> 
> 

