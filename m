Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S316822AbSHARrk>; Thu, 1 Aug 2002 13:47:40 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S316852AbSHARrj>; Thu, 1 Aug 2002 13:47:39 -0400
Received: from h24-67-14-151.cg.shawcable.net ([24.67.14.151]:21237 "EHLO
	webber.adilger.int") by vger.kernel.org with ESMTP
	id <S316822AbSHARri>; Thu, 1 Aug 2002 13:47:38 -0400
From: Andreas Dilger <adilger@clusterfs.com>
Date: Thu, 1 Aug 2002 11:48:56 -0600
To: jpiszcz@lucidpixels.com
Cc: linux-kernel@vger.kernel.org, lftp@uniyar.ac.ru, lftp-devel@uniyar.ac.ru,
       apiszcz@mitre.org, ext2-devel@lists.sourceforge.net
Subject: Re: Nasty ext2fs bug!
Message-ID: <20020801174856.GA29562@clusterfs.com>
Mail-Followup-To: jpiszcz@lucidpixels.com, linux-kernel@vger.kernel.org,
	lftp@uniyar.ac.ru, lftp-devel@uniyar.ac.ru, apiszcz@mitre.org,
	ext2-devel@lists.sourceforge.net
References: <Pine.LNX.4.44.0208011150310.17729-100000@lucidpixels.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.44.0208011150310.17729-100000@lucidpixels.com>
User-Agent: Mutt/1.4i
X-GPG-Key: 1024D/0D35BED6
X-GPG-Fingerprint: 7A37 5D79 BF1B CECA D44F  8A29 A488 39F5 0D35 BED6
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Aug 01, 2002  12:54 -0400, jpiszcz@lucidpixels.com wrote:
>  Summary: When using lftp with the pget -n option for large files, once the
>           file is complete the problem begins.  If you try to copy, ftp, or
>           pretty much anything that involves reading the file, it is "stuck"
>           at a rate of 800KB/s to 1600KB/s.

The problem is obvious - there are many threads writing to the same
file, and the filesystem cannot really do a good job of allocating
blocks for these threads.  When you are reading the file back, the
disk is seeking like crazy to read the data from the disk.

It would be possible, even desirable, to have the block allocation
algorithm try and keep enough empty space on the disk for sparsely
written files, but this is a rather uncommon usage.

If you copy from this fragmented file to a new file, then the new file
is layed out contiguously on disk so readahead works and no seeking is
involved when reading the new file.

>  Problem: The pget -n feature of lftp is very nice if you want to maximize
>           your download bandwidth, however, if getting a large file, such
>           as the one I am getting, once the file is successfully
>           retrived, transferring it to another HDD or FTPing it to another
>           computer is very slow (800KB-1600KB/s).

I find it hard to believe that this would actually make a huge
difference, except in the case where the source is throttling bandwidth
on a per-connection basis.  Either your network is saturated by the
transfer, or some point in between is saturated.  I could be wrong, of
course, and it would be interesting to hear the reasoning behind the
speedup.

Cheers, Andreas

PS - thanks for the very detailed bug report - if only all bug reports
     were so full of useful information...
--
Andreas Dilger
http://www-mddsp.enel.ucalgary.ca/People/adilger/
http://sourceforge.net/projects/ext2resize/

