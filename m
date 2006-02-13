Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030282AbWBMXcf@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030282AbWBMXcf (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 13 Feb 2006 18:32:35 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030293AbWBMXcf
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 13 Feb 2006 18:32:35 -0500
Received: from mx2.netapp.com ([216.240.18.37]:41611 "EHLO mx2.netapp.com")
	by vger.kernel.org with ESMTP id S1030283AbWBMXce (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 13 Feb 2006 18:32:34 -0500
X-IronPort-AV: i="4.02,109,1139212800"; 
   d="scan'208"; a="358434366:sNHT18439440"
Subject: Re: [PATCH] NLM: Fix the NLM_GRANTED callback checks
From: Trond Myklebust <Trond.Myklebust@netapp.com>
To: Andrew Morton <akpm@osdl.org>
Cc: torvalds@osdl.org, linux-kernel@vger.kernel.org
In-Reply-To: <20060213152021.6e25e40b.akpm@osdl.org>
References: <1139801149.7916.11.camel@lade.trondhjem.org>
	 <20060213152021.6e25e40b.akpm@osdl.org>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Organization: Network Appliance, Inc
Date: Mon, 13 Feb 2006 18:32:30 -0500
Message-Id: <1139873550.7870.51.camel@lade.trondhjem.org>
Mime-Version: 1.0
X-Mailer: Evolution 2.4.1 
X-OriginalArrivalTime: 13 Feb 2006 23:32:31.0137 (UTC) FILETIME=[C249B910:01C630F5]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 2006-02-13 at 15:20 -0800, Andrew Morton wrote:
> Trond Myklebust <Trond.Myklebust@netapp.com> wrote:
> >
> > Currently when the NLM_GRANTED callback comes in, lockd walks the list of
> > blocked locks in search of a match to the lock that the NLM server has
> > granted. Although it checks the lock pid, start and end, it fails to check
> > the filehandle and the server address.
> > 
> 
> What are the consequences of this bug?

If 2 threads attached to the same process are blocking on different
locks on different files (maybe even on different servers) but have the
same lock arguments (i.e. same offset+length - actually quite common,
since most processes try to lock the entire file) then the first GRANTED
call that wakes one up will also wake the other.

By checking the filehandle and server IP address, we ensure that this
only happens if the locks truly are referencing the same file.

Cheers,
  Trond
