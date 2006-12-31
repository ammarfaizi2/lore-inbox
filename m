Return-Path: <linux-kernel-owner+w=401wt.eu-S933037AbWLaGiX@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S933037AbWLaGiX (ORCPT <rfc822;w@1wt.eu>);
	Sun, 31 Dec 2006 01:38:23 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S933038AbWLaGiX
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 31 Dec 2006 01:38:23 -0500
Received: from liaag1ab.mx.compuserve.com ([149.174.40.28]:46051 "EHLO
	liaag1ab.mx.compuserve.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S933037AbWLaGiW (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 31 Dec 2006 01:38:22 -0500
Date: Sun, 31 Dec 2006 01:31:43 -0500
From: Chuck Ebbert <76306.1226@compuserve.com>
Subject: Re: [S390] cio: fix stsch_reset.
To: Martin Schwidefsky <schwidefsky@de.ibm.com>
Cc: Michael Holzheu <holzheu@de.ibm.com>, linux-kernel@vger.kernel.org
Message-ID: <200612310135_MC3-1-D6D0-A862@compuserve.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Type: text/plain;
	 charset=us-ascii
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

In-Reply-To: <20061228103925.GB6270@skybase>

On Thu, 28 Dec 2006 11:39:25 +0100, Martin Schwidefsky wrote:

> @@ -881,10 +880,18 @@ static void cio_reset_pgm_check_handler(
>  static int stsch_reset(struct subchannel_id schid, volatile struct schib *addr)
>  {
>       int rc;
> +     register struct subchannel_id reg1 asm ("1") = schid;
>  
>       pgm_check_occured = 0;
>       s390_reset_pgm_handler = cio_reset_pgm_check_handler;
> -     rc = stsch(schid, addr);
> +
> +     asm volatile(
> +             "       stsch   0(%2)\n"
> +             "       ipm     %0\n"
> +             "       srl     %0,28"
> +             : "=d" (rc)
> +             : "d" (reg1), "a" (addr), "m" (*addr) : "memory", "cc");
> +
>       s390_reset_pgm_handler = NULL;
>       if (pgm_check_occured)
>               return -EIO;


Can't you just put a barrier() before the stsch() call?

-- 
MBTI: IXTP

