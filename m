Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932452AbVKGHf0@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932452AbVKGHf0 (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 7 Nov 2005 02:35:26 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932447AbVKGHf0
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 7 Nov 2005 02:35:26 -0500
Received: from zproxy.gmail.com ([64.233.162.207]:47039 "EHLO zproxy.gmail.com")
	by vger.kernel.org with ESMTP id S932450AbVKGHfZ convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 7 Nov 2005 02:35:25 -0500
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=KIAkX/+4iJL1z0QsepKdgCdWL7fL7wnosWBdHbLIX1lJdNLx0yEWTX/t2HQ4x8cTsEAgAwSu+y6nfYMQzeeNCUHvXqD059+eae5gaH6CYIU0NLmEVEyzDB1azSqKLvQCmpuJdSLdbBqMBJodv4vpIzhjYOIvUlHdxFGLMX66HlU=
Message-ID: <aec7e5c30511062335n96c229bve39f614bb8fc7e73@mail.gmail.com>
Date: Mon, 7 Nov 2005 16:35:25 +0900
From: Magnus Damm <magnus.damm@gmail.com>
To: Christoph Lameter <clameter@sgi.com>
Subject: Re: [PATCH 1/5] Swap Migration V5: LRU operations
Cc: torvalds@osdl.org, akpm@osdl.org,
       Marcelo Tosatti <marcelo.tosatti@cyclades.com>,
       Mike Kravetz <kravetz@us.ibm.com>,
       Ray Bryant <raybry@mpdtxmail.amd.com>,
       Lee Schermerhorn <lee.schermerhorn@hp.com>,
       linux-kernel@vger.kernel.org, Paul Jackson <pj@sgi.com>,
       Dave Hansen <haveblue@us.ibm.com>,
       KAMEZAWA Hiroyuki <kamezawa.hiroyu@jp.fujitsu.com>
In-Reply-To: <20051101031244.12488.38211.sendpatchset@schroedinger.engr.sgi.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Content-Disposition: inline
References: <20051101031239.12488.76816.sendpatchset@schroedinger.engr.sgi.com>
	 <20051101031244.12488.38211.sendpatchset@schroedinger.engr.sgi.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 11/1/05, Christoph Lameter <clameter@sgi.com> wrote:
[snip]
> +static inline int
> +__isolate_lru_page(struct zone *zone, struct page *page)
> +{
> +       if (TestClearPageLRU(page)) {
> +               if (get_page_testone(page)) {
> +                       /*
> +                        * It is being freed elsewhere
> +                        */
> +                       __put_page(page);
> +                       SetPageLRU(page);
> +                       return -ENOENT;

Ok, -ENOENT..

> -static int isolate_lru_pages(int nr_to_scan, struct list_head *src,
> -                            struct list_head *dst, int *scanned)
> +static int isolate_lru_pages(struct zone *zone, int nr_to_scan,
> +                            struct list_head *src, struct list_head *dst)
[snip]
> +               switch (__isolate_lru_page(zone, page)) {
> +               case 1:
> +                       /* Succeeded to isolate page */
>                         list_add(&page->lru, dst);
> -                       nr_taken++;
> +                       break;
> +               case -1:
> +                       /* Not possible to isolate */
> +                       list_move(&page->lru, src);
> +                       break;
> +               default:
> +                       BUG();

Huh, -1?

It looks like the V4 to V5 upgrade added -ENOENT as return value to
__isolate_lru_page(), but did not change the code in
isolate_lru_pages().

The fix for this is simple, but maybe something else needs to be
changed too or I'm misunderstanding what is happening here.

Andrew, this looks like a showstopper for 2.6.14-mm1.

/ magnus
