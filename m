Return-Path: <linux-kernel-owner+willy=40w.ods.org-S965034AbWEBXTP@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965034AbWEBXTP (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 2 May 2006 19:19:15 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965036AbWEBXTP
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 2 May 2006 19:19:15 -0400
Received: from smtpout.mac.com ([17.250.248.176]:3833 "EHLO smtpout.mac.com")
	by vger.kernel.org with ESMTP id S965034AbWEBXTP (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 2 May 2006 19:19:15 -0400
In-Reply-To: <20060502214908.GB18192@vrfy.org>
References: <20060428112225.418cadd9.holzheu@de.ibm.com> <20060429075311.GB1886@kroah.com> <8A7D2F4D-5A05-4C93-B514-03268CAA9201@mac.com> <20060429215501.GA9870@kroah.com> <4237705F-E1B2-46CF-BE66-EFB77F68EC42@mac.com> <20060501203815.GE19423@kroah.com> <2DBA690E-B11A-478E-B2E0-0529F4CE45A9@mac.com> <20060502040053.GA14413@kroah.com> <13D6E299-061B-46A5-A3CD-12E1075B9451@mac.com> <20060502213043.GB30957@kroah.com> <20060502214908.GB18192@vrfy.org>
Mime-Version: 1.0 (Apple Message framework v746.3)
Content-Type: text/plain; charset=US-ASCII; delsp=yes; format=flowed
Message-Id: <A7576A6B-AC44-4CAF-ACDE-F49F4023A2A7@mac.com>
Cc: Greg KH <greg@kroah.com>, Michael Holzheu <holzheu@de.ibm.com>,
       akpm@osdl.org, schwidefsky@de.ibm.com, penberg@cs.helsinki.fi,
       ioe-lkml@rameria.de, joern@wohnheim.fh-wedel.de,
       linux-kernel@vger.kernel.org
Content-Transfer-Encoding: 7bit
From: Kyle Moffett <mrmacman_g4@mac.com>
Subject: Re: [PATCH] s390: Hypervisor File System
Date: Tue, 2 May 2006 19:18:52 -0400
To: Kay Sievers <kay.sievers@vrfy.org>
X-Mailer: Apple Mail (2.746.3)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On May 2, 2006, at 17:49:08, Kay Sievers wrote:
> If you can assume that processes accessing the values are  
> cooperative, it already works without any changes:
>
>   $ time flock /sys/class/firmware echo 1 > /sys/class/firmware/ 
> timeout
>   real    0m0.005s
>
>   $ flock /sys/class/firmware sleep 5&
>   [1] 6468
>
>   $ time flock /sys/class/firmware echo 1 > /sys/class/firmware/ 
> timeout
>   real    0m3.558s

But that doesn't solve the problem for framebuffer devices or for the  
s390 code.  Such transactions have one or more of the following  
properties:

(1)  A read operation is _expensive_ or adds unacceptable latencies  
and should be done as rarely as possible
(2)  The data must be all written to hardware simultaneously by the  
kernel; a partial update does not make sense and would cause  
undesired operation from the hardware.

The idea with the transactions would be to create a kernel-memory  
buffer-layer of sorts on top of the underlying sysfs tree to cache  
the read data and collect writes for an atomic commit.  I'll see if I  
can make something work.

Cheers,
Kyle Moffett
