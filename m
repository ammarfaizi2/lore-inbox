Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S135707AbRDXSgu>; Tue, 24 Apr 2001 14:36:50 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S135709AbRDXSgl>; Tue, 24 Apr 2001 14:36:41 -0400
Received: from router-100M.swansea.linux.org.uk ([194.168.151.17]:59917 "EHLO
	the-village.bc.nu") by vger.kernel.org with ESMTP
	id <S135707AbRDXSgd>; Tue, 24 Apr 2001 14:36:33 -0400
Subject: Re: BUG: Global FPU corruption in 2.2
To: zandy@cs.wisc.edu (Victor Zandy)
Date: Tue, 24 Apr 2001 19:37:38 +0100 (BST)
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <cpxitjurwei.fsf@goat.cs.wisc.edu> from "Victor Zandy" at Apr 24, 2001 01:21:41 PM
X-Mailer: ELM [version 2.5 PL1]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-Id: <E14s7gz-0002fh-00@the-village.bc.nu>
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> >         child->flags |= PF_PTRACED; 
> > 
> > without waiting for the child to have stopped. 
> 
> I can see how this could case PF_USEDFPU to be cleared inadvertently,
> but I do not have any ideas for testing this.  Is it clear that this
> is the source of the problem?

There is no guarantee that |= is implemented atomically - in fact its quite
likely to read

		get child->flags
		or PF_PTRACED
		write child->flags

and a PF_USEDFPU on another processor at the same instant -would- end up being
lost.

There are two fixes

1.	Make all the ops atomic (foo_bit())
2.	Split the flags

The preferable one for performance is certainly to backport the 2.4 changes

