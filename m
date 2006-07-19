Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964782AbWGSKEP@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964782AbWGSKEP (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 19 Jul 2006 06:04:15 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964783AbWGSKEP
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 19 Jul 2006 06:04:15 -0400
Received: from e4.ny.us.ibm.com ([32.97.182.144]:2759 "EHLO e4.ny.us.ibm.com")
	by vger.kernel.org with ESMTP id S964782AbWGSKEO (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 19 Jul 2006 06:04:14 -0400
Subject: Re: [Xen-devel] [RFC PATCH 28/33] Add Xen grant table support
From: Harry Butterworth <harry@hebutterworth.freeserve.co.uk>
To: Chris Wright <chrisw@sous-sol.org>
Cc: linux-kernel@vger.kernel.org, Andrew Morton <akpm@osdl.org>,
       Zachary Amsden <zach@vmware.com>, Jeremy Fitzhardinge <jeremy@goop.org>,
       xen-devel@lists.xensource.com, Ian Pratt <ian.pratt@xensource.com>,
       Rusty Russell <rusty@rustcorp.com.au>, Andi Kleen <ak@suse.de>,
       virtualization@lists.osdl.org,
       Christian Limpach <Christian.Limpach@cl.cam.ac.uk>
In-Reply-To: <20060718091956.905130000@sous-sol.org>
References: <20060718091807.467468000@sous-sol.org>
	 <20060718091956.905130000@sous-sol.org>
Content-Type: text/plain
Date: Wed, 19 Jul 2006 11:04:10 +0100
Message-Id: <1153303451.7728.18.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Evolution 2.4.1 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I don't think that the current grant-table API/implementation quite
meets the requirements for revocation.

Specifically I think the requirements are that:

1) When a domain starts to reclaim a set of resources it allocated for
inter-domain communication this process is guaranteed to complete
without cooperation from any other domain.

2) When a domain reclaims resources it allocated for inter-domain
communication it can't cause a page fault or other exception in any
other domain.

The current API/implementation meets the second requirement but not the
first.

It's possible to make the current implementation meet the first
requirement if you relax it a bit and allow the superuser to kill an
offending domain via domain 0 but this expands the scope of the failure
from a single inter-domain communication channel to a whole domain which
is undesirable.

Another potential issue with grant-tables is support for efficient N-way
communication but I haven't investigated that personally.

A final point is that quite a lot of fairly tricky code is required to
combine grant-tables, event-channels and xenbus before you can create an
inter-domain communication channel which can be correctly disconnected
and reconnected across module load and unload.

It's appropriate to have a low-level API at the hypervisor because it
keeps the hypervisor as small as possible and therefore easier to audit.

But, whatever the low-level API, whether grant-tables or something which
has better support for revocation and n-way communication, I think there
needs to be a small library to implement a higher level API that is more
convenient for driver authors to use directly.

