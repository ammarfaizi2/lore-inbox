Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261326AbVFAVr4@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261326AbVFAVr4 (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 1 Jun 2005 17:47:56 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261325AbVFAVrY
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 1 Jun 2005 17:47:24 -0400
Received: from twinlark.arctic.org ([207.7.145.18]:43749 "EHLO
	twinlark.arctic.org") by vger.kernel.org with ESMTP id S261312AbVFAVqh
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 1 Jun 2005 17:46:37 -0400
Date: Wed, 1 Jun 2005 14:46:36 -0700 (PDT)
From: dean gaudet <dean-list-linux-kernel@arctic.org>
To: Denis Vlasenko <vda@ilport.com.ua>
cc: michael@optusnet.com.au, Andi Kleen <ak@muc.de>,
       Jeff Garzik <jgarzik@pobox.com>, Benjamin LaHaise <bcrl@kvack.org>,
       linux-kernel@vger.kernel.org
Subject: Re: [RFC] x86-64: Use SSE for copy_page and clear_page
In-Reply-To: <200506011048.31537.vda@ilport.com.ua>
Message-ID: <Pine.LNX.4.62.0506011442520.1402@twinlark.arctic.org>
References: <20050530181626.GA10212@kvack.org> <20050531092358.GA9372@muc.de>
 <m2zmuaee2z.fsf@mo.optusnet.com.au> <200506011048.31537.vda@ilport.com.ua>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Wed, 1 Jun 2005, Denis Vlasenko wrote:

> However, it is valid only if program writes in every byte in a cacheline.
> Then sufficiently smart CPU may avoid reading from main RAM.
> (I am not sure that today's CPUs are smart enough. K6s were not)

nobody does this yet on regular stores...

so-called "non-temporal" stores actually go through the write-combiners 
(which is why Andi is referring to them as write-combining stores)... the 
write-combiners have byte-enables so they can detect if a full line is 
dirty or not.

in the event a write-combiner is flushed before it's full, the behaviour 
i've measured on all k8/p-m/p4 is to do a read-modify-write *at the memory 
interface*.  this occurs at typically a much slower cycle rate than it 
would in the cache itself... in theory DDR supports a byte-enabled write 
to memory, and there should be no need to do a read-modify-write sequence. 
however all of these processors (and/or their northbridges as appropriate) 
save pins on their package -- they don't have any pins for the DDR byte 
enables (they're hardwired to enabled on the mobo).

(you can see this behaviour with any of the movnt or with maskmov ... just 
leave holes in the lines and watch the store cost go through the roof.)

-dean
