Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264496AbTFQBTd (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 16 Jun 2003 21:19:33 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264498AbTFQBTd
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 16 Jun 2003 21:19:33 -0400
Received: from r2d2.aoltw.net ([64.236.137.26]:62963 "EHLO netscape.com")
	by vger.kernel.org with ESMTP id S264496AbTFQBTc (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 16 Jun 2003 21:19:32 -0400
Message-ID: <3EEE6FD9.2050908@netscape.com>
Date: Mon, 16 Jun 2003 18:33:13 -0700
From: jgmyers@netscape.com (John Myers)
User-Agent: Mozilla/5.0 (Windows; U; Windows NT 5.0; en-US; rv:1.4) Gecko/20030529
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Daniel McNeil <daniel@osdl.org>
CC: Andrew Morton <akpm@digeo.com>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       "linux-aio@kvack.org" <linux-aio@kvack.org>
Subject: Re: [PATCH 2.5.71-mm1] aio process hang on EINVAL
References: <1055810609.1250.1466.camel@dell_ss5.pdx.osdl.net>
In-Reply-To: <1055810609.1250.1466.camel@dell_ss5.pdx.osdl.net>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



Daniel McNeil wrote:

>Are there other error return values where it should jump to the
>aio_put_req()?  Should the check be:
>  
>
The situation is much worse.  The io_submit_one() code in 2.5.71 
distinguishes between conditions where io_submit should fail (which goto 
out_put_req) and conditions where the queued operation completes 
immediately (which result in a call to aio_complete()).  The patch in 
2.5.71-mm1 which separates out aio_setup_iocb() loses track of this 
distinction, mishandling any case where the queued operation completes 
immediately.  Aio poll, for instance, depends on being able to indicate 
immediate completion.

So the part of aio-01-retry.patch that splits out aio_setup_iocb() is 
completely broken.


