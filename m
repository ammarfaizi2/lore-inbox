Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262581AbUCJM1D (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 10 Mar 2004 07:27:03 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262593AbUCJM1C
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 10 Mar 2004 07:27:02 -0500
Received: from fungus.teststation.com ([212.32.186.211]:25096 "EHLO
	fungus.teststation.com") by vger.kernel.org with ESMTP
	id S262585AbUCJM0n (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 10 Mar 2004 07:26:43 -0500
Date: Wed, 10 Mar 2004 13:26:01 +0100 (CET)
From: Urban Widmark <urban@teststation.com>
X-X-Sender: puw@cola.local
To: Linus Torvalds <torvalds@osdl.org>
cc: Adam Sampson <azz@us-lot.org>,
       Kernel Mailing List <linux-kernel@vger.kernel.org>,
       Andrew Morton <akpm@osdl.org>, Zwane Mwaikambo <zwane@arm.linux.org.uk>
Subject: Re: smbfs Oops with Linux 2.6.3
In-Reply-To: <Pine.LNX.4.58.0403091836410.1092@ppc970.osdl.org>
Message-ID: <Pine.LNX.4.44.0403101244480.19728-100000@cola.local>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 9 Mar 2004, Linus Torvalds wrote:

> As to how something like that could happen, I have absolutely no clue. The 
> "smb_install_null_ops()" would seem to cause that, but that's all I can 
> say.
> 
> Maybe the "smp_ops_null" thing should be filled in with stuff that always
> returns EINVAL or something? Rather than actual NULL pointers that will
> oops if they are ever used?

The getattr problem was that after the mount smbfs isn't ready to do 
anything until it gets a connection from smbmount. Filling smp_ops_null 
would give the user an error on whatever it is that it does immediately 
after mounting.

smp_ops_null should really make all functions block and wait for the
connection to be created and given to us from smbmount. That would make it
behave more like smbfs in 2.4 does.

I am thinking of something like this for each entry in smp_ops_null.

int whatever_it_is_that_I_am(args)
{
	timeleft = wait_event_interruptible_timeout(...)
	if (!timeleft || signal_pending(current))
		return -EIO;
	if (!server->ops->whatever_it_is_that_I_am)
		return -EIO;
	return server->ops->whatever_it_is_that_I_am(args)
}


I know bugme has bug1671 with a similar oops. If no one else does, I'll
make a patch for Adam and #1671 to test.

I have not been able to reproduce this before, but if it is that readdir 
is used before it is ready then some extra delays in smbmount might help.

/Urban

