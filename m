Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262241AbVAZAMF@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262241AbVAZAMF (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 25 Jan 2005 19:12:05 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262265AbVAZALU
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 25 Jan 2005 19:11:20 -0500
Received: from e33.co.us.ibm.com ([32.97.110.131]:21967 "EHLO
	e33.co.us.ibm.com") by vger.kernel.org with ESMTP id S262264AbVAZAJE
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 25 Jan 2005 19:09:04 -0500
Subject: Re: [PATCH 2/4] page_cache_readahead: remove duplicated code
From: Ram <linuxram@us.ibm.com>
To: Oleg Nesterov <oleg@tv-sign.ru>
Cc: linux-kernel@vger.kernel.org, Steven Pratt <slpratt@austin.ibm.com>,
       Andrew Morton <akpm@osdl.org>
In-Reply-To: <41F63493.309B0ADB@tv-sign.ru>
References: <41F63493.309B0ADB@tv-sign.ru>
Content-Type: text/plain
Organization: IBM 
Message-Id: <1106698119.3298.57.camel@localhost>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.6 
Date: Tue, 25 Jan 2005 16:08:39 -0800
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 2005-01-25 at 03:59, Oleg Nesterov wrote:
> Cases "no ahead window" and "crossed into ahead window"
> can be unified.


No. There is a reason why we had some duplication. With your patch,
we will end up reading-on-demand instead of reading ahead.

When we notice a sequential reads have resumed, we first read in the
data that is requested. 
However if the read request is for more pages than what are being held
in the current window, we make the ahead window as the current window
and read in more pages in the ahead window. Doing that gives the
opportunity of always having pages in the ahead window when the next
sequential read request comes in.  If we apply this patch, we will
always have to read the pages that are being requested instead of
satisfying them from the ahead window.

Ok, if this does not make it clear, here is another way of proving that
your patch does not exactly behave the way it did earlier.

With your patch you will have only one call to
block_page_cache_readahead(), when earlier there could be cases where
block_page_cache_readahead() could be called twice.

Am I am making sense?
RP
 

