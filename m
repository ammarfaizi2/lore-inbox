Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030444AbWHXSfk@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030444AbWHXSfk (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 24 Aug 2006 14:35:40 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030445AbWHXSfj
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 24 Aug 2006 14:35:39 -0400
Received: from mx1.redhat.com ([66.187.233.31]:43482 "EHLO mx1.redhat.com")
	by vger.kernel.org with ESMTP id S1030444AbWHXSfj (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 24 Aug 2006 14:35:39 -0400
From: David Howells <dhowells@redhat.com>
In-Reply-To: <1156432859.5629.24.camel@localhost> 
References: <1156432859.5629.24.camel@localhost>  <32511.1156263593@warthog.cambridge.redhat.com> 
To: Trond Myklebust <trond.myklebust@fys.uio.no>
Cc: David Howells <dhowells@redhat.com>, torvalds@osdl.org, akpm@osdl.org,
       aviro@redhat.com, steved@redhat.com, linux-kernel@vger.kernel.org,
       nfsv4@linux-nfs.org
Subject: Re: [PATCH] NFS: Check lengths more thoroughly in NFS4 readdir XDR decode 
X-Mailer: MH-E 8.0; nmh 1.1; GNU Emacs 22.0.50
Date: Thu, 24 Aug 2006 19:35:21 +0100
Message-ID: <7346.1156444521@warthog.cambridge.redhat.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


So, what you've done is:

-+		if (end - p < xlen)
++		if (end - p < xlen + 1)
  			goto short_pkt;
 +		dprintk("filename = %*s\n", len, (char *)p);
 +		p += xlen;
  		len = ntohl(*p++);	/* bitmap length */
 -		p += len;
 -		if (p + 1 > end)
-+		if (end - p < len)
++		if (end - p < len + 1)
  			goto short_pkt;
 +		p += len;
  		attrlen = XDR_QUADLEN(ntohl(*p++));
 -		p += attrlen;		/* attributes */
 -		if (p + 2 > end)
-+		if (end - p < attrlen + 1)
++		if (end - p < attrlen + 2)

But is this equivalent:

-+		if (end - p < xlen)
++		if (end - p <= xlen)
  			goto short_pkt;
 +		dprintk("filename = %*s\n", len, (char *)p);
 +		p += xlen;
  		len = ntohl(*p++);	/* bitmap length */
 -		p += len;
 -		if (p + 1 > end)
-+		if (end - p < len)
++		if (end - p <= len)
  			goto short_pkt;
 +		p += len;
  		attrlen = XDR_QUADLEN(ntohl(*p++));
 -		p += attrlen;		/* attributes */
 -		if (p + 2 > end)
-+		if (end - p < attrlen + 1)
++		if (end - p <= attrlen + 1)

Do you think?

David
