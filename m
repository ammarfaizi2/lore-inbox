Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S263204AbTAJGcu>; Fri, 10 Jan 2003 01:32:50 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S263215AbTAJGcu>; Fri, 10 Jan 2003 01:32:50 -0500
Received: from 169.imtp.Ilyichevsk.Odessa.UA ([195.66.192.169]:4883 "EHLO
	Port.imtp.ilyichevsk.odessa.ua") by vger.kernel.org with ESMTP
	id <S263204AbTAJGcs>; Fri, 10 Jan 2003 01:32:48 -0500
Message-Id: <200301100634.h0A6Yps14454@Port.imtp.ilyichevsk.odessa.ua>
Content-Type: text/plain; charset=US-ASCII
From: Denis Vlasenko <vda@port.imtp.ilyichevsk.odessa.ua>
Reply-To: vda@port.imtp.ilyichevsk.odessa.ua
To: Peter Chubb <peter@chubb.wattle.id.au>,
       Andrew McGregor <andrew@indranet.co.nz>
Subject: Re: ISO-9660 Rock Ridge gives different links different inums
Date: Fri, 10 Jan 2003 08:34:44 +0200
X-Mailer: KMail [version 1.3.2]
Cc: eric@andante.org, linux-kernel@vger.kernel.org
References: <15902.14667.489252.346007@wombat.chubb.wattle.id.au> <1345590000.1042169011@localhost.localdomain> <15902.16227.924630.143293@wombat.chubb.wattle.id.au>
In-Reply-To: <15902.16227.924630.143293@wombat.chubb.wattle.id.au>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 10 January 2003 05:34, Peter Chubb wrote:
> >> I don't know enough about the ISO9660 standard to be sure what's
> >> best to do about this.
>
> Andrew> Change it to be the offset to the data area, which should be
> Andrew> the same for all of them?
>
> I thought about that, but I'm unsure if there's any way to get from
> that offset to the directory information.  As far as I can tell,
> there's no concept of an inode separate from directory entry on
> iso9660 --- the directory entry/entries all contain all the
> information that describes a file.  Which means that the inumber has
> to point to some directory node.
>
> Preferably, all the inumbers for the same file would point to the
> same directory entry; but I can see no easy way to do that.  Keeping
> an in-memory table for files with multiple links might be the best
> way, as there aren't that many on a typical filesystem.

And what will happen on a non-typical filesystem with 1 million hardlinks?

The root of the problem is a fundamental layering violation in
traditional Unix filesystems: inode numbers should NOT be visible
to userspace. Userspace just needs a way to tell hardlinks from separate
files, that's all. Exposing inumbers does that, but creates tons
of problems for filesystems which do NOT have such a concept.

There is at least one way to redesign it:
* provide hash number instead of an inumber for each file
  with the following semantics:
  - hardlinks ALWAYS have equal hash numbers
  - different files MAY have equal hash numbers (but rarely)
* provide is_hardlink(file1,file2) system call

But this will cause very long migration period (~10 years?)
and incompatibilities with other Unix variants...
--
vda
