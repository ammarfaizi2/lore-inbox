Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264397AbTDXVNW (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 24 Apr 2003 17:13:22 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264450AbTDXVNV
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 24 Apr 2003 17:13:21 -0400
Received: from [12.47.58.68] ([12.47.58.68]:41315 "EHLO pao-ex01.pao.digeo.com")
	by vger.kernel.org with ESMTP id S264397AbTDXVNR (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 24 Apr 2003 17:13:17 -0400
Date: Thu, 24 Apr 2003 14:23:06 -0700
From: Andrew Morton <akpm@digeo.com>
To: jt@hpl.hp.com
Cc: jt@bougret.hpl.hp.com, linux-kernel@vger.kernel.org, jgarzik@pobox.com,
       davem@redhat.com, kuznet@ms2.inr.ac.ru
Subject: Re: [BUG 2.5.X] pipe/fcntl/F_GETFL/F_SETFL obvious kernel bug
Message-Id: <20030424142306.4510d10f.akpm@digeo.com>
In-Reply-To: <20030424183313.GA17374@bougret.hpl.hp.com>
References: <20030424183313.GA17374@bougret.hpl.hp.com>
X-Mailer: Sylpheed version 0.8.9 (GTK+ 1.2.10; i586-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-OriginalArrivalTime: 24 Apr 2003 21:25:19.0037 (UTC) FILETIME=[01602ED0:01C30AA8]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Jean Tourrilhes <jt@bougret.hpl.hp.com> wrote:
>
> 	Hi,
> 
> 	I reported this obvious kernel 2.5.X bug 6 months ago, and as
> of 2.5.67 it is still not fixed. Do you know who I should send this
> bug report to ?

fcntl(fd, F_GETFL, intp) does not put the return value into *intp.  The
flags are in fcntl()'s return value.  Same with 2.4.

#include <unistd.h>
#include <fcntl.h>
#include <errno.h>
#include <stdio.h>

int main()
{
	int trigger_pipe[2];
	int err;
	int flags;
	int newflags;

	pipe(trigger_pipe);

	/* Get flags */
	flags = fcntl(trigger_pipe[0], F_GETFL, NULL);
	fprintf(stderr, "Set flags: 0x%x\n", flags);

	/* Set flags */
	flags |= O_NONBLOCK;
	err = fcntl(trigger_pipe[0], F_SETFL, flags);
	fprintf(stderr, "Set flags: %d\n", err);

	/* Check flags */
	flags = fcntl(trigger_pipe[0], F_GETFL, NULL);
	fprintf(stderr, "Get flags: 0x%0x\n", flags);
}

