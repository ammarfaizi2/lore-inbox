Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261913AbVC3OeD@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261913AbVC3OeD (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 30 Mar 2005 09:34:03 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261914AbVC3OeD
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 30 Mar 2005 09:34:03 -0500
Received: from e1.ny.us.ibm.com ([32.97.182.141]:31403 "EHLO e1.ny.us.ibm.com")
	by vger.kernel.org with ESMTP id S261913AbVC3Od6 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 30 Mar 2005 09:33:58 -0500
Date: Wed, 30 Mar 2005 08:33:55 -0600
From: "Serge E. Hallyn" <serue@us.ibm.com>
To: Paul Mackerras <paulus@samba.org>
Cc: linux-kernel@vger.kernel.org, linuxppc64-dev@ozlabs.org
Subject: Re: prefetch on ppc64
Message-ID: <20050330143355.GA1692@IBM-BWN8ZTBWA01.austin.ibm.com>
References: <20050330034034.GA1752@IBM-BWN8ZTBWA01.austin.ibm.com> <16970.9005.721117.942549@cargo.ozlabs.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <16970.9005.721117.942549@cargo.ozlabs.ibm.com>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Quoting Paul Mackerras (paulus@samba.org):
> Serge E. Hallyn writes:
> 
> > While investigating the inordinate performance impact one of my patches
> > seemed to be having, we tracked it down to two hlist_for_each_entry
> > loops, and finally to the prefetch instruction in the loop.
> 
> I would be interested to know what results you get if you leave the
> loops using hlist_for_each_entry but change prefetch() and prefetchw()
> to do the dcbt or dcbtst instruction only if the address is non-zero,
> like this:
> 
> static inline void prefetch(const void *x)
> {
> 	if (x)
> 	        __asm__ __volatile__ ("dcbt 0,%0" : : "r" (x));
> }
> 
> static inline void prefetchw(const void *x)
> {
> 	if (x)
> 	        __asm__ __volatile__ ("dcbtst 0,%0" : : "r" (x));
> }
> 
> It seems that doing a prefetch on a NULL pointer, while it doesn't
> cause a fault, does waste time looking for a translation of the zero
> address.

Hi,

Olof Johansson had suggested that earlier, except that his patch used

if (unlikely(!x))
	return;

Performance was quite good, but not as good as having prefetch completely
disabled.  I got

# elements: 50, mean 851.263680, variance 24.561146, std dev 4.955920

compared to 860.823880 stdev 6.896914 with prefetch disabled.

thanks,
-serge

