Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261722AbTEAC2V (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 30 Apr 2003 22:28:21 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262091AbTEAC2V
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 30 Apr 2003 22:28:21 -0400
Received: from [12.47.58.20] ([12.47.58.20]:31624 "EHLO pao-ex01.pao.digeo.com")
	by vger.kernel.org with ESMTP id S261722AbTEAC2U (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 30 Apr 2003 22:28:20 -0400
Date: Wed, 30 Apr 2003 19:41:24 -0700
From: Andrew Morton <akpm@digeo.com>
To: Ben Collins <bcollins@debian.org>
Cc: torvalds@transmeta.com, pavel@ucw.cz, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] Fix NULL handler for compat_ioctl
Message-Id: <20030430194124.03fb29db.akpm@digeo.com>
In-Reply-To: <20030501013427.GA516@phunnypharm.org>
References: <20030501013427.GA516@phunnypharm.org>
X-Mailer: Sylpheed version 0.8.11 (GTK+ 1.2.10; i586-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-OriginalArrivalTime: 01 May 2003 02:40:34.0594 (UTC) FILETIME=[0A67A020:01C30F8B]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Ben Collins <bcollins@debian.org> wrote:
>
> -	t->handler = handler; 
> +	if (!handler)
> +		t->handler = (void *)sys_ioctl;
> +	else
> +		t->handler = handler; 

Is that safe?

- sys_ioctl takes three args, but this vector is going to be called with
  four.  That's making assumptions about arg passing conventions which may
  not be true.

- sys_ioctl() is asmlinkage, but the caller of this vector doesn't know
  that.  Arguments may get put in the wrong place.

Is a little wrapper function needed?

