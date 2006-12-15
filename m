Return-Path: <linux-kernel-owner+w=401wt.eu-S965073AbWLOVQE@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965073AbWLOVQE (ORCPT <rfc822;w@1wt.eu>);
	Fri, 15 Dec 2006 16:16:04 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965077AbWLOVQE
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 15 Dec 2006 16:16:04 -0500
Received: from mtagate1.de.ibm.com ([195.212.29.150]:5374 "EHLO
	mtagate1.de.ibm.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S965073AbWLOVQB (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 15 Dec 2006 16:16:01 -0500
Date: Fri, 15 Dec 2006 22:15:58 +0100
From: Heiko Carstens <heiko.carstens@de.ibm.com>
To: Martin Schwidefsky <schwidefsky@de.ibm.com>
Cc: linux-kernel@vger.kernel.org, holzheu@de.ibm.com
Subject: Re: [S390] Fix reboot hang on LPARs
Message-ID: <20061215211558.GA8101@osiris.ibm.com>
References: <20061215162218.GF4920@skybase>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20061215162218.GF4920@skybase>
User-Agent: mutt-ng/devel-r804 (Linux)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> +static int pgm_check_occured;
> +
> +static void cio_reset_pgm_check_handler(void)
> +{
> +	pgm_check_occured = 1;
> +}
> +
> +static int stsch_reset(struct subchannel_id schid, volatile struct schib *addr)
> +{
> +	int rc;
> +
> +	pgm_check_occured = 0;
> +	s390_reset_pgm_handler = cio_reset_pgm_check_handler;
> +	rc = stsch(schid, addr);
> +	s390_reset_pgm_handler = NULL;
> +	if (pgm_check_occured)
> +		return -EIO;
> +	else
> +		return rc;
> +}

This is broken. pgm_check_occured must be volatile, otherwise the -EIO path
in stsch_reset might get optimized away.
