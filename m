Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1161257AbVKIWGa@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161257AbVKIWGa (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 9 Nov 2005 17:06:30 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1161277AbVKIWGa
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 9 Nov 2005 17:06:30 -0500
Received: from e33.co.us.ibm.com ([32.97.110.151]:5285 "EHLO e33.co.us.ibm.com")
	by vger.kernel.org with ESMTP id S1161257AbVKIWG2 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 9 Nov 2005 17:06:28 -0500
In-Reply-To: <4371E45C.3020500@21cn.com>
To: Yan Zheng <yanzheng@21cn.com>
Cc: linux-kernel@vger.kernel.org, netdev@vger.kernel.org
MIME-Version: 1.0
Subject: Re: [PATCH 2/2][MCAST] Fix for add_grec(...)
X-Mailer: Lotus Notes Release 6.0.2CF1 June 9, 2003
Message-ID: <OFD5769042.0E81A890-ON882570B4.0075A92B-882570B4.00796FDC@us.ibm.com>
From: David Stevens <dlstevens@us.ibm.com>
Date: Wed, 9 Nov 2005 14:06:44 -0800
X-MIMETrack: Serialize by Router on D03NM121/03/M/IBM(Release 6.53HF654 | July 22, 2005) at
 11/09/2005 15:06:45,
	Serialize complete at 11/09/2005 15:06:45
Content-Type: text/plain; charset="US-ASCII"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Yan,
        I think your patch has some problems.

Yan Zheng <yanzheng@21cn.com> wrote on 11/09/2005 03:58:20 AM:

> +#if 0
>     if (!*psf_list) {
>        if (type == MLD2_ALLOW_NEW_SOURCES ||
>            type == MLD2_BLOCK_OLD_SOURCES)
> @@ -1474,12 +1477,15 @@ static struct sk_buff *add_grec(struct s
>        }
>        return skb;
>     }
> +#endif


        This code is the only place in the current code where you
can generate a group header with an empty source list (what it is
checking for). Your patch has added an add_grhead() for change
and EXCLUDE records, but it isn't checking mca_crcount or isquery.
I need to check, but I'm concerned this will create a group header
in a report for cases where it should not.


>     pmr = skb ? (struct mld2_report *)skb->h.raw : NULL;
> 
>     /* EX and TO_EX get a fresh packet, if needed */
> -   if (truncate) {
> -      if (pmr && pmr->ngrec &&
> -          AVAILABLE(skb) < grec_size(pmc, type, gdeleted, sdeleted)) {
> +   if (truncate || ischange) {
> +      int min_len;
> +      min_len   = truncate ? grec_size(pmc, type, gdeleted, sdeleted) : 

> +           (sizeof(struct mld2_grec) + sizeof(struct in6_addr));
> +      if (pmr && pmr->ngrec && AVAILABLE(skb) < min_len) {
>           if (skb)
>              mld_sendpack(skb);
>           skb = mld_newpack(dev, dev->mtu);

        This "truncate" code is to handle exclude records that may be
truncated. It gets a new packet when adding this record and the whole
thing won't fit in a single packet. This is not appropriate for anything
but IS_EX and TO_EX, but "ischange" in your patch will be true for
TO_IN. So, I think this will waste space in a report that could hold
some of these TO_IN sources.

        I haven't run your test code, or tested with your patch yet,
just observing the differences from the original code path and your
patch (and they appear to be more than you intended).

                                                        +-DLS

