Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S318272AbSIBKhq>; Mon, 2 Sep 2002 06:37:46 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S318274AbSIBKhp>; Mon, 2 Sep 2002 06:37:45 -0400
Received: from dsl-213-023-021-067.arcor-ip.net ([213.23.21.67]:37768 "EHLO
	starship") by vger.kernel.org with ESMTP id <S318272AbSIBKho>;
	Mon, 2 Sep 2002 06:37:44 -0400
Content-Type: text/plain; charset=US-ASCII
From: Daniel Phillips <phillips@arcor.de>
To: "Heiko Carstens" <Heiko.Carstens@de.ibm.com>, linux-kernel@vger.kernel.org
Subject: Re: Kernel BUG at page_alloc.c:91! (2.4.19)
Date: Mon, 2 Sep 2002 12:44:49 +0200
X-Mailer: KMail [version 1.3.2]
References: <OF990F4927.6697D5BE-ONC1256C28.002E59F8@de.ibm.com>
In-Reply-To: <OF990F4927.6697D5BE-ONC1256C28.002E59F8@de.ibm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Message-Id: <E17lohO-0004gn-00@starship>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Monday 02 September 2002 10:26, Heiko Carstens wrote:
> Looks to me that this function itself has a bug: after the drop_pte label 
> it is
> checked if the current page has a mapping. If this is true there is a jump 
> to
> the drop_pte label, where without any further checking 
> page_cache_release() gets
> called which will result in the above described BUG() if page_count(page) 

It's not a bug in itself.  The pte was cleared just above, so the reference
being dropped corresponds to the pte that was cleared.  Because the page
has a mapping, there is still at least one count on the page that got there
when the page was put in the page cache, so the page won't be freed just
yet.  (No, this code is not a model of clarity.)

Chances are, you've run into the subtle double-free race I've been working
on for the last few days.  Would you like to try this patch as see if it
makes a difference?

   http://nl.linux.org/~phillips/patches/lru.race-2.4.19


-- 
Daniel
