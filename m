Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261468AbVCaOcc@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261468AbVCaOcc (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 31 Mar 2005 09:32:32 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261470AbVCaOcc
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 31 Mar 2005 09:32:32 -0500
Received: from pat.uio.no ([129.240.130.16]:42493 "EHLO pat.uio.no")
	by vger.kernel.org with ESMTP id S261468AbVCaOcQ (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 31 Mar 2005 09:32:16 -0500
Subject: Re: NFS client latencies
From: Trond Myklebust <trond.myklebust@fys.uio.no>
To: Ingo Molnar <mingo@elte.hu>
Cc: Andrew Morton <akpm@osdl.org>, rlrevell@joe-job.com,
       linux-kernel@vger.kernel.org
In-Reply-To: <20050331135825.GA2214@elte.hu>
References: <1112217299.10771.3.camel@lade.trondhjem.org>
	 <1112236017.26732.4.camel@mindpipe> <20050330183957.2468dc21.akpm@osdl.org>
	 <1112237239.26732.8.camel@mindpipe>
	 <1112240918.10975.4.camel@lade.trondhjem.org>
	 <20050331065942.GA14952@elte.hu> <20050330231801.129b0715.akpm@osdl.org>
	 <20050331073017.GA16577@elte.hu>
	 <1112270304.10975.41.camel@lade.trondhjem.org>
	 <1112272451.10975.72.camel@lade.trondhjem.org>
	 <20050331135825.GA2214@elte.hu>
Content-Type: text/plain
Date: Thu, 31 Mar 2005 09:32:02 -0500
Message-Id: <1112279522.20211.8.camel@lade.trondhjem.org>
Mime-Version: 1.0
X-Mailer: Evolution 2.0.4 
Content-Transfer-Encoding: 7bit
X-UiO-Spam-info: not spam, SpamAssassin (score=-3.489, required 12,
	autolearn=disabled, AWL 1.46, FORGED_RCVD_HELO 0.05,
	UIO_MAIL_IS_INTERNAL -5.00)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

to den 31.03.2005 Klokka 15:58 (+0200) skreiv Ingo Molnar:
> * Trond Myklebust <trond.myklebust@fys.uio.no> wrote:
> 
> > > +	int res;
> > 	  ^^^^^^^ Should be "int res = 0;"
> 
> your patch works fine here - but there are still latencies in 
> nfs_scan_commit()/nfs_scan_list(): see the attached 3.7 msec latency 
> trace. It happened during a simple big-file writeout and is easily 
> reproducible. Could the nfsi->commit list searching be replaced with a 
> radix based approach too?

That would be 100% pure overhead. The nfsi->commit list does not need to
be sorted and with these patches applied, it no longer is. In fact one
of the cleanups I still need to do is to get rid of those redundant
checks on wb->index (start is now always set to 0, and end is always
~0UL).

So the overhead you are currently seeing should just be that of
iterating through the list, locking said requests and adding them to our
private list.

Cheers,
  Trond

-- 
Trond Myklebust <trond.myklebust@fys.uio.no>

