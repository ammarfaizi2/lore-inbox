Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030198AbWHRNrm@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030198AbWHRNrm (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 18 Aug 2006 09:47:42 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751395AbWHRNrm
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 18 Aug 2006 09:47:42 -0400
Received: from ug-out-1314.google.com ([66.249.92.169]:30744 "EHLO
	ug-out-1314.google.com") by vger.kernel.org with ESMTP
	id S1751390AbWHRNrl (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 18 Aug 2006 09:47:41 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:date:from:to:cc:subject:message-id:references:mime-version:content-type:content-disposition:in-reply-to:user-agent;
        b=MOIFwHtMGsXf0bsiQtjeSFfmRp8GtliWyxSpAUuPnQveAfYnbB/5bmSXoAnHWxY3wFzvSsD2Z0ts7TGIEjDl07rXSJR2LacDGZ1Hh2sfnl3cy+DyWqzPTblS53WGTkuztVJobfw8c9pjU5aHWq+FTfMN4+kW7uz+fCImY/ZPfvE=
Date: Fri, 18 Aug 2006 17:47:28 +0400
From: Alexey Dobriyan <adobriyan@gmail.com>
To: Jan-Bernd Themann <ossthema@de.ibm.com>
Cc: netdev@vger.kernel.org, Christoph Raisch <raisch@de.ibm.com>,
       Jan-Bernd Themann <themann@de.ibm.com>,
       linux-kernel <linux-kernel@vger.kernel.org>,
       linux-ppc <linuxppc-dev@ozlabs.org>, Marcus Eder <meder@de.ibm.com>,
       Thomas Klein <osstklei@de.ibm.com>, Thomas Klein <tklein@de.ibm.com>
Subject: Re: [2.6.19 PATCH 1/7] ehea: interface to network stack
Message-ID: <20060818134728.GB5201@martell.zuzino.mipt.ru>
References: <200608181329.02042.ossthema@de.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200608181329.02042.ossthema@de.ibm.com>
User-Agent: Mutt/1.5.11
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Aug 18, 2006 at 01:29:01PM +0200, Jan-Bernd Themann wrote:

Was there noticeable performance difference when explicit prefetching is
removed? At some (invisible) point CPUs will become smarter about prefetching
than programmers and this code will be slower than possible.

> +static inline struct sk_buff *get_skb_by_index(struct sk_buff **skb_array,
> +					       int arr_len,
> +					       struct ehea_cqe *cqe)
> +{
> +	struct sk_buff *skb;
> +	void *pref;
> +	int x;
> +	int skb_index = EHEA_BMASK_GET(EHEA_WR_ID_INDEX, cqe->wr_id);
> +
> +	x = skb_index + 1;
> +	x &= (arr_len - 1);
> +
> +	pref = (void*)skb_array[x];
> +	prefetchw(pref);
> +	prefetchw(pref + EHEA_CACHE_LINE);
> +
> +	pref = (void*)(skb_array[x]->data);
> +	prefetch(pref);
> +	prefetch(pref + EHEA_CACHE_LINE);
> +	prefetch(pref + EHEA_CACHE_LINE * 2);
> +	prefetch(pref + EHEA_CACHE_LINE * 3);
> +	skb = skb_array[skb_index];
> +	skb_array[skb_index] = NULL;
> +	return skb;
> +}
> +
> +static inline struct sk_buff *get_skb_by_index_ll(struct sk_buff **skb_array,
> +						  int arr_len, int wqe_index)
> +{
> +	struct sk_buff *skb;
> +	void *pref;
> +	int x;
> +
> +	x = wqe_index + 1;
> +	x &= (arr_len - 1);
> +
> +	pref = (void*)skb_array[x];
> +	prefetchw(pref);
> +	prefetchw(pref + EHEA_CACHE_LINE);
> +
> +	pref = (void*)(skb_array[x]->data);
> +	prefetchw(pref);
> +	prefetchw(pref + EHEA_CACHE_LINE);
> +
> +	skb = skb_array[wqe_index];
> +	skb_array[wqe_index] = NULL;
> +	return skb;
> +}

