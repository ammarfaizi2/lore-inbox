Return-Path: <linux-kernel-owner+willy=40w.ods.org-S965054AbWH2QUH@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965054AbWH2QUH (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 29 Aug 2006 12:20:07 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965057AbWH2QUH
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 29 Aug 2006 12:20:07 -0400
Received: from nz-out-0102.google.com ([64.233.162.206]:48203 "EHLO
	nz-out-0102.google.com") by vger.kernel.org with ESMTP
	id S965054AbWH2QUF (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 29 Aug 2006 12:20:05 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:date:from:to:cc:subject:message-id:references:mime-version:content-type:content-disposition:in-reply-to:user-agent:sender;
        b=RbCwwm5ItX9TE/CLg5wtHA/Z3jqg3r0JBhLn+Nzo8Y0EkVxo8WZc1oM82moC2GtwInuhgIps3TQ4XdRYya/BZ+NETS9bfZHcqwNN33xHku8zrgZRb9bj4nx8L/AFGm4Bahq2Z32nLWG3D2jQAWjFL0jG0i/rk0RFJ/mHOvu//0s=
Date: Tue, 29 Aug 2006 18:19:36 +0000
From: Frederik Deweerdt <deweerdt@free.fr>
To: Valdis.Kletnieks@vt.edu
Cc: Andrew Morton <akpm@osdl.org>, linux-kernel@vger.kernel.org,
       vnuorval@tcs.hut.fi, davem@davemloft.net
Subject: Re: 2.6.18-rc4-mm3: BUG: warning at include/net/dst.h:154/dst_release()
Message-ID: <20060829181936.GB1633@slug>
References: <200608291425.k7TEP7XR004029@turing-police.cc.vt.edu>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200608291425.k7TEP7XR004029@turing-police.cc.vt.edu>
User-Agent: mutt-ng/devel-r804 (Linux)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Aug 29, 2006 at 10:25:07AM -0400, Valdis.Kletnieks@vt.edu wrote:
> Seeing this a lot on 2.6.18-rc4-mm3 with 2 different stack tracebacks
> (one for received packets, other for sending).  I already picked up the
> fix for the ^ / confusion in fib_rules.c and that didn't help matters.
> 
Hi,

I'm not familiary with net code, but willing to help :). It looks like
the fib6_rule_lookup function is increasing dst.__refcnt in one code
path and not the other. Does the (untested) attached patch help?

Thanks,
Frederik

diff --git a/net/ipv6/fib6_rules.c b/net/ipv6/fib6_rules.c
index ee4aa43..12ec27b 100644
--- a/net/ipv6/fib6_rules.c
+++ b/net/ipv6/fib6_rules.c
@@ -67,8 +67,11 @@ struct dst_entry *fib6_rule_lookup(struc
 	if (arg.rule)
 		fib_rule_put(arg.rule);
 
-	if (arg.result)
-		return (struct dst_entry *) arg.result;
+	if (arg.result) {
+		struct dst_entry *dst = (struct dst_entry *)arg.result;
+		dst_hold(dst);
+		return dst;
+	}
 
 	dst_hold(&ip6_null_entry.u.dst);
 	return &ip6_null_entry.u.dst;
