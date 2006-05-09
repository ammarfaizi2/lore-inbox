Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751282AbWEIQHz@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751282AbWEIQHz (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 9 May 2006 12:07:55 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751283AbWEIQHz
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 9 May 2006 12:07:55 -0400
Received: from smtp.osdl.org ([65.172.181.4]:38886 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S1751282AbWEIQHy (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 9 May 2006 12:07:54 -0400
Date: Tue, 9 May 2006 09:02:02 -0700
From: Andrew Morton <akpm@osdl.org>
To: Arjan van de Ven <arjan@linux.intel.com>
Cc: bunk@stusta.de, linux-kernel@vger.kernel.org
Subject: Re: [patch 1/17] Infrastructure to mark exported symbols as
 unused-for-removal-soon
Message-Id: <20060509090202.2f209f32.akpm@osdl.org>
In-Reply-To: <1146581587.32045.41.camel@laptopd505.fenrus.org>
References: <1146581587.32045.41.camel@laptopd505.fenrus.org>
X-Mailer: Sylpheed version 1.0.4 (GTK+ 1.2.10; i386-redhat-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Arjan van de Ven <arjan@linux.intel.com> wrote:
>
>  As discussed on lkml before; the patch with the infrastructure to deprecate unused symbols
> 
>  This is patch one in a series of 17; to not overload lkml the other 16 will be mailed direct;
>  people who want to see them all can see them at http://www.fenrus.org/unused

A lot of these patches go through major APIs and seemingly-randomly prepare
to unexport things based on whether they are presently used within modules.

So, for example, drivers/base/attribute_container.c gets a whole pile of
exports scheduled for removal, regardless of whether the resulting module
API makes *sense*.  Ditto scsi core.  And lib/*.

For example this:

  EXPORT_SYMBOL(generic_getxattr);
 -EXPORT_SYMBOL(generic_listxattr);
 +EXPORT_UNUSED_SYMBOL(generic_listxattr); /* removal in 2.6.19 */
  EXPORT_SYMBOL(generic_setxattr);
  EXPORT_SYMBOL(generic_removexattr);

just seems random to me, and it's setting us up for later churn.

So hum.  Don't you think it'd be better to look at each API as a whole,
make decisions about what parts of it _should_ be offered to modules,
rather then looking empirically at which parts presently _need_ to be
exported?

