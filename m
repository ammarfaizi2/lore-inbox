Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262554AbTCIRo2>; Sun, 9 Mar 2003 12:44:28 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262555AbTCIRo2>; Sun, 9 Mar 2003 12:44:28 -0500
Received: from mx12.arcor-online.net ([151.189.8.88]:49037 "EHLO
	mx12.arcor-online.net") by vger.kernel.org with ESMTP
	id <S262554AbTCIRo1>; Sun, 9 Mar 2003 12:44:27 -0500
Content-Type: text/plain; charset=US-ASCII
From: Daniel Phillips <phillips@arcor.de>
To: Alex Tomas <bzzz@tmi.comex.ru>
Subject: Re: [Bug 417] New: htree much slower than regular ext3
Date: Mon, 10 Mar 2003 18:58:16 +0100
X-Mailer: KMail [version 1.3.2]
Cc: Alex Tomas <bzzz@tmi.comex.ru>, "Martin J. Bligh" <mbligh@aracnet.com>,
       linux-kernel <linux-kernel@vger.kernel.org>,
       ext2-devel@lists.sourceforge.net, "Theodore Ts'o" <tytso@mit.edu>,
       Andrew Morton <akpm@digeo.com>
References: <11490000.1046367063@[10.10.2.4]> <20030307173425.5C4D3FAAAE@mx12.arcor-online.net> <m3r89hrp8t.fsf@lexa.home.net>
In-Reply-To: <m3r89hrp8t.fsf@lexa.home.net>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Message-Id: <20030309175353.B73FAFFE9A@mx12.arcor-online.net>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun 09 Mar 03 08:08, Alex Tomas wrote:
> >>>>> Daniel Phillips (DP) writes:
>
>  DP> On Fri 07 Mar 03 16:46, Alex Tomas wrote:
>  DP> The problem I see with your approach is that the traversal is no
>  DP> longer in hash order, so a leaf split in the middle of a
>  DP> directory traversal could result in a lot of duplicate dirents.
>  DP> I'm not sure there's a way around that.
>
> 1) As far as I understand, duplicates are possible even in classic ext2
>    w/o sortdir/index. See the diagram:
>
>                     Process 1                  Process 2
>
>                     getdents(2) returns
>                     dentry1 (file1 -> Inode1)
>                     dentry2 (file2 -> Inode2)
>
> context switch -->
>                                                unlink(file1), empty dentry1
>                                                creat(file3), Inode3, use
> dentry1 creat(file1), Inode1, use dentry3
>
> context switch -->
>
>                     getdents(2) returns
>                     dentry3(file1 -> Inode1)
>
>
> Am I right?
>
>
> 2) Why do not use hash order for traversal like ext3_dx_readdir() does?
>    Upon reading several dentries within some hash set readdir() sorts them
>    in inode order and returns to an user.
>
>
> with best regards, Alex

You're right, but you still don't win the stuffed poodle.

I put forth the same argument at last year's kernel workshop and was 
overruled on the grounds that, let me see:

  - Duplicates as a result of unlinks are one thing, duplicates as a
    result of creates are another, worse thing.

  - Creating one duplicate as a result of one unlink is one thing,
    creating lots of duplicates with one operation is another, worse
    thing.

  - The rules are written to allow this particular duplicate behavior
    in UFS (design inherited by Ext2/3) because at the time, UFS was
    the only game in town.

The phrase "broken by design" comes to mind.  Ted and Stephen would no doubt 
be happy to elaborate.  Anyway, there's another reason we need to return 
results in hash order, and that is telldir/seekdir, which expects a stable 
enumeration of a directory with no duplicates, even with concurrent 
operations going on, and even if the server is rebooted in the middle of a 
directory traversal.  Not just broken by design, but smashed to pieces by 
design.  And we still have to make it work, for some definition of "work".

Anyway,
