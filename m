Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261543AbVAGTTS@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261543AbVAGTTS (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 7 Jan 2005 14:19:18 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261536AbVAGTS1
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 7 Jan 2005 14:18:27 -0500
Received: from [195.23.16.24] ([195.23.16.24]:8845 "EHLO
	bipbip.comserver-pie.com") by vger.kernel.org with ESMTP
	id S261543AbVAGTPo (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 7 Jan 2005 14:15:44 -0500
Message-ID: <41DEDF87.8080809@grupopie.com>
Date: Fri, 07 Jan 2005 19:14:15 +0000
From: Paulo Marques <pmarques@grupopie.com>
Organization: Grupo PIE
User-Agent: Mozilla Thunderbird 0.7.1 (X11/20040626)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Vladimir Saveliev <vs@namesys.com>
Cc: linux-mm <linux-mm@kvack.org>, Andrew Morton <akpm@osdl.org>,
       "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
       Christoph Hellwig <hch@infradead.org>
Subject: Re: [RFC] per thread page reservation patch
References: <20050103011113.6f6c8f44.akpm@osdl.org>	 <20050103114854.GA18408@infradead.org> <41DC2386.9010701@namesys.com>	 <1105019521.7074.79.camel@tribesman.namesys.com>	 <20050107144644.GA9606@infradead.org> <1105118217.3616.171.camel@tribesman.namesys.com>
In-Reply-To: <1105118217.3616.171.camel@tribesman.namesys.com>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Vladimir Saveliev wrote:
> [...]
> +	if (order == 0) {
> +		page = perthread_pages_alloc();
> +		if (page != NULL)
> +			return page;
> +	}

I hope this has not been extensively discussed yet, and I missed the 
thread but, does everybody think this is a good thing?

This seems like a very asymmetrical behavior. If the code explicitly 
reserves pages, it should explicitly use them, or it will become 
impossible to track down who is using what (not to mention that this 
will slow down every regular user of __alloc_pages, even if it is just 
for a quick test).

Why are there specialized functions to reserve the pages, but then they 
are used through the standard __alloc_pages interface?

At the very least this test should be moved to the very beginning of the 
function. It is of no use to calculate "can_try_harder" before running 
this code if it will use a reserved page.

Having a specialized function to get the reserved pages, would also make 
the logic in "perthread_pages_reserve" more clear (i.e., that comment 
would become unnecessary), and lose the test to "in_interrupt()" in 
"perthread_pages_alloc", if I'm reading this correctly.

-- 
Paulo Marques - www.grupopie.com

"A journey of a thousand miles begins with a single step."
Lao-tzu, The Way of Lao-tzu
