Return-Path: <linux-kernel-owner+willy=40w.ods.org-S264258AbUFUPHZ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264258AbUFUPHZ (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 21 Jun 2004 11:07:25 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264266AbUFUPHZ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 21 Jun 2004 11:07:25 -0400
Received: from mx1.redhat.com ([66.187.233.31]:18872 "EHLO mx1.redhat.com")
	by vger.kernel.org with ESMTP id S264258AbUFUPHV (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 21 Jun 2004 11:07:21 -0400
Subject: Re: [2.4] page->buffers vanished in journal_try_to_free_buffers()
From: "Stephen C. Tweedie" <sct@redhat.com>
To: Marcelo Tosatti <marcelo.tosatti@cyclades.com>
Cc: Stephen Tweedie <sct@redhat.com>, Steven Dake <sdake@mvista.com>,
       Stian Jordet <liste@jordet.nu>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       sct@redhat.logos.cnet, Andrew Morton <akpm@osdl.org>,
       Stephen Tweedie <sct@redhat.com>
In-Reply-To: <20040617131600.GB3029@logos.cnet>
References: <1075832813.5421.53.camel@chevrolet.hybel>
	 <Pine.LNX.4.58L.0402052139420.16422@logos.cnet>
	 <1078225389.931.3.camel@buick.jordet>
	 <1087232825.28043.4.camel@persist.az.mvista.com>
	 <20040615131650.GA13697@logos.cnet>
	 <1087322198.8117.10.camel@persist.az.mvista.com>
	 <20040617131600.GB3029@logos.cnet>
Content-Type: text/plain
Organization: 
Message-Id: <1087830410.2719.53.camel@sisko.scot.redhat.com>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.2.2 (1.2.2-5) 
Date: 21 Jun 2004 16:06:50 +0100
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On Thu, 2004-06-17 at 14:16, Marcelo Tosatti wrote:

> Stephen, Andrew, do you have any idea how the buffers could have vanished
> under us with the page locked? That should not be possible. 

No, especially not on UP as Frank reported.  

> I dont see how this "page->buffers = NULL" could be caused by hardware problem, 
> which is usually one or two bit flip.

We don't know for sure that it's page->buffers.  If we have gone round
the bh->b_this_page loop already, we could have ended up following the
pointers either to an invalid bh, or to one that's not on the current
page.  So it could also be the previous buffer's b_this_page that got
clobbered, rather than page->buffers.

That's possible in this case, but it's still a bit surprising that we'd
*always* get a NULL pointer rather than some other random pointer as a
result. 

The buffer-ring debug patch that you posted looks like the obvious way
to dig further into this.  If that doesn't get anyway, we can also trap
the case where following bh->b_this_page gives us a buffer whose b_page
is on a different page.

--Stephen


