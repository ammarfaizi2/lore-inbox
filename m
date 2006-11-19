Return-Path: <linux-kernel-owner+willy=40w.ods.org-S933285AbWKSU5O@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S933285AbWKSU5O (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 19 Nov 2006 15:57:14 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S933284AbWKSU5O
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 19 Nov 2006 15:57:14 -0500
Received: from zeniv.linux.org.uk ([195.92.253.2]:47077 "EHLO
	ZenIV.linux.org.uk") by vger.kernel.org with ESMTP id S933285AbWKSU5M
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 19 Nov 2006 15:57:12 -0500
Date: Sun, 19 Nov 2006 20:57:11 +0000
From: Al Viro <viro@ftp.linux.org.uk>
To: Randy Dunlap <randy.dunlap@oracle.com>
Cc: Andi Kleen <ak@suse.de>, Jeff Mahoney <jeffm@suse.com>,
       lkml <linux-kernel@vger.kernel.org>, reiserfs-dev@namesys.com,
       sam@ravnborg.org
Subject: Re: reiserfs NET=n build error
Message-ID: <20061119205711.GE3078@ftp.linux.org.uk>
References: <20061118202206.01bdc0e0.randy.dunlap@oracle.com> <200611190650.49282.ak@suse.de> <45608FC2.5040406@suse.com> <200611191959.55969.ak@suse.de> <4560AAC1.3000800@oracle.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <4560AAC1.3000800@oracle.com>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Nov 19, 2006 at 11:04:33AM -0800, Randy Dunlap wrote:
> Andi Kleen wrote:
> >>>I would copy a relatively simple C implementation, like 
> >>>arch/h8300/lib/checksum.c
> >>As long as the h8300 version has the same output as the x86 version.
> >
> >The trouble is that the different architecture have different output 
> >for csum_partial. So you already got a bug when someone wants to move
> >file systems.
> >
> >-Andi
> 
> That argues for having only one version of it (in a lib.; my preference)
> -or- Every module having its own local copy/version of it.  :(

Wrong.  csum_partial() result is defined modulo 0xffff and it's basically
"whatever's convenient as intermediate for this architecture".

reiserfs use of it is just plain broken.  net/* is fine, since all
final uses are via csum_fold() or equivalents.

Note that reiserfs use is broken in another way: it takes fixed-endian value
and feeds it to cpu_to_le32().  IOW, even if everything had literally the
same csum_partial(), the value it shits on disk would be endian-dependent.

As for net/*, with proper types it's pretty straightforward.  See
davem's net-2.6.20 for that...
