Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261741AbVBOONB@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261741AbVBOONB (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 15 Feb 2005 09:13:01 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261734AbVBOOMo
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 15 Feb 2005 09:12:44 -0500
Received: from mx1.redhat.com ([66.187.233.31]:18888 "EHLO mx1.redhat.com")
	by vger.kernel.org with ESMTP id S261727AbVBOOM0 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 15 Feb 2005 09:12:26 -0500
Subject: Re: [PATCH] ext3: Fix sparse -Wbitwise warnings.
From: "Stephen C. Tweedie" <sct@redhat.com>
To: Alexey Dobriyan <adobriyan@mail.ru>
Cc: Andrew Morton <akpm@osdl.org>, Andreas Dilger <adilger@clusterfs.com>,
       ext3 users list <ext3-users@redhat.com>,
       linux-kernel <linux-kernel@vger.kernel.org>,
       Stephen Tweedie <sct@redhat.com>
In-Reply-To: <200502151246.06598.adobriyan@mail.ru>
References: <200502151246.06598.adobriyan@mail.ru>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Message-Id: <1108476729.3363.9.camel@sisko.sctweedie.blueyonder.co.uk>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.5 (1.4.5-9) 
Date: Tue, 15 Feb 2005 14:12:09 +0000
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On Tue, 2005-02-15 at 10:46, Alexey Dobriyan wrote:

> -			if ((ret = EXT3_HAS_RO_COMPAT_FEATURE(sb,
> -					~EXT3_FEATURE_RO_COMPAT_SUPP))) {
> +			if ((ret = le32_to_cpu(EXT3_HAS_RO_COMPAT_FEATURE(sb,
> +					~EXT3_FEATURE_RO_COMPAT_SUPP)))) {

NAK.

EXT3_HAS_RO_COMPAT_FEATURE returns a boolean value.  It happens to be
implemented internally as 

#define EXT3_HAS_COMPAT_FEATURE(sb,mask)			\
	( EXT3_SB(sb)->s_es->s_feature_compat & cpu_to_le32(mask) )


so the compiler, looking at the preprocessed code, will reasonably
assume it's a genuine little-endian value.  But it's only used as a
boolean, so we shouldn't be requiring the callers to provide an
le32_to_cpu() conversion.

If we want to fix this, let's fix the macros: for example, convert
EXT3_HAS_COMPAT_FEATURE to be

	( le32_to_cpu(EXT3_SB(sb)->s_es->s_feature_compat) & (mask) )

so that we're doing the tests in native CPU endian-ness.

--Stephen

