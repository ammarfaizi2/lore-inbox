Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S285338AbSAUM1I>; Mon, 21 Jan 2002 07:27:08 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S285352AbSAUM07>; Mon, 21 Jan 2002 07:26:59 -0500
Received: from 89dyn20.com21.casema.net ([62.234.20.20]:19109 "EHLO
	abraracourcix.bitwizard.nl") by vger.kernel.org with ESMTP
	id <S285338AbSAUM0p>; Mon, 21 Jan 2002 07:26:45 -0500
Message-Id: <200201211226.NAA23145@cave.bitwizard.nl>
Subject: Re: ls command is slow..... (reiserfs, VM)?
In-Reply-To: <15436.4720.895209.146124@laputa.namesys.com> from Nikita Danilov
 at "Jan 21, 2002 04:06:56 pm"
To: Nikita Danilov <Nikita@Namesys.COM>
Date: Mon, 21 Jan 2002 13:26:30 +0100 (MET)
CC: Rogier Wolff <R.E.Wolff@BitWizard.nl>,
        Linux kernel mailing list <linux-kernel@vger.kernel.org>,
        Reiserfs mail-list <Reiserfs-List@Namesys.COM>
From: R.E.Wolff@BitWizard.nl (Rogier Wolff)
X-Mailer: ELM [version 2.4ME+ PL60 (25)]
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Nikita Danilov wrote:
> Rogier Wolff writes:
>  > 
>  > Hi,
>  > 
>  > the "ls" command is horribly slow on my system....
>  > 
>  > I'm doing some stuff with large files. From the old days when files
>  > couldn't be larger than 2G, I'm manipulating 1G files.
>  > 
>  > There is currently a program runnning that will make a file sparse if
>  > it finds only zeroes in a block. It's reading between 20 and 30Mb per
>  > second off the disks, and currently finding only zeros, so there is no
>  > writing going on.
> 
> Reiserfs puts on-disk inode (stat-data) near file "body" which is an
> array of pointers to actual blocks of the file. This optimizes the case
> of short files, because inode and file "body" can be read in one io. But
> when there are many large files in the same directory, this results in
> inodes of the files from the same directory being far from each other on
> the disk, making readdir() or sequential stat() slower. Reiser4 uses
> (will use, that is) different allocation policy that tries to address
> this.

OK. so the layout on the disk is non-optimal. 

But I'd expect performance on the order of: 

	
times 
in ms

0	my first stat finishes
0.1	the other program has already issued a 1Mb read from the 
	other part of the disk. 
	my ls issues a second stat. 
10 	seek finishes
18	rotational latency. 
58	read (1Mb) finishes (25Mb per second -> 40ms /Mb). 
68	seek to "my ls" finishes. 
76	rotational latency. 
76.1	my stat has transferred its 1k, in the intervening time the
	other program has already issued a new read for 1Mb of data.
86	seek to other program's data finishes... 

So I'd expect something like 10-14 stats per second. While in fact my
trace showed 3 to 5 stats per second. Still at 50 files in a directory
waiting around 4-5 seconds to see results from an "ls" is kind of
annoyingly slow, and I would've reported it as well.

Maybe the stat requires 2 to 3 IOs to complete? That would explain the
difference.

So the question becomes: Why does a stat require 2 or 3 IOs? OR why is
too much independent stuff scheduled inbetween that one IO takes
200-300 ms?...


		Roger. 

-- 
** R.E.Wolff@BitWizard.nl ** http://www.BitWizard.nl/ ** +31-15-2137555 **
*-- BitWizard writes Linux device drivers for any device you may have! --*
* There are old pilots, and there are bold pilots. 
* There are also old, bald pilots. 
