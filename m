Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261978AbUKCXLM@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261978AbUKCXLM (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 3 Nov 2004 18:11:12 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261973AbUKCXLH
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 3 Nov 2004 18:11:07 -0500
Received: from mail1.speakeasy.net ([216.254.0.201]:26297 "EHLO
	mail1.speakeasy.net") by vger.kernel.org with ESMTP id S261978AbUKCXGK
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 3 Nov 2004 18:06:10 -0500
Date: Wed, 3 Nov 2004 15:06:05 -0800 (PST)
From: vlobanov <vlobanov@speakeasy.net>
To: Russell Miller <rmiller@duskglow.com>
cc: Jim Nelson <james4765@verizon.net>, DervishD <lkml@dervishd.net>,
       Gene Heskett <gene.heskett@verizon.net>, linux-kernel@vger.kernel.org,
       =?iso-8859-1?q?M=E5ns_Rullg=E5rd?= <mru@inprovide.com>
Subject: Re: is killing zombies possible w/o a reboot?
In-Reply-To: <200411031644.58979.rmiller@duskglow.com>
Message-ID: <Pine.LNX.4.58.0411031459010.16460@shell2.speakeasy.net>
References: <200411030751.39578.gene.heskett@verizon.net> <20041103192648.GA23274@DervishD>
 <4189586E.2070409@verizon.net> <200411031644.58979.rmiller@duskglow.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Also a kernel newbie here, so apply appropriate amount of salt to
response. :)

One common scenario for why a program is blocked within a syscall is
that it is waiting for data to arrive. Consider, for example, a read()
on a file -- simplifying a lot, the data has to be fetched from disk,
which is slow. So, while the disk is doing it's thing, the program is
blocked within the system call. Then, when an interrupt arrives
signalling that the data is ready, it is placed into the user-space
buffer, and the program is kicked out of the syscall so that it can
continue executing.

Consider what happens if the program suddenly dies within the read()
syscall above: when the data from disk comes back, the kernel needs to
figure out where to put it. This would make for a very confused kernel,
since the original requester "vanished" without a trace. Even worse,
another program might have taken the original program's place in the
meantime! Very bad things happen.

This is certainly not an _impossible_ problem to solve (as far as I
know), but solving it in the general case would involve a lot of
expensive and complex book-keeping code, so it's simply not done.

Am I right? Wrong? Please enlighten me as well. :)

-Vadim Lobanov

On Wed, 3 Nov 2004, Russell Miller wrote:

> On Wednesday 03 November 2004 16:15, Jim Nelson wrote:
>
> > I did this to myself a number of times when I was first learning Samba -
> > even an ls would become unkillable.  You couldn't rmmod smb, since it was
> > in use, and you couldn't kill the process, since it was waiting on a
> > syscall.  Ergh.
> >
>
> I'm not going to pretend to be a kernel expert, or really anything other than
> a newbie when it comes to kernel internals, so please take this with the
> merits it deserves - many, or none, depending.
>
> Anyway, is there a way to simply signal a syscall that it is to be interrupted
> and forcibly cause the syscall to end?  Kicking the program execution out of
> kernel space would be sufficient to "unstick" the process - and coupling that
> with an automatic KILL signal may not be a bad idea.
>
> I'm pretty sure that someone will think of a way why this wouldn't work with
> very little effort.  Please enlighten me?
>
> --Russell
>
> --
>
> Russell Miller - rmiller@duskglow.com - Le Mars, IA
> Duskglow Consulting - Helping companies just like you to succeed for ~ 10 yrs.
> http://www.duskglow.com - 712-546-5886
> -
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/
>
