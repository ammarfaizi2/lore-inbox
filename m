Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261832AbTCGWc0>; Fri, 7 Mar 2003 17:32:26 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261831AbTCGWc0>; Fri, 7 Mar 2003 17:32:26 -0500
Received: from e34.co.us.ibm.com ([32.97.110.132]:23224 "EHLO
	e34.co.us.ibm.com") by vger.kernel.org with ESMTP
	id <S261825AbTCGWcY>; Fri, 7 Mar 2003 17:32:24 -0500
Date: Fri, 7 Mar 2003 14:43:34 -0800
From: Mike Anderson <andmike@us.ibm.com>
To: James Bottomley <James.Bottomley@steeleye.com>
Cc: Andries.Brouwer@cwi.nl, Patrick Mansfield <patmans@us.ibm.com>,
       linux-kernel@vger.kernel.org,
       SCSI Mailing List <linux-scsi@vger.kernel.org>, torvalds@transmeta.com
Subject: Re: [PATCH] scsi_error fix
Message-ID: <20030307224334.GC1148@beaverton.ibm.com>
Mail-Followup-To: James Bottomley <James.Bottomley@steeleye.com>,
	Andries.Brouwer@cwi.nl, Patrick Mansfield <patmans@us.ibm.com>,
	linux-kernel@vger.kernel.org,
	SCSI Mailing List <linux-scsi@vger.kernel.org>,
	torvalds@transmeta.com
References: <UTC200303072019.h27KJXX12872.aeb@smtp.cwi.nl> <20030307211732.GA1148@beaverton.ibm.com> <1047075661.3444.27.camel@mulgrave>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1047075661.3444.27.camel@mulgrave>
User-Agent: Mutt/1.4i
X-Operating-System: Linux 2.0.32 on an i486
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

James Bottomley [James.Bottomley@steeleye.com] wrote:

> @@ -702,8 +701,14 @@
>  		 * if the result was normal, then just pass it along to the
>  		 * upper level.
>  		 */
> -		if (rtn == SUCCESS)
> +		if (rtn == SUCCESS) {
> +			/* we don't want this command reissued, just
> +			 * finished with the sense data, so set
> +			 * retries to the max allowed to ensure it
> +			 * won't get reissued */
> +			scmd->retries = scmd->allowed;
>  			scsi_eh_finish_cmd(scmd, done_q);
> +		}
>  		if (rtn != NEEDS_RETRY)
>  			continue;
>  

We might need to cover the case down below if we succeed on retry without
reaching allowed.

Another option is to look into re-sending the command from the
scsi_queue_insert handler like we do with timeouts. The interface to the
device should be the same from the LLDD's point of view just delayed
some.


-andmike
--
Michael Anderson
andmike@us.ibm.com

