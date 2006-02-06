Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932209AbWBFQsv@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932209AbWBFQsv (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 6 Feb 2006 11:48:51 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932211AbWBFQsv
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 6 Feb 2006 11:48:51 -0500
Received: from omx1-ext.sgi.com ([192.48.179.11]:64980 "EHLO
	omx1.americas.sgi.com") by vger.kernel.org with ESMTP
	id S932209AbWBFQsu (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 6 Feb 2006 11:48:50 -0500
Date: Mon, 6 Feb 2006 08:48:25 -0800 (PST)
From: Christoph Lameter <clameter@engr.sgi.com>
To: Paul Jackson <pj@sgi.com>
cc: Andi Kleen <ak@suse.de>, mingo@elte.hu, akpm@osdl.org, dgc@sgi.com,
       steiner@sgi.com, Simon.Derr@bull.net, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/5] cpuset memory spread basic implementation
In-Reply-To: <20060206063549.d155c619.pj@sgi.com>
Message-ID: <Pine.LNX.4.62.0602060839440.16337@schroedinger.engr.sgi.com>
References: <20060204071910.10021.8437.sendpatchset@jackhammer.engr.sgi.com>
 <200602061109.45788.ak@suse.de> <20060206101156.GA1761@elte.hu>
 <200602061116.44040.ak@suse.de> <20060206063549.d155c619.pj@sgi.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Just some words of clarification here:

Memory spreading is useful if multiple processes are running on 
multiple nodes that access the same set of files (and therefore use the 
same dentries inodes etc). This is only true for very large applications.
Users typically segment a machine using cpusets to give these apps a 
range of nodes and processors to use. The rest of the system may be used
for other needs. The spreading should therefore be restricted to the set 
of nodes in use by that application.

This is very different from the typical case of a single threaded process 
roaming across some data and then terminating. In that case we always want 
placement of memory as near to the process as possible. In cases were we 
are not sure about future application behavior it is best to assume that 
node local is best. Spreading memory allocations for storage that is only 
accessed from one processor will reduce the performance of an application.

So the default operating mode needs to be node local.

There is one exception from this during system bootup. In that case we are 
allocating structures that will be finally be used by processes running on 
all nodes on the system. It is therefore advantageous to spread these 
allocations out. That is currently accomplished by setting the default 
memory allocation policy to MPOL_INTERLEAVE while a kernel boots. Memory 
allocation policies revert to default (node local) when init starts.
