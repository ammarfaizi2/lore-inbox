Return-Path: <linux-kernel-owner+willy=40w.ods.org-S266745AbUHaG1S@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266745AbUHaG1S (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 31 Aug 2004 02:27:18 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266748AbUHaG1S
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 31 Aug 2004 02:27:18 -0400
Received: from mx1.redhat.com ([66.187.233.31]:7876 "EHLO mx1.redhat.com")
	by vger.kernel.org with ESMTP id S266745AbUHaG1M (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 31 Aug 2004 02:27:12 -0400
Date: Tue, 31 Aug 2004 02:26:56 -0400
From: Jakub Jelinek <jakub@redhat.com>
To: Roland McGrath <roland@redhat.com>
Cc: Michael Kerrisk <mtk-lkml@gmx.net>, torvalds@osdl.org, akpm@osdl.org,
       drepper@redhat.com, linux-kernel@vger.kernel.org,
       michael.kerrisk@gmx.net, Tonnerre <tonnerre@thundrix.ch>
Subject: Re: [PATCH] waitid system call
Message-ID: <20040831062656.GU11465@devserv.devel.redhat.com>
Reply-To: Jakub Jelinek <jakub@redhat.com>
References: <12606.1093348262@www48.gmx.net> <200408310604.i7V64k7o010652@magilla.sf.frob.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200408310604.i7V64k7o010652@magilla.sf.frob.com>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Aug 30, 2004 at 11:04:46PM -0700, Roland McGrath wrote:
> +			/*
> +			 * For a WNOHANG return, clear out all the fields
> +			 * we would set so the user can easily tell the
> +			 * difference.
> +			 */
> +			if (!retval)
> +				retval = put_user(0, &infop->si_signo);
> +			if (!retval)
> +				retval = put_user(0, &infop->si_errno);
> +			if (!retval)
> +				retval = put_user(0, &infop->si_code);
> +			if (!retval)
> +				retval = put_user(0, &infop->si_pid);
> +			if (!retval)
> +				retval = put_user(0, &infop->si_uid);
> +			if (!retval)
> +				retval = put_user(0, &infop->si_status);

Is it really necessary to check the exit code after each put_user?
	if (!retval && access_ok(VERIFY_WRITE, infop, sizeof(*infop)))) {
		retval = __put_user(0, &infop->si_signo);
		retval |= __put_user(0, &infop->si_errno);
		retval |= __put_user(0, &infop->si_code);
		retval |= __put_user(0, &infop->si_pid);
		retval |= __put_user(0, &infop->si_uid);
		retval |= __put_user(0, &infop->si_status);
	}
is what kernel usually does when filling multiple structure members.

	Jakub
