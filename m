Return-Path: <linux-kernel-owner+willy=40w.ods.org-S965120AbWD0Mw0@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965120AbWD0Mw0 (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 27 Apr 2006 08:52:26 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965121AbWD0Mw0
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 27 Apr 2006 08:52:26 -0400
Received: from wohnheim.fh-wedel.de ([213.39.233.138]:47085 "EHLO
	wohnheim.fh-wedel.de") by vger.kernel.org with ESMTP
	id S965120AbWD0Mw0 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 27 Apr 2006 08:52:26 -0400
Date: Thu, 27 Apr 2006 14:52:07 +0200
From: =?iso-8859-1?Q?J=F6rn?= Engel <joern@wohnheim.fh-wedel.de>
To: Heiko J Schick <schihei@de.ibm.com>
Cc: openib-general@openib.org, Christoph Raisch <RAISCH@de.ibm.com>,
       Hoang-Nam Nguyen <HNGUYEN@de.ibm.com>, Marcus Eder <MEDER@de.ibm.com>,
       linux-kernel@vger.kernel.org, linuxppc-dev@ozlabs.org
Subject: Re: [PATCH 15/16] ehca: queue page table handling
Message-ID: <20060427125207.GJ32127@wohnheim.fh-wedel.de>
References: <4450A1CE.80503@de.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <4450A1CE.80503@de.ibm.com>
User-Agent: Mutt/1.5.9i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 27 April 2006 12:49:50 +0200, Heiko J Schick wrote:
> +inline static void *ipz_qeit_get_inc_valid(struct ipz_queue *queue)
> +{
> +	void *retvalue = ipz_qeit_get(queue);
> +	u32 qe = ((struct ehca_cqe *)retvalue)->cqe_flags;
> +	if ((qe >> 7) == (queue->toggle_state & 1)) {
> +		/* this is a good one */
> +		ipz_qeit_get_inc(queue);
> +	} else
> +		retvalue = NULL;
> +	return (retvalue);
> +}

How about:
static inline void *ipz_qeit_get_inc_valid(struct ipz_queue *queue)
{
	struct ehca_cqe *cqe = ipz_qeit_get(queue);
	u32 flags = cqe->cqe_flags;

	if ((flags >> 7) != (queue->toggle_state & 1))
		return NULL;

	ipz_qeit_get_inc(queue);
	return cqe;
}

o "static inline", as Arnd requested,
o no cast for cqe,
o possibly useful identifier for "retvalue",
o trivial to identify error path (hint: only error path is indented),
o directly returns NULL instead of assigning to a variable,
o removed brackets around return value.

I'm still not happy with "ehca_cqe" (just try to pronounce it) and the
weird condition.  But you should get the general idea.  Same goes for
other functions.

Jörn

-- 
The cheapest, fastest and most reliable components of a computer
system are those that aren't there.
-- Gordon Bell, DEC labratories
