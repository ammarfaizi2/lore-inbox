Return-Path: <linux-kernel-owner+willy=40w.ods.org-S267490AbUHSW5F@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S267490AbUHSW5F (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 19 Aug 2004 18:57:05 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267489AbUHSW5F
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 19 Aug 2004 18:57:05 -0400
Received: from e33.co.us.ibm.com ([32.97.110.131]:8390 "EHLO e33.co.us.ibm.com")
	by vger.kernel.org with ESMTP id S267490AbUHSW5B (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 19 Aug 2004 18:57:01 -0400
Date: Thu, 19 Aug 2004 10:35:16 -0500
To: Paul Mackerras <paulus@samba.org>
Cc: akpm@osdl.org, anton@samba.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] PPC64 Fix unbalanced pci_dev_put in EEH code
Message-ID: <20040819153516.GM14002@austin.ibm.com>
References: <16674.53330.174867.75311@cargo.ozlabs.ibm.com> <20040818172501.GF14002@austin.ibm.com> <16675.64654.945327.265586@cargo.ozlabs.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <16675.64654.945327.265586@cargo.ozlabs.ibm.com>
User-Agent: Mutt/1.5.6+20040523i
From: Linas Vepstas <linas@austin.ibm.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Aug 19, 2004 at 11:04:14AM +1000, Paul Mackerras was heard to remark:
> Linas Vepstas writes:
> 
> > Hang on there, you didn't just rename the variable, you also missed a
> > teeny chunk of the original patch.  The corrected path is attached below.
> > (Well, I rather liked my original var names better, but whatever).
> 
> Look closer, I didn't miss the chunk, I solved the race condition that
> you mentioned. :)  I did if (!inserted) pci_dev_put(dev) at the end
> rather than if (inserted) pci_dev_get(dev).

OK, I missed the !  (which is why I like !=0 because that avoids
single-char errors from ruinging things.)

That will work.

There's no race, since the for-each-device loop performs a pci_dev_get
which holds on to the device for the duration of the loop interior.
So doing a dev_get at any time inside the loop is sufficient; no
ordering is required.

(One of my original errors was assuming that I had to do a dev_put at the
bottom of the loop to counteract the for-each-device's get; but, no, 
this is not needed, the for-each-device loop performs a dev-put at 
the end of the loop, just as it does a dev_get for the next iteration.)

--linas
