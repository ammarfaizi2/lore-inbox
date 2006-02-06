Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964781AbWBFU17@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964781AbWBFU17 (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 6 Feb 2006 15:27:59 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964780AbWBFU17
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 6 Feb 2006 15:27:59 -0500
Received: from omx2-ext.sgi.com ([192.48.171.19]:14470 "EHLO omx2.sgi.com")
	by vger.kernel.org with ESMTP id S964781AbWBFU16 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 6 Feb 2006 15:27:58 -0500
Date: Mon, 6 Feb 2006 12:27:29 -0800 (PST)
From: Christoph Lameter <clameter@engr.sgi.com>
To: Ingo Molnar <mingo@elte.hu>
cc: Paul Jackson <pj@sgi.com>, ak@suse.de, akpm@osdl.org, dgc@sgi.com,
       steiner@sgi.com, Simon.Derr@bull.net, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/5] cpuset memory spread basic implementation
In-Reply-To: <20060206200506.GA13466@elte.hu>
Message-ID: <Pine.LNX.4.62.0602061221200.18348@schroedinger.engr.sgi.com>
References: <20060204071910.10021.8437.sendpatchset@jackhammer.engr.sgi.com>
 <200602061811.49113.ak@suse.de> <Pine.LNX.4.62.0602061017510.16829@schroedinger.engr.sgi.com>
 <200602061936.27322.ak@suse.de> <20060206184330.GA22275@elte.hu>
 <20060206120109.0738d6a2.pj@sgi.com> <20060206200506.GA13466@elte.hu>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 6 Feb 2006, Ingo Molnar wrote:

> yes. And it seems that for the workloads you cited, the most natural 
> direction to drive the 'spreading' of resources is from the VFS side.  
> That would also avoid the problem Andrew observed: the ugliness of a 
> sysadmin configuring the placement strategy of kernel-internal slab 
> caches. It also feels a much more robust choice from the conceptual POV.

A sysadmin currently simply configures the memory policy or cpuset policy. 
He has no knowledge of the underlying slab.

Moving this to the VFS will give rise to all sorts of weird effects. F.e. 
doing a grep on a file will spread the pages all over the system. 
Performance will drop for simple single thread processes.

What happens if a filesystem is exported? Is the spreading also exported?

Seems that the allocation policy is application dependend and not related 
to file access. Also some of the slabs have no underlying files that 
could determine their allocation strategy (network subsystem etc). 

AFAIK the cleanest solution is that an application controls its memory
allocation policy (which has been available for a long time via memory 
policies which even in early 2.6.x controlled the slab page allocation 
policy).

Cpusets are simply a convenience so that a larger groups of applications 
can implement the same policy and may allow one to avoid running numactl 
or modifying an existent application.
