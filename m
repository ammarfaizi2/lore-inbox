Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751088AbWIAWPo@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751088AbWIAWPo (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 1 Sep 2006 18:15:44 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751091AbWIAWPo
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 1 Sep 2006 18:15:44 -0400
Received: from madara.hpl.hp.com ([192.6.19.124]:12243 "EHLO madara.hpl.hp.com")
	by vger.kernel.org with ESMTP id S1751088AbWIAWPn (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 1 Sep 2006 18:15:43 -0400
Date: Fri, 1 Sep 2006 15:15:23 -0700
From: Stephane Eranian <eranian@hpl.hp.com>
To: Andrew Morton <akpm@osdl.org>
Cc: linux-kernel@vger.kernel.org
Subject: Re: [PATCH 6/18] 2.6.17.9 perfmon2 patch for review: sampling format support
Message-ID: <20060901221523.GB29117@frankl.hpl.hp.com>
Reply-To: eranian@hpl.hp.com
References: <200608230805.k7N85v1s000408@frankl.hpl.hp.com> <20060823153537.cb36b9ac.akpm@osdl.org> <20060901160925.GF27854@frankl.hpl.hp.com> <20060901110912.e27099e8.akpm@osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20060901110912.e27099e8.akpm@osdl.org>
User-Agent: Mutt/1.4.1i
Organisation: HP Labs Palo Alto
Address: HP Labs, 1U-17, 1501 Page Mill road, Palo Alto, CA 94304, USA.
E-mail: eranian@hpl.hp.com
X-HPL-MailScanner: Found to be clean
X-HPL-MailScanner-From: eranian@hpl.hp.com
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Andrew,

On Fri, Sep 01, 2006 at 11:09:12AM -0700, Andrew Morton wrote:
> On Fri, 1 Sep 2006 09:09:25 -0700
> Stephane Eranian <eranian@hpl.hp.com> wrote:
> 
> > > Why identify a format with a UUID rather than via a nice human-readable name?
> > > 
> > 
> > Although a UUID is slightly more difficult to manipulate than a clear text string, it
> > offers several advantages:
> > 	- is guaranteed unique
> > 	- generation is fully distributed
> > 	- easy generation with uuidgen
> > 	- fixed size
> > 	- very easy to pass to the kernel, there is not char * in a struct pass to kernel
> > 	- not to worry about '\0'
> 
> The kernel has got along OK using ascii strings for this sort of thing in
> thousands of places for many years.  Is there something special or unique
> about perfmon's requirements which make UUIDs a clearly superior
> implementation?

I don't think there is something special about perfmon. In my mind, uuid looked
more convenient than strings. But if this is too 'unique' for the kernel, I can look
at switching over to an ascii string. Today the uuid is encapsulated into a struct
that is passed to pfm_create_context(). I would like to avoid doing:

	struct pfm_context {
		char *uuid;
		int fd;
		....
	};

We could do:
	struct pfm_context {
		char uuid[UUID_LEN];
		int fd;
		...
	};
Or add the string to the syscall itself:
	pfm_create_context(struct pfm_context *ctx, char *uuid, void *smpl_arg, size_t arg_sz)

When no format is needed uuid=NULL.

Is there a kernel preference on that?

> 
> > We use UUID to idenitfy a format + a version number. The version number can be useful
> > to identify backward compatible versions of a format.
> 
> Interfaces use major and minor version numbering for that.

But here this is not about the perfmon interface, the version applies to the interface of the
sampling format kernel module itself, e.g., we could have a new version with some extensions.
With the string we could use the name to encode the version number. But we could also use
a generic name and have the more detailed version in the remapped smaping buffer header
managed by the format.

-- 
-Stephane

-- 
VGER BF report: H 0
