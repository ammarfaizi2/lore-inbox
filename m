Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S285388AbRLNPHN>; Fri, 14 Dec 2001 10:07:13 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S285390AbRLNPHD>; Fri, 14 Dec 2001 10:07:03 -0500
Received: from w240.z209220232.was-dc.dsl.cnc.net ([209.220.232.240]:18188
	"EHLO yendi.dmeyer.net") by vger.kernel.org with ESMTP
	id <S285391AbRLNPGr>; Fri, 14 Dec 2001 10:06:47 -0500
Date: Fri, 14 Dec 2001 10:06:38 -0500
From: dmeyer@dmeyer.net
To: linux-kernel@vger.kernel.org
Subject: Re: reiser4 (was Re: [PATCH] Revised extended attributes  interface)
Message-ID: <20011214100638.A7268@jhereg.dmeyer.net>
Reply-To: dmeyer@dmeyer.net
In-Reply-To: <20011214051604.723C52B54A@marcus.pants.nu> <3C19DE41.6000507@namesys.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
X-Newsgroups: local.linux.kernel
In-Reply-To: <3C19DE41.6000507@namesys.com>
Organization: dmeyer.net
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

In article <3C19DE41.6000507@namesys.com> you write:
> Brad Boyer wrote:
> >In particular, the files in the snapshot keep
> >the same inode number as the actual file. Just remember that clever
> >solutions that almost fit the traditional model can have strange
> >results over time.
> 
> Can you detail the problem?

Anything that uses something like file1.st_dev==file2.st_dev &&
file1.st_ino==file2.st_ino to decide if two filenames point to the
same file can get terribly confused.  For example,

$ ls -li .snapshot/hourly.0/.zshrc .zshrc
1411878 -rw-r--r--    1     1247 Mar 19  2001 .snapshot/hourly.0/.zshrc
1411878 -rw-r--r--    1     1248 Dec 14 09:51 .zshrc

Clearly, the file has been modified since the hourly.0 snapshot; however

$ cp .snapshot/hourly.0/.zshrc .zshrc
cp: `.snapshot/hourly.0/.zshrc' and `.zshrc' are the same file

you can't copy the snapshot on top of the current version, since they
have the same inode number.  A somewhat contrived example, perhaps,
but I have been bitten by something similar in the real world.  One of
the things I would like to be able to do with a snapshot is to open a
file in emacs, open a snapshot in another window, and compare the two
files with ediff.  And you can't; emacs treats the original and the
snapshot as if they were the same file - just like cp does - even
though the file contents are different.

-- 
Dave Meyer
dmeyer@dmeyer.net
