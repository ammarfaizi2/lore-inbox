Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261195AbTIKK3m (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 11 Sep 2003 06:29:42 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261201AbTIKK3m
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 11 Sep 2003 06:29:42 -0400
Received: from angband.namesys.com ([212.16.7.85]:63121 "EHLO
	angband.namesys.com") by vger.kernel.org with ESMTP id S261195AbTIKK3j
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 11 Sep 2003 06:29:39 -0400
Date: Thu, 11 Sep 2003 14:29:38 +0400
From: Oleg Drokin <green@namesys.com>
To: Rogier Wolff <R.E.Wolff@BitWizard.nl>, Hans Reiser <reiser@namesys.com>,
       linux-kernel@vger.kernel.org, Nikita Danilov <god@namesys.com>
Subject: Re: First impressions of reiserfs4
Message-ID: <20030911102938.GE29357@namesys.com>
References: <20030908081206.GA17718@namesys.com> <20030908105639.B26722@bitwizard.nl> <20030908090826.GB10487@namesys.com> <20030908113304.A28123@bitwizard.nl> <20030908094825.GD10487@namesys.com> <20030908120531.A28937@bitwizard.nl> <20030908101704.GE10487@namesys.com> <20030908222457.GB17441@matchmail.com> <20030909070421.GJ10487@namesys.com> <20030909191044.GB28279@matchmail.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="lrZ03NoBR/3+SXJZ"
Content-Disposition: inline
In-Reply-To: <20030909191044.GB28279@matchmail.com>
User-Agent: Mutt/1.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--lrZ03NoBR/3+SXJZ
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Hello!

On Tue, Sep 09, 2003 at 12:10:44PM -0700, Mike Fedyk wrote:

> > But my experiments quickly shown that if you ask mkfs to create inode tables with
> > free inodes that exceed blocks count for the device, then mkfs will only create as much free inodes
> > as there are free blocks on the device (I was needing that when I experimented with 60 millions files
> > on ext2/reiserfs/xfs and stuff and I only had 20G partition.)
> Hmm, didn't know this, but it makes sence for ext2/3 since they use 1 block
> per file/directory.  It wouldn't do much good to waste more space for inode
> tables than you could even theoretically use.

Well, in fact empty files do not need this block.

> > > tail merging off, 1k files per directory and all files the same size as
> > > block size with 40M files.  How would the table look as far as space effency
> > Hm. I will probably try this once.
> > For reiserfs:
> > I can tell you that 60M+ empty files (cannot remember exact number, but I still have the script to create those)
> > took ~5.5G of space. 
> With how many directories?  Do you run into drive speed limitations with

Ok. I looked at the script. There should be 182900000 files created. (182.9M)
100 files per dir.
the dir structure was like this (in number of dirs per level):
31/59/25/40
Files were only created at the end of hierarchy.
See the script at the end if you are interested or want to try it yourself.
(script was donated to us by somebody, only it was shell script,
also I changed variable-names to hide identity).

> that much meta-data, or are there still bottlenecks in the
> journaling/hashing to deal with? How big are the reiser3/4 equivalents to

I do not remember what was major limitation.
Creation took something like one hour on my dual athlon box. This suggests
most overhead was still CPU. (I used perl script to create stuff)
Removing those files took even longer.

> inodes?  In ext2/3 they're currently 128 bytes I believe plus some static
> bitmaps in the block groups.  The only thing variable in ext2/3 are the
> directory sizes (and they don't shrink... :( )

Well in reiserfs we have statdata (each object should have one), this is sort of
like ext2 inode, only not static. It's size is 44 bytes (plus 24 bytes item
header overhead). Each metadata block has header of 24 bytes.
If you write to file (not looking at tail case yet), you create "indirect"
items in which block pointers are stored.
(4 bytes per pointer, when you use all space in metadata block, next block is
allocated (24 bytes of overhead + pointer in higher level block) plus
new indirect item (24 bytes of overhead again))
Also bitmaps are static (1 block per 128M of space in case of 4k blocksize)
as are superblock, journal and journal header.

> > Then 60M * 4k is 240G, all these blocks are referenced by leafnodes, ~1000 pointers fits into one node,
> > so we will spend ~245M for block pointers (extra 5 because there are more layers of indirections).
> > > look comparing them?  For that matter, how do JFS & XFS compare?
> > Unfortunatelly I never had the patience to wait until XFS creates 60M files. Have not tried jfs.
> Hmm, isn't XFS slower than ext2/3 in that regard?

Probably it is. I was unable to find blockdevice big enough to hold
all the inode stuff for ext2/3 so I do not have comparable number.
XFS was very slow at creation (like 3 hours only gave ~ 10% of progress
and testing was stopped at this point.
Deletion of those created files also took forever)

Bye,
    Oleg

--lrZ03NoBR/3+SXJZ
Content-Type: application/x-perl
Content-Disposition: attachment; filename="createdirs.pl"
Content-Transfer-Encoding: quoted-printable

#!/usr/bin/perl=0A=0A$homedir=3D"/testfs0/t";=0A$basedir=3D"$homedir/base";=
=0A=0A`mkdir -p $basedir`;=0A=0A$YYYY=3D2002;=0A$MM=3D12;=0A$days=3D31;=0A$=
vars=3D59;=0A$hours=3D2500;=0A$workers=3D40;=0A$files=3D100;=0A=0Achdir("$b=
asedir");=0Amkdir("$YYYY-$MM");=0Achdir("$YYYY-$MM");=0A=0A$day=3D1;=0A=0Aw=
hile ( $day <=3D $days ) {=0A	if ( $day <=3D 10 ) {=0A		mkdir("0$day");=0A =
               chdir("0$day");=0A                $var=3D1;=0A              =
  while ( $var <=3D $vars ) {=0A                        mkdir("var$var");=
=0A                        chdir("var$var");=0A                        $hou=
r=3D100;=0A                        while ( $hour <=3D $hours ) {=0A        =
                        mkdir("$hour");=0A                                c=
hdir("$hour");=0A                                $worker=3D1;=0A           =
                     while ( $worker <=3D $workers ) {=0A					mkdir("DE$wor=
ker");=0A                                        chdir("DE$worker");=0A    =
                                    $file=3D1;=0A                          =
              while ( $file <=3D $files ) {=0A                             =
                   open(OUTFILE,">file$file");=0A						close(OUTFILE);=0A  =
                                              $file=3D$file+1;=0A          =
                              }=0A                                        $=
worker=3D$worker+1;=0A                                        chdir("..");=
=0A                                }=0A                                chdi=
r("..");=0A                                $hour=3D$hour+100;=0A           =
             }=0A                        chdir("..");=0A                   =
     $var=3D$var+1;=0A                }=0A                chdir("..");=0A	}=
 else {=0A		last;=0A	}=0A	$day=3D$day+1;=0A}=0A
--lrZ03NoBR/3+SXJZ--
