Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262601AbVCKIIl@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262601AbVCKIIl (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 11 Mar 2005 03:08:41 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263237AbVCKIIk
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 11 Mar 2005 03:08:40 -0500
Received: from 168.imtp.Ilyichevsk.Odessa.UA ([195.66.192.168]:10245 "HELO
	port.imtp.ilyichevsk.odessa.ua") by vger.kernel.org with SMTP
	id S262601AbVCKIIi (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 11 Mar 2005 03:08:38 -0500
From: Denis Vlasenko <vda@port.imtp.ilyichevsk.odessa.ua>
To: Christoph Lameter <clameter@sgi.com>, Dave Hansen <haveblue@us.ibm.com>,
       Andi Kleen <ak@muc.de>
Subject: Re: [PATCH] add a clear_pages function to clear pages of higher order
Date: Fri, 11 Mar 2005 10:08:11 +0200
User-Agent: KMail/1.5.4
Cc: Andrew Morton <akpm@osdl.org>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       Mel Gorman <mel@csn.ul.ie>
References: <Pine.LNX.4.58.0503101229420.13911@schroedinger.engr.sgi.com> <1110490683.24355.17.camel@localhost> <Pine.LNX.4.58.0503101702120.15940@schroedinger.engr.sgi.com>
In-Reply-To: <Pine.LNX.4.58.0503101702120.15940@schroedinger.engr.sgi.com>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="koi8-r"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200503111008.12134.vda@port.imtp.ilyichevsk.odessa.ua>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Friday 11 March 2005 03:03, Christoph Lameter wrote:
> Changelog:
> - use Kconfig and CONFIG_CLEAR_PAGES
> 
> The zeroing of a page of a arbitrary order in page_alloc.c and in hugetlb.c may benefit from a
> clear_page that is capable of zeroing multiple pages at once. The following patch adds
> a function "clear_pages" that is capable of clearing multiple continuous pages at once.
> 
> Patch against 2.6.11-bk6
> 
> Signed-off-by: Christoph Lameter <clameter@sgi.com>
[snip]
> -clear_page_end:
> +clear_pages_end:
> 
>  	/* C stepping K8 run faster using the string instructions.
>  	   It is also a lot simpler. Use this when possible */

Andi Kleen (iirc) says that non-temporal stores seem to be
big win in microbenchmarks (and I second that), but they are
a net loss when we are going to use zeroed page just after
zeroing. He recommends avoid using non-temporal stores

With this new page prezeroing infrastructure, that argument
most likely is not right anymore. Especially clearing of
high-order pages definitely will benefit from NT stores
because they do not kill L1 data cache in the process.

I don't have K8 and therefore cannot be 100% sure, but
I really doubt that K8 optimize "rep stosq" into _NT_ stores.

Andi?
--
vda

