Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932255AbWGKXnU@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932255AbWGKXnU (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 11 Jul 2006 19:43:20 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932256AbWGKXnU
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 11 Jul 2006 19:43:20 -0400
Received: from sj-iport-2-in.cisco.com ([171.71.176.71]:58232 "EHLO
	sj-iport-2.cisco.com") by vger.kernel.org with ESMTP
	id S932255AbWGKXnU (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 11 Jul 2006 19:43:20 -0400
X-IronPort-AV: i="4.06,230,1149490800"; 
   d="scan'208"; a="328436970:sNHT31095694"
To: Zach Brown <zach.brown@oracle.com>
Cc: Ingo Molnar <mingo@elte.hu>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       openib-general@openib.org, Arjan van de Ven <arjan@infradead.org>
Subject: Re: [openib-general] ipoib lockdep warning
X-Message-Flag: Warning: May contain useful information
References: <44B405C8.4040706@oracle.com> <adawtajzra5.fsf@cisco.com>
	<44B433CE.1030103@oracle.com>
From: Roland Dreier <rdreier@cisco.com>
Date: Tue, 11 Jul 2006 16:43:18 -0700
In-Reply-To: <44B433CE.1030103@oracle.com> (Zach Brown's message of "Tue, 11 Jul 2006 16:27:10 -0700")
Message-ID: <adasll7zp0p.fsf@cisco.com>
User-Agent: Gnus/5.1007 (Gnus v5.10.7) XEmacs/21.4.18 (linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
X-OriginalArrivalTime: 11 Jul 2006 23:43:19.0112 (UTC) FILETIME=[C9A5DC80:01C6A543]
Authentication-Results: sj-dkim-2.cisco.com; header.From=rdreier@cisco.com; dkim=pass (
	sig from cisco.com verified; ); 
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hmm, good point.

It sort of seems to me like the idr interfaces are broken by design.
Internally, lib/idr.c uses bare spin_lock(&idp->lock) with no
interrupt disabling or anything in both the idr_pre_get() and
idr_get_new() code paths.  But idr_pre_get() is supposed to be called
in a context that can sleep, while idr_get_new() is supposed to be
called with locks held to serialize things (at least according to
http://lwn.net/Articles/103209/).

So, ugh... maybe the best thing to do is change lib/idr.c to use
spin_lock_irqsave() internally?

 - R.
