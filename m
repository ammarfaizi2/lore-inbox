Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264339AbUAJAVI (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 9 Jan 2004 19:21:08 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264414AbUAJAVI
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 9 Jan 2004 19:21:08 -0500
Received: from fw.osdl.org ([65.172.181.6]:33749 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S264339AbUAJAVG (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 9 Jan 2004 19:21:06 -0500
Date: Fri, 9 Jan 2004 16:21:49 -0800
From: Andrew Morton <akpm@osdl.org>
To: Felix von Leitner <felix-kernel@fefe.de>
Cc: linux-kernel@vger.kernel.org, Ram Pai <linuxram@us.ibm.com>
Subject: Re: 2.6.1 sendfile regression
Message-Id: <20040109162149.1e88a643.akpm@osdl.org>
In-Reply-To: <20040110000128.GA301@codeblau.de>
References: <20040110000128.GA301@codeblau.de>
X-Mailer: Sylpheed version 0.9.7 (GTK+ 1.2.10; i586-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Felix von Leitner <felix-kernel@fefe.de> wrote:
>
> I'm getting a huge sendfile regression in 2.6.1; when serving a large
> file on an IPv4 TCP socket via sendfile64, the transfer starts at about
> 4 MB (2.6.0: >7 MB) and the hard disk like stays on 100% (which normally
> only happens if the file is badly fragmented, fragmentation of this file
> is 0%).  Then, suddenly, the network performance drops dramatically,
> getting worse and worse.  strace shows that the process is hanging
> inside sendfile64 (which should not happen since the socket is
> non-blocking).  The process then stays inside sendfile for up to a
> minute or so and can't be interrupted or killed in that time.
> 

Probably it is the ill-advised readahead tweak.  Does the below patch fix
it up?

diff -puN mm/filemap.c~a mm/filemap.c
--- 25/mm/filemap.c~a	Fri Jan  9 16:20:32 2004
+++ 25-akpm/mm/filemap.c	Fri Jan  9 16:20:46 2004
@@ -596,12 +596,6 @@ void do_generic_mapping_read(struct addr
 	offset = *ppos & ~PAGE_CACHE_MASK;
 	last = (*ppos + desc->count) >> PAGE_CACHE_SHIFT;
 
-	/*
-	 * Let the readahead logic know upfront about all
-	 * the pages we'll need to satisfy this request
-	 */
-	for (; index < last; index++)
-		page_cache_readahead(mapping, ra, filp, index);
 	index = *ppos >> PAGE_CACHE_SHIFT;
 
 	for (;;) {

_

