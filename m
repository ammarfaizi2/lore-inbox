Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261286AbUKCA7q@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261286AbUKCA7q (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 2 Nov 2004 19:59:46 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261513AbUKBVlS
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 2 Nov 2004 16:41:18 -0500
Received: from mail.dif.dk ([193.138.115.101]:13518 "EHLO mail.dif.dk")
	by vger.kernel.org with ESMTP id S261494AbUKBVkB (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 2 Nov 2004 16:40:01 -0500
Date: Tue, 2 Nov 2004 22:48:39 +0100 (CET)
From: Jesper Juhl <juhl-lkml@dif.dk>
To: Jan Engelhardt <jengelh@linux01.gwdg.de>
Cc: Chris Friesen <cfriesen@nortelnetworks.com>,
       Oliver Neukum <oliver@neukum.org>,
       Linux kernel <linux-kernel@vger.kernel.org>
Subject: Re: question on common error-handling idiom
In-Reply-To: <Pine.LNX.4.53.0411022229070.6104@yvahk01.tjqt.qr>
Message-ID: <Pine.LNX.4.61.0411022241160.3285@dragon.hygekrogen.localhost>
References: <4187E920.1070302@nortelnetworks.com>
 <Pine.LNX.4.61.0411022208390.3285@dragon.hygekrogen.localhost>
 <Pine.LNX.4.53.0411022229070.6104@yvahk01.tjqt.qr>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 2 Nov 2004, Jan Engelhardt wrote:

> >There are some places that do
> >
> >err = -SOMEERROR;
> >if (some_error)
> >	goto out;
> >if (some_other_error)
> >	goto out;
> >if (another_error)
> >	goto out;
> >
> >Let's see what other people think :)
> 
> err = -ESOME;
> if(some_error || some_other_error || another_error) {
> 	goto out;
> }
> 
> Best.
> 
Agreed, but that would potentially make something like the following (from 
fs/binfmt_elf.c::load_elf_binary) quite unreadable :

if (loc->elf_ex.e_type != ET_EXEC && loc->elf_ex.e_type != ET_DYN)
	goto out;
if (!elf_check_arch(&loc->elf_ex))
	goto out;
if (!bprm->file->f_op||!bprm->file->f_op->mmap)
	goto out;


But that's not even the most interresting case, the interresting one is 
the one that does

err = -ERR;
if (foo)
	goto out;

err = -ERROR;
if (bar)
	goto out;

where there's the potential to save an instruction by moving the err= into 
the error path.
But as Oliver Neukum pointed out gcc may not be smart enough for that to 
actually generate the best code.

Has anyone taken a look at what recent gcc's actually do with different 
variations of the constructs mentioned in this thread?


--
Jesper Juhl


