Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751184AbVIBJiS@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751184AbVIBJiS (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 2 Sep 2005 05:38:18 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751130AbVIBJiS
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 2 Sep 2005 05:38:18 -0400
Received: from mx1.redhat.com ([66.187.233.31]:60896 "EHLO mx1.redhat.com")
	by vger.kernel.org with ESMTP id S1751118AbVIBJiR (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 2 Sep 2005 05:38:17 -0400
Date: Fri, 2 Sep 2005 17:44:03 +0800
From: David Teigland <teigland@redhat.com>
To: Arjan van de Ven <arjan@infradead.org>
Cc: linux-fsdevel@vger.kernel.org, akpm@osdl.org, linux-kernel@vger.kernel.org,
       linux-cluster@redhat.com
Subject: Re: GFS, what's remaining
Message-ID: <20050902094403.GD16595@redhat.com>
References: <20050901104620.GA22482@redhat.com> <1125574523.5025.10.camel@laptopd505.fenrus.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1125574523.5025.10.camel@laptopd505.fenrus.org>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Sep 01, 2005 at 01:35:23PM +0200, Arjan van de Ven wrote:

> +	gfs2_assert(gl->gl_sbd, atomic_read(&gl->gl_count) > 0,);

> what is gfs2_assert() about anyway? please just use BUG_ON directly
> everywhere

When a machine has many gfs file systems mounted at once it can be useful
to know which one failed.  Does the following look ok?

#define gfs2_assert(sdp, assertion)                                       \
do {                                                                      \
        if (unlikely(!(assertion))) {                                     \
                printk(KERN_ERR                                           \
                        "GFS2: fsid=%s: fatal: assertion \"%s\" failed\n" \
                        "GFS2: fsid=%s:   function = %s\n"                \
                        "GFS2: fsid=%s:   file = %s, line = %u\n"         \
                        "GFS2: fsid=%s:   time = %lu\n",                  \
                        sdp->sd_fsname, # assertion,                      \
                        sdp->sd_fsname,  __FUNCTION__,                    \
                        sdp->sd_fsname, __FILE__, __LINE__,               \
                        sdp->sd_fsname, get_seconds());                   \
                BUG();                                                    \
        }                                                                 \
} while (0)

