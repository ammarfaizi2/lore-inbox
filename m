Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264855AbUAJAxf (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 9 Jan 2004 19:53:35 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264874AbUAJAxf
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 9 Jan 2004 19:53:35 -0500
Received: from e6.ny.us.ibm.com ([32.97.182.106]:6849 "EHLO e6.ny.us.ibm.com")
	by vger.kernel.org with ESMTP id S264855AbUAJAxX (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 9 Jan 2004 19:53:23 -0500
Subject: Re: 2.6.1 sendfile regression
From: Ram Pai <linuxram@us.ibm.com>
To: Andrew Morton <akpm@osdl.org>
Cc: Felix von Leitner <felix-kernel@fefe.de>, linux-kernel@vger.kernel.org
In-Reply-To: <20040109162149.1e88a643.akpm@osdl.org>
References: <20040110000128.GA301@codeblau.de>
	 <20040109162149.1e88a643.akpm@osdl.org>
Content-Type: text/plain
Organization: 
Message-Id: <1073695921.14637.284.camel@dyn319250.beaverton.ibm.com>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.2.2 (1.2.2-5) 
Date: 09 Jan 2004 16:52:02 -0800
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 2004-01-09 at 16:21, Andrew Morton wrote:
 
> Probably it is the ill-advised readahead tweak.  Does the below patch fix
> it up?
> 
> diff -puN mm/filemap.c~a mm/filemap.c
> --- 25/mm/filemap.c~a	Fri Jan  9 16:20:32 2004
> +++ 25-akpm/mm/filemap.c	Fri Jan  9 16:20:46 2004
> @@ -596,12 +596,6 @@ void do_generic_mapping_read(struct addr
>  	offset = *ppos & ~PAGE_CACHE_MASK;
>  	last = (*ppos + desc->count) >> PAGE_CACHE_SHIFT;
>  
> -	/*
> -	 * Let the readahead logic know upfront about all
> -	 * the pages we'll need to satisfy this request
> -	 */
> -	for (; index < last; index++)
> -		page_cache_readahead(mapping, ra, filp, index);
>  	index = *ppos >> PAGE_CACHE_SHIFT;
>  
>  	for (;;) {
> 

There is a small mistake in Andrew's patch.  The call to
page_cache_readahead() is missing.

Try this one.


*** linux-2.6.1-rc2/mm/filemap.c        Fri Jan  9 00:47:04 2004
--- linux-2.6.1-rc2/mm/filemap.c.1      Fri Jan  9 00:46:43 2004
***************
*** 587,608 ****
                             read_actor_t actor)
  {
        struct inode *inode = mapping->host;
!       unsigned long index, offset, last;
        struct page *cached_page;
        int error;

        cached_page = NULL;
        index = *ppos >> PAGE_CACHE_SHIFT;
        offset = *ppos & ~PAGE_CACHE_MASK;
-       last = (*ppos + desc->count) >> PAGE_CACHE_SHIFT;
- 
-       /*
-        * Let the readahead logic know upfront about all
-        * the pages we'll need to satisfy this request
-        */
-       for (; index < last; index++)
-               page_cache_readahead(mapping, ra, filp, index);
-       index = *ppos >> PAGE_CACHE_SHIFT;

        for (;;) {
                struct page *page;
--- 587,599 ----
                             read_actor_t actor)
  {
        struct inode *inode = mapping->host;
!       unsigned long index, offset;
        struct page *cached_page;
        int error;

        cached_page = NULL;
        index = *ppos >> PAGE_CACHE_SHIFT;
        offset = *ppos & ~PAGE_CACHE_MASK;

        for (;;) {
                struct page *page;
***************
*** 621,626 ****
--- 612,618 ----
                }

                cond_resched();
+               page_cache_readahead(mapping, ra, filp, index);

                nr = nr - offset;
  find_page:



> _
> 
> 

