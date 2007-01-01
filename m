Return-Path: <linux-kernel-owner+w=401wt.eu-S932886AbXAAC4F@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932886AbXAAC4F (ORCPT <rfc822;w@1wt.eu>);
	Sun, 31 Dec 2006 21:56:05 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S933242AbXAAC4F
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 31 Dec 2006 21:56:05 -0500
Received: from mail.clusterfs.com ([206.168.112.78]:41370 "EHLO
	mail.clusterfs.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932886AbXAAC4D (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 31 Dec 2006 21:56:03 -0500
X-Greylist: delayed 1531 seconds by postgrey-1.27 at vger.kernel.org; Sun, 31 Dec 2006 21:56:03 EST
From: Nikita Danilov <nikita@clusterfs.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-ID: <17816.29254.497543.329777@gargle.gargle.HOWL>
Date: Mon, 1 Jan 2007 05:30:30 +0300
To: Mikulas Patocka <mikulas@artax.karlin.mff.cuni.cz>
Cc: Arjan van de Ven <arjan@infradead.org>, Benny Halevy <bhalevy@panasas.com>,
       Jan Harkes <jaharkes@cs.cmu.edu>, Miklos Szeredi <miklos@szeredi.hu>,
       linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org,
       nfsv4@ietf.org
Subject: Re: Finding hardlinks
Newsgroups: gmane.linux.file-systems,gmane.linux.kernel,gmane.ietf.nfsv4
In-Reply-To: <Pine.LNX.4.64.0612300154510.19928@artax.karlin.mff.cuni.cz>
References: <Pine.LNX.4.64.0612200942060.28362@artax.karlin.mff.cuni.cz>
	<E1GwzsI-0004Y1-00@dorka.pomaz.szeredi.hu>
	<20061221185850.GA16807@delft.aura.cs.cmu.edu>
	<Pine.LNX.4.64.0612220038520.4677@artax.karlin.mff.cuni.cz>
	<1166869106.3281.587.camel@laptopd505.fenrus.org>
	<Pine.LNX.4.64.0612231458060.5182@artax.karlin.mff.cuni.cz>
	<4593890C.8030207@panasas.com>
	<1167300352.3281.4183.camel@laptopd505.fenrus.org>
	<Pine.LNX.4.64.0612281909200.2960@artax.karlin.mff.cuni.cz>
	<1167388475.6106.51.camel@lade.trondhjem.org>
	<Pine.LNX.4.64.0612300154510.19928@artax.karlin.mff.cuni.cz>
X-Mailer: VM 7.17 under 21.5 (patch 17) "chayote" (+CVS-20040321) XEmacs Lucid
X-SystemSpamProbe: GOOD 0.0000132 0bacca1ece69ddb8113707427260542f
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Mikulas Patocka writes:
 > 
 > 
 > On Fri, 29 Dec 2006, Trond Myklebust wrote:
 > 
 > > On Thu, 2006-12-28 at 19:14 +0100, Mikulas Patocka wrote:
 > >> Why don't you rip off the support for colliding inode number from the
 > >> kernel at all (i.e. remove iget5_locked)?
 > >>
 > >> It's reasonable to have either no support for colliding ino_t or full
 > >> support for that (including syscalls that userspace can use to work with
 > >> such filesystem) --- but I don't see any point in having half-way support
 > >> in kernel as is right now.
 > >
 > > What would ino_t have to do with inode numbers? It is only used as a
 > > hash table lookup. The inode number is set in the ->getattr() callback.
 > 
 > The question is: why does the kernel contain iget5 function that looks up 
 > according to callback, if the filesystem cannot have more than 64-bit 
 > inode identifier?

Generally speaking, file system might have two different identifiers for
files:

 - one that makes it easy to tell whether two files are the same one;

 - one that makes it easy to locate file on the storage.

According to POSIX, inode number should always work as identifier of the
first class, but not necessary as one of the second. For example, in
reiserfs something called "a key" is used to locate on-disk inode, which
in turn, contains inode number. Identifiers of the second class tend to
live in directory entries, and during lookup we want to consult inode
cache _before_ reading inode from the disk (otherwise cache is mostly
useless), right? This means that some file systems want to index inodes
in a cache by something different than inode number.

There is another reason, why I, personally, would like to have an
ability to index inodes by things other than inode numbers: delayed
inode number allocation. Strictly speaking, file system has to assign
inode number to the file only when it is just about to report it to the
user space (either though stat, or, ugh... readdir). If location of
inode on disk depends on its inode number (like it is in inode-table
based file systems like ext[23]) then delayed inode number allocation
has to same advantages as delayed block allocation.

 > 
 > This lookup callback just induces writing bad filesystems with coliding 
 > inode numbers. Either remove coda, smb (and possibly other) filesystems 
 > from the kernel or make a proper support for userspace for them.
 > 
 > The situation is that current coreutils 6.7 fail to recursively copy 
 > directories if some two directories in the tree have coliding inode 
 > number, so you get random data corruption with these filesystems.
 > 
 > Mikulas

Nikita.

