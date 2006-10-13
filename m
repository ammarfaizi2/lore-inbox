Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750898AbWJMOeK@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750898AbWJMOeK (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 13 Oct 2006 10:34:10 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750904AbWJMOeK
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 13 Oct 2006 10:34:10 -0400
Received: from kanga.kvack.org ([66.96.29.28]:19153 "EHLO kanga.kvack.org")
	by vger.kernel.org with ESMTP id S1750898AbWJMOeJ (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 13 Oct 2006 10:34:09 -0400
Date: Fri, 13 Oct 2006 10:33:59 -0400
From: Benjamin LaHaise <bcrl@kvack.org>
To: "Chen, Kenneth W" <kenneth.w.chen@intel.com>
Cc: "'Zach Brown'" <zach.brown@oracle.com>,
       "'Suparna Bhattacharya'" <suparna@in.ibm.com>,
       "Lahaise, Benjamin C" <benjamin.c.lahaise@intel.com>,
       linux-kernel@vger.kernel.org, "'linux-aio'" <linux-aio@kvack.org>
Subject: Re: [patch] remove redundant kioctx->users ref count
Message-ID: <20061013143359.GK4141@kvack.org>
References: <000201c6ee59$cba3fda0$db34030a@amr.corp.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <000201c6ee59$cba3fda0$db34030a@amr.corp.intel.com>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Oct 12, 2006 at 04:54:46PM -0700, Chen, Kenneth W wrote:
> @@ -1015,9 +1010,6 @@ put_rq:
>  	if (waitqueue_active(&ctx->wait))
>  		wake_up(&ctx->wait);
>  
> -	if (ret)
> -		put_ioctx(ctx);
> -
>  	return ret;
>  }

This part makes me worry -- at this point we no longer have anything 
pinning the ioctx, yet we touch ->wait after dropping the lock.  The 
only way around this is if rcu is introduced in the final free of an 
ioctx to ensure the structure remains around for a sufficient grace 
period.

		-ben
-- 
"Time is of no importance, Mr. President, only life is important."
Don't Email: <dont@kvack.org>.
