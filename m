Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932246AbWFRQU4@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932246AbWFRQU4 (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 18 Jun 2006 12:20:56 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932244AbWFRQUz
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 18 Jun 2006 12:20:55 -0400
Received: from zeniv.linux.org.uk ([195.92.253.2]:63424 "EHLO
	ZenIV.linux.org.uk") by vger.kernel.org with ESMTP id S932217AbWFRQUz
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 18 Jun 2006 12:20:55 -0400
Date: Sun, 18 Jun 2006 17:20:54 +0100
From: Al Viro <viro@ftp.linux.org.uk>
To: Andrew Morton <akpm@osdl.org>, linux-kernel@vger.kernel.org,
       linux-fsdevel@vger.kernel.org
Subject: Re: [PATCH 1/5]: ufs: missed brelse and wrong baseblk
Message-ID: <20060618162054.GW27946@ftp.linux.org.uk>
References: <20060617101403.GA22098@rain.homenetwork>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20060617101403.GA22098@rain.homenetwork>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Comment more on the entire series than on this patch: scenario that causes
trouble
	* foo is a sparse file on ufs with 8Kb block/1Kb fragment
	* process opens it writable and mmaps it shared
	* it proceeds to dirty the pages
	* fork
	* parent and child do msync() on pages next to each other

I.e. we try to write adjacent pages that sit in the same block.  At the
same time.  Each will trigger an allocation and we'd better be very
careful, or we'll end up allocating the same block twice.
