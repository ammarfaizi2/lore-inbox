Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932247AbVJSDDO@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932247AbVJSDDO (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 18 Oct 2005 23:03:14 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932430AbVJSDDN
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 18 Oct 2005 23:03:13 -0400
Received: from zproxy.gmail.com ([64.233.162.201]:61050 "EHLO zproxy.gmail.com")
	by vger.kernel.org with ESMTP id S932247AbVJSDDN (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 18 Oct 2005 23:03:13 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:reply-to:to:subject:date:user-agent:cc:references:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:message-id:from;
        b=DpOVYgZ2ARZvTONWApO8zz41jj9yf3AH/CtpeTUchID5TqJZgVxoYX6ifreSdlu7HlEgW0b1TzM6nr8NQ6gAAafHdBI0xs3glMwwZMLvWpexalOAG1TatAoyKokZ8mFD/yNDwpOgCBAUFejeV4W2tjyNaaWwheav+DSWIEY9pL0=
Reply-To: ajwade@cpe001346162bf9-cm0011ae8cd564.cpe.net.cable.rogers.com
To: Guido Fiala <gfiala@s.netic.de>
Subject: Re: large files unnecessary trashing filesystem cache?
Date: Tue, 18 Oct 2005 23:02:59 -0400
User-Agent: KMail/1.8.3
Cc: linux-kernel@vger.kernel.org
References: <200510182201.11241.gfiala@s.netic.de>
In-Reply-To: <200510182201.11241.gfiala@s.netic.de>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200510182302.59604.ajwade@cpe001346162bf9-cm0011ae8cd564.cpe.net.cable.rogers.com>
From: Andrew James Wade <andrew.j.wade@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tuesday 18 October 2005 16:01, Guido Fiala wrote:
> (please note, i'am not subscribed to the list, please CC me on reply)
> 
> Story:
> Once in while we have a discussion at the vdr (video disk recorder) mailing 
> list about very large files trashing the filesystems memory cache leading to 
> unnecessary delays accessing directory contents no longer cached.
> 
> This program and certainly all applications that deal with very large files 
> only read once (much larger than usual memory)  - it happens that all other 
> cached blocks of the filessystem are removed from memory solely to keep as 
> much as possible of that file in memory, which seems to be a bad strategy in 
> most situations.

     For this particular workload, a heuristic to detect streaming and drop
pages a few mb back from currently accessed pages would probably work well.
I believe the second part is already in the kernel (activated by an f-advise
 call), but the heuristic is lacking.

> Of course one could always implement f_advise-calls in all applications, but i 
> suggest a discussion if a maximum (configurable) in-memory-cache on a 
> per-file base should be implemented in linux/mm or where this belongs.
> 
> My guess was, it has something to do with mm/readahead.c, a test limiting the 
> result of the function "max_sane_readahead(...) to 8 MBytes as a quick and 
> dirty test did not solve the issue, but i might have done something wrong.
> 
> I've searched the archive but could not find a previous discussion - is this a 
> new idea?

I'd do searches on thrashing control and swap tokens. The problem with
thrashing is similar: a process accessing large amounts of memory in a short
period of time blowing away the caches. And the solution should be similar:
penalize the process doing so by preferentially reclaiming it's pages. 

> It would be interesting to discuss if and when this proposed feature could 
> lead to better performance or has any unwanted side effects.

Sometimes you want a single file to take up most of the memory; databases
spring to mind. Perhaps files/processes that take up a large proportion of
memory should be penalized by preferentially reclaiming their pages, but
limit the aggressiveness so that they can still take up most of the memory
if sufficiently persistent (and the rest of the system isn't thrashing).

> 
> Thanks for ideas on that issue.
> -
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/
> 
> 
