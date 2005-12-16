Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932094AbVLPDeh@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932094AbVLPDeh (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 15 Dec 2005 22:34:37 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932095AbVLPDeh
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 15 Dec 2005 22:34:37 -0500
Received: from straum.hexapodia.org ([64.81.70.185]:38204 "EHLO
	straum.hexapodia.org") by vger.kernel.org with ESMTP
	id S932094AbVLPDeg (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 15 Dec 2005 22:34:36 -0500
Date: Thu, 15 Dec 2005 19:34:35 -0800
From: Andy Isaacson <adi@hexapodia.org>
To: Jan Engelhardt <jengelh@linux01.gwdg.de>
Cc: Jesper Juhl <jesper.juhl@gmail.com>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       David Woodhouse <dwmw2@infradead.org>, jffs-dev@axis.com,
       Andrew Morton <akpm@osdl.org>
Subject: Re: [PATCH] Reduce nr of ptr derefs in fs/jffs2/summary.c
Message-ID: <20051216033435.GA21600@hexapodia.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.61.0512152354240.13568@yvahk01.tjqt.qr>
User-Agent: Mutt/1.4.2i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Dec 15, 2005 at 11:55:05PM +0100, Jan Engelhardt wrote:
> >Benefits:
> > - micro speed optimization due to fewer pointer derefs
> > - generated code is slightly smaller
> 
> Should not these two at best be done by the compiler?

The compiler cannot, in general, do CSE on pointer dereferences.
Consider the following snippet from fs/jffs2/summary.c, both before

 610    sdrnt_ptr->type = c->summary->sum_list_head->d.type;
 612    memcpy(sdrnt_ptr->name, c->summary->sum_list_head->d.name,
 613                            c->summary->sum_list_head->d.nsize);
 615    wpage += JFFS2_SUMMARY_DIRENT_SIZE(c->summary->sum_list_head->d.nsize);

and after Jesper's patch:

 611    sdrnt_ptr->type = temp->d.type;
 613    memcpy(sdrnt_ptr->name, temp->d.name,
 614                            temp->d.nsize);
 616    wpage += JFFS2_SUMMARY_DIRENT_SIZE(temp->d.nsize);

Assuming that memcpy is an out-of-line function, the compiler has to
handle the worst case, that it might modify c->summary->sum_list_head
and thus make the saved value stale.  (In the specific case of memcpy
the compiler can take advantage of special knowledge about the function,
and it's probably inline anyways, so this *particular* example is not
real; but it's a nice clean classroom example.)

But a human *can* make the obvious leap and tell the compiler that the
value can be computed once and then saved.  And besides, isn't the code
just *much* nicer to look at, above?

-andy
