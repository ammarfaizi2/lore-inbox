Return-Path: <linux-kernel-owner+w=401wt.eu-S1161089AbXALVqJ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161089AbXALVqJ (ORCPT <rfc822;w@1wt.eu>);
	Fri, 12 Jan 2007 16:46:09 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1161093AbXALVqJ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 12 Jan 2007 16:46:09 -0500
Received: from omx1-ext.sgi.com ([192.48.179.11]:58858 "EHLO omx1.sgi.com"
	rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
	id S1161089AbXALVqG (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 12 Jan 2007 16:46:06 -0500
Date: Fri, 12 Jan 2007 13:45:43 -0800 (PST)
From: Christoph Lameter <clameter@sgi.com>
To: Ravikiran G Thirumalai <kiran@scalex86.org>
cc: linux-kernel@vger.kernel.org, linux-mm@kvack.org, Andi Kleen <ak@suse.de>,
       Andrew Morton <akpm@osdl.org>,
       "Shai Fultheim (Shai@scalex86.org)" <shai@scalex86.org>,
       pravin b shelar <pravin.shelar@calsoftinc.com>, a.p.zijlstra@chello.nl
Subject: Re: High lock spin time for zone->lru_lock under extreme conditions
In-Reply-To: <20070112214021.GA4300@localhost.localdomain>
Message-ID: <Pine.LNX.4.64.0701121341320.3087@schroedinger.engr.sgi.com>
References: <20070112160104.GA5766@localhost.localdomain>
 <Pine.LNX.4.64.0701121137430.2306@schroedinger.engr.sgi.com>
 <20070112214021.GA4300@localhost.localdomain>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 12 Jan 2007, Ravikiran G Thirumalai wrote:

> > Does the system scale the right way if you stay within the bounds of node 
> > memory? I.e. allocate 1.5GB from each process?
> 
> Yes. We see problems only when we oversubscribe memory.

Ok in that case we can have more than 2 processors trying to acquire the 
same zone lock. If they have all exhausted their node local memory and are 
all going off node then all processor may be hitting the last node that 
has some  memory left which will cause a very high degree of contention.

Moreover mostatomic operations are to remote memory which is also 
increasing the problem by making the atomic ops take longer. Typically 
mature NUMA system have implemented hardware provisions that can deal with 
such high degrees of contention. If this is simply a SMP system that was
turned into a NUMA box then this is a new hardware scenario for the 
engineers.

