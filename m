Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261290AbVBNXxj@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261290AbVBNXxj (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 14 Feb 2005 18:53:39 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261388AbVBNXxj
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 14 Feb 2005 18:53:39 -0500
Received: from omx2-ext.sgi.com ([192.48.171.19]:51328 "EHLO omx2.sgi.com")
	by vger.kernel.org with ESMTP id S261290AbVBNXuf (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 14 Feb 2005 18:50:35 -0500
Message-ID: <42113921.7070807@sgi.com>
Date: Mon, 14 Feb 2005 17:49:53 -0600
From: Ray Bryant <raybry@sgi.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.7.2) Gecko/20040805 Netscape/7.2
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Andi Kleen <ak@muc.de>
CC: Robin Holt <holt@sgi.com>, Marcelo Tosatti <marcelo.tosatti@cyclades.com>,
       Ray Bryant <raybry@austin.rr.com>, linux-mm <linux-mm@kvack.org>,
       linux-kernel <linux-kernel@vger.kernel.org>
Subject: Re: [RFC 2.6.11-rc2-mm2 0/7] mm: manual page migration -- overview
References: <20050212032535.18524.12046.26397@tomahawk.engr.sgi.com> <m1vf8yf2nu.fsf@muc.de> <20050212155426.GA26714@logos.cnet> <20050212212914.GA51971@muc.de> <20050214163844.GB8576@lnx-holt.americas.sgi.com> <20050214191509.GA56685@muc.de>
In-Reply-To: <20050214191509.GA56685@muc.de>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Andi Kleen wrote:
>>But how do you use mbind() to change the memory placement for an anonymous
>>private mapping used by a vendor provided executable with mbind()?
> 
> 
> For that you use set_mempolicy.
> 
> -Andi
> --
> To unsubscribe, send a message with 'unsubscribe linux-mm' in
> the body to majordomo@kvack.org.  For more info on Linux MM,
> see: http://www.linux-mm.org/ .
> Don't email: <a href=mailto:"aart@kvack.org"> aart@kvack.org </a>
> 

Andi,

If all processes are guarenteed to use the NUMA api for memory placement,
then AFAIK one could, in principle, imbed the migration of pages into
the NUMA api as you propose.  The problem is that AFAIK most programs
that we run are not using the NUMA api.  Instead, they are using first-touch
with the knowledge that such pages will be allocated on the node where they
are first referenced.

Since we have to build a migration facility that will migrate jobs that
use both the NUMA API and the first-touch approach, it seems to me the
only plausible soluion is to move the pages via a migration facility
and then if there are NUMA API control structures found associated with
the moved pages to update them to represent the new reality.  Whether
this happens as an automatic side effect of the migration call or it
happens by a issuing a new set_mempolicy() is not clear to me.  I would
prefer to just issue a new set_mempolicy(), but somehow the migration
code will have to figure out where this call needs to be executed (i. e.
which pages have an associated NUMA policy).  [Thus the disclaimer in
the overview note that we have figured all the interaction with
memory policy stuff yet.]

-- 
-----------------------------------------------
Ray Bryant
512-453-9679 (work)         512-507-7807 (cell)
raybry@sgi.com             raybry@austin.rr.com
The box said: "Requires Windows 98 or better",
	 so I installed Linux.
-----------------------------------------------
