Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030249AbVKCBWF@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030249AbVKCBWF (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 2 Nov 2005 20:22:05 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030248AbVKCBWF
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 2 Nov 2005 20:22:05 -0500
Received: from zproxy.gmail.com ([64.233.162.204]:214 "EHLO zproxy.gmail.com")
	by vger.kernel.org with ESMTP id S1030244AbVKCBWE convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 2 Nov 2005 20:22:04 -0500
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=CGW3UgJQw1g3z5wA4CI+sfCzz4SEDVR/l15A5NkBzxLad3sz/EvD76/h1EoTbosl/9/Ye/fkInazy0GXJ59MqRyAqUkYWadQGEwiUDZANKEPKV7I+IycRk+5CSGBZw2uNWx/CUYBmYk6KHmgV8Qcr73/IQJi8kmHurc8BQzCGQk=
Message-ID: <7e77d27c0511021722l6bb768c7h@mail.gmail.com>
Date: Thu, 3 Nov 2005 09:22:04 +0800
From: Yan Zheng <yzcorp@gmail.com>
To: Yan Zheng <yanzheng@21cn.com>
Subject: Re: [PATCH][MCAST]Two fix for implementation of MLDv2 .
Cc: netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
       David Stevens <dlstevens@us.ibm.com>
In-Reply-To: <436878E7.3030303@21cn.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Content-Disposition: inline
References: <436878E7.3030303@21cn.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I find something interesting .  Maybe more changes for is_in(...) are needed.


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
		if (type == MLD2_MODE_IS_EXCLUDE)
			return 1;
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
