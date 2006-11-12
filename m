Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1753506AbWKLXqA@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753506AbWKLXqA (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 12 Nov 2006 18:46:00 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753511AbWKLXqA
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 12 Nov 2006 18:46:00 -0500
Received: from smtp.osdl.org ([65.172.181.4]:58259 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S1753506AbWKLXp7 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 12 Nov 2006 18:45:59 -0500
Date: Sun, 12 Nov 2006 15:45:53 -0800
From: Andrew Morton <akpm@osdl.org>
To: Nick Orlov <bugfixer@list.ru>
Cc: linux-kernel <linux-kernel@vger.kernel.org>,
       Nick Piggin <nickpiggin@yahoo.com.au>
Subject: Re: 2.6.19-rc4-mm1: writev() _functional_ regression
Message-Id: <20061112154553.459d6a63.akpm@osdl.org>
In-Reply-To: <20061112223024.GA4104@nickolas.homeunix.com>
References: <20061112223024.GA4104@nickolas.homeunix.com>
X-Mailer: Sylpheed version 2.2.7 (GTK+ 2.8.17; x86_64-unknown-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 12 Nov 2006 17:30:24 -0500
Nick Orlov <bugfixer@list.ru> wrote:

> Andrew,
> 
> Somewhere in between 2.6.18-mm3 and 2.6.19-rc4-mm1 writev() got screwed.
> It does not accept zero-length segments anymore.
> 
> Bad thing that it is extremely easy to trigger (even w/o explicit writev calls).
> For example the following innocent program will fail with 2.6.19-rc4-mm1:
> 
> ======================
> #include <string.h>
> #include <fstream>
> 
> int main()
> {
>   char buf[1024];
>   memset(buf, 'A', sizeof(buf));
>   std::ofstream ofs("test");
>   //ofs << 1 << '\n';
>   ofs.write(buf, sizeof(buf));
>   return 0;
> }
> ======================
> 
> 
> Here is the corresponding part if strace:
> 
> ======================
> open("test", O_WRONLY|O_CREAT|O_TRUNC|O_LARGEFILE, 0666) = 3
> writev(3, [{NULL, 0}, {"AAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAA"..., 1024}], 2) = -1 EFAULT (Bad address)
> close(3)                                = 0
> ======================
> 
> 
> With 2.6.18-mm3 it works
> 
> ======================
> open("test", O_WRONLY|O_CREAT|O_TRUNC|O_LARGEFILE, 0666) = 3
> writev(3, [{NULL, 0}, {"AAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAA"..., 1024}], 2) = 1024
> close(3)                                = 0
> ======================
> 
> 
> It works with 2.6.19-rc4-mm1 _if_ zero-length segments are eliminated
> (by uncommenting ofs << 1 << '\n'):
> 
> ======================
> open("test", O_WRONLY|O_CREAT|O_TRUNC|O_LARGEFILE, 0666) = 3
> writev(3, [{"1\n", 2}, {"AAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAA"..., 1024}], 2) = 1026
> close(3)                                = 0
> ======================
> 
> 
> Given that _all_ applications using C++ streams are potentially affected
> I think it's better to preserve the previous behavior even if it is
> something from "undefined behavior world" (or a plain bug).
> 
> The bug is quite dangerous (I was really close to wipe out my mp3 collection).
> 

OK, thanks.  Those patches do need more work.  I'll shelve them for a while.
