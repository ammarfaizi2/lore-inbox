Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751058AbWBJEOP@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751058AbWBJEOP (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 9 Feb 2006 23:14:15 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751059AbWBJEOP
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 9 Feb 2006 23:14:15 -0500
Received: from smtp.osdl.org ([65.172.181.4]:40080 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S1751057AbWBJEOO (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 9 Feb 2006 23:14:14 -0500
Date: Thu, 9 Feb 2006 20:13:33 -0800
From: Andrew Morton <akpm@osdl.org>
To: Nick Piggin <nickpiggin@yahoo.com.au>
Cc: linux@horizon.com, linux-kernel@vger.kernel.org, sct@redhat.com
Subject: Re: msync() behaviour broken for MS_ASYNC, revert patch?
Message-Id: <20060209201333.62db0e24.akpm@osdl.org>
In-Reply-To: <43EC0F3F.1000805@yahoo.com.au>
References: <20060209071832.10500.qmail@science.horizon.com>
	<20060209001850.18ca135f.akpm@osdl.org>
	<43EAFEB9.2060000@yahoo.com.au>
	<20060209004208.0ada27ef.akpm@osdl.org>
	<43EB3801.70903@yahoo.com.au>
	<20060209094815.75041932.akpm@osdl.org>
	<43EC0A44.1020302@yahoo.com.au>
	<20060209195035.5403ce95.akpm@osdl.org>
	<43EC0F3F.1000805@yahoo.com.au>
X-Mailer: Sylpheed version 1.0.4 (GTK+ 1.2.10; i386-redhat-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Nick Piggin <nickpiggin@yahoo.com.au> wrote:
>
>  I don't think anyone would use MS_ASYNC for anything other than
>  performance improvement, so it is not like we need super well
>  defined behaviour... the earlier it will start IO AFAIKS the better.

Well, no.  Consider a continuously-running application which modifies its
data store via MAP_SHARED+msync(MS_ASYNC).  If the msync() immediately
started I/O, the disk would be seeking all over the place all the time.  The
queue merging and timer-based unplugging would help here, but it won't be
as good as a big, infrequent ascending-file-offset pdflush pass.

Secondly, consider the behaviour of the above application if it is modifying
the same page relatively frequently (quite likely).  If MS_ASYNC starts I/O
immediately, that page will get written 10, 100 or 1000 times per second. 
If MS_ASYNC leaves it to pdflush, that page gets written once per 30
seconds, so we do far much less I/O.

We just don't know.  It's better to leave it up to the application designer
rather than lumping too many operations into the one syscall.
