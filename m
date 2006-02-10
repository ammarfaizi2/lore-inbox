Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751176AbWBJHcE@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751176AbWBJHcE (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 10 Feb 2006 02:32:04 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751177AbWBJHcD
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 10 Feb 2006 02:32:03 -0500
Received: from smtp.osdl.org ([65.172.181.4]:49843 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S1751176AbWBJHcB (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 10 Feb 2006 02:32:01 -0500
Date: Thu, 9 Feb 2006 23:28:01 -0800
From: Andrew Morton <akpm@osdl.org>
To: linux@horizon.com
Cc: nickpiggin@yahoo.com.au, linux-kernel@vger.kernel.org, linux@horizon.com,
       sct@redhat.com
Subject: Re: msync() behaviour broken for MS_ASYNC, revert patch?
Message-Id: <20060209232801.24e17531.akpm@osdl.org>
In-Reply-To: <20060210071504.31345.qmail@science.horizon.com>
References: <20060209201333.62db0e24.akpm@osdl.org>
	<20060210071504.31345.qmail@science.horizon.com>
X-Mailer: Sylpheed version 1.0.4 (GTK+ 1.2.10; i386-redhat-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

linux@horizon.com wrote:
>
> > Well, no.  Consider a continuously-running application which modifies its
>  > data store via MAP_SHARED+msync(MS_ASYNC).  If the msync() immediately
>  > started I/O, the disk would be seeking all over the place all the time.  The
>  > queue merging and timer-based unplugging would help here, but it won't be
>  > as good as a big, infrequent ascending-file-offset pdflush pass.
>  >
>  > Secondly, consider the behaviour of the above application if it is modifying
>  > the same page relatively frequently (quite likely).  If MS_ASYNC starts I/O
>  > immediately, that page will get written 10, 100 or 1000 times per second. 
>  > If MS_ASYNC leaves it to pdflush, that page gets written once per 30
>  > seconds, so we do far much less I/O.
> 
>  You're assuming a brain-dead application.

We've covered this.  Handing pte-dirty pages over to pdflush for prompt
writeback is a perfectly valid, sensible and fast thing to do.

It efficiently solves the single biggest problem with using MAP_SHARED
instead of write().

>  As I said, I'm actively looking for a way, on Linux 2.6.x, x <= 15,
>  to start disk writes on part of an mmapped file without either blocking
>  (yet)

I cannot think of a way, sorry.

> or writing other dirty pages that aren't complete yet.

msync() will write all of the file's dirty pages and it has always has done
that.
