Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261919AbVEQBhM@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261919AbVEQBhM (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 16 May 2005 21:37:12 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261733AbVEQBhM
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 16 May 2005 21:37:12 -0400
Received: from mail.shareable.org ([81.29.64.88]:35287 "EHLO
	mail.shareable.org") by vger.kernel.org with ESMTP id S261724AbVEQBhD
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 16 May 2005 21:37:03 -0400
Date: Tue, 17 May 2005 02:36:55 +0100
From: Jamie Lokier <jamie@shareable.org>
To: Miklos Szeredi <miklos@szeredi.hu>
Cc: akpm@osdl.org, viro@parcelfarce.linux.theplanet.co.uk,
       linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org
Subject: Re: [PATCH] namespace.c: fix mnt_namespace clearing
Message-ID: <20050517013655.GD32226@mail.shareable.org>
References: <E1DXlgJ-0005iU-00@dorka.pomaz.szeredi.hu>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <E1DXlgJ-0005iU-00@dorka.pomaz.szeredi.hu>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Miklos Szeredi wrote:
> This patch clears mnt_namespace on unmount.
> 
> Not clearing mnt_namespace has two effects:
> 
>    1) It is possible to attach a new mount to a detached mount,
>       because check_mnt() returns true.
> 
>       This means, that when no other references to the detached mount
>       remain, it still can't be freed.  This causes a resource leak,
>       and possibly un-removable modules.
> 
>    2) If mnt_namespace is dereferenced (only in mark_mounts_for_expiry())
>       after the namspace has been freed, it can cause an Oops, memory
>       corruption, etc.
> 
> 1) has been tested before and after the patch, 2) is only speculation.

You're right - I was just thinking the same thing.  There is also
another side effect, which is ironic in the context of recent discussion:

     3) Because mnt_namespace may refer to freed memory, it may refer
        to memory that's then allocated for _another_ namespace.  So the
        check for mounting in the correct namespace which prevents
	recursive bind mounts could erronously _allow_ the recursive
	bind to succeed (though without taking the correct lock).

-- Jamie
