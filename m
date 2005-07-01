Return-Path: <linux-kernel-owner+willy=40w.ods.org-S263356AbVGAOPn@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263356AbVGAOPn (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 1 Jul 2005 10:15:43 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263353AbVGAOPn
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 1 Jul 2005 10:15:43 -0400
Received: from wproxy.gmail.com ([64.233.184.206]:49479 "EHLO wproxy.gmail.com")
	by vger.kernel.org with ESMTP id S263356AbVGAOPg convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 1 Jul 2005 10:15:36 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:reply-to:to:subject:mime-version:content-type:content-transfer-encoding:content-disposition;
        b=uFJj3/Qz94n7blagW+MVO7GXzPjyv7GiKOhqYTRlaPgyLe3zxEZ8udO3y38TmDI6b0jVj4dV0rHVUSeMJi7zBIGk2ZzChl+EwTr15GTQ5QFiVVUubH0RIKNP/HukQLBfYAX0BuVhckwX3Oi7BPMOaX0UrhriZpiDP4tPbhwzUNI=
Message-ID: <347d9dae0507010715320f4344@mail.gmail.com>
Date: Fri, 1 Jul 2005 10:15:34 -0400
From: Floyd Miller <floydmiller@gmail.com>
Reply-To: Floyd Miller <floydmiller@gmail.com>
To: linux-kernel@vger.kernel.org
Subject: Re: [PATCH] bigphysarea for 2.6.10 en 2.6.11
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 8BIT
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On  Mon Jun 13 2005 Pádraig Brady wrote:
> That should be: mem_resource.start = virt_to_phys(bigphysarea);
> Otherwise you could get a collision?

Yes, the collision has occured for me with 2.4 kernel on
Dell 2850 system.  Requesting the resource using the
virtual address collided with the physical address of the
PCI expansion slots.

An overlap could also occur because the end address
passed to request_resource() is one too big.
The code should be:

       // register the resource for it
       mem_resource.start = virt_to_phys(bigphysarea);
       mem_resource.end = mem_resource.start
                        + (bigphysarea_pages << PAGE_SHIFT) - 1;
       request_resource(&iomem_resource, &mem_resource);

Note that this may not work for systems such as SGI altix 350
using IA64 processors that do not support the virt_to_phys
operation.  I don;t know what should be done on such a system.

Perhaps it is not necessary to mark the resource busy with
request_resource() since the memory is allocated from the
Kernel at boot time and should not be available for any other
use anyway.
Any thoughts on this?
