Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964775AbWIDLV1@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964775AbWIDLV1 (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 4 Sep 2006 07:21:27 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964777AbWIDLV0
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 4 Sep 2006 07:21:26 -0400
Received: from mtagate3.de.ibm.com ([195.212.29.152]:4428 "EHLO
	mtagate3.de.ibm.com") by vger.kernel.org with ESMTP id S964776AbWIDLVY
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 4 Sep 2006 07:21:24 -0400
Subject: Re: [patch 3/9] Guest page hinting: volatile page cache.
From: Martin Schwidefsky <schwidefsky@de.ibm.com>
Reply-To: schwidefsky@de.ibm.com
To: Dave Hansen <haveblue@us.ibm.com>
Cc: Andy Whitcroft <apw@shadowen.org>, linux-kernel@vger.kernel.org,
       virtualization@lists.osdl.org, akpm@osdl.org, nickpiggin@yahoo.com.au,
       frankeh@watson.ibm.com
In-Reply-To: <1157136106.18728.27.camel@localhost.localdomain>
References: <20060901110948.GD15684@skybase>
	 <1157122667.28577.69.camel@localhost.localdomain>
	 <1157124674.21733.13.camel@localhost>  <44F8563B.3050505@shadowen.org>
	 <1157126640.21733.43.camel@localhost>
	 <1157127483.28577.117.camel@localhost.localdomain>
	 <1157127943.21733.52.camel@localhost>
	 <1157128634.28577.139.camel@localhost.localdomain>
	 <1157129762.21733.63.camel@localhost>
	 <1157130970.28577.150.camel@localhost.localdomain>
	 <1157132520.21733.78.camel@localhost>
	 <1157133780.18728.6.camel@localhost.localdomain>
	 <1157133841.21733.79.camel@localhost>
	 <1157135024.18728.19.camel@localhost.localdomain>
	 <1157135504.21733.83.camel@localhost>
	 <1157136106.18728.27.camel@localhost.localdomain>
Content-Type: text/plain
Organization: IBM Corporation
Date: Mon, 04 Sep 2006 13:21:23 +0200
Message-Id: <1157368883.5078.24.camel@localhost>
Mime-Version: 1.0
X-Mailer: Evolution 2.6.3 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 2006-09-01 at 11:41 -0700, Dave Hansen wrote:
> While something like the following wouldn't be scalable, it would
> functionally work, right?
> 
> +static void __page_discard(struct page *page)
> +{
> +       spin_lock(discard_lock);
> ...
> +       spin_unlock(discard_lock);
> +}
> 
> +void __delete_from_swap_cache(struct page *page)
> +{
> +       spin_lock(discard_lock);
> ...
> +       spin_unlock(discard_lock);
> +}
> 
> +void __remove_from_page_cache(struct page *page)
> +{
> +       spin_lock(discard_lock);
> ...
> +       spin_unlock(discard_lock);
> +}

Any kind of locking won't work. You need the information that a page has
been discarded until the page has been freed. Only then the fact that
the page has been discarded may enter nirvana. Any kind of lock needs to
be freed again to allow the next discard fault to happen. Since you
don't when the last page reference is returned you cannot hold the lock
until the page is free.

-- 
blue skies,
  Martin.

Martin Schwidefsky
Linux for zSeries Development & Services
IBM Deutschland Entwicklung GmbH

"Reality continues to ruin my life." - Calvin.



-- 
VGER BF report: H 0
