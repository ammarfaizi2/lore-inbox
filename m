Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262491AbVCIV7H@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262491AbVCIV7H (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 9 Mar 2005 16:59:07 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262497AbVCIV5s
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 9 Mar 2005 16:57:48 -0500
Received: from fep19-0.kolumbus.fi ([193.229.0.45]:15098 "EHLO
	fep19-app.kolumbus.fi") by vger.kernel.org with ESMTP
	id S262491AbVCIV5W (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 9 Mar 2005 16:57:22 -0500
Date: Wed, 9 Mar 2005 23:58:36 +0200 (EET)
From: Kai Makisara <Kai.Makisara@kolumbus.fi>
X-X-Sender: makisara@kai.makisara.local
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] make st seekable again
In-Reply-To: <1110401474.3116.241.camel@localhost.localdomain>
Message-ID: <Pine.LNX.4.61.0503092338300.6756@kai.makisara.local>
References: <200503081911.j28JBlxi016013@hera.kernel.org>
 <1110401474.3116.241.camel@localhost.localdomain>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 9 Mar 2005, Alan Cox wrote:

> On Maw, 2005-03-08 at 17:25, Linux Kernel Mailing List wrote:
> > ChangeSet 1.2030, 2005/03/08 09:25:05-08:00, kai.makisara@kolumbus.fi
> > 
> > 	[PATCH] make st seekable again
> > 	
> > 	Apparently `tar' errors out if it cannot perform lseek() against a tape.  Work
> > 	around that in-kernel.
> 
> Unfortunately this isn't a good idea. Allowing tar to read the tape
> position makes sense, allowing it to zero the position might but you
> have to do major surgery on the driver first because
> 
> 1.	It doesn't use ppos
> 2.	It doesn't do locking on the ppos at all
> 
> Also allowing apps to randomly seek and report "ok" when they are
> backing up to tape and might really need to see the error is not what
> I'd call stable, professional or quality code.
> 
The proper fix is to fix tar. I have sent an analysis of the problem and a 
suggestion how to fix this to the bug-tar list on March 5 but it is still 
waiting for moderator approval.

While waiting for the application to be fixed, it was decided to restore 
the old behaviour of the tape drivers.

lseek on a tape is not a good fit (addressed by block, blocks on tape can 
have any size, etc.). I don't know any Unix that would really implement 
lseek on tapes but they usually don't return error. This is probably why 
the tar bug has not been found earlier.

There has been one useful way of using lseek() with tapes in some systems. 
Those refuse reads and writes if the file pointer reaches 2 GB. Resetting 
it with lseek(fd,0,0) now and then has allowed writing/reading more than 2 
GB.

I don't think implementing proper read-only lseek for tapes is worth the 
trouble (reliable tracking of the current location is tricky). Purist 
kernels can refuse lseeks. Pragmatic kernels can allow lseeks until 
refusing those won't break common applications.

-- 
Kai
