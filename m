Return-Path: <linux-kernel-owner+w=401wt.eu-S964864AbXADN7h@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964864AbXADN7h (ORCPT <rfc822;w@1wt.eu>);
	Thu, 4 Jan 2007 08:59:37 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964863AbXADN7h
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 4 Jan 2007 08:59:37 -0500
Received: from mail.clusterfs.com ([206.168.112.78]:36483 "EHLO
	mail.clusterfs.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S964855AbXADN7g (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 4 Jan 2007 08:59:36 -0500
From: Nikita Danilov <nikita@clusterfs.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-ID: <17821.2116.968666.182913@gargle.gargle.HOWL>
Date: Thu, 4 Jan 2007 16:59:32 +0300
To: Mikulas Patocka <mikulas@artax.karlin.mff.cuni.cz>
Cc: Arjan van de Ven <arjan@infradead.org>, Benny Halevy <bhalevy@panasas.com>,
       Jan Harkes <jaharkes@cs.cmu.edu>, Miklos Szeredi <miklos@szeredi.hu>,
       linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org,
       nfsv4@ietf.org
Subject: Re: Finding hardlinks
Newsgroups: gmane.linux.file-systems,gmane.linux.kernel,gmane.ietf.nfsv4
In-Reply-To: <Pine.LNX.4.64.0701020018330.5162@artax.karlin.mff.cuni.cz>
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
	<17816.29254.497543.329777@gargle.gargle.HOWL>
	<Pine.LNX.4.64.0701012356410.5162@artax.karlin.mff.cuni.cz>
	<17817.37844.730977.13636@gargle.gargle.HOWL>
	<Pine.LNX.4.64.0701020018330.5162@artax.karlin.mff.cuni.cz>
X-Mailer: VM 7.17 under 21.5 (patch 17) "chayote" (+CVS-20040321) XEmacs Lucid
X-SystemSpamProbe: GOOD 0.0000177 428c16328e8128ff045be705f8632985
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Mikulas Patocka writes:
 > > > BTW. How does ReiserFS find that a given inode number (or object ID in
 > > > ReiserFS terminology) is free before assigning it to new file/directory?
 > >
 > > reiserfs v3 has an extent map of free object identifiers in
 > > super-block.
 > 
 > Inode free space can have at most 2^31 extents --- if inode numbers 
 > alternate between "allocated", "free". How do you pack it to superblock?

In the worst case, when free/used extents are small, some free oids are
"leaked", but this has never been problem in practice. In fact, there
was a patch for reiserfs v3 to store this map in special hidden file but
it wasn't included in mainline, as nobody ever complained about oid map
fragmentation.

 > 
 > > reiser4 used 64 bit object identifiers without reuse.
 > 
 > So you are going to hit the same problem as I did with SpadFS --- you 
 > can't export 64-bit inode number to userspace (programs without 
 > -D_FILE_OFFSET_BITS=64 will have stat() randomly failing with EOVERFLOW 
 > then) and if you export only 32-bit number, it will eventually wrap-around 
 > and colliding st_ino will cause data corruption with many userspace 
 > programs.

Indeed, this is fundamental problem. Reiser4 tries to ameliorate it by
using hash function that starts colliding only when there are billions
of files, in which case 32bit inode number is screwed anyway.

Note, that none of the above problems invalidates reasons for having
long in-kernel inode identifiers that I outlined in other message.

 > 
 > Mikulas

Nikita.

