Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261157AbVEPAXi@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261157AbVEPAXi (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 15 May 2005 20:23:38 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261194AbVEPAXi
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 15 May 2005 20:23:38 -0400
Received: from cpu1185.adsl.bellglobal.com ([207.236.110.166]:39953 "EHLO
	mail.rtr.ca") by vger.kernel.org with ESMTP id S261157AbVEPAXg
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 15 May 2005 20:23:36 -0400
Message-ID: <4287E807.6070502@rtr.ca>
Date: Sun, 15 May 2005 20:23:35 -0400
From: Mark Lord <lkml@rtr.ca>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.7.7) Gecko/20050420 Debian/1.7.7-2
X-Accept-Language: en, en-us
MIME-Version: 1.0
To: Denis Vlasenko <vda@ilport.com.ua>
Cc: mhw@wittsend.com, linux-kernel@vger.kernel.org
Subject: Re: Sync option destroys flash!
References: <1116001207.5239.38.camel@localhost.localdomain> <200505152200.26432.vda@ilport.com.ua>
In-Reply-To: <200505152200.26432.vda@ilport.com.ua>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

All flashcards (other than dumb "smart media" cards) have integrated
NAND controllers which perform automatic page/block remapping and
which implement various wear-leveling algorithms.  Rewriting "Sector 0"
10000 times probably only writes once to the first sector of a 1GB card.
The other writes are spread around the rest of the card, and remapped
logically by the integrated controller.

Linux could be more clever about it all, though.  Wear-leveling can only
be done efficiently on "unused" or "rewritten" blocks/pages on the cards,
and not so well with areas that hold large static data files (from the point
of view of the flash controller, not the O/S).

If we were really clever about it, then when Linux deletes a file from a
flashcard device, it would also issue CFA ERASE commands for the newly
freed sectors.  This would let the card's controller know that it can
remap/reuse that area of the card as it sees fit.

But it's dubious that a *short term* use (minutes/hours) of O_SYNC
would have killed a new 1GB card.

Cheers
