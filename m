Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267131AbTA0PDB>; Mon, 27 Jan 2003 10:03:01 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267184AbTA0PDB>; Mon, 27 Jan 2003 10:03:01 -0500
Received: from caramon.arm.linux.org.uk ([212.18.232.186]:18183 "EHLO
	caramon.arm.linux.org.uk") by vger.kernel.org with ESMTP
	id <S267131AbTA0PDA>; Mon, 27 Jan 2003 10:03:00 -0500
Date: Mon, 27 Jan 2003 15:12:13 +0000
From: Russell King <rmk@arm.linux.org.uk>
To: Nikita Danilov <Nikita@Namesys.COM>
Cc: Linux Kernel Mailing List <Linux-Kernel@Vger.Kernel.ORG>,
       Andrew Morton <AKPM@Digeo.COM>, Alexander Viro <viro@math.psu.edu>
Subject: Re: possible deadlock in sys_pivot_root()?
Message-ID: <20030127151213.B28375@flint.arm.linux.org.uk>
Mail-Followup-To: Nikita Danilov <Nikita@Namesys.COM>,
	Linux Kernel Mailing List <Linux-Kernel@Vger.Kernel.ORG>,
	Andrew Morton <AKPM@Digeo.COM>, Alexander Viro <viro@math.psu.edu>
References: <15925.15947.576552.209252@laputa.namesys.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
In-Reply-To: <15925.15947.576552.209252@laputa.namesys.com>; from Nikita@Namesys.COM on Mon, Jan 27, 2003 at 05:12:27PM +0300
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jan 27, 2003 at 05:12:27PM +0300, Nikita Danilov wrote:
> sys_pivot_root() first takes BKL, then ->i_sem on the old root
> directory. On the other hand, vfs_readdir() first takes ->i_sem on a
> directory and then calls file system ->readdir() method, that usually
> takes BKL. Isn't there a deadlock possibility? Of course,
> sys_pivot_root() is probably not supposed to be called frequently, but
> still.

No, you can't deadlock here.  When you get contention on the i_sem,
one thread will be put to sleep, and when that happens, the BKL will
be automatically released.

So:

  CPU0				CPU1

  BKL
				i_sem
				BKL (spins, waiting for BKL to be released)

  i_sem (finds it locked,
       and sleeps, which
       releases the BKL)
                                (BKL is now released, CPU1 continues)

-- 
Russell King (rmk@arm.linux.org.uk)                The developer of ARM Linux
             http://www.arm.linux.org.uk/personal/aboutme.html

