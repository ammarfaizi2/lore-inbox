Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S285516AbSBLPzb>; Tue, 12 Feb 2002 10:55:31 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S287552AbSBLPzW>; Tue, 12 Feb 2002 10:55:22 -0500
Received: from taifun.devconsult.de ([212.15.193.29]:48905 "EHLO
	taifun.devconsult.de") by vger.kernel.org with ESMTP
	id <S287373AbSBLPzH>; Tue, 12 Feb 2002 10:55:07 -0500
Date: Tue, 12 Feb 2002 16:55:04 +0100
From: Andreas Ferber <aferber@techfak.uni-bielefeld.de>
To: linux-kernel@vger.kernel.org
Cc: Matt Gauthier <elleron@yahoo.com>
Subject: Re: secure erasure of files?
Message-ID: <20020212165504.A5915@devcon.net>
Mail-Followup-To: linux-kernel@vger.kernel.org,
	Matt Gauthier <elleron@yahoo.com>
In-Reply-To: <Pine.LNX.4.30.0202121409150.18597-100000@mustard.heime.net> <Pine.LNX.4.33.0202121438560.7616-100000@unicef.org.yu>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
In-Reply-To: <Pine.LNX.4.33.0202121438560.7616-100000@unicef.org.yu>; from zdavid@unicef.org.yu on Tue, Feb 12, 2002 at 02:41:19PM +0100
Organization: dev/consulting GmbH
X-NCC-RegID: de.devcon
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Feb 12, 2002 at 02:41:19PM +0100, Davidovac Zoran wrote:

(srm maintainer cc'ed)

> there is srm (secure rm) somewhere on the net
> here srm.sourceforge.net
> srm - secure file deletion for posix systems

Broken as designed, it simply /can't/ work reliably (not to mention
the other comments that you can even recover data overwritten multiple
times).

Nothing stops the kernel (or the filesystem for that matter) from
shuffling around disk blocks while you are overwriting the file. You
may end up overwriting other disk blocks than the data you want to
hide lives in if the filesystem decides that your file may fit better
into other blocks, which leaves the original data completely intact.

I don't know if any filesystem currently relocates blocks if you
overwrite a file, but it's certainly possible and allowed (everything
else except the filesystem itself simply must not care where the data
actually ends up on the disk).

In addition to the design breakage, the current implementation of srm
is simply crap. Here is the part actually overwriting the file:

---------- snip ----------
  int i = 0;

  lseek(file, 0, SEEK_SET);
  while (i < file_size - buffsize)
    i += write(file, buffer, buffsize);
  write(file, buffer, file_size - i);
---------- snip ----------

Guess what happens if you try to srm a file longer than INT_MAX bytes?
And what if write() returns an error? Ghee, overwriting the file
backwards from the beginning, until infinity? Impressive...

Ah, and look at rename_unlink(): it tries to "overwrite" the
original filename with random characters. It does this by generating a
new 14 character random filename and rename()ing the file to that name
(keeping it in the same directory). Well, for example on plain stupid
(no pun ;-) ext2fs there are /many/ situations where the new directory
entry ends up in a totally different place than the old one (e.g. a
filename shorter than 14 characters if there is no free space around
the old direntry).

Well, enough for now...

Andreas
-- 
       Andreas Ferber - dev/consulting GmbH - Bielefeld, FRG
     ---------------------------------------------------------
         +49 521 1365800 - af@devcon.net - www.devcon.net
