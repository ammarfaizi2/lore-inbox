Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964891AbWEJKWe@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964891AbWEJKWe (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 10 May 2006 06:22:34 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964890AbWEJKWe
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 10 May 2006 06:22:34 -0400
Received: from outpipe-village-512-1.bc.nu ([81.2.110.250]:60894 "EHLO
	lxorguk.ukuu.org.uk") by vger.kernel.org with ESMTP id S964888AbWEJKWd
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 10 May 2006 06:22:33 -0400
Subject: Re: [PATCH -mm] sys_semctl gcc 4.1 warning fix
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
To: Daniel Walker <dwalker@mvista.com>
Cc: akpm@osdl.org, linux-kernel@vger.kernel.org
In-Reply-To: <200605100256.k4A2u8bd031779@dwalker1.mvista.com>
References: <200605100256.k4A2u8bd031779@dwalker1.mvista.com>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Date: Wed, 10 May 2006 11:34:26 +0100
Message-Id: <1147257266.17886.3.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Evolution 2.2.3 (2.2.3-4.fc4) 
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Maw, 2006-05-09 at 19:56 -0700, Daniel Walker wrote:
> Fixes the following warnings,
> 
> ipc/sem.c: In function 'sys_semctl':
> ipc/sem.c:810: warning: 'setbuf.uid' may be used uninitialized in this function
> ipc/sem.c:810: warning: 'setbuf.gid' may be used uninitialized in this function
> ipc/sem.c:810: warning: 'setbuf.mode' may be used uninitialized in this function
> 
> Signed-Off-By: Daniel Walker <dwalker@mvista.com>
> 
> Index: linux-2.6.16/ipc/sem.c
> ===================================================================
> --- linux-2.6.16.orig/ipc/sem.c
> +++ linux-2.6.16/ipc/sem.c
> @@ -807,7 +807,7 @@ static int semctl_down(int semid, int se
>  {
>  	struct sem_array *sma;
>  	int err;
> -	struct sem_setbuf setbuf;
> +	struct sem_setbuf setbuf = {0, 0, 0};


This causes very poor code as its initializing an object on the stack.
It also appears from inspection to be entirely un-neccessary. Instead
the compiler needs some help.

Hiding warnings like this can be a hazard as it will hide real warnings
later on.

