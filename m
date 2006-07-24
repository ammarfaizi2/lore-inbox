Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751029AbWGXJBy@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751029AbWGXJBy (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 24 Jul 2006 05:01:54 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751059AbWGXJBy
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 24 Jul 2006 05:01:54 -0400
Received: from nz-out-0102.google.com ([64.233.162.199]:50488 "EHLO
	nz-out-0102.google.com") by vger.kernel.org with ESMTP
	id S1751029AbWGXJBy (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 24 Jul 2006 05:01:54 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=g1tFDlPeDMHwsamZa+Zbf6DVxPAiHvA+ASFNtGEoFZThzc5zKI+Hnx0WW5OqARwiJ6QGey0p8j0Jy3EjdfmS3HZmFLG6Mc3+yJM7reXIvnnPp5D+ZjgySlLsCWWBRFBt6ZKVtQsuDXYHZf/7TtelXmllAQlvfeqmpQWj9E1qInY=
Message-ID: <4df04b840607240201l19f95f8cu12dca42de71dba69@mail.gmail.com>
Date: Mon, 24 Jul 2006 17:01:53 +0800
From: "yunfeng zhang" <zyf.zeroos@gmail.com>
To: linux-kernel@vger.kernel.org
Subject: Re: Improvement on memory subsystem
In-Reply-To: <4df04b840607180303i3d8c8bd0o4d2a24752ec2e150@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
References: <4df04b840607180303i3d8c8bd0o4d2a24752ec2e150@mail.gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

How to let memory subsystem allocate bigger consecutive memory pages? In current
Linux, to driver programmer it's always failed to issue a request to alloc_pages
with a enough larger order parameter, or it's diffult to allocate a bigger
consecutive physical memory block.

The reason causing the problem, I think, are the items listed below
1) Core space has a static mapping relationship with physical memory pages. So
once a core page is allocated, its core address is also fixed, it prevents the
physical pages around it to conglomerate together.
2) Current physical page management arithmetic is buddy arithmetic. The main
advantage of its is that pages managed by it is always aligned by 2 power. But,
is it necessary or there is any hardware which need physical memory pages
aligned by 2 or more power?

The solution is
1) Using dynamic page mapping on core space. So we can move all core pages
freely anytime to conglomerate bigger consecutive memory pages, a new background
daemon thread -- RemapDaemon can do conglomeration periodly.
2) Using another page management arithmetic instead of buddy, the minimum unit
of new arithmetic should be page. In fact, I think dlmalloc arithmetic is a good
candidate, it's also page conglomeration-affinity.
