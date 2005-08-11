Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932295AbVHKR2E@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932295AbVHKR2E (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 11 Aug 2005 13:28:04 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932273AbVHKR2A
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 11 Aug 2005 13:28:00 -0400
Received: from omx2-ext.sgi.com ([192.48.171.19]:7881 "EHLO omx2.sgi.com")
	by vger.kernel.org with ESMTP id S932295AbVHKR17 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 11 Aug 2005 13:27:59 -0400
Message-ID: <42FB8A8F.3020902@engr.sgi.com>
Date: Thu, 11 Aug 2005 10:27:43 -0700
From: Jay Lan <jlan@engr.sgi.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.7.2) Gecko/20040906
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Peter Staubach <staubach@redhat.com>
Cc: linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH]  largefile support for accounting
References: <42FB6255.10807@redhat.com>
In-Reply-To: <42FB6255.10807@redhat.com>
X-Enigmail-Version: 0.86.0.0
X-Enigmail-Supports: pgp-inline, pgp-mime
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Yes, our CSA customers reported same problem. CSA already incoporated
same fix to our kernel module code. :)

Cheers,
  - jay


Peter Staubach wrote:
> Hi.
> 
> There is a problem in the accounting subsystem in the kernel can not
> correctly handle files larger than 2GB.  The output file containing
> the process accounting data can grow very large if the system is large
> enough and active enough.  If the 2GB limit is reached, then the system
> simply stops storing process accounting data.
> 
> Another annoying problem is that once the system reaches this 2GB limit,
> then every process which exits will receive a signal, SIGXFSZ.  This
> signal is generated because an attempt was made to write beyond the limit
> for the file descriptor.  This signal makes it look like every process
> has exited due to a signal, when in fact, they have not.
> 
> The solution is to add the O_LARGEFILE flag to the list of flags used
> to open the accounting file.  The rest of the accounting support is
> already largefile safe.
> 
> The changes were tested by constructing a large file (just short of 2GB),
> enabling accounting, and then running enough commands to cause the
> accounting data generated to increase the size of the file to 2GB.  Without
> the changes, the file grows to 2GB and the last command run in the test
> script appears to exit due a signal when it has not.  With the changes,
> things work as expected and quietly.
> 
> There are some user level changes required so that it can deal with
> largefiles, but those are being handled separately.
> 
> Signed-off-by: Peter Staubach <staubach@redhat.com>
> 
> 
> ------------------------------------------------------------------------
> 
> --- linux-2.6.12/kernel/acct.c.org	2005-06-17 15:48:29.000000000 -0400
> +++ linux-2.6.12/kernel/acct.c	2005-08-10 15:12:46.000000000 -0400
> @@ -220,7 +220,7 @@ asmlinkage long sys_acct(const char __us
>  			return (PTR_ERR(tmp));
>  		}
>  		/* Difference from BSD - they don't do O_APPEND */
> -		file = filp_open(tmp, O_WRONLY|O_APPEND, 0);
> +		file = filp_open(tmp, O_WRONLY | O_APPEND | O_LARGEFILE, 0);
>  		putname(tmp);
>  		if (IS_ERR(file)) {
>  			return (PTR_ERR(file));

