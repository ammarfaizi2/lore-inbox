Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1161081AbVKDGTo@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161081AbVKDGTo (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 4 Nov 2005 01:19:44 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1161082AbVKDGTo
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 4 Nov 2005 01:19:44 -0500
Received: from zproxy.gmail.com ([64.233.162.201]:55680 "EHLO zproxy.gmail.com")
	by vger.kernel.org with ESMTP id S1161081AbVKDGTn convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 4 Nov 2005 01:19:43 -0500
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=YS99oYl3vQxgw+tWJ+tLohzYYw9Xd9Fy2MIeyk7JMgPOOFw06Hwv3bE2Sxb6KRTC/eg0DCGlM9lSibiyAl940ZkcaENIXbj35EW5a+iUsbW3sq/PwIgHVUUrLbfUFDX5hyzVMd3EiUZXovkM2DpyNwKvyeiAu64f1VlswBDFWYo=
Message-ID: <7e77d27c0511032219g43b6d015w@mail.gmail.com>
Date: Fri, 4 Nov 2005 14:19:43 +0800
From: Yan Zheng <yzcorp@gmail.com>
To: David Stevens <dlstevens@us.ibm.com>
Subject: Re: [PATCH][MCAST]Two fix for implementation of MLDv2 .
Cc: linux-kernel@vger.kernel.org, netdev@vger.kernel.org
In-Reply-To: <OF70243A3E.F658C3A4-ON882570AF.001699E7-882570AF.0018C8DB@us.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Content-Disposition: inline
References: <7e77d27c0511030526g45d8f6e6l@mail.gmail.com>
	 <OF70243A3E.F658C3A4-ON882570AF.001699E7-882570AF.0018C8DB@us.ibm.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>         So, I'll look at this more carefully and see if I still agree
> it needs a fix and whether or not your patch, or some alternative
> method might be more appropriate. But it'll probably be sometime
> next week before I'll be done reviewing/considering alternatives on
> this one.
>
>                                         +-DLS
>
>


I am sorry, I can't understand your opinion completely.
Please forgive my poor english :-)

Here is my  opinion:

I think Multicast Address and Source Specific Query is sent only when
router want to block traffic from some source.  So when the filter
mode is exclude, node should send a report which includes a
MODE_IS_INCLUDE Record with sources in the query but NOT in the
filter's source list. This is the required behaviour in rfc3810, but
it need addiction item in struct ifmcaddr6 to record sources in the
query.  So I think make process Multicast Address Specific Query and
Multicast Address and Source Specific Query no difference is a
temporary fix.

the secoend change in is_in(...) is because I think include/exclude
counts also should be checked when type is MLD2_MODE_IS_INCLUDE or
MLD2_MODE_IS_EXCLUDE.



Regards

Here is my modify version is_in(...)
-----------------------------------------------------------------------------------------------
static int is_in(struct ifmcaddr6 *pmc, struct ip6_sf_list *psf, int type,
	int gdeleted, int sdeleted)
{
	switch (type) {
	case MLD2_MODE_IS_INCLUDE:
	case MLD2_CHANGE_TO_INCLUDE:
		if (gdeleted || sdeleted)
			return 0;
		if (psf->sf_count[MCAST_INCLUDE] == 0)
			return 0;    // maybe never happen
		if (type == MLD2_CHANGE_TO_INCLUDE)
			return 1;
		return !((pmc->mca_flags & MAF_GSQUERY) && !psf->sf_gsresp);
	case MLD2_MODE_IS_EXCLUDE:
	case MLD2_CHANGE_TO_EXCLUDE:
		if (gdeleted || sdeleted)
			return 0;
		if (pmc->mca_sfcount[MCAST_EXCLUDE] == 0 ||
		    psf->sf_count[MCAST_INCLUDE])
			return 0;
		return pmc->mca_sfcount[MCAST_EXCLUDE] ==
			psf->sf_count[MCAST_EXCLUDE];
	case MLD2_ALLOW_NEW_SOURCES:
		if (gdeleted || !psf->sf_crcount)
			return 0;
		return (pmc->mca_sfmode == MCAST_INCLUDE) ^ sdeleted;
	case MLD2_BLOCK_OLD_SOURCES:
		if (pmc->mca_sfmode == MCAST_INCLUDE)
			return gdeleted || (psf->sf_crcount && sdeleted);
		return psf->sf_crcount && !gdeleted && !sdeleted;
	}
	return 0;
}
