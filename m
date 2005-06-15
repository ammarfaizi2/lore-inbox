Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261621AbVFOXSw@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261621AbVFOXSw (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 15 Jun 2005 19:18:52 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261642AbVFOXRT
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 15 Jun 2005 19:17:19 -0400
Received: from [80.71.243.242] ([80.71.243.242]:4520 "EHLO tau.rusteko.ru")
	by vger.kernel.org with ESMTP id S261621AbVFOXPF (ORCPT
	<rfc822;Linux-Kernel@Vger.Kernel.ORG>);
	Wed, 15 Jun 2005 19:15:05 -0400
From: Nikita Danilov <nikita@clusterfs.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=koi8-r
Content-Transfer-Encoding: 8bit
Message-ID: <17072.46716.96095.48409@gargle.gargle.HOWL>
Date: Thu, 16 Jun 2005 03:15:08 +0400
X-Mailer: VM 7.17 under 21.5 (patch 17) "chayote" (+CVS-20040321) XEmacs Lucid
To: Linux Kernel Mailing List <Linux-Kernel@Vger.Kernel.ORG>
Subject: Re: FIGETBSZ and FIBMAP for directorys
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Sebastian Claßen writes:
 > Hi list...
 > 
 > I'm using this little program to find out which blocks are use by a
 > particular file:
 > int main(int argc, char **argv) {
 >         int             fd,
 >                         i,
 >                         block,
 >                         blocksize,
 >                         bcount;
 >         struct stat     st;
 > 
 >         assert(argv[1] != NULL);
 >         assert(fd=open(argv[1], O_RDONLY));
 >         assert(ioctl(fd, FIGETBSZ, &blocksize) == 0);
 >         assert(!fstat(fd, &st));

Now, if somebody compiles this with NDEBUG? It is bad practice to put
code with side-effects into assertions.

[...]

 > 
 > This works fine for regular files, but not for directorys. Both ioctl's,
 > FIGETBSZ and FIBMAP, are implemented for regular files only. 

FIBMAP is obsolete API, I believe. For certain file systems it doesn't
make sense to ask "in what block, i-th logical block of given file
lives?" for directory files, because directories do not have linear
structure, e.g., are implemented as B-trees. Not incidentally these are
the same file systems that have trouble supporting optional
seekdir/telldir API.

Moreover, for some file systems this question doesn't make a lot of
sense even for regular files, e.g., because small files can be stored in
the same block, or some blocks might be in the "unallocated state", or
file system does behind-the-back relocation to improve disk layout, etc.

Nor does it make sense to ask such questions when files are stripped
over multiple devices, or served over network, or backed up by memory...

Basically, FIBMAP is a hack.

 > 
 > Is there a patch to make this FIGETBSZ and FIBMAP work on directorys
 > too?
 > Or alternativly, is there a way to find out which blocks are used by a
 > directory?
 > 
 > Thanks for answers in advance
 >   Sebastian.
 > 
 > 

Nikita.
