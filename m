Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261517AbULAXy3@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261517AbULAXy3 (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 1 Dec 2004 18:54:29 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261512AbULAXy3
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 1 Dec 2004 18:54:29 -0500
Received: from pat.uio.no ([129.240.130.16]:62174 "EHLO pat.uio.no")
	by vger.kernel.org with ESMTP id S261517AbULAXvD (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 1 Dec 2004 18:51:03 -0500
Subject: Re: nfs and LBD support (2TB+)
From: Trond Myklebust <trond.myklebust@fys.uio.no>
To: Stephan van Hienen <kernel@a2000.nu>
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <Pine.LNX.4.61.0412020017550.2774@adsl.a2000.nu>
References: <Pine.LNX.4.61.0412020017550.2774@adsl.a2000.nu>
Content-Type: text/plain
Date: Wed, 01 Dec 2004 18:50:33 -0500
Message-Id: <1101945033.32266.33.camel@lade.trondhjem.org>
Mime-Version: 1.0
X-Mailer: Evolution 2.0.2 
Content-Transfer-Encoding: 7bit
X-MailScanner-Information: This message has been scanned for viruses/spam. Contact postmaster@uio.no if you have questions about this scanning
X-UiO-MailScanner: No virus found
X-UiO-Spam-info: not spam, SpamAssassin (score=0, required 12)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

to den 02.12.2004 Klokka 00:20 (+0100) skreiv Stephan van Hienen:
> Hi,
> 
> i don't know if this is kernel related ?
> 
> server is exporting nfs 2.3TB
> 
> /dev/md0              2.3T  959G  1.4T  41% /raid
> 
> on the client i see this as 316GB :
> 
> storage:/raid         316GB  129GB  187GB  41% /raid
> 
> server is running 2.6.10-rc2
> client is running 2.6.9-ac11
> 
> both have LBD support enabled
> (and both are running tao (which is based on rhel 3))
> 
> any ideas ?

Yep... There is a slight problem with the way glibc has decided to
implement the statvfs function when interacting with 2.6.x kernels...

The POSIX definition of statvfs declares that the entry f_blocks (which
returns the size of the filesystem) shall be in units of f_frsize (see
the manpage).

OTOH the system call sys_statfs() still returns f_blocks in units of
f_bsize (as it has done since the dawn of Linux)...

So when glibc calls sys_statfs(), and then just copies the results into
the statvfs format structure, it is putting a value of f_blocks which is
in units of f_bsize into something that should be in units of f_frsize.

This was not a problem in Linux-2.4.x, 'cos glibc would simply emulate a
value for f_frsize by setting it to f_bsize.
However for 2.6.x kernels, glibc grabs a value of f_frsize that the
kernel gives it. So if that value differs from the bsize (and allowing
f_frsize != f_bsize is the whole point of passing a value for f_frsize
to glibc in the first place), you get wierd discrepancies like the
above.

Cheers,
  Trond

-- 
Trond Myklebust <trond.myklebust@fys.uio.no>

