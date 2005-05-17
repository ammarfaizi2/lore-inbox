Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262004AbVEQAAn@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262004AbVEQAAn (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 16 May 2005 20:00:43 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261448AbVEQAAj
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 16 May 2005 20:00:39 -0400
Received: from mail.shareable.org ([81.29.64.88]:29399 "EHLO
	mail.shareable.org") by vger.kernel.org with ESMTP id S261316AbVEQAAc
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 16 May 2005 20:00:32 -0400
Date: Tue, 17 May 2005 01:00:16 +0100
From: Jamie Lokier <jamie@shareable.org>
To: Ram <linuxram@us.ibm.com>
Cc: Miklos Szeredi <miklos@szeredi.hu>, viro@parcelfarce.linux.theplanet.co.uk,
       Andrew Morton <akpm@osdl.org>, linux-kernel@vger.kernel.org,
       linux-fsdevel@vger.kernel.org
Subject: Re: [PATCH] namespace.c: fix bind mount from foreign namespace
Message-ID: <20050517000016.GA32226@mail.shareable.org>
References: <E1DWdn9-0004O2-00@dorka.pomaz.szeredi.hu> <1116005355.6248.372.camel@localhost> <E1DWf54-0004Z8-00@dorka.pomaz.szeredi.hu> <1116012287.6248.410.camel@localhost> <E1DWfqJ-0004eP-00@dorka.pomaz.szeredi.hu> <1116013840.6248.429.camel@localhost> <E1DWprs-0005D1-00@dorka.pomaz.szeredi.hu> <1116256279.4154.41.camel@localhost> <20050516111408.GA21145@mail.shareable.org> <1116301843.4154.88.camel@localhost>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1116301843.4154.88.camel@localhost>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Ram wrote:
> Under the premise that bind mounts across namespace should be allowed;
> any insight why the "founding fathers" :) allowed only bind
> and not recursive bind?  What issue would that create?

Recursive bind traverses the subtree of vfsmnts rooted at the source
mount (following mnt->mnt_mounts, see copy_tree()).  That requires the
source mount's namespace semaphore to be held.

> One can easily workaround that restriction by manually binding
> recursively.

Yes, if you know which mounts they are.

> I remember Miklos saying its not a security issue but a
> implementation/locking issue. That can be fixed aswell.

Yes, by taking the source namespace semaphore while traversing the
subtree.  That involves taking _two_ semaphores, so they have to be
ordered to avoid deadlock (see double-locking elsewhere in the kernel).

- Jamie
