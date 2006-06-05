Return-Path: <linux-kernel-owner+akpm=40zip.com.au-S1751109AbWFENi5@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751109AbWFENi5 (ORCPT <rfc822;akpm@zip.com.au>);
	Mon, 5 Jun 2006 09:38:57 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751108AbWFENi5
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 5 Jun 2006 09:38:57 -0400
Received: from canuck.infradead.org ([205.233.218.70]:12270 "EHLO
	canuck.infradead.org") by vger.kernel.org with ESMTP
	id S1751109AbWFENi4 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 5 Jun 2006 09:38:56 -0400
Subject: Re: 2.6.18 -mm merge plans -- GFS
From: David Woodhouse <dwmw2@infradead.org>
To: Andrew Morton <akpm@osdl.org>
Cc: linux-kernel@vger.kernel.org, Patrick Caulfield <pcaulfie@redhat.com>,
        Steven Whitehouse <swhiteho@redhat.com>, davej@redhat.com,
        David Teigland <teigland@redhat.com>
In-Reply-To: <20060604135011.decdc7c9.akpm@osdl.org>
References: <20060604135011.decdc7c9.akpm@osdl.org>
Content-Type: text/plain
Date: Mon, 05 Jun 2006 14:38:50 +0100
Message-Id: <1149514730.30024.133.camel@pmac.infradead.org>
Mime-Version: 1.0
X-Mailer: Evolution 2.6.2 (2.6.2-1.fc5.1.dwmw2.2) 
Content-Transfer-Encoding: 7bit
X-SRS-Rewrite: SMTP reverse-path rewritten from <dwmw2@infradead.org> by canuck.infradead.org
	See http://www.infradead.org/rpr.html
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 2006-06-04 at 13:50 -0700, Andrew Morton wrote:
> It's time to take a look at the -mm queue for 2.6.18.

You didn't mention GFS2 either -- is that ready to go upstream?
It contains this in its user<->kernel communication (whitespace sic)...

/* struct passed to the lock write */
struct dlm_lock_params {
       __u8 mode;
       __u16 flags;
       __u32 lkid;
       __u32 parent;
       __u8 namelen;
        void __user *castparam;
       void __user *castaddr;
       void __user *bastparam;
        void __user *bastaddr;
       struct dlm_lksb __user *lksb;
       char lvb[DLM_USER_LVB_LEN];
       char name[1];
};

struct dlm_lspace_params {
       __u32 flags;
       __u32 minor;
       char name[1];
};

struct dlm_write_request {
       __u32 version[3];
       __u8 cmd;

       union  {
               struct dlm_lock_params   lock;
               struct dlm_lspace_params lspace;
       } i;
};

/* struct read from the "device" fd,
   consists mainly of userspace pointers for the library to use */
struct dlm_lock_result {
       __u32 length;
       void __user * user_astaddr;
       void __user * user_astparam;
       struct dlm_lksb __user * user_lksb;
       struct dlm_lksb lksb;
       __u8 bast_mode;
       /* Offsets may be zero if no data is present */
       __u32 lvb_offset;
};

Now, the intention seems to be that instead of doing CONFIG_COMPAT stuff
in the kernel for backwards-compatibility with 32-bit userspace on
64-bit kernels, we _instead_ attempt to make the 32-bit userspace
_forward_ compatible with 64-bit kernels.

The userspace side of this is implemented (for sparc and s390 only) at
http://sources.redhat.com/cgi-bin/cvsweb.cgi/~checkout~/cluster/dlm/lib/dlm32.c?rev=1.3&content-type=text/plain&cvsroot=cluster

That approach looks broken when i386 binaries are run on x86_64, because
the offset of the 'qinfo' member in a struct which starts like this...

struct dlm_query_params64 {
	uint32_t query;
	uint64_t qinfo;
	...

... is going to be _different_ between the 32-bit userspace code and the
64-bit kernel anyway, despite the fact that this structure is supposed
to match the 64-bit kernel's idea of the structure.

The hdrcleanup and hdrinstall stuff helped to highlight this, because it
now stands out as being immediately obvious that we're adding pointers
to user-visible structures. I'm being asked to add the GFS2 headers to
Fedora's glibc-kernheaders package, but I _don't_ want to diverge from
upstream -- part of the reason for 'make headers_install' was that all
the distros will be able to ship a _consistent_ set of headers. So if
we're going to barf at the compat stuff above, can we do it ASAP and get
it fixed, or if we're going to accept the "userspace must be
forward-compatible" approach and send it to Linus as is, can we reach a
consensus on that instead?

-- 
dwmw2

