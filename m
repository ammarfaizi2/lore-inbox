Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932473AbWESUGY@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932473AbWESUGY (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 19 May 2006 16:06:24 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932476AbWESUGY
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 19 May 2006 16:06:24 -0400
Received: from e4.ny.us.ibm.com ([32.97.182.144]:485 "EHLO e4.ny.us.ibm.com")
	by vger.kernel.org with ESMTP id S932473AbWESUGY (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 19 May 2006 16:06:24 -0400
Subject: Re: [PATCH 0/9] namespaces: Introduction
From: Dave Hansen <haveblue@us.ibm.com>
To: Andrew Morton <akpm@osdl.org>
Cc: Herbert Poetzl <herbert@13thfloor.at>, serue@us.ibm.com,
       linux-kernel@vger.kernel.org, dev@sw.ru, devel@openvz.org,
       sam@vilain.net, ebiederm@xmission.com, xemul@sw.ru, clg@fr.ibm.com
In-Reply-To: <20060519081334.06ce452d.akpm@osdl.org>
References: <20060518154700.GA28344@sergelap.austin.ibm.com>
	 <20060518103430.080e3523.akpm@osdl.org>
	 <20060519124235.GA32304@MAIL.13thfloor.at>
	 <20060519081334.06ce452d.akpm@osdl.org>
Content-Type: text/plain
Date: Fri, 19 May 2006 13:04:49 -0700
Message-Id: <1148069089.6623.197.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Evolution 2.4.1 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 2006-05-19 at 08:13 -0700, Andrew Morton wrote:
> snapshot/restart/migration worry me.  If they require complete
> serialisation of complex kernel data structures then we have a problem,
> because it means that any time anyone changes such a structure they need to
> update (and test) the serialisation.

The idea of actually serializing kernel data structures keeps me up at
night.  This is especially true when we already have some method of
exporting these structures to userspace.

Take VMAs, for example.  Should we have a set of interfaces for saving
and restoring VMAs, or should we just make any program which is doing
checkpoint/restart use /proc/<pid>/maps on checkpoint and mmap() on
restore?

It, of course, isn't that simple.  Any interface focused on VMAs inside
the kernel will have the serialization issues you describe.  I think
this is such an approach:

http://git.openvz.org/?p=linux-2.6-openvz;a=blob;f=kernel/cpt/cpt_mm.c
http://git.openvz.org/?p=linux-2.6-openvz;a=blob;f=kernel/cpt/rst_mm.c

However, the proc-maps/mmap approach would require new interfaces to be
implemented.  There are plenty of attributes not currently readily
visible to userspace like VM_NONLINEAR, or resources which are normally
inaccessible to userspace like deleted files.  Those would need extended
user/kernel interfaces.

I know of at least one in-kernel commercial checkpoint/restart product
which was relatively well tested with "a certain large DB that uses
remap_file_pages()" that never even noticed that it completely missed
VM_NONLINEAR support until vm-savvy people saw the code.  Scary.

-- Dave

