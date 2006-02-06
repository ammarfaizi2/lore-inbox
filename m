Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750775AbWBFBrm@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750775AbWBFBrm (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 5 Feb 2006 20:47:42 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750778AbWBFBrm
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 5 Feb 2006 20:47:42 -0500
Received: from web33003.mail.mud.yahoo.com ([68.142.206.67]:42355 "HELO
	web33003.mail.mud.yahoo.com") by vger.kernel.org with SMTP
	id S1750775AbWBFBrl (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 5 Feb 2006 20:47:41 -0500
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
  s=s1024; d=yahoo.com;
  h=Message-ID:Received:Date:From:Subject:To:Cc:In-Reply-To:MIME-Version:Content-Type:Content-Transfer-Encoding;
  b=2AjjmVH2qy/Yf7HRqqVh0A8s4lAuomxr8v8L5nAVkLopov5p9QBqmx/OKUcArxRRT7wQCsnJFfEuK4jTtvsLYMQLTV9I1+UM3lqsOJ/f0W+3IqpcAAMKti3Xb7WHDqwQ772DFQsM3mzrxu8P03xmVFLILnV0hBZSvYqG/yD1//Y=  ;
Message-ID: <20060206014739.82993.qmail@web33003.mail.mud.yahoo.com>
Date: Sun, 5 Feb 2006 17:47:39 -0800 (PST)
From: Shantanu Goel <sgoel01@yahoo.com>
Subject: Re: [VM PATCH] rotate_reclaimable_page fails frequently
To: Rik van Riel <riel@surriel.com>
Cc: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
       linux-mm@kvack.org
In-Reply-To: <Pine.LNX.4.61L.0602051138260.26086@imladris.surriel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> The question is, why is the page not yet back on the
> LRU by the time the data write completes ?
> 

One possibility is that dirtiness is being tracked by
buffers which are clean.  When writepage() notices
that it simply marks the page clean and calls
end_page_writeback() which then calls
rotate_reclaimable_page() before the page scanner has
had the chance to put the page back on the LRU.

> Surely a disk IO is slow enough that the page will
> have been put on the LRU milliseconds before the IO
> completes ?
> 

Agreed but if the scenario I described above is
possible, there would essentially be no delay.  I have
not examined the ext3 code paths closely.  Perhaps
someone on the list can verify if this can happen. 
The statistics seem to clearly indicate that writeback
can complete before the scanner gets a chance to put
the page back.

> In what kind of configuration do you run into this
> problem ?

Not sure what you looking for here but there is
nothing unusual on this machine that I can think of. 
The machine runs Ubuntu Breezy with Gnome.  To force 
that particular VM code path, I wrote a simple program
that gobbled a lot of mmap'ed memory and then ran the
dd test.  The only VM parameter I adjusted was
swappiness which I set to 55 instead of the default
60.

Shantanu


__________________________________________________
Do You Yahoo!?
Tired of spam?  Yahoo! Mail has the best spam protection around 
http://mail.yahoo.com 
